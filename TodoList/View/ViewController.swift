//
//  ViewController.swift
//  TodoList
//
//  Created by Jorge Alejndro Marcial Galvan on 29/12/23.
//

import UIKit

class ViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let tableViewToDo: UITableView = UITableView()

    var models = [ToDoListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "To Do List"

        setUpView()
        setUpLayout()
        
        getAllItems()
    }

    private func setUpView() {
        tableViewToDo.translatesAutoresizingMaskIntoConstraints = false
        tableViewToDo.delegate = self
        tableViewToDo.dataSource = self
        tableViewToDo.register(TableViewToDoCell.self, forCellReuseIdentifier: TableViewToDoCell.id)
        // tableViewToDo.frame = view.bounds

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }

    private func setUpLayout() {
        view.addSubview(tableViewToDo)

        NSLayoutConstraint.activate([
            tableViewToDo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewToDo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24), // Left
            tableViewToDo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24), // Right
            tableViewToDo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            self?.createItem(name: text)
        }))
        
        present(alert, animated: true)
    }

    // MARK: - Core Data

    func getAllItems() {
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())

            DispatchQueue.main.async {
                self.tableViewToDo.reloadData()
            }
        } catch {
            // error
        }
    }

    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()

        do {
            try context.save()
            getAllItems()
        } catch {
        }
    }

    func deleteItem(item: ToDoListItem) {
        context.delete(item)

        do {
            try context.save()
            getAllItems()
        } catch {
        }
    }

    func updateItem(item: ToDoListItem, newName: String) {
        item.name = newName

        do {
            try context.save()
            getAllItems()
        } catch {
        }
    }
}
