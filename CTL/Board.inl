namespace board {
	inline Score score(const State& state, Player player) {
		Assert(player < state.num_players, "Player index %d out of range %d", player, state.num_players);
		return state.scores[player];
	}
	
	inline Flags flags(const State& state, Player player, unsigned letter) {
		Assert(player < state.num_players, "Player index %d out of range [0, %d]", player, state.num_players);
		Assert(letter < NUM_LETTERS, "Letter index %d out of range [0, %d]", letter, NUM_LETTERS);
		return state.flags[player][letter];
	}
	
	inline void set_flags(State& state, Player player, unsigned letter, Flags flags) {
		Assert(player < state.num_players, "Player index %d out of range [0, %d]", player, state.num_players);
		Assert(letter < NUM_LETTERS, "Letter index %d out of range [0, %d]", letter, NUM_LETTERS);
		state.flags[player][letter] |= flags;
	}
	
	inline void remove_flags(State& state, Player player, unsigned letter, Flags flags) {
		Assert(player < state.num_players, "Player index %d out of range [0, %d]", player, state.num_players);
		Assert(letter < NUM_LETTERS, "Letter index %d out of range [0, %d]", letter, NUM_LETTERS);
		state.flags[player][letter] &= ~flags;
	}
	
	inline void set_score(State& state, Player player, Score score) {
		Assert(player < state.num_players, "Player index %d out of range [0, %d]", player, state.num_players);
		state.scores[player] = score;
	}
}
