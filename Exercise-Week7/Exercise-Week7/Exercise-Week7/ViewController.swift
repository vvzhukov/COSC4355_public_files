//
//  ViewController.swift
//  Exercise-Week7
//
//  Created by Shaila Zaman on 10/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    var language = Languages()
    
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        detailsLbl.text = language.about
        
        URLSession.shared.dataTask(with: language.logo, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.logo.image = UIImage(data: data!)
            }
        }).resume()
    }


}

