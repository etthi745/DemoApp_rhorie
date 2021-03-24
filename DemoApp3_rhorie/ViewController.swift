//
//  ViewController.swift
//  DemoApp3_rhorie
//
//  Created by rhorie on 2021/03/09.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    
    let items = ["Piker","Map","Play Video","Web View","View Pager","Form"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = myTableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
            
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showPickerSegue", sender: nil)
        case 1:
            performSegue(withIdentifier: "showMapSegue", sender: nil)
        case 2:
            performSegue(withIdentifier: "showPlayVideoSegue", sender: nil)
        case 3:
            performSegue(withIdentifier: "showWebViewSegue", sender: nil)
        case 4:
            performSegue(withIdentifier: "showViewPagerSegue", sender: nil)
        case 5:
            performSegue(withIdentifier: "showFormView", sender: nil)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    @IBAction func returnToTop (segue: UIStoryboardSegue) {
        
    }


}

