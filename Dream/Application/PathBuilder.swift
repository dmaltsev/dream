//
//  PathBuilder.swift
//  DroneBasePilot
//
//  Created by denis on 02/06/2019.
//

import Foundation
import CoreLocation
import CoreGraphics
import MapKit
import DJISDK
import Mapbox

class Path {
    
    typealias WaypointTurn = (heading: Int, turnMode: DJIWaypointTurnMode)
    
    private let points: [CLLocationCoordinate2D]
    private let boundingBox: BoundingBox
    
    private var lines: [Line]
    private var hatchLines: [Line]
    
    init?(withPoints points:[CLLocationCoordinate2D], hatchesDistance distance: Double, direction: Int) {
        self.points = points
        
        guard let first = points.first else {
            return nil
        }
        
        let degrees = FlightPathOptimizer.degreesForLengthOptimization(points: points, withAdjustmentDegree: direction)
        
        // Get center of polygon for rotation
        let centerOfPolygon = points.map { $0.point }.centerOfMass
        // Rotate points around center of polygon in the opposite direction of "flight direction"
        let pointsRotated = points.map { $0.point.rotatePoint(aroundOrigin: centerOfPolygon, byDegrees: -degrees).coordinate }
        
        let left = pointsRotated.reduce(first) { $0.longitude < $1.longitude ? $0 : $1 }
        let right = pointsRotated.reduce(first) { $0.longitude > $1.longitude ? $0 : $1 }
        let top = pointsRotated.reduce(first) { $0.latitude > $1.latitude ? $0 : $1 }
        let bottom = pointsRotated.reduce(first) { $0.latitude < $1.latitude ? $0 : $1 }
        
        boundingBox = BoundingBox(leftTop: CLLocationCoordinate2DMake(top.latitude, left.longitude),
                                  leftBottom: CLLocationCoordinate2DMake(bottom.latitude, left.longitude),
                                  rightTop: CLLocationCoordinate2DMake(top.latitude, right.longitude),
                                  rightBottom: CLLocationCoordinate2DMake(bottom.latitude, right.longitude))
        
        var hatchLines: [Line] = []
        while true {
            var anchorStart: CLLocationCoordinate2D
            var anchorEnd: CLLocationCoordinate2D
            if let hatch = hatchLines.last {
                anchorStart = hatch.a
                anchorEnd = hatch.b
            } else {
                anchorStart = boundingBox.leftBottom
                anchorEnd = boundingBox.rightBottom
            }
            
            let start = anchorStart.transform(using: distance, longitudinalMeters: 0)
            let end = anchorEnd.transform(using: distance, longitudinalMeters: 0)
            
            if start.latitude > boundingBox.leftTop.latitude {
                break
            }
            hatchLines.append(Line(a: start, b: end))
        }
        
        let linesData = points + [ points.first! ]
        self.lines = zip(linesData.dropFirst(), linesData).map { Line(a: $0, b: $1) }
        
        // Once hatch lines have been calculated, rotate the points(now lines) back by flight direction for correct orientation
        self.hatchLines = hatchLines.map {
            let a = $0.a.point.rotatePoint(aroundOrigin: centerOfPolygon, byDegrees: degrees)
            let b = $0.b.point.rotatePoint(aroundOrigin: centerOfPolygon, byDegrees: degrees)
            return Line(a: a.coordinate, b: b.coordinate)
        }
        
        var intersections: [HatchIntesections] = []
        self.hatchLines.forEach { line in
            intersections.append(HatchIntesections(line: line))
            self.lines.forEach { areaLine in
                if let intersection = getIntersectionOfLines(line1: line, line2: areaLine) {
                    intersections.last?.intersections.append(intersection)
                }
            }
        }
        
        self.hatchLines = intersections.compactMap { intersections in
            guard let first = intersections.intersections.first else {
                return nil
            }
            
            let left = intersections.intersections.reduce(first) { $0.longitude < $1.longitude ? $0 : $1 }
            let right = intersections.intersections.reduce(first) { $0.longitude > $1.longitude ? $0 : $1 }
            return Line(a: left, b: right)
        }
    }
    
    func hatches() -> [Hatch] {
        return hatchLines.enumerated().map { offset, line -> Hatch in
            if offset % 2 == 1 {
                return Hatch(start: line.b, end: line.a)
            } else {
                return Hatch(start: line.a, end: line.b)
            }
        }
    }
    
    func path() -> [CLLocationCoordinate2D] {
        let hatches = self.hatches()
        
        if hatches.count == 0 {
            return []
        }
        
        var pathCoordinates: [CLLocationCoordinate2D] = []
        
        
        pathCoordinates.append(hatches[0].start)
        zip(hatches.dropFirst(), hatches).forEach { hatch1, hatch2 in
            pathCoordinates.append(hatch2.end)
            pathCoordinates.append(hatch1.start)
        }
        
        if let last = hatches.last {
            pathCoordinates.append(last.end)
        }
        return pathCoordinates
    }
    
