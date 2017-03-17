//
//  MasterViewController.swift
//  FungjaiTest
//
//  Created by hudsioo on 3/17/2560 BE.
//  Copyright © 2560 qoofhouse. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Media]()
    
    func requestDataAPI(){
        Alamofire.request("http://www.anop72.info/api/seed.json").responseData { response in
            if let data = response.result.value{
                let items = JSON(data).arrayObject as! [AnyObject]
                for item in items{
                    let obj = Media.init(mID:       (String(describing: item["id"] as? Int)),
                                         name:      (item["name"]    as? String)!,
                                         coverURL:  (item["cover"]   as? String)!,
                                         type:      (item["type"]    as? String)!)
                    self.objects.append(obj)
                }
                self.tableView.reloadData()
                
                print("\(items)")
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.requestDataAPI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        
    }


    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let obj = objects[indexPath.row]
        var identifier : String = ""
        if obj.type == .track {
            identifier = "TrackCell"
        }else if obj.type == .video{
            identifier = "VideoCell"
        }else if obj.type == .ads{
            identifier = "AdsCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustomCell
        
        Alamofire.request(obj.coverURL).responseData { response in
            cell.coverImageView.image = UIImage(data: response.data!, scale:1)
        }
        cell.titleLabel.text = obj.name
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let obj = objects[indexPath.row]
        if obj.type == .video{
            
            return 150.0
        }
        return 80.0
        
    }

    
    

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

