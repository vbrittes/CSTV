//
//  OpponentObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation

struct OpponentWrapperObject: Codable {
    let opponent: OpponentObject
    let type: String
}

struct OpponentObject: Codable {
    let id: Int
    let name: String
    let acronym: String?
    let location: String?
    let slug: String
    let imageUrl: String?
    let modifiedAt: String//Date?
    
    enum CodingKeys: String, CodingKey {
        case id, name, acronym, location, slug
        case imageUrl = "image_url"
        case modifiedAt = "modified_at"
    }
}
