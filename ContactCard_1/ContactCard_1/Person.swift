//
//  Person.swift
//  ContactCard_1
//
//  Created by Julian West on 12/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit

//Serialisable to local storage
class Person: NSObject, NSCoding{
    struct PropertyKeys {
        static let firstNameKey = "firstName"
        static let lastNameKey = "lastName"
        static let imgPathLargeKey = "imgLarge"
        static let imgPathSmallKey = "imgSmall"
    }
    
    //static paths for our people
    static let DocumentsDir = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDir.URLByAppendingPathComponent("people")
    
    var strFirstName: String
    var strLastName: String
    var imgPathLarge: String?
    var imgPathSmall: String?
    
    required convenience init?(coder aDecoder: NSCoder){
        let strFirstName = aDecoder.decodeObjectForKey(PropertyKeys.firstNameKey) as! String
        let strLastName = aDecoder.decodeObjectForKey(PropertyKeys.lastNameKey) as! String
        let imgPathLargeKey = aDecoder.decodeObjectForKey(PropertyKeys.imgPathLargeKey) as! String
        let imgPathSmallKey = aDecoder.decodeObjectForKey(PropertyKeys.imgPathSmallKey) as! String
        
        self.init(strFirstName: strFirstName,
                strLastName: strLastName,
                imgPathLarge: imgPathLargeKey,
                imgPathSmall: imgPathSmallKey)
    }
    
    init?(strFirstName: String, strLastName: String, imgPathLarge: String?, imgPathSmall: String?) {
        self.strFirstName = strFirstName
        self.strLastName = strLastName
        self.imgPathLarge = imgPathLarge
        self.imgPathSmall = imgPathSmall
        super.init()
        if strFirstName.isEmpty || strLastName.isEmpty{
            return nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(strFirstName, forKey: PropertyKeys.firstNameKey)
        aCoder.encodeObject(strLastName, forKey: PropertyKeys.lastNameKey)
        aCoder.encodeObject(imgPathLarge, forKey: PropertyKeys.imgPathLargeKey)
        aCoder.encodeObject(imgPathSmall, forKey: PropertyKeys.imgPathSmallKey)
    }
}

