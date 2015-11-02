//
//  airport.swift
//  Airport_2
//
//  Created by Julian West on 14/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit
import MapKit

class Airport: NSObject{
    /* 
    //Values as in the db
    var name: String?
    var longitude: Double?
    var latitude: Double?
    var elevation: Double?
    var iso_country: String?
    var municipality: String?
    */
    //Values converted for use on a map
    var icao : String?
    var name : String?
    var location : CLLocationCoordinate2D?
    var elevation : Double?
    var iso_country : String?
    var municipality : String?
}
