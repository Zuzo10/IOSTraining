//
//  nowPlaying.swift
//  APIMovies
//
//  Created by Consultant on 6/16/22.
//

import Foundation

struct requestPlaying: Codable {
    
    var results : [nowPlaying]
    
}

struct nowPlaying : Codable{
    
    var title : String
    var popularity : Float
    
}
