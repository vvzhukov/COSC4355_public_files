//
//  ImageClassifier.swift
//  exc_week12
//
//  Created by Vitalii Zhukov on 11/8/23.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var imageClass: String? {
        classifier.objResults
    }

    var imageText: String? {
        classifier.txtResults
    }
    
    // MARK: Intent(s)
    func detectObj(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detectObj(ciImage: ciImage)
        
    }
    func detectTxt(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detectTxt(ciImage: ciImage)
        
    }
    
}
