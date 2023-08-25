//
//  HistoryViewController.swift
//  langchain_implementation
//
//  Created by Ashley Liu on 2023-07-22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var pastLabel = UILabel()
    var searchBar = UITextField()
    var backButton = UIButton()
    var backConfiguration = UIButton.Configuration.plain()
    let reuseIdentifier = "itineraryReuseIdentifier"
    var iteneraryVCList:[UIViewController] = []
    var iteneraryNamesList:[String] = []
    
    
    
    var itineraryList: UICollectionView!
    let spacing: CGFloat = 20
    

    var dummydata: [Itinerary] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: true)
        //UIBarButtonItem(title: "please", style: .plain, target: self, action: nil)
        
        createDummyData()
        
        pastLabel.text = "Past Itineraries"
        pastLabel.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        pastLabel.font = .systemFont(ofSize: 50, weight: .bold)
        pastLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(pastLabel)
        
        searchBar.text = "Search"
        searchBar.textColor = UIColor(red: 0.74, green: 0.80, blue: 0.84, alpha: 1)
        searchBar.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchBar)
        
        var itineraryLayout = UICollectionViewFlowLayout()
        itineraryLayout.minimumLineSpacing = spacing
        itineraryLayout.minimumInteritemSpacing = spacing
        itineraryLayout.scrollDirection = .vertical
        
        itineraryList = UICollectionView(frame: .zero, collectionViewLayout: itineraryLayout)
        itineraryList.register(ItineraryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        itineraryList.backgroundColor = .white
        itineraryList.dataSource = self
        itineraryList.delegate = self
        itineraryList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itineraryList)
        
        backConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        backButton.configuration = backConfiguration
        
        backButton.backgroundColor = UIColor(red: 0.74, green: 0.8, blue: 0.84, alpha: 1)
        backButton.layer.cornerRadius = 10
        backButton.addTarget(self, action: #selector(goBack), for:.touchUpInside)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pastLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pastLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 22)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: pastLabel.bottomAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 22),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -22),
            searchBar.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            itineraryList.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: spacing),
            itineraryList.leftAnchor.constraint(equalTo: searchBar.leftAnchor),
            itineraryList.rightAnchor.constraint(equalTo: searchBar.rightAnchor),
            itineraryList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: spacing),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1*spacing),
        ])
    }
    
    func createDummyData() {
//        let toronto = Itinerary(destination: "Toronto")
//        let dallas = Itinerary(destination: "Dallas")
//        let ithaca = Itinerary(destination: "Ithaca")
//        let nyc = Itinerary(destination: "NYC")
//        let paris = Itinerary(destination: "Paris")
//        let shanghai = Itinerary(destination: "Shanghai")
//
//        dummydata = [toronto, dallas, ithaca, nyc, paris, shanghai]
        
        NetworkManager.getAllItineraries { itinerary in
            self.dummydata = itinerary.itineraries
            self.itineraryList.reloadData()
        }
        
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HistoryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = itineraryList.dequeueReusableCell(withReuseIdentifier: "itineraryReuseIdentifier", for: indexPath) as? ItineraryCollectionViewCell {
            cell.configure(location: iteneraryNamesList[indexPath.row], vc: iteneraryVCList[indexPath.row])
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iteneraryNamesList.count
    }
    
}

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = searchBar.frame.width
        return CGSize(width: size, height: size*0.15)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(iteneraryVCList[indexPath.row], animated: true)
    }
}
