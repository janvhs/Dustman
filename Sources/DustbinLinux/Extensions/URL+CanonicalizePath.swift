import Foundation

public extension URL {
    func canonicalizePath() -> String {
        absoluteURL.path
    }
}
