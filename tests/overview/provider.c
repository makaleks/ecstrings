#include "provider.h"

#include "ecstrings.h"

// iso369-3
// NOTE: SORT FROM ENDING! CHARACTER SEQUENCES FORM NUMBER IN LITTLE-ENDIAN
static struct ECStringEntry strings[] = {
    // first default
    {"Hello, world!",    {.chars="eng"}},
    // other sorted by language codes (reverse)
    {"Hola Mundo!",      {.chars="spa"}},
    {"Bonjour monde!",   {.chars="fra"}},
    {"Ciao mondo!",      {.chars="ita"}},
    {"Olá Mundo!",       {.chars="por"}},
    {"Здравствуй, мир!", {.chars="rus"}},
    {"Hallo Welt!",      {.chars="deu"}}
};

void provide_string_set (
    struct ECStringEntry **string_set, size_t *string_set_length
) {
    *string_set = strings;
    *string_set_length = sizeof(strings) / sizeof(*strings);
}
