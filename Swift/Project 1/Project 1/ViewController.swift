//
//  ViewController.swift
//  Project 1
//
//  Created by Lia AN on 2022/03/01.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!  // "tell me where I can find all those images I added to my app."
        let items = try! fm.contentsOfDirectory(atPath: path) // an array of strings containing filenames.
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        } // viewDidLoad
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }


}

