//
//  OpenCamera.swift
//  QuickSend
//
//  Created by Maahi on 13/03/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class OpenCamera: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        
        
        
        
        imagePicker.delegate = self
       
        if imagePicker.sourceType == .camera {
            imagePicker.sourceType = .camera
           
            
            
            present(imagePicker, animated: true, completion: nil)
        }else{
           // imagePicker.sourceType = .savedPhotosAlbum
           
            
            
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
            
            
        }
        
        
        // Do any additional setup after loading the view.
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
    
    
    
    
    //MARK: - Delegates
   
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .scaleAspectFit //3
        myImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    
    
    
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    

    
    @IBAction func NextPhoto(_ sender: AnyObject) {
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, myImageView.bounds, nil)
        UIGraphicsBeginPDFPage()
        
        let pdfContext = UIGraphicsGetCurrentContext()
        
        if (pdfContext == nil)
        {
            return
        }
        
        myImageView.layer.render(in: pdfContext!)
        UIGraphicsEndPDFContext()
        
        if let documentDirectories: AnyObject = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as AnyObject?
        {
            let documentsFileName = (documentDirectories as! String)  + ("/demo.pdf")
            debugPrint(documentsFileName, terminator: "")
            pdfData.write(toFile: documentsFileName, atomically: true)
        }
        

        
    }
    
    
    
    @IBAction func Proceed(_ sender: AnyObject) {
        
        
        
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toAddComment"{
            if let nextViewController = segue.destination as? AddComment{
                nextViewController.image1 = myImageView.image
            }
            
        }
        
    }
    
    

}
