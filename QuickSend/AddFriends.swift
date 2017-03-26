//
//  AddFriends.swift
//  QuickSend
//
//  Created by Maahi on 12/03/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit



class AddFriends: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableviewAdd: UITableView!
    var friendsArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

  
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        if   self.LoadData(){
            
            print(friendsArray)
            
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                //viewController.newsObj = newsObj
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
            
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
        return 5
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        // Configure Table View Cell
        configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
        return cell
        
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //        cell.textLabel?.text = incomeArray[indexPath.section] as? String
        //        return cell
    }
    
    func configureCell(cell: FriendsCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
       
        if indexPath.row == 0 {
        cell.textField.placeholder = "Recipeant name"
            if (friendsArray.count) > indexPath.section {
                cell.textField.text = ((friendsArray.object(at: indexPath.section)) as! NSDictionary).value(forKey: "ReciName") as! String?
            }
            
            
            
        }else{
           cell.textField.placeholder = "Email id"
            if (friendsArray.count) > indexPath.section {
               cell.textField.text = ((friendsArray.object(at: indexPath.section)) as! NSDictionary).value(forKey: "ReciEmail") as! String?
            }
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    @IBAction func SubmitInfo(_ sender: AnyObject) {
        
       // Friendinfo.plist
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        let plistPath  = documentsDirectory.appendingPathComponent("Friendinfo.plist")
        let fileManager = FileManager.default
        
        //check if file exists Delete
        do {
            if(fileManager.fileExists(atPath: plistPath)){
               try fileManager.removeItem(atPath: plistPath)
            }
        
        } catch {
            print("Could not clear temp folder: \(error)")
        }
        
        var array = NSMutableArray()
        
       
        for var i in (0..<3)//(tableviewAdd.visibleCells.count))
        {
            
            let indexPath  =  NSIndexPath(row: 0, section: i) as IndexPath //[NSIndexPath indexPathForRow:4 inSection:0]
            let cell = tableviewAdd.cellForRow(at: indexPath) as! FriendsCell
            
            let indexPath2  =  NSIndexPath(row: 1, section: i) as IndexPath //[NSIndexPath indexPathForRow:4 inSection:0]
            let cell2 = tableviewAdd.cellForRow(at: indexPath2) as! FriendsCell
            
            if((cell2.textField.text?.characters.count)! > 0 && (cell.textField.text?.characters.count)! > 0){
                
                
                let dict = NSMutableDictionary()
                dict.setValue(cell.textField.text, forKey: "ReciName")
                dict.setValue(cell2.textField.text, forKey: "ReciEmail")
                array.add(dict)
            }
            
            
        }

        print(array)
        
        if array.count > 0 {
            
            
             array.write(toFile: plistPath, atomically: true)
        }
        
        
        
        
    }
    
    
    
    
    //Read Plist
    func LoadData ()-> Bool{
        
        var returnval:Bool = false as Bool
        
        //let documentsPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String!
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

}
