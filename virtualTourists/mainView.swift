//
//  mainView.swift
//  virtualTourists
//
//  Created by Najla Al qahtani on 2/3/19.
//  Copyright © 2019 Najla Al qahtani. All rights reserved.
//

import UIKit

class mainView: UIViewController {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        self.view.bringSubviewToFront(loading)
        loading.startAnimating()
        perform(#selector(showNavigation), with: nil, afterDelay: 3)
    }
    @objc func showNavigation(){
        self.loading.stopAnimating()
        performSegue(withIdentifier: "showNavigation", sender: self)
    }
}
