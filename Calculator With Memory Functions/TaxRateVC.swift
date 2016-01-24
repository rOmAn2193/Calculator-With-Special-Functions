//
//  TaxRateVC.swift
//  Calculator With Memory Functions
//
//  Created by Roman on 1/24/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

import UIKit

class TaxRateVC: UIViewController
{
    @IBOutlet weak var taxRateEntry: UITextField!

    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func applyTaxRate(sender: AnyObject)
    {
        if taxRateEntry.text != nil
        {
            defaults.setDouble(Double(taxRateEntry.text!)!, forKey: "taxrate")
            dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

}