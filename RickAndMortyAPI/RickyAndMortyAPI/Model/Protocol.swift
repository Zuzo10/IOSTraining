//
//  Protocol.swift
//  RickyAndMortyAPI
//
//  Created by Consultant on 6/14/22.
//

import Foundation

protocol connectAPI{
    
    func connAPI(url : String,completion: @escaping (Any) -> Void)

}
