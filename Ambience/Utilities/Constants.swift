//
//  Constants.swift
//  Ambience
//
//  Created by Lucy Flores on 05/04/2021.
//

import UIKit

// Names for buttons & labels, also used for image names
enum buttonNames: String, CaseIterable {
    case whiteNoise = "White Noise"
    case pinkNoise = "Pink Noise"
    case brownNoise = "Brown Noise"
    case fan = "Fan"
    case washingMachine = "Washing Machine"
    case chimes = "Chimes"
    case ocean = "Ocean"
    case river = "River"
    case waterfall = "Waterfall"
    case rain = "Rain"
    case thunderstorm = "Thunderstorm"
    case wind = "Wind"
    case birds = "Birds"
    case crickets = "Crickets"
    case frogs = "Frogs"
}

enum SFSymbols {
    static let play = "play.circle"//UIImage(systemName: "play.circle")
    static let pause = "pause.circle"//UIImage(systemName: "pause.circle")
    static let chevron = "chevron.down"
    static let xMarkCircle = "xmark.circle.fill"
    static let xMark = "xmark"
}

enum elementCornerSize {
    static let size: CGFloat = 7.0
}

// For the keyboad in iphoneSE that covers the textField and button
enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 667.0//568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}


// Get the number of all possible enum cases
// let numOfCases = Frameworks.allCases.count

//Iterate over all enum cases:
//for framework in Frameworks.allCases {
//    print(framework.rawValue)
//}

//Or using a forEach method:
//Frameworks.allCases.forEach {
//    print($0.rawValue)
//}
