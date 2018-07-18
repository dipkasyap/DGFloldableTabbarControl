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

enum BarToHide:String {
    case top,bottom,both
}

class BarOptions {
    var title:String!
    var image:UIImage!
    init(_ title:String,image:String) {
        self.title = title
        self.image = UIImage(named:image)
    }
}

class ContainerVC: UIViewController {

    @IBOutlet weak var bottomBar: DGFloldableTabbarControl!
    @IBOutlet weak var topBar: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }

    override func viewDidLayoutSubviews() {
        self.bottomBar.cornerRadius   = self.bottomBar.frame.size.height / 2
    }
    
    
    func setUpTabBar() {

        self.bottomBar.options = [
            BarOptions("Home", image: "home"),
            BarOptions("List", image: "category"),
            BarOptions("Search", image: "filter"),
            BarOptions("Dashboard", image: "my_collection"),
            BarOptions("Logout", image: "signout")
        ]
        
        self.bottomBar.currentValue          = self.bottomBar.options[0]
        self.bottomBar.currentIndex          = 0
        self.bottomBar.buttonIcon            = UIImage(named:"scroll")
        self.bottomBar.cornerRadius          = self.bottomBar.frame.size.height / 2
        self.bottomBar.imageInsets           = UIEdgeInsetsMake(12, 12, 12, 12)
        self.bottomBar.selectionColor        = UIColor.black.withAlphaComponent(0.1)
        self.bottomBar.buttonBackgroundColor = UIColor(red: 0.243, green: 0.671, blue: 0.976, alpha: 1.00)
        self.bottomBar.expandedButtonBackgroundColor = self.bottomBar.buttonBackgroundColor
        
        self.bottomBar.optionSelectionBlock = {
            index in
            print("[---] Did select  at index: \(index)")
            
            if let child = self.childViewControllers.first  as? ListVC {
                child.collectionView.reloadData()
            }
            
        }
    }

    ///Method to handle Scroll behaviour
    func hideBar(_ hide:Bool, theBar bar:BarToHide) {
        
        switch bar {
        case .top:
        
            print("hide top bar")
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: UIViewAnimationOptions.curveEaseIn,
                animations: {
                    self.bottomBar.transform = hide ? CGAffineTransform(translationX: 0, y: 100) : CGAffineTransform.identity
                    self.bottomBar.optionsView.transform = hide ? CGAffineTransform(translationX: 0, y: 100) : CGAffineTransform.identity
                    
            }, completion:nil
            )
            
        case .bottom:
            print("hide bottom bar")
            
            UIView.animate(
                withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: {

            }, completion:nil
            )

        default:
            print("hide both bar")

        }
    }
}

