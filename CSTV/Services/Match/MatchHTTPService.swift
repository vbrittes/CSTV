//
//  MatchHTTPService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Alamofire

class MatchHTTPService: MatchService, HTTPPerformer {
    
    fileprivate lazy var http: Session = http()
    
    @discardableResult
    func fetchMatches(page: Int, perPage: Int, completion: @escaping (_ result: [MatchObject]?, _ error: Error?) -> Void) -> DataRequest? {
        
        let parameters: [String: Any] = [
            "sort": "begin_at",
            "page": page + 1,
            "per_page": perPage,
            "token": API.apiToken
        ]
        
        return http.request(API.matches.url(),
                     method: .get,
                     parameters: parameters,
                     headers: defaultHeader)
            .validate()
            .responseDecodable(of: [MatchObject].self) { response in
                switch response.result {
                case .success(let matches):
//                    print("success: \(response.request?.urlRequest)")
                    completion(matches, nil)
                case .failure(let error):
//                    print("failure: \(response.request?.urlRequest)")
//                    debug purpose
//                    print("\(self.prettyPrintedJSON(from: response.data)  ?? "")")
                    completion(nil, error)
                }
            }
    }
    
}
