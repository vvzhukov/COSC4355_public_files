//
//  ViewController.swift
//  Exercise_Week2
//
//  Created by Shaila Zaman on 9/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let weatherImages: [UIImage] = [#imageLiteral(resourceName: "weather_3"), #imageLiteral(resourceName: "weather_1"), #imageLiteral(resourceName: "weather_4"), #imageLiteral(resourceName: "weather_2")]
    // let weatherImages: [UIImage] = [#imageLiteral(resourceName: "weather_3"), #imageLiteral(resourceName: "weather_1"), #imageLiteral(resourceName: "weather_4"), #imageLiteral(resourceName: "weather_2")]
    
    // UIImage(named:"3.png")
    var dayIdx = 0

    // @ shows compiler the external connection to the UI interface
    @IBOutlet weak var dayLabel: UILabel!
    // weak here means that the reference object is not
    // protected by the reference from deallocation by ARC
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var dayInput: UITextField!
    
    
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
    
    func getRandomWeather() -> Int {
        return(Int.random(in: 1 ... 4))
    }
    
    func showDayAndWeather() {
        dayLabel.text = days[dayIdx]
//        weatherImg.image = UIImage(named: "weather_\(getRandomWeather()).jpg")
        weatherImg.image = weatherImages.randomElement()
    }

    @IBAction func showNextDayWeather(_ sender: Any) {
        if dayInput.text?.count == 0 {
            dayIdx = (dayIdx+1)%7
            showDayAndWeather()
            
        } else {
            if let givenDay = dayInput.text,
               days.contains(givenDay) {
                dayIdx = days.firstIndex(of: givenDay)!
                showDayAndWeather()
                dayInput.text = ""
            } else {
                createAlert(title: "Invalid Day", msg: "Please enter a valid day! e.g. Friday")
            }
        }
        
    }
    
    @IBAction func selectDay(_ sender: Any) {
        let actionSheetAlert = UIAlertController(title: "Pick a Day", message: "", preferredStyle: .actionSheet)
        for day in days {
            actionSheetAlert.addAction(UIAlertAction(title: day, style: .default, handler: { _ in
                self.dayIdx = self.days.firstIndex(of: day)!
                self.showDayAndWeather()
            }))
        }
        actionSheetAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(actionSheetAlert, animated: true, completion: nil)
    }
}

