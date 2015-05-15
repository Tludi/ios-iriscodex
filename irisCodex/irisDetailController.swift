//
//  irisDetailController.swift
//  irisCodex
//
//  Created by Timothy Ludi on 5/12/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit

class irisDetailController: UIViewController {

  var singleIris = Iris()
  
  @IBOutlet weak var irisNameLabel: UILabel!
  
  override func viewWillAppear(animated: Bool) {
    irisNameLabel.text = singleIris.name
  }
  
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

}
