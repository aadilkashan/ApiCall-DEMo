//
//  ViewController.swift
//  ApiCall
//
//  Created by Elite- 77 on 07/04/18.
//  Copyright © 2018 Aadil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
    var arr = NSArray()
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
        
        @IBAction func getBtn(_ sender: Any) {
            let url = URL(string: "http://mahindralylf.com/apiv1/getholidays")
            let task = URLSession.shared.dataTask(with: url!)  { (data, response, err) in
               print("Response here \(data)")
                //tempdata = data is optional binding.
                 if let tempdata = data{
                
                do{
                    let dict = try JSONSerialization.jsonObject(with: tempdata, options: .mutableContainers) as! NSDictionary
                    print("Dict is \(dict)")
                    
                    print(dict.value(forKey: "response_code") ?? "")
                    print(dict.value(forKey: "response_msg") ?? "")
                    print(dict.value(forKey: "holiday_count") ?? "")
                    
                   self.arr = dict.value(forKey: "holidays") as! NSArray
                    print("arr count is \(self.arr.count)")
                    
                    
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                    
                    
                }catch{
                    print("Exception")
                }
                 }else {
                    print("no data")
                }
                }
           task.resume()
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let monthDict = arr.object(at: section) as! NSDictionary
        return monthDict.value(forKey: "month") as? String
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let monthDict = arr.object(at: section) as! NSDictionary
        let detailsArr = monthDict.value(forKey: "details") as! NSArray
        
        return detailsArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        let monthDict = arr.object(at: indexPath.section) as! NSDictionary
        let detailsArr = monthDict.value(forKey: "details") as! NSArray
        let detailsDict = detailsArr.object(at: indexPath.row) as! NSDictionary
        cell.textLabel?.text = detailsDict.value(forKey: "title") as? String
       // cell.textLabel?.text = "ROW NUMBER\(indexPath.row)"
        return cell
    }
    
    
    
    
    
        @IBAction func postBtn(_ sender: Any) {
        }
        
       

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

