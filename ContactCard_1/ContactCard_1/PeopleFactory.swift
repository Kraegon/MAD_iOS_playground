//
//  PeopleFactory.swift
//  ContactCard_1
//
//  Created by Julian West on 30/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PeopleFactory {
    static var people = [Person]()
    
    static let url = "https://randomuser.me/api/"
    
    static func GeneratePerson(){
        Alamofire.request(.GET, url).responseJSON
            { response in
                
            let json = JSON(response.result.value!)

            print("Response!")
            var person: Person
                
            person = Person(strFirstName: json["results"][0]["user"]["name"]["first"].string!,
                strLastName: json["results"][0]["user"]["name"]["last"].string!,
                imgPathLarge: json["results"][0]["user"]["picture"]["large"].string!,
                imgPathSmall: json["results"][0]["user"]["picture"]["thumbnail"].string!)!
            person.strFirstName = person.strFirstName.capitalizedString
            person.strLastName = person.strLastName.capitalizedString
            PeopleFactory.people.append(person)
            print(person.strFirstName+" has been born...")
            PeopleFactory.savePeople()
        }
    }
    
    
    static func savePeople(){//A True Hero
        if NSKeyedArchiver.archiveRootObject(people, toFile: Person.ArchiveURL.path!) {
            //Success case
        } else {
            print("Failed to save people 😢")
        }
    }
    
    static func loadPeople() -> Bool{
        if let tmpPeople = NSKeyedUnarchiver.unarchiveObjectWithFile(Person.ArchiveURL.path!) as? [Person] {
            PeopleFactory.people = tmpPeople
            return true
        } else {
            return false
        }
    }
    
    
    /* Doe de .GET
    let url = "https://randomuser.me/api/"
    Alamofire.request(.GET, url)
    .responseJSON { request, response, data in
        //print(data.value)
        
    
        
        // Serialize to person object
        PersonStore.sharedInstance.storePerson(
            json["results"][0]["user"]["name"]["first"].string!,
            last: json["results"][0]["user"]["name"]["last"].string!,
            title: json["results"][0]["user"]["name"]["title"].string!,
            username: json["results"][0]["user"]["username"].string!,
            imageurl: json["results"][0]["user"]["picture"]["large"].string!,
            phone: json["results"][0]["user"]["phone"].string!
        )
    }*/
}
