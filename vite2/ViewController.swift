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
    
    @IBOutlet weak var tut: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tutView: UIView!
    @IBOutlet weak var tutButton: UIButton!
    @IBOutlet weak var tutLabel: UILabel!
    @IBOutlet weak var loadScreen: UIView!
    let loginButton = FBSDKLoginButton()
    var ref = FIRDatabaseReference()
    var userID = ""
    var fbid = ""
    var vc = UIViewController()
    var vc0 = UIViewController()
    var vc1 = UIViewController()
    var vc2 = UIViewController()
    var vc3 = UIViewController()
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
    var blinkTime = Timer()
    var obj = UIButton()
    var yelp = 0
    var gone = 0
    var tutMode = 0
//    var runner = 0
    @IBOutlet weak var eula: UIView!
    
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
        
        self.view.bringSubview(toFront: self.eula)
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch1.")
            self.eula.isHidden = true
        }else{
            do{ try FIRAuth.auth()?.signOut()
                        }catch{}
        }
        
        self.scrollView.delegate = self
        
//        UIApplication.shared.beginIgnoringInteractionEvents()
      self.showLoader()
        self.view.bringSubview(toFront: loadScreen)
//        self.loadScreen.layer.zPosition = CGFloat.greatestFiniteMagnitude
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
        
        
//        do{ try FIRAuth.auth()?.signOut()
//        }catch{}
        
        
        
//        print("hellooooo")
//        loginView.backgroundColor = UIColor.orange
        loginFb.layer.cornerRadius = 10
         loginFb.layer.masksToBounds = true
        tutButton.layer.cornerRadius = 10
        tutButton.layer.masksToBounds = true
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
//                self.ref.child("users").observeSingleEvent(of: .value, with: { snapshot in
//                    print((snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: "info").childSnapshot(forPath: "19DEF").value as? String ?? "")!)
//                    if((snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: "info").childSnapshot(forPath: "19DEF").value as? String ?? "")! == "" && self.runner == 0){
//                        self.runner = 1
//                        do{ try FIRAuth.auth()?.signOut() }catch{}
//                    }
//                    })
                if(self.user2URL == ""){
                self.setupPage(user: user)
//                self.hideLoader()
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
                     self.showLoader()
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
                                                let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
                                                DispatchQueue.main.asyncAfter(deadline: when) {
                                                    self.setupPage(user: user!)
                                                }
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
    
    @IBAction func eula(_ sender: Any) {
        eula.isHidden = true
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
        print("helloss")
        if let error = error {
            print(error.localizedDescription)
            return
        }
        if(FBSDKAccessToken.current() == nil){
            self.hideLoader()
            return
        }else{
            self.showLoader()
        }
        //        print("jj")
        //        print(FBSDKAccessToken.current().tokenString)
                print("ooo")
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//            self.hideLoader()
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
                        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            self.setupPage(user: user!)
                        }
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
        self.dismissKeyboard()
        self.vc0.dismissKeyboard()
        self.vc1.dismissKeyboard()
        self.vc2.dismissKeyboard()
        self.vc3.dismissKeyboard()
        self.vc4.dismissKeyboard()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            print("dfasdf")
        }
//        else {
//            //something else
//        }
        if(returnPage() == CGPoint(x: 0, y: 0)){
            self.vc4.view.isHidden = true
        }
        if(returnPage() == CGPoint(x: self.view.frame.size.width, y: 0)){
            if(self.vc3.view.frame.origin == CGPoint(x: self.view.frame.size.width*2, y: 0)){
                self.vc3.view.isHidden = true
            }
        }
        if(returnPage() == CGPoint(x: self.view.frame.size.width*2, y: 0)){
            if(self.vc3.view.frame.origin == CGPoint(x: self.view.frame.size.width, y: 0)){
                self.vc3.view.isHidden = true
            }
            self.vc4.view.isHidden = true
        }
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
    
    @IBAction func exitTut(_ sender: UIButton) {
    self.tutView.removeFromSuperview()
        sender.removeFromSuperview()
    }
    
    @IBAction func questions(_ sender: Any) {
        let email = "viteappllc@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    func setupPage(user: FIRUser){
    gone += 1
        if(gone == 1){
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
                self.ref.child("users").child(user.uid).child("info").updateChildValues(["17BIO":  "Enter Bio..."])
            }
                            })
            print("tokens")
        if self.token != ""{
        self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("info").updateChildValues(["16TOK":   self.token])
        }
        
