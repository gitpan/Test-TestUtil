#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  Docs::Site_SVD::Test_TestUtil;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.03';
$DATE = '2003/06/13';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_TestUtil.pm' => [qw(0.03 2003/06/13), 'revised 0.02'],
    'MANIFEST' => [qw(0.03 2003/06/13), 'generated, replaces 0.02'],
    'Makefile.PL' => [qw(0.03 2003/06/13), 'generated, replaces 0.02'],
    'README' => [qw(0.03 2003/06/13), 'generated, replaces 0.02'],
    'lib/Test/TestUtil.pm' => [qw(1.05 2003/06/13), 'revised 1.04'],
    't/Test/TestUtil/TestUtil.t' => [qw(0.02 2003/06/13), 'revised 0.01'],
    't/Test/TestUtil/Drivers/Driver.pm' => [qw(0.01 2003/06/12), 'unchanged'],
    't/Test/TestUtil/Drivers/Generate.pm' => [qw(0.01 2003/06/12), 'unchanged'],
    't/Test/TestUtil/Drivers/IO.pm' => [qw(0.01 2003/06/12), 'unchanged'],

);

########
# The SVD::SVDmaker module uses the data after the __DATA__ 
# token to automatically generate the this file.
#
# Don't edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time SVD::SVDmaker generates this file.
#
#



=head1 Title Page

 Software Version Description

 for

 Test::TestUtil - Utilites for Test::STDmaker and ExtUtils::SVDmaker

 Revision: B

 Version: 0.03

 Date: 2003/06/13

 Prepared for: General Public 

 Prepared by:  SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>

 Copyright: copyright © 2003 Software Diamonds

 Classification: NONE

=head1 1.0 SCOPE

This paragraph identifies and provides an overview
of the released files.

=head2 1.1 Indentification

This release is a collection of Perl modules that
extend the capabilities of the Perl language.

=head2 1.2 System overview

The system is the Perl programming language software.
The system does not have any hardware.
The Perl programming language contains two features that
are utilized by this release:

=over 4

=item 1

Program Modules to extend the languages

=item 2

Plain Old Documentation (POD) that may be embedded in the language

=back

These features are established by the referenced documents.

This release adds low level utilites used initially in support
of Test::STDmaker and ExtUtils::SVDmaker but may have uses in other modules.

The dependency of the program modules in the Test::STDmaker ExtUtils::SVDmaker
US DOD STD2167A bundle is as follows:

 Test::TestUtil
     Test::Tester
        DataPort::FormDB
            Test::STDmaker ExtUtils::SVDmaker

Test software should be short and not depend on any other
modules. In other words, it should use just the basic
core pure Perl and as little of the extension modules as possible.
As such these utilities are a collection of very short
methods, using core pure Perl and very few program modules
(SelfLoader and use File::Spec) 
of seemingly functionally unrelated methods.

Some of the capabilities they provide are as follows:

=over 4

=item *

Methods to change file specifications from
one operating system to another.

=item *

Methods that address the issue of different
new line sequences for different operating systems

=item *

Formatting raw array tables for inclusion in PODS

=item *

Picking up data from program modules

=item *

Loading program modules using an I<eval> and testing
that the program module vocabulary is present.

=back

=head2 1.3 Document overview.

This document releases Test::TestUtil version 0.03
providing a description of the inventory, installation
instructions and other information necessary to
utilize and track this release.

=head1 3.0 VERSION DESCRIPTION

All file specifications in this SVD
use the Unix operating
system file specification.

=head2 3.1 Inventory of materials released.

=head2 3.1.1 Files.

This document releases the file found
at the following repository:

   http://www.softwarediamonds/packages/Test-TestUtil-0.03
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-TestUtil-0.03


=head2 3.1.2 Copyright.

copyright © 2003 Software Diamonds

=head2 3.1.3 Copyright holder contact.

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.1.4 License.

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

=head2 3.2 Inventory of software contents

The content of the released, compressed, archieve file,
consists of the following files:

 file                                                         version date       comment
 ------------------------------------------------------------ ------- ---------- ------------------------
 lib/Docs/Site_SVD/Test_TestUtil.pm                           0.03    2003/06/13 revised 0.02
 MANIFEST                                                     0.03    2003/06/13 generated, replaces 0.02
 Makefile.PL                                                  0.03    2003/06/13 generated, replaces 0.02
 README                                                       0.03    2003/06/13 generated, replaces 0.02
 lib/Test/TestUtil.pm                                         1.05    2003/06/13 revised 1.04
 t/Test/TestUtil/TestUtil.t                                   0.02    2003/06/13 revised 0.01
 t/Test/TestUtil/Drivers/Driver.pm                            0.01    2003/06/12 unchanged
 t/Test/TestUtil/Drivers/Generate.pm                          0.01    2003/06/12 unchanged
 t/Test/TestUtil/Drivers/IO.pm                                0.01    2003/06/12 unchanged


