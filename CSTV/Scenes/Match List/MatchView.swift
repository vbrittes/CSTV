//
//  MatchView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit
import Kingfisher

class MatchView: UIView {

    @IBOutlet var firstTeamImageView: UIImageView!
    @IBOutlet var firstTeamNameLabel: UILabel!
    
    @IBOutlet var secondTeamImageView: UIImageView!
    @IBOutlet var secondTeamNameLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var vsLabel: UILabel!
    @IBOutlet var separatorView: UIView!
    
    @IBOutlet var leagueImageView: UIImageView!
    @IBOutlet var leagueNameLabel: UILabel!
    
    func populate(match describer: MatchDescriber) {
        firstTeamImageView.kf.setImage(with: describer.teamOneImageURL)
        firstTeamNameLabel.text = describer.teamOneName
        
        secondTeamImageView.kf.setImage(with: describer.teamTwoImageURL)
        secondTeamNameLabel.text = describer.teamTwoName
        
        dateLabel.text = describer.formattedStartDate
        
//        leagueImageView
        leagueNameLabel.text = describer.leagueName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupInterface()
    }
    
    fileprivate func setupInterface() {
        layer.cornerRadius = 16
        clipsToBounds = true
        
        dateLabel.layer.cornerRadius = 16
        dateLabel.layer.maskedCorners = [.layerMinXMaxYCorner]
        dateLabel.clipsToBounds = true
        
        vsLabel.text = "vs"
        
        backgroundColor = UIColor(named: "")
    }

}

extension MatchView {
    private static var nibName: String {
        return "MatchView"
    }
    
    static func ibInstance() -> MatchView {
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! MatchView
    }
}
