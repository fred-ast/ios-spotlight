//
//  AppDelegate.swift
//  ios-spotlight
//
//  Created by Frédéric ASTIC on 02/08/2021.
//

import UIKit
import CoreSpotlight

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard let indexedActivity = IndexedActivityResult(userActivity: userActivity) else {
            return false
        }
        let typeOf = indexedActivity.domain // Le type d'objet à gérer
        let identifier = indexedActivity.identifier // l'identifiant unique de l'objet
        
        return true
    }
}

