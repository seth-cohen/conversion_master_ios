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
  @IBOutlet weak var tableView: UITableView!
  
  internal var currentUnitType: String = String()
  internal var currentBasis: String = String()
  
  fileprivate var units: [String] = [String]()
  fileprivate var converter: Converter?
  fileprivate let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .scientific
    nf.exponentSymbol = "e"
    nf.minimumSignificantDigits = 0
    nf.maximumSignificantDigits = 4
    
    return nf
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // Load the unit type data from the plist
    if let pListPath: String = Bundle.main.path(forResource: currentUnitType.replacingOccurrences(of: " ", with: "").appending("Data"), ofType: "plist") {
      let dict = NSDictionary(contentsOfFile: pListPath) as! [String : Any]
      let unitDict = dict["map"] as! [String : Any]
      units = unitDict.keys.sorted()
      currentBasis = units[0]
      
      // Get the right converter
      let converterType: ConverterType = dict["converter"] as! String == "gainOffset" ? .GAIN_OFFSET : .GAIN
      converter = ConverterFactory.create(dataMap: unitDict, type: converterType)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // Highlight the basis cell - reload unhighlights the cell
    let indexPath: IndexPath = IndexPath(item: units.index(of: currentBasis)!, section: 0)
    if let cell: ConversionViewCell = tableView.cellForRow(at: indexPath) as? ConversionViewCell {
      cell.setHighlighted(true, animated: false)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func highlightCellAt(indexPath: IndexPath) {
    // Highlight the basis cell - reload unhighlights the cell
    if let cell: ConversionViewCell = tableView.cellForRow(at: indexPath) as? ConversionViewCell {
      cell.setHighlighted(true, animated: false)
    }
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversionViewCell
    let cellUnit: String = units[indexPath.row]
    cell.unitType.text = ":" + cellUnit
    
    if converter != nil {
      let cellValue: Double = converter!.convert(value: 2.0, fromUnit: currentBasis, toUnit: cellUnit)
      cell.value.text = numberFormatter.string(from: cellValue as NSNumber)
    } else {
      cell.value.text = "N/A"
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return units.count
  }
  
  
  // MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Set the new basis
    currentBasis = units[indexPath.row]
    tableView.reloadData()
    
    // Reloading the data deselects (or at least unhighlights) the selected cell
    highlightCellAt(indexPath: indexPath)
  }
}
