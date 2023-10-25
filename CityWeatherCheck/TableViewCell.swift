//
//  TableViewCell.swift
//  CityWeatherCheck
//
//  Created by Aset Bakirov on 24.10.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(news: NewsData) {
        labelTitle.text = news.title
        labelTime.text = String(news.time)
        labelScore.text = String(news.score)
    }

}
