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

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
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
    var vc2 = UIViewController()
    var vc4 = UIViewController()
    var logInButton = TWTRLogInButton()
    var user2NAME = "Enter Name"
    var user2URL = ""
    var use00 = ""
    var modeVc4 = 0
    var vc4User = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func showLoader(){
        loader.startAnimating()
        loadScreen.fadeIn()
    }
    
    func hideLoader(){
        loader.stopAnimating()
        loadScreen.fadeOut()
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
    }
    
    //https://chart.googleapis.com/chart?cht=qr&chl=vite!-username%2F%2Fsgrutan978&chs=180x180&choe=UTF-8&chld=L|2' alt='
    
    func goBack(vc3: ViewController3){
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.goBackHelper), userInfo: vc3, repeats: false)
        vc3.view.fadeOut(withDuration: 0.3)
    }
    
    func goBackHelper(timer: Timer){
        let vc3 = timer.userInfo as! ViewController3
        vc3.view.isHidden = true
        vc3.topView.isHidden = true
        timer.invalidate()
    }
    
    func goToPage(num: Int){
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width*CGFloat(num), y: 0), animated: false)
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
                (self.vc2 as! ViewController2).addDude(user: uid)
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


//**************************************************************




//        let ref = FIRDatabase.database().reference(withPath: "vite-a7f75/grocery-items/")

//        print("pizzq")
//        // 1
//        let rootRef = FIRDatabase.database().reference()
//
//        // 2
//        let childRef = FIRDatabase.database().reference(withPath: "grocery-items")
//
//        // 3
//        let itemsRef = rootRef.child("grocery-items")
//
//        // 4
//        let milkRef = itemsRef.child("milk")
//
//        // 5
//        print(rootRef.key)   // prints: ""
//        print(childRef.key)  // prints: "grocery-items"
//        print(itemsRef.key)  // prints: "grocery-items"
//        print(milkRef.key)   // prints: "milk"

//        ref.observe(.value, with: { snapshot in
//            print(snapshot.value as Any)
//        })
//print("dude")
//        ref.observe(.value, with: { (snapshot) in
//            print("hi")
////            print(snapshot.value as? [String : AnyObject] ?? 0)
//            // ...
//        })
//     print("tip")



//        self.addChildViewController(vc3)
//        self.scrollView.addSubview(vc3.view)
// let vc3 = ViewController3(nibName: "ViewController3", bundle: nil)











