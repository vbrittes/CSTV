//
//  Array.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 07/03/25.
//

extension Array {
    func safeFind(index: Int) -> Element? {
        guard index < count else {
            return nil
        }
        
        return self[index]
    }
}
