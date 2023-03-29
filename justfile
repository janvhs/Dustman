format:
    @swiftformat .

build:
    swift build

build-r:
    swift build -c release

run:
    @rm -rf ./delete_me
    @mkdir ./delete_me
    @touch ./delete_me/test.txt
    swift run Dustman put ./delete_me/test.txt

run-r:
    @rm -rf ./delete_me
    @mkdir ./delete_me
    @touch ./delete_me/test.txt
    swift run -c release Dustman put ./delete_me/test.txt

clean:
    swift package clean

delete:
    rm -rf .build
