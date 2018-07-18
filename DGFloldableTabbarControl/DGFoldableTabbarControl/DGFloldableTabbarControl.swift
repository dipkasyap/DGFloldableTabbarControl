//
// Created by Dip kasyap inspired from Vladislav Kovalyov
// Copyright © Dip kasyap All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

typealias OptionSelectionBlock = (_ index: Int) -> Void

@IBDesignable
class DGFloldableTabbarControl: UIView {

    var barWidth = (UIApplication.shared.delegate as! AppDelegate).window!.frame.width * CGFloat(0.95)
    var backGorundColor = UIColor(red: 0.643, green: 0.114, blue: 0.271, alpha: 1.00)
    
    var options: [BarOptions]! {
        didSet {
        }
    }
    
    var textFont  = UIFont.systemFont(ofSize: 22.0)
    
    var textColor = UIColor.white{
        didSet {
            self.button.setTitleColor(self.textColor, for: .normal)
        }
    }
    
    var isExpanded = false
    
    var expandedTextColor = UIColor.white
    
    var autoHideOptions = true
    var animationDuration: TimeInterval = 0.275
    var minOptionSize: CGFloat = 60
    
    var imageInsets: UIEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6) {
        didSet {
            self.button.imageEdgeInsets = imageInsets
        }
    }
    
    var buttonBackgroundColor = UIColor(red: 0.643, green: 0.114, blue: 0.271, alpha: 1.00) {
        didSet {
            self.button.backgroundColor = buttonBackgroundColor
        }
    }
    
    var expandedButtonBackgroundColor = UIColor.red
    
    var selectionColor = UIColor.gray {
        didSet {
            self.button.setBackgroundImage(UIImage.imageWithColor(color: buttonBackgroundColor), for: .highlighted)
        }
    }
    
    var cornerRadius: CGFloat = 0{
        didSet {
            self.button.layer.cornerRadius      = cornerRadius
            self.optionsView.layer.cornerRadius = cornerRadius
        }
    }
    
    let arrowWidth:CGFloat = 80.0

    ///Default is 0
    var currentIndex: Int! = 0
    
    var currentValue: AnyObject!
    
    var optionSelectionBlock: OptionSelectionBlock?
    
    let btnArrow = UIButton()
    var button      = UIButton()
    var optionsView = UIView()
    var stackView = UIStackView()
    
    var buttonIcon:UIImage? {
        didSet {
            self.button.setImage(buttonIcon, for: .normal)
        }
    }
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupStackView()
        self.observeOrientation()
    }
    
    required init?(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)
        self.setupStackView()
        self.setupView()
        self.observeOrientation()
    }
    
    // MARK: -
    private func observeOrientation() {
        NotificationCenter.default.addObserver(self, selector: #selector(DGFloldableTabbarControl.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc private func rotated() {
        
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("landScape")
            barWidth = (UIApplication.shared.delegate as! AppDelegate).window!.frame.height * CGFloat(0.95)
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("portait")
            barWidth = (UIApplication.shared.delegate as! AppDelegate).window!.frame.width * CGFloat(0.95)
        }
    }
    
    
    // MARK: - View Setup
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.configureOptions()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.button.frame  = self.bounds
        self.optionsView.frame = self.bounds
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }


    
    private func setupStackView(){
        self.stackView.axis = .horizontal
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillEqually
    }
    

    private func setupView() {
        
        self.button.frame               = self.bounds
        self.optionsView.frame          = self.bounds
        self.button.titleLabel?.font    = self.textFont
        self.button.layer.cornerRadius  = self.cornerRadius
        self.button.backgroundColor     = self.buttonBackgroundColor
        
        self.button.imageView?.contentMode  = .scaleAspectFit
        self.button.imageEdgeInsets         = self.imageInsets
        
        self.button.titleLabel?.textAlignment = .center
        self.button.setTitleColor(self.textColor, for: .normal)
        
        self.button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        self.button.setBackgroundImage(UIImage.imageWithColor(color: buttonBackgroundColor), for: .normal)
        self.button.addTarget(self, action: #selector(DGFloldableTabbarControl.showOptions), for: .touchUpInside)
        
        self.addSubview(self.button)
        
        self.backgroundColor = UIColor.clear
        self.button.layer.masksToBounds      = true
        self.optionsView.layer.masksToBounds = true
    }

    
   private func getWitdthOfItem(_ atIndex:Int)->CGFloat {
        // self.barWidth = self.optionsView.frame.width
        guard atIndex != self.options.count else {
            return arrowWidth
        }
        return (self.barWidth-arrowWidth)/CGFloat(options.count)
    }
   
    
     //Show tabar
    @objc private func configureOptions() {
        
        self.isExpanded = true
        
        // Create `optionsView`
        self.optionsView.frame = self.frame
        self.optionsView.backgroundColor = self.button.backgroundColor
        
        var desiredOrigin: CGFloat = 20
        
        self.superview?.addSubview(optionsView)
        self.optionsView.addSubview(stackView)
        
        var i = 0
        
        // Create buttons for each option
        for option in self.options {
            
            // Prepare frame
            let frame = CGRect(x:desiredOrigin, y:0, width:self.getWitdthOfItem(i), height:optionsView.frame.size.height)
            
            let button = TabItem(frame: frame)
            button.image = option.image
            button.title = option.title
            
            // Configure button
            button.backgroundColor = UIColor.clear
            button.setBackgroundImage(UIImage.imageWithColor(color: self.selectionColor), for: .selected)
            button.addTarget(self, action: #selector(DGFloldableTabbarControl.didSelect), for: .touchUpInside)
            button.layer.cornerRadius  = self.cornerRadius
            button.layer.masksToBounds = true
            button.tag = i
            button.isSelected = i == currentIndex
            
            // Add button to 'optionView'
            self.stackView.addArrangedSubview(button)
            
            // Prepare frame and index for next button
            desiredOrigin += button.frame.size.width
            i += 1
        }
        
        let frame = CGRect(x:desiredOrigin, y:0, width:self.getWitdthOfItem(self.options.count), height:optionsView.frame.size.height)
        btnArrow.frame = frame
        btnArrow.setImage(self.buttonIcon, for: .normal)
        btnArrow.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        btnArrow.layer.addBorder(edge: .left, color: UIColor.white.withAlphaComponent(0.7), thickness: 1.0)
        btnArrow.addTarget(self, action: #selector(DGFloldableTabbarControl.onOptionButtonAction), for: .touchUpInside)
        btnArrow.tag = 128923 // random tag
        self.optionsView.addSubview(btnArrow)
        
        //initially showing options
        self.showOptions()
        
    }
    
    private func addConstraints() {
        self.superview?.addConstraintsWithFormat("H:|-20-[v0]-20-|", views: optionsView)
        self.superview?.addConstraintsWithFormat("V:[v0(\(self.frame.height))]-20-|", views: optionsView)
        self.optionsView.addConstraintsWithFormat("H:|[v0]-(\(self.arrowWidth))-|", views: stackView)
        self.optionsView.addConstraintsWithFormat("V:|[v0]|", views: stackView)
        self.optionsView.addConstraintsWithFormat("H:[v0(\(arrowWidth))]", views: btnArrow)
        self.optionsView.addConstraintsWithFormat("V:|[v0]|", views: btnArrow)
        self.btnArrow.leftAnchor.constraint(equalTo:
            stackView.rightAnchor
            ).isActive = true
    }
    
    @objc private func showOptions() {
        
        // Show
        self.superview?.addSubview(optionsView)
        self.optionsView.addSubview(stackView)
        
        //for view in self.optionsView.subviews
        for view in self.stackView.subviews {
            view.alpha = 1
        }
        
        self.addConstraints()
        
        UIView.animate(withDuration: self.animationDuration) {
            self.optionsView.backgroundColor = self.expandedButtonBackgroundColor
            self.optionsView.isHidden = false
            self.superview?.layoutIfNeeded()
        }
    }
    
    /**
     collaps tabbar
     - Parameter selectedIndex: Index of selected tab
     */
    private func hideOptions(selectedIndex: Int = 0)  {
        
        self.isExpanded = false
        //Hide
        UIView.animate(withDuration: self.animationDuration, animations: {
            self.optionsView.backgroundColor = self.buttonBackgroundColor
            self.optionsView.frame = self.frame
        }) { (completed) in
            UIView.animate(withDuration: self.animationDuration, animations: {
                self.optionsView.isHidden = true
            })
        }
    }
    
    // MARK: - Actions 
     //Selector of `self.button`
    @objc private func onButtonAction(sender: UIButton) {
        self.showOptions()
    }
    
     //Selector for each tab
     @objc private func didSelect(sender: UIButton) {
        
        //Update selected value
        self.currentValue = self.options[sender.tag]
        
        //Hide all options buttons except of selected one
        UIView.animate(withDuration: self.animationDuration / 2) {
            //for view in self.optionsView.subviews
            for view in self.stackView.subviews {
                (view as! TabItem).isSelected = view.tag == sender.tag
            }
        }
        
        // Perform completion block
        if let completionBlock = self.optionSelectionBlock {
            completionBlock(sender.tag)
        }
    }
    
    
    @objc private func onOptionButtonAction(sender: UIButton) {
        // Close options view if it is required
        if self.autoHideOptions{
            UIView.animate(withDuration: self.animationDuration, animations: {
                    sender.frame = CGRect(x:0, y:0, width:self.button.frame.size.width, height:self.button.frame.size.height)
            })
            self.hideOptions(selectedIndex: sender.tag)
        }
    }
}

// MARK: - Utils
extension UIImage {
    /**
     Create image from specific `UIColor`
     - Parameter color: Specific color
     - Returns: `UIImage` object filled by specific color
     */
    class func imageWithColor(color: UIColor) -> UIImage {
        let size = CGSize(width: 64, height: 64)
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
