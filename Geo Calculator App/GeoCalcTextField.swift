//
//  GeoCalcTextField.swift
//  Geo Calculator App
//
//  Created by student on 5/24/18.
//  Copyright © 2018 GVSU. All rights reserved.
//

import UIKit

class GeoCalcTextField: UITextField {

    override func awakeFromNib() {
        
        self.tintColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        
        //self.textColor = THEME_COLOR3
        
        guard let ph = self.placeholder  else {
            return
        }
        
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = foreground as! CGColor FOREGROUND_COLOR
        
        self.attributedPlaceholder =
            NSAttributedString(string: ph, attributes: [NSAttributedStringKey.foregroundColor :
                FOREGROUND_COLOR])
    }

}
