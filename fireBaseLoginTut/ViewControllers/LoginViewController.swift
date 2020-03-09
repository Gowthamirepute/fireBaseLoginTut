//
//  LoginViewController.swift
//  fireBaseLoginTut
//
//  Created by Hxtreme on 06/03/20.
//  Copyright © 2020 Hxtreme. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginAction(_ sender: Any) {

        
        
        let email=userName.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        let password=passWord.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        
        
        
        
        

        //Store in FireBase
        Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
            if let errors=error{
                
                print("Seems error in Firebase\(errors.localizedDescription)")
            }
            else{
                
                
              
              
                
                self.showDashBoard()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
