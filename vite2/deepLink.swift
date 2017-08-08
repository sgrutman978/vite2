//
////
////  RemoteNotificationDeepLink.swift
////  DeepLink
////
////  Created by Brian Coleman on 2015-07-12.
////  Copyright (c) 2015 Brian Coleman. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//let RemoteNotificationDeepLinkAppSectionKey : String = "article"
//
//class RemoteNotificationDeepLink: NSObject {
//    
//    var article : String = ""
//    
//    class func create(userInfo : [NSObject : AnyObject]) -> RemoteNotificationDeepLink?
//    {
//        print("fsgssgdf")
//        let info = userInfo as NSDictionary
//        
//        let articleID = info.object(forKey: RemoteNotificationDeepLinkAppSectionKey) as! String
//        
//        var ret : RemoteNotificationDeepLink? = nil
//        if !articleID.isEmpty
//        {
//            ret = RemoteNotificationDeepLinkArticle(articleStr: articleID)
//        }
//        return ret
//    }
//    
//    public override init()
//    {
//        self.article = ""
//        super.init()
//    }
//    
//    public init(articleStr: String)
//    {
//        self.article = articleStr
//        super.init()
//    }
//    
//    final func trigger()
//    {
//        DispatchQueue.main.async()
//            {
//                //NSLog("Triggering Deep Link - %@", self)
//                self.triggerImp()
//                    { (passedData) in
//                        // do nothing
//                }
//        }
//    }
//    
//    public func triggerImp(completion: ((AnyObject?)->(Void)))
//    {
//        
//        completion(nil)
//    }
//}
//
//class RemoteNotificationDeepLinkArticle : RemoteNotificationDeepLink
//{
//    var articleID : String!
//    
//    override init(articleStr: String)
//    {
//        self.articleID = articleStr
//        super.init(articleStr: articleStr)
//    }
//    
//    public override func triggerImp(completion: ((AnyObject?)->(Void)))
//    {
//        super.triggerImp()
//            { (passedData) in
//                
//                //                var vc = UIViewController()
//                
//                // Handle Deep Link Data to present the Article passed through
//                
//                if self.articleID == "A"
//                {
//                    print("aaaaaaaaaaaaaaaaaaaaaaaa")
//                }
//                else if self.articleID == "B"
//                {
//                    print("bbbbbbbbbbbbbbbbbbbbb")
//                }
//                else if self.articleID == "C"
//                {
//                    print("ccccccccccccccccccccc")
//                }
//                
////                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
////                                appDelegate.window?.addSubview(vc.view)
//                
//                completion(nil)
//        }
//    }
//    
//}
