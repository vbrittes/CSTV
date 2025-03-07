//
//  MatchView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit
import Kingfisher

final class MatchView: UIView {

    @IBOutlet var firstTeamImageView: UIImageView!
    @IBOutlet var firstTeamNameLabel: UILabel!
    
    @IBOutlet var secondTeamImageView: UIImageView!
    @IBOutlet var secondTeamNameLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var vsLabel: UILabel!
    @IBOutlet var separatorView: UIView!
    
    @IBOutlet var leagueImageView: UIImageView!
    @IBOutlet var leagueNameLabel: UILabel!
    
    func populate(match describer: MatchListItemDescriber) {
        firstTeamImageView.loadWithCirclePlaceholder(url: describer.teamOneImageURL)
        firstTeamNameLabel.text = describer.teamOneName
        
        secondTeamImageView.loadWithCirclePlaceholder(url: describer.teamTwoImageURL)
        secondTeamNameLabel.text = describer.teamTwoName
        
        dateLabel.text = describer.formattedStartDate
        
        leagueImageView.loadWithCirclePlaceholder(url: describer.leagueImageURL)
        leagueNameLabel.text = describer.leagueName
        
        dateLabel.backgroundColor = .cellHighlightOnLabel
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupInterface()
    }

}

fileprivate extension MatchView {
    
    func setupInterface() {
        layer.cornerRadius = 16
        clipsToBounds = true
        
        dateLabel.layer.cornerRadius = 16
        dateLabel.layer.maskedCorners = [.layerMinXMaxYCorner]
        dateLabel.clipsToBounds = true
        
        vsLabel.text = "vs"
        vsLabel.textColor = .secondaryText
        
        separatorView.backgroundColor = .borderSeparator
        
        let labelsToFormat: [UILabel] = [firstTeamNameLabel, secondTeamNameLabel, leagueNameLabel, dateLabel]
        labelsToFormat.forEach { label in
            label.textColor = .primaryText
            label.textAlignment = .center
            label.numberOfLines = 2
            label.lineBreakMode = .byTruncatingTail
        }
        
        backgroundColor = .cellBg
    }
    
}

extension MatchView {
    private static var nibName: String {
        return "MatchView"
    }
    
    static func ibInstance() -> MatchView {
        let instance = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! MatchView
        instance.translatesAutoresizingMaskIntoConstraints = false
        
        return instance
    }
}
