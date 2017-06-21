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
    let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "fbPage.png", "mail.png", "pint.png", "tumblr.png", "git.png", "plus.png"]
    var list = ""
    
    
    @IBAction func closeIt(_ sender: Any) {
        self.view.isHidden = true
    }
    
    @IBAction func createCode(_ sender: Any) {
        print("send 'list' to qr code generator piece in this view controller (find in vc0 commented out) and change GUI accordingly to show code and such")
        print(list)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = FIRAuth.auth()?.currentUser
        list = "vite!-username//"+(user?.uid)!
        ref.child("users").child((user?.uid)!).child("info").observe(.value, with: { snapshot in
            let enumerator = snapshot.children
            for all in self.scroller.subviews{
                all.removeFromSuperview()
            }
            var count = 0
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
                    newOne.frame = CGRect(x: 0, y: 0, width: 101, height: 116)
                    newOne.layer.borderWidth = 1
                    newOne.layer.cornerRadius = 5
                    newOne.layer.borderColor = UIColor.white.cgColor
                    newOne.addTarget(self, action: #selector(self.checkIt), for: .touchUpInside)
                    check.layer.cornerRadius = 5
                    check.layer.masksToBounds = true
                    let label = UILabel(frame: CGRect(x: 0, y: 101, width: 101, height: 14))
                    label.adjustsFontSizeToFitWidth = true
                    label.text = res
                    label.textColor = UIColor.white
                    label.font = label.font.withSize(12)
                    label.textAlignment = .center
                    newOne.accessibilityIdentifier = rest.key
                    check.addSubview(image)
                    check.addSubview(label)
                    check.addSubview(newOne)
                     self.scroller.addSubview(check)
                }
            }
        })
    }
    
    public func checkIt(sender: UIButton){
        let num = CGFloat(0.77)
        if(sender.backgroundColor == UIColor(red: num, green: num, blue: num, alpha: 0.77)){
        sender.backgroundColor = UIColor(red: num, green: num, blue: num, alpha: 0.0)
            sender.setBackgroundImage(nil, for: .normal)
        }else{
            sender.backgroundColor = UIColor(red: num, green: num, blue: num, alpha: 0.77)
            sender.setBackgroundImage(UIImage(named: "checked.png"), for: .normal)
            list = list+")"+sender.accessibilityIdentifier!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
