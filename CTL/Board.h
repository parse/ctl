#pragma once

#import "Assert.h"

namespace board {
	class Allocator {
	public:
		virtual void* allocate(size_t size) = 0;
		virtual void deallocate(void* p) = 0;
	};
	
	/// Supports temp allocations in a 128byte static buffer, released on destroy.
	class TempAllocator128 : public Allocator {
	public:
		TempAllocator128() : _p(0), _data(0) {
			_data = (char*)malloc(128);
		}
		
		~TempAllocator128() {
			free(_data);
		}
		
		void* allocate(size_t size) {
			Assert(_p + size < 128, "Temp allocator full on allocate(%d)", size);
			return &_data[_p += size];
		}
		
		void deallocate(void* p) { }
		
	private:
		char* _data;
		unsigned _p;
	};
	
	typedef unsigned short Letter;
	typedef unsigned Score;
	typedef unsigned Player;
	typedef unsigned char Flags;
	
	enum { NO_LETTER = 0, MAX_PLAYERS = 5, NUM_LETTERS = 5, WORD_SIZE = 10 };
	
	enum {
		SELECTED = 1 << 0,			///< Selected letter state.
		USER_FLAG_START_BIT = 1 << 1	///< User flag start bit.
	};

	#pragma pack(push, 2)
	struct State {
		unsigned short num_players;				///< Number of players in the board. In [1, MAX_PLAYERS].
		unsigned short current_player;				///< The index of the current turns player. In [1, MAX_PLAYERS].
		Score scores[MAX_PLAYERS];					///< Scores for all players.
		Letter word[WORD_SIZE];					///< The boards active word.
		Letter letters[MAX_PLAYERS][NUM_LETTERS];	///< The pseudo-randomized letters available to build the active word from.
		Flags flags[MAX_PLAYERS][NUM_LETTERS];		///< 8-bit flags for each letter in the board.
	};
	#pragma pack(pop)
	
	/// Sets the player at index @p player's letter at index @p letter to the single utf-8 character in @p to.
	void set_letter(State& state, Player player, unsigned letter, const char* to);
	
	/// Sets the player at index @p players letters to @p to.
	void set_letters(State& state, Player player, const char* to);
	
	/// Returns an UTF-8 string containing the letter at index @p letter of player @p player, allocated by @allocator.
	char* letter(Allocator& allocator, const State& state, Player player, unsigned letter);
	
	/// Returns an UTF-8 string containing the all letters of player @p player, allocated by @allocator.
	char* letters(Allocator& allocator, const State& state, Player player);

	/// Returns an UTF-8 string with the current word.
	char* word(Allocator& allocator, const State& state);
	
	/// Set the current word to @p to.
	void set_word(State& state, const char* word);
	
	/// Returns an UTF-8 string with a the letter at index @p letter of the current word.
	char* word_letter(Allocator& allocator, const State& state, unsigned letter);
	
	/// Sets the letter at index @p letter of the current word to @p to.
	void set_word_letter(State& state, unsigned letter, const char* to);
	
	/// Returns the number of letters in the current word.
	unsigned num_word_letters(const State& state);
	
	/// Clears the current word.
	void clear_word(State& state);
	
	/// Sets the score of the player at index @player to @p score.
	inline void set_score(State& state, Player player, Score score);
	
	/// Returns the score of the player at index @p player.
	inline Score score(const State& state, Player player);
	
	/// Sets the flags @p flags to the player at index @p player and letter at index @letter.
	inline void set_flags(State& state, Player player, unsigned letter, Flags flags);
	
	/// Removes the flags @p flags from the player at index @p player and letter at index @letter.
	inline void remove_flags(State& state, Player player, unsigned letter, Flags flags);
	
	/// Returns the flags of the player at index @p player and letter at index @letter.
	inline Flags flags(const State& state, Player player, unsigned letter);
	
	/// @{ @name Conveinience methods
		/// Returns the selected state of the player at index @p player and letter at index @p letter.
		inline bool is_selected(State& state, Player player, unsigned letter) {
			return (flags(state, player, letter) & SELECTED) > 0;
		}

		/// Sets the selected state of the player at index @p player and letter at index @p letter to @selected.
		inline void set_selected(State& state, Player player, unsigned letter, bool selected) {
			if (selected)
				set_flags(state, player, letter, SELECTED);
			else
				remove_flags(state, player, letter, SELECTED);
		}
	
		/// Clear all selected state
		inline void clear_selected(State& state) {
			for (unsigned p = 0; p != state.num_players; ++p) {
				for (unsigned l = 0; l != NUM_LETTERS; ++l)
					set_selected(state, p, l, false);
			}
		}
	/// @}
}

#include "Board.inl"
