#include "ecstrings.h"

#include <stddef.h>
#include <stdint.h>

// https://stackoverflow.com/a/16254679
// https://stackoverflow.com/a/23699777
extern inline const char* ecStringGetEntryByChars (
    const struct ECStringEntry *entries_start,
    size_t                     entries_length,
    const char                 dest_chars[4]
);
extern inline const char* ecStringGetEntryByCode (
    const struct ECStringEntry *entries_start,
    size_t                     entries_length,
    const uint32_t             *dest_code
);

const char* ecStringGetEntry (
    const struct ECStringEntry *entries_start,
    size_t                     entries_length,
    const union ECStringType   *dest_type
) {
    uint32_t                   type_dest;
    uint32_t                   type;
    const struct ECStringEntry *entries_end;
    const struct ECStringEntry *middle;

#ifndef NDEBUG
    if (
        NULL == entries_start || 0 == entries_length
    ) {
        return NULL;
    }
#endif // NDEBUG

    type_dest = dest_type->code;
    type      = entries_start->type.code;

    if (type_dest == type) {
        // hit 'default'
        return entries_start->utf8_value;
    }
    entries_start++;
    entries_length--;

    // else traditional binary search
    entries_end = entries_start + entries_length;

    while (entries_end != entries_start + 1) {
        middle = entries_start + ((entries_end - entries_start) >> 1);
        type   = middle->type.code;
        if (type <= type_dest) {
            entries_start = middle;
        }
        else {
            entries_end = middle;
        }
    }

    type   = entries_start->type.code;
    if (type_dest != type) {
        return NULL;
    }
    else {
        return entries_start->utf8_value;
    }
}
