//
//  ViewController.swift
//  Project 7
//
//  Created by Lia AN on 2022/03/25.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json" // points to json data online
        
        // convert string -> url (safely unwrap)
        if let url = URL(string: urlString) {
            // convert url -> data
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse (while downloading: app will lock up -> white screen)
                parse(json: data)
            }
        }

    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }


}

