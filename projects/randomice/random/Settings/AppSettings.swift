//
// AppSettings.swift
//

import Foundation
import UIKit

class AppSettings {
    struct fonts {
        static let featuredNumber: UIFont! = UIFont(name: "ArialRoundedMTBold", size: 120)
        static let inputNumber: UIFont! = UIFont(name: "ArialRoundedMTBold", size: 32)
        static let historyNumber: UIFont! = UIFont(name: "ArialRoundedMTBold", size: 26)
        static let historyCellNumber: UIFont! = UIFont(name: "ArialRoundedMTBold", size: 24)
        static let historyTotalNumber: UIFont! = UIFont(name: "ArialRoundedMTBold", size: 32)
        static let appTitle: UIFont! = UIFont(name: "ArialRoundedMTBold", size: 32)
        static let appVersion: UIFont! = UIFont(name: "ArialRoundedMTBold", size: 24)
        static let alertTitle: UIFont! = UIFont(name: "ArialRoundedMTBold", size: 32)
    }
    struct colors {
        static let themeRed: UIColor! = UIColor(red: 0.8, green: 0.0, blue: 0.2, alpha: 1.0)
        static let themeWhite: UIColor! = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let themeBlack: UIColor! = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        static let lightBlack: UIColor! = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        static let featuredNumber: UIColor! = themeRed
        static let inputNumber: UIColor! = themeRed
        
        static let historyNumber: UIColor! = themeRed
        static let historyCellNumber: UIColor! = themeRed
        static let historyTotalNumber: UIColor! = themeRed
        
        static let appTitle: UIColor! = themeRed
        static let appVersion: UIColor! = themeRed
        
        static let alertBorder: UIColor! = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        static let defaultBackground: UIColor! = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    struct sizes {
        static let buttonLarge: CGSize = CGSize(width: 80, height: 80)
    }
    
    struct views {
        struct root {
            static let backgroundColor = AppSettings.colors.defaultBackground
        }
        struct random {
            struct featuredNumber {
                static let font = AppSettings.fonts.featuredNumber
                static let color = AppSettings.colors.featuredNumber
            }
            struct inputNumber {
                static let font = AppSettings.fonts.inputNumber
                static let color = AppSettings.colors.inputNumber
            }
            struct historyNumber {
                static let font = AppSettings.fonts.historyNumber
                static let color = AppSettings.colors.historyNumber
            }
        }
        struct about {
            struct title {
                static let font = AppSettings.fonts.appTitle
                static let color = AppSettings.colors.appTitle
            }
            struct version {
                static let font = AppSettings.fonts.appVersion
                static let color = AppSettings.colors.appVersion
            }
        }
        struct history {
            struct number {
                static let font = AppSettings.fonts.historyCellNumber
                static let color = AppSettings.colors.historyCellNumber
            }
            struct total {
                static let font = AppSettings.fonts.historyTotalNumber
                static let color = AppSettings.colors.historyTotalNumber
            }
        }
        struct alert {
            struct title {
                static let font = AppSettings.fonts.alertTitle
                static let color = AppSettings.colors.themeRed
            }
        }
    }
}


