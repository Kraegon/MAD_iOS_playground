//
//  AirportTableViewController.swift RECOVERED, YOU WOULDN'T BELIEVE THE SHIT I WENT THROUGH TO GET THIS FILE BACK OH MY GOD
//  Airport_2
//
//  Created by Julian West on 14/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit

class AirportTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var allAirports = [Airport]()
    var filteredAirports = [Airport]()
    var countryToDisplay: String?
    
    //Required variable for managing searching
    var resultSearchController: UISearchController!
    
    func populateAirportsByIso(iso_country: String)
    {
        if let queryResult = DBBridge.sharedInstance.getAirportsByIso(iso_country.uppercaseString){
            allAirports = queryResult
        } else {
            print("Airport query failure")
        }
    }
    
    func populateAirports(){
        if let queryResult = DBBridge.sharedInstance.getAirports(){
            allAirports = queryResult
        } else {
            print("Airport query failure")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar

        setCountryFromPList()
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func setCountryFromPList()
    {
        let path = NSURL(fileURLWithPath:NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]).URLByAppendingPathComponent("Country.plist")
        
        if let dict = NSDictionary(contentsOfURL: path) as? Dictionary<String, AnyObject> {
            let tempCountry = dict["DisplayedCountry"] as! String
            if !tempCountry.isEmpty {
                countryToDisplay = tempCountry
            }
        }
        if let ctd = countryToDisplay {
            populateAirportsByIso(ctd)
        }
    }
    
    //Once we return from children
    override func viewDidAppear(animated: Bool) {
        setCountryFromPList()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultSearchController.active ? filteredAirports.count : allAirports.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "AirportTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AirportTableViewCell
        
        let cellAirport = self.resultSearchController.active ? filteredAirports[indexPath.row] : allAirports[indexPath.row]
        cell.airportNameLbl.text = cellAirport.name!
        cell.airportMunicipalityLbl.text = cellAirport.municipality!
        cell.isoLbl.text = cellAirport.iso_country!
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.filteredAirports.removeAll(keepCapacity: false)
        
        self.filteredAirports = self.allAirports.filter({( testAirport: Airport) -> Bool in
            let stringMatch = testAirport.name!.rangeOfString(searchController.searchBar.text!)
            return stringMatch != nil
        })
        
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? AirportSummaryViewController {
            // Get the cell that generated this segue.
            if let selectedAirportCell = sender as? AirportTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedAirportCell)!
                let selectedAirport = self.resultSearchController.active ? filteredAirports[indexPath.row] : allAirports[indexPath.row]
                destinationViewController.focusAirport = selectedAirport
                destinationViewController.compareAirport = DBBridge.sharedInstance.getSchiphol();
            }
            
        }
        resultSearchController.active = false;
    }
    
}
