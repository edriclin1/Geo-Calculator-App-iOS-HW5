//
//  GeoCalcTextField.swift
//  Geo Calculator App
//
//  Created by student on 5/24/18.
//  Copyright © 2018 GVSU. All rights reserved.
//

import UIKit

class GeoCalcTextField: DecimalMinusTextField {

    override func awakeFromNib() {
        
        // set foreground color to FOREGROUND_COLOR
        self.tintColor = FOREGROUND_COLOR
        
        // set background color to transparent
        self.backgroundColor = UIColor.clear
        
        // set placeholder text color to FOREGROUND_COLOR
        guard let ph = self.placeholder  else {
            return
        }
        self.attributedPlaceholder =
            NSAttributedString(string: ph, attributes: [NSAttributedStringKey.foregroundColor :
                FOREGROUND_COLOR])
        
        // set 1 point border with rounded corners with color FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        
        // set text to FOREGORUND_COLOR
        self.textColor = FOREGROUND_COLOR
    }

}
