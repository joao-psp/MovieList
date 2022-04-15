//
//  MovieSearchViewModel.swift
//  Teste_iFood
//
//  Created by João Pedro DTI on 15/04/22.
//

import Foundation

protocol MovieSearchViewModelDelegate: AnyObject {
    func onSuccess()
    func onFailure()
}

class MovieSearchViewModel {
    var movieList = [MovieSearchModel]()
    private var service: SearchMovieService
    
    weak var delegate: MovieSearchViewModelDelegate?
    var searchQuery: String {
        didSet {
           reloadSearch()
        }
    }

    init(service: SearchMovieService = SearchMovieService()) {
        self.service = service
        searchQuery = ""
    }

    func reloadSearch() {
        service.fetchMovieSearch(query: searchQuery) { result in
            self.movieList = result
            self.delegate?.onSuccess()
        } onFailure: { error in
            print(error)
        }
    }

    func numberOfSearch() -> Int {
         movieList.count
    }
}
