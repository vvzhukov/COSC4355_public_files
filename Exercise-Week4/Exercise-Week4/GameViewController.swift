//
//  GameViewController.swift
//  Exercise-Week4
//
//  Created by Shaila Zaman on 9/15/21.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    
    var totalSameCards = 0
    var totalDiffCards = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let statsTab = self.tabBarController?.children[1] as! StatViewController
        statsTab.totalSameCards = totalSameCards
        statsTab.totalDiffCards = totalDiffCards
    }
    
    func generateRandomNumber(from: Int, to: Int) -> Int {
        return Int.random(in: from..<to)
    }
    
    @IBAction func shuffleImages(_ sender: Any) {
        let cardNum1 = Int.random(in: 2..<9)
        let cardNum2 = Int.random(in: 2..<9)
        
        img1.image = UIImage(named: "\(cardNum1).png")!
        img2.image = UIImage(named: "\(cardNum2).png")!
        
        if cardNum1 == cardNum2 {
            totalSameCards += 1
        } else{
            totalDiffCards += 1
        }
    }

}
