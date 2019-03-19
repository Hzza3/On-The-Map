//
//  LoginViewController.swift
//  On The Map
//
//  Created by Epic Systems on 3/4/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if userNameTextField.text == "" {
            showAlertWithMessage("Please Enter User Name")
            return
        }
        
        if passwordTextField.text == "" {
            showAlertWithMessage("Please Enter Password")
            return
        }
        
        UdacityAccountServices.shared().createSession(userName: userNameTextField.text!, password: passwordTextField.text!) { (success, error) in
            
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToMain", sender: nil)
                }
            } else {
                if error == "request error" {
                    performUIUpdatesOnMain {
                        self.showAlertWithMessage("Check your internet connection")
                    }
                } else if error == "wrong code" {
                    performUIUpdatesOnMain {
                        self.showAlertWithMessage("Wrong Username or Password")
                    }
                } else if error == "no data" {
                    performUIUpdatesOnMain {
                        self.showAlertWithMessage("Wrong Username or Password")
                    }
                }
            }
        }
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        guard let url = URL(string: UdacityConstants.udacitySignUpURL) else { return }
        UIApplication.shared.open(url)
    }
    
}
