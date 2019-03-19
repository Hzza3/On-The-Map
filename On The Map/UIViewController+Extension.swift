//
//  UIViewController+Extension.swift
//  On The Map
//
//  Created by Epic Systems on 3/18/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithMessage(_ message: String) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
