//
//  CoinViewCell.swift
//  MarketCoins
//
//  Created by user239336 on 10/13/23.
//

import UIKit

class CoinViewCell: UITableViewCell {

    static let identifier = "CoinViewCell"
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var marketCapitalizationLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
