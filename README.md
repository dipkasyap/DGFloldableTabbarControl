# DGFloldableTabbarControl
![bar](https://user-images.githubusercontent.com/12591229/30094395-d8aadb7a-92eb-11e7-8e19-e3c90c17a3c7.png)

An elegant foldable tabbar control. (iPad)


![record](https://user-images.githubusercontent.com/12591229/30094896-d494a3a6-92ee-11e7-9e46-7da82fd5c60c.gif)


# Usage
1. Drag and drop DGFoldableTabbarControl folder from demo to your project.
2. Place a View on your storyboard and assign DGFloldableTabbarControl class.
3. Drag outlet of that View on your controller.
   
        @IBOutlet weak var bottomBar: DGFloldableTabbarControl!

4. Customize your tabbar as following 

        self.bottomBar.options        = [BarOptions("Home", image: "home"),BarOptions("List", image: "category"),BarOptions("Search", image: "filter"),BarOptions("Dashboard", image: "my_collection"),BarOptions("Logout", image: "signout")]
        self.bottomBar.currentValue   = self.bottomBar.options[0]
        self.bottomBar.currentIndex   = 0
        self.bottomBar.buttonIcon   = UIImage(named:"scroll")
        self.bottomBar.cornerRadius   = self.bottomBar.frame.size.height / 2
        self.bottomBar.imageInsets    = UIEdgeInsetsMake(12, 12, 12, 12)
        self.bottomBar.selectionColor = UIColor.black.withAlphaComponent(0.1) //UIColor(red: 75.0/256.0, green: 178.0/256.0, blue: 174.0/256.0, alpha: 1.0)
        self.bottomBar.buttonBackgroundColor = UIColor(red: 0.243, green: 0.671, blue: 0.976, alpha: 1.00) //UIColor(red: 0.643, green: 0.114, blue: 0.271, alpha: 1.00)
        self.bottomBar.expandedButtonBackgroundColor = self.bottomBar.buttonBackgroundColor
        
        self.bottomBar.optionSelectionBlock = {
            index in
            print("[---] Did select  at index: \(index)")
        }




#Created by Dip kasyap inspired from Vladislav Kovalyov
#Licence

The MIT License (MIT) Copyright (c) 2014 Dip Kasyap (Dpd Ghimire) (pr0gramm3r8hai)

email:- dpd.ghimire@gmail.com github : https://github.com/dipkasyap/DGLocalization

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE DGLocalization
