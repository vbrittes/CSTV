//
//  MatchDetailHeaderView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

import UIKit
import Kingfisher

final class MatchDetailHeaderView: UIView {

    @IBOutlet var firstTeamImageView: UIImageView!
    @IBOutlet var firstTeamNameLabel: UILabel!
    
    @IBOutlet var secondTeamImageView: UIImageView!
    @IBOutlet var secondTeamNameLabel: UILabel!
        
    @IBOutlet var vsLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    fileprivate lazy var dynamicWidthConstraint = NSLayoutConstraint(item: self,
                                                                     attribute: .width,
                                                                     relatedBy: .equal,
                                                                     toItem: nil,
                                                                     attribute: .notAnAttribute,
                                                                     multiplier: 1,
                                                                     constant: 0)
    
    var dynamicWidth: CGFloat {
        get {
            return dynamicWidthConstraint.constant
        }
        set {
            dynamicWidthConstraint.constant = newValue
        }
    }
    
    func populate(match describer: MatchDetailDescriber) {
        firstTeamImageView.loadWithCirclePlaceholder(url: describer.teamOneImageURL)
        
        firstTeamNameLabel.text = describer.teamOneName
        firstTeamNameLabel.font = .customRegular(size: 10)
        
        secondTeamImageView.loadWithCirclePlaceholder(url: describer.teamTwoImageURL)
        
        secondTeamNameLabel.text = describer.teamTwoName
        secondTeamNameLabel.font = .customRegular(size: 10)
        
        vsLabel.text = "vs"
        vsLabel.textColor = .secondaryText
        vsLabel.font = .customRegular(size: 12)
        
        dateLabel.text = describer.formattedStartDate
        dateLabel.font = .customBold(size: 12)
    }
    
    override func awakeFromNib() {
        setupInterface()
    }
}

fileprivate extension MatchDetailHeaderView {
    func setupInterface() {
        backgroundColor = .clear
        
        let labels: [UILabel] = [firstTeamNameLabel, secondTeamNameLabel, dateLabel]
        labels.forEach { l in
            l.textColor = .primaryText
            l.numberOfLines = 2
            l.lineBreakMode = .byTruncatingTail
            l.textAlignment = .center
        }
        
        let imageViews: [UIImageView] = [firstTeamImageView, secondTeamImageView]
        imageViews.forEach { iv in
            iv.backgroundColor = .placeholderBg
        }
        
        addConstraint(dynamicWidthConstraint)
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
