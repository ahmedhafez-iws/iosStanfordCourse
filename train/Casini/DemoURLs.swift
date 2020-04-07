//
//  DemoURLs.swift
//  train
//
//  Created by IT Wolf MacBook 1 on 4/7/20.
//  Copyright © 2020 IT Wolf MacBook 1. All rights reserved.
//

import Foundation

struct DemoURLs {
    
    // Stanford's Oval image
    static let stanford = Bundle.main.url(forResource: "oval", withExtension: "jpg")
    
    static var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            // (This Tesla image takes less time to download)
            "Cassini" : "https://insideevs.com/wp-content/uploads/2017/08/3840x2160-White-MS-Snowy-Mountain.jpg",
            // "Cassini" : "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn" : "https://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
