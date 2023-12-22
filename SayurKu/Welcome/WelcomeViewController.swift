//
//  WelcomViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 15/12/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 20
        registerButton.layer.cornerRadius = 20
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        navigateToRegistration()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        navigateToLogin()
    }
    
    func navigateToRegistration() {
        print("Navigating to RegistrationViewController")
        let registrationViewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    func navigateToLogin() {
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}
