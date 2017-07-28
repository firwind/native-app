//
//  GirderItem.swift
//  Compare-Swift
//
//  Created by X-Liang on 2017/7/14.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit
import Kingfisher

class GirderItem: UIView {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var info: Dictionary<String, Any>? {
        didSet {
            guard let info = info else {
                return 
            }
            if let urlStr = (info["imageurl"] as? String)?.replacingOccurrences(of: "w.h", with: "120.0"),
                let url = URL(string: urlStr) {
                let resource = ImageResource(downloadURL: url)
                detailImageView.kf.setImage(with: resource)
            }
            
            if let title = info["title"] as? String {
                titleLabel.text = title
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let subView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            subView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subView)
            
            let topConstraint = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            let leftConstraint = NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            let rightConstriant = NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
            addConstraints([topConstraint, leftConstraint, bottomConstraint, rightConstriant])
            
        }

    }
}
