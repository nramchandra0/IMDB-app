//
//  MovieListViewController.swift
//  IMDB
//
//  Created by Ramchandra on 24/09/23.
//

import UIKit

class MovieListViewController: UIViewController {

    // MARK: - Properties

    let viewModel = MovieListViewModel()

    // MARK: - Outlets

    @IBOutlet weak var movieListTableView: UITableView!

    // MARK: - View LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.setupViewModel(view: self)
    }

    // MARK: - Button Action

    @IBAction func filterButtonAction() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Favourites", style: .default) { _ in
            self.viewModel.showFavouriteMovies()
        })
        alert.addAction(UIAlertAction(title: "All", style: .default) { _ in
            self.viewModel.showAllMovies()
        })
        self.present(alert, animated: true)
    }

    // MARK: - UI Helper Methods

    func setupUI() {
        let cellName = MovieTableViewCell.identifier
        let cellNib = UINib(nibName: cellName, bundle: .main)
        movieListTableView.register(cellNib, forCellReuseIdentifier: cellName)
        movieListTableView.dataSource = self
    }

}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell {
            let cellViewModel = viewModel.movieCellViewModel(at: indexPath.row)
            movieCell.configureCellWith(viewModel: cellViewModel, action: { [weak self, cellViewModel] in
                self?.viewModel.favouriteButtonAction(cellViewModel)
            })
            return movieCell
        }
        return UITableViewCell()
    }
}

extension MovieListViewController: MovieListViewInterface {
    func reloadMoviesTable() {
        movieListTableView.reloadData()
    }

    func reloadCell(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        DispatchQueue.main.async {
            self.movieListTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
