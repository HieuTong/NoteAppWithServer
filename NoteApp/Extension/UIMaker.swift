//
//  UIMaker.swift
//  NoteApp
//
//  Created by HieuTong on 3/1/21.
//

import UIKit

var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

struct UIMaker {
    static func makeKeyboardDoneView(title: String = "Done", doneAction: Selector? = nil) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 35))
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.color(value: 3), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        if let doneAction = doneAction {
            button.addTarget(self, action: doneAction, for: .touchUpInside)
        } else {
            button.addTarget(appDelegate, action: #selector(appDelegate.hideKeyboard), for: .touchUpInside)
        }
        view.addSubview(button)
        button.right(toView: view, space: -30)
        button.centerY(toView: view)
        
        view.backgroundColor = UIColor.color(value: 235)
        return view
    }
    
    static func makeTextField(font: UIFont, color: UIColor, text: String? = nil, placeholder: String? = nil) -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = font
        tf.placeholder = placeholder
        tf.textColor = color
        tf.text = text
        tf.autocorrectionType = .no
        tf.clearButtonMode = .whileEditing
        tf.inputAccessoryView = makeKeyboardDoneView()
        return tf
    }
    
    static func makeTextView(font: UIFont? = .boldSystemFont(ofSize: 15),
                             color: UIColor? = UIColor.coin_font_title,
                             text: String? = nil) -> UITextView {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = font
        tf.textColor = color
        tf.autocorrectionType = .no
        tf.showsVerticalScrollIndicator = false
        tf.inputAccessoryView = makeKeyboardDoneView()
        tf.showsVerticalScrollIndicator = false
        return tf
    }
    
    static func makeContentLabel(fontSize: CGFloat,
                                   text: String? = nil,
                                   isBold: Bool = false,
                                   color: UIColor = .coin_font_content,
                                   numberOfLines: Int = 0,
                                   alignment: NSTextAlignment = .left) -> UILabel{
        let label = UILabel()
        label.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        label.textColor = color
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    static func makeTitleLabel(fontSize: CGFloat = 16,
                                 text: String? = nil,
                                 isBold: Bool = true,
                                 color: UIColor = .coin_font_title,
                                 numberOfLines: Int = 0,
                                 alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        label.textColor = color
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byWordWrapping
        return label
    }
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate

extension UIColor {
    static let coin_font_title = color(hex: "354053")
    static let coin_font_content = color(hex: "75808E")
    func adjustBrightness(_ amount:CGFloat) -> UIColor {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            brightness += (amount-1.0)
            brightness = max(min(brightness, 1.0), 0.0)
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        }
        return self
    }
    
    static func color(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
    
    convenience init(value: CGFloat) {
        let c = value / 255
        self.init(red: c, green: c, blue: c, alpha: 1)
    }
    
    static func color(value: CGFloat) -> UIColor {
        return UIColor(red: value / 255, green: value / 255, blue: value / 255, alpha: 1)
    }
    
    func alpha(_ value: CGFloat) -> UIColor {
        return withAlphaComponent(value)
    }
    
    static func color(hex: String, alpha: CGFloat = 1) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
   
    func getRGBAComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)?
    {
        var (red, green, blue, alpha) = (CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0))
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        {
            return (red, green, blue, alpha)
        } else {
            return nil
        }
    }
}
