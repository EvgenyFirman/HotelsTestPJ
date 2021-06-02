//
//  HotelsAPI.swift
//  Hotels
//
//  Created by Евгений Фирман on 02.06.2021.
//

import UIKit

class HotelsAPI {
    
    var hotels = [HotelsStruct]()
    
    var hotelsAPI: String = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
    
    func hotelAPICall(_ url: String) {
        
        if let url = URL(string: url){
            
            let session = URLSession(configuration: .default)
        
            
            let task = session.dataTask(with: url) { (data,urlResponse,error)  in
               
                if error == nil {
                
                    if let safeData = data {
                        
                        if let hotel = self.decodeJSON(hotelsData: safeData){
                           
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func callAPI() {
        
        return hotelAPICall(hotelsAPI)
        
    }
    
    func decodeJSON(hotelsData: Data) -> HotelsStruct?{
        
        let decoder = JSONDecoder()
        
        var hotel: HotelsStruct?
        
        do {
            
            let decodedData = try decoder.decode([Results].self, from: hotelsData)
            
            for i in 0..<decodedData.count {
                
                let id = decodedData[i].id
                let name = decodedData[i].name
                let adress = decodedData[i].adress
                let stars = decodedData[i].stars
                let distance = decodedData[i].distance
                let suites_availibility = decodedData[i].suites_availibility
                
                hotel = HotelsStruct(id: id , name: name, adress: adress, stars: stars, distance: distance, suites_availibility: suites_availibility)
                
                if let uwrappedHotel = hotel {
                    self.hotels.append(uwrappedHotel)
                }
            }
            
        } catch {
            print(error)
        }
        
        return hotel
    }
}

