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
class ListRestaurant: UITableViewController{
    

    var listRestaurant = [ ListAddress(name: "Thanh Xuân 1", address: "Số 1 Chiến Thắng"),
                           ListAddress(name: "Thanh Xuân 2", address: "Số 1 Chiến Thắng"),
                           ListAddress(name: "Thanh Xuân 3", address: "Số 1 Chiến Thắng"),
                           ListAddress(name: "Thanh Xuân 4", address: "Số 1 Chiến Thắng")
    ]
    var filteredRest = [ListAddress]()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredRest = listRestaurant
        
        searchController.searchBar.placeholder = "Search Address"
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        //tableView.tableHeaderView = searchController.searchBar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var searchableText: String {
        return searchController.searchBar.text!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func filterContentForSearchText(_ searchText: String) {
        filteredRest = listRestaurant.filter({(rest) -> Bool in
            if rest.name.lowercased().contains(searchableText) || rest.address.lowercased().contains(searchableText) {
                return true
            } else {return false}
        })
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listRestaurant.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = listRestaurant[indexPath.row].name
        cell.detailTextLabel?.text = listRestaurant[indexPath.row].address

        return cell
    }

}
extension ListRestaurant: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}
extension ListRestaurant: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
