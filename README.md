# Embedded C Strings

An implentation of embedded strings usage convention, when set of string ids is
known only at runtime.

## Description

When we implement whatever stringset reciever and senders, but do not control,
which stringset is recieved at runtime, we have to use something more complex
than predefined string array indexes. Binary search is required, maybe with an
optional 'default' or 'most frequently used' value. This library provides the
minimal data structure and search function.

The requirement for the caller is to provide all string codes, except the
first, sorted.

## Example

Let's imagine we need shared libraries to provide their names in more than one
language. We cannot control all libraries to provide off spectrum of
translations and we don't want to forbid some translations to be provided.

The idea is to store a sorted array of translations in library, then provide
either an address to this array or the actual string by
[iso639-3 code](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).

Now assume our library's name is 'Hello, world'. Here are some snippents from
`tests/overview/`:

```C
// some provider.c

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
```

```C
// some main()

char   eng[4] = "eng";
char   deu[4] = "deu";
char   rus[4] = "rus";
char   spa[4] = "spa";

struct ECStringEntry *strings = NULL;
size_t               length = 0;

provide_string_set(&strings, &length);

printf("Eng: %s\n", ecStringGetEntryByChars(strings, length, eng));
printf("Deu: %s\n", ecStringGetEntryByChars(strings, length, deu));
printf("Rus: %s\n", ecStringGetEntryByChars(strings, length, rus));
printf("Spa: %s\n", ecStringGetEntryByChars(strings, length, spa));
```
