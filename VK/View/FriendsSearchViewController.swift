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
                  userPhoto: UIImage(systemName: "star"),
                  userAge: 20),
        UserModel(userFirstName: "Ivan",
                  userSurname: "Gomez",
                  userPhoto: UIImage(systemName: "star"),
                  userAge: 20),
        UserModel(userFirstName: "Pavel",
                  userSurname: "Harvey",
                  userPhoto: UIImage(systemName: "star"),
                  userAge: 20),
        UserModel(userFirstName: "Maria",
                  userSurname: "Fernando",
                  userPhoto: UIImage(systemName: "star"),
                  userAge: 20),
        UserModel(userFirstName: "Nick",
                  userSurname: "Cage",
                  userPhoto: UIImage(systemName: "star"),
                  userAge: 20),
        UserModel(userFirstName: "Shawn",
                  userSurname: "Frank",
                  userPhoto: UIImage(systemName: "star"),
                  userAge: 20)
    ]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userFriends: [UserModel] = []
    var friendSectionTitles = [String]()
    var friendsDictionary = [String: [UserModel]]()
    
    //эталонный массив с именами для сравнения при поиске
    var perfectArrayWithNames: [String] = []
    
    // массив с именами меняется (при поиске) и используется в таблице
    var namesListModifed: [String] = []
    
    var letersOfNames: [String] = []
    
    // создание массива из имен пользователей
    func arrayOfUserNames() {
        
        // удаляем все элементы эталонного массива с именами
        perfectArrayWithNames.removeAll()
        
        // получаем число элементов массива
        for item in 0...(friends.count - 1) {
            
            // добавляем элементы в эталонный массив с именами
            perfectArrayWithNames.append(friends[item].userFirstName)
        }
        namesListModifed = perfectArrayWithNames
    }
    
    // созданием массива из начальных букв имен пользователй по алфавиту
    func sortNamesAlphabetically() {
        
        var letersSet = Set<Character>()
        
        // обнуляем массив на случай повторного использования
        letersOfNames = []
        
        // создание сета из первых букв имени, чтобы не было повторов
        for name in namesListModifed {
            
            // insert - вставка элемента в определенное место массива
            letersSet.insert(name[name.startIndex])
        }
        
        // заполнение массива строк из букв имен
        // возвращам новый отсортированный массив, никак не изменяя старый
        for leter in letersSet.sorted() {
            letersOfNames.append(String(leter))
        }
    }
    
    func nameFriend(_ indexPath: IndexPath) -> String {
        var namesRows = [String]()
        for name in namesListModifed.sorted() {
            if letersOfNames[indexPath.section].contains(name.first!) {
                namesRows.append(name)
            }
        }
        return namesRows[indexPath.row]
    }
    
    func surnameFriend(_ indexPath: IndexPath) -> String? {
        for friend in friends {
            let namesRows = nameFriend(indexPath)
            if friend.userFirstName.contains(namesRows) {
                return friend.userSurname
            }
        }
        return nil
    }
    
    func photoFriend(_ indexPath: IndexPath) -> UIImage? {
        for friend in friends {
            let namesRows = nameFriend(indexPath)
            if friend.userFirstName.contains(namesRows) {
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
        
        // создаем заново массив заглавных букв для хедера
        sortNamesAlphabetically()
        tableView.reloadData()
    }
    
    // отмена поиска (через кнопку Cancel)
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true // показыть кнопку Cancel
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false // скрыть кнопку Cancel
        searchBar.text = nil
        arrayOfUserNames() // возвращаем массив имен
        sortNamesAlphabetically()  // создаем заново массив заглавных букв для хедера
        tableView.reloadData() //обновить таблицу
        searchBar.resignFirstResponder() // скрыть клавиатуру
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        letersOfNames.count
    }
    
    // настройка хедера ячеек и добавление в него букв
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        // цвет и прозрачность хедера
        header.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        // координаты размещения букв
        let leter: UILabel = UILabel(frame: CGRect(x: 27, y: 5, width: 20, height: 20))
        // цвет и прозрачность букв
        leter.textColor = UIColor.cyan.withAlphaComponent(1)
        leter.text = letersOfNames[section]
        // размер и толщина букв
        leter.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        header.addSubview(leter)
        
        return header
    }
    
    // список букв для навигации (справа контрол)
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRows = 0
        // сравниваем массив букв и заглавные буквы каждого имени, выводим количество ячеек в соотвествии именам на отдельную букву
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
        
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true)}
        performSegue(
            withIdentifier: "showProfile",
            sender: nil)
        let friendKey = letersOfNames[indexPath.section]
        var currentFriend = friends[indexPath.row]
        if let friendValues = friendsDictionary[friendKey] {
            currentFriend = friendValues[indexPath.row]
        }
        
        if userFriends.firstIndex(of: currentFriend) == nil {
            userFriends.append(currentFriend)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile",
           let myFriendsViewController = segue.destination as? MyFriendsViewController {
            myFriendsViewController.friends = userFriends
        }
    }
}

extension UITableViewController: UISearchBarDelegate {
}
