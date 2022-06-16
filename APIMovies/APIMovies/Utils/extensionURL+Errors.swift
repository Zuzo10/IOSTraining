//
//  extensionURL+Errors.swift
//  APIMovies
//
//  Created by Consultant on 6/16/22.
//

import Foundation

extension URLSession{
    
    enum requestErrors: Error{
        
        case badURL
        case badData
        
    }
}
