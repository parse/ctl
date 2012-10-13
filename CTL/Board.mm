#include "Board.h"

namespace {
	inline char* encode(board::Letter c, char *utf8)
	{
		if (c<0x80) {
			*utf8 = c;
			return utf8 + 1;
		} else if (c<0x800) {
			utf8[0] = (c>>6)|0xC0;
			utf8[1] = (c&0x3F)|0x80;
			return utf8 + 2;
		} else if (c<0x10000) {
			utf8[0] = (c>>12)|0xE0;
			utf8[1] = ((c>>6)&0x3F)|0x80;
			utf8[2] = (c&0x3F)|0x80;
			return utf8 + 3;
		} else if (c<0x110000) {
			utf8[0] = (c>>18)|0xf0;
			utf8[1] = ((c>>12)&0x3F)|0x80;
			utf8[2] = ((c>>6)&0x3F)|0x80;
			utf8[3] = (c&0x3F)|0x80;
			return utf8 + 4;
		} else {
			Assert(false, "Cannot encode character");
		}
		return utf8;
	}
	
	inline const char* decode(const char *utf8, board::Letter &codepoint)
	{
		char c = *utf8;
		if ((c&0x80)==0x0) {
			codepoint = c;
			return utf8 + 1;
		} else if ((c&0xE0)==0xC0) {
			unsigned char d = utf8[1];
			Assert((d&0xC0)==0x80, "Archive not utf-8 encoded %s", utf8);
			codepoint = (static_cast<int>(c&0x1F)<<6) | static_cast<int>(d&0x3F);
			return utf8 + 2;
		} else if ((c&0xF0)==0xE0) {
			Assert(false, "Only two-byte unicode codepoints are supported.");
		} else if ((c&0xf8)==0xf0) {
			Assert(false, "Only two-byte unicode codepoints are supported.");
		} else {
			Assert(false, "Archive not utf-8 encoded %s", utf8);
			return utf8;
		}
		
		return NULL;
	}
	
	inline unsigned letter_utf8_length(board::Letter l) {
		char buffer[5];
		return encode(l, &buffer[0]) - &buffer[0];
	}

	inline unsigned word_utf8_length(const board::Letter* word)
	{
		unsigned size = 0;
		for (unsigned i = 0; i != board::NUM_LETTERS; ++i)
			size += letter_utf8_length(word[i]);
		
		return size + 1;
	}
}

namespace board {
	char* letter(Allocator& allocator, const State& state, Player player, unsigned letter) {
		Assert(player < state.num_players, "Player index %d out of range [0, %d]", player, state.num_players);
		Assert(letter < NUM_LETTERS, "Letter index %d out of range [0, %d]", letter, NUM_LETTERS);
		
		Letter l = state.letters[player][letter];
		unsigned length = letter_utf8_length(l);
		char* string = (char*)allocator.allocate(length + 1);
		*encode(l, string) = 0;
		return string;
	}
	
	char* letters(Allocator& allocator, const State& state, Player player) {
		Assert(player < state.num_players, "Player index %d out of range [0, %d]", player, state.num_players);
		
		const Letter* word = state.letters[player];
		unsigned length = word_utf8_length(word);
		char* string = (char*)allocator.allocate(length);
		char* p = string;
		for (unsigned i = 0; i != NUM_LETTERS; ++i)
			p = encode(word[i], p);
		
		*p = 0;
		return string;
	}
	
	void set_letter(State& state, Player player, unsigned letter, const char* utf8) {
		Assert(player < state.num_players, "Player index %d out of range [0, %d]", player, state.num_players);
		Assert(letter < NUM_LETTERS, "Letter index %d out of range [0, %d]", letter, NUM_LETTERS);
		decode(utf8, state.letters[player][letter]);
	}
	
	void set_letters(State& state, Player player,  const char* utf8) {
		Assert(player < state.num_players, "Player index %d out of range [0, %d]", player, state.num_players);
		Letter* word = state.letters[player];
		const char* p = utf8;
		for (unsigned i = 0; *p && i != NUM_LETTERS; ++i)
			p = decode(p, word[i]);
	}
	
	void set_word(State& state, const char* utf8) {
		const char* p = utf8;
		for (unsigned i = 0; *p && i != NUM_LETTERS; ++i)
			p = decode(p, state.word[i]);
	}
	
	char* word(Allocator& allocator, const State& state) {
		unsigned length = word_utf8_length(state.word);
		char* string = (char*)allocator.allocate(length);
		char* p = string;
		for (unsigned i = 0; i != NUM_LETTERS; ++i)
			p = encode(state.word[i], p);
		
		*p = 0;
		return string;
	}
}
