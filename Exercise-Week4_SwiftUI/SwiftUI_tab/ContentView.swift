//
//  ContentView.swift
//  SwiftUI_tab
//
//  Created by Vitalii Zhukov on 9/14/23.
//

import SwiftUI

// Add wrapper, don't forget to change
// entry points for ContentView_Previews
// and at @main (SwiftUI_tabApp.swift)
struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Original V", systemImage: "list.dash")
                }
            SecondContentView()
                .tabItem {
                    Label("Second V", systemImage: "square.and.pencil")
                }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.black)
            Text("Hello, world!")
        }
        .padding()
    }
}


struct SecondContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.red)
            Text("Hey, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
