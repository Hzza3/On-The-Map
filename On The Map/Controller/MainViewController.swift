//
//  MainViewController.swift
//  On The Map
//
//  Created by Epic Systems on 3/7/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var addPinButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
    }
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        UdacityAccountServices.shared().deleteSession { (success, error) in
            
            if success {
                UserData.shared().userKey = "" as AnyObject
                UserData.shared().sessionID = "" as AnyObject
                performUIUpdatesOnMain {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                performUIUpdatesOnMain {
                    self.showAlertWithMessage("Can not logout from account")
                }
            }
        
        }
    }
    
    
    
    @IBAction func addPinTapped(_ sender: Any) {
        
        let dvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func getUserInfo () {
        UdacityAccountServices.shared().getUserInfo { (success, error) in
        }
    }
    
    
}
