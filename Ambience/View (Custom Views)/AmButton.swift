//
//  AmButton.swift
//  Ambience
//
//  Created by Lucy Flores on 02/04/2021.
//

import UIKit

class AmButton: UIButton {
    
    let edgeInset : CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Convenience Init for button titles
    convenience init(withAlphaComponent: CGFloat, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = UIColor.black.withAlphaComponent(withAlphaComponent)
        self.setTitle(title, for: .normal)
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    // MARK: - Convenience Init for button SFSymbol Big Configuration
    convenience init(image: String, pointSize: CGFloat) {
        self.init(frame: .zero)
        
        let largeConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .semibold, scale: .medium)
        let largeBoldIcon = UIImage(systemName: image, withConfiguration: largeConfiguration)
        
        self.setImage(largeBoldIcon, for: .normal)
        self.tintColor = .white
    }
    
    // MARK: - Convenience Init for button SFSymbol
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        
        self.setImage(image, for: .normal)
        self.tintColor = .white
    }
    
    // MARK: - Button Configuration
    private func configure(){
        layer.cornerRadius = elementCornerSize.size
        setTitleColor(.white, for: .normal)
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setSoundButtonImage(named: String){
        setImage(UIImage(named: named), for: .normal)
   
        imageView?.contentMode = .scaleAspectFill
        imageEdgeInsets = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
    
    
    
    func roundCornersToSquaredCorners(corner1: UIRectCorner, corner2: UIRectCorner) {
        self.layer.cornerRadius = 0
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [corner1, corner2], cornerRadii: CGSize(width: elementCornerSize.size, height: elementCornerSize.size))
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
}
