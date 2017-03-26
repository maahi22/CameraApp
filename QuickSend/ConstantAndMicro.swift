//
//  ConstantAndMicro.swift
//  QuickSend
//
//  Created by Maahi on 15/12/16.
//  Copyright © 2016 Maahi. All rights reserved.
//

import UIKit

class ConstantAndMicro: NSObject {
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    

}
