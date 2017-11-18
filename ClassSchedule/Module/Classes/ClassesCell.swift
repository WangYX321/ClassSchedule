//
//  ClassesCell.swift
//  ClassSchedule
//
//  Created by wyx on 2017/11/18.
//  Copyright © 2017年 wyx. All rights reserved.
//

import UIKit

class ClassesCell: UITableViewCell {

    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
