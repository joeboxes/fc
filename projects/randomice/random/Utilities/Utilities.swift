//
//  Utilities.swift
//

import UIKit
// import SnapKit


class Utilities {
    
    static func initialize() {
        srand48(time(nil))
    }
    
    static func random() -> Double {
        return drand48()
    
    }
    
    static func randomInt(_ min: Int, _ max: Int) -> Int { // inclusive
        if min==max {
            return min
        }
        let num = random()
        let ran = max - min + 1
        return Int( Double(min) + floor(num*Double(ran)) )
    }
    
    static func randomIntNoRepeat(_ min: Int, _ max: Int, _ list: NSArray) -> (Int, Bool) { // NSNumber
        let ran = max - min + 1
        if ran > 0 {
            if min==max { // just check for single number = min
                for value in (list as! [NSNumber]) {
                    if value.intValue == min {
                        return (0, false)
                    }
                }
                return (min, true)
            }
            var existing = [(Int,Bool)]()
            for i in 0...ran-1 {
                existing.append( (min+i, false) )
            }
            for value in (list as! [NSNumber]) {
                let local = value.intValue - min
                if 0<=local && local<ran { // replace with found
                    existing[local] = (local+min,true)
                }
            }
            var remaining = [Int]()
            for item in existing {
                if !item.1 {
                    remaining.append(item.0)
                }
            }
            if remaining.count > 0 {
                let index = randomInt(0,remaining.count-1)
                let value = remaining[index]
                return (value, true)
            }
        }
        return (0, false)
    }
    
    
    
    
    
    
    
    
    
    
    static func bundleString(key: String, _ defaultValue: String = "") -> String {
        var value = defaultValue
        if let dictionary = Bundle.main.infoDictionary {
            value = dictionary[key] as? String ?? value
        }
        return value
    }
    
    static func appVersionNumber() -> String {
        return bundleString(key: "CFBundleShortVersionString", "")
    }
    
    static func appBuildNumber() -> String {
        return bundleString(key: "CFBundleVersion", "")
    }
    
    static func appDisplayName() -> String {
        return bundleString(key: "CFBundleDisplayName", "")
    }
    
    
    static func appendURLQueryParameters(_ url: String, _ parameters: [String:String]) -> String {
        if var components = URLComponents(string: url) {
            var queryItems: [URLQueryItem]
            if let items = components.queryItems {
                queryItems = items
            } else {
                queryItems = [URLQueryItem]()
            }
            let keys = parameters.keys
            for key in keys {
                let value = parameters[key]
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            components.queryItems = queryItems
            if let newURL = components.url {
                return newURL.absoluteString
            } else {
                print("components.asURL() - url - threw \(url)")
            }
        }
        return url
    }
    
    static func isLowPowerModeOn() -> Bool {
        return ProcessInfo.processInfo.isLowPowerModeEnabled
    }
    // "updated_at": "2017-12-28T10:38:02-08:00",
    // 2017-11-16T21:09:39-08:00
    //  2017-12-28 18:38:02 +0000
    static func parseDateFromISO8601(_ date: String) -> Date? {
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        // possibly try different formats if a fail happens
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateObject = formatter.date(from: date)
        return dateObject
    }
    
    static func URLSafeString(_ string: String) -> String {
        let trim = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let escaped = trim.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) ?? ""
        return escaped
    }
    
    static func secondsToHumanReadableTime(_ seconds: CGFloat) -> String {
        var sec: Int = Int(seconds)
        let hours: Int = sec / 3600
        sec = sec - hours * 3600
        let minutes: Int = sec / 60
        sec = sec - minutes * 60
        var time = ""
        // TODO: prefix with 0
        // hours
        if hours > 0 {
            time = time + "\(hours)"
        }
        // minutes
        //if minutes > 0 {
        if time.count > 0 {
            //time = time + ":" + ("\(minutes)".padding(toLength: 2, withPad: "0", startingAt: 0))
            let s = "\(minutes)"
            time = time + ":" + ("".padding(toLength: 2-s.count, withPad: "0", startingAt: 0)) + s
        } else {
            time = time + "\(minutes)"
        }
        //}
        // seconds
        if time.count > 0 {
            let s = "\(sec)"
            time = time + ":" + ("".padding(toLength: 2-s.count, withPad: "0", startingAt: 0)) + s
        } else {
            time = time + "\(sec)"
        }
        return time
    }
    
    static func dateToTimeSinceHumanReadable(_ date: Date) -> String {
        var difference = date.timeIntervalSinceNow
        let years = floor(difference / 31536000) // 365*24*60*60
        difference -= years * 31536000
        if years > 0 {
            return "\(Int(years)) yrs ago"
        }
        let months = floor(difference / 2592000) // 30*24*60*60
        difference -= months * 2592000
        if months > 0 {
            return "\(Int(months)) mth ago"
        }
        let days = floor(difference / 86400) // 24*60*60
        difference -= days * 86400
        if days > 0 {
            return "\(Int(days)) dys ago"
        }
        let hours = floor(difference / 3600) // 60*60
        difference -= hours * 3600
        if hours > 0 {
            return "\(Int(hours)) hrs ago"
        }
        let minutes = floor(difference / 60) // 60
        difference -= minutes * 60
        if minutes > 0 {
            return "\(Int(minutes)) m ago"
        }
        let seconds = difference
        return "\(Int(seconds)) s ago"
    }
    
