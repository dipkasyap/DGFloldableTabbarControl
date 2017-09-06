# DGFloldableTabbarControl
![bar](https://user-images.githubusercontent.com/12591229/30094395-d8aadb7a-92eb-11e7-8e19-e3c90c17a3c7.png)

An elegant foldable tabbar control. (iPad)


![record](https://user-images.githubusercontent.com/12591229/30094896-d494a3a6-92ee-11e7-9e46-7da82fd5c60c.gif)


# Usage

1. Place a View on your storyboard and assign DGFloldableTabbarControl class.
2. Drag outlet of that View on your controller.
    @IBOutlet weak var bottomBar: DGFloldableTabbarControl!

2. Customize your tabbar as following 

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
