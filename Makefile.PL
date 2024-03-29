
####
# 
# The module Build::SVDgen generated this file from the contents of
#
# E:\User\SoftwareDiamonds\installation\lib/Docs/Site_SVD/Test_TestUtil.pm 
#
# Don't edit this file, edit instead
#
# E:\User\SoftwareDiamonds\installation\lib/Docs/Site_SVD/Test_TestUtil.pm
#
#	ANY CHANGES MADE HERE WILL BE LOST
#
#       the next time Build::SVDgen generates it.
#
#

use ExtUtils::MakeMaker;

my $tests = join ' ',unix2os('t/Test/TestUtil/TestUtil.t');
my $exe;
if( $exe ) {
  $exe = [join ' ',unix2os($exe)];
}
else {
   $exe = [];
}

WriteMakefile(
    NAME => 'Test::TestUtil',
    DISTNAME => 'Test-TestUtil',
    VERSION  => '0.04',
    dist     => {COMPRESS => 'gzip',
                'gz' => 'gz'},
    test     => {TESTS => $tests},
    PREREQ_PM => {},
    EXE_FILES => $exe,

    ($] >= 5.005 ?     
        (AUTHOR    => 'SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>',
        ABSTRACT  => 'Low level utilities originally developed to support Test::STDmaker', ) : ()),
);



use File::Spec;
use File::Spec::Unix;
sub unix2os
{
   my @file = ();
   foreach my $file (@_) {
       my (undef, $dir, $file_unix) = File::Spec::Unix->splitpath( $file );
       my @dir = File::Spec::Unix->splitdir( $dir );
       push @file, File::Spec->catfile( @dir, $file_unix);
   }
   @file;
}

