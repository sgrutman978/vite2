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

    @IBOutlet weak var getCode: UIButton!
    let ref = FIRDatabase.database().reference()
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var myCode: UIImageView!
    @IBOutlet weak var closeCode: UIButton!
    @IBOutlet weak var choseLabel: UILabel!
    let myString = "http://www.appstore.com/stevengrutman/speedsquare#"
    var viewer = ViewController()
    var viewer3 = ViewController3()
    let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "fbPage.png", "mail.png", "pint.png", "tumblr.png", "git.png", "plus.png", "skype.jpg", "reddit.jpg", "stack.png", "youtube.png", "yelp.png", "venmo.png", "linkedin.jpg", "dribbble.jpg", "peri.png", "500px.png", "myspace.png", "spotify.png"]
    var list = ""
    
    
    @IBAction func closeCode(_ sender: Any) {
        codeView.isHidden = true
    }
    
    @IBAction func closeIt(_ sender: Any) {
        self.view.isHidden = true
    }
    
    @IBAction func createCode(_ sender: Any) {
        createHelp(mode: viewer.modeVc4)
    }
    func createHelp(mode: Int){
        let user = FIRAuth.auth()?.currentUser
        
        if(mode == 0){
            list = myString+(user?.uid)!+"()00use)17BIO)18NAME)19DEF"
            for all2 in scroller.subviews{
                for all in all2.subviews{
                    if(all.accessibilityIdentifier != nil && all.accessibilityIdentifier! != "" && all.accessibilityLabel == "seth"){
                        // && all.alpha != 1.0
                        //                     print(all.alpha)
                        list = list+")"+all.accessibilityIdentifier!
                    }
                }
            }
            var qrcodeImage: CIImage!
            let data = list.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
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
            colorFilter.setValue(CIColor.black(), forKey: "inputColor0")
            colorFilter.setValue(transparentBG, forKey: "inputColor1")
            qrcodeImage = colorFilter.outputImage!
            
            myCode.image = UIImage(ciImage: qrcodeImage)
            let scaleX = myCode.frame.size.width / qrcodeImage.extent.size.width
            let scaleY = myCode.frame.size.height / qrcodeImage.extent.size.height
            let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
            myCode.image = UIImage(ciImage: transformedImage)
            
            codeView.layer.cornerRadius = 50
            codeView.layer.borderWidth = 2
            codeView.layer.masksToBounds = true
            codeView.layer.borderColor = UIColor.black.cgColor
            
//            print("send 'list' to qr code generator piece in this view controller (find in vc0 commented out) and change GUI accordingly to show code and such")
//            print(list)
            self.codeView.isHidden = false
        }else{
            var currentList = "()00use)17BIO)18NAME)19DEF"
            ref.child("users").child(viewer.vc4User).child("allowed").child((user?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                currentList = snapshot.value as? String ?? "()00use)17BIO)18NAME)19DEF"
                for all2 in self.scroller.subviews{
                    for all in all2.subviews{
                        if(all.accessibilityIdentifier != nil && all.accessibilityIdentifier! != "" && all.accessibilityLabel == "seth"){
                            // && all.alpha != 1.0
                            //                     print(all.alpha)
                            if(!currentList.contains(")"+all.accessibilityIdentifier!)){
                                currentList = currentList+")"+all.accessibilityIdentifier!
                            }
                        }
                    }
                }
                print(currentList)
                self.ref.child("users").child(self.viewer.vc4User).child("allowed").updateChildValues([(user?.uid)!: currentList])
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = FIRAuth.auth()?.currentUser
        ref.child("users").child((user?.uid)!).child("info").observe(.value, with: { snapshot in
            let enumerator = snapshot.children
            for all in self.scroller.subviews{
                all.removeFromSuperview()
            }
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
                let check = UIView(frame: CGRect(x: (18*(count%3+1))+(101*(count%3)), y: (134*(count/3)), width: 101, height: 116))
                self.scroller.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(((count+3)/3)*134)+47)
                    count += 1
//                check.backgroundColor = UIColor.green
                    let image = UIImageView(image: UIImage(named: self.arr2[type]))
                    image.frame = CGRect(x: 0, y: 0, width: 101, height: 101)
//                    image.layer.cornerRadius = 5
                    let newOne = UIButton()
                    newOne.accessibilityHint = String(counter)
                    newOne.frame = CGRect(x: 0, y: 0, width: 101, height: 116)
                    newOne.layer.borderWidth = 1
                    newOne.layer.cornerRadius = 5
//                    newOne.layer.borderColor = UIColor.white.cgColor
                    newOne.addTarget(self, action: #selector(self.checkIt), for: .touchUpInside)
                    newOne.accessibilityLabel = "cole"
                    check.layer.cornerRadius = 5
                    check.layer.masksToBounds = true
                    let label = UILabel(frame: CGRect(x: 0, y: 101, width: 101, height: 14))
                    label.adjustsFontSizeToFitWidth = true
                    label.text = res
                    label.textColor = UIColor.white
                    label.font = label.font.withSize(12)
                    label.textAlignment = .center
                    var checkThing = UIButton()
                    checkThing.frame = CGRect(x: 68, y: 3, width: 30, height: 30)
                    checkThing.setBackgroundImage(UIImage(named: "check.png"), for: .normal)
                    checkThing.accessibilityHint = String(counter)
                    checkThing.isHidden = true
                    counter += 1
                    newOne.accessibilityIdentifier = rest.key
                    var bColor = UIColor.white
                    var tColor = UIColor.white
                    switch type {
                    case 0:
                        bColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
                        tColor = UIColor.white
                    case 1:
                        bColor = UIColor(red: 2/255, green: 171/255, blue: 238/255, alpha: 1.0)
                        tColor = UIColor.white
                    case 2:
                        bColor = UIColor(red: 40/255, green: 210/255, blue: 48/255, alpha: 1.0)
                        tColor = UIColor.white
                    case 3:
                        bColor = UIColor(red: 255/255, green: 252/255, blue: 1/255, alpha: 1.0)
                        tColor = UIColor.black
                    case 4:
                        bColor = UIColor(red: 255/255, green: 201/255, blue: 105/255, alpha: 1.0)
                        tColor = UIColor.black
                    default:
                        bColor = UIColor.white
                        tColor = UIColor.white
                    }
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
