#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';
$DATE = '2003/06/12';

use Cwd;
use File::Spec;
use File::Glob ':glob';
use Test::TestUtil;
use Test;
use Data::Dumper;

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $T $__restore_dir__ @__restore_inc__ $__tests__);

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   $__tests__ = 28;
   plan(tests => $__tests__);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( $0 );
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Add the library of the unit under test (UUT) to @INC
   #
   my $work_dir = cwd();
   ($vol,$dirs) = File::Spec->splitpath( $work_dir, 'nofile');
   my @dirs = File::Spec->splitdir( $dirs );
   while( $dirs[-1] ne 't' ) { 
       chdir File::Spec->updir();
       pop @dirs;
   };
   @__restore_inc__ = @INC;
   unshift @INC, cwd();  # include the current test directory
   chdir File::Spec->updir();
   my $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   unshift @INC, $lib_dir;
   chdir $work_dir;

}

END {

    #########
    # Restore working directory and @INC back to when enter script
    #
    @INC = @__restore_inc__;
    chdir $__restore_dir__;
}

    #######
    # Delete actual results files
    #
    my @actual = bsd_glob( 'actual*.*' );
    unlink @actual;
    my $T = 'Test::TestUtil';

#######
#
# ok: 1 
#
# R:
#
my $loaded;

test( [$loaded = $T->is_package_loaded('File::Basename')], 
    [''], 'is_package_loaded'); 

#######
# 
# ok:  2
#
# R:
# 
skip_rest( verify(
    $loaded, # condition to skip test   
    [$T->load_package( 'File::Basename' )], 
    [''], 'load_package') );  

#######
#
# ok:  3
#
# R:
#
test( [$T->pod_errors( 'File::Basename')], 
      [0], 'Pod_pod_errors'); # expected results);


####
#
# ok: 4
#
# R:
#
test( [$T->fspec2fspec( 'Unix', 'MSWin32', 'Test/TestUtil.pm')], 
      ['Test\\TestUtil.pm'], 'fspec2fspec' );

####
#
# ok: 5
#
# R:
#
test( [$T->os2fspec( 'Unix', ($T->fspec2os( 'Unix', 'Test/TestUtil.pm')))], 
      ['Test/TestUtil.pm'], 'fspec2os os2fspec' );

####
#
# ok: 6
#
# R:
#
test( [$T->os2fspec( 'MSWin32', ($T->fspec2os( 'MSWin32', 'Test\\TestUtil.pm')))], 
      ['Test\\TestUtil.pm'], 'fspec2os os2fspec' );

####
#
# ok: 7
#
# R:
#
test( [$T->pm2require( 'Test::TestUtil')], 
      [$T->fspec2os( 'Unix', 'Test/TestUtil.pm')],
      'pm2require' );

####
#
# ok: 8
#
# R:
#
my ($file) = $T->pm2file( 'Test::TestUtil');
my $test = 0;
foreach my $path (@INC) {
    if( $file =~ m=^\Q$path\E= ) {
       $test = 1;
       last;
    }   
}
test( [$test], [1], 'pm2file' );

####
#
# ok: 9
#
# R:
#
my @drivers = sort $T->drivers( __FILE__, 'Drivers' );
test( [join (', ', @drivers)], ['Driver, Generate, IO'],  'drivers');

####
#
# ok: 10
#
# R:
#
test( [$T->is_driver('dri', @drivers )], ['Driver'], 'is_driver');

####
#
# ok: 11
#
# R:
#
test( [$T->fspec2pm('Unix', 'Test/TestUtil.pm')], ['Test::TestUtil'], 'fspec2pm');

####
#
# ok: 12
#
# R:
#
unshift @INC,File::Spec->catdir(cwd(),'lib');
my @t_path = $T->find_t_paths( );
test( [$t_path[0]], [File::Spec->catdir(cwd(),'t')], 'find_t_paths');
shift @INC;

####
#
# ok: 13
#
# R:
#
@drivers = sort $T->fspec_glob('Unix','Drivers/G*.pm');
test( [join (', ', @drivers)], 
      [File::Spec->catfile('Drivers', 'Generate.pm')], 'fspec_glob Unix');

####
#
# ok: 14
#
@drivers = sort $T->fspec_glob('MSWin32','Drivers\\I*.pm');
test( [join (', ', @drivers)], 
      [File::Spec->catfile('Drivers', 'IO.pm')],'fspec_glob Unix');

