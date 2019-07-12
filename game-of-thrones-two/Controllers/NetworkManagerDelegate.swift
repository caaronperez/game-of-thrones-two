import Foundation

protocol NetworkManagerDelegate: class {
    func didDownloadPost(postArray: [String: Any])
}

protocol NetworkManagerDelegateSerie: class {
    func didDownloadPost(postArray: [Episode])
}


