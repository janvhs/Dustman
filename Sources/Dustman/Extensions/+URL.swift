import Foundation

extension URL {
    func absolutePath() -> String {
        let filePath: String

        // TODO: Find the support matrix for this.
        #if os(macOS)
            if #available(OSX 13.0, *) {
                filePath = absoluteURL.path()
            } else {
                filePath = absoluteURL.path
            }
        #else
            filePath = absoluteURL.path
        #endif

        return filePath
    }
}