    func distance() -> Double {
        let path = self.path()
        
        var distance: Double = 0
        var locationStart: CLLocation?
        var locationEnd: CLLocation?
        
        path.forEach { coordinate in
            if locationStart == nil {
                locationStart = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            }
            
            locationEnd = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            if locationEnd != nil {
                distance += locationEnd!.distance(from: locationStart!)
            }
            
            locationStart = locationEnd
        }
        return distance
    }
    
    func startWaypointLocation() -> CLLocationCoordinate2D? {
        return self.hatchLines.first?.a
    }
    
    func mission(height: Float, speed: Float, shotTimeInterval: Float, gimbalAngle: Int, orthoFlight: OrthoFlight) -> DJIWaypointMission? {
        let hatches = self.hatches()
        guard hatches.count > 0 else {
            debug("Path: Failed to create mission with 0 hatch lines.")
            return nil
        }
        var waypoints: [DJIWaypoint] = []
        let turnMode = getTurnMode(hatchA: hatches[0], hatchB: hatches.count > 1 ? hatches[1]: hatches[0])
        
        hatches.enumerated().forEach { offset, hatch in
            let newTurnMode = offset % 2 == 0 ? turnMode.even: turnMode.odd
            let waypointTurn = WaypointTurn(heading: hatch.angle(), turnMode: newTurnMode)
            
            waypoints.append(makeWaypoint(withCoordinate: hatch.start, height: height, speed: speed, gimbalAngle: gimbalAngle, firstWaypoint: offset == 0, shotTimeInterval: shotTimeInterval, waypointTurn: waypointTurn))
            waypoints.append(makeWaypoint(withCoordinate: hatch.end, height: height, speed: speed, gimbalAngle: gimbalAngle, waypointTurn: waypointTurn))
        }
        var targetWaypoint = 0
        
        // Use coordinate as waypoint index because target index changes if mission is stoped instead of paused
        // and we need to stop the mission for complete control of the drone
        if let waypointCoordinate = orthoFlight.orthoFlight.lastTargetWaypointCoordinate,
            let waypointIndex = waypoints.firstIndex(where: { $0.coordinate == waypointCoordinate }) {
            targetWaypoint = Int(waypointIndex)
        } else {
            targetWaypoint = Int(orthoFlight.orthoFlight.waypoint)
        }
        
        if targetWaypoint % 2 == 0 {
            // we can start from target waypoint
            waypoints = Array(waypoints.dropFirst(targetWaypoint))
        } else {
            // we should check last taken image
            let lastImage = orthoFlight.orthoFlight.imagesArray.sorted { (li, ri) -> Bool in
                let lTime = li.createdDateTime?.timeIntervalSince1970 ?? 0
                let rTime = ri.createdDateTime?.timeIntervalSince1970 ?? 0
                return lTime < rTime
                }.last
            
            if let lastImage = lastImage {
                let startingLocation = CLLocationCoordinate2DMake(lastImage.latitude, lastImage.longitude)
                let remainingWaypoints = Array(waypoints.dropFirst(targetWaypoint))
                if let firstRemainingWaypoint = remainingWaypoints.first {
                    let firstHatch = Hatch(start: startingLocation, end: remainingWaypoints[0].coordinate)
                    let firstTurn = WaypointTurn(heading: firstHatch.angle(), firstRemainingWaypoint.turnMode == .clockwise ? .counterClockwise: .clockwise)
                    let firstWaypoint = makeWaypoint(withCoordinate: startingLocation, height: height, speed: speed, gimbalAngle: gimbalAngle, firstWaypoint: true, shotTimeInterval: shotTimeInterval, waypointTurn: firstTurn)
                    
                    waypoints =  [firstWaypoint] + remainingWaypoints
                } else {
                    debug("Path: Failed to create / continue mission due to incorrect number of waypoints.")
                    waypoints = Array(waypoints.dropFirst(targetWaypoint - 1))
                }
            } else {
                waypoints = Array(waypoints.dropFirst(targetWaypoint - 1))
            }
        }
        
        let mission = DJIMutableWaypointMission()
        mission.addWaypoints(waypoints)
        mission.rotateGimbalPitch = true
        mission.autoFlightSpeed = speed
        mission.maxFlightSpeed = speed
        mission.headingMode = .usingWaypointHeading
        return DJIWaypointMission(mission: mission)
    }
    
