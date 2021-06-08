//
//  HotelsAPI.swift
//  Created by Евгений Фирман on 02.06.2021.

import UIKit


protocol HotelsManagerDelegate{
    func didUpdateImages(images: [HotelItemStruct])
    
    func didUpdateHotels(hotels: [HotelsStruct])
    
    func didCatchError(_ error: Error)
}


class HotelsAPI {
    
    var delegate: HotelsManagerDelegate?
    
    var hotels = [HotelsStruct]()
    
    let hotelItem = HotelItemAPI()

    func hotelAPICall(_ url: String = APIStructure.hotelsAPI) {
        
        if let url = URL(string: url){
            
            let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url) { (data,urlResponse,error)  in
               
                if error == nil {
                
                    if let safeData = data {
                        
                        if self.decodeJSON(hotelsData: safeData) != nil {
                            for i in 0..<self.hotels.count{
                                self.hotelItem.callAPI(self.hotels[i].id)
                            }
                            self.delegate?.didUpdateImages(images: self.hotelItem.hotelItem)
                        }
                    }
                } 
            }
            task.resume()
        }
    }
    
    
    func decodeJSON(hotelsData: Data){
        
        let decoder = JSONDecoder()
        
        var hotel: HotelsStruct?
        
        do {
            let decodedData = try decoder.decode([Results].self, from: hotelsData)
        
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
        }
        
        self.delegate?.didUpdateHotels(hotels: hotels)
    }

}
