//
//  TaskTableViewCell.swift
//  Compare-Swift
//
//  Created by X-Liang on 2017/7/11.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var data: ItemData? {
        didSet {
            taskImageView.image = data?.image
            titleLabel.text = data?.title
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
