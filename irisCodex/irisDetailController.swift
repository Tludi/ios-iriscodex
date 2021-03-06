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
  @IBOutlet weak var detailScrollView: UIScrollView!
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
    
    // TODO: need to try to refactor in future release
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
    } else {
      favImage.setImage(UIImage(named: "star1.png"), forState: UIControlState.Normal)
    }
    
  } // end viewWillAppear
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    view.endEditing(true)
  }
  
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }

  // save the edited text in notes:
  func textViewDidChange(textView: UITextView) {
    editNotes()
  }

  func textViewDidEndEditing(textView: UITextView) {
    notes.resignFirstResponder()
  }

  // toggle the favorite status of the iris and image
  func editFavorites() {
    let realm = Realm()
    realm.write {
      if self.singleIris.favorite {
        self.singleIris.favorite = false
        self.favImage.setImage(UIImage(named: "star1.png"), forState: UIControlState.Normal)
      } else {
        self.singleIris.favorite = true
        self.favImage.setImage(UIImage(named: "star2.png"), forState: UIControlState.Normal)
      }
    }
  }

  // save the textView if edited
  func editNotes() {
    let realm = Realm()
    realm.write {
      self.singleIris.note = self.notes.text
    }
  }
  

}
