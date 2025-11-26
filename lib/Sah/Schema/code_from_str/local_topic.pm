package Sah::Schema::code_from_str::local_topic;

use strict;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [
    code => {
        summary => 'Like `code_from_str`, but localize and return `$_`',
        description => <<'MARKDOWN',

This schema is like `code_from_str`, but it adds the following around the code:

    sub {
        package main;
        local $_ = $_;
        $orig_code->();
        return $_;
    }

This allows the specify code to process the topic variable `$_` without side
effect. The wrapper code will return the topic variable so you can get the
result of the processing.

MARKDOWN

        prefilters => [ ['Code::eval_local_topic'=>{}] ],

        examples => [
        ],
    },
];

1;
# ABSTRACT: Like `code_from_str`, but localize and return `$_`

=for Pod::Coverage ^(.+)$

=head1 SEE ALSO

L<Sah::Schema::code_from_str>
