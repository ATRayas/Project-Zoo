//
//  AnimalCell.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/9/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import UIKit

class AnimalCell: UITableViewCell {

    @IBOutlet weak var AnimalImageView: UIImageView!{
        didSet {
            AnimalImageView.layer.cornerRadius = AnimalImageView.bounds.width / 2
            AnimalImageView.clipsToBounds = true
        }
    }
    
    //@IBOutlet weak var cityShortDescription: UILabel!
    @IBOutlet weak var AnimalName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
