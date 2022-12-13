//
//  AmVolumeContainerView.swift
//  Ambience
//
//  Created by Lucy Flores on 17/06/2021.
//

import UIKit

class AmVolumeContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.5411764706, blue: 0.6039215686, alpha: 1) //UIColor.systemBackground.cgColor
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = .none //highlight? blur??
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
