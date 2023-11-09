//
//  exc_week12App.swift
//  exc_week12
//
//  Created by Vitalii Zhukov on 11/7/23.
//

import SwiftUI

@main
struct exc_week12App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: ImageClassifier())
        }
    }
}