//       print("worked")
        self.userID = user.uid
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
        
            let vc1 = ViewController1(nibName: "ViewController1", bundle: nil)
            vc1.viewer = self
            var frame1 = self.view.frame
            let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
        //creates second view with starting place = width of first
        self.vc = vc1
        vc1.viewer = self
         frame1 = vc1.view.frame
        frame1.origin.x = self.view.frame.size.width
        vc1.view.frame = frame1
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        vc1.didMove(toParentViewController: self)
        self.addChildViewController(vc0)
        self.scrollView.addSubview(vc0.view)
            }
        
            let vc2 = ViewController2(nibName: "ViewController2", bundle: nil)
                let when2 = DispatchTime.now() + 1.2 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
        //creates 3rd view with starting place width * 2
        vc2.user = self.userID
        var frame2 = vc2.view.frame
        frame2.origin.x = self.view.frame.size.width * 2
        vc2.view.frame = frame2
        self.addChildViewController(vc2)
        self.scrollView.addSubview(vc2.view)
        vc2.didMove(toParentViewController: self)
            }
            
                    let when3 = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        let vc3 = ViewController3(nibName: "ViewController3", bundle: nil)
                        let vc4 = ViewController4(nibName: "ViewController4", bundle: nil)
                        
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
                        
                        self.vc0 = vc0
                        self.vc1 = vc1
                        self.vc2 = vc2
                        self.vc3 = vc3
                        self.vc4 = vc4
                        
                        
        vc3.view.frame = frame1
        self.addChildViewController(vc3)
        self.scrollView.addSubview(vc3.view)

        vc4.view.frame = frame1
        self.addChildViewController(vc4)
        self.scrollView.addSubview(vc4.view)
        
        vc0.didMove(toParentViewController: self)
        
        
//        vc1.viewer3 = vc3
//        vc1.viewer0 = vc0
//        vc1.viewer4 = vc4
//        vc2.viewer3 = vc3
        
      
        vc3.view.alpha = 0;
        vc3.view.isHidden = true
        vc4.view.isHidden = true
                        
        let mainFrame = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.scrollView.frame.size = mainFrame
        vc0.view.frame.size = mainFrame
        vc1.view.frame.size = mainFrame
        vc2.view.frame.size = mainFrame
        vc3.view.frame.size = mainFrame
        vc4.view.frame.size = mainFrame
        //        moveTofound(vc3: vc3, uid: userID)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height-64)
        
        //        self.scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: false)
                            
//        self.tut.frame = frame1
//        self.scrollView.bringSubview(toFront: self.tut)
//        vc1.view.bringSubview(toFront: vc1.icon2)
                            
//                            vc1.icon2.layer.cornerRadius = 10
//                            vc1.icon2.layer.masksToBounds = true
//                            vc1.icon2.layer.borderWidth = 1
//                            vc1.icon2.layer.borderColor = (UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)).cgColor
                        
            }
            let when4 = DispatchTime.now() + 1.8 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
        self.hideLoader()
        //        ref.child("users").child(user.uid).child("allowed").observe(.value) { (snapshot: FIRDataSnapshot) in
        //            print("ooo")
        //            print(snapshot.value)
        // print(snapshot.childSnapshot(forPath: "users").value ?? 0)
        //        }
        
