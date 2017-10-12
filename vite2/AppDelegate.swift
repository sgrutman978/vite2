//
//  AppDelegate.swift
//  vite2
//
//  Created by Steven Grutman on 1/17/17.
//  Copyright © 2017 Steven Grutman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import Fabric
import TwitterKit
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var i = 0


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool{
        
        FIRApp.configure()
        Twitter.sharedInstance().start(withConsumerKey: "bsQ3hZemqFjdZi4PaWvWsMjpB", consumerSecret: "ohyvjn3TQrOowkZCVnlgiL4fAkAVkG41dYlwDvgbEHAoD2sPQS")
        Fabric.with([Twitter.self])
        
//         Override point for customization after application launch.
        if let url = launchOptions?[.url] as? URL, let annotation = launchOptions?[.annotation] {
            self.application(application, open: url, sourceApplication: launchOptions![.sourceApplication] as? String, annotation: annotation)
        }
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
//
        let notificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
        application.registerForRemoteNotifications()
        
//        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as UIViewController
//        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
//        
//        .present(viewController, animated: false, completion: nil)
//        if let locationValue = launchOptions?[UIApplicationLaunchOptionsKey.location] as? Bool, locationValue {
            // the app was launched in response to a location event
            // do your location stuff
//        FIRApp.configure()
         
           
        
//            return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "ViewController") as UIViewController
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = initialViewControlleripad
//        self.window?.makeKeyAndVisible()
//            self.window?.rootViewController?.viewDidLoad()
//         if let url = launchOptions?[.url] as? URL, let annotation = launchOptions?[.annotation] {
//         self.application(application, open: url, sourceApplication: launchOptions![.sourceApplication] as? String, annotation: annotation)
//        }
//        }else{
//        FIRApp.configure()
//        Twitter.sharedInstance().start(withConsumerKey: "bsQ3hZemqFjdZi4PaWvWsMjpB", consumerSecret: "ohyvjn3TQrOowkZCVnlgiL4fAkAVkG41dYlwDvgbEHAoD2sPQS")
//                      Fabric.with([Twitter.self])
//        }
        return true
    }

//    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//       
////        
//////       self.window?.makeKeyAndVisible()
//////        print("this suckkkks")
////        if let url = launchOptions?[.url] as? URL, let annotation = launchOptions?[.annotation] {
//////             print("th2is suckkkks")
//////            let storyboard = UIStoryboard(name: "Main.storyboard", bundle: nil)
//////                    let newHomeView = storyboard.instantiateViewController(withIdentifier: "ViewController") as! UIViewController
//////            self.window!.rootViewController = newHomeView
//////            self.window?.makeKeyAndVisible()
//////            self.application(application, open: url, sourceApplication: launchOptions![.sourceApplication] as? String, annotation: annotation)
////        }else{
//         FIRApp.configure()
////        }
//       
//        
//        
////        let remoteNotif = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? NSDictionary
////        
////        if remoteNotif != nil {
////            let itemName = remoteNotif?["aps"] as! String
////            print("Custom: \(itemName)")
////        }
////        else {
////            print("//////////////////////////")
////        }
//        
//        
//        
////        if launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] != nil {
////            // Do what you want to happen when a remote notification is tapped.
////        }
//        
//        
//        
//         Twitter.sharedInstance().start(withConsumerKey: "bsQ3hZemqFjdZi4PaWvWsMjpB", consumerSecret: "ohyvjn3TQrOowkZCVnlgiL4fAkAVkG41dYlwDvgbEHAoD2sPQS")
//              Fabric.with([Twitter.self])
//        // Override point for customization after application launch.
//        
//        return true
//    }
//    
    
    
    
