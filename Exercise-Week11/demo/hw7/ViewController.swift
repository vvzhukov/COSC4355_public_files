//
//  ViewController.swift
//  hw7
//
//  Created by Vitalii Zhukov on 11/1/22.
//

import UIKit
import WatchConnectivity
import Foundation

extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var watchButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var originalImage = UIImage(named: "nature_1")
    var context = CIContext()
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        picker.delegate = self
        self.title = "Photo Filter App"
        
        imageView.image = originalImage
        
        // rgb(45, 70, 185)
        selectButton.tintColor = UIColor(red: 45/255, green: 70/255, blue: 185/255, alpha: 1)
        saveButton.tintColor = UIColor(red: 45/255, green: 70/255, blue: 185/255, alpha: 1)
        watchButton.tintColor = UIColor(red: 45/255, green: 70/255, blue: 185/255, alpha: 1)

        selectButton.contentVerticalAlignment = .fill
        selectButton.contentHorizontalAlignment = .fill
        
        watchButton.contentVerticalAlignment = .fill
        watchButton.contentHorizontalAlignment = .fill
        
        saveButton.contentVerticalAlignment = .fill
        saveButton.contentHorizontalAlignment = .fill
        
        if WCSession.isSupported(){
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected an image, but was provided the following: \(info)")
        }
        
        imageView.image = selectedImage
        originalImage = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        }
    }
    
    func loadImageFromGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        }
    }
    
    func getFilterFromSegmentIdx(segmentIdx: Int, inputCIImage: CIImage) -> CIFilter {
        if segmentIdx == 1 {
            return CIFilter(name: "CIGaussianBlur", parameters: ["inputImage": inputCIImage, "inputRadius": 10.0])!
        } else if segmentIdx == 2 {
            return CIFilter(name: "CISepiaTone", parameters: ["inputImage": inputCIImage, "inputIntensity": 0.9])!
        } else if segmentIdx == 3 {
            return CIFilter(name: "CIPhotoEffectInstant", parameters: ["inputImage": inputCIImage])!
        } else {
            return CIFilter(name: "CIPhotoEffectNoir", parameters: ["inputImage": inputCIImage])!
        }
    }
    
    
    func filterImage(inputImg : UIImage, segmentIdx: Int) -> UIImage? {
        guard let inputCIImage = CIImage(image: inputImg) else {
            return nil
        }

        let filter = getFilterFromSegmentIdx(segmentIdx: segmentIdx, inputCIImage: inputCIImage)
   
        guard let ciImageResult = filter.outputImage else {
            return nil
        }
        
        if let _cgImage = context.createCGImage(ciImageResult, from: ciImageResult.extent) {
            let originalOrientation = inputImg.imageOrientation
            let originalScale = inputImg.scale
            return UIImage(cgImage: _cgImage, scale: originalScale, orientation: originalOrientation)
        }
        
        return nil
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
        show_picker()
    }
    
    @IBAction func sendToWatch(_ sender: Any) {
        
        // Create Date
        let date = Date()

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "hh:mm:ss"

        // Convert Date to String
        
        var preprocessed_img = self.imageView.image!.resizeImageTo(size: CGSize(width: 45.00, height: 45.00))
        var img = preprocessed_img!.pngData()!
       
        
        let message = ["message": "Got at \(dateFormatter.string(from: date))"]
        
        if WCSession.default.isReachable {
             
            WCSession.default.sendMessage(message, replyHandler: nil){ (error) in
                print(error.localizedDescription)
            }
            
            WCSession.default.sendMessageData(img, replyHandler: nil){ (error) in
                print(error.localizedDescription)
            }
        }
        
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        guard imageView.image != nil else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(save_image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    @IBAction func applyFilter(_ sender: AnyObject) {
        guard let img = self.originalImage else {
            return
        }

        if sender.selectedSegmentIndex == 0 {
            self.imageView.image = img

        } else if let image = self.filterImage(inputImg: img, segmentIdx: sender.selectedSegmentIndex) {
            self.imageView.image = image
        }
    }
    
    
    
    @objc func save_image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photo gallery", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func show_picker() {
        let alert = UIAlertController(title: "Photo Source Picker", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Open Camera", comment: "Default action"), style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Open Gallery", comment: "Default action"), style: .default, handler: { _ in
            self.loadImageFromGallery()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

