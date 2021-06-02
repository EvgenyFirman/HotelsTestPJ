//
//  HotelsAPI.swift
//  Hotels
//
//  Created by Евгений Фирман on 02.06.2021.
//

import UIKit

struct HotelsAPI {
    
    var hotelsAPI: String = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
    
    func hotelAPICall(_ url: String) {
        
        if let url = URL(string: url){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data,urlResponse,error) in
                
                if error == nil {
                    
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        
                        do {
                            
                            let results = try decoder.decode([Results].self, from: safeData)
                            
                            DispatchQueue.main.async {
                                
                                print(results[0].name)
                        
                            }
                            
                        }
                        catch {
                            print(error)
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
    
    }

