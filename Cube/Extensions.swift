//
//  Extensions.swift
//  Cube
//
//  Created by John Nik on 3/29/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
        
    }
    
}

extension UIButton {
    func setImageWith(imageName: String) {
        
        let image = UIImage(named: imageName)
        
        self.setImage(image, for: .normal)
    }
    
    func setBorderAndRound(radius: CGFloat) {
        
        self.backgroundColor = UIColor.white
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor

        
    }
}


extension UIImageView {
    
    func setImageWith(imageName: String) {
        
        let image = UIImage(named: imageName)
        
        self.image = image
        self.contentMode = .scaleAspectFill
    }

}


extension String {
    var chomp : String {
        mutating get {
            self.remove(at: self.startIndex)
            return self
        }
    }
}

extension UITextView {
    func increaseFontSize () {
        self.font =  UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)!+1)!
    }
}

















