//
//  ListViewController.swift
//  On The Map
//
//  Created by Epic Systems on 3/7/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var locations = [StudentInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locations = StudentsData.shared().StudentsLocations
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell") {
            cell.textLabel?.text = locations[indexPath.row].firstName + " " + locations[indexPath.row].lastName
            cell.detailTextLabel?.text = locations[indexPath.row].mediaURL
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: locations[indexPath.row].mediaURL) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
