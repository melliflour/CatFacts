//
//  ViewController.swift
//  CatFacts
//
//  Created by Faith on 7/9/19.
//  Copyright © 2019 Faith. All rights reserved.
//

import UIKit

class CatFactViewController: UIViewController {
  
  @IBAction func buttonPressed(_ sender: Any) {
    fetchOnlineCatFact { (catFact) in
      if let catFact = catFact {
        DispatchQueue.main.async {
          self.factLabel.text = catFact.text
        }
      }
    }
  }
  
  func fetchOnlineCatFact(completion: @escaping (CatFact?) -> Void) {
    let url = URL(string: "https://cat-fact.herokuapp.com/facts/random")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      let jsonDecoder = JSONDecoder()
      
      if let data = data, let catFact = try? jsonDecoder.decode(CatFact.self, from: data) {
        completion(catFact)
      } else {
        completion(nil)
      }
    }
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    task.resume()
  }
  
  @IBOutlet weak var factLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

