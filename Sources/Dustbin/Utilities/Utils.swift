import DustbinCore
import Foundation

func ensureUserUID() throws {
    guard let sudoUIDstring = ProcessInfo.processInfo.environment["SUDO_UID"],
          let sudoUID = uid_t(sudoUIDstring)
    else {
        return
    }

    let result = setuid(sudoUID)
    guard result == 0 else {
        throw DustbinError.setUIDFailed
    }
}
