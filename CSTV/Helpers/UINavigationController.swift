//
//  UINavigationController.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 07/03/25.
//

import UIKit

struct NavigationBarAppearences {
    static var standardAppearence: UINavigationBarAppearance?
    static var scrollAppearence: UINavigationBarAppearance?
}

extension UINavigationController {
    func applyCustomStyling() {
        
        let backImage = UIImage(systemName: "arrow.backward")
        
        let barButtonAppearance = UIBarButtonItemAppearance(style: .plain)
                barButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        //When opaque
        let standardAppearence = UINavigationBarAppearance()
        standardAppearence.configureWithDefaultBackground()
        
        standardAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.mainBg]
        standardAppearence.titleTextAttributes = [.foregroundColor: UIColor.mainBg]
        standardAppearence.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        standardAppearence.backButtonAppearance = barButtonAppearance
        
        NavigationBarAppearences.standardAppearence = standardAppearence
        navigationBar.standardAppearance = standardAppearence
        
        //When transparent
        let scrollAppearence = UINavigationBarAppearance()
        scrollAppearence.configureWithTransparentBackground()
        
        scrollAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.primaryText]
        scrollAppearence.titleTextAttributes = [.foregroundColor: UIColor.primaryText]
        scrollAppearence.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        scrollAppearence.backButtonAppearance = barButtonAppearance
        
        NavigationBarAppearences.scrollAppearence = scrollAppearence
        navigationBar.scrollEdgeAppearance = scrollAppearence
        
        navigationBar.tintColor = .primaryText
    }
}
