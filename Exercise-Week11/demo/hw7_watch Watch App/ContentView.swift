//
//  ContentView.swift
//  hw7_watch Watch App
//
//  Created by Vitalii Zhukov on 11/1/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModelWatch()
    var body: some View {
        VStack {
            Image(systemName: "photo.artframe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(model.messageText)
            Image(uiImage: model.messageImg!)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
