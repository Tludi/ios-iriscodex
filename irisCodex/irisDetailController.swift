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
  @IBOutlet weak var garden1: UIImageView!
  @IBOutlet weak var garden2: UIImageView!
  @IBOutlet weak var garden3: UIImageView!
  @IBOutlet weak var garden4: UIImageView!
  @IBOutlet weak var garden5: UIImageView!
  @IBOutlet weak var garden6: UIImageView!
  
  override func viewWillAppear(animated: Bool) {
    irisNameLabel.text = singleIris.name
    hybridizerLabel.text = singleIris.hybridizer
    yearLabel.text = singleIris.year
    typeLabel.text = singleIris.irisType
    
    if singleIris.garden1 {
      garden1.image = UIImage(named: "15x15filled.png")
    }else{
      garden1.image = UIImage(named: "15x15empty.png")
    }
    if singleIris.garden2{
      garden2.image = UIImage(named: "15x15filled.png")
    }else{
      garden2.image = UIImage(named: "15x15empty.png")
    }
    if singleIris.garden3 {
      garden3.image = UIImage(named: "15x15filled.png")
    }else{
      garden3.image = UIImage(named: "15x15empty.png")
    }
    if singleIris.garden4 {
      garden4.image = UIImage(named: "15x15filled.png")
    }else{
      garden4.image = UIImage(named: "15x15empty.png")
    }
    if singleIris.garden5 {
      garden5.image = UIImage(named: "15x15filled.png")
    }else{
      garden5.image = UIImage(named: "15x15empty.png")
    }
    if singleIris.garden6 {
      garden6.image = UIImage(named: "15x15filled.png")
    }else{
      garden6.image = UIImage(named: "15x15empty.png")
    }
    
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
