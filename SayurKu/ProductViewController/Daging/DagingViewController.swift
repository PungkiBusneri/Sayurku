//
//  DagingViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class DagingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shoppingChart: UIButton!
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var dagingCollection: UICollectionView!
    
    private var cellIdentifier = "DagingCollectionViewCell"
    private var dagingData = ["Daging Sapi", "Ayam Potong", "Bebek Segar", "Burung Puyuh", "Daging Kambing", "Hati Sapi"]
    private var dagingImage: [String: String] = [
        
        "Daging Sapi":"Daging Sapi",
        "Ayam Potong":"Ayam Potong",
        "Bebek Segar":"Bebek Segar",
        "Burung Puyuh":"Burung Puyuh",
        "Daging Kambing":"Kambing Segar",
        "Hati Sapi": "Hati Sapi"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dagingCollection.dataSource = self
        dagingCollection.delegate = self
        
        dagingCollection.register(UINib(nibName: "DagingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        searchBar.delegate = self
        searchBar.attributedPlaceholder = NSAttributedString(
            string: "Cari Dagingnya Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dagingData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DagingCollectionViewCell
        
        cell.backgroundColor = .pink
        cell.layer.cornerRadius = 10.0
        
        let kategoryIndex = min(indexPath.item, dagingData.count - 1)
        if let namaGambar = dagingImage[dagingData[kategoryIndex]] {
            cell.dagingImage.image = UIImage(named: namaGambar)
        }
        cell.labelName.text = dagingData[indexPath.item]
        return cell
    }
    
}
extension DagingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateDagingList(dagingData)
            
        } else {
            
            let filteredProduct = dagingData.filter { sayur in
                
                return searchKeywords.allSatisfy { keyword in
                    
                    return sayur.lowercased().contains(keyword)
                    
                }
            }
            
            updateDagingList(filteredProduct)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateDagingList(dagingData)
        return true
    }
    
    private func updateDagingList(_ newDagingList: [String]) {
        if newDagingList.isEmpty {
            
            dagingData = ["Daging Sapi", "Ayam Potong", "Bebek Segar", "Burung Puyuh", "Daging Kambing", "Hati Sapi"]
        } else {
            
            dagingData = newDagingList
        }
        dagingCollection.reloadData()
    }
}
