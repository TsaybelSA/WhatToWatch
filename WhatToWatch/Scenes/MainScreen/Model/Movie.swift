//
//  Movie.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 12.03.2023.
//

import UIKit

class Movie: NSObject {
    var title: String?
    var name: String?
    var coverImage: CoverImage?
    
    var type: String?
    var id: String?
    var titleType: String?
    var year: Int?
    var image: UIImage?
    
    override init() {
        self.title = ""
        self.name = ""
        
        super.init()
    }
    
    func set(title: String?, name: String?, imageURL: String?,
         type: String?, id: String?, titleType: String?, year: Int?,
             coverImage: CoverImage?) {
        self.title = title ?? ""
        self.name = name ?? ""
        self.coverImage = coverImage
        self.type = type
        self.id = id
        self.titleType = titleType
        self.year = year
        self.coverImage = coverImage
    }
    
    func set(image: UIImage?) {
        self.image = image
    }
}
struct CoverImage: Codable {
    var height: Double?
    var id: String?
    var url: String?
    var width: Double?
}
