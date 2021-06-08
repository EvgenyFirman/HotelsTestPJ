//
//  HotelItemAPI.swift
//  Hotels
//
//  Created by Евгений Фирман on 06.06.2021.
//

import UIKit

// API Call
 
class HotelItemAPI {
    
    var hotelImage = HotelImage()
    
    var hotelItem = [HotelItemStruct]()
    
    func callAPI(_ id: Int) {
        let url = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(id).json"
        hotelItemAPICall(url)
    }
    
    

    func hotelItemAPICall(_ url: String) {
        
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
    
    
    
    func decodeJSON(hotelsData: Data) {
        
        let decoder = JSONDecoder()
        
        var hotelItem: HotelItemStruct?
        
        do {
            
            let decodedData = try decoder.decode(HotelItemStruct.self, from: hotelsData)
            
                    let id = decodedData.id
                    let image = decodedData.image
                    
                    hotelItem = HotelItemStruct(id:id ,image: image)
                    
                    if let unwrappedHotelItem = hotelItem {
                        self.hotelItem.append(unwrappedHotelItem)
                    }
        } catch {
           print("Error")
        }
    }
}


