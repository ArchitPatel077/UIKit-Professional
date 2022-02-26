//
//  AppDelegate.swift
//  Bankey
//
//  Created by Archit Patel on 2022-02-18.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        let vc = MainViewController()
        vc.setStatusBar()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = vc
        return true
    }
}

extension AppDelegate {
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        
        guard animated, let window = self.window else {
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        return
    }
    
    window.rootViewController = vc
    window.makeKeyAndVisible()
    UIView.transition(with: window,
                      duration: 0.3,
                      options: .transitionCrossDissolve,
                      animations: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {

    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
        setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    
    func didFinishedOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

