//
//  PostVcViewController.swift
//  ApiCall
//
//  Created by Elite- 77 on 07/04/18.
//  Copyright © 2018 Aadil. All rights reserved.
//

import UIKit

class PostVcViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
   
    @IBOutlet weak var myTableview: UITableView!
    var arr = NSDictionary()
    var stateArr = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = URL(string: "http://stag-Kalyan.com/api/city_listing.php")
        var urlRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
        urlRequest.httpMethod = "POST"
        
        let postStr = "request=city_listing&device_type=ios"
        urlRequest.httpBody = postStr.data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
        print("Response here")
            do{
                let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                print("Dict is \(dict)")
                
                self.arr = dict.value(forKey: "city_array") as! NSDictionary
                self.stateArr = self.arr.allKeys as NSArray
                DispatchQueue.main.async {
                    self.myTableview.reloadData()
                }
                
                
            }catch{
                print("Exception")
            }
        }.resume()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.stateArr .object(at: section) as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stateKeyStr = self.stateArr.object(at: section) as! String
        let cityArr = self.arr.value(forKey: stateKeyStr) as! NSArray

        return cityArr.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        let stateKeyStr = self.stateArr.object(at: indexPath.section) as! String
        let cityArr = self.arr.value(forKey: stateKeyStr) as! NSArray

        cell.textLabel?.text = cityArr.object(at: indexPath.row) as? String
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
