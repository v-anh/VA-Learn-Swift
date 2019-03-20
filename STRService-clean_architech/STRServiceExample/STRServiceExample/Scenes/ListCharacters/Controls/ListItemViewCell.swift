//
//  ListItemViewCell.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/15/19.
//

import UIKit

class ListItemViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptions: UILabel!
}

extension ListItemViewCell {
    
    func bind(_ model: ListCharactersModels.CharacterViewModel) {
        name.text = model.name
        descriptions.text = model.description
    }
}
