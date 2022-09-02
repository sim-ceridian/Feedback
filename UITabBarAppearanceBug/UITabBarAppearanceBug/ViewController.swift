//
//  ViewController.swift
//  TabBarTest
//
//  Created by Saint-Saens, Simeon on 1/9/2022.
//

import UIKit

class ViewController: UIViewController {

    let icon: String
    
    func button(title: String, icon: String, action: @escaping ()->Void) -> UIButton {
        var config = UIButton.Configuration.bordered()
        config.title = title
        config.image = UIImage(systemName: icon)
                
        let button = UIButton(primaryAction: UIAction { _ in
            action()
        })
        
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    init(title: String, icon: String, tag: Int) {
        
        self.icon = icon
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        
        tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), tag: tag)
        
        var config = UIButton.Configuration.bordered()
        config.title = "Apply UITabBar Appearance"
        config.image = UIImage(systemName: "paintpalette.fill")
                
        let customStyleButton = button(title: "Apply Custom Appearance", icon: "paintpalette.fill") { [weak self] in
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.red]
            appearance.stackedLayoutAppearance.normal.iconColor = .red
            
            self?.tabBarController?.tabBar.standardAppearance = appearance
        }
        
        let emptyStyleButton = button(title: "Apply Same Appearance", icon: "paintpalette.fill") { [weak self] in
            guard let tabBar = self?.tabBarController?.tabBar else { return }
            
            tabBar.standardAppearance = tabBar.standardAppearance
                                    
            print("Applied the same appearance to the tab bar itself")
        }
        
        let resetViewControllersButton = button(title: "Reset View Controllers", icon: "arrow.triangle.2.circlepath") { [weak self] in
            self?.tabBarController?.setViewControllers([
                ViewController(title: "Home", icon: "house", tag: 0),
                ViewController(title: "Approvals", icon: "checkmark.circle", tag: 1),
                ViewController(title: "Calendar", icon: "calendar", tag: 2),
                ViewController(title: "Dayforce Assistant Test", icon: "mic.fill", tag: 3),
                ViewController(title: "More", icon: "ellipsis", tag: 4),
            ], animated: false)
        }

        let stack = UIStackView(arrangedSubviews: [customStyleButton, emptyStyleButton, resetViewControllersButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .fill
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .tertiarySystemBackground
        
    }


}

