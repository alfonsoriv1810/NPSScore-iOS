//
//  KNpsBuildDetailViewController.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/10/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import UIKit

class KNpsBuildDetailViewController: KBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK:ViewController properties
    public var buildNpsModel:KBuildModel? = nil
    private var currentSelectedIndex:Int = 0
    @IBOutlet weak var npsValuesCollectionView: UICollectionView!
    @IBOutlet weak var freemiumTotalUsersLabel: UILabel!
    @IBOutlet weak var premiumTotalUsersLabel: UILabel!
    @IBOutlet weak var currentPercentageOfUsersLabel: UILabel!
    @IBOutlet weak var usersAnswersLabel: UILabel!
    @IBOutlet weak var numberActivitiesLabel: UILabel!
    
    
    //MARK:ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpNpsDetailUIData(npsValue: 0)
    }
    
    //MARK:ViewController parent methods
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        self.navigationItem.title = "NPS Detail \(self.buildNpsModel?.version ?? "")"
        self.navigationController?.title = "NPS Detail \(self.buildNpsModel?.version ?? "")"
    }
    
    //MARK:ViewController UI methods
    func setUpCollectionView() {
        self.npsValuesCollectionView.delegate = self
        self.npsValuesCollectionView.dataSource = self
        self.npsValuesCollectionView.register(UINib.init(nibName: KCellsIdentifiers.npsValueCell, bundle: nil), forCellWithReuseIdentifier: KCellsIdentifiers.npsValueCell)
    }
    
    func setUpNpsDetailUIData(npsValue:Int) {
        self.freemiumTotalUsersLabel.text = "\(self.buildNpsModel?.freemiumUsers?.count ?? 0)"
        self.premiumTotalUsersLabel.text = "\(self.buildNpsModel?.premiumUsers?.count ?? 0)"
        self.usersAnswersLabel.text = "of the users that answered \(npsValue) in their"
        
        //TODO:Update nps info data.
        let npsUsersPredicate = NSPredicate(format: "npsValue == \(npsValue)")
        let myArray:[KNpsModel] = self.buildNpsModel?.allUsers?.filtered(using: npsUsersPredicate) as! [KNpsModel]
        let activityViews = myArray.map({ $0.activityViews })
        
        // Create dictionary to map value to count
        var counts = [Int: Int]()
        
        // Count the values with using forEach
        activityViews.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }
        
        // Find the most frequent value and its count with max(by:)
        if let (value, count) = counts.max(by: {$0.1 < $1.1}) {
            //print("\(value) occurs \(count) times")
            if count > 1 {
                self.numberActivitiesLabel.text = "\(value) activities"
            } else {
                self.numberActivitiesLabel.text = "\(activityViews.max() ?? 0) activities"
            }
            self.currentPercentageOfUsersLabel.text = "\((count * 100)/activityViews.count)%"
        }
    }
    
    //MARK:UICollectionViewDelegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellObject:KNpsValueCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellsIdentifiers.npsValueCell, for: indexPath) as! KNpsValueCollectionViewCell
        cellObject.updateCellWithIndex(index: indexPath.row)
        cellObject.setCurrentCellAsSelected(selected: indexPath.row == self.currentSelectedIndex)
        return cellObject
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentSelectedIndex = indexPath.row
        collectionView.reloadData()
        setUpNpsDetailUIData(npsValue: indexPath.row)
    }
}
