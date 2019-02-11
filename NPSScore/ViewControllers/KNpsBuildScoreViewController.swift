//
//  KNpsBuildScoreViewController.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/10/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import UIKit

class KNpsBuildScoreViewController: KBaseViewController {
    //MARK:ViewController properties
    var buildsArray:NSArray? = nil
    
    @IBOutlet weak var buildsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var npsFreemiumUsersLabel: UILabel!
    @IBOutlet weak var totalFreemiumUsersLabel: UILabel!
    @IBOutlet weak var npsPremiumUsersLabel: UILabel!
    @IBOutlet weak var totalPremiumUsersLabel: UILabel!
    @IBOutlet weak var npsScoreContentView: UIView!
    
    //MARK:ViewController life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildsArray = KNPSSingleton.sharedInstance.buildsArray
        configureSegmentedControl()
    }
    
    //MARK:ViewController UI methods
    func configureSegmentedControl() {
        self.buildsSegmentedControl.removeAllSegments()
        if (self.buildsArray?.count)! > 0 {
            for i in 0 ..< self.buildsArray!.count {
                let buildModel = self.buildsArray![i] as! KBuildModel
                self.buildsSegmentedControl.insertSegment(withTitle: buildModel.version, at: i, animated: false)
            }
            self.buildsSegmentedControl.selectedSegmentIndex = 0
            setUpNPSScore(buildModel: self.buildsArray![0] as! KBuildModel)
        }
    }
    
    func setUpNPSScore(buildModel:KBuildModel) {
        self.totalFreemiumUsersLabel.text = "Out of \(buildModel.freemiumUsers?.count ?? 0) users."
        self.totalPremiumUsersLabel.text = "Out of \(buildModel.premiumUsers?.count ?? 0) users."
        
        let detractorsUsersPredicate = NSPredicate(format: "npsValue < 7")
        let promotersUsersPredicate = NSPredicate(format: "npsValue >= 9")
        //let passivesUsersPredicate = NSPredicate(format: "npsValue == 7 || npsValue == 8")
        
        let freemiumDetractorsArray = buildModel.freemiumUsers?.filtered(using: detractorsUsersPredicate)
        let freemiumPromotersArray = buildModel.freemiumUsers?.filtered(using: promotersUsersPredicate)
        
        let preemiumDetractorsArray = buildModel.premiumUsers?.filtered(using: detractorsUsersPredicate)
        let preemiumPromotersArray = buildModel.premiumUsers?.filtered(using: promotersUsersPredicate)
        
        let npsFreemiumDetractorsPercentage = ((freemiumDetractorsArray?.count)! * 100) / (buildModel.freemiumUsers?.count)! as Int
        let npsFreemiumPromotersPercentage = ((freemiumPromotersArray?.count)! * 100) / (buildModel.freemiumUsers?.count)! as Int
        
        let npsPremiumDetractorsPercentage = ((preemiumDetractorsArray?.count)! * 100) / (buildModel.premiumUsers?.count)! as Int
        let npsPremiumPromotersPercentage = ((preemiumPromotersArray?.count)! * 100) / (buildModel.premiumUsers?.count)! as Int
        
        let npsPremiumScore = npsPremiumPromotersPercentage - npsPremiumDetractorsPercentage
        let npsFreemiumScore = npsFreemiumPromotersPercentage - npsFreemiumDetractorsPercentage
        
        self.npsPremiumUsersLabel.text = "\(npsPremiumScore)"
        self.npsFreemiumUsersLabel.text = "\(npsFreemiumScore)"
        
        if npsPremiumScore >= 70 {
            self.npsPremiumUsersLabel.textColor = UIColor.init(displayP3Red: 120.0/255.0, green: 183.0/255.0, blue: 66.0/255.0, alpha: 1)
        } else {
            self.npsPremiumUsersLabel.textColor = UIColor.init(displayP3Red: 226.0/255.0, green: 10.0/255.0, blue: 25.0/255.0, alpha: 1)
        }
        
        if npsFreemiumScore >= 70 {
            self.npsFreemiumUsersLabel.textColor = UIColor.init(displayP3Red: 120.0/255.0, green: 183.0/255.0, blue: 66.0/255.0, alpha: 1)
        } else {
            self.npsFreemiumUsersLabel.textColor = UIColor.init(displayP3Red: 226.0/255.0, green: 10.0/255.0, blue: 25.0/255.0, alpha: 1)
        }
    }
    
    //MARK:IBActions methods
    @IBAction func didSelectSegmentedControlOption(_ sender: UISegmentedControl) {
        setUpNPSScore(buildModel: self.buildsArray![sender.selectedSegmentIndex] as! KBuildModel)
    }
    
    @IBAction func didPressedViewMoreDetailsButton(_ sender: UIButton) {
        let currentStotyboard = UIStoryboard(name: KStoryboards.mainStoryboard, bundle: nil)
        let buildDetailViewController = currentStotyboard.instantiateViewController(withIdentifier: KViewControllers.npsBuildDetailViewController) as! KNpsBuildDetailViewController
        buildDetailViewController.buildNpsModel = (self.buildsArray![self.buildsSegmentedControl.selectedSegmentIndex] as! KBuildModel)
        self.navigationController?.pushViewController(buildDetailViewController, animated: true)
    }
}
