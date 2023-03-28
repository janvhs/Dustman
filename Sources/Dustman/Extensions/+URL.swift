import Foundation

extension URL {
    func absolutePath() -> String {
        let filePath: String

        // TODO: Find the support matrix for this.
        #if os(Linux)
            filePath = absoluteURL.path
        #else
            // TODO: Check if this can be removed because of the minimum os version set in Package.swift.
            if #available(OSX 13.0, *) {
                filePath = absoluteURL.path()
            } else {
                filePath = absoluteURL.path
            }
        #endif

        return filePath
    }
}
