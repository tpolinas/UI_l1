//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//
import UIKit

final class AllGroupsViewController: UITableViewController {

    var groups = [
        "/testpool",
        "киберпанк, который мы заслужили",
        "Десигн",
        "Однажды в Википедии",
        "Вся история рока",
        "Цитаты Курта Кобейна",
        "RUSH band",
        "Квантовые вычисления",
        "Типичный Сисадмин",
        "Физика для еб@нов",
    ]
    var groupSectionTitles = [String]()
    var groupsDictionary = [String: [String]]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "GroupCell",
            bundle: nil),
                           forCellReuseIdentifier: "groupCell")
        
        for group in groups {
            let groupKey = String(group.prefix(1))
            if var groupValues = groupsDictionary[groupKey] {
                groupValues.append(group)
                groupsDictionary[groupKey] = groupValues
            } else {
                groupsDictionary[groupKey] = [group]
            }
        }
        
        groupSectionTitles = [String](groupsDictionary.keys)
        groupSectionTitles = groupSectionTitles.sorted(by: { $0 < $1 })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let groupKey = groupSectionTitles[section]
        if let groupValues = groupsDictionary[groupKey] {
            return groupValues.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupSectionTitles
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell
        else { return UITableViewCell() }
        
        var currentGroup = groups[indexPath.row]
        
        let groupKey = groupSectionTitles[indexPath.section]
        if let groupValues = groupsDictionary[groupKey] {
            currentGroup = groupValues[indexPath.row]
        }
        
        cell.configure(
            photo: UIImage(systemName: "person.3.fill") ?? UIImage(),
            name: currentGroup)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
        performSegue(
            withIdentifier: "addGroup",
            sender: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
