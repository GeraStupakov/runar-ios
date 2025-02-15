//
//  UILabel.swift
//  Runar
//
//  Created by George Stupakov on 25/05/2022.
//

import UIKit

extension UILabel {
    
    static func getAttributedText(text: String, lineHeight: CGFloat) -> NSAttributedString{
        let prgph = NSMutableParagraphStyle()
        
        prgph.lineHeightMultiple = lineHeight
        
        return NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: prgph])
    }
    
    static func createAmatic(title: String, size: CGFloat, lineHeight: CGFloat, height: CGFloat) -> UILabel{
        let label = UILabel()
        
        label.font = FontFamily.AmaticSC.bold.font(size: size)
        label.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        label.textAlignment = .center
        label.contentMode = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let prgph = NSMutableParagraphStyle()
        
        prgph.lineHeightMultiple = lineHeight
        
        label.attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return label
    }
}
