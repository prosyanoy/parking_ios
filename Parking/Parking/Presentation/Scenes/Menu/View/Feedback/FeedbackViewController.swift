//
//  FeedbackViewController.swift
//  Parking
//
//  Created by Никита Макаревич on 07.09.2022.
//

import UIKit
import MessageUI

final class FeedbackViewController: UIViewController {
    
    private let transparentView = UIView()
    private let optionsTableView = UITableView()
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    private var selectedOption = "Другое"
    private var reportMessageBody = "Текст"
    private let reportOptions = ["Режим работы",
                                 "Чек об оплате",
                                 "Возврат средств",
                                 "Другое",
                                 "Оставить отзыв"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGray5
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    private let optionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.text = "Тема"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var optionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выберите тему", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapOptionsButton), for: .touchUpInside)
        
        return button
    }()
    
    private let reportTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .lightGray
        textView.text = "Текст обращения"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(UIColor.systemGray4, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.6
        button.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        
        return button
    }()
}
// MARK: - MessageUI extension
extension FeedbackViewController: MFMailComposeViewControllerDelegate {
    
    /// отпарвка сообщения на email
    @objc func sendEmail() {
        if MFMailComposeViewController.canSendMail() { // Отправка письма не возможна на симуляторе
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["support@pros.sbs"]) // адрес почты, куда упадет письмо
            mail.setSubject(selectedOption) // Тема письма
            mail.setMessageBody("<p>\(reportMessageBody)</p>", isHTML: true) // Тело письма
            
            present(mail, animated: true)
        }
        else {
            print("Failed to send message")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

// MARK: - UITextViewDelegate extension
extension FeedbackViewController: UITextViewDelegate {
    
    /// убираем placeHolder, если юзер нажал на textView
    func textViewDidBeginEditing (_ textView: UITextView) {
        if reportTextView.textColor == UIColor.lightGray && reportTextView.isFirstResponder {
            reportTextView.text = ""
            reportTextView.textColor = .black
        }
    }
    
    /// возвращаем placeHolder, когда юзер уже нажимал на textView, но оставил поле пустым
    func textViewDidEndEditing (_ textView: UITextView) {
        if reportTextView.text.isEmpty || reportTextView.text == "" {
            reportTextView.textColor = .lightGray
            reportTextView.text = "Текст обращения"
        }
    }
    
    /// убираем клавиатуру, когда нажимаем в любое место кроме самого textView
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - DropDown menu extension
private extension FeedbackViewController {
    
    /// Создаем и добавляем drop-down меню
    func addTransparentView(frames: CGRect) {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        transparentView.frame = keyWindow?.frame ?? self.view.frame
        view.addSubview(transparentView)
        
        optionsTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        optionsTableView.layer.cornerRadius = 5
        view.addSubview(optionsTableView)
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0.5
            self.optionsTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.reportOptions.count * 50 + 20))
        }, completion: nil)
    }
    
    /// убрать drop-down меню
    @objc func removeTransparentView() {
        let frames = optionsButton.frame
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0
            self.optionsTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    ///  Вызываем функцию для добавления и отрисовки drop-down menu
    @objc func didTapOptionsButton() {
        addTransparentView(frames: optionsButton.frame)
    }
    
}

// MARK: - TableView для drop-down меню
extension FeedbackViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reportOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = optionsTableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        cell.textLabel?.text = reportOptions[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        optionsButton.setTitle(reportOptions[indexPath.row], for: .normal)
        optionsButton.setTitleColor(UIColor.black, for: .normal)
        selectedOption = reportOptions[indexPath.row]
        sendButton.isUserInteractionEnabled = true
        sendButton.setTitleColor(UIColor.systemBlue, for: .normal)
        sendButton.alpha = 1
        removeTransparentView()
    }
}

// MARK: - View Configuration extension
private extension FeedbackViewController {
    func configureView() {
        configureNavigationBar()
        reportTextView.delegate = self
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "optionCell")
        
        createObserversForKeyboard()
        
        optionStackView.addSubview(optionLabel)
        optionStackView.addSubview(optionsButton)
        view.addSubview(optionStackView)
        view.addSubview(sendButton)
        view.addSubview(reportTextView)
        setConstraints()
    }
    
    /// настройки для шапки UINavigationController'a
    func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationItem.title = "Обращение"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.setLeftBarButton(UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(backButtonTapped)),
            animated: false)
    }
    
    /// Убирает текущий экран
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
    /// Создаем обзерверы для добавления и удаления gestureRecognizer в зависимтости от состояния клавиатуры
    func createObserversForKeyboard() {
        let willHide = UIResponder.keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: willHide, object: nil)
        let willShow = UIResponder.keyboardWillShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: willShow, object: nil)
    }
    
    /// добавляем распознаватель жестов, когда клавиатура открывается
    @objc func keyboardWillAppear() {
        view.addGestureRecognizer(tap)
    }
    
    /// убирваем распознаватель жестов, когда клавиатура скрывается
    @objc func keyboardWillDisappear() {
        view.removeGestureRecognizer(tap)
        reportMessageBody = reportTextView.text
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            optionStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            optionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            optionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            optionLabel.topAnchor.constraint(equalTo: optionStackView.topAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: optionStackView.leadingAnchor, constant: 20),
            optionLabel.bottomAnchor.constraint(equalTo: optionStackView.bottomAnchor),
            
            optionsButton.heightAnchor.constraint(equalToConstant: 35),
            optionsButton.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            optionsButton.topAnchor.constraint(equalTo: optionStackView.topAnchor),
            optionsButton.leadingAnchor.constraint(equalTo: optionLabel.trailingAnchor, constant: 50),
            optionsButton.trailingAnchor.constraint(equalTo: optionStackView.trailingAnchor, constant: -20),
            optionsButton.bottomAnchor.constraint(equalTo: optionStackView.bottomAnchor),
            
            reportTextView.topAnchor.constraint(equalTo: optionStackView.bottomAnchor, constant: 40),
            reportTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reportTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reportTextView.bottomAnchor.constraint(greaterThanOrEqualTo: sendButton.topAnchor, constant: -100),
            
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}

