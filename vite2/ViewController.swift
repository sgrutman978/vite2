//
//  ViewController.swift
//  vite2
//
//  Created by Steven Grutman on 1/17/17.
//  Copyright © 2017 Steven Grutman. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FBSDKLoginKit
import Fabric
import TwitterKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var loginFb: UIButton!
    @IBOutlet weak var loginTw: UIButton!
    
    //creates outlet for scroll view
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var loadScreen: UIView!
    let loginButton = FBSDKLoginButton()
    var ref = FIRDatabaseReference()
    var userID = ""
    var fbid = ""
    var vc = UIViewController()
    var vc0 = UIViewController()
    var vc2 = UIViewController()
    var vc4 = UIViewController()
    var logInButton = TWTRLogInButton()
    var user2NAME = "Enter Name"
    var user2URL = ""
    var use00 = ""
    var modeVc4 = 0
    var vc4User = ""
    var hasLoaded = 0
    var userTemp = ""
    var accTemp = ""
    var viewableName = ""
    var firstTime = true
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var request = URLRequest(url: URL(string: "http://www.thisismylink.com/postName.php")!)
//        request.httpMethod = "POST"
//        let postString = "id=13&name=Jack"
//        request.httpBody = postString.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(error)")
//                return
//            }
//            
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//            }
//            
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
//        }
//        task.resume()
        
        
        
        self.scrollView.delegate = self
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
//        UIApplication.shared.beginIgnoringInteractionEvents()
      self.showLoader()
        self.view.bringSubview(toFront: loadScreen)
//        self.loadScreen.layer.zPosition = CGFloat.greatestFiniteMagnitude
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
//        print("hellooooo")
//        loginView.backgroundColor = UIColor.orange
        loginFb.layer.cornerRadius = 10
         loginFb.layer.masksToBounds = true
//        loginFb.layer.borderWidth = 1
//        loginFb.layer.borderColor = UIColor.black as! CGColor
        loginTw.layer.cornerRadius = 10
        loginTw.layer.masksToBounds = true
//        loginTw.layer.borderWidth = 1
//        loginTw.layer.borderColor = UIColor.black as! CGColor
        ref = FIRDatabase.database().reference()
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.triggerDeepLinkIfPresent()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
//                                print(user.uid)
                if(self.user2URL == ""){
                self.setupPage(user: user)
                self.hideLoader()
                }
            }
            
            if FIRAuth.auth()?.currentUser == nil {
                self.hideLoader()
            }
            
            //else {
//                                print("you suck")
//                self.loginButton.delegate = self
//                self.loginButton.center.x = -300
//                self.loginView.addSubview(self.loginButton)
//            }
        
            self.loginButton.delegate = self
            self.loginButton.center.x = -300
            self.loginView.addSubview(self.loginButton)
