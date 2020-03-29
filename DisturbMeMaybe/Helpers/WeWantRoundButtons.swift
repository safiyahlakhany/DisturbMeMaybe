//
//  WeWantRoundButtons.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/29/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit

@IBDesignable
class WeWantRoundButtons: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
        self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
