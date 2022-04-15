//
//  ViewController.swift
//  Teste_iFood
//
//  Created by João Pedro DTI on 15/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var collectionView: UICollectionView!

    private var movieSearchViewModel: MovieSearchViewModel = MovieSearchViewModel()
    private var movieList = [MovieSearchModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieSearchViewModel.delegate = self
        setupSearchBar()
        setupCollectionView()
    }

    private func setupSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.searchTextField.textColor = .black
    }

    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib (nibName: "MovieSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellid")
    }
}

extension ViewController: MovieSearchViewModelDelegate {
    func onSuccess() {
        self.collectionView.reloadData()
    }
    
    func onFailure() {
        let alert = UIAlertController(title: "Erro", message: "Tente mais tarde!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            movieSearchViewModel.searchQuery = searchText
        } else if searchText.isEmpty {
            movieSearchViewModel.movieList.removeAll()
            collectionView.reloadData()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieSearchViewModel.searchQuery = searchBar.text ?? ""
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieSearchViewModel.numberOfSearch()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! MovieSearchCollectionViewCell
        cell.image(url: movieSearchViewModel.movieList[indexPath.row].posterPath ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 3)-4, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: movieSearchViewModel.movieList[indexPath.row].title,
                                      message: movieSearchViewModel.movieList[indexPath.row].overview,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
