//
//  SoundPlayerUIView.swift
//  Ambience
//
//  Created by Lucy Flores on 11/05/2021.
//

import UIKit

class SoundPlayerView: UIView {

    let soundPlayingLabel = AmSecondaryTitleLabel(textAlignment: .left, fontSize: 15)
    let soundNameLabel = AmSecondaryTitleLabel(textAlignment: .left, fontSize: 15)
    let pausePlayButton = AmButton(image: SFSymbols.pause, pointSize: 30.0)
    let chevronButton = AmButton(image: SFSymbols.chevron, pointSize: 20.0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUIView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(chevronButton)
        addSubview(soundPlayingLabel)
        addSubview(soundNameLabel)
        addSubview(pausePlayButton)

        backgroundColor = #colorLiteral(red: 0.2778919459, green: 0.4184262752, blue: 0.5, alpha: 1)
        layer.cornerRadius =  elementCornerSize.size

        chevronButton.contentMode = .scaleAspectFit
        
        soundPlayingLabel.text = "Playing:"
        soundPlayingLabel.lineBreakMode = .byClipping

        soundNameLabel.lineBreakMode = .byTruncatingTail
  
        pausePlayButton.contentMode = .scaleToFill
        
    }
    
    func updateSoundNameLabel(text: String) {
        soundNameLabel.text = text
    }
    
    func pausePlayButtonPressed(systemName: String){
        let largeConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold, scale: .medium)
        
        let largeBoldIcon = UIImage(systemName: systemName, withConfiguration: largeConfiguration)

        pausePlayButton.setImage(largeBoldIcon, for: .normal)
    }
    
    
    private func layoutUIView() {
        chevronButton.translatesAutoresizingMaskIntoConstraints = false
        soundPlayingLabel.translatesAutoresizingMaskIntoConstraints = false
        soundNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pausePlayButton.translatesAutoresizingMaskIntoConstraints = false
        

        
        NSLayoutConstraint.activate([
            
            chevronButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            //chevronButton.widthAnchor.constraint(equalToConstant: 20),
            chevronButton.heightAnchor.constraint(equalTo: chevronButton.widthAnchor),
            
            soundPlayingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            soundPlayingLabel.leadingAnchor.constraint(equalTo: chevronButton.trailingAnchor, constant: 5),
            soundPlayingLabel.widthAnchor.constraint(equalToConstant: 54),
            
            soundNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            soundNameLabel.leadingAnchor.constraint(equalTo: soundPlayingLabel.trailingAnchor, constant: 5),
            soundNameLabel.trailingAnchor.constraint(equalTo: pausePlayButton.leadingAnchor, constant: -5),
            
            pausePlayButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            pausePlayButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            pausePlayButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            pausePlayButton.widthAnchor.constraint(equalTo: pausePlayButton.heightAnchor)
        ])
    }
    

}
