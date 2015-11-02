//
//  SummaryViewController.swift
//  ContactCard_1
//
//  Created by Julian West on 12/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit
import Alamofire

class SummaryViewController: UIViewController {
    //Person information outlets
    @IBOutlet weak var person_img_view: UIImageView!
    @IBOutlet weak var firstName_lbl: UILabel!
    @IBOutlet weak var lastname_lbl: UILabel!
    
    //Local variables
    var doggle🐶: Bool = false //Get it? Toggle, doggle? Right? I'm hilarious.
    var person: Person!
    
    @IBAction func btn_action(sender: AnyObject) {
        if !doggle🐶{
            if let tmp_image = UIImage(named: "face1") {
                person_img_view.image = tmp_image
            }
            firstName_lbl.text = "Johnny"
            lastname_lbl.text = "Doe"
            doggle🐶 = true
        } else {
            if let tmp_image = UIImage(named: "male icon") {
                person_img_view.image = tmp_image
            }
            firstName_lbl.text = "First name"
            lastname_lbl.text = "Last name"
            doggle🐶 = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (person != nil) {
            firstName_lbl.text = person.strFirstName
            lastname_lbl.text = person.strLastName
            Alamofire.request(.GET, person.imgPathLarge!).response() {
                (req, res, data, error) in
                if error == nil {
                    let image = UIImage(data: data!)
                    self.person_img_view.image = image
                }
            }
        }
        
        // Do any additional setup after loading the view
        person_img_view.layer.cornerRadius = person_img_view.frame.width / 2.0
        person_img_view.layer.borderColor = UIColor.whiteColor().CGColor
        person_img_view.layer.borderWidth = 4.0
        person_img_view.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
