import Foundation

public extension URL {
    func canonicalizePath() -> String {
        let filePath: String
        if #available(OSX 13.0, *) {
            filePath = absoluteURL.path()
        } else {
            filePath = absoluteURL.path
        }

        return filePath
    }
}
