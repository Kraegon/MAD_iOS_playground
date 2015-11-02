//
//  CountriesCollectionViewController.swift
//  Airport_2
//
//  Created by Julian West on 21/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CountriesCollectionViewCell"

class CountriesCollectionViewController: UICollectionViewController {
    
     var availableCountries = [String]()
    
    func populateCountries(){
        if let queryResult = DBBridge.sharedInstance.getCountries(){
            availableCountries = queryResult.sort()
        } else {
            print("Countries query failure")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateCountries()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes, 
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableCountries.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CountriesCollectionViewCell
        
        cell.countryLbl.text = availableCountries[indexPath.row]
        // Configure the cell
        let path = NSURL(fileURLWithPath:NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]).URLByAppendingPathComponent("Country.plist")
        
        if let dict = NSDictionary(contentsOfURL: path) as? Dictionary<String, AnyObject> {
            let tempCountry = dict["DisplayedCountry"] as! String
            if availableCountries[indexPath.row].compare(tempCountry).rawValue == 0 {
                cell.backgroundColor = UIColor.blueColor()
            } else {
                cell.backgroundColor = UIColor.whiteColor()
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        //Contains desired text
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CountriesCollectionViewCell
        //Set path for writing to a writeable destination in Documents
        let path = NSURL(fileURLWithPath:NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]).URLByAppendingPathComponent("Country.plist")
        //Save operation
        let dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        dict.setObject(cell.countryLbl.text!, forKey: "DisplayedCountry")
        dict.writeToURL(path, atomically: false)
        
        //Test
        let resultDictionary = NSMutableDictionary(contentsOfURL: path)!
        print("Saved Country.plist file is --> \(resultDictionary.description)")
        
        navigationController?.popViewControllerAnimated(true)
        return true
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
