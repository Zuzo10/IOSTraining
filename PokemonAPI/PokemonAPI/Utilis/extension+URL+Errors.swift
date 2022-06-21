//
//  extension+URL+Errors.swift
//  PokemonAPI
//
//  Created by Consultant on 6/17/22.
//

import Foundation

extension URLSession{
    enum urlErrors : Error{
        
        case badUrl
        case badData
    }
}
