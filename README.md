# HamsterTime

Upload your time tracking from "Hamster Time Tracker" to "Pivotaltracker" time shifts.

## Installation

    $ git pull
    $ bundle
		$ vim .env
			HAMSTER_DB_PATH: ~/.local/share/hamster-applet/hamster.db
			PIVOTAL_USERNAME: <your username>
			PIVOTAL_PASSWORD: <your password>

## Usage

		$./bin/hamster_time <12.8.2013>

	Categories in Hamster should be the in the same name as projects in Pivotal tracker.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
