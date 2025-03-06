//
//  PlayerHTTPService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

import Alamofire

struct PlayerObject: Codable {
    let active: Bool
    let age: Int?
    let birthday: String?
    let currentTeam: TeamObject?
    let currentVideogame: VideogameObject?
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
        case currentTeam = "current_team"
        case currentVideogame = "current_videogame"
        case firstName = "first_name"
        case id
        case imageURL = "image_url"
        case lastName = "last_name"
        case modifiedAt = "modified_at"
        case name, nationality, role, slug
    }
}

struct TeamObject: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case imageURL = "image_url"
    }
}

struct VideogameObject: Codable {
    let id: Int
    let name: String
    let slug: String
}

class PlayerHTTPService: PlayerService, HTTPPerformer {
    fileprivate lazy var http: Session = http()
    
    //team id
    
    //cs id: 3
    func fetchPlayers(team id: Int, completion: @escaping (_ result: [PlayerObject]?, _ error: Error?) -> Void) {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "authorization": "Bearer 37RdDYBEr8u_7om870eY2hyoBLs3tx_tkXaDpBKLksy_uEarHAo"
        ]
        
        let parameters: [String: Any] = [
            "filter[team_id][0]": String(id)
        ]
        
        http.request(API.players.url(params: [String(id)]),
                     method: .get,
                     parameters: parameters,
                     headers: headers)
            .validate()
            .responseDecodable(of: [PlayerObject].self) { response in
                switch response.result {
                case .success(let players):
                    completion(players, nil)
                case .failure(let error):
//                    debug purpose
//                    print("\(self.prettyPrintedJSON(from: response.data)  ?? "")")
                    completion(nil, error)
                }
            }
    }
}
