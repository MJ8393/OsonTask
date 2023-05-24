//
//  ViewController.swift
//  OsonTask
//
//  Created by Mekhriddin Jumaev on 23/05/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = MainViewModel()
    var categoryTableView: UITableView!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.makeTree(list: categories)
    }
    
    // MARK: UI Configuration
    
    private func configureUI() {
        categoryTableView = UITableView(frame: .zero, style: .grouped)
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseID)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
                
        view.addSubview(categoryTableView)
        categoryTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Setup Binding
    
    func setupBinding() {
        viewModel.orderedCategoriesDidChange = {
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let numOfSections = viewModel.orderedCategories?.count {
            return numOfSections
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numOfRows = viewModel.orderedCategories?[section].childs?.count {
            return numOfRows
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseID, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        if let child = viewModel.orderedCategories?[indexPath.section].childs?[indexPath.row] {
            cell.setData(child.id) 
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let parentID = viewModel.orderedCategories?[section].id {
            return "\(parentID)"
        }
        return ""
    }
}
