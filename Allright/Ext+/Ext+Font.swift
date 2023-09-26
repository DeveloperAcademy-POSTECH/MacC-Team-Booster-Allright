//
//  Ext+Font.swift
//  Allright
//
//  Created by 최진용 on 2023/09/16.
//

import SwiftUI

struct NanumFont {
    static let bold = "NanumSquareRoundB"
    static let extraBold = "NanumSquareRoundEB"
    static let light = "NanumSquareRoundL"
    static let regular = "NanumSquareRoundR"
    static let otfBold = "NanumSquareRoundOTFB"
    static let otfExtraBold = "NanumSquareRoundOTFEB"
    static let otfLight = "NanumSquareRoundOTFL"
    static let oftRegular = "NanumSquareRoundOTFR"
}


extension Font {
    static func overlayTitle() -> Font {
        return Font.custom(NanumFont.extraBold, size: 40 * setFontSize())
    }
    static func playImage() -> Font {
        return Font.custom(NanumFont.extraBold, size: 40 * setFontSize())
    }
    static func cardBig() -> Font {
        return Font.custom(NanumFont.otfBold, size: 100 * setFontSize())
    }
    static func cardMedium() -> Font {
        return Font.custom(NanumFont.otfBold, size: 56 * setFontSize())
    }
    static func cardSmall() -> Font {
        return Font.custom(NanumFont.otfBold, size: 20 * setFontSize())
    }
    static func largeTitle() -> Font {
        return Font.custom(NanumFont.otfBold, size: 32 * setFontSize())
    }
    static func selectionTitle() -> Font {
        return Font.custom(NanumFont.otfBold, size: 28 * setFontSize())
    }
    static func title1() -> Font {
        return Font.custom(NanumFont.otfBold, size: 20 * setFontSize())
    }
    static func title2() -> Font {
        return Font.custom(NanumFont.otfBold, size: 16 * setFontSize())
    }
    static func body() -> Font {
        return Font.custom(NanumFont.otfBold, size: 14 * setFontSize())
    }
    static func caption1() -> Font {
        return Font.custom(NanumFont.otfBold, size: 12 * setFontSize())
    }

    

// MARK: - 추가로 사용되는 폰트 사이즈 여기서 추가.

    // swiftlint:disable:next cyclomatic_complexity
    static func setFontSize() -> Double {
        let height = UIScreen.screenHeight
        var size = 1.0

        switch height {
        case 480.0: // Iphone 3,4S => 3.5 inch
            size = 0.85
        case 568.0: // iphone 5, SE => 4 inch
            size = 0.9
        case 667.0: // iphone 6, 6s, 7, 8 => 4.7 inch
            size = 0.9
        case 736.0: // iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            size = 0.95
        case 812.0: // iphone X, XS => 5.8 inch, 13 mini, 12, mini
            size = 0.98
        case 844.0: // iphone 14, iphone 13 pro, iphone 13, 12 pro, 12
            size = 1
        case 852.0: // iphone 14 pro
            size = 1
        case 926.0: // iphone 14 plus, iphone 13 pro max, 12 pro max
            size = 1.05
        case 896.0: // iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch, 11 pro max, 11
            size = 1.05
        case 932.0: // iPhone14 Pro Max
            size = 1.08
        default:
            size = 1
        }
        return size
    }
}

extension Font {
    static func registerFonts() {
        self.register(name: NanumFont.bold, withExtension: "ttf")
        self.register(name: NanumFont.extraBold, withExtension: "ttf")
        self.register(name: NanumFont.light, withExtension: "ttf")
        self.register(name: NanumFont.regular, withExtension: "ttf")
        self.register(name: NanumFont.otfBold, withExtension: "otf")
        self.register(name: NanumFont.otfExtraBold, withExtension: "otf")
        self.register(name: NanumFont.otfLight, withExtension: "otf")
        self.register(name: NanumFont.oftRegular, withExtension: "otf")
    }
    
    static func register(name: String, withExtension: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: withExtension),CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        else {
            return print("failed to regist \(name) font")
        }
    }
}
