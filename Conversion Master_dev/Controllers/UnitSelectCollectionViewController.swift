//
//  UnitSelectCollectionViewController.swift
//  Conversion Master_dev
//
//  Created by Seth Cohen on 1/7/17.
//  Copyright © 2017 Seth Cohen. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "UnitTypeCell"

class UnitSelectCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  fileprivate let itemMargin: CGFloat = 10.0
  fileprivate var unitTypes: [String] = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Do any additional setup after loading the view.
    // Load the unit types from the plist
    if let pListPath:String = Bundle.main.path(forResource: "UnitTypes", ofType: "plist") {
      let dict = NSDictionary(contentsOfFile: pListPath) as! [String : Any]
      unitTypes = dict["unitTypeArray"] as! [String]
      print("Unit type array: \(unitTypes)")
    }
    
    // Get the layout size so we can makes sure that we have 3 equally sized cells per row
    // @TODO perhaps this should be in a viewWillAppear call
    let layout: UICollectionViewFlowLayout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    let viewWidth = layout.collectionViewContentSize.width
    let itemWidth = Int((viewWidth - 4 * itemMargin) / 3)
    layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    print("\(layout.collectionViewContentSize)")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  
  // Hand over the requisite data to the conversion view controller
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the currently selected item
    let unitCell: UnitSelectViewCell = sender as! UnitSelectViewCell
    let conversionController = segue.destination as! ConversionViewController
    conversionController.currentUnitType = unitCell.unitTypeLabel.text!
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return unitTypes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UnitSelectViewCell
    
    // Configure the cell
    cell.unitTypeLabel.text = unitTypes[indexPath.row]
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.layer.borderColor = UIColor.red.cgColor
  }
  
  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.layer.borderColor = UIColor.black.cgColor
  }
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
   
   }
   */
  
}
