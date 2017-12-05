#include <stdio.h>
#include <stdbool.h>

// get lowercase character by bitmasking
char lower(char c) {
    return c & (0xff - 32);
}

// check if a character is a "letter", letter including \0. This is because we
// want the `lo` index to stop at the end of the string.
bool is_letter(char c) {
    char norm = lower(c);
    return c == '\0' || ('A' <= norm && norm <= 'Z');
}

// seek the next two letters that need to be compared in a palindrome testing
// scheme. lo can be safely incremented until it hits the end of the string,
// but hi must check that it doesn't go past lo (so that it doesn't go past hte
// start of the string. Returns true if the indices haven't passed each other.
bool seek_next(char s[], int *lo, int *hi) {
    while (!is_letter(s[++*lo]));
    while (!is_letter(s[--*hi])) {
        if (*hi <= *lo)
            return false;
    }
    return *lo < *hi;
}

// determine if string is palindrome
bool is_pal(char s[]) {
    int lo = -1; // initialise lo to be out of bounds
    // hi seeks the end of the string:
    int hi = -1; 
    while (s[++hi] != '\0');
    // continue to contract the indices until either the letters aren't the
    // same or they pass each other
    while (seek_next(s, &lo, &hi)) {
        if (lower(s[hi] - s[lo])) {
            return false;
        }
    }
    return true;
}

int main(int argc, char **argv) {
    for (int i = 1; i < argc; i++) {
        printf("\"%s\": palindromity %s\n",
                    argv[i],
                    is_pal(argv[i]) ? "true" : "false");
    }
}
