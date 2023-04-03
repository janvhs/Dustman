import Foundation

// INFO: This will prevent the recycling of protected files,
//       but it will also ensue the file will not end up in a
//       place where it can be deleted completely.
func ensureUserUID() throws {
    guard let sudoUID = getSudoUid() else {
        return
    }

    let result = setuid(sudoUID)
    guard result == 0 else {
        throw DustbinError.setUIDFailed
    }
}

func getSudoUid() -> UInt32? {
    let sudoUid = ProcessInfo.processInfo.environment["SUDO_UID"]
    if let sudoUid {
        return UInt32(sudoUid)
    } else {
        return nil
    }
}
