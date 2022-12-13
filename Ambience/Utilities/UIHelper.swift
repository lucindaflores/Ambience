//
//  UIHelper.swift
//  Ambience
//
//  Created by Lucy Flores on 03/05/2021.
//

import UIKit

enum UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        
        let padding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 25 : 25
        let minimumItemSpacing: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 35 : 30
        let widthForLabel: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 25 : 35
        
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
     
        print(width, " ", padding, " ", minimumItemSpacing, " ",availableWidth, " ", itemWidth)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + widthForLabel) //making the rectangle for the text
        flowLayout.minimumLineSpacing = 0
        
        return flowLayout
    }
}
