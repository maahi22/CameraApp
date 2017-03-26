//
//  AddComment.swift
//  QuickSend
//
//  Created by Maahi on 13/03/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import MessageUI
import Messages






class AddComment: UIViewController {

    var image1:UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
    func genPdf() {
        
        let fileName = "demo.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        
        let fileManager = FileManager.default
        
        let pdfPath  = documentsDirectory.appendingPathComponent("demo.pdf")
        
        
        //check if file exists Delete
        do {
            if(fileManager.fileExists(atPath: pdfPath)){
                try fileManager.removeItem(atPath: pdfPath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
        

        self.generatePdfWithFilePath(filePath: pdfPath as String);
        
        
        
    }
    
    
    func generatePdfWithFilePath(filePath pdfPath : String) {
        
       /* guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height);
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0);
            
            ctx.cgContext.drawPDFPage(page);
        }*/

      /*  let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, imageView.bounds, nil)
        UIGraphicsBeginPDFPage()
        
        let pdfContext = UIGraphicsGetCurrentContext()
        
        if (pdfContext == nil)
        {
            return
        }
        
        imageView.layer.renderInContext(pdfContext!)
        UIGraphicsEndPDFContext()
        
        if let documentDirectories: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        {
            let documentsFileName = (documentDirectories as! String)  + ("demo.pdf")
            debugPrint(documentsFileName, terminator: "")
            pdfData.writeToFile(documentsFileName, atomically: true)
        }
        */
        
    }
    

}
