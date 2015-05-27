//
//  irisDetailController.swift
//  irisCodex
//
//  Created by Timothy Ludi on 5/12/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class irisDetailController: UIViewController {

  var singleIris = Iris()
  
  @IBOutlet weak var favorite: UIButton!
  @IBAction func addFavorite(sender: UIButton) {
    editFavorites()
  }

  @IBOutlet weak var irisNameLabel: UILabel!
  @IBOutlet weak var hybridizerLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  
  override func viewWillAppear(animated: Bool) {
    irisNameLabel.text = singleIris.name
    hybridizerLabel.text = singleIris.hybridizer
    yearLabel.text = singleIris.year
    typeLabel.text = singleIris.irisType
    
    if singleIris.favorite {
      favorite.setTitle("Remove From Favorites", forState: .Normal)
    } else {
      favorite.setTitle("Add To Favorites", forState: .Normal)
    }
    //notes.text = singleIris.note
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editFavorites() {
      let realm = Realm()
      realm.write {
        if self.singleIris.favorite {
          self.singleIris.favorite = false
          self.favorite.setTitle("Add To Favorites", forState: .Normal)
        } else {
          self.singleIris.favorite = true
          self.favorite.setTitle("Remove From Favorites", forState: .Normal)
        }
      }
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
