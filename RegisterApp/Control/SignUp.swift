//
//  SignUp.swift
//  RegisterApp
//
//  Created by minafcis16 on 2/11/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class SignUp: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    let picker = UIImagePickerController()
    
    var user : User!

    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func goToProfileScreen() {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tableViewSB") as! moviesTableViewController
        self.present(profileVC, animated: true, completion: nil)
    }
    
    func EncodingAndSavingData(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(user)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                defaults.set(jsonString , forKey : "user")
            }
        } catch {
            print(error.localizedDescription)
        }
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
    
    func validationEmail (_ email : String) -> Bool {
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z0-9]+@[a-zA-Z0-9]+.com")
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func checkForUpperChar (_ password : String) ->Bool{
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: password)
        return capitalresult
    }
    
    func checkForSpecialChar (_ password : String) -> Bool{
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        let specialresult = texttest2.evaluate(with: password)
        return specialresult
    }
    
    func validationPassword (_ password : String) -> Bool {
        if password.count < 8 {
            alertMSG("The password must be more than or equal 8 char")
            return false
        }
        else if !checkForUpperChar(password){
            alertMSG("The password must be contain at least one upper char")
            return false
        }
        else if !checkForSpecialChar(password){
            alertMSG("The password must be contain at least one special char")
            return false
        }
        return true
    }
    
    func validationFields () {
        if usernameTF.text?.count == 0 {
            alertMSG("You must fill username")
        }
        else if emailTF.text?.count == 0 {
            alertMSG("You must fill email")
        }
        else {
            alertMSG("You must fill password")
        }
    }
    
    
    private func isValidData() -> Bool {
        if let name = usernameTF.text, !name.isEmpty, let email = emailTF.text, !email.isEmpty, let password = passwordTF.text, !password.isEmpty{
            
            if !validationEmail(email){
                alertMSG("unvalidation email")
                return false
            }
            
            if !validationPassword(password){
                return false
            }
            
            var gender = "male"
            if genderSwitch.isOn {
                gender = "female"
            }
            
            user = User(name: name, email: email, password: password , gender: gender)
            return true
        } else {
            validationFields()
            return false
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
        }
        
        
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }

    
    @IBAction func setImageFromGallary(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            picker.allowsEditing = false
            
            present(picker, animated: true, completion: nil)
        }
    }
    @IBAction func confirmButtonPress(_ sender: Any) {
        if isValidData(){
            EncodingAndSavingData()
            goToProfileScreen()
        }
    }
}
    

