//
//  HearthstoneCardViewCell.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import UIKit

class HearthstoneCardViewCell: UITableViewCell {
    @IBOutlet weak var nameCard: UILabel!
    
    @IBOutlet weak var cardSet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HearthstoneCardViewCell {
    
    func bind(_ model: ListHearthstoneCardsModels.HearthstoneCardViewModel) {
        nameCard.text = model.name
        cardSet.text = model.cardSet
    }
}
