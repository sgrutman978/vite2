//
//  ViewController2.swift
//  vite2
//
//  Created by Steven Grutman on 1/17/17.
//  Copyright © 2017 Steven Grutman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ViewController2: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var favs: UIScrollView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    let ref = FIRDatabase.database().reference()
    var counter = 0
    var place = 0
    var user = ""
    var favoritesPlace = 10
    var arr2 = [String]()
    var viewer = ViewController()
    var viewer3 = ViewController3()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.hideKeyboardWhenTappedAround()
        searchBar.delegate = self
//        print("uuuu")
        setupList()
            }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        dismissKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
//        print(searchBar.text!)
        var pos = 0
        var moves: [UIView] = []
        for subs in self.scroller.subviews {
            if(subs.accessibilityLabel != nil){
                moves.append(subs)
            }
        }
        let movies = moves.sorted(by: { $0.accessibilityIdentifier! < $1.accessibilityIdentifier! })
        for all in movies{
            if(searchBar.text! == "" || (all.accessibilityIdentifier?.contains((searchBar.text?.lowercased())!))!){
                all.isHidden = false
                all.frame.origin.y = CGFloat(pos)
                pos += 90
            }else{
                all.isHidden = true
            }
        }
    }
    
    func addDude(user: String){
        self.ref.child("users").child(self.user).child("allowed").child(user).observeSingleEvent(of: .value, with: { snapshot in
            self.addPerson(rest: snapshot)
        })
    }
    
    func setupList() {
        //load info for user you scanned from database
//        print("ululul")
    ref.child("users").child(user).child("allowed").observe(.value, with: { snapshot in
        var arr = [String]()
        for subs in self.favs.subviews {
            arr.append(subs.accessibilityIdentifier! as String)
        }
//        print(arr)
//        print("doggy")
        let enumerator = snapshot.children
        while let rest = enumerator.nextObject() as? FIRDataSnapshot {
            var res = ""
            if let result_number = (rest.value)! as? NSNumber
            {
                res = "\(result_number)"
            }else{
                res = rest.value as! String
            }
            if(res.characters.first == "a"){
                self.arr2.append(rest.key)
            }
            //work out deleting stuffs
             self.favoritesPlace = 10
        for subs in self.favs.subviews {
//            print("dsdsds")
//            print(rest.key)
            if subs.accessibilityIdentifier! as String == rest.key && arr.contains(rest.key) && res.characters.first == "a" {
//                print("yuyuyu")
                arr.remove(at: arr.index(of: rest.key)!)
            }
        }
//        print("lklklklk")
             if(res.characters.first == "a"){
//                print(rest.key)
                var fbTw = 0
                self.ref.child("users").child(rest.key).child("info").child("00use").observeSingleEvent(of: .value, with: { snapshot6 in
                    if(snapshot6.value as! String == "tw"){
                    fbTw = 1
                    }
                })
        self.ref.child("users").child(rest.key).child("info").child("19DEF").observeSingleEvent(of: .value, with: { snapshot2 in
            var arr2 = [String]()
            for subs in self.favs.subviews {
                arr2.append(subs.accessibilityIdentifier! as String)
            }
           
            if(!arr2.contains(rest.key)){
            let imageView2 = UIImageView()
            imageView2.frame = CGRect(x: self.favoritesPlace, y: 10, width: 70, height: 70)
            let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
                imageView2.isUserInteractionEnabled = true
            gesture.accessibilityLabel = rest.key
            imageView2.addGestureRecognizer(gesture)
//            print(self.favoritesPlace)
            
            imageView2.accessibilityIdentifier = rest.key
            imageView2.layer.cornerRadius = 35
//            imageView2.layer.borderWidth = 1
            imageView2.layer.masksToBounds = true
//            imageView2.layer.borderColor = UIColor.black.cgColor
                
                if(fbTw == 0){
                    imageView2.setImageFromURl(stringImageUrl: (self.getProfPic(mode: 0, myURLString: "http://graph.facebook.com/"+(snapshot2.value as! String)+"/picture?type=large&redirect=false")))
                }else{
                    imageView2.setImageFromURl(stringImageUrl: (self.getProfPic(mode: 1, myURLString: snapshot2.value as! String)))
                }
            
            self.favs.addSubview(imageView2)
                var duplicateFavPlace = 80*self.favs.subviews.count - 70
                self.favs.contentSize = CGSize(width: duplicateFavPlace+80, height: 90)
                for subs in self.favs.subviews {
                    if(Int(subs.frame.origin.x) != duplicateFavPlace){
                        subs.frame.origin.x = CGFloat(duplicateFavPlace)
                    }
                    duplicateFavPlace = duplicateFavPlace - 80
                }

                self.favoritesPlace = self.favoritesPlace + 80
            }
        })
            }
        }
//print(arr)
        for subs in self.favs.subviews {
            if(arr.contains(subs.accessibilityIdentifier! as String)){
                subs.removeFromSuperview()
            }
        }
        var duplicateFavPlace = 80*self.favs.subviews.count - 70
        self.favs.contentSize = CGSize(width: duplicateFavPlace+80, height: 90)
        for subs in self.favs.subviews {
            if(Int(subs.frame.origin.x) != duplicateFavPlace){
                subs.frame.origin.x = CGFloat(duplicateFavPlace)
            }
            duplicateFavPlace = duplicateFavPlace - 80
        }
        })
        
        self.ref.child("users").child(self.user).child("allowed").observe(.value, with: { snapshot in
            //            let enumerator2 = snapshot.children
            //            var arr5: [String] = []
            //            var arr6: [String] = []
            //            while let rest = enumerator2.nextObject() as? FIRDataSnapshot {
            //                arr5.append(rest.key)
            //            }
            //        self.counter = 0
            //        self.place = 0
            //        for subs in self.scroller.subviews {
            //            if(subs.accessibilityLabel != nil && !arr5.contains(subs.accessibilityLabel!)){
            //                print("helooorty")
            //                subs.removeFromSuperview()
            //            }else{
            //                if(subs.accessibilityLabel != nil){
            //                    arr6.append(subs.accessibilityLabel!)
            //                    subs.frame.origin.y = CGFloat(self.place)
            //                    self.place += 94
            //                }
            //            }
            //        }
            
            
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                //                print("ololol")
                //                print(rest.key)
                //                print(arr6)
                //                if(!arr6.contains(rest.key)){
                self.addPerson(rest: rest)
                //            }
            }
            self.loader.isHidden = true
        })
        
