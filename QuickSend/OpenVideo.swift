//
//  OpenVideo.swift
//  QuickSend
//
//  Created by Maahi on 13/03/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AVKit



class OpenVideo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       // self.playVideo()
        
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
    
    
    
    
    
    
    @IBAction func playVideo(_ sender: AnyObject) {
        if let documentDirectories: AnyObject = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as AnyObject?
        {
        let documentsFileName = (documentDirectories as! String)  + ("/vid1.mp4")
        let fileManager = FileManager.default
        //check if file exists Delete
        if(fileManager.fileExists(atPath: documentsFileName)){
                self.playVideo()
            }
        }
    }
    
    
    
    
    
    
    func playVideo() {
        
        if let documentDirectories: AnyObject = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as AnyObject?
        {
            //let dataPath = documentsDirectory.appendingPathComponent("/vid1.mp4")
            let documentsFileName = (documentDirectories as! String)  + ("/vid1.mp4")
            debugPrint(documentsFileName, terminator: "")
            
            let path:NSURL = NSURL.fileURL(withPath: documentsFileName, isDirectory: false) as NSURL;
            //_player = AVPlayer(URL: path);
            
          let  videoPlayer = AVPlayer(url: path as URL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = videoPlayer
            NotificationCenter.default.addObserver(self, selector: Selector(("playerDidReachEndNotificationHandler:")), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer.currentItem)
            self.present(playerViewController, animated: true)
            {
                playerViewController.player!.play()
            }
            //- See more at: http://www.theappguruz.com/blog/play-audio-and-video-using-avfoundation-framework-in-swift#sthash.pdHp9yEV.dpuf
            
            // startMediaBrowserFromViewController(viewController: self, usingDelegate: self)
            
        }

        
        
        }
        
        
        
    
    
    
    
    
    
    
    
    
    func startMediaBrowserFromViewController(viewController: UIViewController, usingDelegate delegate: protocol<UINavigationControllerDelegate, UIImagePickerControllerDelegate>) -> Bool {
        // 1
    
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
            return false
        }
        
        // 2
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .savedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as NSString as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        
        // 3
        present(mediaUI, animated: true, completion: nil)
        return true
    }

    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func proceedClick(_ sender: AnyObject) {
        
        
        
    }
    
    
    

    @IBAction func recordingClick(_ sender: AnyObject) {
        
        startCameraFromViewController(viewController: self, withDelegate: self)
        
        
    }
    
    func startCameraFromViewController(viewController: UIViewController, withDelegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool {
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            return false
        }
        
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.mediaTypes = [kUTTypeMovie as NSString as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        present(cameraController, animated: true, completion: nil)
        return true
    }
    
    func video(videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
        var title = "Success"
        var message = "Video was saved"
        if let _ = error {
            title = "Error"
            message = "Video failed to save"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toAddComment"{
            if let nextViewController = segue.destination as? AddComment{
                nextViewController.image1 = nil
                nextViewController.status = false
            }
            
        }
        
    }
    
    
    
    
    
}


// MARK: - UIImagePickerControllerDelegate

/*extension OpenVideo: UIImagePickerControllerDelegate {
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // 1
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        // 2
        dismiss(animated: true) {
            // 3
            if mediaType == kUTTypeMovie {
                let moviePlayer = MPMoviePlayerViewController(contentURL: (info[UIImagePickerControllerMediaURL] as! NSURL) as URL!)
                self.presentMoviePlayerViewControllerAnimated(moviePlayer)
            }
        }
    }
}*/

// MARK: - UINavigationControllerDelegate

extension OpenVideo: UINavigationControllerDelegate {
}



// MARK: - UIImagePickerControllerDelegate

extension OpenVideo: UIImagePickerControllerDelegate {
   
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        
       /* let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismiss(animated: true, completion: nil)
        // Handle a movie capture
        if mediaType == kUTTypeMovie {
           
            
            
            
            
           /* guard let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path else { return }
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, #selector(OpenVideo.video(_:didFinishSavingWithError:contextInfo:)), nil)
            }*/
        }*/
        
        
        let videoURL = info[UIImagePickerControllerMediaURL] as! NSURL
        let videoData = NSData(contentsOf: videoURL as URL)
        //let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        //let documentsDirectory: AnyObject = paths[0] as AnyObject
        if let documentDirectories: AnyObject = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as AnyObject?
        {
        //let dataPath = documentsDirectory.appendingPathComponent("/vid1.mp4")
        let documentsFileName = (documentDirectories as! String)  + ("/vid1.mp4")
        debugPrint(documentsFileName, terminator: "")
        videoData?.write(toFile: documentsFileName, atomically: false)
            
        }
        
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
}

// MARK: - UINavigationControllerDelegate