=head2 3.3 Changes

Correct failure from Josts Smokehouse" <Jost.Krieger+smokeback@ruhr-uni-bochum.de>
test run

PERL_DL_NONLAZY=1 /usr/local/perl/bin/perl "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/Test/TestUtil/TestUtil.t
t/Test/TestUtil/TestUtil....# Test 18 got: '$VAR1 = '';
' (t/Test/TestUtil/TestUtil.t at line 540 fail #17)
#    Expected: '$VAR1 = '\\=head1 Title Page

The I<pm2datah> method is not returning any data for Test 18. This will also cause
the test of I<pm2data>, test 19 to fail.
The I<pm2datah> is searching for the string "\n__DATA__\n".

The "\n" character on Perl is a logical end of line character sequence.
The "\n" end of line is different on Mr. Smokehouse's Unix operating system
than on my Windows NT operating system.
The test file was created under MSWin32 and uses a MSWin32 "\n".
Under UNIX, I<pm2datah> method will look for the Unix "\n"
and there will not be any.

Changed "\n__DATA__\n" to /[\012\015]__DATA__/. 

During the clean-up for CPAN, broke the I<format_hash_table>
method for tables in hash of hash format. 
Fixed the break, added test 29 to the I<t/Test/TestUtil/TestUtil.t>
test script for this
feature, and added a discusssion of this feature in
POD discription for I<format_hash_table>

=head2 3.4 Adaptation data.

This installation requires that the installation site
has the Perl programming language installed.
Installation sites running Microsoft Operating systems require
the installation of Unix utilities. 
An excellent, highly recommended Unix utilities for Microsoft
operating systems is unxutils by Karl M. Syring.
A copy is available at the following web sites:

 http://unxutils.sourceforge.net
 http://packages.SoftwareDiamnds.com

There are no other additional requirements or tailoring needed of 
configurations files, adaptation data or other software needed for this
installation particular to any installation site.

=head2 3.5 Related documents.

There are no related documents needed for the installation and
test of this release.

=head2 3.6 Installation instructions.

To installed the release file, use the CPAN module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

The distribution file is at the following respositories:

   http://www.softwarediamonds/packages/Test-TestUtil-0.03
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-TestUtil-0.03


=head2 3.6.1 Installation support.

If there are installation problems or questions with the installation
contact

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.6.2 Installation Tests.

Most Perl installation software will run the following test script(s)
as part of the installation:

 t/Test/TestUtil/TestUtil.t

=head2 3.7 Possible problems and known errors

The I<pm2datah> method determines the data section
by searching for the token /[\012\015]__DATA__/.
Currently the I<pm2datah> test only tests for
"\n__DATA__" for the current operating system.
The test should be for all operating systems,
not just the current one.

The Test::TestUtil program module is the foundation
program module for testing
and must be rock solid to ensure the quality of
the Units that it will be testing.
Testing of this module should be proactive and
not dumped upon the end-user.

There is still much work needed to ensure the quality 
of this module as follows:

=over 4

=item *

State the functional requirements for each method 
including not only the GO paths but also what to
expect for the NOGO paths

=item *

All the tests are GO path tests. Should add
NOGO tests.

=item *

Add the requirements addressed as I<# R: >
comment to the tests

=item *

Write a program to build a matrix to trace
test step to the requirements and vice versa by
parsing the I<# R: > comments.
Automatically insert the matrix in the
Test::TestUtil POD.

=back

=head1 4.0 NOTES

The following are useful acronyms:

=over 4

=item .d

extension for a Perl demo script file

=item .pm

extension for a Perl Library Module

=item .t

extension for a Perl test script file

=item DID

Data Item Description

=item POD

Plain Old Documentation

=item STD

Software Test Description

=item SVD

Software Version Description

=back

=head1 2.0 SEE ALSO

 L<US DOD SVD|Docs::US_DOD::SVD>
 L<Test::TestUtil|Test::TestUtil>

=for html
<hr>
<p><br>
<!-- BLK ID="PROJECT_MANAGEMENT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

1;

__DATA__



DISTNAME: Test-TestUtil^
VERSION : 0.03^
REPOSITORY_DIR: packages^
FREEZE: 1^

PREVIOUS_DISTNAME:  ^
PREVIOUS_RELEASE: 0.02^
CHANGE2CURRENT:  ^
AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^
ABSTRACT: Low level utilities originally developed to support Test::STDmaker^
REVISION: B^
TITLE   : Test::TestUtil - Utilites for Test::STDmaker and ExtUtils::SVDmaker^
END_USER: General Public^
COPYRIGHT: copyright © 2003 Software Diamonds^
CLASSIFICATION: NONE^
TEMPLATE:  ^
CSS: help.css^
SVD_FSPEC: Unix^

REPOSITORY: 
  http://www.softwarediamonds/packages/
  http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/
