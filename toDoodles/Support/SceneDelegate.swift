//
//  SceneDelegate.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 28/11/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        configureNC()
    }
    
    func historyNC() -> UINavigationController {
        let historyVC = HistoryVC()
        historyVC.title = "History"
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), tag: 0)
        return UINavigationController(rootViewController: historyVC)
    }
    
    func todayNC() -> UINavigationController {
        let todayVC = TodayVC()
        todayVC.title = "Today"
        todayVC.tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "list.bullet"), tag: 1)
        return UINavigationController(rootViewController: todayVC)
    }
    
    func progressNC() -> UINavigationController {
        let progressVC = ProgressVC()
        progressVC.title = "Progress"
        progressVC.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(systemName: "chart.bar.xaxis"), tag: 2)
        return UINavigationController(rootViewController: progressVC)
    }
    
    func configureNC() {
        UINavigationBar.appearance().tintColor = .systemIndigo
    }
    
    func createTabBar() -> UITabBarController {
       let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemIndigo
        tabbar.viewControllers = [historyNC(), todayNC(), progressNC()]
        tabbar.selectedIndex = 1 // this selects which item you want to be presented first
        return tabbar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

