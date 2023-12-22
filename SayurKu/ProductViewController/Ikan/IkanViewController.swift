//
//  IkanViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class IkanViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shoppingChart: UIButton!
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var ikanCollection: UICollectionView!
    
    
    private var cellIdentifier = "IkanCollectionViewCell"
    private var ikanData = ["Ikan Tuna", "Ikan Salmon","Ikan Lele", "Ikan Mas", "Ikan Gurame", "Ikan Cikalang", "Ikan Nila", "Ikan Mujair", "Ikan Bandeng"]
    private var ikanImage: [String: String] = [
        "Ikan Tuna": "Ikan Tuna",
        "Ikan Salmon": "Ikan Salmon",
        "Ikan Lele": "Ikan Lele",
        "Ikan Gurame": "Ikan Gurame",
        "Ikan Cikalang": "Ikan Cikalang",
        "Ikan Nila": "Ikan Nila",
        "Ikan Mujair": "Ikan Mujair",
        "Ikan Mas": "Ikan Mas",
        "Ikan Bandeng": "Ikan Bandeng"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        ikanCollection.dataSource = self
        ikanCollection.delegate = self
        ikanCollection.register(UINib(nibName: "IkanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        searchBar.delegate = self
        searchBar.attributedPlaceholder = NSAttributedString(
            string: "Cari Ikannya Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ikanData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ikanCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! IkanCollectionViewCell
        cell.backgroundColor = .pink
        cell.layer.cornerRadius = 10.0
        let kategoryIndex = min(indexPath.item, ikanData.count - 1)
        
        if let namaGambar = ikanImage[ikanData[kategoryIndex]] {
            cell.ikanImage.image = UIImage(named: namaGambar)
        }
        
        cell.labelName.text = ikanData[indexPath.item]
        return cell
    }
}
extension IkanViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateIkanList(ikanData)
            
        } else {
            
            let filteredProduct = ikanData.filter { sayur in
                
                return searchKeywords.allSatisfy { keyword in
                    
                    return sayur.lowercased().contains(keyword)
                    
                }
            }
            
            updateIkanList(filteredProduct)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateIkanList(ikanData)
        return true
    }
    
    private func updateIkanList(_ newIkanList: [String]) {
        if newIkanList.isEmpty {
            
            ikanData = ["Ikan Tuna", "Ikan Salmon","Ikan Lele", "Ikan Mas", "Ikan Gurame", "Ikan Cikalang", "Ikan Nila", "Ikan Mujair", "Ikan Bandeng"]
        } else {
            
           ikanData = newIkanList
        }
        ikanCollection.reloadData()
    }
}
