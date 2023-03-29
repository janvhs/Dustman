format:
    @swiftformat .

build-dev:
    swift build --product Dustman

build:
    swift build -c release --product Dustman

run:
    @rm -rf ./delete_me
    @mkdir ./delete_me
    @touch ./delete_me/test.txt
    swift run Dustman put ./delete_me/test.txt

run-release:
    @rm -rf ./delete_me
    @mkdir ./delete_me
    @touch ./delete_me/test.txt
    swift run -c release Dustman put ./delete_me/test.txt

clean:
    swift package clean

delete:
    rm -rf .build
