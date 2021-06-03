//
//  ViewController.swift
//  Hotels
//
//  Created by Евгений Фирман on 02.06.2021.
//

import UIKit

class ViewController: UITableViewController{
   
    let hotels = HotelsAPI()
    
    private var dataHotels =  [HotelsStruct]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        
        tableView.delegate = self
        // Do any additional setup after loading the view.
        hotels.delegate = self
        
        hotels.callAPI()
        
    }
    
// MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataHotels[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataHotels.count
    }
    
}



// MARK: - HotelsManagerDelegate
extension ViewController: HotelsManagerDelegate{
 
    // Update hotels delegate
    func didUpdateHotels(hotels: [HotelsStruct]) {
            self.dataHotels = hotels
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // Error handler
    func didCatchError(_ error: Error) {
        print(error)
    }
}

