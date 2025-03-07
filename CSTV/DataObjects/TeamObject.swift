//
//  TeamObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

struct TeamObject: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let imageURL: String?
    let players: [PlayerObject]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, players
        case imageURL = "image_url"
    }
}