^

COMPRESS: gzip^
COMPRESS_SUFFIX: gz^

RESTRUCTURE:  ^

AUTO_REVISE: 
lib/Test/TestUtil.pm
t/Test/TestUtil/TestUtil.t
t/Test/TestUtil/Drivers/*
^

PREREQ_PM:  ^

TESTS: t/Test/TestUtil/TestUtil.t^

EXE_FILES:  ^

CHANGES:

Correct failure from Josts Smokehouse" <Jost.Krieger+smokeback@ruhr-uni-bochum.de>
test run

PERL_DL_NONLAZY=1 /usr/local/perl/bin/perl "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/Test/TestUtil/TestUtil.t
t/Test/TestUtil/TestUtil....# Test 18 got: '$VAR1 = '';
' (t/Test/TestUtil/TestUtil.t at line 540 fail #17)
#    Expected: '$VAR1 = '\\=head1 Title Page

The I<pm2datah> method is not returning any data for Test 18. This will also cause
the test of I<pm2data>, test 19 to fail.
The I<pm2datah> is searching for the string "\n__DATA__\n".

The "\n" character on Perl is a logical end of line character sequence.
The "\n" end of line is different on Mr. Smokehouse's Unix operating system
than on my Windows NT operating system.
The test file was created under MSWin32 and uses a MSWin32 "\n".
Under UNIX, I<pm2datah> method will look for the Unix "\n"
and there will not be any.

Changed "\n__DATA__\n" to /[\012\015]__DATA__/. 

During the clean-up for CPAN, broke the I<format_hash_table>
method for tables in hash of hash format. 
Fixed the break, added test 29 to the I<t/Test/TestUtil/TestUtil.t>
test script for this
feature, and added a discusssion of this feature in
POD discription for I<format_hash_table>
^

DOCUMENT_OVERVIEW:
This document releases ${NAME} version ${VERSION}
providing a description of the inventory, installation
instructions and other information necessary to
utilize and track this release.
^

CAPABILITIES:
This release adds low level utilites used initially in support
of Test::STDmaker and ExtUtils::SVDmaker but may have uses in other modules.

The dependency of the program modules in the Test::STDmaker ExtUtils::SVDmaker
US DOD STD2167A bundle is as follows:

 Test::TestUtil
     Test::Tester
        DataPort::FormDB
            Test::STDmaker ExtUtils::SVDmaker

Test software should be short and not depend on any other
modules. In other words, it should use just the basic
core pure Perl and as little of the extension modules as possible.
As such these utilities are a collection of very short
methods, using core pure Perl and very few program modules
(SelfLoader and use File::Spec) 
of seemingly functionally unrelated methods.

Some of the capabilities they provide are as follows:

\=over 4

\=item *

Methods to change file specifications from
one operating system to another.

\=item *

Methods that address the issue of different
new line sequences for different operating systems

\=item *

Formatting raw array tables for inclusion in PODS

\=item *

Picking up data from program modules

\=item *

Loading program modules using an I<eval> and testing
that the program module vocabulary is present.

\=back
^

PROBLEMS:

The I<pm2datah> method determines the data section
by searching for the token /[\012\015]__DATA__/.
Currently the I<pm2datah> test only tests for
"\n__DATA__" for the current operating system.
The test should be for all operating systems,
not just the current one.

The Test::TestUtil program module is the foundation
program module for testing
and must be rock solid to ensure the quality of
the Units that it will be testing.
Testing of this module should be proactive and
not dumped upon the end-user.

There is still much work needed to ensure the quality 
of this module as follows:

\=over 4

\=item *

State the functional requirements for each method 
including not only the GO paths but also what to
expect for the NOGO paths

\=item *

All the tests are GO path tests. Should add
NOGO tests.

\=item *

Add the requirements addressed as I<# R: >
comment to the tests

\=item *

Write a program to build a matrix to trace
test step to the requirements and vice versa by
parsing the I<# R: > comments.
Automatically insert the matrix in the
Test::TestUtil POD.

\=back

^

LICENSE:
Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

\=over 4

\=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

\=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

\=back

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
^


INSTALLATION:
To installed the release file, use the CPAN module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

The distribution file is at the following respositories:

${REPOSITORY}
^

SUPPORT: 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>^

NOTES:
The following are useful acronyms:

\=over 4

\=item .d

extension for a Perl demo script file

\=item .pm

extension for a Perl Library Module

\=item .t

extension for a Perl test script file

\=item DID

Data Item Description

\=item POD

Plain Old Documentation

\=item STD

Software Test Description

\=item SVD

Software Version Description

\=back
^

SEE_ALSO:
 L<US DOD SVD|Docs::US_DOD::SVD>
 L<Test::TestUtil|Test::TestUtil>
^

HTML:
<hr>
<p><br>
<!-- BLK ID="PROJECT_MANAGEMENT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>
^
~-~


