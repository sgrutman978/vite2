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

    @IBOutlet weak var enterBio: UITextView!
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var myCode: UIImageView!
    var qrcodeImage: CIImage!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var scroller: UIScrollView!
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
     let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "fbPage.png", "mail.png", "pint.png", "tumblr.png", "git.png", "plus.png"]
//    var activeTextField = UITextField()
//    
//    private func textFieldDidBeginEditing(textField: UITextField) {
//        self.activeTextField = textField
//    }
    
//    @IBAction func closeThis(_ sender: Any) {
//        self.view.isHidden = true
//    }
    
    
    
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
        logoutButton.layer.cornerRadius = 5
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.borderColor = UIColor.black.cgColor

        myCode.layer.cornerRadius = 15
        myCode.layer.borderWidth = 1
        myCode.layer.masksToBounds = true
        myCode.layer.borderColor = UIColor.black.cgColor
        
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
//         self.topView.addBottomBorderWithColor(color: UIColor.darkGray, width: 4)
        ref.child("users").child((user?.uid)!).child("info").observe(FIRDataEventType.value, with: { snapshot in
            var counter = 0
            var place = 272
            //delete all existing buttons
            for subs in self.scroller.subviews {
                if subs.tag != -1 {
                    print(subs)
                    subs.removeFromSuperview()
                }
            }
            
            self.thing2.frame = CGRect(x: 0, y: place, width:Int(self.view.frame.size.width), height: 50)
            place+=54
            self.thing2.backgroundColor = UIColor.gray
            self.thing2.tag = 0
            
            self.menu.isHidden = true
            self.menu.isScrollEnabled = true
            
            self.enterText.frame = CGRect(x: 0, y: 0, width:Int(self.view.frame.size.width), height: 60)
            
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
            
            self.button3.frame = CGRect(x: 9, y: 7, width: 36, height: 36)
            self.button3.setTitle("X", for: .normal)
            self.button3.backgroundColor = UIColor.lightGray
            self.button3.setTitleColor(UIColor.black, for: .normal)
            self.button3.layer.cornerRadius = 15
            self.button3.layer.borderWidth = 0
            self.button3.layer.masksToBounds = true
            self.button3.layer.borderColor = UIColor.black.cgColor
            self.button3.addTarget(self, action: #selector(self.hideMenu), for: .touchUpInside)
            self.menu.addSubview(self.button3)
            
            var place2 = 50
           
            self.menu.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
            self.menu.contentSize = CGSize(width: (self.arr2.count-1)*58+50, height: 50)
            self.menu.showsHorizontalScrollIndicator = false
            self.menu.bounces = false
            for all in self.arr2[1..<(self.arr2.count)] {
                let image = UIImage(named: all)
                let newOne = UIButton()
                newOne.accessibilityIdentifier = self.arr2.index(of: all)?.description
                newOne.setImage(image, for: .normal)
                newOne.frame = CGRect(x: place2, y: 3, width: 44, height: 44)
                newOne.setTitle(String((place2-50)/58), for: .normal)
                place2+=51
                newOne.setTitleColor(UIColor.clear, for: .normal)
                newOne.layer.cornerRadius = 5
                newOne.layer.borderWidth = 1
                newOne.layer.masksToBounds = true
                newOne.layer.borderColor = UIColor.black.cgColor
                 newOne.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                self.menu.addSubview(newOne)
            }
            
            self.button2.backgroundColor = UIColor.clear
            self.button2.frame = CGRect(x: 0, y: 0, width:Int(self.view.frame.size.width), height: 50)
            self.button2.setTitle("Add Service", for: .normal)
            self.button2.setTitleColor(UIColor.black, for: .normal)
            self.button2.addTarget(self, action: #selector(self.showMenu), for: .touchUpInside)
            
            
            self.enterText.isHidden = true
            self.thing2.addSubview(self.menu)
            self.thing2.addSubview(self.enterText)
            self.thing2.addSubview(self.button2)
//            self.scroller.addSubview(self.thing2)
            self.view.addSubview(self.thing2)
            
            
            
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                print("t")
                var res = ""
                if let result_number = (rest.value)! as? NSNumber
                {
                    res = "\(result_number)"
                }else{
                    res = rest.value as! String
                }
                print("r")
                if(Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! >= 20){
//                    let button = UIButton()
                    //                    button.tag = 123
                    //                    button.frame = (frame: CGRect(x: xpx, y: ypx, width: ((Int(self.view.frame.size.width) - (18*4))/3), height: ((Int(self.view.frame.size.width) - (18*4))/3)))
                    
                    let thing = UIView()
                    thing.frame = CGRect(x: 0, y: place, width:Int(self.view.frame.size.width), height: 60)
                    place+=64
                    thing.backgroundColor = UIColor.lightGray
                    print("y")
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
                    imageView.frame = CGRect(x: 10, y: 6, width: 48, height: 48)
                    imageView.layer.cornerRadius = 5
                    imageView.layer.borderWidth = 1
                    imageView.layer.masksToBounds = true
                    imageView.layer.borderColor = UIColor.black.cgColor
                    
                    let label = UILabel()
                    label.text = res
                    label.frame = CGRect(x: 64, y: 6, width: self.view.frame.size.width - 64 - 10, height: 48)
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
                    button.frame = CGRect(x: self.view.frame.width - 40, y: 15, width: 30, height: 30)
                    button.setTitle("X", for: .normal)
                    button.accessibilityIdentifier = rest.key
                    button.backgroundColor = UIColor.red
                    button.setTitleColor(UIColor.black, for: .normal)
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
            self.scroller.contentSize = CGSize(width: Int(self.view.frame.size.width), height: (Int(346+(64*(counter+1)))))
        })
        
    }
    
    func removeService(sender: UIButton!){
        
        let refreshAlert = UIAlertController(title: "Remove Service", message: "Would you like to remove this social media platform from your profile?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            let user = FIRAuth.auth()?.currentUser
            self.ref.child("users").child((user?.uid)!).child("info").child(sender.accessibilityIdentifier!).removeValue()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("cancled remove")
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func logoutClick(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Log Out", message: "You are about to log out of your account. Proceed?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.logout()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("cancled logout")
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
            print("Logged Out");
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func buttonAction(sender: UIButton!) {
        print("yoyoy")
//        UIApplication.shared.open((URL(string: sender.title(for: .normal)!))!
//            , options: [:], completionHandler: nil)
        tempP = Int(sender.frame.minX)
        tempB = sender
        sender.frame = CGRect(x: 50, y: 3, width: 44, height: 44)
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
        tempB.frame = CGRect(x: tempP, y: 3, width: 44, height: 44)
        self.menu.addSubview(self.button3)
        self.menu.addSubview(self.tempB)
        menu.isHidden = true
        enterText.isHidden = true
        label.text = ""
        self.dismissKeyboard()
    }
    
    func addService(){
        let user = FIRAuth.auth()?.currentUser
    ref.child("users").child((user?.uid)!).child("info").updateChildValues([String(21+Int(tempB.title(for: .normal)!)!)+self.randomString(length: 7):label.text ?? "sgrutman978"])
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
