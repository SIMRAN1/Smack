//
//  ChannelCell.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 26/02/18.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var ChannelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
}
    func configureCell(Channel:Channel)
    {
        let title = Channel.channelTitle ?? ""
        ChannelName.text = "#\(title)"
    }
}
