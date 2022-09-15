//
//  StatViewController.swift
//  Exercise-Week4
//
//  Created by Shaila Zaman on 9/15/21.
//

import UIKit

class StatViewController: UIViewController {
    
    @IBOutlet weak var sameCardLabel: UITextField!
    @IBOutlet weak var diffCardLabel: UITextField!
    
    var totalSameCards = 0
    var totalDiffCards = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sameCardLabel.text = String(totalSameCards)
        diffCardLabel.text = String(totalDiffCards)
    }

}
