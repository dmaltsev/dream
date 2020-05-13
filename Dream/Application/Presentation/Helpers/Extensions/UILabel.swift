//
//  UILabel.swift
//  Мечта.ру
//

import Foundation

// MARK: - UILabel

extension UILabel {
    
    static func heightForView(text: String, font: UIFont, width: CGFloat, numberOfLines: Int = 0) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }

    func attributedTextHeight(forWidth width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }

    var isTruncated: Bool {

        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil).size

        let delta: CGFloat = 5
        return labelTextSize.height > bounds.size.height + delta
    }
}

class SharedEmployeeWarningTimer : NSObject {

    static let defaultTimerValue = 30

    static let notification = "ExecutorTimerTick"
    static let scheduleNotification = "ExecutorTimerSchedule"
    static let resetNotification = "ExecutorTimerReset"

    static let sharedInstance = SharedEmployeeWarningTimer()

    var labelTimer: Timer?
    var timerValue: Int = SharedEmployeeWarningTimer.defaultTimerValue
    var skipSchedule: Bool = false
    var showConfirm:Bool = false
    fileprivate var timerStopped = false

    fileprivate func invalidateTimer() {
        if self.labelTimer != nil {
            self.labelTimer?.invalidate()
            self.labelTimer = nil
        }
        timerValue = SharedEmployeeWarningTimer.defaultTimerValue
        timerStopped = true
    }

    func resetTimer() {
        invalidateTimer()
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: SharedEmployeeWarningTimer.resetNotification), object: nil)
    }

    func scheduleTimer() {
        if self.labelTimer == nil && !skipSchedule {
            showConfirm = false
            NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: SharedEmployeeWarningTimer.scheduleNotification), object: nil)

            self.labelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)

            RunLoop.current.add(self.labelTimer!, forMode: RunLoop.Mode.common)
            RunLoop.current.add(self.labelTimer!, forMode: RunLoop.Mode.tracking)
        }
        skipSchedule = false
    }

    func stopTimer() {
        invalidateTimer()
    }

    @objc func tickTimer() {
        timerValue -= 1
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: SharedEmployeeWarningTimer.notification), object: nil)

        if timerValue == 0 {
            invalidateTimer()
            showConfirm = true
        }
    }
}
