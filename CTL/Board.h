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
	
	enum { MAX_PLAYERS = 5, NUM_LETTERS = 5 };

	struct State {
		unsigned num_players;
		Score scores[MAX_PLAYERS];
		Letter letters[MAX_PLAYERS][NUM_LETTERS];
	};
	
	char* letter(Allocator& allocator, const State& state, Player player, unsigned letter);
	char* word(Allocator& allocator, const State& state, Player player);
	
	char* set_letter(const State& state, Player player, unsigned letter);
	char* set_word(const State& state, Player player);
	
	inline Score score(const State& state, Player player);
}

#include "Board.inl"
