//
//  FontExtension.swift
//  BetaCookie
//
//  Created by Anjin on 10/20/24.
//

import SwiftUI

extension Font {
    enum CookieFont {
        case gmarketBold
        case gmarketMedium
        case gmarketLight
        case glodok
        
        var font: String {
            switch self {
            case .gmarketBold:
                "GmarketSansBold"
            case .gmarketMedium:
                "GmarketSansMedium"
            case .gmarketLight:
                "GmarketSansLight"
            case .glodok:
                "Glodok-Display"
            }
        }
    }

    static func cookieFont(font: CookieFont, size: CGFloat) -> Font {
        return .custom(font.font, size: size)
    }
}

extension Font {
    static var cookieGmarketLight10: Font {
        Font.cookieFont(font: .gmarketLight, size: 10)
    }
    
    static var cookieGmarketLight12: Font {
        Font.cookieFont(font: .gmarketLight, size: 12)
    }
    
    static var cookieGmarketMedium32: Font {
        Font.cookieFont(font: .gmarketMedium, size: 32)
    }
    
    static var cookieGmarketMedium26: Font {
        Font.cookieFont(font: .gmarketMedium, size: 26)
    }
    
    static var cookieGmarketMedium15: Font {
        Font.cookieFont(font: .gmarketMedium, size: 15)
    }
    
    static var cookieGmarketMedium12: Font {
        Font.cookieFont(font: .gmarketMedium, size: 12)
    }
    
    static var cookieGmarketMedium10: Font {
        Font.cookieFont(font: .gmarketMedium, size: 10)
    }
    
    static var cookieGmarketBold12: Font {
        Font.cookieFont(font: .gmarketBold, size: 12)
    }
    
    static var cookieGmarketBold28: Font {
        Font.cookieFont(font: .gmarketBold, size: 28)
    }
    
    static var cookieGlodok32: Font {
        Font.cookieFont(font: .glodok, size: 32)
    }
}

