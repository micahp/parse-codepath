//
//  MessageCell.swift
//  parse-codepath
//
//  Created by Micah Peoples on 2/23/17.
//  Copyright © 2017 micah. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
