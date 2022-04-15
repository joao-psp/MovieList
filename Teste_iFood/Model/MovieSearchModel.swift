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
    var overview: String?
    
   private enum CodingKeys: String, CodingKey {
       case title
       case posterPath = "poster_path"
       case id
       case overview
    }    
}
