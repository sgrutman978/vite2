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
    @IBOutlet weak var closeAll: UIButton!
    @IBOutlet weak var choseLabel: UILabel!
    let arr2: [String] = ["fb.png", "twitter.jpg", "phone.png", "snap.jpg", "insta.jpg", "fbPage.png", "mail.png", "pint.png", "tumblr.png", "git.png", "plus.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var count = 0
        ref.child("users").child("tgCZNjvGzWgbUXIAuAeCAdinJDr2").child("info").observe(.value, with: { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                let check:checkBox = checkBox(frame: CGRect(x: (15*(count%3+1))+(100*(count%3)), y: 15+(135*(count/3)), width: 100, height: 120))
                count += 1
                check.backgroundColor = UIColor.green
                self.scroller.addSubview(check)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



public class checkBox: UIView {
    
    let image:UIImageView = UIImageView()
    let label:UILabel = UILabel()
    let checked:Bool = false
    
    func setShit(image: String, label: String){
        self.image.image = UIImage(named: image)
        self.label.text = label
//        self.backgroundColor = UIColor.green
    }
    
    
    
}
