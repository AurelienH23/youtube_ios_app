//
//  ApiService.swift
//  youtube
//
//  Created by Aurélien Haie on 07/01/2017.
//  Copyright © 2017 Aurélien Haie. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //Error case
            if error != nil {
                print("ERROR = \(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as AnyObject!
                var videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    //Let's populate the videos
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                
                completion(videos)
            } catch let jsonError {
                print(jsonError)
            }
            
            //            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            }.resume()
    }
    
}
