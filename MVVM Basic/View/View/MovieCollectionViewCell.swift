//
//  MovieCollectionViewCell.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/17/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(movie: Movie) {
        if let poster_path = movie.poster_path {
            let url = URL.init(string: GetImage + poster_path)
            posterImageView.kf.setImage(with: url)
        }
    }
}

