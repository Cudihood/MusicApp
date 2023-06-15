//
//  Constants.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit

enum Constants {
    static let dynamicTextColor = UIColor { (traitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }
    
    enum Spacing {
        static let standart = 16
        static let little = 6
    }
    
    enum Size {
        static let little = 60
        static let big = 200
        static let cornerRadius: CGFloat = 20
    }
    
    enum Font {
        static let title1 = UIFont.preferredFont(forTextStyle: .title1)
        static let title2 = UIFont.preferredFont(forTextStyle: .title2)
        static let title3 = UIFont.preferredFont(forTextStyle: .title3)
        static let body = UIFont.preferredFont(forTextStyle: .body)
    }
    
    enum Color {
        static let blue = UIColor.systemBlue
        static let background = UIColor.systemBackground
        static let red = UIColor.systemRed
    }
}
