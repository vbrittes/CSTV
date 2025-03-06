//
//  MatchPlayerView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit
import Kingfisher

class MatchPlayerView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupInterface()
    }
    
    fileprivate func setupInterface() {
        backgroundColor = UIColor(named: "cell-bg-color")
    }
}

extension MatchPlayerView {
    private static var nibName: String {
        return "MatchPlayerView"
    }
    
    static func ibInstance() -> MatchPlayerView {
        return MatchPlayerView()
//        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! MatchPlayerView
    }
}
