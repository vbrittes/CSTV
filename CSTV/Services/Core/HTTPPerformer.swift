//
//  HTTPService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Alamofire
import Foundation

protocol HTTPPerformer {
}

extension HTTPPerformer {
    func http() -> Session {
        return AF
    }
    
    func prettyPrintedJSON(from data: Data?) -> String? {
        guard let data = data else {
            return nil
        }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8)
        } catch {
            print("Error formatting JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
