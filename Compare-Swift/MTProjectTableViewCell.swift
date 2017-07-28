//
//  MTProjectTableViewCell.swift
//  Compare-Swift
//
//  Created by X-Liang on 2017/7/14.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit
import Kingfisher

class MTProjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectDetailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var info: Dictionary<String, Any>? {
        didSet {
            guard let value = info else {
                return
            }
            if let urlStr = (value["imgurl"] as? String)?.replacingOccurrences(of: "w.h", with: "120.0"),
               let url = URL(string: urlStr) {
                let resource = ImageResource(downloadURL: url)
                detailImageView.kf.setImage(with: resource)
            }
            
            if let title = value["mname"] as? String {
                projectNameLabel.text = title
            }
            
            if let detail = value["title"] as? String {
                projectDetailLabel.text = detail
            }
            
            if let price = value["price"] as? Int {
                priceLabel.text = String(price) + "元 >"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
