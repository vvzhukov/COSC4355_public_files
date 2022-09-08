//
//  WelcomeViewController.swift
//  Exercise-Week3
//
//  Created by Shaila Zaman on 9/8/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var name:String?

    @IBOutlet weak var welcomeMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeMsg.text = "Welcome \(name!)!"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