//    func applicationDidBecomeActive(_ application: UIApplication)
//    {
//        
//        if(i>0){
//            print("lllll")
//        let viewer = ViewController()
//        viewer.returnVC().viewDidLoad()
//        }else{
//            i=1
//        }
//        FBSDKAppEvents.activateApp();
//        
//    }

    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo["gcm_message_id"] ?? "yup")
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            let viewer = self.window?.rootViewController as! ViewController
            viewer.token = refreshedToken
        }
    }
    
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any)  -> (Bool)
    {
//        FIRApp.configure()
        print("rgegwreg")
        print("url \(url)")
        print("url host :\(url.host!)")
        print("url path :\(url.path)")
        let urlPath : String = url.path as String!
        let urlHost : String = url.host as String!
        //        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if(urlHost != "inner")
        {
            print("Host is not correct")
        }else{
            //        if(urlPath == "/inner"){
            let viewer = self.window?.rootViewController as! ViewController
            let viewer3 = ViewController3()
            viewer3.view.isHidden = false
            viewer3.view.alpha = 1
            //            (viewer.vc2 as! ViewController2).viewer3.view.isHidden = false
            //            (viewer.vc2 as! ViewController2).viewer3.view.alpha = 1
            viewer.scrollView.setContentOffset(CGPoint(x: viewer.view.frame.size.width, y: 0), animated: true)
            let index2: String.Index = url.path.index(url.path.startIndex, offsetBy: 28)
            let index22: String.Index = url.path.index(url.path.startIndex, offsetBy: 29)
            let username = url.path.substring(from: url.path.startIndex).substring(to: index22)
            let accounts = url.path.substring(from: index2)
            print(username)
            var frame1 = viewer.view.frame
            frame1.origin.x = viewer.view.frame.size.width * 1
            viewer3.view.frame = frame1
            viewer.scrollView.addSubview(viewer3.view)
            viewer3.view.frame = frame1
            viewer.scrollView.bringSubview(toFront: viewer3.view)
            viewer.addPerson(mode: 0, vc3: viewer3, uid: username, acc: accounts, code: "temp1234")
        }
        self.window?.makeKeyAndVisible()
        
        
//        print("rgegwreg")
//        print("url \(url)")
//        print("url host :\(url.host!)")
//        print("url path :\(url.path)")
//        let urlPath : String = url.path as String!
//        let urlHost : String = url.host as String!
//        //        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        if(urlHost != "inner")
//        {
//            print("Host is not correct")
//        }else{
//            //        if(urlPath == "/inner"){
//            let viewer = self.window?.rootViewController as! ViewController
//            let index2: String.Index = url.path.index(url.path.startIndex, offsetBy: 28)
//            let index22: String.Index = url.path.index(url.path.startIndex, offsetBy: 29)
//            let username = url.path.substring(from: url.path.startIndex).substring(to: index22)
//            let accounts = url.path.substring(from: index2)
//            viewer.addPerson(mode: 200, vc3: ViewController3(), uid: username, acc: accounts)
//        }
//        self.window?.makeKeyAndVisible()
        
        
        
        
        let wasHandled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application
            ,open:url
            ,sourceApplication:sourceApplication
            ,annotation:annotation)
        
        if (wasHandled) {
            if (FBSDKAccessToken.current()) != nil {
                print("works1!")
            }else{
                print("no current token")
            }
        }
        
        return wasHandled
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        FIRApp.configure()
        let when = DispatchTime.now() + 2.6
         DispatchQueue.main.asyncAfter(deadline: when) {
        print("rgegwreg")
                print("url \(url)")
                print("url host :\(url.host!)")
                print("url path :\(url.path)")
                let urlPath : String = url.path as String!
                let urlHost : String = url.host as String!
                //        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if(urlHost != "inner")
                {
                    print("Host is not correct")
                }else{
                    //        if(urlPath == "/inner"){
                    let viewer = self.window?.rootViewController as! ViewController
                    viewer.scrollView.setContentOffset(CGPoint(x: viewer.view.frame.size.width, y: 0), animated: true)
                    let index2: String.Index = url.path.index(url.path.startIndex, offsetBy: 28)
                    let index22: String.Index = url.path.index(url.path.startIndex, offsetBy: 29)
                    let username = url.path.substring(from: url.path.startIndex).substring(to: index22)
                    let accounts = url.path.substring(from: index2)
                    if viewer.hasLoaded == 1 {
                    viewer.addHelper(uid: username, acc: accounts)
                    }else{
                        viewer.accTemp = accounts
                        viewer.userTemp = username
                    }
                }
                self.window?.makeKeyAndVisible()
        }
        
        let wasHandled: Bool =  FBSDKApplicationDelegate.sharedInstance().application(
            app,
            open: url as URL!,
            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String,
            annotation: options[UIApplicationOpenURLOptionsKey.annotation]
        )
        
        if (wasHandled) {
            if (FBSDKAccessToken.current()) != nil {
                print("works2!")
            }else{
                print("no current token")
            }
        }
        
        return wasHandled;
    }
    
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        let facebookDidHandle = ApplicationDelegate.sharedInstance().application(
//            application,
//            open: url,
//            sourceApplication: sourceApplication,
//            annotation: annotation)
//        // Add any custom logic here.
//        return facebookDidHandle
//    }

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

//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        
//        // Call the 'activate' method to log an app event for use
//        // in analytics and advertising reporting.
//       // AppEventsLogger.activate(application)
//    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

