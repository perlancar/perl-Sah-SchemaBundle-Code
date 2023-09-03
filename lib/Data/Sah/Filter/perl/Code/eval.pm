package Data::Sah::Filter::perl::Code::eval;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => "Eval a string inside 'sub { ... }' and return a coderef",
        might_fail => 1,
        args => {
            # XXX use strict?
            # XXX use warnings?
            # XXX namespace?
        },
    };
}

sub filter {
    my %fargs = @_;

    my $dt = $fargs{data_term};
    my $gen_args = $fargs{args} // {};

    my $res = {};
    $res->{expr_filter} = join(
        "",
        "do {", (
            "my \$tmp = $dt; ",
            "if (ref \$tmp eq 'CODE') { ", (
                "[undef, \$tmp] "),
            "} else { ", (
                "my \$code = eval qq(package main; sub { \$tmp }); if (\$@) { [\"Error in compiling code: \$@\", \$tmp] } else { [undef, \$code] } ",
                "}"),
        ),
        "}",
    );

    $res;
}

1;
# ABSTRACT: Convert string to regex if string is delimited by /.../ or qr(...)

=for Pod::Coverage ^(meta|filter)$

=head1 DESCRIPTION

Currently for the C<qr(...)> form, unlike in normal Perl, only parentheses C<(>
and C<)> are allowed as the delimiter.

Currently regex modifiers C<i>, C<m>, and C<s> are allowed at the end.
