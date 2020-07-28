//
//  ActorCollectionViewCell.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/22/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarActor: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCellWithCast(cast: Cast) {
        if let profile_path = cast.profile_path {
            let url = URL.init(string: GetImage + profile_path)
            avatarActor.kf.setImage(with: url)
        }
    }
    
    func configCellWithCrew(crew: Crew) {
        if let profile_path = crew.profile_path {
            let url = URL.init(string: GetImage + profile_path)
            avatarActor.kf.setImage(with: url)
        }
    }
}
