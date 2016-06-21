//
//  MessageCell.swift
//  ParseChat
//
//  Created by Simon Posada Fishman on 6/21/16.
//  Copyright © 2016 Simon Posada Fishman. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userLabel.text = ""

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
