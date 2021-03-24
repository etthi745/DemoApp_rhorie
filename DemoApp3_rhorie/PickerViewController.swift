//
//  PickerViewController.swift
//  DemoApp3_rhorie
//
//  Created by rhorie on 2021/03/09.
//

import UIKit

class PickerViewController: UIViewController {

   
    @IBOutlet weak var cusView: UIView!
    
    
    var r = CGFloat(0.0)
    var g = CGFloat(0.0)
    var b = CGFloat(0.0)
    
    
    @IBAction func rSlider(_ sender: UISlider) {
        r = CGFloat(sender.value/255)
        self.cusView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    @IBAction func gSlider(_ sender: UISlider) {
        g = CGFloat(sender.value/255)
        self.cusView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }

    @IBAction func bSlider(_ sender: UISlider) {
        b = CGFloat(sender.value/255)
        self.cusView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusView.backgroundColor = .black
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
