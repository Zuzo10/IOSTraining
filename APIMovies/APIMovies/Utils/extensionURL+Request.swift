//
//  extensionURL+Request.swift
//  APIMovies
//
//  Created by Consultant on 6/16/22.
//

import Foundation

extension URLSession{
    
    func getRequest<T:Codable>(url: URL?,decoding: T.Type,completion: @escaping (Result<T,Error>)->()){
        
        guard let url = url else {
            completion(.failure(requestErrors.badURL))
            return
        }
        
        let task = self.dataTask(with: url){ data, _, error in
            
            guard data != nil else {
                completion(.failure(requestErrors.badData))
                return
            }
            
            if let error = error {
                completion(.failure(error))
            }
          
            do{
                let jsonResult = try JSONDecoder().decode(decoding, from: data!)
                completion(.success(jsonResult))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
}
