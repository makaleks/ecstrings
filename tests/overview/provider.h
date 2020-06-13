#ifndef PROVIDER_H_INCLUDED
#define PROVIDER_H_INCLUDED 0

#include <stddef.h>

#include "ecstrings.h"

void provide_string_set (
    struct ECStringEntry **string_set, size_t *string_set_length
);

#endif // PROVIDER_H_INCLUDED
