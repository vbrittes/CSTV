//
//  TournamentObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import Foundation

struct TournamentObject: Codable {
    let id: Int
    let name: String
    let slug: String
    let leagueId: Int
    let serieId: Int
    let beginAt: String?
    let endAt: String?
    let modifiedAt: String?
    let hasBracket: Bool
    let prizepool: String?
    let region: String?
    let tier: String?
    let type: String?
    let winnerId: Int?
    let winnerType: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, region, tier, type
        case leagueId = "league_id"
        case serieId = "serie_id"
        case beginAt = "begin_at"
        case endAt = "end_at"
        case modifiedAt = "modified_at"
        case hasBracket = "has_bracket"
        case prizepool
        case winnerId = "winner_id"
        case winnerType = "winner_type"
    }
}