####
#
# ok: 15
#
# R:
#
my $template = << 'EOF';
=head1 Title Page

 Software Version Description

 for

 ${TITLE}

 Revision: ${REVISION}

 Version: ${VERSION}

 Date: ${DATE}

 Prepared for: ${END_USER} 

 Prepared by:  ${AUTHOR}

 Copyright: ${COPYRIGHT}

 Classification: ${CLASSIFICATION}

=cut

EOF

my %variables = (
   TITLE => 'SVDmaker',
   REVISION => '-',
   VERSION => '0.01',
   DATE => '2003/6/10',
   END_USER => 'General Public',
   AUTHOR => 'Software Diamonds',
   COPYRIGHT => 'none',
   CLASSIFICATION => 'none');

$T->replace_variables( \$template, \%variables );

my $expected_template = << 'EOF';
=head1 Title Page

 Software Version Description

 for

 SVDmaker

 Revision: -

 Version: 0.01

 Date: 2003/6/10

 Prepared for: General Public 

 Prepared by:  Software Diamonds

 Copyright: none

 Classification: none

=cut

EOF

test( [$template], [$expected_template], 'replace_variables');

####
#
# ok: 16
#
# R:
#
my @restore_inc = $T->test_lib2inc( );

my ($vol,$dirs) = File::Spec->splitpath( cwd(), 'nofile');
my @dirs = File::Spec->splitdir( $dirs );
pop @dirs; pop @dirs;
shift @dirs unless $dirs[0];
my @expected_lib = ();
$dirs[-1] = 't';
unshift @expected_lib, File::Spec->catdir($vol, @dirs);
$dirs[-1] = 'lib';
unshift @expected_lib, File::Spec->catdir($vol, @dirs);

test( [$INC[0],$INC[1]], [@expected_lib], 'test_lib2inc');

@INC = @restore_inc;

####
#
# ok: 17
#
# R:
#
my $date = $T->get_date();
test( [$date =~ m=2\d\d\d/\d\d/\d\d=], ['1'], 'get_date' );

####
#
# ok: 18
#
# R:
#
my $fh = $T->pm2datah('Test::TestUtil::Drivers::Driver');
my $actual_datah = join '',<$fh>;
$actual_datah =~ s/^\s*(.*)\s*$/$1/gs;

my $expected_datah = << 'EOF';
\=head1 Title Page

 Software Version Description

 for

 ${TITLE}

 Revision: ${REVISION}

 Version: ${VERSION}

 Date: ${DATE}

 Prepared for: ${END_USER} 

 Prepared by:  ${AUTHOR}

 Copyright: ${COPYRIGHT}

 Classification: ${CLASSIFICATION}

\=cut
EOF

$expected_datah =~ s/^\s*(.*)\s*$/$1/gs;

test([$actual_datah], [$expected_datah], 'pm2datah');

####
#
# ok: 19
#
# R:
#
$actual_datah = $T->pm2data('Test::TestUtil::Drivers::Driver');
$actual_datah =~ s/^\s*(.*)\s*$/$1/gs;
test([$actual_datah], [$expected_datah], 'pm2data');

####
#
# ok: 20
#
# R:
#
my $fout_expected = "=head1 Title Page\n\nSoftware Version Description\n\nfor\n\n";
$T->fout( 'test.pm', $fout_expected, {binary => 1} );
my $fout_actual = $T->fin( 'test.pm' );
test([$fout_actual],[$fout_expected],'fin fout' );

####
#
# ok: 21
#
# R:
#
my $fout_dos = "=head1 Title Page\r\n\r\nSoftware Version Description\r\n\r\nfor\r\n\r\n";
$T->fout( 'test.pm', $fout_dos, {binary => 1} );
$fout_actual = $T->fin('test.pm');
test([$fout_actual],[$fout_expected],'fin fout' );


####
#
# ok: 22
#
my $text = 'ok 2 # (E:/User/SoftwareDiamonds/installation/t/Test/STDmaker/tgA1.t at line 123 TODO?!)';
test([$T->scrub_file_line($text)],
     ['ok 2 # (xxxx.t at line 000 TODO?!)'],
     'scrub_file_line' );

####
#
# ok: 23
#
# R:
#
$text = 'Running Tests\n\nE:/User/SoftwareDiamonds/installation/t/Test/STDmaker/tgA1.1..16 todo 2 5;';
test([$T->scrub_test_file($text)],
     ['Running Tests xxx.t 1..16 todo 2 5;'],
     'scrub_test_file' );

####
#
# ok: 24
#
$text = '$VERSION = \'0.01\';\n$DATE = \'2003/06/07\';';
test([$T->scrub_date_version($text)],
     ['$VERSION = \'0.00\';\n$DATE = \'Jan 1, 2000\';'],
     'scrub_date_version' );

