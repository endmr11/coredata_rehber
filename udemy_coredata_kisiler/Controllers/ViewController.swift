//
//  ViewController.swift
//  udemy_coredata_kisiler
//
//  Created by Eren Demir on 7.05.2022.
//

import UIKit
import CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kisilerTableView: UITableView!
    
    var kisilerListe = [Kisiler]()
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        searchBar.delegate = self
        tumKisiler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if aramaYapiliyorMu {
            aramaYap(kisi_ad: aramaKelimesi!)
        }else{
            tumKisiler()
        }
        
        kisilerTableView.reloadData()//TableView güncelleme setState gibi
    }
    
    func tumKisiler() {
        do {
            kisilerListe.removeAll()
            kisilerListe = try context.fetch(Kisiler.fetchRequest())
        }catch {
            print("Okuma yaparken hata")
        }
        for kisi in kisilerListe {
            print("Kisi Adı: \(kisi.kisi_ad!) Kişi yaş: \(kisi.kisi_no!)")
        }
    }
    
    func aramaYap(kisi_ad:String) {
        
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS  %@", kisi_ad)
        do {
            kisilerListe.removeAll()
            kisilerListe = try context.fetch(fetchRequest)
        }catch {
            print("Arama filtrerken hata")
        }
        for kisi in kisilerListe {
            print("Kisi Adı: \(kisi.kisi_ad!) Kişi yaş: \(kisi.kisi_no!)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "kisilerToKisiDetay" {
            print("Kişiler To Kişi Detay")
            if let veri = sender as? Int{
                let gidilecekVC = segue.destination as! KisiDetayViewController
                gidilecekVC.kisi = kisilerListe[veri]
            }
        }
        if segue.identifier == "kisilerToKisiDuzenle" {
            print("Kişiler To Kişi Düzenle")
            if let veri = sender as? Int{
                let gidilecekVC = segue.destination as! KisiDuzenleViewController
                gidilecekVC.kisi = kisilerListe[veri]
            }
        }
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return kisilerListe.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisilerHucre", for: indexPath) as! KisilerHucreTableViewCell
        cell.kisiAdEtiket.text = "\(kisi.kisi_ad!) - \(kisi.kisi_no!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "kisilerToKisiDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, boolValue) in
            print("Sil \(self.kisilerListe[indexPath.row])")
            do{
                let kisi = self.kisilerListe[indexPath.row]
                self.context.delete(kisi)
                try self.context.save()
                if self.aramaYapiliyorMu {
                    self.aramaYap(kisi_ad: self.aramaKelimesi!)
                }else {
                    self.tumKisiler()
                }
                self.kisilerTableView.reloadData()
            }catch{
                print("Silerken hata oluştu.")
            }
        }
        let editAction = UIContextualAction(style: .normal, title: "Düzenle") { (contextualAction, view, boolValue) in
            print("Düzenle \(self.kisilerListe[indexPath.row])")
            self.performSegue(withIdentifier: "kisilerToKisiDuzenle", sender: indexPath.row)
            
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        
        return swipeActions
    }
    
}

extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(print(searchText))
        aramaKelimesi = searchText
        if searchText == ""{
            aramaYapiliyorMu = false
            tumKisiler()
        }else{
            aramaYapiliyorMu = true
            aramaYap(kisi_ad: aramaKelimesi!)
        }
        kisilerTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel tıklandı")
        
    }
}

