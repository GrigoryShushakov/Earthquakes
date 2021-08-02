import UIKit

enum Font {
    static var body: UIFont {
        UIFont.preferredFont(forTextStyle: .body)
    }
    
    static var headline: UIFont {
        UIFont.preferredFont(forTextStyle: .headline)
    }
    
    static var caption: UIFont {
        UIFont.preferredFont(forTextStyle: .caption1)
    }
}
