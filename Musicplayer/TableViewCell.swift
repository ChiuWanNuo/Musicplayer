//
//  TableViewCell.swift
//  Musicplayer
//
//  Created by ChiuWanNuo on 06/04/2020.
//  Copyright © 2020 ChiuWanNuo. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listsongnameLabel: UILabel!
    @IBOutlet weak var listsingerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
