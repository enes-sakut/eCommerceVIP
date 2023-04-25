//
//  SearchTextField.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 18.04.2023.
//

import UIKit

public protocol SearchTextFieldDelegate: AnyObject {
    func textFieldDidBeginEditing(searchText: String?)
}

class SearchTextField: UITextField {
    
    public weak var searchDelegate: SearchTextFieldDelegate?
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "searchIcon"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchView() {
        delegate = self
        borderStyle = .none
        textColor = .black
        backgroundColor = UIColor(named: "searchBackgroundColor")
        font = .latoRegular12
        attributedPlaceholder = NSAttributedString(string: "Marka, ürün veya hizmet arayın",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeHolderColor") ?? UIColor.placeholderText])

        layer.borderWidth = 1.0
        layer.borderColor = UIColor(named: "contentBorderColor")?.cgColor
        layer.cornerRadius = 6.0
        clearButtonMode = .always
        leftView = searchButton
        leftViewMode = .always
        self.addTarget(self, action: #selector(editingDidChange(textField:)), for: .editingChanged)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.leftViewRect(forBounds: bounds)
        padding.origin.x += 12

        return padding
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 12.0, left: 40.0, bottom: 12.0, right: 0.0))
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 12.0, left: 40.0, bottom: 12.0, right: 36.0))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 12.0, left: 40.0, bottom: 12.0, right: 36.0))
    }
    @objc func editingDidChange(textField: UITextField) {
        let newText = textField.text ?? ""
        searchDelegate?.textFieldDidBeginEditing(searchText: newText)
    }

}

extension SearchTextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if text?.isEmpty ?? true {
            rightViewMode = .never
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        let newText = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let text = textField.text, let predictRange = Range(range, in: text) else { return true }
        let predictedText = text.replacingCharacters(in: predictRange, with: newText)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        if predictedText.isEmpty {
            rightViewMode = .never
        } else {
            rightViewMode = .whileEditing
        }
        return true
    }
}
