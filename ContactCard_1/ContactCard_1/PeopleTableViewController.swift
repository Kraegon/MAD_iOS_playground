    //
//  PeopleTableViewController.swift
//  ContactCard_1
//
//  Created by Julian West on 12/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit
import Alamofire

class PeopleTableViewController: UITableViewController {
    
    var displayedPeople = [Person]()
    
    func populateSamplePeople() {
        for (var i = 0; i < 4; i++)
        {
            PeopleFactory.GeneratePerson()
        }
        PeopleFactory.loadPeople()
        print("Created 4 sample doe")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if PeopleFactory.loadPeople() {
            displayedPeople = PeopleFactory.people
        } else {
            populateSamplePeople()
            displayedPeople = PeopleFactory.people
        }
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
        // Set to array length
        return displayedPeople.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "PeopleTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PeopleTableViewCell
        let person = displayedPeople[indexPath.row]
        
        cell.firstname_lbl.text = person.strFirstName
        cell.lastname_lbl.text = person.strLastName
        
        Alamofire.request(.GET, person.imgPathSmall!).response() {
            (req, res, data, error) in
            if error == nil {
                let image = UIImage(data: data!)
                cell.person_img_view.image = image
            }
        }
        
        return cell
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // There is only a single seque possible, so forced cast
        let destinationViewController = segue.destinationViewController as! SummaryViewController
        
        // Get the cell that generated this segue.
        if let selectedPeopleCell = sender as? PeopleTableViewCell {
            let indexPath = tableView.indexPathForCell(selectedPeopleCell)!
            let selectedPerson = displayedPeople[indexPath.row]
            destinationViewController.person = selectedPerson
        }
        
    }

}
