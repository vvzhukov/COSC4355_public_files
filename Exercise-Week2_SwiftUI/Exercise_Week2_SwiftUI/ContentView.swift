//
//  ContentView.swift
//  Exercise_Week2_SwiftUI
//
//  Created by Vitalii Zhukov on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dayName: String = ""
    @State private var dayIdx: Int = 0
    @State private var weatherIdx: Int = 0
    @State private var showingAlert = false
    @State private var showingOptions = false
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    let weatherImages: [UIImage] = [#imageLiteral(resourceName: "weather_3"), #imageLiteral(resourceName: "weather_1"), #imageLiteral(resourceName: "weather_4"), #imageLiteral(resourceName: "weather_2")]
    
    
    var body: some View {
        VStack {
            Text(days[dayIdx])
                .font(.title)
            Spacer()
            
            
            Image( uiImage: weatherImages[weatherIdx])
                .resizable()
                .frame(width: 300.0, height: 300.0)
                .foregroundColor(.accentColor)
            Spacer()
            
            Button(action: nextDay) {
                Text("Next Day")
                    .font(.title)
            }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .buttonBorderShape(.roundedRectangle(radius: 1))
            Spacer()
            
            TextField("Enter day", text: $dayName)
                .onSubmit {
                    if days.contains(dayName) {
                        dayIdx = days.firstIndex(of: dayName)!
                        setWeather()
                        dayName = ""
                    } else {
                        showingAlert = true
                        dayName = ""
                    }
                }
                .multilineTextAlignment(.center)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Invalid Day"),
                          message: Text("Please enter a valid day! e.g. Friday"),
                          dismissButton: .default(Text("Got it!")))
                }
            Spacer()
            
            
            Button(action: dayPanel) {
                Text("Day panel")
                    .font(.title)
                
            }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .buttonBorderShape(.roundedRectangle(radius: 1))
                .confirmationDialog("Select a color",
                                    isPresented: $showingOptions,
                                    titleVisibility: .visible) {
                    ForEach(days, id: \.self) { day in
                    Button(day) {
                        dayIdx = days.firstIndex(of: day)!
                        setWeather()
                    }
                }
                }
            
            Spacer()
            
        }
        .padding()
    }
    
    func setWeather() {
        weatherIdx = Int.random(in: 0..<4)
    }
    
    func nextDay() {
        dayIdx = (dayIdx+1)%7
        setWeather()
    }
        
    func dayPanel() {
        showingOptions = true
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
