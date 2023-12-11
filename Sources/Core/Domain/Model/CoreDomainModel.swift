//
//  File.swift
//  
//
//  Created by hastu on 19/11/23.
//

import Foundation

public struct CoreDomainModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let released: String
    public let rating: Float
    public let ratingsCount: Int
    public let image: String
    public let imageAdditional: String
    public var genres: String
    public var screenshots: String
    public let web: String
    public let slug: String
    public let desc: String
    public var note: String
    public let tstamp: Double

    public init(id: Int, name: String, rating: Float, ratingsCount: Int, released: String,
                image: String, imageAdditional: String, desc: String, web: String, slug: String, genres: String,
                screenshots: String, note: String, tstamp: Double) {
        self.id = id
        self.name = name
        self.released = released
        self.rating = rating
        self.ratingsCount = ratingsCount
        self.image = image
        self.imageAdditional = imageAdditional
        self.genres = genres
        self.screenshots = screenshots
        self.web = web
        self.slug = slug
        self.desc = desc
        self.note = note
        self.tstamp = tstamp
    }

    public init(genres: String, screenshots: String) {
        self.id = 0
        self.name = "Unknown"
        self.released = ""
        self.rating = 0.0
        self.ratingsCount = 0
        self.image = ""
        self.imageAdditional = ""
        self.genres = genres
        self.screenshots = screenshots
        self.web = ""
        self.slug = ""
        self.desc = ""
        self.note = ""
        self.tstamp = 0
    }
}
