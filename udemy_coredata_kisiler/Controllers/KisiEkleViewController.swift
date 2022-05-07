//
//  KisiEkleViewController.swift
//  udemy_coredata_kisiler
//
//  Created by Eren Demir on 7.05.2022.
//

import UIKit

class KisiEkleViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    @IBOutlet weak var adGirdiAlani: UITextField!
    @IBOutlet weak var noGirdiAlani: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func kisiEkle(_ sender: Any) {
        
        if let ad = adGirdiAlani.text, let no = noGirdiAlani.text {
            let kisi = Kisiler(context: context)
            kisi.kisi_ad = ad
            kisi.kisi_no = no
            do {
                try context.save()
            }
            catch {
                print("Kayıt yaparken hata")
            }
        }
        
        
    }
}
