//
//  PlayerObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

struct PlayerObject: Codable {
    let active: Bool
    let age: Int?
    let birthday: String?
    let firstName: String?
    let id: Int
    let imageURL: String?
    let lastName: String?
    let modifiedAt: String?
    let name: String
    let nationality: String?
    let role: String?
    let slug: String

    enum CodingKeys: String, CodingKey {
        case active, age, birthday
        case firstName = "first_name"
        case id
        case imageURL = "image_url"
        case lastName = "last_name"
        case modifiedAt = "modified_at"
        case name, nationality, role, slug
    }
}
