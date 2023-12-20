package Sah::Schema::code_from_str;

use strict;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [
    code => {
        summary => 'Coderef from eval\`ed string',
        description => <<'MARKDOWN',

This schema accepts coderef or string which will be eval'ed to coderef. Note
that this means allowing your user to provide arbitrary Perl code for you to
execute! Make sure first and foremost that security-wise this is acceptable in
your case.

By default `eval()` is performed in the `main` namespace and without stricture
or warnings. See the parameterized version <pm:Sah::PSchema::code_from_str> if
you want to customize the `eval()`.

What's the difference between this schema and `str_or_code` (from
<pm:Sah::Schemas::Str>)? Both this schema and `str_or_code` accept string, but
this schema will directly compile any input string while `str_or_code` will only
convert string to code if it is in the form of `sub { ... }`. In other words,
this schema will always produce coderef, while `str_or_code` can produce strings
also.

MARKDOWN

        prefilters => [ ['Code::eval'=>{}] ],

        examples => [
        ],
    },
];

1;
# ABSTRACT: Coderef from string

=for Pod::Coverage ^(.+)$

=head1 SEE ALSO

L<Sah::PSchema::code_from_str> a parameterized version of this schema.

Tangentially related: L<Sah::Schema::re_from_str> which also involves compiling
arbitrary regex from string, albeit with some safety.
