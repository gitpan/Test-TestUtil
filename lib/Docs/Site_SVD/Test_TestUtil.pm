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
$VERSION = '0.04';
$DATE = '2003/06/14';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_TestUtil.pm' => [qw(0.04 2003/06/14), 'revised 0.03'],
    'MANIFEST' => [qw(0.04 2003/06/14), 'generated, replaces 0.03'],
    'Makefile.PL' => [qw(0.04 2003/06/14), 'generated, replaces 0.03'],
    'README' => [qw(0.04 2003/06/14), 'generated, replaces 0.03'],
    'lib/Test/TestUtil.pm' => [qw(1.06 2003/06/14), 'revised 1.05'],
    't/Test/TestUtil/TestUtil.t' => [qw(0.03 2003/06/14), 'revised 0.02'],
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

 Revision: C

 Version: 0.04

 Date: 2003/06/14

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
     Test::Tech
        DataPort::DataFile DataPort::FileType::FormDB
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

This document releases Test::TestUtil version 0.04
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

   http://www.softwarediamonds/packages/Test-TestUtil-0.04
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-TestUtil-0.04


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
 lib/Docs/Site_SVD/Test_TestUtil.pm                           0.04    2003/06/14 revised 0.03
 MANIFEST                                                     0.04    2003/06/14 generated, replaces 0.03
 Makefile.PL                                                  0.04    2003/06/14 generated, replaces 0.03
 README                                                       0.04    2003/06/14 generated, replaces 0.03
 lib/Test/TestUtil.pm                                         1.06    2003/06/14 revised 1.05
 t/Test/TestUtil/TestUtil.t                                   0.03    2003/06/14 revised 0.02
 t/Test/TestUtil/Drivers/Driver.pm                            0.01    2003/06/12 unchanged
 t/Test/TestUtil/Drivers/Generate.pm                          0.01    2003/06/12 unchanged
 t/Test/TestUtil/Drivers/IO.pm                                0.01    2003/06/12 unchanged


=head2 3.3 Changes

The changes from the previous version are as follows:

=over 4

=item our old friend visits again - DOS and UNIX text file incompatibility

This impacts other modules. We have to examine all modules for
this portability defect and correct any found defects.

Correct failure from Josts Smokehouse" <Jost.Krieger+smokeback@ruhr-uni-bochum.de>
and Kingpin <mthurn@carbon> test runs.

On Mr. Smokehouse's run email the got: VAR1 clearly showed extra white space
line that is not present in the expected: VAR1. 
In Mr. Kingpin's run the got: VAR1 and expected: VAR1 look visually the same.
However, the Unix found a difference(s) and failed the test.

For Mr. Smokehouse's run:

PERL_DL_NONLAZY=1 /usr/local/bin/perl "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/Test/TestUtil/TestUtil.t
t/Test/TestUtil/TestUtil....NOK 18# Test 18 got: '$VAR1 = '\\=head1 Title Page


 Software Version Description


 for


 Test::TestUtil - Utilites for Test::STDmaker and ExtUtils::SVDmaker


 Revision: C

[snip]


