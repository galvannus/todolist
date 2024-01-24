//
//  TableViewToDoCell.swift
//  TodoList
//
//  Created by Jorge Alejndro Marcial Galvan on 30/12/23.
//

import Foundation
import UIKit

class TableViewToDoCell: UITableViewCell {
    static let id = "TableViewToDoCellId"

    var titleLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpView()
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        titleLabel.textColor = .black
        [titleLabel].forEach{
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func setUp(with model: ToDoListItem) {
        titleLabel.text = model.name
    }
}
