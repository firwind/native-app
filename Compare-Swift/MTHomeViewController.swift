//
//  MTHomeViewController.swift
//  Compare-Swift
//
//  Created by X-Liang on 2017/7/14.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit

class MTHomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var girderItems: [GirderItem]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var projectData: [Dictionary] = {
        return [Dictionary<String, Any>]()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecommend()
        loadDiscount()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: CGFloat(CGFloat(UIScreen.main.bounds.width - 60) / 5.0),
                                 height: CGFloat(CGFloat(UIScreen.main.bounds.width - 60) / 5.0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MTHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MTProjectTableViewCell", for: indexPath) as! MTProjectTableViewCell
        cell.info = projectData[indexPath.row]
        return cell
    }
}

extension MTHomeViewController {
    
    func loadDiscount() {
        guard let url = URL(string: Global.MTDiscount) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>,
                let proData = json["data"] as? [Dictionary<String, Any>] else { return }
            DispatchQueue.main.async {
                for (index, info) in proData.enumerated() {
                    self.girderItems[index].info = info
                }
                
            }
        }.resume()
        
        
    }
    
    func loadRecommend() {
        guard let url = URL(string: Global.MTRecommend) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>,
                let proData = json["data"] as? [Dictionary<String, Any>] else { return }
            self.projectData = proData + proData + proData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            }.resume()
    }
}

extension MTHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath)
        return cell
    }
}


