//
//  AddNoteCtr.swift
//  NoteApp
//
//  Created by HieuTong on 3/1/21.
//

import UIKit

class AddNoteCtr: UIViewController {
    
    var note: Note? {
        didSet {
            guard let note = note else {
                return
            }
            navigationItem.title = note.title
            textField.text = note.title
            textView.text = note.note
        }
    }
    var update: Bool = false
    
    let textField = UIMaker.makeTextField(font: .systemFont(ofSize: 14), color: .coin_font_title)
    let textView = UIMaker.makeTextView()
    lazy var saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
    lazy var deleteButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(handleDelete))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        
        setupView(view: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !update {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    func setNavBar() {
        
        
        deleteButton.tintColor = .red
        
        navigationItem.rightBarButtonItems = [saveButton, deleteButton]
        navigationController?.isNavigationBarHidden = false

    }
    
    func setupView(view: UIView) {
        view.backgroundColor = .gray
        view.addSubviews(views: textField, textView)
        textField.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(16)
            maker.height.equalTo(44)
            maker.top.equalToSuperview().inset(100)
        }
        textView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview().inset(16)
            maker.bottom.equalToSuperview().inset(16)
            maker.top.equalTo(textField.snp.bottom).offset(16)
        }
        textField.backgroundColor = .white
        textView.backgroundColor = .cyan
    }
    
    @objc func handleSave() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        guard let title = textField.text, title != "", let noteText = textView.text, noteText != "" else { return }
        if !update {
            APIFunction.functions.addNote(date: date, title: title, note: noteText)
        } else {
            APIFunction.functions.updateNote(date: date, title: title, note: noteText, id: note?._id ?? "")
        }
        pop()
    }
    
    @objc func handleDelete() {
        guard let note = note else { return }
        APIFunction.functions.deleteNote(id: note._id)
        pop()
    }
}


