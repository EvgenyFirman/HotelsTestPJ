//
//  HotelsAPI.swift
//  Hotels
//  Created by Евгений Фирман on 02.06.2021.
//

import UIKit

protocol HotelsManagerDelegate{
    
    func didUpdateHotels(hotels: [HotelsStruct])
    
    func didCatchError(_ error: Error)
}

class HotelsAPI {
    
    var delegate: HotelsManagerDelegate?
    
    var hotels = [HotelsStruct]()
    
    var hotelsAPI: String = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
    
    func hotelAPICall(_ url: String) {
        
        if let url = URL(string: url){
            
            let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url) { (data,urlResponse,error)  in
               
                if error == nil {
                
                    if let safeData = data {
                        
                        if self.decodeJSON(hotelsData: safeData) != nil{
                            
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
            print(decodedData)
        
                for i in 0..<decodedData.count {
                    
                    let id = decodedData[i].id
                    let name = decodedData[i].name
                    let address = decodedData[i].address
                    let stars = decodedData[i].stars
                    let distance = decodedData[i].distance
                    let suites_availability = decodedData[i].suites_availability
                    
                    hotel = HotelsStruct(id: id , name: name, address: address, stars: stars, distance: distance, suites_availability: suites_availability)
                    
                    if let uwrappedHotel = hotel {
                        self.hotels.append(uwrappedHotel)
                    }
                }
            
        } catch {
            self.delegate?.didCatchError(error)
            return nil
        }
        
        self.delegate?.didUpdateHotels(hotels: hotels)
        return hotel
    }
}

