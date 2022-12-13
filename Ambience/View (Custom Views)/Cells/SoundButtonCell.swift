//
//  SoundButtonCell.swift
//  Ambience
//
//  Created by Lucy Flores on 30/04/2021.
//

import UIKit

class SoundButtonCell: UICollectionViewCell {
    
    static let reuseID = "SoundButtonCell"
    
    lazy var buttonImageView = AmButton()
    let secondaryTitlelabel = AmSecondaryTitleLabel(textAlignment: .center, fontSize: 12)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.contentView.isUserInteractionEnabled = false // Fix 12/10/21: Tap not working on button. It is possible that the button's touchUpInside event is sent to the tableview's didSelectRowAt instead.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(soundButton: SoundsModel) {
        buttonImageView.tag = soundButton.buttonTag
        buttonImageView.setSoundButtonImage(named: soundButton.imageName)
        buttonImageView.backgroundColor = #colorLiteral(red: 0.01429648139, green: 0.169411391, blue: 0.118654348, alpha: 1)
        secondaryTitlelabel.text = soundButton.labelName
    }
    
    func changeButtonBackgroundColor(flag soundButtonPressed: Bool) {
        if soundButtonPressed  == true {
            buttonImageView.backgroundColor = #colorLiteral(red: 0, green: 0.8039215686, blue: 0.831372549, alpha: 1)
        } else {
            buttonImageView.backgroundColor = #colorLiteral(red: 0.2, green: 0.3019607843, blue: 0.3607843137, alpha: 1)
        }
    }
    
    private func configure() {
        contentView.addSubview(buttonImageView)
        contentView.addSubview(secondaryTitlelabel)
        
        let padding: CGFloat = 2
        
        NSLayoutConstraint.activate([
            buttonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            buttonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            buttonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            buttonImageView.heightAnchor.constraint(equalTo: buttonImageView.widthAnchor), // the width of the cell can vary is based on how width the screen is, but we want it the height = width to be a square
            secondaryTitlelabel.topAnchor.constraint(equalTo: buttonImageView.bottomAnchor, constant: 5),
            secondaryTitlelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),//, constant: 12),
            secondaryTitlelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)//, constant: -padding)
        ])
    }
    

}
