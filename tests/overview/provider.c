#include "provider.h"

#include "ecstrings.h"

// iso369-3
// NOTE: SORT FROM ENDING! CHARACTER SEQUENCES FORM NUMBER IN LITTLE-ENDIAN
static struct ECStringEntry strings[] = {
    // first default
    {{.chars="eng"}, "Hello, world!"},
    // other sorted by language codes (reverse)
    {{.chars="spa"}, "Hola Mundo!"},
    {{.chars="fra"}, "Bonjour monde!"},
    {{.chars="ita"}, "Ciao mondo!"},
    {{.chars="por"}, "Olá Mundo!"},
    {{.chars="rus"}, "Здравствуй, мир!"},
    {{.chars="deu"}, "Hallo Welt!"}
};

void provide_string_set (
    struct ECStringEntry **string_set, size_t *string_set_length
) {
    *string_set = strings;
    *string_set_length = sizeof(strings) / sizeof(*strings);
}
