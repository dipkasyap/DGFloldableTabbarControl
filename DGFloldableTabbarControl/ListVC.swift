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

class ListVC: BaseVC,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    let dx:CGFloat = 10
    let vMargin:CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.random.withAlphaComponent(0.5)
        return cell
    }
    
    
    //MARK: Collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (collectionView.frame.height - vMargin)/3 - dx
        let width:CGFloat = (collectionView.frame.width )/3
        
        return CGSize(width: width - (3*dx)/2, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: dx, left: dx, bottom: dx, right: dx)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return dx
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return dx
    }

}

class BaseVC:UIViewController,UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    enum ScrollDirection {
        case up,down
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("start scrolling........<<<<<<>>>>>>")
        
        guard let _ = self.parent as? ContainerVC else {
            print("NO Parent exist")
            
            return
        }
        
        let direction:ScrollDirection = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 ? .up : .down
        print(direction)
        
        if direction == .up {
            self.hideBar(false, theBar: .top)
            self.hideBar(true, theBar: .bottom)
        } else {
            self.hideBar(true, theBar: .top)
            self.hideBar(false, theBar: .bottom)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Stopped scrolling.....!!!!!!!!")
        self.hideBar(false, theBar: .top)
        self.hideBar(false, theBar: .bottom)
    }
    
    func hideBar(_ hide:Bool, theBar bar:BarToHide) {
        
        guard let parent = self.parent as? ContainerVC else {
            print("NO Parent exist")
            return
        }
        parent.hideBar(hide, theBar: bar)
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}
