//
//  topRate.swift
//  APIMovies
//
//  Created by Consultant on 6/16/22.
//

import Foundation

struct topRate : Codable{
    
    var title : String
    var voteAverage :Float
    
    enum CodingKeys : String,CodingKey{
        case title = "title"
        case voteAverage = "vote_average"
    }
    
}

struct request : Codable{
    
    var page : Int
    var results : [topRate]
    
    
}
