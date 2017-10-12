//
//  TableViewCell.swift
//  PokedexLab
//
//  Created by Yichen Sun on 10/11/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
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
