//
//  ViewController.swift
//  Hotels
//  Created by Евгений Фирман on 02.06.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var tableVIEW: UITableView!
    
    var hotelImages = [HotelItemStruct]()
    
    var hotelImagesDecoded = [UIImage]()
    
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
        
        DispatchQueue.main.async {
            for i in 0..<self.hotelImages.count{
                let completedUrl = "https://github.com/iMofas/ios-android-test/raw/master/\(self.hotelImages[i].image!)"
                if hotelData.id == self.hotelImages[i].id {
                    cell.hotelImage.downloaded(from: completedUrl)
                }
            }
           
        }
      
        return cell
    }
    
    // MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "hotelDetail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hotelDetail"{
            _ = segue.destination as! DetailViewController
        }
    }
    
}


// MARK: - HotelsManagerDelegate

extension ViewController: HotelsManagerDelegate{
    
    func didUpdateImages(images: [HotelItemStruct]) {
        DispatchQueue.main.async {
            self.hotelImages = images
        }
        
    }
    
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

// MARK: - ImageView Extension for downloading
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
