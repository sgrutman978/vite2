//
//  ViewController1.swift
//  vite2
//
//  Created by Steven Grutman on 1/17/17.
//  Copyright © 2017 Steven Grutman. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class ViewController1: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

//    @IBOutlet var messageLabel:UILabel!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
//    var qrCodeFrameView:UIView?
    
    @IBOutlet weak var icon4: UIButton!
    @IBOutlet weak var icon1: UIButton!
    @IBOutlet weak var icon2: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var viewer = ViewController()
    var viewer0 = ViewController0()
    var viewer3 = ViewController3()
    var viewer4 = ViewController4()
    var allowed = true
    
    @IBAction func showCode(_ sender: Any) {
        viewer4.view.isHidden = false
        viewer4.view.alpha = 1.0
        viewer4.getCode.setTitle("Get Code", for: .normal)
        viewer.modeVc4 = 0
        //        self.view.isHidden = true
    }
    @IBAction func moveLeft(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.viewer.scrollView.contentOffset.x = 0
        }, completion: nil)
    }
    @IBAction func moveRight(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.viewer.scrollView.contentOffset.x = self.view.frame.width * 2
        }, completion: nil)
    }
    
//    @IBAction func showSettings(_ sender: Any) {
//        viewer0.view.isHidden = false
////        self.view.isHidden = true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("lllrrr")
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
//            view.bringSubview(toFront: messageLabel)
            view.bringSubview(toFront: icon1)
             view.bringSubview(toFront: icon2)
             view.bringSubview(toFront: icon4)
//            viewer.scrollView.bringSubview(toFront: viewer3.view)
            
           
            
            // Initialize QR Code Frame to highlight the QR code
//            qrCodeFrameView = UIView()
//            
//            if let qrCodeFrameView = qrCodeFrameView {
//                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
//                qrCodeFrameView.layer.borderWidth = 2
//                view.addSubview(qrCodeFrameView)
//                view.bringSubview(toFront: qrCodeFrameView)
//            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if(viewer.returnPage() == CGPoint(x: self.view.frame.size.width, y: 0) && allowed){
            allowed = false
            viewer3.view.isHidden = false
            viewer3.view.alpha = 1
            viewer.scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
//            qrCodeFrameView?.frame = CGRect.zero
//            messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
//            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
//                messageLabel.text = metadataObj.stringValue
                let myString = "http://www.appstore.com/stevengrutman/speedsquare#"
                let index: String.Index = metadataObj.stringValue.index(metadataObj.stringValue.startIndex, offsetBy: myString.characters.count)
//                print("helllooooodsfgdgsdgs")
                if metadataObj.stringValue.substring(to: index) == myString {
                    let index2: String.Index = metadataObj.stringValue.index(metadataObj.stringValue.startIndex, offsetBy: 28)
                    let index3: String.Index = metadataObj.stringValue.index(metadataObj.stringValue.startIndex, offsetBy: myString.characters.count + 28)
                    let username = metadataObj.stringValue.substring(from: index).substring(to: index2)
                    let accounts = metadataObj.stringValue.substring(from: index3)
//                    print(username)
                    var frame1 = self.view.frame
                    frame1.origin.x = self.view.frame.size.width * 1
                    viewer3.view.frame = frame1
                    viewer.addPerson(mode: 0, vc3: viewer3, uid: username, acc: accounts)
//                    print("falseStuff")
                     Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.reAllow), userInfo: nil, repeats: false)
            }
        }
    }
        }
    }
    
    func reAllow(){
        allowed = true
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
