//
//  ViewController0.swift
//  vite2
//
//  Created by Steven Grutman on 1/17/17.
//  Copyright © 2017 Steven Grutman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ViewController0: UIViewController/*, UITextViewDelegate, UITextFieldDelegate*/ {
    
    // , UITextFieldDelegate
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var enterBio: UITextView!
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var myCode: UIImageView!
    var qrcodeImage: CIImage!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
//    var arr = [String]()
    @IBOutlet weak var orange: UIImageView!
    var mainView = ViewController()
    let ref = FIRDatabase.database().reference()
    let thing2 = UIView()
    let menu = UIScrollView()
    let button2 = UIButton()
    let enterText = UIView()
     let button3 = UIButton()
    var tempP = 0
    var tempB = UIButton()
    let label = UITextField()
    var initName = ""
    var initBio = ""
    var editMode = 0
     let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "mail.png", "link.png", "pint.png", "tumblr.png", "git.png", "plus.png", "skype.jpg", "reddit.jpg", "stack.png", "youtube.png", "yelp.png", "venmo.png", "linkedin.jpg", "dribbble.jpg", "peri.png", "500px.png", "myspace.png", "spotify.png", "flickr.png", "aim.jpg"]
//    var activeTextField = UITextField()
//    
//    private func textFieldDidBeginEditing(textField: UITextField) {
//        self.activeTextField = textField
//    }
    