####
#
# ok: 25
#
# R:
#
$text = <<'EOF';
Date: Apr 12 00 00 00 2003 +0000
Subject: 20030506, This Week in Health'
X-SDticket: 20030205
X-eudora-date: Feb 6 2000 00 00 2003 +0000
X-SDmailit: dead Feb 5 2000 00 00 2003
Sent email 20030205-20030506 to support.softwarediamonds.com
EOF

my $expected_text = <<'EOF';
Date: Apr 12 00 00 00 2003 +0000
Subject: XXXXXXXXX-X,  This Week in Health'
X-SDticket: XXXXXXXXX-X
X-eudora-date: Apr 12 00 00 00 2003 +0000
X-SDmailit: dead Sat Apr 12 00 00 00 2003 +0000
Sent email XXXXXXXXX-X to support.softwarediamonds.com
EOF

test([$T->scrub_date_ticket($text)],
     [$expected_text],
     'scrub_date_ticket' );

####
#
# ok: 26
#
# R:
#
my @array_table =  (
   [qw(module.pm 0.01 2003/5/6 new)],
   [qw(bin/script.pl 1.04 2003/5/5 generated)],
   [qw(bin/script.pod 3.01 2003/6/8), 'revised 2.03']
);

my $expected_table = << 'EOF';
 file            version date       comment
 --------------- ------- ---------- ---------------
 module.pm       0.01    2003/5/6   new
 bin/script.pl   1.04    2003/5/5   generated
 bin/script.pod  3.01    2003/6/8   revised 2.03
EOF

test([$T->format_array_table(\@array_table, [15,7,10,15],[qw(file version date comment)])],
     [$expected_table],
     'format_array_table' );

####
#
# ok: 27
#
# R:
#
my %hash_table =  (
   'module.pm' => [qw(0.01 2003/5/6 new)],
   'bin/script.pl' => [qw(1.04 2003/5/5 generated)],
   'bin/script.pod' => [qw(3.01 2003/6/8), 'revised 2.03']
);

$expected_table = << 'EOF';
 file            version date       comment
 --------------- ------- ---------- ---------------
 bin/script.pl   1.04    2003/5/5   generated
 bin/script.pod  3.01    2003/6/8   revised 2.03
 module.pm       0.01    2003/5/6   new
EOF

test([$T->format_hash_table(\%hash_table, [15,7,10,15],[qw(file version date comment)])],
     [$expected_table],
     'format_hash_table' );



####
#
# ok: 28
#
# R:
#
($vol,$dirs) = File::Spec->splitpath( cwd(), 'nofile');
@dirs = File::Spec->splitdir( $dirs );
pop @dirs; pop @dirs;
shift @dirs unless $dirs[0];
my $expected_file = File::Spec->catfile($vol, @dirs, 'Test', 'TestUtil', 'TestUtil.t');
my $expected_dir = File::Spec->catdir($vol, @dirs);

test( [$T->find_in_path('Unix', 'Test/TestUtil/TestUtil.t')],
      [$expected_file, $expected_dir],
      'find_in_path' );


#######
# Delete actual results files
#
@actual = bsd_glob( 'actual*.*' );
unlink @actual;

####
# 
# Support:
#
# The ok user caller to look up the stack. If nothing there,
# ok produces a warining. Thus, burying it in a subroutine eliminates
# these warning.
#
sub test { 
   my ($actual_p, $expected_p, $name) = @_;
   print "# $name\n" if $name;
   my $actual = Dumper(@$actual_p);
   my $expected = Dumper(@$expected_p);
   ok($actual, $expected, '');
};

sub verify { 
   my ($mod, $actual_p, $expected_p, $name) = @_;

   print "# $name\n" if $name;
   my $actual = Dumper(@$actual_p);
   my $expected = Dumper(@$expected_p);
   my $test_ok = skip($mod, $actual, $expected, '');
   $test_ok = 1 if $mod;  # make sure do not stop 
   $test_ok

};


sub skip_rest
{
    my ($test_results) = @_;
    unless( $test_results ) {
        for (my $i=2; $i < $__tests__; $i++) { skip(1,0,0) };
        exit 1;
    }
}


__END__


=head1 NAME

tester.t - test script for Test::Tester

=head1 SYNOPSIS

 tester.t 

=head1 COPYRIGHT

copyright © 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http://www.SoftwareDiamonds.com,
PROVIDES THIS SOFTWARE 
'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL SOFTWARE DIAMONDS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL,EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE,DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING USE OF THIS SOFTWARE, EVEN IF
ADVISED OF NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

## end of test script file ##

