//
//  TextAnalyzerViewController.swift
//  Exercise-Week12-Solution
//
//  Created by Shaila Zaman on 11/10/21.
//  Modified by Vitalii Zhukov on 11/08/22.
//

import UIKit
import NaturalLanguage

class TextAnalyzerViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var nlpOutput: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showTokens() {
        let text = inputText.text!
        
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = text
        
        var outputTxt = ""
        
        tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { tokenRange, _ in
            // print(text[tokenRange])
            outputTxt = outputTxt + text[tokenRange] + ", "
            return true
        }
        
        nlpOutput.text = String(outputTxt.dropLast(2))
    }
    
    func showLemma() {
        let text = inputText.text!
        
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = text
        
        var outputTxt = ""
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lemma) { tag, tokenRange in
            if let tag = tag {
                // print("\(text[tokenRange]): \(tag.rawValue.capitalized)")
                outputTxt = outputTxt + "\(text[tokenRange]): \(tag.rawValue.capitalized) \n"
            }
            return true
        }
        
        nlpOutput.text = outputTxt
    }
    
    func analyzeSentiment() {
        let text = inputText.text!
        
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        let sentiment = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore).0
        let score = Double(sentiment?.rawValue ?? "0") ?? 0
        
        var outputTxt = "The input is a "
        
        if score == 0 {
            outputTxt = outputTxt + "neutral"
        } else if score < 0{
            outputTxt = outputTxt + "negative"
        } else {
            outputTxt = outputTxt + "positive"
        }
        
        nlpOutput.text = outputTxt + " text. Sentiment Score: \(score) "
    }
    

    @IBAction func applyNLP(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            nlpOutput.text = ""
        } else if sender.selectedSegmentIndex == 1 {
            showLemma()
        } else if sender.selectedSegmentIndex == 2 {
            analyzeSentiment()
        } else if sender.selectedSegmentIndex == 3 {
            showTokens()
        }
    }
    
}
