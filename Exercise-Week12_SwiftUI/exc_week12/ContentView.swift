//
//  ContentView.swift
//  exc_week12
//
//  Created by Vitalii Zhukov on 11/7/23.
//


// https://developer.apple.com/machine-learning/models/


import SwiftUI
import NaturalLanguage
import CoreML


struct ContentView: View {
    
    var imageArray = ["sample0","tweet1","tweet2","tweet3"]
    @ObservedObject var classifier: ImageClassifier
    
    @State var classificationText = "Classifying Image..."
    @State var classificationImageName = "tweet1"

    var syncService = SyncService()
    
    var body: some View {
        
        /*
        Button("Send", action: {
            syncService.sendMessage("mood", "2", { error in })
        })
        */
        
        TabView {
                VStack {
                    Text("Xª ") //use fn + e
                        .foregroundStyle(.white)
                        .font(.system(size: 36))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Spacer()
                    Image(classificationImageName)
                        .resizable()
                        .frame(width: 350, height: 350)
                        .border(.yellow, width: 4)
                        .onAppear{
                            classifier.detectObj(uiImage: UIImage(named: classificationImageName)!)
                            syncService.sendMessage("mood", "\(analyzeSentiment(text: classifier.imageClass!))", { error in })
                        }
                        .onTapGesture {
                            // get random element from array excluding current
                            classificationImageName = (imageArray.filter {$0 != classificationImageName} ).randomElement()!
                            classifier.detectObj(uiImage: UIImage(named: classificationImageName)!)
                            syncService.sendMessage("mood", "\(analyzeSentiment(text: classifier.imageClass!))", { error in })
                        }
                    Spacer()
                        Group {
                                if let imageClass = classifier.imageClass {
                                        HStack{
                                                Text("Objects:")
                                                    .font(.system(size: 26))
                                                Text(imageClass)
                                                    .bold()
                                                    .lineLimit(7)
                                        }
                                        .foregroundStyle(.white)
                                        } else {
                                            HStack{
                                                Text("Unable to identify objects")
                                                    .font(.system(size: 26))
                                            }
                                            .foregroundStyle(.white)
                                        }
                                        
                                }
                                .font(.subheadline)
                                .padding()
                    Spacer()
                    // Bleeds into TabView
                    Rectangle()
                        .frame(height: 0)
                        .background(.thinMaterial)
                }
                .background(Color.blue)
                .tabItem {
                    Text("Objects identification")
                    Image(systemName: "photo") //cmd+shift+l
                }
            
                VStack {
                    Text("Xª ") //use fn + e
                        .foregroundStyle(.white)
                        .font(.system(size: 36))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Spacer()
                    Image(classificationImageName)
                        .resizable()
                        .frame(width: 350, height: 350)
                        .border(.yellow, width: 4)
                        .onAppear{
                            classifier.detectTxt(uiImage: UIImage(named: classificationImageName)!)
                            syncService.sendMessage("mood", "\(analyzeSentiment(text: classifier.imageText!))", { error in })
                        }
                        .onTapGesture {
                            // get random element from array excluding current
                            classificationImageName = (imageArray.filter {$0 != classificationImageName} ).randomElement()!
                            classifier.detectTxt(uiImage: UIImage(named: classificationImageName)!)
                            syncService.sendMessage("mood", "\(analyzeSentiment(text: classifier.imageText!))", { error in })
                        }
                    Spacer()
                        Group {
                                if let imageText = classifier.imageText {
                                        HStack{
                                                Text("Text:")
                                                    .font(.system(size: 26))
                                                Text(imageText)
                                                    .bold()
                                                    .lineLimit(7)
                                        }
                                        .foregroundStyle(.white)
                                        } else {
                                            HStack{
                                                Text("Unable to identify objects")
                                                    .font(.system(size: 26))
                                            }
                                            .foregroundStyle(.white)
                                        }
                                        
                                }
                                .font(.subheadline)
                                .padding()
                    Spacer()
                    // Bleeds into TabView
                    Rectangle()
                        .frame(height: 0)
                        .background(.thinMaterial)
                }
                .background(Color.blue)

                .tabItem {
                    Text("Text recognition")
                    Image(systemName: "doc.text")
                }
        }
        .accentColor(.yellow)
        
    }
    
    func analyzeSentiment(text: String) -> Int {
        
        //limit input to first 100 symbols
        let text = String(text.prefix(100))
        
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        
        let sentiment = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore).0
        let score = Double(sentiment?.rawValue ?? "0") ?? 0

        let outputTxt = "The input: \(text) \n is "
        
        //sentiment analyzis is broken in the current update
        
        return Int.random(in: 0..<3)
        
        
        if score == 0 {
            print(outputTxt + "neutral with a score of \(score)")
            return 2
            
        } else if score < 0 {
            print(outputTxt + "negative with a score of \(score)")
            return 3
            
        } else {
            print(outputTxt + "positive with a score of \(score)")
            return 1
        }

    }
    
}




#Preview {
    ContentView(classifier: ImageClassifier())
}
