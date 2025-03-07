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
        loadImage(url: describer.teamOneImageURL, imageView: firstTeamImageView)
        firstTeamNameLabel.text = describer.teamOneName
        
        loadImage(url: describer.teamTwoImageURL, imageView: secondTeamImageView)
        secondTeamNameLabel.text = describer.teamTwoName
        
        dateLabel.text = describer.formattedStartDate
        
        loadImage(url: describer.leagueImageURL, imageView: leagueImageView)
        leagueNameLabel.text = describer.leagueName
        
        dateLabel.backgroundColor = .cellHighlightOnLabel
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupInterface()
    }

}

fileprivate extension MatchView {
    
    func loadImage(url: URL?, imageView: UIImageView) {
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.3))]) { result in
            switch result {
            case .success(let value):
                imageView.backgroundColor = .clear
            case .failure(_):
                imageView.backgroundColor = .placeholderBg
            }
            
        }
    }
    
    func setupInterface() {
        layer.cornerRadius = 16
        clipsToBounds = true
        
        dateLabel.layer.cornerRadius = 16
        dateLabel.layer.maskedCorners = [.layerMinXMaxYCorner]
        dateLabel.clipsToBounds = true
        
        vsLabel.text = "vs"
        vsLabel.textColor = .secondaryLabel
        
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
