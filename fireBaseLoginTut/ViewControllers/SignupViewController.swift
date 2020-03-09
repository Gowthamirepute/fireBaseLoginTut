//
//  SignupViewController.swift
//  fireBaseLoginTut
//
//  Created by Hxtreme on 06/03/20.
//  Copyright © 2020 Hxtreme. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passWord: UITextField!

    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide label Beginning,Hence we can show once error found
        errorLabel.alpha=0

    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        
        
        //ValidateField in order to Check whether user properly give information incase any inconsistence found in fields or password then get that info and show it in label
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        
        
        else{
            
            let firstname=firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname=lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines)

            let password=passWord.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            
            
            
            
            

            //Store in FireBase
            Auth.auth().createUser(withEmail: email.text!, password: passWord.text!) { (result, error) in
                if let errors=error{
                    
                    print("Seems error in Firebase\(errors.localizedDescription)")
                }
                else{
                    
                    
                  
                    let dbReference=Firestore.firestore().collection("users").addDocument(data: ["firstName":firstname,"lastName":lastname,"uid":result?.user.uid]) { (err) in
                        if err != nil{
                            
                            self.showError(err!.localizedDescription)
                        }
                    }
                    
                    self.showDashBoard()
                }
            }
            
        }
        
        
    }
    
    func showDashBoard(){
        
        
       if let vc=storyboard?.instantiateViewController(identifier: "HomeVc") as? HomeViewController{
            let navigationVc=UINavigationController(rootViewController: vc)
            self.view.window?.rootViewController=navigationVc
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passWord.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanedPassword.isValidPassword() == true {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
//
     func showError(_ message:String) {
         
         errorLabel.text = message
         errorLabel.alpha = 1
     }
   

}
extension String{
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
