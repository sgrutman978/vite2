//
//  ViewController4.swift
//  vite2
//
//  Created by Steven Grutman on 6/10/17.
//  Copyright © 2017 Steven Grutman. All rights reserved.
//

import UIKit
import Firebase

class ViewController4: UIViewController {

    @IBOutlet weak var codeView2: UIView!
    @IBOutlet weak var getCode: UIButton!
    let ref = FIRDatabase.database().reference()
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var myCode: UIImageView!
    @IBOutlet weak var closeCode: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var choseLabel: UILabel!
    let myString = "http://vite.online/?info="
    var viewer = ViewController()
    var viewer3 = ViewController3()
    var checkList = [UIButton]()
    var globalList = ""
    var rand = ""
    let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "mail.png", "link.png", "pint.png", "tumblr.png", "git.png", "plus.png", "skype.jpg", "reddit.jpg", "stack.png", "youtube.png", "yelp.png", "venmo.png", "linkedin.jpg", "dribbble.jpg", "peri.png", "500px.png", "myspace.png", "spotify.png", "flickr.png", "aim.jpg", "xbox.jpg"]
    var list = ""
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func closeCode(_ sender: Any) {
        codeView.isHidden = true
        self.allButton.isHidden = false
    }
    
    @IBAction func closeIt(_ sender: Any) {
        self.view.isHidden = true
    }
    
    @IBAction func sendLink(_ sender: Any) {
        let user = FIRAuth.auth()?.currentUser
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
//        let textToShare = viewer.viewableName + " has shared their Vite with you!\n"
//        if let myWebsite = URL(string: "vite://inner/"+globalList) {//Enter link to your app here
//            let textToShare2 = "\n\nDon't have Vite? Download it for free!\n"
//            let myWebsite2 = URL(string: "https://itunes.apple.com/us/app/vite-meet-greet-connect/id1289967327?ls=1&mt=8")
//            let alltext = viewer.viewableName + " has shared their Vite with you!\nvite://inner/"+globalList+"\n\nDon't have Vite? Download it for free!\nhttps://itunes.apple.com/us/app/vite-meet-greet-connect/id1289967327?ls=1&mt=8"
        
        let textToShare = viewer.viewableName + " has shared their Vite with you!\n"
        if let myWebsite = URL(string: "http://vite.online/?info="+rand+(user?.uid)!) {//Enter link to your app here
            let objectsToShare = [image ?? "", textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: [])
            
            //Excluded Activities 
            activityVC.excludedActivityTypes = [UIActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.present(activityVC, animated: true, completion: nil)
        }
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
    
    @IBAction func choseAll(_ sender: Any) {
        if(allButton.currentTitle == "All"){
            allButton.setTitle("None", for: .normal)
            allButton.setTitleColor(UIColor.init(red: 186/255, green: 0, blue: 0, alpha: 1.0), for: .normal)
        }else{
            allButton.setTitle("All", for: .normal)
            allButton.setTitleColor(UIColor.init(red: 0, green: 128/255, blue: 0, alpha: 1.0), for: .normal)
        }
        for all in checkList {
            if(allButton.currentTitle == "All"){
            all.accessibilityLabel = "seth"
            }else{
                all.accessibilityLabel = "cole"
            }
            all.sendActions(for: .touchUpInside)
        }
    }
    
    @IBAction func createCode(_ sender: Any) {
        var counter44 = 0
        getCode.backgroundColor = UIColor(red: 94/255, green: 180/255, blue: 255/255, alpha: 1)
        
        for all2 in scroller.subviews{
            for all in all2.subviews{
                if(all.accessibilityIdentifier != nil && all.accessibilityIdentifier! != "" && all.accessibilityLabel == "seth"){
                    counter44 = counter44 + 1
                }
            }
        }
        if(counter44 != 0){
        createHelp(mode: viewer.modeVc4)
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore2")
        if launchedBefore  {
            print("Not first launch2.")
        } else {
            print("First launch, setting UserDefault.")
            //tutorial
            let when = DispatchTime.now() + 0.25 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.viewer.tutView.isHidden = false
                self.viewer.view.bringSubview(toFront: self.viewer.tutView)
                self.getCode.backgroundColor = UIColor(red: 94/255, green: 180/255, blue: 255/255, alpha: 1)
                self.viewer.obj = self.shareButton
                self.viewer.tutButton.frame = self.shareButton.frame
                self.viewer.tutLabel.text = "Click \"Profile\" Button"
                self.viewer.tutMode = 6
//                self.viewer.blink()
             UserDefaults.standard.set(true, forKey: "launchedBefore2")
            }}
        }else{
    let alert = UIAlertController(title: "Choose Accounts to Share!", message: "You did not chose any accounts to share!", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }
    }
    
    func createHelp(mode: Int){
        let user = FIRAuth.auth()?.currentUser
        
        if(mode == 0){
            list = myString+(user?.uid)!+"()00use)17BIO)18NAME)19DEF"
            globalList = (user?.uid)!+"()00use)17BIO)18NAME)19DEF"
            for all2 in scroller.subviews{
                for all in all2.subviews{
                    if(all.accessibilityIdentifier != nil && all.accessibilityIdentifier! != "" && all.accessibilityLabel == "seth"){
                        // && all.alpha != 1.0
                                             print(all.alpha)
                        globalList = globalList+")"+all.accessibilityIdentifier!
                        list = list+")"+all.accessibilityIdentifier!
                    }
                }
            }
            self.ref.child("users").child((user?.uid)!).child("codes").updateChildValues(["temp1234": (myString+rand+(user?.uid)!)])
            var qrcodeImage: CIImage!
            rand = randomString(length: 8)
            self.ref.child("users").child((user?.uid)!).child("codes").updateChildValues([rand: globalList])
            let ext = myString+rand+(user?.uid)!
            let data = ext.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            //        qrcodeImage = filter?.outputImage
            
            //Create a CIFalseColor Filter
            let colorFilter: CIFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(filter?.outputImage!, forKey: "inputImage")
            //Then set the background colour like this,
            let transparentBG: CIColor = CIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            // let transparentBG: CIColor = CIColor(red: 255.0, green: 215.0, blue: 20.0, alpha: 1.0)
            colorFilter.setValue(CIColor.init(red: 94/255, green: 180/255, blue: 255/255), forKey: "inputColor0")
//            colorFilter.setValue(CIColor.white(), forKey: "inputColor0")
//            colorFilter.setValue(CIColor.black(), forKey: "inputColor0")
            colorFilter.setValue(transparentBG, forKey: "inputColor1")
            qrcodeImage = colorFilter.outputImage!
            
            myCode.image = UIImage(ciImage: qrcodeImage)
            let scaleX = myCode.frame.size.width / qrcodeImage.extent.size.width
            let scaleY = myCode.frame.size.height / qrcodeImage.extent.size.height
            let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
            myCode.image = UIImage(ciImage: transformedImage)
            
            codeView2.layer.cornerRadius = 50
            codeView2.layer.borderWidth = 2
            codeView2.layer.masksToBounds = true
            codeView2.layer.borderColor = UIColor.gray.cgColor //init(ciColor: CIColor.init(red: 94/255, green: 180/255, blue: 255/255)).cgColor
            
//            print("send 'list' to qr code generator piece in this view controller (find in vc0 commented out) and change GUI accordingly to show code and such")
//            print(list)
            self.codeView.isHidden = false
            self.allButton.isHidden = true
        }else{
            var currentList = "()00use)17BIO)18NAME)19DEF"
            globalList = (user?.uid)!+"()00use)17BIO)18NAME)19DEF"
            ref.child("users").child(viewer.vc4User).child("allowed").child((user?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                currentList = snapshot.value as? String ?? "()00use)17BIO)18NAME)19DEF"
                for all2 in self.scroller.subviews{
                    for all in all2.subviews{
                        if(all.accessibilityIdentifier != nil && all.accessibilityIdentifier! != "" && all.accessibilityLabel == "seth"){
                            // && all.alpha != 1.0
                            //                     print(all.alpha)
                            if(!currentList.contains(")"+all.accessibilityIdentifier!)){
                                currentList = currentList+")"+all.accessibilityIdentifier!
                                self.globalList = self.globalList+")"+all.accessibilityIdentifier!
                            }
                        }
                    }
                }
                print(currentList)
                (self.viewer.vc4 as! ViewController4).getCode.setTitle("Get Code", for: .normal)
                let alert = UIAlertController(title: "Vite Sent!", message: "Your contact information has been delivered.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.view.fadeOut()
                self.ref.child("users").child(self.viewer.vc4User).child("allowed").updateChildValues([(user?.uid)!: currentList])
                self.viewer.sendNotif(list: self.globalList)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("pedal4")
        let user = FIRAuth.auth()?.currentUser
        ref.child("users").child((user?.uid)!).child("info").observe(.value, with: { snapshot in
            self.checkList = [UIButton]()
            let enumerator = snapshot.children
            for all in self.scroller.subviews{
                all.removeFromSuperview()
            }
//            self.getCode.layer.cornerRadius = 5
//            self.getCode.layer.masksToBounds = true
            var count = 0
            var counter = 8
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                var res = ""
                if let result_number = (rest.value)! as? NSNumber
                {
                    res = "\(result_number)"
                }else{
                    res = rest.value as! String
                }
                let type = Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! - 20
                if(type >= 0){
                    let vw = (self.view.frame.width/375)
                    let vw2 = 101*vw
                    let vh = vw
                    let vh2 = vw2
                    let vh3 = vw2+20.0*(self.view.frame.height/667)
                let check = UIView(frame: CGRect(x: ((18.0*vw*CGFloat(count%3+1))+(vw2*CGFloat(count%3))), y: CGFloat(((137.0*vh*CGFloat(count/3))+3.0)), width: vw2, height: vh3))
                self.scroller.contentSize = CGSize(width: (self.view.frame.width), height: CGFloat((CGFloat((count+3)/3)*137.0*vh)+(49.0*vh)))
                    count += 1
//                check.backgroundColor = UIColor.green
                    let image = UIImageView(image: UIImage(named: self.arr2[type]))
                    image.frame = CGRect(x: 0.0, y: 0.0, width: vw2, height: vh2)
                    image.layer.cornerRadius = 8
                    image.layer.masksToBounds = true
//                    image.layer.cornerRadius = 5
                    let newOne = UIButton()
                    newOne.accessibilityHint = String(counter)
                    newOne.frame = CGRect(x: 0.0, y: 0.0, width: vw2, height: vh3)
                    newOne.layer.borderWidth = 0 //1
                    newOne.layer.cornerRadius = 8
//                    newOne.layer.borderColor = UIColor.white.cgColor
                    newOne.addTarget(self, action: #selector(self.checkIt), for: .touchUpInside)
                    self.checkList.append(newOne)
                    newOne.accessibilityLabel = "cole"
                    check.layer.cornerRadius = 8
                    check.layer.masksToBounds = true
                    let label = UILabel(frame: CGRect(x: 0.0, y: 104.0*vh, width: vw2, height: 14.0*vh))
//                    label.adjustsFontSizeToFitWidth = true
                    if([0, 10, 13, 15, 17, 22, 23].contains(type) && rest.key != "20MAIN"){
                    self.ref.child("users").child((user?.uid)!).child("info2").child(rest.key).observeSingleEvent(of: .value, with: { snapshot6 in
                            label.text = snapshot6.value as? String
                        })
                    }else{
                        label.text = res
                    }

                    label.textColor = UIColor.white
                    label.font = label.font.withSize(12)
                    label.textAlignment = .center
                    var checkThing = UIButton()
                    checkThing.frame = CGRect(x: 68.0*vw, y: 3.0, width: 30.0*vw, height: 30.0*vh)
                    checkThing.setBackgroundImage(UIImage(named: "check.png"), for: .normal)
                    checkThing.accessibilityHint = String(counter)
                    checkThing.isHidden = true
                    counter += 1
                    newOne.accessibilityIdentifier = rest.key
                    var bColor = UIColor.white
                    var tColor = UIColor.darkGray
//                    switch type {
//                    case 0:
//                        bColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
//                        tColor = UIColor.white
//                    case 1:
//                        bColor = UIColor(red: 2/255, green: 171/255, blue: 238/255, alpha: 1.0)
//                        tColor = UIColor.white
//                    case 2:
//                        bColor = UIColor(red: 40/255, green: 210/255, blue: 48/255, alpha: 1.0)
//                        tColor = UIColor.white
//                    case 3:
//                        bColor = UIColor(red: 255/255, green: 252/255, blue: 1/255, alpha: 1.0)
//                        tColor = UIColor.black
//                    case 4:
//                        bColor = UIColor(red: 255/255, green: 201/255, blue: 105/255, alpha: 1.0)
//                        tColor = UIColor.black
//                    default:
//                        bColor = UIColor.white
//                        tColor = UIColor.white
//                    }
                    check.backgroundColor = bColor
                    label.textColor = tColor
                    check.addSubview(image)
                    check.addSubview(label)
                    check.addSubview(newOne)
                    check.addSubview(checkThing)
                     self.scroller.addSubview(check)
                }
            }
        })
    }
    
    public func checkIt(sender: UIButton){
//        print("hey seth")
        let num = CGFloat(0.4)
        if(sender.accessibilityLabel == "seth"){
            for all in (sender.superview?.subviews)!{
//                print(sender.accessibilityHint ?? 1)
//                print(all.accessibilityHint ?? 1)
                if(all.accessibilityHint == sender.accessibilityHint && all != sender){
                    sender.backgroundColor = UIColor(red: num, green: num, blue: num, alpha: 0)
                    all.isHidden = true
                }
            }
            sender.accessibilityLabel = "cole"
        }else{
            for all in (sender.superview?.subviews)!{
//                print(sender.accessibilityHint ?? 1)
//                print(all.accessibilityHint ?? 1)
                if(all.accessibilityHint == sender.accessibilityHint && all != sender){
                    sender.backgroundColor = UIColor(red: num, green: num, blue: num, alpha: num+0.2)
                    all.isHidden = false
                }
            }
            sender.accessibilityLabel = "seth"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
