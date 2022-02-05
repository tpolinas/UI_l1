//
//  FriendsSearchViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit

final class FriendsSearchViewController: UITableViewController {

    private var friends = [
        UserModel(userFirstName: "Geddy",
                  userSurname: "Lee",
                  userPhoto: UIImage(named: "G3"),
                  userPhotos: [UIImage(named: "G0")!, UIImage(named: "G1")!, UIImage(named: "G2")!, UIImage(named: "G3")!, UIImage(named: "G4")!, UIImage(named: "G5")!, UIImage(named: "G6")!, UIImage(named: "G7")!, UIImage(named: "G8")!, UIImage(named: "G9")!, UIImage(named: "G10")!, UIImage(named: "G11")!, UIImage(named: "G12")!, UIImage(named: "G13")!, UIImage(named: "G14")!, UIImage(named: "G15")!, UIImage(named: "G16")!, UIImage(named: "G17")!, UIImage(named: "G18")!],
                  userAge: Int(),
                  id: 0),
        UserModel(userFirstName: "Alex",
                  userSurname: "Lifeson",
                  userPhoto: UIImage(named: "A1"),
                  userPhotos: [UIImage(named: "A0")!, UIImage(named: "A1")!, UIImage(named: "A2")!, UIImage(named: "A3")!, UIImage(named: "A4")!, UIImage(named: "A5")!, UIImage(named: "A6")!, UIImage(named: "A7")!, UIImage(named: "A8")!, UIImage(named: "A9")!, UIImage(named: "A10")!, UIImage(named: "A11")!, UIImage(named: "A12")!, UIImage(named: "A13")!, UIImage(named: "A14")!, UIImage(named: "A15")!, UIImage(named: "A16")!, UIImage(named: "A17")!, UIImage(named: "A18")!],
                  userAge: Int(),
                  id: 1),
    ]

    @IBOutlet weak var searchBar: UISearchBar!

    var userFriends: [UserModel] = []
    var friendSectionTitles = [String]()
    var friendsDictionary = [String: [UserModel]]()


    var perfectArrayWithNames: [String] = []
    var namesListModifed: [String] = []
    var letersOfNames: [String] = []

    var selectedFriend: UserModel?
    
    func arrayOfUserNames() {

       
        perfectArrayWithNames.removeAll()


        for item in 0...(friends.count - 1) {


            perfectArrayWithNames.append(friends[item].userSurname)
        }
        namesListModifed = perfectArrayWithNames
    }


    func sortNamesAlphabetically() {

        var letersSet = Set<Character>()

        letersOfNames = []

        for name in namesListModifed {

            letersSet.insert(name[name.startIndex])
        }


        for leter in letersSet.sorted() {
            letersOfNames.append(String(leter))
        }
    }

    func surnameFriend(_ indexPath: IndexPath) -> String {
        var namesRows = [String]()
        for name in namesListModifed.sorted() {
            if letersOfNames[indexPath.section].contains(name.first!) {
                namesRows.append(name)
            }
        }
        return namesRows[indexPath.row]
    }

    func nameFriend(_ indexPath: IndexPath) -> String? {
        for friend in friends {
            let namesRows = surnameFriend(indexPath)
            if friend.userSurname.contains(namesRows) {
                return friend.userFirstName
            }
        }
        return nil
    }

    func photoFriend(_ indexPath: IndexPath) -> UIImage? {
        for friend in friends {
            let namesRows = surnameFriend(indexPath)
            if friend.userSurname.contains(namesRows) {
                return friend.userPhoto
            }
        }
        return nil
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        arrayOfUserNames()
        sortNamesAlphabetically()

        tableView.register(UINib(
            nibName: "FriendCell",
            bundle: nil),
                           forCellReuseIdentifier: "friendCell")

    }

    // MARK: - Table view data source

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        namesListModifed = searchText.isEmpty ? perfectArrayWithNames : perfectArrayWithNames.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }


        sortNamesAlphabetically()
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        arrayOfUserNames()
        sortNamesAlphabetically()
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        letersOfNames.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        let leter: UILabel = UILabel(frame: CGRect(x: 27, y: 5, width: 20, height: 20))
        leter.textColor = UIColor.cyan.withAlphaComponent(1)
        leter.text = letersOfNames[section]
        leter.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        header.addSubview(leter)

        return header
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRows = 0
        for name in namesListModifed {
            if letersOfNames[section].contains(name.first!) {
                countOfRows += 1
            }
        }
        return countOfRows

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendCell
        else { return UITableViewCell() }

        cell.friendName.text = nameFriend(indexPath)
        cell.friendSurname.text = surnameFriend(indexPath)
        cell.friendPhoto.image = photoFriend(indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedFriend = friends[indexPath.row]
        performSegue(withIdentifier: "showProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showProfile" {
            
            guard let detailVC = segue.destination as? PhotosFriendCollectionViewController  else { return }
            detailVC.photos = selectedFriend
            
            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.title = nameFriend(indexPath)
            }
        }
    }
    
}

extension UITableViewController: UISearchBarDelegate {
    
}
