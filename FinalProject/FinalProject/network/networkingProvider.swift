//
//  networkingProvider.swift
//  FinalProject
//
//  Created by Consultant on 7/5/22.
//

import Foundation
import Alamofire

class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    private let sportsURL = "https://api.the-odds-api.com/v4/sports/?apiKey=05a0e401a43385ccf264ec9fa9bb15da"
    
    private let statusOK = 200...299
    
    func getSport(success: @escaping(_ sports :[listSports]) -> (), failure: @escaping(_ error: Error?) -> ()){
        
        AF.request(sportsURL, method: .get).validate(statusCode: statusOK).responseDecodable (of: [listSports].self){ response in
            
            if let sp = response.value{
                success(sp)
            }else{
                failure(response.error)
            }
            
        }
    }

}
