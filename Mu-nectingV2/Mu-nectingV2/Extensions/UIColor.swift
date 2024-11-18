import Foundation
import UIKit

extension UIColor {
    
    // UIColor(hexCode: "979797") 이런식으로 사용
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    static func gradient(colors:[UIColor]) -> UIColor? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map {
            $0.cgColor
        }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image != nil ? UIColor(patternImage: image!) : nil
        }
        
        return nil
    }
}

//extension UIColor {
//    static let mnMainColor = UIColor.gradient(colors: [
//        UIColor(hexCode: "BB00CB"),
//        UIColor(hexCode: "D614CE"),
//        UIColor(hexCode: "F04E51"),
//        UIColor(hexCode: "E3A400")
//    ])
//}
