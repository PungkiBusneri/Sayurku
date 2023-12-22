//
//  BuahViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class BuahViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shoppingChart: UIButton!
    @IBOutlet var searchProduct: UITextField!
    @IBOutlet var buahColllection: UICollectionView!
    
    private var cellIdentifier = "BuahCollectionViewCell"
    private var buahData = ["Apel", "Anggur", "Rambutan", "Jeruk Medan", "Mangga", "Kelapa Muda", "Pepaya", "Nenas", "Pisang", "Semangka"]
    private var gambarBuah: [String: String] = [
        "Apel": "Apel",
        "Anggur": "Anggur",
        "Rambutan": "Rambutan",
        "Jeruk Medan": "Jeruk Medan",
        "Mangga": "Mangga",
        "Kelapa Muda": "Kelapa Muda",
        "Pepaya": "Pepaya",
        "Nenas": "Nenas",
        "Semangka": "Semangka",
        "Pisang": "Pisang"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buahColllection.dataSource = self
        buahColllection.delegate = self
        
        buahColllection.register(UINib(nibName: "BuahCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        searchProduct.delegate = self
        searchProduct.attributedPlaceholder = NSAttributedString(
            string: "Cari Buahnya Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buahData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BuahCollectionViewCell
        
        cell.backgroundColor = .greenWelcome
        cell.layer.cornerRadius = 10.0
        
        let kategoriIndex = min(indexPath.item, buahData.count - 1)
        
        if let namaGambar = gambarBuah[buahData[kategoriIndex]] {
                cell.buahImage.image = UIImage(named: namaGambar)
            }
        cell.buahNameLabel.text = buahData[indexPath.item]
        
        return cell
    }
}
extension BuahViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateBuahList(buahData)
            
        } else {
            
            let filteredProduct = buahData.filter { sayur in
                
                return searchKeywords.allSatisfy { keyword in
                    
                    return sayur.lowercased().contains(keyword)
                    
                }
            }
            
            updateBuahList(filteredProduct)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateBuahList(buahData)
        return true
    }
    
    private func updateBuahList(_ newBuahList: [String]) {
        if newBuahList.isEmpty {
            
            buahData = ["Apel", "Anggur", "Rambutan", "Jeruk Medan", "Mangga", "Kelapa Muda", "Pepaya", "Nenas", "Pisang", "Semangka"]
        } else {
            
            buahData = newBuahList
        }
        buahColllection.reloadData()
    }
}
