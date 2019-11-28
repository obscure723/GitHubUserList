//
//  GitHubUserCell.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/28.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit

class GitHubUserCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var login: UILabel!
    
    @IBOutlet weak var siteAdmin: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
