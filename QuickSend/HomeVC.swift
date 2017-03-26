//
//  HomeVC.swift
//  QuickSend
//
//  Created by Maahi on 12/03/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {

    var previousCheckedIndex = 0
    var friendsArray = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker.delegate = self
        
        if   self.LoadData(){
            
            tableView .reloadData()
        }
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
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
       // return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        
        
        return friendsArray.count
        //return 2
    }
    
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        // Configure Table View Cell
        configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
        return cell
       
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        
         cell.textLabel?.text = ((friendsArray.object(at: indexPath.row)) as! NSDictionary).value(forKey: "ReciName") as! String?
        
        /*if indexPath.row == 0 {
            if (friendsArray.count) > indexPath.section {
                cell.textLabel?.text = ((friendsArray.object(at: indexPath.section)) as! NSDictionary).value(forKey: "ReciName") as! String?
            }
        
        }else{

            if (friendsArray.count) > indexPath.section {
                cell.textLabel?.text = ((friendsArray.object(at: indexPath.section)) as! NSDictionary).value(forKey: "ReciEmail") as! String?
            }
        }*/
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       // let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        
            //tableView.cellForRow(at: IndexPath) as! UITableViewCell
       
       // if (indexPath.row != previousCheckedIndex) {
            var cell: UITableViewCell = tableView.cellForRow(at: indexPath)!
            if (cell.accessoryType == UITableViewCellAccessoryType.none) {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                
               // returnVal = (optionArray[indexPath.row] as? String)!
                
               /* if (previousCheckedIndex != indexPath.row) {
                    
                    cell = tableView.cellForRow(at: NSIndexPath(row : previousCheckedIndex, section: 0) as IndexPath)!
                    
                    cell.accessoryType = UITableViewCellAccessoryType.none
                    previousCheckedIndex = indexPath.row
                }*/
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            
            
       // }
        

    }
    
    
    
    func LoadData ()-> Bool{
        
        var returnval:Bool = false as Bool
        
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        let path  = documentsDirectory.appendingPathComponent("Friendinfo.plist")
        print("Path"+path)
        
        let fileManager = FileManager.default
        
        //check if file exists
        if(!fileManager.fileExists(atPath: path))
        {
            // If it doesn't, copy it from the default file in the Bundle
            
            if let bundlePath = Bundle.main.path(forResource: "Friendinfo", ofType: "plist")
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
        
        let resultArry = NSMutableArray(contentsOfFile: path)
        print("Loaded GameData.plist file is --> \(resultArry?.description)")
        let Array = NSArray(contentsOfFile: path)
        
        if (Array?.count)! > 0  {
            
            friendsArray = Array as! NSMutableArray;
            
            returnval = true
        }
        
        return returnval
    }


    
    
    
    
//Action buttons
    @IBAction func openCamera(_ sender: AnyObject) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OpenCamera") as? OpenCamera {
            //viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
        
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
     
        
        
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    
    
    
    
    
    @IBAction func openVideo(_ sender: AnyObject) {
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
