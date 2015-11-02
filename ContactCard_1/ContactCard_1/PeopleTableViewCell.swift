//
//  PeopleTableViewCell.swift
//  ContactCard_1
//
//  Created by Julian West on 13/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstname_lbl: UILabel!
    @IBOutlet weak var lastname_lbl: UILabel!
    @IBOutlet weak var person_img_view: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        person_img_view.layer.cornerRadius = person_img_view.frame.width / 2.0
        person_img_view.layer.borderColor = UIColor.blackColor().CGColor
        person_img_view.layer.borderWidth = 4.0
        person_img_view.clipsToBounds = true
    }
    
}
