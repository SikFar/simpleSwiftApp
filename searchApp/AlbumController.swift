//
//  AlbumController.swift
//  searchApp
//
//  Created by Sikander Farooq on 2017-09-21.
//  Copyright © 2017 Sikander Farooq. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


struct album {
    let albumCover : UIImage!
    let albumName : String!
    let artistName : String!
    let tracklist: String!
}

class AlbumController: UICollectionViewController {
    
    var selectedIndexPath = Int()
    var albums = [album]()
    
    var artistName = String()
    
    
    typealias JSONStandard = [String : AnyObject]
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView?.indexPath(for: cell) {
            let tc = segue.destination as! TrackController
            tc.image = albums[indexPath[1]].albumCover
            tc.albumName = albums[indexPath[1]].albumName
            tc.tracklistURL = albums[indexPath[1]].tracklist
        }
    }
    
    override func viewDidLoad() {
        
        activityIndicator.startAnimating()
        let finalArtistName = artistName.replacingOccurrences(of: " ", with: "+")
        let albumURL = "http://api.deezer.com/search/album?q=\(finalArtistName)"
        callAlamo(url: albumURL)
        
    }
    
    
  
    
    func callAlamo(url : String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.parseData(JSONData : response.data!)
            
        });
    }
    
    func parseData(JSONData : Data) {
        
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            
            if let data = readableJSON["data"] as? [JSONStandard]{
                for i in 0..<data.count {
                    let item = data[i] as! JSONStandard
                    if let artist = item["artist"] {
                        let artistName = artist["name"] as! String
                        let trackListURL = item["tracklist"] as! String
                        let albumName = item["title"] as! String
                        let albumCoverImageURL = URL(string: item["cover_xl"] as! String)
                        let albumCoverImageData = NSData(contentsOf: albumCoverImageURL!)
                        let albumCoverImage = UIImage(data: albumCoverImageData as! Data)
                        
                        
                        albums.append(album.init(albumCover: albumCoverImage, albumName: albumName, artistName : artistName, tracklist: trackListURL))
                        
                        self.collectionView?.reloadData()
                        
                    }
                    
                }
                
            }
            
        }
        catch {
            print(error)
        }
    }
    
  
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let albumCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath)
        
        let albumImage = albumCell.viewWithTag(3) as! UIImageView
        let albumNameLabel = albumCell.viewWithTag(2) as! UILabel
        let artistLabel = albumCell.viewWithTag(1) as! UILabel
        
        albumImage.image = albums[indexPath.row].albumCover
        albumNameLabel.text = albums[indexPath.row].albumName
        artistLabel.text = albums[indexPath.row].artistName
        
        activityIndicator.stopAnimating()
        return albumCell
    }
}