//    @IBAction func closeThis(_ sender: Any) {
//        self.view.isHidden = true
//    }
    
    
    @IBAction func editClick(_ sender: Any) {
        if (editButton.titleLabel?.text == "E"){
            self.thing2.isHidden = false
            self.scroller.frame.origin.y = CGFloat(57)
            self.scroller.contentSize = CGSize(width: self.scroller.contentSize.width, height: self.scroller.contentSize.height + CGFloat(60))
            editButton.setTitle("D", for: .normal)
            editButton.setBackgroundImage(UIImage(named: "orangeCheck.png"), for: .normal)
            for all2 in self.scroller.subviews{
                for all in all2.subviews{
                    if(all.accessibilityLabel != nil && all.accessibilityLabel! == "delete"){
                        all.isHidden = false
                    }
                }
            }
        }else{
            self.thing2.isHidden = true
            self.scroller.frame.origin.y = CGFloat(0)
            self.scroller.contentSize = CGSize(width: self.scroller.contentSize.width, height: self.scroller.contentSize.height - CGFloat(60))
            editButton.setTitle("E", for: .normal)
            editButton.setBackgroundImage(UIImage(named: "edit.png"), for: .normal)
            for all2 in self.scroller.subviews{
                for all in all2.subviews{
                    if(all.accessibilityLabel != nil && all.accessibilityLabel! == "delete"){
                        all.isHidden = true
                    }
            }
        }
    }
    }
    
    
    func getProfPic(mode: Int, myURLString: String) -> String {
        if(mode == 0){
            guard let myURL = URL(string: myURLString) else {
                print("Error: \(myURLString) doesn't seem to be a valid URL")
                return ""
            }
            do {
                let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
                var dict = self.convertToDictionary(text: myHTMLString)
                var dict2 = NSDictionary()
                dict2 = dict?["data"] as! NSDictionary
                //                print(dict2["url"] ?? 0)
                return (dict2["url"] as? String)!
            } catch let error {
                print("Error: \(error)")
            }
            return ""
        }else{
            let fullNameArr = myURLString.components(separatedBy: "_normal")
            return fullNameArr[0] + fullNameArr[1]
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("return1")
//        self.view.endEditing(true)
//        return false
//    }
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("scrolling1")
//        self.view.endEditing(true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.hideKeyboardWhenTappedAround()
        let user = FIRAuth.auth()?.currentUser
//        enterBio.delegate = self
        
//        //only apply the blur if the user hasn't disabled transparency effects
//        if !UIAccessibilityIsReduceTransparencyEnabled() {
//            self.view.backgroundColor = UIColor.clear
//            
//            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            //always fill the view
//            blurEffectView.frame = self.view.bounds
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            
//            self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
//        } else {
//            self.view.backgroundColor = UIColor.black
//        }
//        logoutButton.layer.cornerRadius = 5
//        logoutButton.layer.borderWidth = 1
//        logoutButton.layer.masksToBounds = true
//        logoutButton.layer.borderColor = UIColor.black.cgColor

        myCode.layer.cornerRadius = 75
//        myCode.layer.borderWidth = 1
        myCode.layer.masksToBounds = true
//        myCode.layer.borderColor = UIColor.black.cgColor
        
        var fbTw = 0
        self.ref.child("users").child((user?.uid)!).child("info").child("00use").observe(.value, with: { snapshot6 in
            if(snapshot6.value as! String == "tw"){
                fbTw = 1
            }
        })
         self.ref.child("users").child((user?.uid)!).child("info").child("19DEF").observe(.value, with: { snapshot2 in
//            print("ggggg")
//            print(snapshot2.value as! String)
//            print("hhhhh")
            if(snapshot2.value as? String ?? "" != ""){
            if(fbTw == 0){
            self.myCode.setImageFromURl(stringImageUrl: (self.getProfPic(mode: 0, myURLString: "http://graph.facebook.com/"+(snapshot2.value as? String ?? "")+"/picture?type=large&redirect=false")))
        }else{
            self.myCode.setImageFromURl(stringImageUrl: (self.getProfPic(mode: 1, myURLString: snapshot2.value as? String ?? "")))
        }
            }
         })
        
        
        
        
        ref.child("users").child((user?.uid)!).child("info").observe(.value, with: { snapshot in
            self.initBio = snapshot.childSnapshot(forPath: "17BIO").value as? String ?? ""
            self.initName = snapshot.childSnapshot(forPath: "18NAME").value as? String ?? ""
            self.enterBio.text = self.initBio
            self.enterName.text = self.initName
            self.mainView.viewableName = self.initName
        })
        
        
        
        
//        let data = ("vite!-username//"+(user?.uid)!).data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
//        let filter = CIFilter(name: "CIQRCodeGenerator")
//        filter?.setValue(data, forKey: "inputMessage")
//        filter?.setValue("Q", forKey: "inputCorrectionLevel")
////        qrcodeImage = filter?.outputImage
//        
//        //Create a CIFalseColor Filter
//        let colorFilter: CIFilter = CIFilter(name: "CIFalseColor")!
//        colorFilter.setDefaults()
//        colorFilter.setValue(filter?.outputImage!, forKey: "inputImage")
//        //Then set the background colour like this,
//        let transparentBG: CIColor = CIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
//        // let transparentBG: CIColor = CIColor(red: 255.0, green: 215.0, blue: 20.0, alpha: 1.0)
//        colorFilter.setValue(CIColor.black(), forKey: "inputColor0")
//        colorFilter.setValue(transparentBG, forKey: "inputColor1")
//        qrcodeImage = colorFilter.outputImage!
//        
////        myCode.image = UIImage(ciImage: qrcodeImage)
//        let scaleX = myCode.frame.size.width / qrcodeImage.extent.size.width
//        let scaleY = myCode.frame.size.height / qrcodeImage.extent.size.height
//        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
//        myCode.image = UIImage(ciImage: transformedImage)
//        
//        orange.layer.cornerRadius = 50
//        orange.layer.borderWidth = 2
//        orange.layer.masksToBounds = true
//        orange.layer.borderColor = UIColor.black.cgColor
        
        
        
        
//        arr = [String]()
        //load info for user you scanned from database
         self.topView.addBottomBorderWithColor(color: UIColor.gray, width: 1)
        ref.child("users").child((user?.uid)!).child("info").observe(FIRDataEventType.value, with: { snapshot in
            var counter = 0
            var place = 301
            //delete all existing buttons
            for subs in self.scroller.subviews {
                if subs.tag != -1 {
//                    print(subs)
                    subs.removeFromSuperview()
                }
            }
            
            self.thing2.frame = CGRect(x: 0, y: place-3, width:Int(self.view.frame.size.width), height: 55)
            self.thing2.addBottomBorderWithColor(color: UIColor.gray, width: 1)
//            place+=54
            self.thing2.backgroundColor = UIColor.white
            self.thing2.tag = 0
//            self.thing2.layer.cornerRadius = 10
//            self.thing2.layer.borderWidth = 1
//            self.thing2.layer.borderColor = UIColor.black.cgColor
            
            self.menu.isHidden = true
            self.menu.isScrollEnabled = true
            
            self.enterText.frame = CGRect(x: 0, y: 0, width:Int(self.view.frame.size.width), height: 55)
            
            self.label.frame = CGRect(x: 110, y: 2, width: self.view.frame.size.width - 72 - 110, height: 48)
            self.label.font = UIFont(name: "Heiti TC", size: 20)
//            label.numberOfLines = 0
//            label.minimumScaleFactor = 0.1
//            label.baselineAdjustment = .alignCenters
            self.enterText.addSubview(self.label)
            
            let button4 = UIButton()
            button4.backgroundColor = UIColor.yellow
            button4.frame = CGRect(x: (self.view.frame.size.width - 72), y: 4, width: 62, height: 42)
            button4.setTitle("Add", for: .normal)
            button4.setTitleColor(UIColor.black, for: .normal)
            button4.layer.cornerRadius = 10
            button4.layer.borderWidth = 1
            button4.layer.borderColor = UIColor.black.cgColor
            button4.addTarget(self, action: #selector(self.addService), for: .touchUpInside)
            self.enterText.addSubview(button4)
            
            self.button3.frame = CGRect(x: 9, y: 9, width: 40, height: 40)
            self.button3.setTitle("X", for: .normal)
//            self.button3.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
            self.button3.setTitleColor(UIColor.black, for: .normal)
//            self.button3.layer.cornerRadius = 15
//            self.button3.layer.borderWidth = 0
//            self.button3.layer.masksToBounds = true
//            self.button3.layer.borderColor = UIColor.black.cgColor
            self.button3.addTarget(self, action: #selector(self.hideMenu), for: .touchUpInside)
            self.menu.addSubview(self.button3)
            
            var place2 = 55
           
            self.menu.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 55)
            self.menu.contentSize = CGSize(width: (self.arr2.count-1)*58+46, height: 55)
            self.menu.showsHorizontalScrollIndicator = false
            self.menu.bounces = false
            var counter11 = 0
            for all in self.arr2[0..<(self.arr2.count)] {
                let image = UIImage(named: all)
                let newOne = UIButton()
                newOne.accessibilityIdentifier = self.arr2.index(of: all)?.description
                newOne.setImage(image, for: .normal)
                newOne.frame = CGRect(x: place2, y: 3, width: 48, height: 48)
                newOne.setTitle(String(counter11), for: .normal)
                place2+=55
                newOne.setTitleColor(UIColor.clear, for: .normal)
                newOne.layer.cornerRadius = 5
//                newOne.layer.borderWidth = 1
                newOne.layer.masksToBounds = true
//                newOne.layer.borderColor = UIColor.black.cgColor
                 newOne.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                self.menu.addSubview(newOne)
                counter11 = counter11 + 1
            }
            
            self.button2.backgroundColor = UIColor(red: 94/255, green: 180/255, blue: 255/255, alpha: 1.0)
            self.button2.frame = CGRect(x: 0, y: 0, width:Int(self.view.frame.size.width), height: 55)
            self.button2.setTitle("Add Service", for: .normal)
            self.button2.setTitleColor(UIColor.black, for: .normal)
            self.button2.addTarget(self, action: #selector(self.showMenu), for: .touchUpInside)
            
            
            self.enterText.isHidden = true
            self.thing2.addSubview(self.menu)
            self.thing2.addSubview(self.enterText)
            self.thing2.addSubview(self.button2)
//            self.scroller.addSubview(self.thing2)
            if self.editMode == 0{
                self.thing2.isHidden = true
            }
            self.view.addSubview(self.thing2)
            
            
            
            let enumerator = snapshot.children
            let number = snapshot.children.allObjects.count - 5
            
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
//                print("t")
                var res = ""
                if let result_number = (rest.value)! as? NSNumber
                {
                    res = "\(result_number)"
                }else{
                    res = rest.value as! String
                }
//                print("r")
                if(Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! >= 20){
//                    let button = UIButton()
                    //                    button.tag = 123
                    //                    button.frame = (frame: CGRect(x: xpx, y: ypx, width: ((Int(self.view.frame.size.width) - (18*4))/3), height: ((Int(self.view.frame.size.width) - (18*4))/3)))
                    
                    let thing = UIView()
                    thing.frame = CGRect(x: 0, y: place, width:Int(self.view.frame.size.width), height: 60)
                    place+=60
                    thing.backgroundColor = UIColor.clear
//                    thing.layer.cornerRadius = 15
//                    thing.layer.borderWidth = 1
//                    thing.layer.masksToBounds = true
//                    thing.layer.borderColor = UIColor.black.cgColor
                    if number != counter{
//                        thing.addBottomBorderWithColor(color: UIColor.black, width: 1)
                        let grayLine = UIView()
                        grayLine.frame = CGRect(x: 72, y: thing.frame.height - 3, width: thing.frame.width*0.76, height: 1)
                        grayLine.backgroundColor = UIColor.lightGray
                        thing.addSubview(grayLine)
                    }else{
                        self.topView.isHidden = false
                        self.loader.isHidden = true
                    }
//                    print("y")
                    thing.tag = counter
                    counter+=1;
                    var imgString = ""
                    
                    let numKey = Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! - 20
                    imgString = self.arr2[numKey]
                    if(numKey == 4 || numKey == 1){
                        res = "@"+res
                    }
                    
                    let image = UIImage(named: imgString)
                    let imageView = UIImageView(image: image!)
                    imageView.frame = CGRect(x: 15, y: 6, width: 48, height: 48)
                    imageView.layer.cornerRadius = 5
//                    imageView.layer.borderWidth = 1
                    imageView.layer.masksToBounds = true
//                    imageView.layer.borderColor = UIColor.black.cgColor
                    
                    let label = UILabel()
                    label.text = res
                    label.frame = CGRect(x: 72, y: 6, width: self.view.frame.size.width - 72 - 10 - 48, height: 48)
                    label.font = UIFont(name: "Heiti TC", size: 20)
                    label.numberOfLines = 0
                    label.minimumScaleFactor = 0.1
                    label.baselineAdjustment = .alignCenters
                    //label.adjustsFontSizeToFitWidth = true
                    //label.backgroundColor = UIColor.green
                    //label.textAlignment  = .center
                    
                    // button.setImage(UIImage(named: imgString), for: UIControlState.normal)
                    //button.setTitleColor(UIColor.clear, for: .normal)
                    if(rest.key != "20MAIN" && rest.key != "21MAIN"){
                    let button = UIButton()
                    button.frame = CGRect(x: self.view.frame.width - 50, y: 15, width: 30, height: 30)
                        button.setBackgroundImage(UIImage(named: "close.png"), for: .normal)
//                    button.setTitle("|", for: .normal)
//                    button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
                    button.accessibilityIdentifier = rest.key
                    button.accessibilityLabel = "delete"
                        if self.editMode == 0{
                    button.isHidden = true
                        }
//                    button.backgroundColor = UIColor.red
                        button.backgroundColor?.withAlphaComponent(0.8)
                    button.setTitleColor(UIColor.white, for: .normal)
                    button.layer.cornerRadius = 15
                    button.layer.borderWidth = 0
                    button.layer.masksToBounds = true
                    button.layer.borderColor = UIColor.black.cgColor
                    button.addTarget(self, action: #selector(self.removeService), for: .touchUpInside)
                    
                    thing.addSubview(button)
                }
                    thing.addSubview(label)
                    thing.addSubview(imageView)
                    self.scroller.addSubview(thing)
                }
            }
            self.scroller.contentSize = CGSize(width: Int(self.view.frame.size.width), height: (Int(346+(60*(counter+self.editMode)))) - 42 - self.editMode*2)
             self.editMode = 0
        })
//        sleep(1)
//          self.mainView.hideLoader()
    }
    
    func removeService(sender: UIButton!){
        
        let refreshAlert = UIAlertController(title: "Remove Service", message: "Would you like to remove this social media platform from your profile?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
             self.editMode = 1
            let user = FIRAuth.auth()?.currentUser
            self.ref.child("users").child((user?.uid)!).child("info").child(sender.accessibilityIdentifier!).removeValue()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("cancled remove")
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func logoutClick(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Log Out", message: "You are about to log out of your account. Proceed?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.logout()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("cancled logout")
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func logout(){
        let firebaseAuth = FIRAuth.auth()
        FBSDKLoginManager().logOut()
        do {
            try firebaseAuth?.signOut()
            mainView.loginView.isHidden = false
            mainView.scrollView.isHidden = true
            for  subview in mainView.scrollView.subviews
            {
                subview.removeFromSuperview()
            }
//            print("Logged Out");
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func buttonAction(sender: UIButton!) {
//        print("yoyoy")
//        UIApplication.shared.open((URL(string: sender.title(for: .normal)!))!
//            , options: [:], completionHandler: nil)
        tempP = Int(sender.frame.minX)
        tempB = sender
        sender.frame = CGRect(x: 50, y: 3, width: 48, height: 48)
        enterText.addSubview(sender)
        button2.isHidden = true
        menu.isHidden = true
        enterText.isHidden = false
        self.enterText.addSubview(self.button3)
        switch Int(sender.accessibilityIdentifier!)! {
        case 1,4:
            self.label.placeholder = "@username"
        case 2:
            self.label.placeholder = "(888) 888-8888"
        case 3, 9, 10:
            self.label.placeholder = "username"
        case 6:
            self.label.placeholder = "username@example.com"
        default:
            self.label.placeholder = "put shit here"
        }
    }
    
    func showMenu(){
        button2.isHidden = true
        menu.isHidden = false
        enterText.isHidden = true
    }
    
    func hideMenu(){
        button2.isHidden = false
        tempB.frame = CGRect(x: tempP, y: 3, width: 48, height: 48)
        self.menu.addSubview(self.button3)
        self.menu.addSubview(self.tempB)
        menu.isHidden = true
        enterText.isHidden = true
        label.text = ""
        self.dismissKeyboard()
    }
    
    func addService(){
        self.editMode = 1
        let user = FIRAuth.auth()?.currentUser
    ref.child("users").child((user?.uid)!).child("info").updateChildValues([String(20+Int(tempB.title(for: .normal)!)!)+self.randomString(length: 7):label.text ?? "sgrutman978"])
        self.hideMenu()
    }
    
    //Calls this function when the tap is recognized.
    override func dismissKeyboard() {
        let user = FIRAuth.auth()?.currentUser
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        if(activeTextField == enterName){
        if(initName != enterName.text){
            ref.child("users").child((user?.uid)!).child("info").updateChildValues(["18NAME": enterName.text ?? "Enter Name"])
            initName = enterName.text!
        }
//        if(activeTextField == enterBio){
        if(initBio != enterBio.text){
            ref.child("users").child((user?.uid)!).child("info").updateChildValues(["17BIO": enterBio.text ?? "Enter Bio"])
            initBio = enterBio.text
        }
//        activeTextField = UITextField()
        view.endEditing(true)
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}




//func load_image(urlString: String)
//{
//
//    var imgURL = URL(string: urlString)!
//    let request = NSURLRequest(url: imgURL)
//    NSURLConnection.sendAsynchronousRequest(
//        request as URLRequest, queue: OperationQueue.mainQueue,
//        completionHandler: {(response: URLResponse!,data: NSData!,error: NSError!) -> Void in
//            if error == nil {
//                self.image_element.image = UIImage(data: data)
//            }
//    })
//    
//}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


//
//extension UIImageView {
//    public func imageFromUrl(urlString: String) {
//        if let url = NSURL(string: urlString) {
//            let request = NSMutableURLRequest(url: url as URL)
//            request.setValue("http", forHTTPHeaderField: "http")
//            URLSession.shared.dataTask(with: request as URLRequest) {
//                (data, response, error) in
//                guard let data = data, error == nil else{
//                    NSLog("Image download error: \(error)")
//                    return
//                }
//                
//                if let httpResponse = response as? HTTPURLResponse{
//                    if httpResponse.statusCode > 400 {
//                        let errorMsg = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                        NSLog("Image download error, statusCode: \(httpResponse.statusCode), error: \(errorMsg!)")
//                        return
//                    }
//                }
//                
//                DispatchQueue.main.async(execute: {
//                    NSLog("Image download success")
//                    self.image = UIImage(data: data)
//                })
//                }.resume()
//        }
//    }
//}
//



//UIImage(data: data!)

//        myCode.image = UIImage(data: NSData(contentsOf: NSURL(string: "kids.nationalgeographic.com/content/dam/kids/photos/articles/Nature/Q-Z/siberian-tiger-profile.jpg")! as URL)! as Data)


//        let url = URL(string:
//            "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png")
//
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard let data = data, error == nil else { return }
//
//            DispatchQueue.main.sync() {
//                self.myCode.image = UIImage(data: data)
//            }
//        }
//
//        task.resume()

//        let imgURL = "https://chart.googleapis.com/chart?cht=qr&chl=vite!-username%2F%2F"+(user?.uid)!+"&chs=180x180&choe=UTF-8&chld=L|2" // or jpg
//        self.myCode.setImageFromURl(stringImageUrl: imgURL)



//print("ll")
////https://chart.googleapis.com/chart?cht=qr&chl=vite!-username%2F%2F"+(user?.uid)!+"&chs=180x180&choe=UTF-8&chld=L|2
//print("http://www.kids.nationalgeographic.com/content/dam/kids/photos/articles/Nature/Q-Z/siberian-tiger-profile.jpg")
//
////http://chart.googleapis.com/chart?cht=qr&chl=vite!-username%2F%2F"+(user?.uid)!+"&chs=180x180&chld=L|2
//
////        let url = URL(string: "chart.googleapis.com/chart?cht=qr&chl=vite!-username%2F%2F"+(user?.uid)!+"&chs=180x180&choe=UTF-8&chld=L|2")
////        print(url?.absoluteString ?? 0)
////        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//
//
////        myCode.imageFromUrl(urlString: "http://www.kids.nationalgeographic.com/content/dam/kids/photos/articles/Nature/Q-Z/siberian-tiger-profile.jpg")
