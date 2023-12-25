import UIKit

var greeting = "Hello, playground"

let attributes : [NSAttributedString.Key: Any] = [
    .foregroundColor : UIColor.green,
    .font: UIFont.preferredFont(forTextStyle: .caption1)
]

var attributedGretting = NSMutableAttributedString(string: greeting)
attributedGretting.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 4))
attributedGretting.addAttribute(.underlineStyle, value: NSUnderlineStyle.single, range: NSRange(location: 5, length: 2))
