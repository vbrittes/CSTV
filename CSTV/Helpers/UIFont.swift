//
//  UIFont.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 09/03/25.
//

import UIKit

extension UIFont {
    static func customRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size)!
    }
    
    static func customBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
}
