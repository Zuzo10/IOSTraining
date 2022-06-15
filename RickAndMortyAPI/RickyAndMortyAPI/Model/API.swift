//
//  API.swift
//  RickyAndMortyAPI
//
//  Created by Consultant on 6/14/22.
//

import Foundation
import UIKit

class apiRM{
    
    var name : String = ""
    var status : String = ""
    var species : String = ""
    var img : String = ""
    
    
    init(name: String, status:String, species:String,img:String){
        
        self.name = name
        self.status = status
        self.species = species
        self.img = img
        
    }
    
}

struct structConnect:connectAPI{

    func connAPI(url: String,completion: @escaping (Any) -> Void)  {
        var jsonArray3 = [Any]()
        
        let session = URLSession.shared
        guard let urlRes = URL(string: url) else{ return }
        
        let task = session.dataTask(with: urlRes){ data, response, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "No idea what happened")")
                return
            }
            
            guard let responseData = data else {
                print("Error:did not receive data")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Not a valid HTTP URL response")
                return
            }
            print("Response status code: \(httpResponse.statusCode)")
            print("Response status debugDescription: \(httpResponse.debugDescription)")
            print("Response status localizedStrinf: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
            
            //parse the result as json
            
            do{
                
                guard let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: []) else { return }
                print(jsonData)
                guard let jsonArray = jsonData as? [String:Any] else {
                    print("ERROR1")
                    return }
            
                guard let jsonArray2 = jsonArray["results"] as? [Any] else {
                    print("ERROR2")
                    return }
                
                jsonArray3 = jsonArray2
                completion(jsonArray3)
            }
        }
        task.resume()
       
    }
    
    
    
}
