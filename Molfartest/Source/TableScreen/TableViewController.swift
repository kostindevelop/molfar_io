//
//  TableViewController.swift
//  Molfartest
//
//  Created by Konstantin Igorevich on 27.02.2020.
//  Copyright © 2020 Konstantin Igorevich. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet private weak var lbCounter: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var persons = [Person]()
    
    var searchAge = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData() {
        DispatchQueue.global(qos: .background).async {
            
            self.persons = StorageService.shared.getPersons(by: self.searchAge)

            DispatchQueue.main.async {
                self.lbCounter.text = "Number of persons found: \(self.persons.count)"
                self.tableView.reloadData()
            }
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.isEmpty ? 0 : persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        cell.textLabel?.text = persons[indexPath.row].name
        cell.detailTextLabel?.text = "\(persons[indexPath.row].age)"
        return cell
    }
}
