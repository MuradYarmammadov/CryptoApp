//
//  CryptoTableViewCell.swift
//  CryptoApp
//
//  Created by Murad Yarmamedov on 02.11.23.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var cryptoName: UILabel!
    @IBOutlet weak var cryptoValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var item: Crypto! {
        didSet {
            self.cryptoName.text = item.currency
            self.cryptoValue.text = item.price
        }
    }

}
