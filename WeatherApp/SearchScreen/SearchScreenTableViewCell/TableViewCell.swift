//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Mert Karahan on 8.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var administrative: UILabel!
    @IBOutlet weak var county: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func searchConfigure(item: PlaceItem){
        administrative.text = item.administrative[0] + ","
        county.text = item.county?.default[0]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
