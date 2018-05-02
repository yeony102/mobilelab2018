//
//  AppDelegate.swift
//  photoGallery
//
//  Created by Yeonhee Lee on 4/11/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

// in the AppDelegate, we have to create the view after the launch.
import UIKit
import Photos

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // create the viewpassedContentOffset
        // when the app launches, we need to determine whether the app has access to the photos library.
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined { // if the access isn't determined
            // then request the authorization
            PHPhotoLibrary.requestAuthorization({ status in
                if status == .authorized { // if the user clicks the 'OK'
                    // then go to the view controller
                    self.gotoVC()
                } else {    // if the user denies the access
                    // then show an alert
                    let alert = UIAlertController(title: "Photos Access Denied", message: "App needs access to photo library.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            })
        } else if photos == .authorized {   // after the second lauch... (it's already been authorized)
            // then directly go to the view controller
            gotoVC()
        }
        
        return true
    }
    
    func gotoVC() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.window = UIWindow(frame: UIScreen.main.bounds) // set the window
            if let window = self.window {
                window.backgroundColor = UIColor.white // set the background colour to white
                
                // embed the navigation controller
                let nav = UINavigationController()
                let mainView = ViewController()     // the main view will be view controller
                nav.viewControllers = [mainView]    // embedding
                window.rootViewController = nav     //embedding
                window.makeKeyAndVisible()          // presenting
            }
            
        })
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

