//
//  KisiDetayViewController.swift
//  udemy_coredata_kisiler
//
//  Created by Eren Demir on 7.05.2022.
//

import UIKit

class KisiDetayViewController: UIViewController {


    @IBOutlet weak var kisiAdEtiket: UILabel!
    @IBOutlet weak var kisiNoEtiket: UILabel!
    var kisi:Kisiler?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let kisiler = kisi {
            kisiAdEtiket.text = kisiler.kisi_ad
            kisiNoEtiket.text = kisiler.kisi_no
        }
    }


}
