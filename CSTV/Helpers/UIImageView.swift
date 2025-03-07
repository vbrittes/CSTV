//
//  UIImageView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 07/03/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadWithCirclePlaceholder(url: URL?) {
        kf.setImage(with: url, options: [.transition(.fade(0.5))]) { result in
            switch result {
            case .success(_):
                self.backgroundColor = .clear
                self.circleForm(enable: false)
            case .failure(_):
                self.backgroundColor = .placeholderBg
                self.circleForm(enable: true)
            }
            
        }
    }
}