//            self.hideLoader()
        
            self.logInButton = TWTRLogInButton(logInCompletion: { session, error in
                if (session != nil) {
                    print("signed in as \(session?.userName)")
                    let credential = FIRTwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
                    FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                self.user2URL = "a"
                        
                        
                        
//                        let twitterClient = TWTRAPIClient(userID: session?.userID)
//                        twitterClient.loadUser(withID: (session?.userID)!, completion: {(user: TWTRUser, error: NSError?) -> Void in
//                            print(user.profileImageURL)
//                        } as! TWTRLoadUserCompletion)
                       
                        
                        
                            if (session != nil) {
                                let userID = Twitter.sharedInstance().sessionStore.session()!.userID
                                let client = TWTRAPIClient(userID: userID)
                                print("the user id is \(userID)")
                                let statusesShowEndpoint = "https://api.twitter.com/1.1/users/show.json?user_id=\(userID)"
                                let params = ["profile_image_url_https":"https://si0.twimg.com/profile_images/1438634086/avatar_normal.png"]
                                var clientError : NSError?
                                
                                let twitterClient = TWTRAPIClient(userID: userID)
                                let request = twitterClient.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
                                
                                
                                client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                                    if (connectionError == nil) {
                                        
                                        do {
                                            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
//                                                print("i am getting some form of data")
//                                                print(jsonResult)
                                                let data:[String:AnyObject] = jsonResult as! [String : AnyObject]
                                                //                    print(data.endIndex)
                                                
                                                self.ref.child("users").child((user?.uid)!).child("info").updateChildValues(["00use":   "tw"])
                                                self.use00 = data["screen_name"] as! String
                                                self.user2NAME = data["name"] as! String
                                                self.user2URL = data["profile_image_url"] as! String
                                                self.setupPage(user: user!)
                                            }
                                        } catch let error as NSError {
                                            print(error.localizedDescription)
                                        }
                                        
                                        
                                    }
                                    else {
                                        print("Error: \(connectionError)")
                                    }
                                }
                            }
                        
                    }
                } else {
                    print("error: \(error?.localizedDescription)")
                }
            })
            self.logInButton.center.x = -400
            self.loginView.addSubview(self.logInButton)
            
        }
    }
    
    
    //        // Swift
    //        Twitter.sharedInstance().logIn { session, error in
    //            if (session != nil) {
    //                print("signed in as \(session?.userName)")
    //            } else {
    //                print("error: \(error?.localizedDescription)")
    //            }
    //        }
  
    
    func applicationDidBecomeActive(_ notification: NSNotification) {
        self.vc.viewDidLoad()
    }
    
    
    func sendNotif(list: String){
        self.ref.child("users").child(vc4User).child("info").child("16TOK").observeSingleEvent(of: .value, with: { snapshot in
            self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("info").child("18NAME").observeSingleEvent(of: .value, with: { snapshot2 in
        let headers = [
            "authorization": "key=AAAA6z_Aucc:APA91bFJKKWMEx8Vl3FQVHvwusHpKf0LjPtyHplwGGoECTT_Fy-hk0jAsJ4Z1edwMqfyfiJSadv44J_cboSbzicxdIcLVOpoqDZkcS5nDjDcos3GMDvJroov5fnQXWJpJLB03thZy7qE",
            "content-type": "application/json",
            "cache-control": "no-cache",
            "postman-token": "cdd8e810-c7bd-2cc5-873d-9392571213f9"
        ]
        let parameters = [
            "notification": [
                "title": snapshot2.value as! String,
                "body": "has just sent you services!"
            ],
            "to": snapshot.value ?? ""
            ] as [String : Any]
        
        
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let request = NSMutableURLRequest(url: NSURL(string: "https://fcm.googleapis.com/fcm/send")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                }
            })
            
            dataTask.resume()
            
        }catch{
            print("fml")
        }
        })
        })
    }

    
    @IBAction func clickTwitter(_ sender: Any) {
        self.user2URL = "aa"
        logInButton.sendActions(for: .touchUpInside)
    }
    
    
    @IBAction func fbLogin(_ sender: Any) {
        self.user2URL = "aa"
        loginButton.sendActions(for: .touchUpInside)
    }
    
    func returnVC() -> UIViewController{
        return self.vc
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        return true
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton?, didCompleteWith result: FBSDKLoginManagerLoginResult?, error: Error?) {
//        print("helloss")
        if let error = error {
            print(error.localizedDescription)
            return
        }
        if(FBSDKAccessToken.current() == nil){
            return
        }
        //        print("jj")
        //        print(FBSDKAccessToken.current().tokenString)
        //        print("ooo")
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if error != nil {
                return
            }
            else{
            self.user2URL = "a"
            if((FBSDKAccessToken.current()) != nil){
                let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name,email, picture.type(large)"])
                
                graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                    
                    if ((error) != nil)
                    {
                        print("Error: \(error)")
                    }
                    else
                    {
                        let data:[String:AnyObject] = result as! [String : AnyObject]
                        //                    print(data.endIndex)
                        self.fbid = data["id"] as! String
                        print(data)
                        print(self.fbid)
//                        self.ref.child("users").child((user?.uid)!).child("info").updateChildValues(["11ABC": user?.email ?? 0])
                        self.ref.child("users").child((user?.uid)!).child("info").updateChildValues(["00use":   "fb"])
                        self.use00 = "fb"
                        self.user2URL = self.fbid
                        self.user2NAME = data["name"] as! String
                        self.setupPage(user: user!)
                    }
                })
            }

        }
        }
       
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton?) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        (vc0 as! ViewController0).view.endEditing(true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            print("dfasdf")
        }
