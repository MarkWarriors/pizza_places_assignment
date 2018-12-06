//
//  Extensions.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit
import GoogleMaps


extension Double {
    public func toStringWith(decimals: Int) -> String {
        return String.init(format: "%.\(decimals)f", self)
    }
    
    public func roundAtDecimal(_ decimal: Int) -> Double {
        let approx = Double(10^(decimal+1))
        return (self * approx).rounded() / approx
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func notEmpty() -> Bool{
        return self != ""
    }
}

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

@IBDesignable
class PPCheckbox: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.setImage(self.checked ? self.onImage : self.offImage, for: .normal)
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    @IBInspectable var checked: Bool = true {
        didSet{
            self.setImage(self.checked ? self.onImage : self.offImage, for: .normal)
        }
    }
    
    @IBInspectable var onImage: UIImage? {
        didSet{
            if self.checked {
                self.setImage(onImage, for: .normal)
            }
        }
    }
    
    @IBInspectable var offImage: UIImage? {
        didSet{
            if !self.checked {
                self.setImage(offImage, for: .normal)
            }
        }
    }
    
    override var buttonType: UIButton.ButtonType {
        return .custom
    }
    
    var changeValue : ((Bool)->())?
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.checked = !self.checked
        self.setImage(self.checked ? self.onImage : self.offImage, for: .normal)
        if self.changeValue != nil {
            self.changeValue!(self.checked)
        }
        super.touchesEnded(touches, with: event)
    }
    
    
    
}

@IBDesignable
class PPRoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}

class PPMarker : GMSMarker {
    var id : String
    
    init(resturant: PPResturant) {
        self.id = resturant.id
        //TODO OPEN/CLOSE
        super.init()
        self.snippet = resturant.name
        self.position = resturant.coordinates ?? CLLocationCoordinate2D()
    }
}
