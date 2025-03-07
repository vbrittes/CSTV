//
//  PlayerHTTPService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

import Alamofire

class PlayerHTTPService: PlayerService, HTTPPerformer {
    fileprivate lazy var http: Session = http()
    
    func fetchPlayers(match id: Int, completion: @escaping (_ result: [OpponentObject]?, _ error: Error?) -> Void) {
        
        let parameters: [String: Any] = [
            "page": "1",
            "per_page": "50",
            "token": API.apiToken
        ]
        
        http.request(API.matchOpponents(String(id)).url(),
                     method: .get,
                     parameters: parameters,
                     headers: defaultHeader)
        .validate()
        .responseDecodable(of: OpponentWrapperObject.self) { response in
            switch response.result {
            case .success(let opponent):
                print("success: \(response.request!.urlRequest!)")
//                print("\(self.prettyPrintedJSON(from: response.data)  ?? "")")
//                print("count: \(opponent.opponents.count)")
                completion(opponent.opponents, nil)
            case .failure(let error):
                print("failure: \(response.request!.urlRequest!)")
                //                    debug purpose
//                print("\(self.prettyPrintedJSON(from: response.data)  ?? "")")
                completion(nil, error)
            }
        }
    }
}
