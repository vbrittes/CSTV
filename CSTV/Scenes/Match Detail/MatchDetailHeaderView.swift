//
//  MatchDetailHeaderView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

import UIKit
import Kingfisher

class MatchDetailHeaderView: UIView {

    @IBOutlet var firstTeamImageView: UIImageView!
    @IBOutlet var firstTeamNameLabel: UILabel!
    
    @IBOutlet var secondTeamImageView: UIImageView!
    @IBOutlet var secondTeamNameLabel: UILabel!
        
    @IBOutlet var vsLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        setupInterface()
    }
    
    private func setupInterface() {
        backgroundColor = .clear
        
        let labels: [UILabel] = [firstTeamNameLabel, secondTeamNameLabel, dateLabel]
        labels.forEach { l in
            l.textColor = .white
            l.numberOfLines = 2
            l.lineBreakMode = .byTruncatingTail
            l.textAlignment = .center
        }
        
        let imageViews: [UIImageView] = [firstTeamImageView, secondTeamImageView]
        imageViews.forEach { iv in
            iv.backgroundColor = UIColor(named: "placeholder-bg-color")
        }
    }
    
    func populate(match describer: MatchDetailDescriber) {
        firstTeamImageView.kf.setImage(with: describer.teamOneImageURL, options: [.transition(.fade(0.3))])
        firstTeamNameLabel.text = describer.teamOneName
        
        secondTeamImageView.kf.setImage(with: describer.teamTwoImageURL, options: [.transition(.fade(0.3))])
        secondTeamNameLabel.text = describer.teamTwoName
        
        vsLabel.text = "vs"
        
        dateLabel.text = describer.formattedStartDate
    }

}

extension MatchDetailHeaderView {
    private static var nibName: String {
        return "MatchDetailHeaderView"
    }
    
    static func ibInstance() -> MatchDetailHeaderView {
        let instance = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! MatchDetailHeaderView
        instance.translatesAutoresizingMaskIntoConstraints = false
        
        return instance
    }
}
