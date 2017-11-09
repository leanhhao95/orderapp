//
//  ListRestaurant.swift
//  OrderMeal
//
//  Created by Luyen on 11/7/17.
//  Copyright © 2017 Luyen. All rights reserved.
//

import UIKit

struct ListAddress {
    let name: String
    let address: String
}
class ListRestaurant: UITableViewController,  UISearchBarDelegate, UISearchResultsUpdating {
    
    
    var listRestaurant = [ ListAddress(name: "Thanh Xuân 1", address: "Số 1 Chiến Thắng"),
                           ListAddress(name: "Thanh Xuân 2", address: "Số 1 Chiến Thắng"),
                           ListAddress(name: "Thanh Xuân 3", address: "Số 1 Chiến Thắng"),
                           ListAddress(name: "Thanh Xuân 4", address: "Số 1 Chiến Thắng")
    ]
    var searchActive: Bool = false
    var filteredRest = [ListAddress]()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return  filteredRest.count
        }
        return listRestaurant.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if searchController.isActive {
            cell.textLabel?.text = filteredRest[indexPath.row].name
            cell.detailTextLabel?.text = filteredRest[indexPath.row].address
        } else {
            cell.textLabel?.text = listRestaurant[indexPath.row].name
            cell.detailTextLabel?.text = listRestaurant[indexPath.row].address
        }
        
        return cell
    }
    var searchableText: String {
        return searchController.searchBar.text!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func updateSearchResults(for searchController: UISearchController) {
        filteredRest = listRestaurant.filter({(rest) -> Bool in
            if rest.name.lowercased().contains(searchableText) || rest.address.lowercased().contains(searchableText) {
                return true
            } else {return false}
        })
        tableView.reloadData()
    }
}


