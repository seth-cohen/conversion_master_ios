//
//  ConversionViewController.swift
//  Conversion Master_dev
//
//  Created by Seth Cohen on 1/8/17.
//  Copyright © 2017 Seth Cohen. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "ConversionCell"

class ConversionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  internal var currentUnitType: String = String()
  internal var currentBasis: String = String()
  
  fileprivate var units: [String] = [String]()
  fileprivate var converter: Converter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // Load the unit type data from the plist
    if let pListPath: String = Bundle.main.path(forResource: currentUnitType.appending("Data"), ofType: "plist") {
      let dict = NSDictionary(contentsOfFile: pListPath) as! [String : Any]
      let unitDict = dict["map"] as! [String : Any]
      units = unitDict.keys.sorted()
      currentBasis = units[0]
      
      // Get the right converter
      let converterType: ConverterType = dictMap["converter"] as! String == "gainOffset" ? .GAIN_OFFSET : .GAIN
      converter = ConverterFactory.create(dataMap: unitDict, type: converterType)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversionViewCell
    let cellUnit: String = units[indexPath.row]
    cell.unitType.text = cellUnit
    
    if converter != nil {
      let cellValue: Double = converter!.convert(value: 2.0, fromUnit: currentBasis, toUnit: cellUnit)
      cell.value.text = String(cellValue)
    } else {
      cell.value.text = "N/A"
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return units.count
  }
  
  
  // MARK: UITableViewDelegate
  
}
