//
//  ViewController.swift
//  PersonBook
//
//  Created by admin on 20/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Person>!
    override func loadView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 8
        collectionView = UICollectionView(frame: .zero, collectionViewLayout:  UICollectionViewFlowLayout())
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: PersonCell.reusableId)
        
        setupCollectionView()
        //collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        view = collectionView
        collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}


extension ViewController {
    
    func setupCollectionView(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reusableId, for: indexPath) as? PersonCell else {
                fatalError("person cell not found!")
            }
            let path = self.getDocumentsDirectory().appendingPathComponent(itemIdentifier.image)
            cell.imageView.image = UIImage(contentsOfFile: path.path())
            cell.nameLabel.text = itemIdentifier.name
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,Person>()
        snapshot.appendSections([.main])
        if let previousPeople = loadData() {
            snapshot.appendItems(previousPeople)
        }
        dataSource.apply(snapshot)
    }
    
    func setup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPersonTapped))
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func updateCollectionView(_ person: Person) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([person])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    //private func loadData() -> [Person]? {
    //        let defaults = UserDefaults.standard
    //
    //        if let savedPeople = defaults.object(forKey: "people") as? Data {
    //            if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
    //                return decodedPeople
    //            }
    //        }
    //        return nil
    //    }
        
//    func save() {
//        let people = dataSource.snapshot().itemIdentifiers
//        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
//            let defaults = UserDefaults.standard
//            for (index, item) in people.enumerated() {
//                print("\(index) \(item.name)")
//            }
//            defaults.set(savedData, forKey: "people")
//        }
//    }
    
    private func loadData() -> [Person]? {
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                let people = try jsonDecoder.decode([Person].self, from: savedPeople)
                return people
            } catch {
                print("Failed to load people")
            }
        }
        return nil
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        let people = dataSource.snapshot().itemIdentifiers
        if let savedData = try? jsonEncoder.encode(people) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        } else {
            print("Failed to save people.")
        }
    }
}


extension ViewController {
    @objc func addPersonTapped() {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIAlertController(title: "Enter person name", message: "", preferredStyle: .alert)
        vc.addTextField()
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        vc.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self, weak vc]_ in
            if let personName = vc?.textFields?[0].text {
                let oldPerson = self?.dataSource.itemIdentifier(for: indexPath)
                let oldSnapShot = self?.dataSource.snapshot()
                if let oldPerson , var oldSnapShot {
                    let person = Person(name: personName, image:  oldPerson.image)
                    oldSnapShot.insertItems([person], afterItem: oldPerson)
                    oldSnapShot.deleteItems([oldPerson])
                    self?.dataSource.apply(oldSnapShot, completion: { [weak self] in
                        guard let self else {return}
                        self.save()
                    })
                   
                }
            }
        }))
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 140, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appending(path: imageName)
        if let jpgData = image.jpegData(compressionQuality: 0.8) {
            try? jpgData.write(to: imagePath)
        }
        var newPerson = Person(name: "Unkown", image:  imageName)
        newPerson.name = "Unkown"
        newPerson.image = imageName
        updateCollectionView(newPerson)
        save()
        dismiss(animated: true)
    }
}


enum Section {
    case main
}


class PersonCell : UICollectionViewCell {
    static let reusableId = "basic_cell"
    var imageView = UIImageView()
    var nameLabel = UILabel()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setup()
        layout()
    }
    
    func setup(){
        
        clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .preferredFont(forTextStyle: .caption1)
        nameLabel.textColor = .black
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
    }
    
    func layout(){
        [imageView,nameLabel].forEach(contentView.addSubview)
        
        //image
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        //label
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1)
        ])
    }
    
}


//class Person: NSObject,NSCoding {
//    var name: String
//    var image: String
//
//    init(name: String, image: String) {
//        self.name = name
//        self.image = image
//        super.init()
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
//        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
//        aCoder.encode(image, forKey: "image")
//    }
//    
//    static func == (lhs: Person, rhs: Person) -> Bool {
//        return lhs.hash == rhs.hash
//    }
//}


class Person: NSObject, Codable {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
        super.init()
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.hash == rhs.hash
    }
}
