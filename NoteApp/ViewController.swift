//
//  ViewController.swift
//  NoteApp
//
//  Created by HieuTong on 3/1/21.
//

import UIKit
import SnapKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notesArray = [Note]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNav()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.ID)
        APIFunction.functions.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIFunction.functions.fetchNotes()
    }

    
    func setupNav() {
        navigationItem.title = "Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add notes", style: .plain, target: self, action: #selector(handleNote))
    }
    
    @objc func handleNote() {
        let ctr = AddNoteCtr()
        push(ctr)
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.ID, for: indexPath) as! NoteCell
        cell.note = notesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ctr = AddNoteCtr()
        ctr.note = notesArray[indexPath.row]
        ctr.update = true
        push(ctr)
    }

}

// MARK: - Custom Delegate

protocol DataDelegate {
    func updateArray(newArray: String)
}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            let decoder = JSONDecoder()
            notesArray = try decoder.decode([Note].self, from: newArray.data(using: .utf8)!)

        } catch {
            print("Failed to fetch")
        }
        self.tableView.reloadData()
    }
}

class NoteCell: BaseTableCell {
    static let ID = "NoteCell"
    
    var note: Note? {
        didSet {
            guard let note = note else { return }
            titleLabel.text = note.title
            noteLabel.text = note.note
            dateLabel.text = note.date
        }
    }
    
    let titleLabel = UIMaker.makeTitleLabel()
    let noteLabel = UIMaker.makeContentLabel(fontSize: 14)
    let dateLabel = UIMaker.makeContentLabel(fontSize: 14)
    override func setupView() {
        addSubviews(views: titleLabel, noteLabel, dateLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.top.equalToSuperview().inset(16)
        }
        
        noteLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(16)
            maker.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        dateLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(16)
            maker.top.equalTo(noteLabel.snp.bottom).offset(16)
            maker.bottom.equalToSuperview().inset(16)
        }
    }
}



class BaseTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
}

