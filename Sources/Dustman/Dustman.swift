import ArgumentParser

@main
public struct Dustman: ParsableCommand {
    public init() {}

    public static var configuration = CommandConfiguration(
        abstract: "Move files to the trash.",
        subcommands: [
            Put.self,
        ],
        defaultSubcommand: Put.self
    )
}