////
////  ViewController.swift
////  vite2
////
////  Created by Steven Grutman on 1/17/17.
////  Copyright © 2017 Steven Grutman. All rights reserved.
////
//
//import UIKit
//import Firebase
//import Foundation
//import FBSDKLoginKit
//
//class ViewController: UIViewController, FBSDKLoginButtonDelegate {
//    
//    @IBOutlet weak var loginView: UIView!
//    
//    
//    //creates outlet for scroll view
//    @IBOutlet weak var scrollView: UIScrollView!
//    
//    let loginButton = FBSDKLoginButton()
//    var ref = FIRDatabaseReference()
//    var userID = ""
//    var fbid = ""
//    var vc = UIViewController()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("hellooooo")
//        loginView.backgroundColor = UIColor.orange
//        
//        ref = FIRDatabase.database().reference()
//        
//        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
//            if let user = user {
//                print("hi")
//                self.setupPage(user: user)
//            } else {
//                print("you suck")
//                self.loginButton.delegate = self
//                self.loginButton.center = self.loginView.center
//                self.loginView.addSubview(self.loginButton)
//            }
//        }
//    }
//    
//    func returnVC() -> UIViewController{
//        return vc
//    }
//    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        FIRApp.configure()
//        return true
//    }
//    
//    func loginButton(_ loginButton: FBSDKLoginButton?, didCompleteWith result: FBSDKLoginManagerLoginResult?, error: Error?) {
//        print("helloss")
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//        if(FBSDKAccessToken.current() == nil){
//            return
//        }
//        //        print("jj")
//        //        print(FBSDKAccessToken.current().tokenString)
//        //        print("ooo")
//        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//            // ...
//            if error != nil {
//                return
//            }
//            //            else{
//            //                self.setupPage()
//            //            }
//            
//            if((FBSDKAccessToken.current()) != nil){
//                let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"])
//                
//                graphRequest.start(completionHandler: { (connection, result, error) -> Void in
//                    
//                    if ((error) != nil)
//                    {
//                        print("Error: \(error)")
//                    }
//                    else
//                    {
//                        let data:[String:AnyObject] = result as! [String : AnyObject]
//                        //                    print(data.endIndex)
//                        self.fbid = data["id"] as! String
//                        print(data)
//                        print(self.fbid)
//                        self.ref.child("users").child((user?.uid)!).child("info").updateChildValues(["11ABC": user?.email ?? 0])
//                        self.ref.child("users").child((user?.uid)!).child("info").updateChildValues(["19DEF":   self.fbid])
//                        print("blahblahblah")
//                        
//                    }
//                })
//            }
//            
//        }
//        
//    }
//    
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton?) {
//        
//    }
//    
//    
//    func setupPage(user: FIRUser){
//        
//        userID = user.uid
//        self.loginView.isHidden = true
//        self.scrollView.isHidden = false
//        //creates first view
//        let vc0 = ViewController0(nibName: "ViewController0", bundle: nil)
//        vc0.mainView = self
//        self.addChildViewController(vc0)
//        self.scrollView.addSubview(vc0.view)
//        vc0.didMove(toParentViewController: self)
//        
//        
//        //creates second view with starting place = width of first
//        let vc1 = ViewController1(nibName: "ViewController1", bundle: nil)
//        vc = vc1
//        vc1.viewer = self
//        var frame1 = vc1.view.frame
//        frame1.origin.x = self.view.frame.size.width
//        vc1.view.frame = frame1
//        self.addChildViewController(vc1)
//        self.scrollView.addSubview(vc1.view)
//        vc1.didMove(toParentViewController: self)
//        
//        
//        //creates 3rd view with starting place width * 2
//        let vc2 = ViewController2(nibName: "ViewController2", bundle: nil)
//        vc2.user = userID
//        var frame2 = vc2.view.frame
//        frame2.origin.x = self.view.frame.size.width * 2
//        vc2.view.frame = frame2
//        self.addChildViewController(vc2)
//        self.scrollView.addSubview(vc2.view)
//        vc2.didMove(toParentViewController: self)
//        
//        let vc3 = ViewController3(nibName: "ViewController3", bundle: nil)
//        vc3.view.frame = frame2
//        self.addChildViewController(vc3)
//        self.scrollView.addSubview(vc3.view)
//        vc0.didMove(toParentViewController: self)
//        
//        
//        vc1.viewer2 = vc3
//        vc3.view.alpha = 0;
//        vc3.view.isHidden = true
//        //        moveTofound(vc3: vc3, uid: userID)
//        
//        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height/*-64*/)
//        
//        //        self.scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: false)
//        //        ref.child("users").child(user.uid).child("allowed").observe(.value) { (snapshot: FIRDataSnapshot) in
//        //            print("ooo")
//        //            print(snapshot.value)
//        // print(snapshot.childSnapshot(forPath: "users").value ?? 0)
//        //        }
//    }
//    
//    //https://chart.googleapis.com/chart?cht=qr&chl=vite!-username%2F%2Fsgrutan978&chs=180x180&choe=UTF-8&chld=L|2' alt='
//    
//    func moveTofound(vc3: ViewController3, uid: String){
//        //       self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 4, height: self.view.frame.size.height/*-64*/)
//        
//        ref.child("users").child(uid).child("info").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            //            let value = snapshot.value as? NSDictionary
//            //            let username = value?["username"] as? String ?? ""
//            //            let user = User.init(username: username)\
//            print(snapshot.value as Any)
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        
//        vc3.setupPerson(user: uid)
//        
//    }
//    
//    func goBack(vc3: ViewController3){
//        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.goBackHelper), userInfo: vc3, repeats: false)
//        vc3.view.fadeOut(withDuration: 0.5)
//    }
//    
//    func goBackHelper(timer: Timer){
//        let vc3 = timer.userInfo as! ViewController3
//        vc3.view.isHidden = true
//        timer.invalidate()
//    }
//    
//    func addPerson(uid: String){
//        let user = FIRAuth.auth()?.currentUser
//        ref.child("users").child((user?.uid)!).child("allowed").updateChildValues([uid: "a"])
//        ref.child("users").child((user?.uid)!).child("temp").updateChildValues([uid: ""])
//        
//        ref.child("users").child(uid).child("allowed").updateChildValues([(user?.uid)!: "a"])
//        ref.child("users").child((user?.uid)!).child("temp").setValue(nil)
//    }
//    
//    func returnPage() -> CGPoint {
//        return self.scrollView.contentOffset
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//}
//
//
//public extension UIView {
//    /**
//     Fade in a view with a duration
//     
//     - parameter duration: custom animation duration
//     */
//    func fadeIn(withDuration duration: TimeInterval = 1.0) {
//        UIView.animate(withDuration: duration, animations: {
//            self.alpha = 1.0
//        })
//    }
//    
//    /**
//     Fade out a view with a duration
//     
//     - parameter duration: custom animation duration
//     */
//    func fadeOut(withDuration duration: TimeInterval = 1.0) {
//        UIView.animate(withDuration: duration, animations: {
//            self.alpha = 0.0
//        })
//    }
//    
//}

