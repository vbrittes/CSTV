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
    
    func populate(match describer: MatchListItemDescriber) {
        loadImage(url: describer.teamOneImageURL, imageView: firstTeamImageView)
        firstTeamNameLabel.text = describer.teamOneName
        
        loadImage(url: describer.teamTwoImageURL, imageView: secondTeamImageView)
        secondTeamNameLabel.text = describer.teamTwoName
        
        dateLabel.text = "test"//describer.formattedStartDate
        
        loadImage(url: describer.leagueImageURL, imageView: leagueImageView)
        leagueNameLabel.text = describer.leagueName
        
        dateLabel.backgroundColor = UIColor(named: "cell-highlight-on-label-color")
    }
    
    fileprivate func loadImage(url: URL?, imageView: UIImageView) {
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.3))]) { result in
            switch result {
            case .success(let value):
                imageView.backgroundColor = .clear
            case .failure(_):
                imageView.backgroundColor = UIColor(named: "placeholder-bg-color")
            }
            
        }
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
        vsLabel.textColor = .white
        vsLabel.alpha = 0.5
        
        separatorView.backgroundColor = .white
        separatorView.alpha = 0.2
        
        let labelsToFormat: [UILabel] = [firstTeamNameLabel, secondTeamNameLabel, leagueNameLabel, dateLabel]
        labelsToFormat.forEach { label in
            label.textColor = .white
            label.textAlignment = .center
            label.numberOfLines = 2
            label.lineBreakMode = .byTruncatingTail
        }
        
        backgroundColor = UIColor(named: "cell-bg-color")
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
