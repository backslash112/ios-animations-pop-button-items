//
//  ButtonItemsViewController.swift
//  ios-animations-pop-button-items
//
//  Created by Carl.Yang on 11/30/15.
//  Copyright © 2015 Yangcun. All rights reserved.
//

import UIKit
import pop

class ButtonItemsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var icons: Array<UIImage> = [UIImage(named: "downloadIcon")!, UIImage(named: "dribbbleIcon")!, UIImage(named: "twitterIcon")!]

    @IBOutlet weak var button: UIButton!
    var isOpening = false
    @IBAction func buttonClick(sender: AnyObject) {
        if isOpening {
            for view in self.view.subviews {
                if view.tag > 1000 {
                    view.removeFromSuperview()
                }
                isOpening = false
            }
            return
        }
        var iconViews: Array<UIImageView> = []
        var iconNumber: Double = 1

        for iconImage in self.icons {
            let iconView = UIImageView(image: iconImage)
            iconView.tag = 1000 + Int(iconNumber)
            iconView.center = CGPointMake(button.center.x - CGFloat(40 * iconNumber), button.center.y + CGFloat(40 * iconNumber))
            iconView.alpha = 0.0
            self.view.addSubview(iconView)
            
            iconViews.append(iconView)
            iconNumber++
        }
        iconNumber = 1
        for icon in iconViews {
            let alpha = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            alpha.toValue = 1.0
            alpha.duration = 0.2
            alpha.beginTime = CACurrentMediaTime() + iconNumber * 0.06
            icon.pop_addAnimation(alpha, forKey: "alpha")
            iconNumber++
        }
        isOpening = true
    }
}
