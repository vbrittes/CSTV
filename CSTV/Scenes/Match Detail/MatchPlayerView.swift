//
//  MatchPlayerView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit
import Kingfisher

class MatchPlayerView: UIView {
    
    @IBOutlet var playerOneContainerView: UIView!
    @IBOutlet var playerOneNicknameLabel: UILabel!
    @IBOutlet var playerOneFullNameLabel: UILabel!
    @IBOutlet var playerOneImageView: UIImageView!
    
    @IBOutlet var playerTwoContainerView: UIView!
    @IBOutlet var playerTwoNicknameLabel: UILabel!
    @IBOutlet var playerTwoFullNameLabel: UILabel!
    @IBOutlet var playerTwoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupInterface()
    }
    
    fileprivate func setupInterface() {
        backgroundColor = .clear
        
        playerOneContainerView.backgroundColor = UIColor(named: "cell-bg-color")
        playerOneContainerView.layer.cornerRadius = 12
        playerOneContainerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        playerTwoContainerView.backgroundColor = UIColor(named: "cell-bg-color")
        playerTwoContainerView.layer.cornerRadius = 12
        playerTwoContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        let placeholderIV: [UIImageView] = [playerOneImageView, playerTwoImageView]
        placeholderIV.forEach { iv in
            iv.backgroundColor = UIColor(named: "placeholder-bg-color")
            iv.layer.cornerRadius = 8
            iv.layer.masksToBounds = true
        }
        
        playerOneNicknameLabel.textColor = .white
        
        playerTwoNicknameLabel.textColor = .white
    }
    
    func populate(pair describer: MatchPlayerPairDescriber) {
        playerOneNicknameLabel.text = describer.playerOneNickname
        playerOneFullNameLabel.text = describer.playerOneFullname
        playerOneImageView.kf.setImage(with: describer.playerOneImageURL)
        
        playerTwoNicknameLabel.text = describer.playerTwoNickname
        playerTwoFullNameLabel.text = describer.playerTwoFullname
        playerTwoImageView.kf.setImage(with: describer.playerTwoImageURL)
    }
}

extension MatchPlayerView {
    private static var nibName: String {
        return "MatchPlayerView"
    }
    
    static func ibInstance() -> MatchPlayerView {
        let instance = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! MatchPlayerView
        instance.translatesAutoresizingMaskIntoConstraints = false
        
        return instance
    }
}
