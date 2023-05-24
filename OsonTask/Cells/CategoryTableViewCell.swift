//
//  CategoryTableViewCell.swift
//  OsonTask
//
//  Created by Mekhriddin Jumaev on 25/05/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    static let reuseID = "CategoryTableViewCell"
    
    lazy var childLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ id: Int?) {
        childLabel.text = "\(id ?? 0)"
    }
    
    private func configureUI() {
        self.addSubview(childLabel)
        childLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }

}
