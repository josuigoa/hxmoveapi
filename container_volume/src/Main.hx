import psmoveapi.PsMoveApi;

enum State {
	Simon;
	PlayersAsleep;
	PlayersAwake;
	Fail;
}

class Main {
	static var lastTimeStamp = haxe.Timer.stamp();
	static var noInteractionTime:Float = 0;

	static var simonValues:Array<UInt>;
	static var simonValuesIndex:Int = -1;
	static var simonValuesDelayMs:UInt = 1000;

	static var players:Array<Player>;
	static var lastPlayerOn:Player = null;

	static var CURRENT_STATE:State;

	static public function main() {
		
        var currentVersion = PsMoveApi.VERSION_MAJOR << 16 |
                            PsMoveApi.VERSION_MINOR << 8 |
                            PsMoveApi.VERSION_PATCH << 0;
		var inited = PsMoveApi.init(currentVersion);
		if (!inited) {
			trace('PS Move API init failed (wrong version?)');
			return;
		}

		var connectedCount = PsMoveApi.count_connected();
		if (connectedCount == 0) {
			trace('No PsMove controller connected, exiting...');
			Sys.exit(0);
		} else if (connectedCount == 1) {
			trace('If only is one PsMove controller the game will be a bit boring, exiting...');
			Sys.exit(0);
		}

		players = [];
		simonValues = [];
        var move:PsMove;

		for (i in 0...connectedCount) {
			move = PsMoveApi.connect_by_id(i);
			if (move.isNull())
				continue;

			players.push(new Player(move, Std.random(255), Std.random(255), Std.random(255)));
		}

		CURRENT_STATE = Simon;

		haxe.MainLoop.add(update);
	}

	static function fail() {
		trace('fail!');
	}

	static function update() {
		switch CURRENT_STATE {
			case Simon:
				lastPlayerOn = null;
				noInteractionTime = 0;
				simonValuesIndex = -1;
				simonValues.push(Std.random(players.length));
				var p;
				for (value in simonValues) {
					p = players[value];
					p.on();
					Sys.sleep(simonValuesDelayMs);
					p.off();
				}
				CURRENT_STATE = PlayersAsleep;

			case PlayersAsleep:
				simonValuesIndex++;
				lastPlayerOn = null;
				var newTime = haxe.Timer.stamp();
				var elapsedTime = newTime - lastTimeStamp;
				lastTimeStamp = newTime;

				for (p in players) {
					if (p.update()) { // a player has clicked the Move button
						CURRENT_STATE = PlayersAwake;
						return;
					}
				}

				noInteractionTime += elapsedTime;
				if (noInteractionTime > simonValuesDelayMs)
					CURRENT_STATE = Fail;

			case PlayersAwake:
				if (lastPlayerOn == null) {
					var p;
					for (i in 0...players.length) {
						p = players[i];
						if (p.update()) {
							if (i != simonValuesIndex) // is not the right player
								CURRENT_STATE = Fail;
							else if (lastPlayerOn != null) // more than one lights turned on
								CURRENT_STATE = Fail;

							lastPlayerOn = p;
						}
					}
				} else if (!lastPlayerOn.isOn) {
					CURRENT_STATE = PlayersAsleep;
				}

				if (simonValuesIndex > simonValues.length) {
					CURRENT_STATE = Simon;
				}

			case Fail:
				trace('failed!');
		}
	}
}
