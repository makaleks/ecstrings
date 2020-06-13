#include <stdio.h>

#include "ecstrings.h"
#include "provider.h"

int main () {
    char   eng[4] = "eng";
    char   deu[4] = "deu";
    char   rus[4] = "rus";
    char   spa[4] = "spa";
    char   cym[4] = "cym";

    struct ECStringEntry *strings = NULL;
    size_t               length = 0;

    provide_string_set(&strings, &length);

    printf("Eng: %s\n", ecStringGetEntryByChars(strings, length, eng));
    printf("Deu: %s\n", ecStringGetEntryByChars(strings, length, deu));
    printf("Rus: %s\n", ecStringGetEntryByChars(strings, length, rus));
    printf("Spa: %s\n", ecStringGetEntryByChars(strings, length, spa));
    printf(
        "Cym: %s [expected NULL]\n",
        ecStringGetEntryByChars(strings, length, cym)
    );

    return 0;
}
