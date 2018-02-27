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
        ChannelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for id in MessageService.instance.unreadChannels {
            if id == Channel.Id {
                ChannelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
    }
}
