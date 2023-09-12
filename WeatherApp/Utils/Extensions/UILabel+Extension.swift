//
//  UILabel+Extension.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 04.09.2023.
//

import UIKit

extension UILabel {
    func attachImage(_ image: UIImage?, atPosition position: ImagePosition) {
        let attributedSpacing = NSMutableAttributedString(string: "  ")
        let attributedText = NSMutableAttributedString(attributedString: self.attributedText ?? NSAttributedString())
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        guard let image else { return }
        let imageString = NSAttributedString(attachment: imageAttachment)
        let font = self.font ?? UIFont.systemFont(ofSize: 17)
        let baselineOffset = (font.capHeight - image.size.height).rounded() / 2
        imageAttachment.bounds = CGRect(x: 0, y: baselineOffset, width: image.size.width, height: image.size.height)
        
        switch position {
            case .beginning:
                attributedText.insert(attributedSpacing, at: 0)
                attributedText.insert(imageString, at: 0)
            case .end:
                attributedText.append(attributedSpacing)
                attributedText.append(imageString)
        }

        self.attributedText = attributedText
    }
}

enum ImagePosition {
    case beginning
    case end
}
