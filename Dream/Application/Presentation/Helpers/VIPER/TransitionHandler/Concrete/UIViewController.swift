//
//  UIViewController.swift
//  Мечта.ру
//

import UIKit

// MARK: - TransitionHandler

extension UIViewController: TransitionHandler {

    private struct ModuleInputAssociatedKey {
        static var moduleInput: ModuleInput?
    }

    var moduleInput: ModuleInput? {
        get {
            guard let result = objc_getAssociatedObject(self, &ModuleInputAssociatedKey.moduleInput) as? ModuleInput else {
                if let provider = self as? ViewOutputProvider {
                    if let result = provider.viewOutput {
                        return result
                    } else {
                        fatalError("Your UIViewController must return ModuleInput!")
                    }
                } else {
                    fatalError("Your UIViewController must implement protocol 'ViewOutputProvider'!")
                }
            }
            return result
        }
        set (moduleInput) {
            objc_setAssociatedObject(self, &ModuleInputAssociatedKey.moduleInput, moduleInput, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func openModule<M>(_ moduleType: M.Type, controller: UIViewController?) -> TransitionPromise<M.Input> where M : Module {

        let destination = controller ?? M.instantiateTransitionHandler()
        destination.hidesBottomBarWhenPushed = true
        let promise = TransitionPromise(source: self, destination: destination, for: M.Input.self)

        promise.postLinkAction { [weak self] in
            self?.present(destination, animated: true, completion: nil)
        }

        return promise
    }

    func performSegue(_ segueIdentifier: String) {
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }

    func openModuleUsingSegue<T>(_ segueIdentifier: String, to type: T.Type, setup: @escaping (T) -> Void) {
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: segueIdentifier, sender: nil) { segue in
                var destination = segue.destination
                if destination is UINavigationController {
                    destination = (segue.destination as? UINavigationController)?.topViewController ?? segue.destination
                }
                guard let moduleInput = destination.moduleInput as? T else {
                    fatalError("Cannot cast controller \(String(describing: destination.self)) to expected type \(type)")
                }
                setup(moduleInput)
            }
        }
    }

    func closeCurrentModule(animated: Bool) {
        if let parent = parent as? UINavigationController, parent.children.count > 1 {
            parent.popViewController(animated: animated)
        } else if let _ = presentingViewController {
            dismiss(animated: animated, completion: nil)
        } else {
            removeFromParent()
            view?.removeFromSuperview()
        }
    }
    
    @objc func closeCurrentModuleAnimated() {
        self.closeCurrentModule(animated: true)
    }
}

// MARK: - Swizzling

extension UIViewController {

    class Value {

        let value: Any?

        init(_ value: Any?) {
            self.value = value
        }
    }

    @nonobjc static var PrepareForSegueKey = "ru.dream.method.prepareForSegue"

    var performSegueConfig: PerformSegueConfig? {
        get {
            let value = objc_getAssociatedObject(self, &UIViewController.PrepareForSegueKey) as? Value
            return value?.value as? PerformSegueConfig
        }
        set {
            objc_setAssociatedObject(self, &UIViewController.PrepareForSegueKey, Value(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    typealias PerformSegueConfig = (UIStoryboardSegue) -> ()

    func performSegue(withIdentifier identifier: String, sender: Any?, completion: @escaping PerformSegueConfig) {
        swizzlePrepareForSegue()
        performSegueConfig = completion
        performSegue(withIdentifier: identifier, sender: sender)
    }

    func swizzlePrepareForSegue() {
        DispatchQueue.once(token: "ru.dream.swizzle") {
            let originalMethodSelector = #selector(UIViewController.prepare(for:sender:))
            let swizzledMethodSelector = #selector(UIViewController.swizzledPrepare(for:sender:))
            let controllerClass = UIViewController.self
            let originalMethod = class_getInstanceMethod(controllerClass, originalMethodSelector)
            let swizzledMethod = class_getInstanceMethod(controllerClass, swizzledMethodSelector)
            let needed = class_addMethod(controllerClass, originalMethodSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
            if needed {
                class_replaceMethod(controllerClass, swizzledMethodSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
            } else {
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
    }

    @objc func swizzledPrepare(for segue: UIStoryboardSegue, sender: Any?) {
        performSegueConfig?(segue)
        swizzledPrepare(for: segue, sender: sender)
        performSegueConfig = nil
    }
}

extension UIViewController{

    var topDistance: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
