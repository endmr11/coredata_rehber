//
//  KisiDuzenleViewController.swift
//  udemy_coredata_kisiler
//
//  Created by Eren Demir on 7.05.2022.
//

import UIKit

class KisiDuzenleViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    @IBOutlet weak var adGirdiAlani: UITextField!
    @IBOutlet weak var noGirdiAlani: UITextField!
    
    var kisi:Kisiler?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let k = kisi {
            adGirdiAlani.text = k.kisi_ad
            noGirdiAlani.text = k.kisi_no
        }
    }
    @IBAction func kisiDuzenle(_ sender: Any) {
        if let kisiler = kisi,let ad = adGirdiAlani.text,let tel = noGirdiAlani.text {
            
            kisiler.kisi_ad = ad
            kisiler.kisi_no = tel
            
            do {
                try context.save()
            }catch{
                print("Güncellerken hata oluştu")
            }
            
        }
    }
}
