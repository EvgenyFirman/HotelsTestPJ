//
//  ViewController.swift
//  Hotels
//  Created by Евгений Фирман on 02.06.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var tableVIEW: UITableView!
    
    let hotels = HotelsAPI()
    
    let hotelItem = HotelItemAPI()
    
    private var dataHotels =  [HotelsStruct]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Hotels"
        // Do any additional setup after loading the view.
        hotels.delegate = self
        hotels.hotelAPICall()
        
   
    }

    
    // MARK: - TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataHotels.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableVIEW.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let hotelData = dataHotels[indexPath.row]
        
        cell.hotelName.text = hotelData.name
        
        cell.hotelStars.text = String(format:"%.0f", hotelData.stars)
        
        return cell
    }
    
    // MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "hotelDetail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hotelDetail"{
            let destinationVC = segue.destination as! DetailViewController
        }
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


// MARK: - Spinner
var aView: UIView?

extension UIViewController {
    
    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.center = aView!.center
        
        ai.startAnimating()
        
        aView?.addSubview(ai)
        
        self.view.addSubview(aView!)
    }
    
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
}
