#ifndef EMBEDDED_C_STRINGS_H_INCLUDED
#define EMBEDDED_C_STRINGS_H_INCLUDED 0

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#include <stddef.h>
#include <stdint.h>

union ECStringType {
    uint32_t code;
    char     chars[4];
};

struct ECStringEntry {
    char               *utf8_value;
    union ECStringType type;
};

char* ecStringGetEntry (
    struct ECStringEntry *entries_start,
    size_t               entries_length,
    union ECStringType   *dest_type
);

inline char* ecStringGetEntryByCode (
    struct ECStringEntry *entries_start,
    size_t               entries_length,
    uint32_t             *dest_code
) {
    return ecStringGetEntry(
        entries_start, entries_length, (union ECStringType*)dest_code
    );
}
inline char* ecStringGetEntryByChars (
    struct ECStringEntry *entries_start,
    size_t               entries_length,
    char                 dest_chars[4]
) {
    return ecStringGetEntry(
        entries_start, entries_length, (union ECStringType*)dest_chars
    );
}

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // EMBEDDED_C_STRINGS_H_INCLUDED
