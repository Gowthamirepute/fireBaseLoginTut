//
//  ViewController.swift
//  fireBaseLoginTut
//
//  Created by Hxtreme on 06/03/20.
//  Copyright © 2020 Hxtreme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc=segue.destination
        
                    vc.modalPresentationStyle = .fullScreen
    
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden=true
    }
    override func viewWillDisappear(_ animated: Bool) {
                navigationController?.isNavigationBarHidden=false

    }
}

