//
//  SearchMovieService.swift
//  Teste_iFood
//
//  Created by João Pedro DTI on 15/04/22.
//

import Foundation

enum Error {
    case parseError(error: String)
}

enum completion2 {
    case sucess(movieSearch: [MovieSearchModel])
    case failure(error: Error )
}

class SearchMovieService {
    
    func fetchMovieSearch(query: String, onSuccess: @escaping ([MovieSearchModel]) -> Void, onFailure: @escaping (Error) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=edb4f3b3e78c5872021d690c027fe34c&language=pt-BR&query=\(query)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        guard let data = data else {return}
                        let movies = try JSONDecoder().decode(MovieSearchResult.self, from: data)
                        onSuccess(movies.results)
                    } catch {
                        onFailure(Error.parseError(error: "error"))
                    }
                }
            }
        }.resume()
    }
}
