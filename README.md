# HamsterTime

Upload your time tracking from "Hamster Time Tracker" to "Pivotal Tracker" time shifts.

## Installation

    $ git pull https://github.com/gacha/hamster_time.git
    $ cd hamster_time
    $ bundle

Add file `.env` with configuration

    HAMSTER_DB_PATH: ~/.local/share/hamster-applet/hamster.db
    PIVOTAL_USERNAME: <your username>
    PIVOTAL_PASSWORD: <your password>

Patch hamster DB, add `synced` field:

    $ ./bin/migrate

## Usage
Run with specific date or it will publish yesterday's work.

    $ ./bin/hamster_time <12.8.2013>

## Notes

Categories in Hamster should be the in the same name as projects in Pivotal tracker.

## License

Available for use under the [MIT License](/LICENSE.txt)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
