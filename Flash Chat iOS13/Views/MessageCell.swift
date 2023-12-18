//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by New Guest on 18/12/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var leftMessageAvatar: UIImageView!
    
    @IBOutlet weak var rightMessageAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = messageView.frame.size.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
