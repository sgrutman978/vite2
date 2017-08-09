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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var i = 0


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
         Twitter.sharedInstance().start(withConsumerKey: "bsQ3hZemqFjdZi4PaWvWsMjpB", consumerSecret: "ohyvjn3TQrOowkZCVnlgiL4fAkAVkG41dYlwDvgbEHAoD2sPQS")
              Fabric.with([Twitter.self])
        // Override point for customization after application launch.
        if let url = launchOptions?[.url] as? URL, let annotation = launchOptions?[.annotation] {
            return self.application(application, open: url, sourceApplication: launchOptions![.sourceApplication] as? String, annotation: annotation)
        }
        return true
    }
    
    
    
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

    
    
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any)  -> (Bool)
    {
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
            (viewer.vc2 as! ViewController2).viewer3.view.isHidden = false
            (viewer.vc2 as! ViewController2).viewer3.view.alpha = 1
            viewer.scrollView.setContentOffset(CGPoint(x: viewer.view.frame.size.width, y: 0), animated: true)
            let index2: String.Index = url.path.index(url.path.startIndex, offsetBy: 28)
            let index22: String.Index = url.path.index(url.path.startIndex, offsetBy: 29)
            let username = url.path.substring(from: url.path.startIndex).substring(to: index22)
            let accounts = url.path.substring(from: index2)
            print(username)
            var frame1 = viewer.view.frame
            frame1.origin.x = (viewer.vc2 as! ViewController2).viewer3.view.frame.size.width * 1
            (viewer.vc2 as! ViewController2).viewer3.view.frame = frame1
            viewer.addPerson(mode: 0, vc3: (viewer.vc2 as! ViewController2).viewer3, uid: username, acc: accounts)
        }
        self.window?.makeKeyAndVisible()
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
            (viewer.vc2 as! ViewController2).viewer3.view.isHidden = false
            (viewer.vc2 as! ViewController2).viewer3.view.alpha = 1
            viewer.scrollView.setContentOffset(CGPoint(x: viewer.view.frame.size.width, y: 0), animated: true)
            let index2: String.Index = url.path.index(url.path.startIndex, offsetBy: 28)
            let index22: String.Index = url.path.index(url.path.startIndex, offsetBy: 29)
            let username = url.path.substring(from: url.path.startIndex).substring(to: index22)
            let accounts = url.path.substring(from: index2)
            print(username)
            var frame1 = viewer.view.frame
            frame1.origin.x = (viewer.vc2 as! ViewController2).viewer3.view.frame.size.width * 1
            (viewer.vc2 as! ViewController2).viewer3.view.frame = frame1
            viewer.addPerson(mode: 0, vc3: (viewer.vc2 as! ViewController2).viewer3, uid: username, acc: accounts)
        } 
        self.window?.makeKeyAndVisible()

        
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

