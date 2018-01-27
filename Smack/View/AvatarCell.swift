//
//  AvatarCell.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 27/01/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
   // @IBOutlet weak var avatarImg: UIImageView!
    
    @IBOutlet weak var avatarImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    
}

