//
//  MovieTableViewCell.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Properties

    static var identifier: String { String(describing: Self.self) }
    var favouriteAction: (() -> Void)?

    // MARK: - Outlets

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    // MARK: - Button Actions

    @IBAction func favouriteButtonClicked() {
        favouriteAction?()
    }

    // MARK: - Helper Methods

    func configureCellWith(viewModel: MovieCellViewModel, action: (() -> Void)?) {
        self.favouriteAction = action

        posterImageView.image = nil
        ImageDownloader.shared.downloadImage(for: viewModel.imageURL) { [weak self] image in
            self?.posterImageView.image = image
        }

        titleLabel.text = viewModel.title
        ratingLabel.text = viewModel.ratingString
        playlistLabel.text = viewModel.playlistString
        playlistLabel.isHidden = !viewModel.addedToPlaylist
        let image = UIImage(systemName: viewModel.favouriteImage)
        favouriteButton.setImage(image, for: .normal)
    }
}
