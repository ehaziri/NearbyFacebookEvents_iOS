//
//  Event.swift
//  NearbyEventsFacebook
//
//  Created by Xona on 4/12/18.
//

import Foundation

class Event{
    let profilePicture: String
    let name: String
    let date: String
    let coverPicture: String
    let description: String
    let venue: String
    init(profilePicture: String, name: String, date: String, coverPicture: String, description: String, venue: String){
        self.profilePicture = profilePicture
        self.name = name
        self.date = date
        self.coverPicture = coverPicture
        self.description = description
        self.venue = venue
    }
}
