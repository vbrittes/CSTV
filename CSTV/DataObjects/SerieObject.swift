//
//  SerieObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import Foundation

struct SerieObject: Codable {
    let id: Int
    let name: String?
    let fullName: String
    let leagueId: Int
    let beginAt: String?
    let endAt: String?
    let modifiedAt: String?
    let season: String?
    let slug: String
    let winnerId: Int?
    let winnerType: String?
    let year: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, season, slug, year
        case fullName = "full_name"
        case leagueId = "league_id"
        case beginAt = "begin_at"
        case endAt = "end_at"
        case modifiedAt = "modified_at"
        case winnerId = "winner_id"
        case winnerType = "winner_type"
    }
}
