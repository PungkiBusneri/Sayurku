//
//  BumbuViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class BumbuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shoppingChart: UIButton!
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var bumbuDapurCollection: UICollectionView!
    
    private var cellIdentifier = "BumbuDapurCollectionViewCell"
    private var bumbuData = ["Daun Jeruk", "Daun Bawang", "Daun Kemangi", "Bunga Lawang", "Kencur", "Kunyit", "Jahe", "Jeruk Nipis", "Jeruk Purut", "Kelapa", "Santan Kelapa", "Seledri", "Sereh", "Lengkuas", "Kayu Manis"]
    
    private var bumbuImage: [String: String] = [
        "Daun Jeruk": "Daun Jeruk",
        "Daun Bawang": "Daun Bawang",
        "Daun Kemangi": "Daun Kemangi",
        "Bunga Lawang": "Bunga Lawang",
        "Kencur": "Kencur",
        "Kunyit": "Kunyit",
        "Jahe": "Jahe",
        "Jeruk Nipis": "Jeruk nipis",
        "Jeruk Purut": "Jeruk Purut",
        "Kelapa": "Kelapa",
        "Santan Kelapa": "Santan kelapa",
        "Seledri": "Seledri",
        "Sereh": "Sereh",
        "Lengkuas": "Lengkuas",
        "Kayu Manis": "Kayu manis"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bumbuDapurCollection.dataSource = self
        bumbuDapurCollection.delegate = self
        bumbuDapurCollection.register(UINib(nibName: "BumbuDapurCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        searchBar.delegate = self
        searchBar.attributedPlaceholder = NSAttributedString(
            string: "Cari Bumbu Masakannya Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return bumbuData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bumbuDapurCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BumbuDapurCollectionViewCell
        
        cell.backgroundColor = .greenWelcome
        cell.layer.cornerRadius = 10.0
        
        let kategoryIndex = min(indexPath.item, bumbuData.count - 1)
        
        if let namaGambar = bumbuImage[bumbuData[kategoryIndex]] {
            cell.bumbuDapurImage.image = UIImage(named: namaGambar)
        }
        cell.labelName.text = bumbuData[indexPath.item]
        return cell
    }
}
extension BumbuViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateBumbuDapurList(bumbuData)
            
        } else {
            
            let filteredProduct = bumbuData.filter { sayur in
                
                return searchKeywords.allSatisfy { keyword in
                    
                    return sayur.lowercased().contains(keyword)
                    
                }
            }
            
            updateBumbuDapurList(filteredProduct)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateBumbuDapurList(bumbuData)
        return true
    }
    
    private func updateBumbuDapurList(_ newBumbuDapurList: [String]) {
        if newBumbuDapurList.isEmpty {
            
            bumbuData = ["Daun Jeruk", "Daun Bawang", "Daun Kemangi", "Bunga Lawang", "Kencur", "Kunyit", "Jahe", "Jeruk Nipis", "Jeruk Purut", "Kelapa", "Santan Kelapa", "Seledri", "Sereh", "Lengkuas", "Kayu Manis"]
        } else {
            
            bumbuData = newBumbuDapurList
        }
        bumbuDapurCollection.reloadData()
    }
}
