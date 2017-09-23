//
//  TrackController.swift
//  searchApp
//
//  Created by Sikander Farooq on 2017-09-22.
//  Copyright © 2017 Sikander Farooq. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


struct track {
    let trackName : String!
    let duration : Int!
    let artist : String!
    let tracknr : Int!
    let disknr : Int!
}


class TrackController: UITableViewController {
    
    typealias JSONStandard = [String : AnyObject]
    
    var tracks = [track]()
    var image = UIImage()
    var albumName = String()
    var tracklistURL = String()
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var header: UITableViewCell!
    
    override func viewDidLoad() {
        
        print("22222222222222222222222222222222222222222222222222222222222222222222",tracklistURL)
        
        backgroundImage.image = image
        albumImage.image = image
        
        callAlamo(url: tracklistURL)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
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
            //print(readableJSON)
            print(readableJSON["data"])
            if let data = readableJSON["data"] as? [JSONStandard]{
                for i in 0..<data.count {
                    let item = data[i] as! JSONStandard
                    if let artist = item["artist"] {
                        let trackName = item["title"] as! String
                        let duration = item["duration"] as! Int
                        let artist = artist["name"] as! String
                        let tracknr = item["track_position"] as! Int
                        let disknr = item["disk_number"] as! Int
                        print(trackName, duration, artist)
                        
                        tracks.append(track.init(trackName : trackName, duration: duration, artist: artist, tracknr: tracknr, disknr: disknr))
                        
                        self.tableView.reloadData()
                    }
                    
                    
                }
                
            }
            
            
        }
        catch {
            print(error)
        }
           
    }
    
    
    func secondsToMinutesSeconds (seconds : Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell")
        if tracks.count > 0{
            let trackNrLabel = cell?.viewWithTag(4) as! UILabel
            let trackNameLabel = cell?.viewWithTag(1) as! UILabel
            let trackArtistLabel = cell?.viewWithTag(2) as! UILabel
            let trackDurationLabel = cell?.viewWithTag(3) as! UILabel
            
            
            
            var trackNr = String(describing: tracks[indexPath.row].tracknr!)
            trackNrLabel.text = trackNr
            trackNameLabel.text = tracks[indexPath.row].trackName
            trackArtistLabel.text = tracks[indexPath.row].artist
            
            let duration = secondsToMinutesSeconds(seconds: tracks[indexPath.row].duration)
            let min = String(describing: duration.0)
            let sec = String(describing: duration.1)
            trackDurationLabel.text = "\(min):\(sec)"
            
            if tracks[indexPath.row].tracknr! == 1 {
                let headerlabel = cell?.viewWithTag(5) as! UILabel
                headerlabel.isHidden = false
                headerlabel.isEnabled = false
                headerlabel.text = "Volume \(tracks[indexPath.row].disknr!)"
            }else{
                let headerlabel = cell?.viewWithTag(5) as! UILabel
                headerlabel.isHidden = true
            }
            
        }
        
        return cell!
    }
}
