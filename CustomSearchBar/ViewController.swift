//
//  ViewController.swift
//  CustomSearchBar
//
//  Created by Alexander Blokhin on 19.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    
    var searchController: UISearchController!
    
    var dataArray = [String]()
    
    var filteredArray = [String]()
    
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadListOfCountries()
        configureSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Введите для поиска..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
    // MARK: - UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredArray[indexPath.row]
        }
        else {
            cell.textLabel?.text = dataArray[indexPath.row]
        }
        
        return cell
    }
    
    // MARK: - Supporting functions
    
    func loadListOfCountries() {
        // Specify the path to the countries list file.
        let pathToFile = NSBundle.mainBundle().pathForResource("countries", ofType: "txt")
        
        if let path = pathToFile {
            // Load the file contents as a string.
            do {
                let countriesString = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                
                // Append the countries from the string to the dataArray array by breaking them using the line change character.
                dataArray = countriesString.componentsSeparatedByString("\n")
                
                // Reload the tableview.
                tableView.reloadData()
            } catch {}
        }
    }
}

