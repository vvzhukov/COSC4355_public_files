//
//  ContentView.swift
//  exc_week12 Watch App
//
//  Created by Vitalii Zhukov on 11/7/23.
//

import SwiftUI

struct ContentView: View {
    private var syncService = SyncService()
    @State private var data: String = ""
    @State private var receivedData: [String] = []
    
    var moodArray = ["🤔","😊","🤨","😫"]
    @State var moodIdx = 0
    
    var body: some View {
        VStack {
            Text("Xª ") //use fn + e
                .foregroundStyle(.white)
                .font(.system(size: 36))
                .bold()
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(moodArray[moodIdx])
                .font(.system(size: 80))
            /*
            ForEach(receivedData, id: \.self) { item in
                Text(item)
                    .padding()
            }
            */
            
            // Bleeds into TabView
            Rectangle()
                .frame(height: 0)
                .background(.thinMaterial)
        }
        .background(Color.blue)
        .onAppear { syncService.dataReceived = Receive }
    }
    
    
    private func Receive(key: String, value: Any) -> Void {
        self.receivedData.append("\(Date().formatted(date: .omitted, time: .standard)) - \(key):\(value)")
        self.moodIdx = Int("\(value)") ?? 0
    }
}

#Preview {
    ContentView()
}
