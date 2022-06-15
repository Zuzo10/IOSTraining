//
//  Model.swift
//  NYSchools
//
//  Created by Consultant on 6/15/22.
//

import Foundation

protocol connection{
    
    func fetchData(url:String,completion: @escaping (Result<[dataSchool], APIError>) -> Void)
    func fetchDataDetails(dataDbn:String,completion: @escaping (Result<[dataDetails], APIError>) -> Void)
}

struct dataSchool : Codable {
    
    var dbn : String
    var schoolName:String
    
    enum CodingKeys : String,CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
    }
    
}

struct dataDetails : Codable {
    
    var dbn :String
    var schoolName:String
    var satCriticalReadingAvgScore :String
    var satMathAvgScore : String
    var satWritingAvgScore : String
    
    enum CodingKeys : String,CodingKey{
        
        case dbn    = "dbn"
        case schoolName = "school_name"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
        
    }
}

enum APIError: Error {
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case unknownError
}


struct getSchool:connection{
    
    static let shared = getSchool()
    
    func fetchData(url : String, completion: @escaping (Result<[dataSchool], APIError>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "Something stange happened")")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("server error!")
                return
            }
            
            guard data != nil else {
                print("Error: We have no data bub")
                return
            }
           
            do {
                
                let schools = try JSONDecoder().decode([dataSchool].self, from: data!)
                print("success")
                DispatchQueue.main.async {
                    completion(.success(schools))
                }
                
            } catch {
                print("Error1: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }

    func fetchDataDetails(dataDbn :String ,completion: @escaping (Result<[dataDetails], APIError>) -> Void) {
        
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "Something stange happened")")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("server error!")
                return
            }
            
            guard data != nil else {
                print("Error: We have no data bub")
                return
            }
           
            
            do {
                
                var details = try JSONDecoder().decode([dataDetails].self, from: data!)
                details = details.filter { $0.dbn == dataDbn}
                DispatchQueue.main.async {
                    completion(.success(details))
                }
                
            } catch {
                print("Error1: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
}


