//
//  extension+UserDefault.swift
//  CodableDota
//
//  Created by Consultant on 6/20/22.
//

import Foundation

extension UserDefaults {
    
    private enum userDefaulKeys:String{
        case favorites
    }
    
    var favorites: [Int]{
        
        get{
            
            let data = array(forKey: userDefaulKeys.favorites.rawValue)
            return data as! [Int]
    
        }
        set{
            
           // if userDefaulKeys.favorites.contains(where: newValue) {
           //     removeObject(forKey: userDefaulKeys.favorites.rawValue)
          //  } else {
                setValue(newValue, forKey: userDefaulKeys.favorites.rawValue)
          //  }
            
        }
    }
    
  

}
