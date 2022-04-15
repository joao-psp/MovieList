//
//  MovieSearchCollectionViewCell.swift
//  Teste_iFood
//
//  Created by João Pedro DTI on 15/04/22.
//

import UIKit
import SDWebImage

class MovieSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var progressLoad: UIActivityIndicatorView!
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.cornerRadius = 16.0
        self.view.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
        self.view.layer.borderWidth = 4.0
        self.view.clipsToBounds = true
        self.posterImageView.clipsToBounds = true
    }
    
    func image(url: String) {
        if let url = URL(string: url) {
            posterImageView.sd_setImage(with: url) { (image, error, _, url) in
                self.progressLoad.stopAnimating()
            }
        }
    }
}

protocol MovieSearchCollectionViewDelegate: AnyObject {
    func cellTapped(movie: MovieSearchModel)
}

