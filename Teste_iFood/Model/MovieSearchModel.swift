//
//  MovieSearchModel.swift
//  Teste_iFood
//
//  Created by João Pedro DTI on 15/04/22.
//

import Foundation

struct MovieSearchResult: Decodable {
    var results: [MovieSearchModel]
}
struct MovieSearchModel: Decodable {
    
    var title: String?
    var posterPath: String?
    var id: Int?

    init(title: String?, posterPath: String?, id: Int) {
        self.title = title
        self.posterPath = posterPath
        self.id = id
    }
    
   private enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        let id = try container.decode(Int.self, forKey: .id)
        self.init(title: title, posterPath: "https://image.tmdb.org/t/p/original\(posterPath)", id: id)
    }
    
}
