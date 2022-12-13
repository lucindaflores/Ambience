//
//  AmButtonStack.swift
//  Ambience
//
//  Created by Lucy Flores on 03/05/2021.
//

import UIKit

class AmButtonStack: UIStackView {

    let soundButton = AmButton()
    let soundButtonLabel = AmSecondaryTitleLabel(textAlignment: .center, fontSize: 10)
    let amButtonsStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(amButtonsStackView)
//        addSubview(soundButton)
//        addSubview(soundButtonLabel)
        

        
        amButtonsStackView.axis = .vertical
        amButtonsStackView.spacing = 5
        amButtonsStackView.distribution = .fillProportionally
        
       // amButtonsStackView.addArrangedSubview(soundButton)
        amButtonsStackView.addArrangedSubview(soundButtonLabel)
        
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            soundButton.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            soundButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            soundButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            soundButton.heightAnchor.constraint(equalToConstant: 80)
            
//            ,
//            
//            soundButtonLabel.topAnchor.constraint(equalTo: soundButton.bottomAnchor),
//            
//            soundButtonLabel.leadingAnchor.constraint(equalTo: amButtonsStackView.leadingAnchor, constant: padding),
//            soundButtonLabel.trailingAnchor.constraint(equalTo: amButtonsStackView.trailingAnchor, constant: -padding)
//            
//            
        
            
            
        ])
    }
    
    func setElements(text: String) {
        soundButton.backgroundColor = .cyan//UIColor(named: backgroundColor)
        soundButtonLabel.text = text
        soundButtonLabel.tintColor = .magenta
        
    }
    
    
}
