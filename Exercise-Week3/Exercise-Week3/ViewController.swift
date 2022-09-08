//
//  ViewController.swift
//  Exercise-Week3
//
//  Created by Shaila Zaman on 9/8/21.
//

import UIKit

class ViewController: UIViewController, signUpDelegate {
    
    var userName:String?
    var userNamePasswordDict = ["admin": "AdminPassword", "a": "b"]

    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if segue.identifier == "homeToWelcome" {
            let segueWelcome = segue.destination as! WelcomeViewController
            segueWelcome.name = userName!
        }
        if segue.identifier == "homeToSignUp"{
            let segueSignUp = segue.destination as! SignUpViewController
            segueSignUp.delegate = self
        }
    }
    
    func addUserFunction(name: String, password: String) {
        userNamePasswordDict[name] = password
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        if (userNameInput.text?.count)! > 0 && (passInput.text?.count)! > 0{
            
            if(userNamePasswordDict[userNameInput.text!] == passInput.text!){
                userName = self.userNameInput.text!
                self.userNameInput.text = ""
                self.passInput.text = ""
                performSegue(withIdentifier: "homeToWelcome", sender: self)
                
            } else {
                createAlert(title: "Invalid Entry!", msg: "Combination of User Name and  Password is not valid")
            }
            
        } else {
            createAlert(title: "Missing Entry!", msg: "Missing User Name or Password")
        }
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "homeToSignUp", sender: self)
    }
    
}

