//
//  ViewController.swift
//  searchApp
//
//  Created by Sikander Farooq on 2017-09-20.
//  Copyright © 2017 Sikander Farooq. All rights reserved.
//

import UIKit
import Alamofire

struct artist {
    let artistName : String!
    let image : UIImage!
}

class ArtistController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    //var artistNames = [String]()
    var artists = [artist]()
    
    var searchUrl = "http://api.deezer.com/search/artist?q=a"
    
    typealias JSONStandard = [String : AnyObject]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let ac = segue.destination as! AlbumController
        ac.artistName = artists[indexPath!].artistName
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        artists.removeAll()
        if searchText==""{
            self.tableView.reloadData()
        }
        else{
            let keywords = searchBar.text
            let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
            let searchURL = "http://api.deezer.com/search/artist?q=\(finalKeywords!)"
            callAlamo(url : searchURL);
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    
    func callAlamo(url : String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.parseData(JSONData : response.data!)
            
        });
    }
    
    func parseData(JSONData : Data) {
    
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            
            if let data = readableJSON["data"] as? [JSONStandard]{
                for i in 0..<data.count {
                    let item = data[i] as! JSONStandard
                    
                    let artistName = item["name"] as! String
                    let artistImageURL = URL(string: item["picture_small"] as! String)
                    let artistImageData = NSData(contentsOf: artistImageURL!)
                    let artistImage = UIImage(data: artistImageData as! Data)
                    
                    
                    artists.append(artist.init(artistName : artistName, image: artistImage))
                    
                    self.tableView.reloadData()
                }
                
            }
            
        
        }
        catch {
            print(error)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if artists.count > 0{
            let label = cell?.viewWithTag(1) as! UILabel
            label.text = artists[indexPath.row].artistName
            
            let artistimage = cell?.viewWithTag(2) as! UIImageView
            artistimage.image = artists[indexPath.row].image
            
        }
        
        return cell!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

