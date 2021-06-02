//
//  ViewController.swift
//  Hotels
//
//  Created by Евгений Фирман on 02.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let hotels = HotelsAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hotels.callAPI()
    }


}

