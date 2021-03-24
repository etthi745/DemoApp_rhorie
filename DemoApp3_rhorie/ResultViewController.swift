//
//  ResultViewController.swift
//  DemoApp3_rhorie
//
//  Created by rhorie on 2021/03/22.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    var nameString = ""
    
    @IBOutlet weak var gender: UILabel!
    var genderString = ""
    
    @IBOutlet weak var birthday: UILabel!
    var year = ""
    var month = ""
    var day = ""
    
    @IBOutlet weak var age: UILabel!
    var ageString = ""
    
    @IBOutlet weak var ans: UITextView!
    var ansString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = nameString
        gender.text = genderString
        birthday.text = "\(year)年 \(month)月 \(day)日"
        age.text = "\(ageString)歳"
        ans.text = ansString
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

