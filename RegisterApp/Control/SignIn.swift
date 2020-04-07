//
//  ViewController.swift
//  RegisterApp
//
//  Created by minafcis16 on 2/11/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit

class SignIn: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func goToProfileScreen() {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tapbar")
        self.present(profileVC, animated: true, completion: nil)
    }
    
    private func goToSignUpScreen() {
        let SignUpCV = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUp") as! SignUp
        self.present(SignUpCV, animated: true, completion: nil)
    }
    
    func alertMSG (_ message : String){
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }
    
    func validationFields () {
        if emailTF.text?.count == 0 {
            alertMSG("You must fill email")
        }
        else {
            alertMSG("You must fill password")
        }
    }
    
    
    @IBAction func LoginButton(_ sender: Any) {
        
        guard let email = emailTF.text, !email.isEmpty, let password = passwordTF.text, !password.isEmpty else {
            validationFields()
            return
        }
        
        if let jsonString = defaults.string(forKey: "user") {
            
            if let jsonData = jsonString.data(using: .utf8)
            {
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData)
                    if email == user.email && password == user.password {
                        defaults.set("true", forKey: "IsLogin")
                        goToProfileScreen()
                    } else {
                        alertMSG("Invalid constrains")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        
        }
    }
    
    @IBAction func CreateNewAccountBTN(_ sender: Any) {
        goToSignUpScreen()
    }
    
}



