//
//  MusicTableViewCell.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 4.01.2023.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
