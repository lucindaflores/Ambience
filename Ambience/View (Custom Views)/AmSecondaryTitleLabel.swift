//
//  AmSecondaryTitaleLabel.swift
//  Ambience
//
//  Created by Lucy Flores on 30/04/2021.
//

import UIKit

class AmSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame:.zero)
        self.textAlignment = textAlignment
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        textColor = .white
        //adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        translatesAutoresizingMaskIntoConstraints = false
    }

}
