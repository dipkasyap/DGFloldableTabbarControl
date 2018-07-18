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

class TabItem: UIButton  {
    
    @IBInspectable var image:UIImage? {
        didSet {
            if let imageView  = imageVU {
                imageView.image = image
            }
        }
    }
    
    lazy var imageVU:UIImageView? = {
        
        let imageVU = UIImageView()
        return imageVU
    }()
    
    lazy var containerView:UIView? = {
        let imageVU = UIView()
        return imageVU
    }()
    
    
    @IBInspectable var title:String? {
        didSet {
            self.titleLbl.text = title
        }
    }
    
    var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor.white
        lbl.textAlignment = .left
        return lbl
    }()
    
    let padding:CGFloat = 5
    var verticalPadding:CGFloat = 5
    var interItemPadding:CGFloat = 0
    
    var imageWidth:CGFloat = {
        var val:CGFloat = 20.0
        return val
    }()
    
    open var minimumScale: CGFloat = 0.95
    open var pressSpringDamping: CGFloat = 0.4
    open var releaseSpringDamping: CGFloat = 0.35
    open var pressSpringDuration = 0.4
    open var releaseSpringDuration = 0.5
    open var cornorRadious:CGFloat = 6.0
    
    //MARK:- Init
    convenience init (withImage image:UIImage , andTitle title:String?) {
        self.init()
        self.image = image
        self.title = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    //MARK:- setup
    func setUp() {
        //decoration
        self.addSubview(containerView!)
        self.containerView?.translatesAutoresizingMaskIntoConstraints = false
        self.containerView?.backgroundColor = .red
        self.containerView?.addSubview(imageVU!)
        self.containerView?.addSubview(titleLbl)
        //constraints
        manageConstraints()
    }
    
    private func manageConstraints() {
        //1. Centering
        self.imageVU?.centerYAnchor.constraint(equalTo:
            centerYAnchor
            ).isActive = true
        
        self.containerView?.centerYAnchor.constraint(equalTo:
            centerYAnchor
            ).isActive = true
        self.containerView?.centerXAnchor.constraint(equalTo:
            centerXAnchor
            ).isActive = true
        
        self.titleLbl.centerYAnchor.constraint(equalTo:
            centerYAnchor
            ).isActive = true
        
        //2. Size
        self.containerView!.addConstraintsWithFormat("H:[v0(\(imageWidth))]", views: imageVU!)
        self.containerView!.addConstraintsWithFormat("V:[v0(\(imageWidth))]", views: imageVU!)
        
        //3. Positioning
        self.containerView!.addConstraintsWithFormat("H:|[v0]-4-[v1]|", views: imageVU!,titleLbl)
    }

    //MARK:- Touch actions
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: self.pressSpringDuration, delay: 0, usingSpringWithDamping: self.pressSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: self.minimumScale, y: self.minimumScale)
        }, completion: nil)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let location = touches.first!.location(in: self)
        if !self.bounds.contains(location) {
            UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}


// MARK: - Utils
extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}

