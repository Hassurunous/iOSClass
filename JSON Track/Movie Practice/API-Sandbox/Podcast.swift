//
//  Podcast.swift
//  API-Sandbox
//
//  Created by Michael Loubier on 10/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Podcast {
    let name: String
    let rightsOwner: String
    let price: Double
    let link: String
    let releaseDate: String
    let poster: String
    let summary: String
    
    init(json: JSON) {
        self.name = json["im:name"]["label"].stringValue
        self.rightsOwner = json["rights"]["label"].stringValue
        self.price = json["im:price"]["attributes"]["amount"].doubleValue
        self.link = json["link"][0]["attributes"]["href"].stringValue
        self.releaseDate = json["im:releaseDate"]["attributes"]["label"].stringValue
        self.poster = json["im:image"][2]["label"].stringValue
        self.summary = json["summary"]["label"].stringValue
    }
}
