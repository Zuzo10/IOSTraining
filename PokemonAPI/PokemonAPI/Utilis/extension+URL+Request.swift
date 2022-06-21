//
//  extension+URL+Request.swift
//  PokemonAPI
//
//  Created by Consultant on 6/17/22.
//

import Foundation

extension URLSession{
    
    func requestData<T:Codable>(url : URL?, decoding: T.Type,completion : @escaping(Result<T,Error>)->()){
        
        guard let url = url else {
            completion(.failure(urlErrors.badUrl))
            return
        }
        
        let task = self.dataTask(with: url){ Data, _, Error in
            
            guard Data != nil else {
                completion(.failure(urlErrors.badData))
                return
            }
            
            if let Error = Error {
                completion(.failure(Error))
            }
            
            do{
                let jsonData = try JSONDecoder().decode(decoding,from : Data!)
                completion(.success(jsonData))

            }catch{
                completion(.failure(error))
            }

        }
        task.resume()
        

    }
   

    
    
}
