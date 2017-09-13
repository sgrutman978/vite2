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
import Contacts
import ContactsUI
import SafariServices

class ViewController0: UIViewController, CNContactViewControllerDelegate /*, UITextViewDelegate, UITextFieldDelegate*/ {
    
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
    var temp3 = ""
    var initBio = ""
    var linkMode = 0
    var num = 0
    var editMode = 0
    var temp123 = ""
     let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "mail.png", "link.png", "pint.png", "tumblr.png", "git.png", "plus.png", "skype.jpg", "reddit.jpg", "stack.png", "youtube.png", "yelp.png", "venmo.png", "linkedin.jpg", "dribbble.jpg", "peri.png", "500px.png", "myspace.png", "spotify.png", "flickr.png", "aim.jpg", "xbox.jpg"]
    var arr = [String]()
    var arr3 = [String]()
//    var activeTextField = UITextField()
//    
//    private func textFieldDidBeginEditing(textField: UITextField) {
//        self.activeTextField = textField
//    }
    
//    @IBAction func closeThis(_ sender: Any) {
//        self.view.isHidden = true
//    }
    
    
    @IBAction func editClick(_ sender: Any) {
        if(mainView.tutMode == 3){
           // mainView.tutTemp()
            //mainView.tutButton.sendActions(for: .touchUpInside)
            mainView.scrollView.contentSize = CGSize(width: self.view.frame.width*3, height: mainView.scrollView.contentSize.height)
            mainView.tutView.isHidden = false
            mainView.obj = (mainView.vc1 as! ViewController1).icon1
            mainView.tutButton.frame = CGRect(x: mainView.obj.frame.origin.x-5, y: mainView.obj.frame.origin.y-5, width: mainView.obj.frame.width+10, height: mainView.obj.frame.height+10)
            mainView.scrollView.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: true)
            editButton.backgroundColor = UIColor.clear
            mainView.tutLabel.text = "Click Vite! Logo"
            mainView.tutMode += 1
        }
        if (editButton.titleLabel?.text == "E"){
            self.thing2.isHidden = false
            editMode = 1
            hideMenu()
            self.scroller.contentOffset.y = self.scroller.contentOffset.y - 55
            self.scroller.contentInset.top = 55
//            self.scroller.contentSize = CGSize(width: self.scroller.contentSize.width, height: self.scroller.contentSize.height + CGFloat(60))
            editButton.setTitle("D", for: .normal)
            editButton.setBackgroundImage(UIImage(named: "orangeCheck.png"), for: .normal)
            for all2 in self.scroller.subviews{
                for all in all2.subviews{
                    if(all.accessibilityLabel != nil && all.accessibilityLabel! == "delete"){
                        all.isHidden = false
                    }
                    if(all.accessibilityLabel != nil && all.accessibilityLabel! == "View"){
                        all.isHidden = true
                    }
                }
            }
        }else{
            editMode = 0
            self.thing2.isHidden = true
            self.scroller.contentInset.top = 0
//            self.scroller.contentSize = CGSize(width: self.scroller.contentSize.width, height: self.scroller.contentSize.height - CGFloat(60))
            editButton.setTitle("E", for: .normal)
            editButton.setBackgroundImage(UIImage(named: "edit.png"), for: .normal)
            for all2 in self.scroller.subviews{
                for all in all2.subviews{
                    if(all.accessibilityLabel != nil && all.accessibilityLabel! == "delete"){
                        all.isHidden = true
                    }
                    if(all.accessibilityLabel != nil && all.accessibilityLabel! == "View"){
                        all.isHidden = false
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
            print("heyyygjgghg")
            print(fullNameArr[0] + fullNameArr[1])
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
    
    func textFieldDidChange(_ textField: UITextField) {
        print("fsgdf")
        
    }
    
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
        
        
        enterBio.textAlignment = NSTextAlignment.center
        enterBio.allowsEditingTextAttributes = false
//        myCode.layer.borderColor = UIColor.black.cgColor
        
        var fbTw = -1
        self.ref.child("users").child((user?.uid)!).child("info").child("00use").observe(.value, with: { snapshot6 in
            if(snapshot6.value as? String == "fb"){
                fbTw = 0
            }
            if(snapshot6.value as? String == "tw"){
                fbTw = 1
            }
        })
         self.ref.child("users").child((user?.uid)!).child("info").child("19DEF").observe(.value, with: { snapshot2 in
//            print("ggggg")
//            print(snapshot2.value as! String)
//            print("hhhhh")
            if(snapshot2.value as? String ?? "" != ""){
                print("got the pic!!!!!")
            if(fbTw == 0){
                print("fb")
            self.myCode.setImageFromURl(stringImageUrl: (self.getProfPic(mode: 0, myURLString: "http://graph.facebook.com/"+(snapshot2.value as? String ?? "")+"/picture?type=large&redirect=false")))
        }else{
                print("tw")
                print(snapshot2.value as! String)
            self.myCode.setImageFromURl(stringImageUrl: (self.getProfPic(mode: 1, myURLString: snapshot2.value as? String ?? "")))
        }
            }
         })
        
        
        
        
        ref.child("users").child((user?.uid)!).child("info").observe(.value, with: { snapshot in
            self.initBio = snapshot.childSnapshot(forPath: "17BIO").value as? String ?? "Enter Bio"
            self.initName = snapshot.childSnapshot(forPath: "18NAME").value as? String ?? "Enter Name"
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
//         self.topView.addBottomBorderWithColor(color: UIColor.gray, width: 1)
//        topView.frame.size = CGSize(width: topView.frame.width, height: CGFloat((281/667.0)*self.mainView.view.frame.height))
        ref.child("users").child((user?.uid)!).child("info").observe(FIRDataEventType.value, with: { snapshot in
            var counter = 0
            self.arr = []
            var place = Int((281/667)*self.mainView.view.frame.height)
            let topVLine = UIView()
            topVLine.frame = CGRect(x: 0, y: place-3, width: Int(self.mainView.view.frame.width), height: 1)
            self.view.addSubview(topVLine)
            topVLine.backgroundColor = UIColor.gray
            print(place)
            print("fdsg")
            //delete all existing buttons
            for subs in self.scroller.subviews {
                if subs.tag != -1 {
//                    print(subs)
                    subs.removeFromSuperview()
                }
            }
            
            self.thing2.frame = CGRect(x: 0, y: place-2, width:Int(self.mainView.view.frame.size.width), height: 55)
            self.thing2.addBottomBorderWithColor(color: UIColor.gray, width: 1)
//            place+=54
            self.thing2.backgroundColor = UIColor.white
            self.thing2.tag = 0
//            self.thing2.layer.cornerRadius = 10
//            self.thing2.layer.borderWidth = 1
//            self.thing2.layer.borderColor = UIColor.black.cgColor
            
//            self.menu.isHidden = true
            self.hideMenu()
            self.menu.isScrollEnabled = true
            
            self.enterText.frame = CGRect(x: 0, y: 0, width:Int(self.mainView.view.frame.size.width), height: 55)
            
            self.label.frame = CGRect(x: 110, y: 2, width: self.mainView.view.frame.size.width - 72 - 110, height: 48)
            self.label.font = UIFont(name: "Heiti TC", size: 20)
//            label.numberOfLines = 0
//            label.minimumScaleFactor = 0.1
//            label.baselineAdjustment = .alignCenters
            self.label.addTarget(self, action: Selector(("textFieldDidChange")), for: UIControlEvents.editingChanged)
            self.enterText.addSubview(self.label)
            
            let button4 = UIButton()
//            button4.backgroundColor = UIColor.yellow
            button4.frame = CGRect(x: (self.mainView.view.frame.size.width - 72), y: 6, width: 62, height: 42)
            button4.setTitle("Add", for: .normal)
            button4.setTitleColor(UIColor.black, for: .normal)
            button4.layer.cornerRadius = 10
            button4.layer.borderWidth = 0 //1
            button4.backgroundColor = UIColor.init(red: 94/255, green: 180/255, blue: 255/255, alpha: 0.4)
            button4.layer.borderColor = UIColor.black.cgColor
            button4.addTarget(self, action: #selector(self.addService), for: .touchUpInside)
            self.enterText.addSubview(button4)
            
            self.button3.frame = CGRect(x: 8, y: 6, width: 40, height: 40)
            self.button3.alpha = 0.5
//            self.button3.setTitle("X", for: .normal)
            self.button3.setBackgroundImage(UIImage.init(named: "cx2.png"), for: .normal)
//            self.button3.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
            self.button3.setTitleColor(UIColor.black, for: .normal)
//            self.button3.layer.cornerRadius = 15
//            self.button3.layer.borderWidth = 0
//            self.button3.layer.masksToBounds = true
//            self.button3.layer.borderColor = UIColor.black.cgColor
            self.button3.addTarget(self, action: #selector(self.hideMenu), for: .touchUpInside)
            self.menu.addSubview(self.button3)
            
            var place2 = 55
           
            self.menu.frame = CGRect(x: 0, y: 0, width: self.mainView.view.frame.size.width, height: 55)
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
            self.button2.frame = CGRect(x: 0, y: 0, width:Int(self.mainView.view.frame.size.width), height: 55)
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
            let number = snapshot.children.allObjects.count - 6
            
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
                if(rest.key == "19DEF"){
                    self.temp123 = rest.value as! String
                }
                if(Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! >= 20){
//                    let button = UIButton()
                    //                    button.tag = 123
                    //                    button.frame = (frame: CGRect(x: xpx, y: ypx, width: ((Int(self.mainView.view.frame.size.width) - (18*4))/3), height: ((Int(self.mainView.view.frame.size.width) - (18*4))/3)))
                    
                    let thing = UIView()
                    thing.frame = CGRect(x: 0, y: place, width:Int(self.mainView.view.frame.size.width), height: 60)
                    place+=60
                    thing.backgroundColor = UIColor.clear
//                    thing.layer.cornerRadius = 15
//                    thing.layer.borderWidth = 1
//                    thing.layer.masksToBounds = true
//                    thing.layer.borderColor = UIColor.black.cgColor
                    print(number)
                    print("sfgg")
                    print(counter)
                    if number != counter{
//                        thing.addBottomBorderWithColor(color: UIColor.black, width: 1)
                        let grayLine = UIView()
                        grayLine.frame = CGRect(x: 72, y: thing.frame.height - 3, width: thing.frame.width-83, height: 1)
                        grayLine.backgroundColor = UIColor.lightGray
                        thing.addSubview(grayLine)
                    }//else{
                        self.topView.isHidden = false
                        self.loader.isHidden = true
                   // }
//                    print("y")
                    thing.tag = counter
                    counter+=1;
                    var imgString = ""
                    
                    let numKey = Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! - 20
                    imgString = self.arr2[numKey]
                    if(numKey == 1){
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
                     if([0, 10, 13, 15, 17, 22, 23].contains(numKey) && rest.key != "20MAIN"){
                    self.ref.child("users").child((user?.uid)!).child("info2").child(rest.key).observeSingleEvent(of: .value, with: { snapshot6 in
                            label.text = snapshot6.value as? String
                            })
                     }else{
                       label.text = res
                    }
                    label.frame = CGRect(x: 72, y: 6, width: self.mainView.view.frame.size.width - 72 - 10 - 68, height: 48)
                    label.font = UIFont(name: "Heiti TC", size: 20)
                    label.numberOfLines = 0
                    label.minimumScaleFactor = 0.1
                    label.baselineAdjustment = .alignCenters
                    //label.adjustsFontSizeToFitWidth = true
                    //label.backgroundColor = UIColor.green
                    //label.textAlignment  = .center
                    
                    // button.setImage(UIImage(named: imgString), for: UIControlState.normal)
                    //button.setTitleColor(UIColor.clear, for: .normal)
                    
                    let button = UIButton()
                    button.frame = CGRect(x: self.view.frame.width - 50, y: 15, width: 30, height: 30)
                        button.setBackgroundImage(UIImage(named: "close.png"), for: .normal)
//                    button.setTitle("|", for: .normal)
//                    button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
                    button.accessibilityIdentifier = rest.key
                    button.accessibilityLabel = "delete"
                        
                        let arr3: [String] = ["https://"+res,
                                              "http://twitter.com/"+res,
                                              "phone",
                                              "http://snapchat.com/add/"+res,
                                              "http://instagram.com/"+res,
                                              "email",
                                              "http://" + res,
                                              "http://pinterest.com/"+res,
                                              "http://"+res+".tumblr.com",
                                              "https://github.com/"+res,
                                              "https://"+res,
                                              "skype",
                                              "http://reddit.com/"+res,
                                              "https://"+res,
                                              "http://youtube.com/channel/"+res,
                                              "https://"+res,
                                              "https://venmo.com/"+res,
                                              "https://"+res,
                                              "https://dribbble.com/"+res,
                                              "peri",
                                              "http://500px.com/"+res,
                                              "http://myspace.com/"+res,
                                              "https://"+res,
                                              "https://"+res,
                                              "aim",
                                              "xbox"]

                        
//                        let numKey = Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! - 20
                    if(rest.key != "20MAIN" && rest.key != "21MAIN"){
                    self.arr.append(arr3[numKey])
                    }else{
                        if(rest.key == "20MAIN" || rest.key == "21MAIN"){
                            if(numKey == 0){
                                self.arr.append("https://www.facebook.com/"+self.temp123)
                            }else{
                                self.arr.append("https://www.twitter.com/"+self.temp123)
                            }
                        }
                    }
                        let button32 = UIButton()
                        button32.backgroundColor = UIColor.init(red: 94/255, green: 180/255, blue: 255/255, alpha: 0.4)
                        button32.frame = CGRect(x: (self.mainView.view.frame.size.width - 72), y: 10, width: 62, height: 40)
                        button32.setTitle("View", for: .normal)
                        button32.setTitleColor(UIColor.black, for: .normal)
                        button32.layer.cornerRadius = 10
                        button32.layer.borderWidth = 0 //1
                        button32.accessibilityIdentifier = String(numKey)
                        button32.accessibilityLabel = "View"
                    
                        button32.tag = counter-1
                        button32.accessibilityHint = res
                        button32.layer.borderColor = UIColor.black.cgColor
                        button32.addTarget(self, action: #selector(self.buttonAction2), for: .touchUpInside)
                        if(numKey != 11 && numKey != 24 && numKey != 25){
                            thing.addSubview(button32)
                        }
                    
                        
                        if self.editMode == 0{
                    button.isHidden = true
                        }else{
                            button32.isHidden = true
                        }
//                    button.backgroundColor = UIColor.red
                        button.backgroundColor?.withAlphaComponent(0.8)
                    button.setTitleColor(UIColor.white, for: .normal)
                    button.layer.cornerRadius = 15
                    button.layer.borderWidth = 0
                    button.layer.masksToBounds = true
                    button.layer.borderColor = UIColor.black.cgColor
                    button.addTarget(self, action: #selector(self.removeService), for: .touchUpInside)
                    if(rest.key != "20MAIN" && rest.key != "21MAIN"){
                    thing.addSubview(button)
                    }
                    
                    thing.addSubview(label)
                    thing.addSubview(imageView)
                    self.scroller.addSubview(thing)
                }
            }
            self.scroller.contentSize = CGSize(width: Int(self.mainView.view.frame.size.width), height: (Int((281/667)*self.mainView.view.frame.height))+3+(60*(counter)))
            print("Sgfg")
            print((self.mainView.view.frame.height/667.0)*(155.0/2.0))
            print(self.myCode.frame.height)
            print(self.myCode.layer.cornerRadius) //(sqrt(pow(self.mainView.view.frame.height,2) + pow(self.mainView.view.frame.width,2))/765.0)*(155.0/2.0))
            self.myCode.layer.cornerRadius = (self.mainView.view.frame.width - 76 - 72 - 72)/2.0
                //(sqrt(pow(self.mainView.view.frame.height,2) + pow(self.mainView.view.frame.width,2))/765.0)*(155.0/2.0) //myCode.frame.width/2
            //        myCode.layer.borderWidth = 1
            self.myCode.layer.masksToBounds = true
/*Int(346+(60*(counter/*+self.editMode*/)))) - 42 /*- self.editMode*2*/*/
//             self.editMode = 0
        })
//        sleep(1)
//          self.mainView.hideLoader()
    }
    
    func buttonAction2(sender: UIButton!) {
                print(sender.tag)
        if(arr[sender.tag] == "phone"){
            createContact(content: sender.accessibilityHint!, type: 0)
        }else if arr[sender.tag] == "email"{
            createContact(content: sender.accessibilityHint!, type: 1)
            //else if address?
        }else{
            //                print("fgsfdg")
            print(sender.tag)
            print(arr[sender.tag])
            let svc = SFSafariViewController(url: URL(string: arr[sender.tag])!)
            self.present(svc, animated: true, completion: nil)
            //                print("bgdghd")
            //              UIApplication.shared.open((URL(string: arr[sender.tag]))!
            //            , options: [:], completionHandler: nil)
        }
    }
    
    func createContact(content: String, type: Int){
        let newContact = CNMutableContact()
        if(type == 0){
            newContact.phoneNumbers.append(CNLabeledValue(label: "other", value: CNPhoneNumber(stringValue: content)))
        }else if type == 1{
            newContact.emailAddresses.append(CNLabeledValue(label: CNLabelHome, value: content as NSString))
        }else{
            //address?
        }
        let contactVC = CNContactViewController(forUnknownContact: newContact)
        contactVC.contactStore = CNContactStore()
        contactVC.delegate = self
        contactVC.allowsActions = true
        let navigationController = UINavigationController(rootViewController: contactVC)
        
        //For presenting the vc you have to make it navigation controller otherwise it will not work, if you already have navigatiation controllerjust push it you dont have to make it a navigation controller
        contactVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,target: self, action: "dismiss")
        
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldDidChange() -> Bool{
        /*
         case 0:
         self.label.placeholder = "Example: facebook.com/..."
         case 1, 4, 3, 7, 8, 9, 11, 12, 13, 14, 16, 18, 19, 20, 21, 24:
         self.label.placeholder = "username"
         case 2:
         self.label.placeholder = "(888) 888-8888"
         case 5:
         self.label.placeholder = "username@example.com"
         case 6:
         self.label.placeholder = "myExampleWebsite.com"
         case 10:
         self.label.placeholder = "plus.google.com/888888888888888888888"
         case 15:
         self.label.placeholder = "yelp.com/Example"
         case 17:
         self.label.placeholder = "linkedin.com/Example"
         case 22:
         self.label.placeholder = "open.spotify.com/Example"
         case 23:
         self.label.placeholder = "flickr.com/Example"
 */
        var regex = ".*?"
        if(linkMode == 0){
        switch Int(tempB.title(for: .normal)!)! {
        case 0:
            regex = "^facebook.com/.*?$"
        case 1:
            regex = "^[a-zA-Z0-9_]{1,15}$"
        case 4, 3, 7, 8, 9, 11, 12, 14, 18, 19, 20, 21, 24:
            regex = "^[a-zA-Z0-9_]{1,40}$"
        case 2:
            regex = "^\\+?(\\d{1,3})?-? ?\\(?\\d{3}\\)?-? ?\\d{3}-? ?\\d{4} ?(x|ext|extension|ext.)? ?\\d{0,10}$" //"/^(?:(?:\\(?(?:00|\\+)([1-4]\\d\\d|[1-9]\\d?)\\)?)?[\\-\\.\\ \\\\\\/]?)?((?:\\(?\\d{1,}\\)?[\\-\\.\\ \\\\\\/]?){0,})(?:[\\-\\.\\ \\\\\\/]?(?:#|ext\\.?|extension|x)[\\-\\.\\ \\\\\\/]?(\\d+))?$/i" //"(?:(?:\\+?1\\s*(?:[.-]\\s*)?)?(?:(\\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]‌​)\\s*)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\\s*(?:[.-]\\s*)?)([2-9]1[02-9]‌​|[2-9][02-9]1|[2-9][02-9]{2})\\s*(?:[.-]\\s*)?([0-9]{4})\\s*(?:\\s*(?:#|x\\.?|ext\\.?|extension)\\s*(\\d+)\\s*)?$" //"\\(?\\+[0-9]{1,3}\\)? ?-?[0-9]{1,3} ?-?[0-9]{3,5} ?-?[0-9]{4}( ?-?[0-9]{3})? ?(\\w{1,10}\\s?\\d{1,6})?" //"^\\+(?:[0-9] ?){6,14}[0-9]$"
        case 5:
            regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        case 6:
           regex = "^([a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)+.*)$" //"[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)"
        case 10:
            regex = "^plus.google.com/.*?$"
        case 13:
            regex = "^stackoverflow.com/.*?$"
        case 15:
            regex = "^yelp.com/.*?$"
        case 16:
            regex = "^[a-zA-Z0-9_-]{1,40}$"
        case 17:
            regex = "^linkedin.com/.*?$"
        case 22:
            regex = "^open.spotify.com/.*?$"
        case 23:
            regex = "^flickr.com/.*?$"
        case 25:
            regex = "^[a-zA-Z0-9_ ]{1,40}$"
        default:
            regex = "" // ".*?" -> anything
            break
        }
        }
        if matches(for: regex, in: label.text!) != [] {
            label.textColor = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 1.0)
            return true
        }else{
            label.textColor = UIColor.red
            return false
        }
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func removeService(sender: UIButton!){
        
        let refreshAlert = UIAlertController(title: "Remove Service", message: "Would you like to remove this social media platform from your profile?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
//             self.editMode = 1
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
        mainView.gone = 0
        self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("info").updateChildValues(["16TOK":   ""])
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
        sender.frame = CGRect(x: 55, y: 3, width: 48, height: 48)
        enterText.addSubview(sender)
        button2.isHidden = true
        menu.isHidden = true
        enterText.isHidden = false
        linkMode = 0
        num = Int(tempB.title(for: .normal)!)!
        self.enterText.addSubview(self.button3)
        self.button3.addTarget(self, action: #selector(self.hideMenu), for: .touchUpInside)
        switch Int(sender.accessibilityIdentifier!)! {
        case 0:
            self.label.text = "facebook.com/"
        case 1, 4, 3, 7, 8, 9, 11, 12, 14, 16, 18, 19, 20, 21, 24:
            self.label.placeholder = "username"
        case 2:
            self.label.placeholder = "(888) 888-8888"
        case 5:
            self.label.placeholder = "username@example.com"
        case 6:
            self.label.placeholder = "myExampleWebsite.com"
        case 10:
            self.label.text = "plus.google.com/"
        case 13:
            self.label.text = "stackoverflow.com/"
        case 15:
            self.label.text = "yelp.com/"
        case 17:
            self.label.text = "linkedin.com/"
        case 22:
            self.label.text = "open.spotify.com/"
        case 23:
            self.label.text = "flickr.com/"
        case 25:
            self.label.placeholder = "gamertag"
        default:
            self.label.placeholder = "Add stuff here"
        }
    }
    
    func showMenu(){
        button2.isHidden = true
        menu.isHidden = false
        enterText.isHidden = true
    }
    
    func hideMenu(){
        self.button2.isHidden = false
        self.tempB.frame = CGRect(x: tempP, y: 3, width: 48, height: 48)
        self.menu.addSubview(self.button3)
        self.button3.addTarget(self, action: #selector(self.hideMenu), for: .touchUpInside)
        self.menu.addSubview(self.tempB)
        self.menu.isHidden = true
        self.enterText.isHidden = true
        self.label.text = ""
        self.dismissKeyboard()
    }
    
    func addService(){
        if(textFieldDidChange()){
//        self.editMode = 1
        let user = FIRAuth.auth()?.currentUser
            print(num)
            if([0, 10, 13, 15, 17, 22, 23].contains(num)){
                print("fdgdfg")
                if(linkMode == 0){
                    temp3 = label.text!
                    label.text = ""
                    label.placeholder = "Name your link"
                    linkMode = 1
                }else{
                    let rand = self.randomString(length: 7)
                ref.child("users").child((user?.uid)!).child("info2").updateChildValues([String(20+Int(tempB.title(for: .normal)!)!)+rand:label.text ?? "No Name"])
                ref.child("users").child((user?.uid)!).child("info").updateChildValues([String(20+Int(tempB.title(for: .normal)!)!)+rand:temp3])
                    self.hideMenu()
                }
            }else{
                ref.child("users").child((user?.uid)!).child("info").updateChildValues([String(20+Int(tempB.title(for: .normal)!)!)+self.randomString(length: 7):label.text ?? "No Name"])
                self.hideMenu()
            }
        }else{
            let refreshAlert = UIAlertController(title: "Invalid Entry", message: "The information you provided will not properly link to any social media account. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
                //            print("cancled remove")
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    //Calls this function when the tap is recognized.
    override func dismissKeyboard() {
        enterBio.textAlignment = NSTextAlignment.center
        let user = FIRAuth.auth()?.currentUser
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        if(activeTextField == enterName){
        if(initName != enterName.text){
            ref.child("users").child((user?.uid)!).child("info").updateChildValues(["18NAME": enterName.text ?? "Enter Name"])
            initName = enterName.text!
        }
//        if(activeTextField == enterBio){
        if(initBio != enterBio.text){
            ref.child("users").child((user?.uid)!).child("info").updateChildValues(["17BIO": enterBio.text ?? "Enter Bio..."])
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