    static func deviceHasFullScreenPadding() -> Bool {
        if deviceFullScreenPaddingTop() > CGFloat(0.0) {
            return true
        }
        return false
    }
    
    static func deviceFullScreenPaddingTop() -> CGFloat {
        if #available(iOS 11.0, *) {
            if let padding = UIApplication.shared.delegate?.window??.safeAreaInsets.top {
                return padding
            }
        }
        return CGFloat(0.0)
    }
    
    static func deviceFullScreenPaddingBottom() -> CGFloat {
        if #available(iOS 11.0, *) {
            if let padding = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom {
                return padding
            }
        }
        return CGFloat(0.0)
    }
    
    static func numberHumanReadable(_ count: Double) -> String { // 3 digits visibility
        let score: Double = max(0, count)
        if score < 1E3 { // [0, 1000)
            return String(format:"%i", round(score))
        } else if score < 1E4 { // [1K, 10K)
            return String(format:"%3.2fk", round(score*1.0E-1)/1.0E2)
        } else if score < 1E5 { // [10K, 100K)
            return String(format:"%3.1fk", round(score*1.0E-1)/1.0E2)
        } else if score < 1E6 { // [100K, 1000K)
            return String(format:"%3.0fk", round(score*1.0E-1)/1.0E2)
        } else if (score<1E7) { // [1M, 10M)
            return String(format:"%3.2fM", round(score*1.0E-4)/1.0E2)
        } else if (score<1E8) { // [10M, 100M)
            return String(format:"%3.1fM", round(score*1.0E-4)/1.0E2)
        } else if (score<1E9) { // [100M, 1000M)
            return String(format:"%3.0fM", round(score*1.0E-4)/1.0E2)
        } else if (score<1E10) { // [1G, 10G)
            return String(format:"%3.2fG", round(score*1.0E-7)/1.0E2)
        } else if (score<1E11) { // [10G, 100G)
            return String(format:"%3.1fG", round(score*1.0E-7)/1.0E2)
        } else if (score<1E12) { // [100G, 1000G)
            return String(format:"%3.0fG", round(score*1.0E-7)/1.0E2)
        } else if (score<1E13) { // [1T, 10T)
            return String(format:"%3.2fT", round(score*1.0E-10)/1.0E2)
        } else if (score<1E14) { // [10T, 100T)
            return String(format:"%3.1fT", round(score*1.0E-10)/1.0E2)
        } else if (score<1E15) { // [100T, 1000T)
            return String(format:"%3.0fT", round(score*1.0E-10)/1.0E2)
        } else if (score<1E16) { // [1P, 10P)
            return String(format:"%3.2fP", round(score*1.0E-13)/1.0E2)
        } else if (score<1E17) { // [10P, 100P)
            return String(format:"%3.1fP", round(score*1.0E-13)/1.0E2)
        } else if (score<1E18) { // [100P, 1000P)
            return String(format:"%3.0fP", round(score*1.0E-13)/1.0E2)
        } else if (score<1E19) { // [1E, 10E)
            return String(format:"%3.2fE", round(score*1.0E-16)/1.0E2)
        } else if (score<1E20) { // [10E, 100E)
            return String(format:"%3.1fE", round(score*1.0E-16)/1.0E2)
        } else if (score<1E21) { // [100E, 1000E)
            return String(format:"%3.0fE", round(score*1.0E-16)/1.0E2)
        } // gigantic number
        return "∞"
    }
    
    static func openExternalURL(_ text:String, _ controller:UIViewController, messageTitle: String? = nil, messageDescription: String? = nil, buttonOK: String? = nil, buttonCancel: String? = nil) {
        guard let url = URL(string: text) else {
            print("openExternalURL: bad URL: '\(text)'")
            return
        }
        let title = messageTitle ?? NSLocalizedString("MAIN_ALERT_OPEN_URL_TITLE", comment:"")
        let prefix = NSLocalizedString("MAIN_ALERT_OPEN_URL_MESSAGE", comment:"")
        let message = messageDescription ?? "\(prefix)\(url.absoluteString)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let titleOK = buttonOK ?? "MAIN_ALERT_OPEN_URL_OK".localized()
        let titleCancel = buttonCancel ?? "MAIN_ALERT_OPEN_URL_CANCEL".localized()
        let actionOK = UIAlertAction(title: titleOK, style:.default) {
            UIAlertAction in
            // TODO: LOG ANALYTICS
            UIApplication.shared.open(url, options: [:], completionHandler: { (result) in
                print("result: \(result)")
            })
        }
        let actionCancel = UIAlertAction(title: titleCancel, style:.cancel) {
            UIAlertAction in
            // TODO: LOG ANALYTICS
        }
        alert.addAction( actionCancel )
        alert.addAction( actionOK )
        controller.present(alert, animated:true, completion:nil)
    }
    
    static func getScreenshot(view: UIView) -> UIImage {
        let rect = view.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: rect, afterScreenUpdates: false)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return finalImage
    }
}
