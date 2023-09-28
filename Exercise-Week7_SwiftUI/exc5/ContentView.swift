//
//  ContentView.swift
//  exc5
//
//  Created by Vitalii Zhukov on 9/28/23.
//

import SwiftUI

// colors
struct CustomColor {
    static let DarkBlue = Color("DarkBlue")
    static let LightBlue = Color("LightBlue")
    static let PinkBackground = Color("PinkBackground")
}


// store retrieved data
struct Response: Codable {
    var results: [Language]
}

struct ContentView: View {
    
    @State private var languages = [Language]()
    
    var body: some View {
        NavigationView {
            List(languages, id: \.id) { Language in
                HStack {
                    NavigationLink(destination: DetailView(about: Language.about, img_logo: Language.logo)) {
                        HStack {
                            AsyncImage(url: Language.logo) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 80, maxHeight: 80)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Spacer()
                            
                            VStack {
                                Spacer()
                                Text(Language.name)
                                    .font(.system(size: 25))
                                    .bold()
                                    .foregroundColor(CustomColor.DarkBlue)
                                Spacer()
                                
                                Text("Est. " + String(Language.first_appeared))
                                    .font(.system(size: 12))
                                    .foregroundColor(CustomColor.LightBlue)
                                Spacer()
                            }
                            .multilineTextAlignment(.trailing)
                            
                        }
                    }
                }
            }
            .colorMultiply(CustomColor.PinkBackground)
            .task {
                await loadData()
            }
        }
    }
    
    
    func loadData() async {
        // func might want to go to sleep in order to complete work
        
        guard let url = URL(string: "http://m.cpl.uh.edu/courses/ubicomp/fall2021/webservice/languages_id.json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonDecoder = JSONDecoder()
                    languages = try jsonDecoder.decode(Array<Language>.self, from: data)
                    
                } catch {
                    print("Error trying to decode JSON object")
                }

            } else if let error = error {
                print(error.localizedDescription)
            }
        }

        task.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
