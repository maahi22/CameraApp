//
//  ViewController.swift
//  QuickSend
//
//  Created by Maahi on 14/12/16.
//  Copyright © 2016 Maahi. All rights reserved.
//

import UIKit
//import ConsstantAndMicro

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField?
    @IBOutlet weak var txtOfficeName: UITextField?
    @IBOutlet weak var txtOfficePhoneNumber: UITextField?
    @IBOutlet weak var txtEmailAdd: UITextField?
    @IBOutlet weak var txtAccountNo: UITextField?
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if   self.LoadData(){
           
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFriends") as? AddFriends {
                //viewController.newsObj = newsObj
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
            
            /*if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                //viewController.newsObj = newsObj
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }*/
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func clickNext(_ sender: AnyObject) {
        
        
        
        
        //if ConsstantAndMicro.isv
        
        if (txtName?.text?.characters.count)! > 0 && (txtOfficeName?.text?.characters.count)!>0 && (txtOfficePhoneNumber?.text?.characters.count)!>0 && (txtEmailAdd?.text?.characters.count)! > 0 && (txtAccountNo?.text?.characters.count)! > 0  {
            
            
            var name = "" as String
            name = (txtName?.text)!
            var officename = "" as String
             officename = (txtOfficeName?.text)!
            var phone = "" as String
             phone   = (txtOfficePhoneNumber?.text)!
            var email = "" as String
                email = (txtEmailAdd?.text)!
            var account = "" as String
                account = (txtAccountNo?.text)!
            
            
            
            //Strt
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            let documentsDirectory = paths[0] as! NSString
            let plistPath  = documentsDirectory.appendingPathComponent("userinfo.plist")
            
           // let dictionary = ["23": name, "56": ""] as NSMutableDictionary
            let dictionary = ["user_name": name, "user_offname": officename,"user_phNo": phone, "user_email": email,"user_AcNo": account] as NSMutableDictionary
            dictionary.write(toFile: plistPath, atomically: true)
            print("write")
            //END
            let resultDictionary = NSMutableDictionary(contentsOfFile: plistPath)
            print("Saved userinfo.plist file is --> \(resultDictionary?.description)")
            
            
            
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFriends") as? AddFriends {
                //viewController.newsObj = newsObj
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
            
            
            
        }else{
            // create the alert
            let alert = UIAlertController(title: "Alert", message: "Enter all Fields.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
        
    }
    
    
    
    
    func LoadData ()-> Bool{
        
        var returnval:Bool = false as Bool
        
        //let documentsPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String!
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        let path  = documentsDirectory.appendingPathComponent("userinfo.plist")
        print("Path"+path)
        
        let fileManager = FileManager.default
        
        //check if file exists
        if(!fileManager.fileExists(atPath: path))
        {
            // If it doesn't, copy it from the default file in the Bundle
            
            if let bundlePath = Bundle.main.path(forResource: "userinfo", ofType: "plist")
            {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle GameData.plist file is --> \(resultDictionary?.description)")
                
                do
                {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                    print("copy")
                }
                catch _
                {
                    print("error failed loading data")
                }
            }
            else
            {
                print("GameData.plist not found. Please, make sure it is part of the bundle.")
            }
        }
        else
        {
            print("GameData.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Loaded GameData.plist file is --> \(resultDictionary?.description)")
        let myDict = NSDictionary(contentsOfFile: path)
        
        if let dict = myDict {
            //loading values
            
            
            txtName?.text = dict.object(forKey: "user_name") as! String!
            txtOfficeName?.text = dict.object(forKey:"user_offname")  as? String
            txtOfficePhoneNumber?.text = dict.object(forKey:"user_phNo") as? String
            txtEmailAdd?.text = dict.object(forKey:"user_email") as? String
            txtAccountNo?.text = dict.object(forKey:"user_AcNo") as? String
            
            //...
            returnval = true
        }
        else
        {
            print("WARNING: Couldn't create dictionary from GameData.plist! Default values will be used!")
        }
        
        
       return returnval
    }
    
    
    
}





