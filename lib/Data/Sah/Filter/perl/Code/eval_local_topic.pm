package Data::Sah::Filter::perl::Code::eval_local_topic;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => q[Eval a string inside 'sub { local $_ = $_; ...; return $_ }' and return a coderef],
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
                "[undef, sub { local \$_=\$_; \$tmp->(); return $_}] "),
            "} else { ", (
                "my \$code = eval qq(package main; sub { local \$_=\$_; \$tmp; return \$_ }); if (\$@) { [\"Error in compiling code: \$@\", \$tmp] } else { [undef, \$code] } ",
                "}"),
        ),
        "}",
    );

    $res;
}

1;
# ABSTRACT: Eval a string inside 'sub { local $_ = $_; ...; return $_ }' and return a coderef

=for Pod::Coverage ^(meta|filter)$

=head1 DESCRIPTION

=cut
