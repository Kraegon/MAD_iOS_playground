//
//  DBBridge.swift
//  Airport_2
//
//  Created by Julian West on 20/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit
import MapKit

class DBBridge: NSObject {
    enum DBError: ErrorType {
        case NotConnected(path: String)
    }
    
    enum ExampleQuery: String{
        case selectAll = "SELECT * FROM airports",
        selectAllOrdered = "SELECT * FROM airports ORDER BY name",
        selectIsoNL = "SELECT * FROM airports WHERE iso_country = \"NL\" ORDER BY name",
        selectDistinctIso = "SELECT DISTINCT iso_country FROM airports"
    }
    
    static let sharedInstance = DBBridge() //Singleton to avoid multiple access
    static let dbFilePath = NSBundle.mainBundle().pathForResource("airports", ofType: "sqlite")
    
    var db : COpaquePointer = nil
    
    override init() {
        if sqlite3_open(DBBridge.dbFilePath!,&db) != SQLITE_OK {
            print("Path: "+DBBridge.dbFilePath!+" is not okay!")
        }
    }
    
    func getCountries() -> [String]?
    {
        var queryResultsAsStrings = [String]()
        
        // Prepare query and execute, I stole this part of the function
        var statement : COpaquePointer = nil
        if sqlite3_prepare_v2(db, ExampleQuery.selectDistinctIso.rawValue, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String.fromCString(sqlite3_errmsg(db))
            print("error query: \(errmsg)")
            return nil
        }
        
        // Convert results to objects
        while sqlite3_step(statement) == SQLITE_ROW {
            queryResultsAsStrings.append(String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 0)))!)
        }
        return queryResultsAsStrings
    }
    
    func getSchiphol() -> Airport?
    {
        let query = "SELECT * FROM airports WHERE name = \"Amsterdam Airport Schiphol\""
        var statement : COpaquePointer = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String.fromCString(sqlite3_errmsg(db))
            print("error query: \(errmsg)")
            return nil
        }
        //Expecting one row
        sqlite3_step(statement)
        let airportSchiphol = Airport();
            
        // ICAO code and naming
        airportSchiphol.icao = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 0)));
        airportSchiphol.name = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 1)));
        
        // GPS coordinates
        let longitude : CLLocationDegrees = sqlite3_value_double(sqlite3_column_value(statement, 2))
        let latitude : CLLocationDegrees = sqlite3_value_double(sqlite3_column_value(statement, 3))
        airportSchiphol.location = CLLocationCoordinate2DMake(latitude, longitude)
        airportSchiphol.elevation = sqlite3_value_double(sqlite3_column_value(statement, 4))
        
        // Country and city
        airportSchiphol.iso_country = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 5)));
        airportSchiphol.municipality = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 6)));

        return airportSchiphol
    }
    
    func getAirportsByIso(iso_country: String) -> [Airport]?
    {
        var queryResultsAsAirports = [Airport]()
        let query = "SELECT * FROM airports WHERE iso_country = \""+iso_country+"\" ORDER BY name"
        // Prepare query and execute, I stole this part of the function
        var statement : COpaquePointer = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String.fromCString(sqlite3_errmsg(db))
            print("error query: \(errmsg)")
            return nil
        }
        
        // Convert results to objects
        while sqlite3_step(statement) == SQLITE_ROW {
            let airport = Airport();
            
            // ICAO code and naming
            airport.icao = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 0)));
            airport.name = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 1)));
            
            // GPS coordinates
            let longitude : CLLocationDegrees = sqlite3_value_double(sqlite3_column_value(statement, 2))
            let latitude : CLLocationDegrees = sqlite3_value_double(sqlite3_column_value(statement, 3))
            airport.location = CLLocationCoordinate2DMake(latitude, longitude)
            airport.elevation = sqlite3_value_double(sqlite3_column_value(statement, 4))
            
            // Country and city
            airport.iso_country = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 5)));
            airport.municipality = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 6)));
            
            // Check object and add to result
            queryResultsAsAirports.append(airport)
            
        }
        return queryResultsAsAirports
    }
    
    func getAirports() -> [Airport]?
    {
        var queryResultsAsAirports = [Airport]()
        
        // Prepare query and execute, I stole this part of the function
        var statement : COpaquePointer = nil
        if sqlite3_prepare_v2(db, ExampleQuery.selectIsoNL.rawValue, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String.fromCString(sqlite3_errmsg(db))
            print("error query: \(errmsg)")
            return nil
        }
        
        // Convert results to objects
        while sqlite3_step(statement) == SQLITE_ROW {
            let airport = Airport();
            
            // ICAO code and naming
            airport.icao = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 0)));
            airport.name = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 1)));
            
            // GPS coordinates
            let longitude : CLLocationDegrees = sqlite3_value_double(sqlite3_column_value(statement, 2))
            let latitude : CLLocationDegrees = sqlite3_value_double(sqlite3_column_value(statement, 3))
            airport.location = CLLocationCoordinate2DMake(latitude, longitude)
            airport.elevation = sqlite3_value_double(sqlite3_column_value(statement, 4))
            
            // Country and city
            airport.iso_country = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 5)));
            airport.municipality = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 6)));
            
            // Check object and add to result
            queryResultsAsAirports.append(airport)
            
        }
        return queryResultsAsAirports
    }
}