//        else {
//            //something else
//        }
        
    }
    
    func showLoader(){
        loader.startAnimating()
        loadScreen.fadeIn()
    }
    
    func hideLoader(){
        loader.stopAnimating()
        loadScreen.fadeOut()
        self.hasLoaded = 1
    }
    
    
    func setupPage(user: FIRUser){
    
//        print("dfgdfg")
            self.ref.child("users").child(user.uid).child("info").observeSingleEvent(of: .value, with: { snapshot in
            if(!snapshot.hasChild("18NAME")){
                if(self.use00 != "" && self.use00 != "fb"){
                    self.ref.child("users").child(user.uid).child("info").updateChildValues(["21MAIN":   self.use00])
                }
                if(self.use00 == "fb"){
                    self.ref.child("users").child(user.uid).child("info").updateChildValues(["20MAIN":   self.user2NAME])
                }
                self.ref.child("users").child(user.uid).child("info").updateChildValues(["19DEF":   self.user2URL])
                self.ref.child("users").child(user.uid).child("info").updateChildValues(["18NAME":   self.user2NAME])
                self.ref.child("users").child(user.uid).child("info").updateChildValues(["17BIO":   ""])
            }
                            })
        if self.token != ""{
        self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("info").updateChildValues(["16TOK":   self.token])
        }
            
//       print("worked")
        userID = user.uid
        self.loginView.isHidden = true
        self.scrollView.isHidden = false
        //creates first view
        let vc0 = ViewController0(nibName: "ViewController0", bundle: nil)
        vc0.mainView = self
        self.addChildViewController(vc0)
        self.scrollView.addSubview(vc0.view)
        vc0.didMove(toParentViewController: self)
        self.vc0 = vc0
//        vc0.view.isHidden = true
        
        
        //creates second view with starting place = width of first
        let vc1 = ViewController1(nibName: "ViewController1", bundle: nil)
        vc = vc1
        vc1.viewer = self
        var frame1 = vc1.view.frame
        frame1.origin.x = self.view.frame.size.width
        vc1.view.frame = frame1
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        vc1.didMove(toParentViewController: self)
        self.addChildViewController(vc0)
        self.scrollView.addSubview(vc0.view)
        
        
        //creates 3rd view with starting place width * 2
        let vc2 = ViewController2(nibName: "ViewController2", bundle: nil)
        vc2.user = userID
        var frame2 = vc2.view.frame
        frame2.origin.x = self.view.frame.size.width * 2
        vc2.view.frame = frame2
        self.addChildViewController(vc2)
        self.scrollView.addSubview(vc2.view)
        vc2.didMove(toParentViewController: self)
        
        let vc3 = ViewController3(nibName: "ViewController3", bundle: nil)
        vc3.view.frame = frame1
        self.addChildViewController(vc3)
        self.scrollView.addSubview(vc3.view)
        
        let vc4 = ViewController4(nibName: "ViewController4", bundle: nil)
        vc4.view.frame = frame1
        self.addChildViewController(vc4)
        self.scrollView.addSubview(vc4.view)
        
        vc0.didMove(toParentViewController: self)
        
        
//        vc1.viewer3 = vc3
//        vc1.viewer0 = vc0
//        vc1.viewer4 = vc4
//        vc2.viewer3 = vc3
        
        vc1.viewer3 = vc3
        vc1.viewer0 = vc0
        vc1.viewer = self
        vc1.viewer4 = vc4
        
        vc2.viewer = self
//        vc2.viewer1 = vc1
        vc2.viewer3 = vc3
        vc3.viewer = self
        vc4.viewer = self
        vc4.viewer3 = vc3
        
        self.vc2 = vc2
        self.vc4 = vc4
        vc3.view.alpha = 0;
        vc3.view.isHidden = true
        vc4.view.isHidden = true
        //        moveTofound(vc3: vc3, uid: userID)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height-64)
        
        //        self.scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: false)
        
        //        ref.child("users").child(user.uid).child("allowed").observe(.value) { (snapshot: FIRDataSnapshot) in
        //            print("ooo")
        //            print(snapshot.value)
        // print(snapshot.childSnapshot(forPath: "users").value ?? 0)
        //        }
        
        if(userTemp != ""){
            self.addHelper(uid: userTemp, acc: accTemp)
        }
        
    }
    
    //https://chart.googleapis.com/chart?cht=qr&chl=vite!-username%2F%2Fsgrutan978&chs=180x180&choe=UTF-8&chld=L|2' alt='
    
//    func goBack(vc3: ViewController3){
//        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.goBackHelper), userInfo: vc3, repeats: false)
//        vc3.view.fadeOut(withDuration: 0.3)
//    }
//    
//    func goBackHelper(timer: Timer){
//        let vc3 = timer.userInfo as! ViewController3
//        vc3.view.isHidden = true
//        vc3.topView.isHidden = true
//        timer.invalidate()
//    }
    
    func goToPage(num: Int){
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width*CGFloat(num), y: 0), animated: false)
    }
    
    func addHelper(uid: String, acc: String){
            let viewer3 = (self.vc2 as! ViewController2).viewer3
            viewer3.view.isHidden = false
            viewer3.view.alpha = 1
            //            (viewer.vc2 as! ViewController2).viewer3.view.isHidden = false
            //            (viewer.vc2 as! ViewController2).viewer3.view.alpha = 1
            self.scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
            var frame1 = self.view.frame
            frame1.origin.x = viewer3.view.frame.size.width * 1
            viewer3.view.frame = frame1
            self.scrollView.addSubview(viewer3.view)
            viewer3.view.frame = frame1
            self.scrollView.bringSubview(toFront: viewer3.view)
            self.addPerson(mode: 0, vc3: viewer3, uid: uid, acc: acc)
    }
    
    func addPerson(mode: Int, vc3: ViewController3, uid: String, acc: String){
        if(mode == 0){
        let user = FIRAuth.auth()?.currentUser
            print(acc)
            let accs = acc.components(separatedBy: ")").dropFirst()
            
            var currentList = "()00use)17BIO)18NAME)19DEF"
            ref.child("users").child((user?.uid)!).child("allowed").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                currentList = snapshot.value as? String ?? "()00use)17BIO)18NAME)19DEF"
                for all in accs{
                            if(!currentList.contains(")"+all)){
                                currentList = currentList+")"+all
                    }
                }
                self.ref.child("users").child((user?.uid)!).child("allowed").updateChildValues([uid: currentList])
//                (self.vc2 as! ViewController2).addDude(user: uid)
                vc3.setupPerson(user: uid)
            })
        }else{
            vc3.setupPerson(user: uid)
        }
    }
    
    func returnPage() -> CGPoint {
        return self.scrollView.contentOffset
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



public extension UIView {
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(withDuration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(withDuration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
}
