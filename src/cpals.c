#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#include <string.h>

// also return true is char is a null byte so we can stop at the end of the
// string
bool alpha_or_null(char c) {
    return c == '\0' || isalpha(c);
}

// seek the next two letters that need to be compared in a palindrome testing
// scheme. lo can be safely incremented until it hits the end of the string,
// but hi must check that it doesn't go past lo (so that it doesn't go past hte
// start of the string. Returns true if the indices haven't passed each other.
bool seek_next(char s[], int *lo, int *hi) {
    while (!alpha_or_null(s[++*lo]));
    while (!alpha_or_null(s[--*hi])) {
        if (*hi <= *lo)
            return false;
    }
    return *lo < *hi;
}

// determine if string is palindrome
bool is_pal(char s[]) {
    int lo = -1; // initialise lo to be out of bounds
    int hi = strlen(s);
    if (!hi)
        return true;
    // continue to contract the indices until either the letters aren't the
    // same or they pass each other
    while (seek_next(s, &lo, &hi)) {
        if (tolower(s[hi]) !=  tolower(s[lo])) {
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
    return 0;
}
