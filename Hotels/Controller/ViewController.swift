//
//  ViewController.swift
//  Hotels
//
//  Created by Евгений Фирман on 02.06.2021.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    let hotels = HotelsAPI()
    
    private var dataHotels =  [HotelsStruct]()


    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        hotels.delegate = self
        
        hotels.callAPI()
        
             
    }
}



// MARK: - HotelsManagerDelegate
extension ViewController: HotelsManagerDelegate{
 
    // Update hotels delegate
    func didUpdateHotels(hotels: [HotelsStruct]) {
        self.dataHotels = hotels
        
    }
    
    // Error handler
    func didCatchError(_ error: Error) {
        print(error)
    }
}

