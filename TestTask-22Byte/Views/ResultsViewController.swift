//
//  ResultsViewController.swift
//  TestTask-22Byte
//
//  Created by Nikolai  on 15.10.2023.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .white
        view.backgroundColor = .init(red: 171/255, green: 237/255, blue: 216/255, alpha: 1)
        view.addSubview(tableView)
        
        setupTableView()
        setConstraints()
        
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "Журнал"
        registerCell()
    }
    
    func registerCell() {
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Base.shared.allGamesInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier,
                                                       for:  indexPath) as? MainCell else {
            return UITableViewCell()
        }
        cell.setupCell(array: Base.shared.allGamesInfo[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailsViewController(Base.shared.allGamesInfo[indexPath.row].name)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
