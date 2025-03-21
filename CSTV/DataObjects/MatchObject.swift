//
//  MatchObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation

enum MatchStatus: String, Codable {
    case notStarted = "not_started"
    case running
    case finished
    case postponed
    case canceled
}

struct MatchObject: Codable {
    let id: Int
    let name: String
    let status: MatchStatus
    let beginAt: String?
    let endAt: String?
    let modifiedAt: String?
    let scheduledAt: String?
    let originalScheduledAt: String?
    let detailedStats: Bool
    let draw: Bool
    let forfeit: Bool
    let gameAdvantage: Int?
    let numberOfGames: Int
    let matchType: String
    let rescheduled: Bool
    let slug: String
    let league: LeagueObject
    let serie: SerieObject
    let opponents: [OpponentObject]

    enum CodingKeys: String, CodingKey {
        case id, name, status, league, serie, opponents
        case beginAt = "begin_at"
        case endAt = "end_at"
        case modifiedAt = "modified_at"
        case scheduledAt = "scheduled_at"
        case originalScheduledAt = "original_scheduled_at"
        case detailedStats = "detailed_stats"
        case draw, forfeit
        case gameAdvantage = "game_advantage"
        case numberOfGames = "number_of_games"
        case matchType = "match_type"
        case rescheduled, slug
    }
}