    private func makeWaypoint(withCoordinate coordinate: CLLocationCoordinate2D,
                              height: Float,
                              speed: Float,
                              gimbalAngle: Int,
                              firstWaypoint: Bool = false,
                              shotTimeInterval: Float? = nil,
                              waypointTurn: WaypointTurn? = nil) -> DJIWaypoint {
        let waypoint = DJIWaypoint(coordinate: coordinate)
        waypoint.altitude = height
        waypoint.speed = speed
        waypoint.gimbalPitch = -1 * Float(gimbalAngle)
        
        if shotTimeInterval != nil {
            waypoint.shootPhotoTimeInterval = shotTimeInterval!
        }
        
        if let turn = waypointTurn {
            waypoint.heading = turn.heading
            waypoint.turnMode = turn.turnMode
            
            if firstWaypoint {
                let confirmHeadingAction = DJIWaypointAction(actionType: .rotateAircraft, param: Int16(turn.heading))
                waypoint.add(confirmHeadingAction)
            }
        }
        
        return waypoint
    }
    
    func getTurnMode(hatchA: Hatch, hatchB: Hatch) -> (even: DJIWaypointTurnMode, odd: DJIWaypointTurnMode) {
        let Ax = hatchA.start.point.x
        let Ay = hatchA.start.point.y
        
        let Bx = hatchA.end.point.x
        let By = hatchA.end.point.y
        
        let X = hatchB.start.point.x
        let Y = hatchB.start.point.y
        
        let position = sin((Bx - Ax) * (Y - Ay) - (By - Ay) * (X - Ax))
        let evenTurnMode: DJIWaypointTurnMode = position <= 0 ? .clockwise: .counterClockwise
        let oddTurnMode: DJIWaypointTurnMode = evenTurnMode == .clockwise ? .counterClockwise: .clockwise
        return (evenTurnMode, oddTurnMode)
    }
}

func getIntersectionOfLines(line1: Line, line2: Line) -> CLLocationCoordinate2D? {
    let distance = (line1.b.latitude - line1.a.latitude) * (line2.b.longitude - line2.a.longitude) -
        (line1.b.longitude - line1.a.longitude) * (line2.b.latitude - line2.a.latitude)
    
    if distance == 0 {
        return nil
    }
    
    let u = ((line2.a.latitude - line1.a.latitude) * (line2.b.longitude - line2.a.longitude) - (line2.a.longitude - line1.a.longitude) * (line2.b.latitude - line2.a.latitude)) / distance
    let v = ((line2.a.latitude - line1.a.latitude) * (line1.b.longitude - line1.a.longitude) - (line2.a.longitude - line1.a.longitude) * (line1.b.latitude - line1.a.latitude)) / distance
    
    if (u < 0.0 || u > 1.0) {
        return nil
    }
    if (v < 0.0 || v > 1.0) {
        return nil
    }
    
    return CLLocationCoordinate2DMake(
        line1.a.latitude + u * (line1.b.latitude - line1.a.latitude),
        line1.a.longitude + u * (line1.b.longitude - line1.a.longitude))
}

extension Path {
    
    func polyline() -> AreaPolyline {
        let polylinePoints = points + [points.first!]
        return AreaPolyline(coordinates: polylinePoints, count: UInt(polylinePoints.count))
    }
    
    func polygon() -> BoundsPolyline {
        let polylinePoints = points + [points.first!]
        return BoundsPolyline(coordinates: polylinePoints, count: UInt(polylinePoints.count))
    }
    
    func polylineBounds() -> BoundsPolyline {
        return BoundsPolyline(coordinates: [ boundingBox.leftTop, boundingBox.rightTop, boundingBox.rightBottom, boundingBox.leftBottom, boundingBox.leftTop ], count: 5)
    }
    
    func hatchPolylines() -> [MGLPolyline] {
        return hatches().map { MGLPolyline(coordinates: [$0.start, $0.end], count: 2) }
    }
    
    func pathPoly() -> FlightPathPolyline? {
        let path = self.path()
        guard path.count >= 2 else {
            return nil
        }
        return FlightPathPolyline(coordinates: path, count: UInt(path.count))
    }
}

// MARK: - Map Polyline Helper Annotations

class AreaPolyline: MGLPolyline { }

class BoundsPolyline: MGLPolygon { }

class FlightPathPolyline: MGLPolyline { }

class DroneFlightHistoryPolyline: MGLPolyline { }

// MARK: - Path Structures

struct BoundingBox {
    
    let leftTop: CLLocationCoordinate2D
    let leftBottom: CLLocationCoordinate2D
    let rightTop: CLLocationCoordinate2D
    let rightBottom: CLLocationCoordinate2D
}

struct Hatch {
    
    let start: CLLocationCoordinate2D
    let end: CLLocationCoordinate2D
    
    func reverse() -> Hatch {
        return Hatch(start: end, end: start)
    }
    
    func angle() -> Int {
        let angle = atan2(end.longitude - start.longitude, end.latitude - start.latitude).radiansToDegrees
        return Int(angle > 180 ? angle - 180.0: angle)
    }
}

class HatchIntesections {
    
    let line: Line
    var intersections:[CLLocationCoordinate2D] = []
    
    init(line: Line) {
        self.line = line
    }
    
}

struct Line {
    let a: CLLocationCoordinate2D
    let b: CLLocationCoordinate2D
}