//        if(self.userTemp != ""){
//            self.addHelper(uid: self.userTemp, acc: self.accTemp)
//        }
              
                            
                            
                
            

            }
                            }//}
    }
    
    func tutTemp(){
//        if(tutMode == 2 || tutMode == 4){
//            obj.backgroundColor = UIColor(red: 94/255, green: 180/255, blue: 255/255, alpha: 1.0)
//        }else{
//        obj.backgroundColor = UIColor.clear
//        }
        obj.sendActions(for: .touchUpInside)
        tutMode += 1
        switch tutMode {
        case 1:
            obj = (vc0 as! ViewController0).editButton
            tutLabel.text = "Click \"Edit\""
            break
        case 2:
            obj = (vc0 as! ViewController0).button2
            tutLabel.text = "Click \"Add Service\""
            break
        case 3:
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollView.contentSize.height)
            tutView.isHidden = true
            obj = (vc0 as! ViewController0).editButton
            break
        case 4:
//            obj = (vc1 as! ViewController1).icon1
//            tutLabel.text = "Chose Accounts then \"Get Code\""
            break
        case 5:
            tutView.isHidden = true
            obj = (vc4 as! ViewController4).getCode
            tutLabel.text = "Chose Accounts then \"Get Code\""
            break
        case 6:
            obj.backgroundColor = UIColor(red: 94/255, green: 180/255, blue: 255/255, alpha: 1)
            tutView.isHidden = false
            obj = (vc4 as! ViewController4).shareButton
            tutLabel.text = "Share Vite! Code"
            break
        default:
            self.tutView.isHidden = true
            self.blinkTime.invalidate()
        }
        if(tutMode == 2 || tutMode == 4){
            tutButton.frame = CGRect(x: obj.frame.origin.x-15, y: obj.frame.origin.y, width: obj.frame.width+30, height: obj.frame.height)
        }else{
        tutButton.frame = CGRect(x: obj.frame.origin.x-5, y: obj.frame.origin.y-5, width: obj.frame.width+10, height: obj.frame.height+10)
        }
        if(tutMode == 2){
            tutButton.frame.origin.y = (vc0 as! ViewController0).topView.frame.height
        }
        //        obj.layer.cornerRadius = 10
        //        obj.layer.masksToBounds = true
    }
    
    @IBAction func tutClick(_ sender: Any) {
        tutTemp()
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
    
    
    func blink() {
        self.blinkTime = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.blinker), userInfo: nil, repeats: true)
    }
    
    func blinker(){
       // print("hiiibhjb")
        yelp += 1
        switch tutMode {
        case 2:
            if(yelp%2 == 0){
                tutButton.backgroundColor = UIColor.white
            }else{
                tutButton.backgroundColor = UIColor.clear
            }
            break
        case 3:
            if(yelp%2 == 0){
                obj.backgroundColor = UIColor(red: 94/255, green: 180/255, blue: 255/255, alpha: 0.7)
            }else{
                obj.backgroundColor = UIColor.clear
            }
            break
        case 5:
            if(yelp%2 == 0){
                obj.backgroundColor = UIColor(red: 94/255, green: 180/255, blue: 255/255, alpha: 1)
            }else{
                obj.backgroundColor = UIColor.white
            }
            break
        default:
            if(yelp%2 == 0){
                tutButton.backgroundColor = UIColor(red: 94/255, green: 180/255, blue: 255/255, alpha: 0.7)
            }else{
                tutButton.backgroundColor = UIColor.clear
            }
            //yelp += 1
        }
    }
    
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
        print("chiwawa")
        if(mode == 0){
        let user = FIRAuth.auth()?.currentUser
            print(acc)
            let accs = acc.components(separatedBy: ")").dropFirst()
            print("lolz")
            ref.child("users").observeSingleEvent(of: .value, with: { (snapshot2) in
                print("yup")
                if(snapshot2.hasChild(uid)){
            print("yayayay")
            var currentList = "()00use)17BIO)18NAME)19DEF"
            self.ref.child("users").child((user?.uid)!).child("allowed").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                currentList = snapshot.value as? String ?? "()00use)17BIO)18NAME)19DEF"
                for all in accs{
                            if(!currentList.contains(")"+all) && snapshot2.childSnapshot(forPath: uid).childSnapshot(forPath: "info").hasChild(all)){
                                currentList = currentList+")"+all
                    }
                }
                self.ref.child("users").child((user?.uid)!).child("allowed").updateChildValues([uid: currentList])
//                (self.vc2 as! ViewController2).addDude(user: uid)
                vc3.setupPerson(user: uid)
            })
                }else{
                    print("fuck youuuuu")
                }
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




extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}


public extension UIView {
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(withDuration duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(withDuration duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
}
