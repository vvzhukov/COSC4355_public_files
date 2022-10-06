//
//  TableViewController.swift
//  Exercise-Week7
//
//  Created by Shaila Zaman on 10/6/21.
//

import UIKit

struct Languages: Codable {
    init() {
        name = ""
        designed_by = ""
        logo = URL(string: "http://www.google.com")!
        first_appeared = 0
        website = ""
        about = ""
    }
    
    let name: String
    let designed_by: String
    let logo: URL
    let first_appeared: Int
    let website: String
    let about: String
}

class TableViewController: UITableViewController {
    
    var language = [Languages]()
    var selectedLanguage = Languages()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://cpl.uh.edu/courses/ubicomp/fall2021/webservice/languages.json")
        
        if url != nil {
            getData(url: url!)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let logo = cell.viewWithTag(1) as! UIImageView
        let name = cell.viewWithTag(2) as! UILabel
        let firstAppeared = cell.viewWithTag(3) as! UILabel

        name.text = language[indexPath.row].name
        firstAppeared.text = "Est. \(language[indexPath.row].first_appeared)"

        let url = language[indexPath.row].logo
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                logo.image = UIImage(data: data!)
            }
        }).resume()
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguage = language[indexPath.row]
        self.performSegue(withIdentifier: "seg_details", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg_details" {
            let detailed_view = segue.destination as! ViewController
            detailed_view.language = selectedLanguage
        }
    }
    
    func getData(url: URL) {

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonDecoder = JSONDecoder()
                    let languages = try jsonDecoder.decode(Array<Languages>.self, from: data)
//                    print(languages)
                    self.language = languages
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
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
