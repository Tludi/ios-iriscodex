//
//  irisDetailController.swift
//  irisCodex
//
//  Created by Timothy Ludi on 5/12/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class irisDetailController: UIViewController, UITextViewDelegate {

  var singleIris = Iris()
  let nonFavoriteImageFile = UIImage(named: "star1.png")
  let favoriteImageFile = UIImage(named: "star2.png")
  
  @IBOutlet weak var favImage: UIButton!
  @IBAction func editFavorite(sender: UIButton) {
    editFavorites()
  }
  @IBOutlet weak var favorite: UIButton!
  @IBAction func addFavorite(sender: UIButton) {
    editFavorites()
  }

  @IBOutlet weak var irisNameLabel: UILabel!
  @IBOutlet weak var hybridizerLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var garden1: UIImageView!
  @IBOutlet weak var garden2: UIImageView!
  @IBOutlet weak var garden3: UIImageView!
  @IBOutlet weak var garden4: UIImageView!
  @IBOutlet weak var garden5: UIImageView!
  @IBOutlet weak var garden6: UIImageView!

  
  @IBOutlet weak var notes: UITextView!
  
  override func viewWillAppear(animated: Bool) {
    irisNameLabel.text = singleIris.name
    hybridizerLabel.text = singleIris.hybridizer
    yearLabel.text = "\(singleIris.year) - \(singleIris.irisType)"
    
    notes.text = singleIris.note
    let emptyIris = "40x40empty2.png"
    let filledIris = "40x40filled2.png"
    
    if singleIris.garden1 {
      garden1.image = UIImage(named: filledIris)
    }else{
      garden1.image = UIImage(named: emptyIris)
    }
    if singleIris.garden2{
      garden2.image = UIImage(named: filledIris)
    }else{
      garden2.image = UIImage(named: emptyIris)
    }
    if singleIris.garden3 {
      garden3.image = UIImage(named: filledIris)
    }else{
      garden3.image = UIImage(named: emptyIris)
    }
    if singleIris.garden4 {
      garden4.image = UIImage(named: filledIris)
    }else{
      garden4.image = UIImage(named: emptyIris)
    }
    if singleIris.garden5 {
      garden5.image = UIImage(named: filledIris)
    }else{
      garden5.image = UIImage(named: emptyIris)
    }
    if singleIris.garden6 {
      garden6.image = UIImage(named: filledIris)
    }else{
      garden6.image = UIImage(named: emptyIris)
    }
    
    if singleIris.favorite {
      favImage.setImage(UIImage(named: "star2.png"), forState: UIControlState.Normal)
      favorite.setTitle("Remove From Favorites", forState: .Normal)
    } else {
      favImage.setImage(UIImage(named: "star1.png"), forState: UIControlState.Normal)
      favorite.setTitle("Add To Favorites", forState: .Normal)
    }
    
  } // end viewWillAppear
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    view.endEditing(true)
  }
  
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  // save the edited text in notes:
  func textViewDidChange(textView: UITextView) {
    editNotes()
  }

  func textViewDidEndEditing(textView: UITextView) {
    notes.resignFirstResponder()
  }

  func editFavorites() {
    let realm = Realm()
    realm.write {
      if self.singleIris.favorite {
        self.singleIris.favorite = false
        self.favorite.setTitle("Add To Favorites", forState: .Normal)
        self.favImage.setImage(UIImage(named: "star1.png"), forState: UIControlState.Normal)
      } else {
        self.singleIris.favorite = true
        self.favorite.setTitle("Remove From Favorites", forState: .Normal)
        self.favImage.setImage(UIImage(named: "star2.png"), forState: UIControlState.Normal)
      }
    }
  }

  func editNotes() {
    let realm = Realm()
    realm.write {
      self.singleIris.note = self.notes.text
    }
  }
  

}
