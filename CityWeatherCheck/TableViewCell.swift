//
//  TableViewCell.swift
//  CityWeatherCheck
//
//  Created by Aset Bakirov on 24.10.2023.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelUrl: UILabel!
    
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
        let unixTime = news.time
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy, HH:mm:ss"
        //print(dateFormatter.string(from: date))
        labelTime.text = dateFormatter.string(from: date)
        labelScore.text = String(news.score)
        var urlString = news.url
        var url = URL(string: urlString)
        var domain = url?.host()
        labelUrl.text = domain
    }

}
