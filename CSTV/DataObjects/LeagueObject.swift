//
//  LeagueObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation

struct LeagueObject: Codable {
    let id: Int
    let name: String
    let imageUrl: String?
    let slug: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case imageUrl = "image_url"
    }
}
