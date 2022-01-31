//
//  FriendsSearchViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit

final class FriendsSearchViewController: UITableViewController {

    private var friends = [
        UserModel(userFirstName: "Polina",
                  userSurname: "James",
                  userPhoto: UIImage(named: "2"),
                  userPhotos: [UIImage(named: "background")!, UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!],
                  userAge: 20,
                  id: 0),
        UserModel(userFirstName: "Ivan",
                  userSurname: "Gomez",
                  userPhoto: UIImage(named: "3"),
                  userPhotos: [UIImage(named: "background")!, UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!],
                  userAge: 20,
                  id: 1),
        UserModel(userFirstName: "Pavel",
                  userSurname: "Harvey",
                  userPhoto: UIImage(named: "5"),
                  userPhotos: [UIImage(named: "background")!, UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!],
                  userAge: 20,
                  id: 2),
        UserModel(userFirstName: "Maria",
                  userSurname: "Fernando",
                  userPhoto: UIImage(named: "6"),
                  userPhotos: [UIImage(named: "background")!, UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!],
                  userAge: 20,
                  id: 3),
        UserModel(userFirstName: "Nick",
                  userSurname: "Cage",
                  userPhoto: UIImage(named: "7"),
                  userPhotos: [UIImage(named: "background")!, UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!],
                  userAge: 20,
                  id: 4),
        UserModel(userFirstName: "Shawn",
                  userSurname: "Frank",
                  userPhoto: UIImage(named: "9"),
                  userPhotos: [UIImage(named: "background")!, UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!],
                  userAge: 20,
                  id: 5)
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
    
    // сохраняем выбранный индекс в переменной selectedFriend и убираем выделения
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedFriend = friends[indexPath.row]
        performSegue(withIdentifier: "showProfile", sender: self)
    }
    
    // метод через который мы переходим на PhotosFriendCollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //вызываем подготовку к переходу
        super.prepare(for: segue, sender: sender)
        
        // проверяем что индитификатор называется "toPhotosFriend"
        if segue.identifier == "showProfile" {
            
            // проверяем что контроллер на который мы переходим является контроллером типа PhotosFriendCollectionViewController и передаем тот или иной friend по соответствующему индексу строки
            guard let detailVC = segue.destination as? PhotosFriendCollectionViewController  else { return }
            detailVC.photos = selectedFriend
            
            // индекс нажатой ячейки
            if let indexPath = tableView.indexPathForSelectedRow {
                // заголовок для Navigation Bar
                detailVC.title = nameFriend(indexPath)
            }
        }
    }
    
}

extension UITableViewController: UISearchBarDelegate {
}
