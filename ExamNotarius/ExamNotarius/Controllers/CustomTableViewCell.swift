//
//  CustomTableViewCell.swift
//  ExamNotarius
//
//  Created by Александр on 17.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleExamLabel: UILabel!
    @IBOutlet weak var countQuestsLabel: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
