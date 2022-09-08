//
//  SignUpViewController.swift
//  Exercise-Week3
//
//  Created by Shaila Zaman on 9/8/21.
//

import UIKit

protocol signUpDelegate {
    func addUserFunction(name: String, password: String)
}

class SignUpViewController: UIViewController {
    
    var delegate: signUpDelegate?
    
    var userName:String?
    var userPass:String?
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    @IBOutlet weak var confirmPassInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign up"

        // Do any additional setup after loading the view.
    }
    
    func createAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpToWelcome" {
            let segueSignUpToWelcome = segue.destination as! WelcomeViewController
            segueSignUpToWelcome.name = userName!
            delegate?.addUserFunction(name: userName!, password: userPass!)
        }
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        if (userNameInput.text?.count)! > 0 && (passInput.text?.count)! > 0 && (confirmPassInput.text?.count)! > 0 {
            
            if passInput.text == confirmPassInput.text {
                userName = self.userNameInput.text!
                userPass = self.passInput.text!
                
                self.confirmPassInput.text = ""
                self.passInput.text = ""
                self.userNameInput.text = ""
                
                performSegue(withIdentifier: "signUpToWelcome", sender: self)
                
            } else {
                createAlert(title: "Password Mismatch!", msg: "Password and Confirm Password does not match")
            }
            
        } else {
            createAlert(title: "Missing Entry!", msg: "Missing UserName, Password, or Confirm Password")
        }
    }

}
