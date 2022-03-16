package com.example.cinema.telegrambot.dto;

import com.vdurmont.emoji.EmojiParser;
import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum Emojis {
    TICKET(EmojiParser.parseToUnicode(":ticket:")),
    EMAIL(EmojiParser.parseToUnicode(":email:")),
    PASSWORD(EmojiParser.parseToUnicode(":key:")),
    DATE(EmojiParser.parseToUnicode(":date:")),
    CINEMA(EmojiParser.parseToUnicode(":cinema:")),
    MOVIE(EmojiParser.parseToUnicode(":clapper:")),
    TIME(EmojiParser.parseToUnicode(":clock1:")),
    CITY(EmojiParser.parseToUnicode(":city_sunrise:")),
    SEAT(EmojiParser.parseToUnicode(":wheelchair:")),
    PRICE(EmojiParser.parseToUnicode(":dollar:")),
    SUCCESS_MARK(EmojiParser.parseToUnicode(":white_check_mark:")),
    MARK_FAILED(EmojiParser.parseToUnicode(":exclamation:")),
    INFO_MARK(EmojiParser.parseToUnicode(":information_source:"));

    private String emojiName;

    @Override
    public String toString() {
        return emojiName;
    }
}
