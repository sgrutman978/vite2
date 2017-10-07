//
//  ViewController3.swift
//  vite2
//
//  Created by Steven Grutman on 1/28/17.
//  Copyright © 2017 Steven Grutman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import Contacts
import ContactsUI
import SafariServices

class ViewController3: UIViewController, CNContactViewControllerDelegate {
    
    var viewer = ViewController()
    @IBOutlet weak var profPic: UIImageView!
    let ref = FIRDatabase.database().reference()
    @IBOutlet weak var scroller: UIScrollView!
       var arr = [String]()
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var nameTag: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scroller.contentSize = CGSize(width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendBack(_ sender: Any) {
        viewer.vc4.view.isHidden = false
        viewer.vc4.view.alpha = 1.0
        viewer.modeVc4 = 1
        viewer.goToPage(num: 1)
        (viewer.vc4 as! ViewController4).getCode.setTitle("Send Back", for: .normal)
        viewer.vc4.view.isHidden = false
        viewer.vc4.view.alpha = 1.0
        viewer.scrollView.bringSubview(toFront: viewer.vc4.view)
        viewer.vc4.view.frame.origin.x = viewer.view.frame.size.width
        goBack(UILabel())
    }
    
    @IBAction func goBack(_ sender: Any) {
//        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.goBackHelper), userInfo: nil, repeats: false)
        self.view.fadeOut(withDuration: 0.3)
    }
    
//    func goBack(vc3: ViewController3){
//        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.goBackHelper), userInfo: vc3, repeats: false)
//        vc3.view.fadeOut(withDuration: 0.3)
//    }
    
    func goBackHelper(timer: Timer){
       
        self.view.isHidden = true
        self.topView.isHidden = true
//        timer.invalidate()
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
    
    func setupPerson(user: String){
        print("fuck all this shit give me some")
        //delete all existing buttons
        for subs in scroller.subviews {
            if subs.tag != -1 {
                print(subs)
                subs.removeFromSuperview()
            }
        }
        self.topView.isHidden = true
        self.loader.isHidden = false
//        topView.isHidden = true
//        loader.isHidden = false
        viewer.vc4User = user
        
        self.view.alpha = 1
        scroller.bounces = true
        
        var counter = 0
        var place = Int(self.topView.frame.height+3)
//        self.topView.frame.size = CGSize(width: self.topView.frame.width, height: (324/667)*self.viewer.view.frame.height)
        arr = [String]()
        var fbTw = 0
        var temp = ""
        var temp2 = ""
        
        self.view.isHidden = false
        
        ref.child("users").child(user).child("info").observeSingleEvent(of: .value, with: { snapshot in
            let currBio = snapshot.childSnapshot(forPath: "17BIO").value as? String ?? ""
            if(currBio != "" && currBio != "Enter Bio..."){
            self.bio.text = currBio
            }else{
                self.bio.text = ""
            }
            self.nameTag.text = snapshot.childSnapshot(forPath: "18NAME").value as? String ?? ""
        })
        ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("allowed").child(user).observeSingleEvent(of: .value, with: { snapshot33 in
//            var res = ""
//            if let result_number = (rest.value)! as? NSNumber
//            {
//                res = "\(result_number)"
//            }else{
//                res = rest.value as! String
//            }
//            print(snapshot33.value!)
            let arr = String(describing: snapshot33.value!).components(separatedBy: ")")
        
        //load info for user you scanned from database
        self.ref.child("users").child(user).child("info").observeSingleEvent(of: .value, with: { snapshot in
//            print(snapshot.childrenCount) // I got the expected number of items
            let number = arr.count-1
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
//                print("t")
                if(rest.key == "19DEF"){
                    temp = rest.value as! String
                }
                if(rest.key == "21MAIN"){
                    temp2 = rest.value as! String
                }
                if(rest.key == "00use"){
                    if(rest.value as! String == "fb"){
                        fbTw = 1
                    }
                }
                var res = ""
                if let result_number = (rest.value)! as? NSNumber
                {
                    res = "\(result_number)"
                }else{
                    res = rest.value as! String
                }
//                print("r")
                if(Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! >= 20 && arr.contains(rest.key)){
                    let button = UIButton()
//                    button.tag = 123
//                    button.frame = (frame: CGRect(x: xpx, y: ypx, width: ((Int(self.view.frame.size.width) - (18*4))/3), height: ((Int(self.view.frame.size.width) - (18*4))/3)))
                    
                    let thing = UIView()
                    thing.frame = CGRect(x: 0, y: place-17, width:Int(self.view.frame.size.width), height: 60)
//                    let mygray = UIColor.init(red: 167, green: 170, blue: 175, alpha: 1)
//                    self.topView.addBottomBorderWithColor(color: UIColor.black, width: 1)
                    place+=64
                    thing.backgroundColor = UIColor.clear
                    if number != counter{
                        //                        thing.addBottomBorderWithColor(color: UIColor.black, width: 1)
                        let grayLine = UIView()
                        grayLine.frame = CGRect(x: 72, y: thing.frame.height - 3, width: thing.frame.width-83, height: 1)
                        grayLine.backgroundColor = UIColor.lightGray
                        thing.addSubview(grayLine)
                    }
//                   print("y")
                    thing.tag = counter
                    button.tag = counter
                    counter+=1;
                    
                    var imgString = ""
                    
                    let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "mail.png", "link.png", "pint.png", "tumblr.png", "git.png", "plus.png", "skype.jpg", "reddit.jpg", "stack.png", "youtube.png", "yelp.png", "venmo.png", "linkedin.jpg", "dribbble.jpg", "peri.png", "500px.png", "myspace.png", "spotify.png", "flickr.png", "aim.jpg", "xbox.jpg"]
                    
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
                    
                    let numKey = Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! - 20
//                    print("fb://profile/"+res)
                    if(rest.key == "20MAIN" || rest.key == "21MAIN"){
                        if(numKey == 0){
                        self.arr.append("https://www.facebook.com/"+temp)
                        }else{
                            self.arr.append("https://www.twitter.com/"+temp2)
                        }
                    }else{
                    self.arr.append(arr3[numKey])
                    }
                    imgString = arr2[numKey]
                    
                    if(numKey == 1){
                        res = "@"+res
                    }
                    
                    let image = UIImage(named: imgString)
                    let imageView = UIImageView(image: image!)
                    imageView.frame = CGRect(x: 10, y: 6, width: 48, height: 48)
                    imageView.layer.cornerRadius = 5
//                    imageView.layer.borderWidth = 1
                    imageView.layer.masksToBounds = true
//                    imageView.layer.borderColor = UIColor.black.cgColor
                    
                    let label = UILabel()
                    if([0, 10, 13, 15, 17, 22, 23].contains(numKey) && rest.key != "20MAIN"){
                    self.ref.child("users").child(user).child("info2").child(rest.key).observeSingleEvent(of: .value, with: { snapshot6 in
                            label.text = snapshot6.value as? String
                        })
                    }else{
                        label.text = res
                    }

                    label.frame = CGRect(x: 64, y: 6, width: self.view.frame.size.width - 64 - 14, height: 48)
                    
                    label.font = UIFont(name: "Heiti TC", size: 20)
                    label.numberOfLines = 0
                    label.minimumScaleFactor = 0.1
                    label.baselineAdjustment = .alignCenters
//                    label.adjustsFontSizeToFitWidth = true
//                    label.backgroundColor = UIColor.green
                   
                    //label.textAlignment  = .center
                   // button.setImage(UIImage(named: imgString), for: UIControlState.normal)
                    //button.setTitleColor(UIColor.clear, for: .normal)
                    
                    button.backgroundColor = UIColor.clear
                        //UIColor.init(red: 94/255, green: 180/255, blue: 255/255, alpha: 0.4)
                     button.frame = CGRect(x: 0.0, y: -8.0, width: thing.frame.width, height: thing.frame.height+8)
                    //button.frame = CGRect(x: (self.view.frame.size.width - 72), y: 10, width: 62, height: 40)
                    button.setTitle("", for: .normal) //"View"
                    button.setTitleColor(UIColor.black, for: .normal)
//                    button.layer.cornerRadius = 10
                    button.layer.borderWidth = 0 //1
                    button.accessibilityHint = res
                    button.layer.borderColor = UIColor.black.cgColor
                    button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                    if(numKey != 11 && numKey != 24 && numKey != 25){
                    thing.addSubview(button)
                    }
                    thing.addSubview(label)
                    thing.addSubview(imageView)
                    self.scroller.addSubview(thing)
                }
                if(rest.key == "20MAIN" || rest.key == "21MAIN"){
//                    print("piiiiiii")
                    if(fbTw == 0){
                        let fullNameArr = temp.components(separatedBy: "_normal")
                        self.profPic.setImageFromURl(stringImageUrl: (fullNameArr[0] + fullNameArr[1]))
                    }else{
                        
                        let myURLString = "http://graph.facebook.com/"+temp+"/picture?type=large&redirect=false"
                        guard let myURL = URL(string: myURLString) else {
                            print("Error: \(myURLString) doesn't seem to be a valid URL")
                            return
                        }
                        
                        do {
                            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
                            var dict = self.convertToDictionary(text: myHTMLString)
                            var dict2 = NSDictionary()
                            dict2 = dict?["data"] as! NSDictionary
//                            print(dict2["url"] ?? 0)
                            self.profPic.setImageFromURl(stringImageUrl: (dict2["url"] as? String)!)
                        } catch let error {
                            print("Error: \(error)")
                        }
                    }
                    self.profPic.layer.cornerRadius = (self.viewer.view.frame.width*0.42)/2.0
//                    self.profPic.layer.borderWidth = 2
                    self.profPic.layer.masksToBounds = true
//                    self.profPic.layer.borderColor = UIColor.black.cgColor
                }
            }
            print("chgv")
            print(self.topView.frame.height)
             self.scroller.contentSize = CGSize(width: Int(self.view.frame.size.width), height: (Int(Int((322/667)*self.viewer.view.frame.height)+(64*counter))-((Int(self.topView.frame.height)-313))))
            self.topView.isHidden = false
            self.loader.isHidden = true
        })
        })
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
    
    func buttonAction(sender: UIButton!) {
//        print(sender.tag)
        if(arr[sender.tag] == "phone"){
            createContact(content: sender.accessibilityHint!, type: 0)
        }else if arr[sender.tag] == "email"{
        createContact(content: sender.accessibilityHint!, type: 1)
            //else if address?
            }else{
//                print("fgsfdg")
                print(arr[sender.tag])
                let svc = SFSafariViewController(url: URL(string: arr[sender.tag])!)
                self.present(svc, animated: true, completion: nil)
//                print("bgdghd")
//              UIApplication.shared.open((URL(string: arr[sender.tag]))!
//            , options: [:], completionHandler: nil)
        }
        sender.backgroundColor = UIColor.lightGray
        let when = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            sender.backgroundColor = UIColor.clear
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}
