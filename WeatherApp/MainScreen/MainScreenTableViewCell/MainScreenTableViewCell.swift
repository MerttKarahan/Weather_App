//
//  MainScreenTableViewCell.swift
//  WeatherApp
//
//  Created by Mert Karahan on 27.07.2022.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func tableViewConfigure(list: WeatherListItem) {
        clock.text = list.dt_txt
        temp.text = (String(Int(list.main.temp)) + "°")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
