//
//  TableViewCell.swift
//  Hotels
//
//  Created by Евгений Фирман on 05.06.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelStars: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
