//
//  ViewController.swift
//  Exercise-Week8
//
//  Created by Shaila Zaman on 10/13/21.
//

import UIKit
import MapKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    var selectedCompany = Company()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        showMap()
        showNotification()
        setuplongPressGestureRecognizer()
    }

    func setuplongPressGestureRecognizer() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(press:)))
        longPressGestureRecognizer.minimumPressDuration = 2.0
        map.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func showNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            if error != nil {
                print("Error in notifications")
            }
        })
        
        let content = UNMutableNotificationContent()
        content.title = "Map Notification!"
        content.body = "5 seconds passed after map loading"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timeDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @objc func addAnnotation(press:UILongPressGestureRecognizer){
        if press.state == .began{
            let location = press.location(in: map)
            let coordinates = map.convert(location, toCoordinateFrom: map)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = "Long Pressed Location"
            annotation.subtitle = "Hello!!"
            
            map.addAnnotation(annotation)
        }
    }

    
    func showMap() {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let companyLocation = CLLocationCoordinate2DMake(selectedCompany.hq_latitude, selectedCompany.hq_longitude)
        let region = MKCoordinateRegion(center: companyLocation, span: span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        
        
        let loc = CLLocation(latitude: self.selectedCompany.hq_latitude, longitude: self.selectedCompany.hq_longitude)
        CLGeocoder().reverseGeocodeLocation(loc) { (placemark, error) in
            if error != nil {
                print("Error in Map Loading")
                return
            }

            if let place = placemark?[0] {
                let annotation = MKPointAnnotation()
                annotation.coordinate = companyLocation
                annotation.title = "\(self.selectedCompany.company)"

                annotation.subtitle = "\(place.locality!), \(place.administrativeArea!), \(place.isoCountryCode!)"
                
                DispatchQueue.main.async {
                    self.map.addAnnotation(annotation)
                }
            }
        }
    }

}
