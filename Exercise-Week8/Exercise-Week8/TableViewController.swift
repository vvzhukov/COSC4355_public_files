//
//  TableViewController.swift
//  Exercise-Week8
//
//  Created by Shaila Zaman on 10/13/21.
//

//
//  ViewController.swift
//  Exercise-Week8
//
//  Created by Shaila Zaman on 10/13/21.
//

import UIKit


struct Company : Codable {
    init() {
        company = ""
        hq_longitude = 0.00
        hq_latitude = 0.00
    }
    
    var company: String
    var hq_longitude: Double
    var hq_latitude: Double
}

class TableViewController: UITableViewController {
    
    var selectedCompany = Company()
    var downloadedCompanies = [Company]()

    override func viewDidLoad() {
        super.viewDidLoad()

        downloadData(url: URL(string: "http://cpl.uh.edu/courses/ubicomp/fall2021/webservice/companies_map.json")!)
    }
    
    func downloadData(url: URL) {
        URLSession.shared.dataTask(with: url){(data,response,error) in
            
            if let downloadedData = data{
                do {
                    self.downloadedCompanies = try JSONDecoder().decode(Array<Company>.self, from: downloadedData)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("Error in JSON decoding!")
                }
            }
        }.resume()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return downloadedCompanies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let companyLbl = cell.viewWithTag(1) as! UILabel
        companyLbl.text = downloadedCompanies[indexPath.row].company

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg_map" {
            let mapViewPage = segue.destination as! ViewController
            mapViewPage.selectedCompany = selectedCompany
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCompany = downloadedCompanies[indexPath.row]
        performSegue(withIdentifier: "seg_map", sender: self)
    }

}