//        self.ref.child("users").child(user).child("allowed").observeSingleEvent(of: .value, with: { snapshot in
//            
//            //delete all existing buttons
//            self.counter = 0
//            self.place = 0
//            for subs in self.scroller.subviews {
//                if subs.tag != -1 {
//                    //                    print(subs)
//                    subs.removeFromSuperview()
//                }
//            }
        
//print("ililil")
    }
    
    func reorder(){
                self.counter = 0
                self.place = 0
        var moves: [UIView] = []
        for subs in self.scroller.subviews {
            if(subs.accessibilityLabel != nil){
                moves.append(subs)
            }
        }
        let movies = moves.sorted(by: { $0.accessibilityIdentifier! < $1.accessibilityIdentifier! })
                for subs in movies {
                            subs.frame.origin.y = CGFloat(self.place)
//                    if(self.place == 0){
//                        for all in subs.subviews{
//                            if (all.accessibilityLabel == "value"){
//                                all.frame.origin.y = -3
//                                all.frame = CGRect(x: all.frame.origin.x, y: all.frame.origin.y, width: all.frame.width, height: all.frame.height+3)
//                            }
//                        }
//                    }
                            self.place += 90
                }
    }
    
    
    func addPerson(rest: FIRDataSnapshot){
        var check = true
        for subs in self.scroller.subviews {
            if(subs.accessibilityLabel != nil && rest.key == subs.accessibilityLabel!){
                check = false
                break
            }
        }
        if(check){
//            print("klklkl")
        let thing = UIScrollView()
        thing.frame = CGRect(x: 0, y: self.place, width:Int(self.view.frame.size.width)+1, height: 90)
        //                    let mygray = UIColor.init(red: 167, green: 170, blue: 175, alpha: 1)
        //                    self.topView.addBottomBorderWithColor(color: UIColor.darkGray, width: 4)
        self.place+=90
//        thing.backgroundColor = UIColor.clear
//            thing.addBottomBorderWithColor(color: UIColor.black, width: 1)
            let grayLine = UIView()
            grayLine.frame = CGRect(x: 90, y: thing.frame.height-1, width: thing.frame.width, height: 1)
            grayLine.backgroundColor = UIColor.lightGray
            thing.addSubview(grayLine)
        //                    print("y")
        thing.tag = self.counter
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        gesture.accessibilityLabel = rest.key
        thing.addGestureRecognizer(gesture)
        thing.accessibilityLabel = rest.key
        //                    button.tag = counter
        self.counter+=1;
        
        //NEED TO GET THE INFO FROM THIS USER WITH A REF2
        //                print("pizzasss")
        //                print(rest.key)
        self.ref.child("users").child(rest.key).child("info").child("00use").observeSingleEvent(of: .value, with: { snapshot5 in
            
            self.ref.child("users").child(rest.key).child("info").child("19DEF").observeSingleEvent(of: .value, with: { snapshot2 in
                
                self.ref.child("users").child(rest.key).child("info").child("18NAME").observeSingleEvent(of: .value, with: { snapshot3 in
                    
                    self.ref.child("users").child(rest.key).child("info").child("17BIO").observeSingleEvent(of: .value, with: { snapshot4 in
                        
                        let imageView = UIImageView()
                        imageView.frame = CGRect(x: 11, y: 10, width: 70, height: 70)
                        imageView.layer.cornerRadius = 35
//                        imageView.layer.borderWidth = 1
                        imageView.layer.masksToBounds = true
//                        imageView.layer.borderColor = UIColor.black.cgColor
                        
                        if(snapshot2.value as? String != nil){
                            if(snapshot5.value as! String == "fb"){
                                imageView.setImageFromURl(stringImageUrl: (self.getProfPic(mode: 0, myURLString: "http://graph.facebook.com/"+(snapshot2.value as! String)+"/picture?type=large&redirect=false")))
                            }else{
                                imageView.setImageFromURl(stringImageUrl: (self.getProfPic(mode: 1, myURLString: snapshot2.value as! String)))
                            }
                        }
                        
                        let label = UILabel()
                        if(snapshot3.value != nil){
                            label.text = snapshot3.value as? String
                            thing.accessibilityIdentifier = (snapshot3.value as? String)?.lowercased()
                        }
                        label.frame = CGRect(x: 90, y: 3, width: self.view.frame.size.width - 90 - 82, height: 48)
                        
                        label.font = UIFont(name: "Heiti TC", size: 20)
                        
                        let label2 = UILabel()
                        if(snapshot4.value != nil){
                            label2.text = snapshot4.value as? String
                        }
                        label2.frame = CGRect(x: 90, y: 35, width: self.view.frame.size.width - 90 - 82, height: 48)
                        
                        label2.font = UIFont(name: "Heiti TC", size: 16)
                        
                        let button2 = UIButton()
                        //red X button
//                        button2.frame = CGRect(x: self.view.frame.width - 135, y: 15, width: 20, height: 20)
                        button2.frame = CGRect(x: self.view.frame.width+1, y: 0, width: thing.frame.width/4 + 1, height: thing.frame.height-1)
                        button2.setTitle("Delete", for: .normal)
                        button2.accessibilityIdentifier = rest.key
                        button2.accessibilityLabel = "value"
                        button2.backgroundColor = UIColor.red
                        button2.setTitleColor(UIColor.white, for: .normal)
//                        button2.layer.cornerRadius = 15
                        button2.layer.borderWidth = 0
                        button2.layer.masksToBounds = true
                        button2.layer.borderColor = UIColor.black.cgColor
//                        button2.addBottomBorderWithColor(color: UIColor.black, width: 1)
                        button2.addTarget(self, action: #selector(self.removePerson), for: .touchUpInside)
                        
//                        thing.addSubview(button2)
                        
                        //            label.numberOfLines = 0
                        //            label.minimumScaleFactor = 0.1
                        //            label.baselineAdjustment = .alignCenters
                        //UP TO HERE IS WHAT WAS WORKING BEFORE to verticaly center
                        //                    label.adjustsFontSizeToFitWidth = true
                        //                    label.backgroundColor = UIColor.green
                        
                        //label.textAlignment  = .center
                        // button.setImage(UIImage(named: imgString), for: UIControlState.normal)
                        //button.setTitleColor(UIColor.clear, for: .normal)
                        let button = UIButton()
                        button.accessibilityIdentifier = rest.key
                        //            button.backgroundColor = UIColor.yellow
                        var res = ""
                        if let result_number = (rest.value)! as? NSNumber
                        {
                            res = "\(result_number)"
                        }else{
                            res = rest.value as! String
                        }
                        var temp = UIImage()
                        if(res.characters.first == "a"){
                            temp = UIImage.init(named: "starYellow.png")!
                        }else{
                            temp = UIImage.init(named: "starClear.png")!
                        }
                        button.setImage(temp, for: .normal)
                        button.frame = CGRect(x: self.view.frame.size.width - 60, y: 25, width: 40, height: 40)
                        //            button.setTitle("View", for: .normal)
                        //            button.setTitleColor(UIColor.black, for: .normal)
                        //            button.layer.cornerRadius = 10
                        //            button.layer.borderWidth = 1
                        //            button.layer.borderColor = UIColor.black.cgColor
                        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                        
                        
                        thing.isPagingEnabled = true
                        thing.contentSize = CGSize(width: thing.frame.width + thing.frame.width/4, height: thing.frame.height)
                        
                        thing.bounces = false
                        thing.showsHorizontalScrollIndicator = false
                        
                        thing.addSubview(button)
                        thing.addSubview(label)
                        thing.addSubview(label2)
                        thing.addSubview(imageView)
                        thing.addSubview(button2)
//                        print("plplplpl")
                        self.scroller.addSubview(thing)
                        self.reorder()
                        print("fuck thissss")
                        print(90*self.scroller.subviews.count)
                        self.scroller.contentSize = CGSize(width: Int(self.view.frame.size.width)+1, height: (Int(90*self.scroller.subviews.count-90)))
                    })
                })
            })
        })
        }
        
    }
    
    func removePerson(sender: UIButton!){
//            let refreshAlert = UIAlertController(title: "Remove Service", message: "Would you like to remove this social media platform from your profile?", preferredStyle: UIAlertControllerStyle.alert)
//            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                let user = FIRAuth.auth()?.currentUser
                self.ref.child("users").child((user?.uid)!).child("allowed").child(sender.accessibilityIdentifier!).removeValue()
//  DONT ADD              self.arr2.remove(at: self.arr2.index(of: sender.accessibilityIdentifier!)!)
                sender.superview?.removeFromSuperview()
                self.reorder()
//            }))
//            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//                print("cancled remove")
//            }))
//            present(refreshAlert, animated: true, completion: nil)
    }
    
    func someAction(_ sender:UITapGestureRecognizer){
//        print("alalal")
        viewer3.view.isHidden = false
        viewer3.view.alpha = 1
        var frame2 = self.view.frame
        frame2.origin.x = self.view.frame.size.width * 2
        viewer3.view.frame = frame2
        viewer.addPerson(mode: 1, vc3: viewer3, uid: sender.accessibilityLabel!, acc: "")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//        print(sender.accessibilityIdentifier! as String)
        var temp = UIImage()
        if(sender.image(for: .normal) == UIImage.init(named: "starYellow.png")){
            temp = UIImage.init(named: "starClear.png")!
        }else{
            temp = UIImage.init(named: "starYellow.png")!
        }
        sender.setImage(temp, for: .normal)
        ref.child("users").child(user).child("allowed").child(sender.accessibilityIdentifier! as String).observeSingleEvent(of: .value, with: { snapshot in
//            print(snapshot.value as! String)
            var res = ""
            if let result_number = (snapshot.value)! as? NSNumber
            {
                res = "\(result_number)"
            }else{
                res = snapshot.value as! String
            }

            if(res.characters.first == "("){
                let outputString = "a" + String(res.characters.dropFirst())
                 self.ref.child("users").child(self.user).child("allowed").updateChildValues([sender.accessibilityIdentifier! as String: outputString])
            }else{
                let outputString = "(" + String(res.characters.dropFirst())
                self.ref.child("users").child(self.user).child("allowed").updateChildValues([sender.accessibilityIdentifier! as String: outputString])
            }
        })
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
