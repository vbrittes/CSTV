//
//  UIView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 07/03/25.
//

import UIKit

extension UIView {
    func circleForm(enable: Bool) {
        layer.cornerRadius = enable ? frame.height / 2.0 : 0
        clipsToBounds = true
    }
}
