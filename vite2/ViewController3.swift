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

class ViewController3: UIViewController {
    
    var viewer = ViewController()
    @IBOutlet weak var profPic: UIImageView!
    let ref = FIRDatabase.database().reference()
    @IBOutlet weak var scroller: UIScrollView!
       var arr = [String]()
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scroller.contentSize = CGSize(width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        viewer.goBack(vc3: self)
    }
    
    func setupPerson(user: String){
        
        //delete all existing buttons
        for subs in scroller.subviews {
            if subs.tag != -1 {
                print(subs)
                subs.removeFromSuperview()
            }
        }
        
        scroller.bounces = true
        
        var counter = 0
        var place = 346
        arr = [String]()
        var fbTw = 0
        var temp = ""
        
        //load info for user you scanned from database
        ref.child("users").child(user).child("info").observeSingleEvent(of: .value, with: { snapshot in
//            print(snapshot.childrenCount) // I got the expected number of items
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                print("t")
                if(rest.key == "19DEF"){
                    temp = rest.value as! String
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
                print("r")
                if(Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! >= 20){
                    let button = UIButton()
//                    button.tag = 123
//                    button.frame = (frame: CGRect(x: xpx, y: ypx, width: ((Int(self.view.frame.size.width) - (18*4))/3), height: ((Int(self.view.frame.size.width) - (18*4))/3)))
                    
                    let thing = UIView()
                    thing.frame = CGRect(x: 0, y: place, width:Int(self.view.frame.size.width), height: 60)
//                    let mygray = UIColor.init(red: 167, green: 170, blue: 175, alpha: 1)
                    self.topView.addBottomBorderWithColor(color: UIColor.darkGray, width: 4)
                    place+=64
                    thing.backgroundColor = UIColor.lightGray
                   print("y")
                    thing.tag = counter
                    button.tag = counter
                    counter+=1;
                    
                    var imgString = ""
                    
                    let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "fbPage.png", "mail.png", "pint.png", "tumblr.png", "git.png", "plus.png"]
                    
                    let arr3: [String] = ["fb://profile/"+res, "twitter://user?screen_name="+res, "http://snapchat.com/", "http://snapchat.com/add/"+res, "instagram://user?username="+res, "fbPage", "mailto:"+res, "pinterest://user/"+res, "http://"+res+".tumblr.com", "https://github.com/"+res, "plus"]
                    
                    let numKey = Int(rest.key.substring(to: rest.key.index(rest.key.startIndex, offsetBy: 2)))! - 20
//                    print("fb://profile/"+res)
                    self.arr.append(arr3[numKey])
                    imgString = arr2[numKey]
                    
                    if(rest.key == "20MAIN" || rest.key == "21MAIN"){
                        print("piiiiiii")
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
                            print(dict2["url"] ?? 0)
                            self.profPic.setImageFromURl(stringImageUrl: (dict2["url"] as? String)!)
                        } catch let error {
                            print("Error: \(error)")
                        }
                    }
                        self.profPic.layer.cornerRadius = 10
                        self.profPic.layer.borderWidth = 2
                        self.profPic.layer.masksToBounds = true
                        self.profPic.layer.borderColor = UIColor.black.cgColor
                    }
                    
                    if(numKey < 3){
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
                    label.frame = CGRect(x: 64, y: 6, width: self.view.frame.size.width - 64 - 82, height: 48)
                    
                    label.font = UIFont(name: "Heiti TC", size: 20)
                    label.numberOfLines = 0
                    label.minimumScaleFactor = 0.1
                    label.baselineAdjustment = .alignCenters
//                    label.adjustsFontSizeToFitWidth = true
//                    label.backgroundColor = UIColor.green
                   
                    //label.textAlignment  = .center
                   // button.setImage(UIImage(named: imgString), for: UIControlState.normal)
                    //button.setTitleColor(UIColor.clear, for: .normal)
                    
                    button.backgroundColor = UIColor.yellow
                    button.frame = CGRect(x: (self.view.frame.size.width - 72), y: 10, width: 62, height: 40)
                    button.setTitle("View", for: .normal)
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.layer.cornerRadius = 10
                    button.layer.borderWidth = 1
                    button.layer.borderColor = UIColor.black.cgColor
                    button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                    thing.addSubview(button)
                    thing.addSubview(label)
                    thing.addSubview(imageView)
                    self.scroller.addSubview(thing)
                }else{
                   
                }
            }
             self.scroller.contentSize = CGSize(width: Int(self.view.frame.size.width), height: (Int(346+(64*counter))))
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
        print(arr[sender.tag])
        UIApplication.shared.open((URL(string: arr[sender.tag]))!
            , options: [:], completionHandler: nil)
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
