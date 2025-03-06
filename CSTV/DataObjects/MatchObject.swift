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

//struct MatchObject: Codable {
//    let id: Int
//    let name: String
//    let status: MatchStatus
//    let beginAt: String?
//    let league: LeagueObject
//    let opponents: [OpponentWrapperObject]
//    
//}

////Getters
//extension MatchObject {
//    fileprivate var dateFormatter: ISO8601DateFormatter { ISO8601DateFormatter() }
//
//    var beginAtDate: Date? {
//        guard let begin = beginAt else { return nil }
//        return dateFormatter.date(from: begin)
//    }
//}

//

// MARK: - Match
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
    let tournament: TournamentObject
    let videogame: VideoGameObject
    let opponents: [OpponentWrapperObject]
//        let results: [Result]
//        let games: [Game]
//        let live: Live
//        let streamsList: [Stream]
//        let winner: Winner?

    enum CodingKeys: String, CodingKey {
        case id, name, status, league, serie, tournament, videogame, opponents
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

// MARK: - VideoGame






//// MARK: - Result
//struct Result: Codable {
//    let score: Int
//    let teamId: Int
//
//    enum CodingKeys: String, CodingKey {
//        case score
//        case teamId = "team_id"
//    }
//}

//// MARK: - Game
//struct Game: Codable {
//    let id: Int
//    let matchId: Int
//    let position: Int
//    let status: String
//    let complete: Bool
//    let detailedStats: Bool
//    let finished: Bool
//    let forfeit: Bool
//    let length: Int?
//    let winner: Winner?
//    let winnerType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, position, status, complete, finished, forfeit, length, winner
//        case matchId = "match_id"
//        case detailedStats = "detailed_stats"
//        case winnerType = "winner_type"
//    }
//}

//// MARK: - Winner
//struct Winner: Codable {
//    let id: Int?
//    let type: String
//}
//
//// MARK: - Live
//struct Live: Codable {
//    let opensAt: Date?
//    let supported: Bool
//    let url: String?
//
//    enum CodingKeys: String, CodingKey {
//        case opensAt = "opens_at"
//        case supported, url
//    }
//}

//// MARK: - Stream
//struct Stream: Codable {
//    let name: String?
//    let url: String?
//    let language: String?
//}

