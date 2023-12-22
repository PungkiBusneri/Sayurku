//
//  RegisterViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 15/12/23.
//

import UIKit
import SwiftyJSON

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var userName: UITextField!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passInput: UITextField!
    @IBOutlet var passConfirm: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var showOffPass: UIButton!
    @IBOutlet var showOnPass: UIButton!
    
    let registerManager = RegisterManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = .greenWelcome
        showOnPass.tintColor = .greenWelcome
        showOffPass.tintColor = .greenWelcome
        
        userName.placeholder = "Username"
        emailInput.placeholder = "Your email"
        passInput.placeholder = "Your password"
        passConfirm.placeholder = "Confirm your Password"
        
        passConfirm.delegate = self
//        navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    func textFieldBeginEditing(_ textfield: UITextField) {
        textfield.placeholder = nil
    }
    func textFieldDidEndEditing(_ textfield: UITextField) {
        if textfield.text?.isEmpty ?? true {
            textfield.placeholder = "Complete your data"
        }
    }
    
    @IBAction func toogleButtonShowOff(_ sender: Any) {
        passInput.isSecureTextEntry.toggle()
    }
    
    @IBAction func toogleButtonShowOn(_ sender: Any) {
        passConfirm.isSecureTextEntry.toggle()
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        registerButton.titleLabel?.text = "REGISTER"
        let validationResult = validateInputs()
        
        if validationResult.isValid {
            print("Registrasi success")
            print("Name: \(userName.text ?? "")")
            print("Email: \(emailInput.text ?? "")")
            print("Password: \(passInput.text ?? "")")
            
            let name = userName.text ?? ""
            let email = emailInput.text ?? ""
            let password = passInput.text ?? ""
            
            // Panggil fungsi registrasi dari RegisterManager (disesuaikan dengan struktur aplikasi Anda)
            registerUser(name: name, email: email, password: password)
        } else {
            print("Validasi gagal: \(validationResult.errorMessage)")
            showAlert(message: validationResult.errorMessage)
        }
    }
    
    func registerUser(name: String, email: String, password: String) {
        RegisterManager.shared.registerUser(name: name, email: email, password: password) { data, error, statusCode in
            // Handle the response
            if let data = data {
                // Process the data
                print("Register Data: \(data)")
                let responseData = RegisterModel(json: data)
                self.handleRegistrationResponse(responseData)
            } else if let error = error {
                // Handle the error
                print("Register Error: \(error)")
                self.showAlert(message: "Error: \(error)")
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        passConfirm.isSecureTextEntry = true
        
        return true
    }
    
    func handleRegistrationResponse(_ responseData: RegisterModel) {
        let code = responseData.code
        if code == "20000" { // Sesuaikan dengan kode sukses yang diharapkan
            print("Registrasi berhasil")
            let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
            navigationController?.pushViewController(loginVC, animated: true)
        } else {
            let errorMessage = responseData.message ?? "Tidak ada pesan"
            print("Registrasi gagal. Pesan: \(errorMessage)")
            showAlert(message: "Registrasi gagal. \(errorMessage)")
        }
    }
    
    func validateInputs() -> (isValid: Bool, errorMessage: String) {
        
        guard let nameText = userName.text, !nameText.isEmpty else {
            return(false, "nama harus di isi")
        }
        guard let emailText = emailInput.text, !emailText.isEmpty else {
            return(false, "email harus di isi")
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: emailText) {
            return(false, "Format email tidak valid")
        }
        guard let passwordText = passInput.text, passwordText.count >= 6 else {
            return (false, "Password minimal 6 karakter")
        }
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        if !numberPredicate.evaluate(with: passwordText) {
            return (false, "Password harus mengandung setidaknya satu angka")
        }
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        if !passwordPredicate.evaluate(with: passwordText) {
            return (false, "Password harus mengandung setidaknya satu huruf kecil, satu huruf besar, dan satu simbol")
        }
        return (true, "")
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Peringatan", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
