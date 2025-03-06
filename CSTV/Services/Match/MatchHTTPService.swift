//
//  MatchHTTPService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Alamofire

class MatchHTTPService: MatchService, HTTPPerformer {
    
    fileprivate lazy var http: Session = http()
    
    func fetchMatches(completion: @escaping (_ result: [MatchObject]?, _ error: Error?) -> Void) {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "authorization": "Bearer 37RdDYBEr8u_7om870eY2hyoBLs3tx_tkXaDpBKLksy_uEarHAo"
        ]
        
        let parameters: [String: Any] = [
            "sort": "begin_at",
                        "page": "1",
                        "per_page": "10"
        ]
        
        http.request(API.matches.url(),
                     method: .get,
                     parameters: parameters,
                     headers: headers)
            .validate()
            .responseDecodable(of: [MatchObject].self) { [weak self] response in
                switch response.result {
                case .success(let matches):
                    completion(matches, nil)
                case .failure(let error):
                    //debug purpose
//                    print("\(self?.prettyPrintedJSON(from: response.data)  ?? "")")
                    completion(nil, error)
                }
            }
    }
    
//    func fetchMatch(id: Int, completion: @escaping (_ result: MatchObject?, _ error: Error?) -> Void) {
//        let headers: HTTPHeaders = [
//            "accept": "application/json",
//            "authorization": "Bearer 37RdDYBEr8u_7om870eY2hyoBLs3tx_tkXaDpBKLksy_uEarHAo"
//        ]
//        
//        http.request(API.matches.url(params: [String(id)]), method: .get, headers: headers)
//            .validate()
//            .responseDecodable(of: MatchObject.self) { [weak self] response in
//                switch response.result {
//                case .success(let match):
//                    completion(match, nil)
//                case .failure(let error):
//                    //debug purpose
////                    print("\(self?.prettyPrintedJSON(from: response.data)  ?? "")")
//                    completion(nil, error)
//                }
//            }
//    }
    
}
