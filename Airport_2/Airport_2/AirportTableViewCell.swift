//
//  AirportTableViewCell.swift
//  Airport_2
//
//  Created by Julian West on 21/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var airportNameLbl: UILabel!
    @IBOutlet weak var airportMunicipalityLbl: UILabel!
    @IBOutlet weak var isoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
