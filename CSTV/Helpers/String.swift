//
//  String.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 07/03/25.
//

import Foundation

extension String {
    var fullNsRange : NSRange {
        return NSRange(self.startIndex..., in: self)
    }
    
    func fullRange(from nsRange: NSRange) -> Range<String.Index>? {
        return Range(fullNsRange, in: self)
    }
}
