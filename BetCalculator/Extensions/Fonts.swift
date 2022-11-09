//
//  Fonts.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 9.11.22.
//

import SwiftUI

extension Font {
    static func mainFont(size: CGFloat = 17, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .thin:
            return Font.custom("AppleSDGothicNeo-Thin", size: size)
        case .light:
            return Font.custom("AppleSDGothicNeo-Light", size: size)
        case .ultraLight:
            return Font.custom("AppleSDGothicNeo-UltraLight", size: size)
        case .medium:
            return Font.custom("AppleSDGothicNeo-Medium", size: size)
        case .semibold:
            return Font.custom("AppleSDGothicNeo-SemiBold", size: size)
        case .bold:
            return Font.custom("AppleSDGothicNeo-Bold", size: size)
        default:
            return Font.custom("AppleSDGothicNeo-Regular", size: size)
        }
    }
}
