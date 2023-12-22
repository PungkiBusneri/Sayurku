//
//  LoginViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 15/12/23.
//

import UIKit
import SwiftyJSON
import Moya

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var showOnPass: UIButton!
    
    let loginManager = LoginManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = .greenWelcome
        showOnPass.tintColor = .greenWelcome
        
        emailInput.placeholder = "username@example.com"
        passwordInput.placeholder = "Your password"
        emailInput.delegate = self
        passwordInput.delegate = self
        
    }
    
    func textFieldBeginEditing(_ textfield: UITextField) {
        textfield.placeholder = nil
    }
    
    func textFieldDidEndEditing(_ textfield: UITextField) {
        if textfield.text?.isEmpty ?? true {
            textfield.placeholder = "Input your valid email and password"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        passwordInput.isSecureTextEntry = true
        
        return true
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toogleButtonPresed(_ sender: Any) {
        passwordInput.isSecureTextEntry.toggle()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        login()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Peringatan", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func login() {
        
        guard let email = emailInput.text, !email.isEmpty,
              let password = passwordInput.text, !password.isEmpty else {
            print("Nilai loginEmail.text: \(emailInput.text ?? "")")
            print("Nilai loginPass.text: \(passwordInput.text ?? "")")
            
            showAlert(message: "email dan password harus valid")
            
            return
        }
        
        loginUser(email: email, password: password)
        
    }
    
    func loginUser(email: String, password: String) {
        LoginManager.shared.loginUser(email: email, password: password) { data, error, statusCode in
            // Handle the response
            if let data = data {
                // Process the data
                print("Login Data: \(data)")
                let responseData = LoginModel(json: data)
                self.handlerLoginResponse(responseData)
            } else if let error = error {
                // Handle the error
                print("Login Error: \(error)")
                self.showAlert(message: "Error: \(error)")
            }
        }
    }
    
    func handlerLoginResponse(_ responseData: LoginModel) {
        if responseData.code == "20000" {
            print("Login berhasil")
            
            UserDefaults.standard.set(responseData.data.token, forKey: "AuthToken")
            print("AuthToken: \(String(describing: UserDefaults.standard.string(forKey: "AuthToken")))")
            
            if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
                // Jika token tersimpan
                print("AuthToken: \(authToken)")
                let tabBarVC = TabBarController(nibName: "TabBarController", bundle: nil)
                print("Mencoba push ke TabBarController")
                navigationController?.pushViewController(tabBarVC, animated: true)
                
            } else {
                print("Token tidak tersimpan.")
            }
            
        } else {
            print("Login gagal. Pesan: \(responseData.message)")
            showAlert(message: "Login gagal. \(responseData.message)")
        }
    }
}





