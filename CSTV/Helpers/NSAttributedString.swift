//
//  NSAttributedString.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 07/03/25.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func formattedErrorDisplay(content: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 44
        paragraphStyle.headIndent = 44
        paragraphStyle.tailIndent = -44
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attributedString = NSMutableAttributedString(string: content)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: content.fullNsRange)
        
        return attributedString
    }
}
