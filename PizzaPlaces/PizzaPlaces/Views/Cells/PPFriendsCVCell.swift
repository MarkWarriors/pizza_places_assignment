//
//  PPFriendsCVCell.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 06/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit

class PPFriendsCVCell: UICollectionViewCell {

    static let identifier = "PPFriendsCVCell"
    @IBOutlet weak var friendImageView: PPRoundImageView!
    public var friend : PPFriend? {
        didSet {
            // not a good implementation, but is for finish the work
            DispatchQueue.main.async { [weak self] in
                if let self = self {
                    self.friendImageView.image = PPImages.placeholder
                
                    if let uri = self.friend?.avatarUrl, let url = URL(string: uri), let data = try? Data(contentsOf: url) {
                            self.friendImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
}
