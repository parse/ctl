namespace board {
	inline Score score(const State& state, Player player) {
		Assert(player < state.num_players, "Player index %d out of range %d", player, state.num_players);
		return state.scores[player];
	}
}