(t/Test/TestUtil/TestUtil.t at line 565 fail #17)
#    Expected: '$VAR1 = '\\=head1 Title Page


 Software Version Description


 for


 Test::TestUtil - Utilites for Test::STDmaker and ExtUtils::SVDmaker

What we have before, was a totally "failure to communicate." aka Cool Hand Luke. 
VAR1 was empty. Now VAR1 has something. It is not completely dead.
One probable cause is the Unix operating system must be producing two Unix \012 new lines 
for a Microsoft single newline \015\012.
Without being able to examine the test with a debugger, the only way to verify
this is to provide the fix and see if the problem goes away when this great group
of testers try for the fourth time. 

Revised I<fin> method to take a handle, change I<pm2datah> method handle,  I<$fh>, 
to binary by adding a I<binmode $fh> statement, and pass the actual
thru the I<fin> method for test 18.

Use I<fin($fh)> to read in the data for I<pm2data>, test 19 Unit Under Test (UUT),
instead of using the raw file handle.

The I<fin> method takes any \015\012 combination and changes it into the 
logical Perl new line, I<"\n">, for the current operating system.

=item Namespace conflict

Someone is complain that they have uploaded a Test-Tester before my upload
Changed Test-Tester to Test-Tech and submitted a registration for Test-Tech.
This impacts documentation for this module.

=item Setup Unix Portability Test Machine

This development of portable code with the tester on one side of the big pond called
the Atlantic ocean and the developer on the other side could use some improvement.
Need to take one of Crystal's PCs she is not using and put up Free BSD for portability
testing. This way the CPAN version numbers will not be spining so fast.

=back

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

   http://www.softwarediamonds/packages/Test-TestUtil-0.04
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-TestUtil-0.04


=head2 3.6.1 Installation support.

If there are installation problems or questions with the installation
contact

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.6.2 Installation Tests.

Most Perl installation software will run the following test script(s)
as part of the installation:

 t/Test/TestUtil/TestUtil.t

=head2 3.7 Possible problems and known errors

The I<pm2datah> and I<pm2data> methods determines the data section
by searching for the expression /

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
VERSION : 0.04^
REPOSITORY_DIR: packages^
FREEZE: 1^

PREVIOUS_DISTNAME:  ^
PREVIOUS_RELEASE: 0.03^
REVISION: C^
CHANGE2CURRENT:  ^
AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^
ABSTRACT: Low level utilities originally developed to support Test::STDmaker^
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

The changes from the previous version are as follows:

=over 4

=item our old friend visits again - DOS and UNIX text file incompatibility

This impacts other modules. We have to examine all modules for
this portability defect and correct any found defects.

Correct failure from Josts Smokehouse" <Jost.Krieger+smokeback@ruhr-uni-bochum.de>
and Kingpin <mthurn@carbon> test runs.

On Mr. Smokehouse's run email the got: VAR1 clearly showed extra white space
line that is not present in the expected: VAR1. 
In Mr. Kingpin's run the got: VAR1 and expected: VAR1 look visually the same.
However, the Unix found a difference(s) and failed the test.

For Mr. Smokehouse's run:

PERL_DL_NONLAZY=1 /usr/local/bin/perl "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/Test/TestUtil/TestUtil.t
t/Test/TestUtil/TestUtil....NOK 18# Test 18 got: '$VAR1 = '\\=head1 Title Page


 Software Version Description


 for


 ${TITLE}


 Revision: ${REVISION}

[snip]


(t/Test/TestUtil/TestUtil.t at line 565 fail #17)
#    Expected: '$VAR1 = '\\=head1 Title Page


 Software Version Description


 for


 ${TITLE}

What we have before, was a totally "failure to communicate." aka Cool Hand Luke. 
VAR1 was empty. Now VAR1 has something. It is not completely dead.
One probable cause is the Unix operating system must be producing two Unix \012 new lines 
for a Microsoft single newline \015\012.
Without being able to examine the test with a debugger, the only way to verify
this is to provide the fix and see if the problem goes away when this great group
of testers try for the fourth time. 

Revised I<fin> method to take a handle, change I<pm2datah> method handle,  I<$fh>, 
to binary by adding a I<binmode $fh> statement, and pass the actual
thru the I<fin> method for test 18.

Use I<fin($fh)> to read in the data for I<pm2data>, test 19 Unit Under Test (UUT),
instead of using the raw file handle.

The I<fin> method takes any \015\012 combination and changes it into the 
logical Perl new line, I<"\n">, for the current operating system.

=item Namespace conflict

Someone is complain that they have uploaded a Test-Tester before my upload
Changed Test-Tester to Test-Tech and submitted a registration for Test-Tech.
This impacts documentation for this module.

=item Setup Unix Portability Test Machine

This development of portable code with the tester on one side of the big pond called
the Atlantic ocean and the developer on the other side could use some improvement.
Need to take one of Crystal's PCs she is not using and put up Free BSD for portability
testing. This way the CPAN version numbers will not be spining so fast.

=back

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
     Test::Tech
        DataPort::DataFile DataPort::FileType::FormDB
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
The I<pm2datah> and I<pm2data> methods determines the data section
by searching for the expression /^[\012\015]__DATA__$/.
If somehow this sequence appears in the code,
it will cause a failure of these methods.
Thus, when using this function, statments such as the
below (if it is even a valid statement) cannot be used:

 $var = '
 __DATA__
 ';


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


