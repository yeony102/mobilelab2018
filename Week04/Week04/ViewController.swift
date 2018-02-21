//
//  ViewController.swift
//  Week04
//
//  Created by Yeonhee Lee on 2/21/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // UIView to animate.
    var circleView: UIView!
    let scale: CGFloat = 1.0;
    
    let duration: Double = 1.0
    
    // For view sizing.
    let radius: CGFloat = 50.0
    
    let colour = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        circleView = UIView(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        circleView.layer.cornerRadius = radius
        
        // Set the circle color.
        circleView.backgroundColor = colour
        
        // Center on parent view.
        circleView.center = self.view.center
        
        
        // Add to parent view.
        self.view.addSubview(circleView)
        
 
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        circleView.center  = self.view.center
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let xTarget : CGFloat = CGFloat(arc4random_uniform(UInt32(self.view.frame.width))) //self.view.frame.width / 3.0
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.20,
            initialSpringVelocity: 0.0,
            options: [.curveEaseInOut],
            animations: {
                self.circleView.center = CGPoint(x: xTarget, y: 0)
            }
        )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

