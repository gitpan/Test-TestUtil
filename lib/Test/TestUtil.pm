#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  Test::TestUtil;

use 5.001;
use strict;
use warnings;
use warnings::register;


use vars qw($VERSION $DATE);
$VERSION = '1.04';
$DATE = '2003/06/12';

use SelfLoader;
use File::Spec;

######
#
# Having trouble with requires in Self Loader
#
#####

my %module = (
      MacOS   => 'Mac',
      MSWin32 => 'Win32',
      os2     => 'OS2',
      VMS     => 'VMS',
      epoc    => 'Epoc');

sub fspec2module
{
    my (undef,$fspec) = @_;
    $module{$fspec} || 'Unix';
}


#####
# Convert between file specifications for different operating systems to a Unix file specification
#
sub fspec2fspec
{
    my (undef, $from_fspec, $to_fspec, $fspec_file, $nofile) = @_;

    return $fspec_file if $from_fspec eq $to_fspec;

    #######
    # Extract the raw @dirs, file
    #
    my $from_module = Test::TestUtil->fspec2module( $from_fspec );
    my $from_package = "File::Spec::$from_module";
    Test::TestUtil->load_package( $from_package);
    my (undef, $fspec_dirs, $file) = $from_package->splitpath( $fspec_file, $nofile); 
    my @dirs = ($fspec_dirs) ? $from_package->splitdir( $fspec_dirs ) : ();

    return $file unless @dirs;  # no directories, file spec same for all os


    #######
    # Contruct the new file specification
    #
    my $to_module = Test::TestUtil->fspec2module( $to_fspec );
    my $to_package = "File::Spec::$to_module";
    Test::TestUtil->load_package( $to_package);
    my @dirs_up;
    foreach my $dir (@dirs) {
       $dir = $to_package->updir() if $dir eq $to_package->updir();
       push @dirs_up, $dir;
    }
    return $to_package->catdir(@dirs_up) if $nofile;
    $to_package->catfile(@dirs_up, $file); # to native operating system file spec

}

######
#
#
sub pm2file
{
   my (undef, $pm) = @_;
   my $require = Test::TestUtil->pm2require( $pm );
   my ($file,$path) = Test::TestUtil->find_in_path($^O, $require);
   ($file,$path)
}

__DATA__


######
#
#
sub pm2datah
{
    my (undef, $pm) = @_;
   
    #####
    #
    # Alternative:
    #    $fh = \*{"${svd_pm}::DATA"}; only works the first time load, thereafter, closed
    #
    # Only works the one time after loading a module. Thereafter it is closed. No rewinds.
    # 
    #
    my ($file) = Test::TestUtil->pm2file( $pm );

    unless( $file ) {
        warn "Cannot find file for $pm\n";
        return undef;
    }

    local($/);
    $/ = "\n__DATA__\n";
    my $fh;
    unless( open $fh, "< $file" ) {
        warn "Cannot open $file\n";
        return undef;
    }    
    my $data =  <$fh>;

    $fh
}



######
# Format hash table
#
sub format_hash_table
{

    my (undef, $h_p, $width_p, $header_p) = @_;

    my @array_table = ();

    my (@keys, $key, $entries_p, @entries, $entry);
    unless (ref($h_p) eq 'HASH') {
        warn "Table to format must be an hash table\n";
        return undef;
    }

    @keys = sort keys %$h_p;
    foreach $key (@keys) {
       $entries_p = $h_p->{$key};
       push @array_table, [$key, @$entries_p];
    }

    Test::TestUtil->format_array_table( \@array_table, $width_p, $header_p );
}



######
# Format an array table.
#
sub format_array_table
{

    my (undef, $a_p, $width_p, $header_p) = @_;

    unless (ref($a_p) eq 'ARRAY') {
        warn "Table to format must be an array table\n";
        return undef;
    }
    
    ######
    # Format the inventory list
    #
    unless (ref($width_p) eq 'ARRAY') {
        warn "Width  must be an array\n";
        return undef;
    }
    my @w = @$width_p;
    my $total=0;
    my (@dash, @header);
    foreach my $w (@w) {
        $total += $w;
        push @dash,'-' x $w;        

    }
    unshift @$a_p,[@dash];
    unshift @$a_p,[@$header_p];
    
    my ($type, $r_p, @r, $r, $r_total, $c, $size);
    my $str = "\n ";
    foreach $r_p (@$a_p) {
        
        unless (ref($r_p) eq 'ARRAY') {
            warn "Rows in table to format must be an arrays\n";
            return undef;
        }

        @r = @$r_p;

        $r_total = 0;     
        foreach $r (@r) {
            $r_total += length( $r);   
        }

        #####
        # Mutlitple of single line
        #
        $type = ($total < $r_total) ? 1 :0;
        if ($type) {
            $str =~ s/(.*?)\s*$/$1/sg; # drop trailing white space
            $str .= "\n ";
        }

        while( $r_total ) {
            for( $c=0; $c < @w; $c++ ) {

                #######
                # Determine amount of row entry to use for column
                # 
                $size = length( $r[$c] );
                $size = ($w[$c] < $size) ? $w[$c] : $size;
                
                ########
                # Add row to column
                #  
                $str .= substr( $r[$c], 0, $size );
                if ($size < length( $r[$c] )) {
                    $r[$c] = substr( $r[$c], $size);
                }
                else {
                    $r[$c] = '';
                    $str .= ' ' x ($w[$c] - $size);
                }
                if($c < (@w - 1)) {
                    $str .= ' ';
                }
                else {
                    $str =~ s/(.*?)\s*$/$1/sg; # drop trailing white space
                    $str .= "\n ";
                }
            }

            $r[$c] = '' unless($c < @w);  # ran out of columns   

            $r_total = 0;     
            foreach $r (@r) {
                $r_total = length( $r);   
            }
        }


        if ($type) {
            $str =~ s/(.*?)\s*$/$1/sg; # drop trailing white space
            $str .= "\n ";
        }
    } 

    ######
    # Clean up table
    #    
    $str =~ s/^\s*(.*)\n\s*$/$1/s;  # drop leading trailing white space
    while( chomp $str ) { };  # single line feed at the end
    $str .= "\n";
    $str = ' ' . $str;
}



#####
#
#
sub os2fspec
{
    my (undef, $fspec, $os_file, $nofile) = @_;
    Test::TestUtil->fspec2fspec($^O, $fspec, $os_file, $nofile);
}

#####
#
#
sub fspec2os
{
    my (undef, $fspec, $fspec_file, $nofile) = @_;
    Test::TestUtil->fspec2fspec( $fspec, $^O, $fspec_file, $nofile);
}


#####
#
#
sub pm2require
{
   my (undef, $pm) = @_;
   $pm .= '.pm';
   my @dirs = split /::/, $pm;
   my $require = File::Spec->catfile( @dirs );

}



#####
#
#
sub test_lib2inc
{
   #######
   # Add the library of the unit under test (UUT) to @INC
   #
   use Cwd;
   my $work_dir = cwd();
   my ($vol,$dirs) = File::Spec->splitpath( $work_dir, 'nofile');
   my @dirs = File::Spec->splitdir( $dirs );
   while( $dirs[-1] ne 't' ) { 
       chdir File::Spec->updir();
       pop @dirs;
   };
   my @inc = @INC;
   my $lib_dir = cwd();
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;  # include the current test directory
   chdir File::Spec->updir();
   $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   unshift @INC, $lib_dir;
   chdir $work_dir if $work_dir;
   @inc;
 
}



######
#
#
sub pm2data
{
    my (undef, $pm) = @_;
    my $fh = Test::TestUtil->pm2datah( $pm );
    my $data = join '', <$fh>;
    close $fh;
    $data;
}


######
#
#
sub is_package_loaded
{
    my (undef, $package) = @_;
   
    $package .= "::";
    defined %$package

}



######
#
#
sub load_package
{
    my (undef, $package) = @_;
    unless ($package) { # have problem if there is no package
        my $error = "The package name is empty. There is no package to load.\n";
        warn( $error );
        return $error;
    }
    if( $package =~ /\-/ ) {
        my $error =  "The - in $package causes problem. Perl thinks - is subtraction when it evals it.\n";
        warn( $error );
        return $error;      
    }
    return '' if Test::TestUtil->is_package_loaded( $package );
    eval "require $package";
    if($@) {
        warn( "Cannot load $package.\n\t$@\n");
        return( $@ );
    }
    unless (Test::TestUtil->is_package_loaded( $package )) {
        my $error = "$package loaded but package vocabulary absent.\n";
        warn( $error );
        return $error;
    }
    ''
}


########
########
#
# Below is an attempt to make the reading and writing text files in the
# test software in a platform independent manner
#
########
########


sub fspec2pm
{
    my (undef, $fspec, $fspec_file) = @_;

    ##########
    # Must be a pm to conver to :: specification
    #
    return $fspec_file unless $fspec_file =~ /\.pm$/; 
    my $module = Test::TestUtil->fspec2module( $fspec );
    my $fspec_package = "File::Spec::$module";
    Test::TestUtil->load_package( $fspec_package);
    
    #####
    # extract the raw @dirs and file from the file spec
    # 
    my (undef, $fspec_dirs, $file) = $fspec_package->splitpath( $fspec_file ); 
    my @dirs = $fspec_package->splitdir( $fspec_dirs );
    pop @dirs unless $dirs[-1]; # sometimes get empty for last directory

    #####
    # Contruct the pm specification
    #
    $file =~ s/\..*?$//g; # drop extension
    $file = join '::', (@dirs,$file);    
    $file
}


####
# slurp in a text file in a platform independent manner
#
sub fin
{
   my (undef, $file, , $options_p) = @_;

   my $fspec = $options_p->{fspec};
   $fspec = 'Unix' unless $fspec;
   $file = Test::TestUtil->fspec2os($fspec, $file );   

   #####
   # slurp in the file contents with no operating system
   # translations
   #
   unless(open IN, "<$file") {
       warn("Cannot open <$file\n");
       return undef;
   }
   binmode IN; # make the test friendly for more platforms
   my $data = join '', <IN>;
   unless(close(IN)) {
       warn( "Cannot close $file\n");
       return undef;
   }
   return $data unless( $data );

   #########
   # No matter what platform generated the data, convert
   # all platform dependent new lines to the new line for
   # the current platform.
   #
   unless($options_p->{binary}) {
       $data =~ s/\015\012|\012\015/\012/g;  # replace LFCR or CRLF with a LF
       $data =~ s/\012|\015/\n/g;   # replace CR or LF with logical \n 
   }
   $data          
}

###
# slurp a file out, current platform text format
#
sub fout
{
   my (undef, $file, $data, $options_p) = @_;

   my $fspec = $options_p->{fspec};
   $fspec = 'Unix' unless $fspec;
   $file = Test::TestUtil->fspec2os($fspec, $file );   

   if($options_p->{append}) {
       unless(open OUT, ">>$file") {
           warn("Cannot open >$file\n");
           return undef;
       }
   }
   else {
       unless(open OUT, ">$file") {
           warn("Cannot open >$file\n");
           return undef;
       }
   }
   binmode OUT if $options_p->{binary};
   my $char_out = print OUT $data;
   unless(close(OUT)) {
       warn( "Cannot close $file\n");
       return undef;
   }
   $char_out; 
}

#####
#
# Check pod for errors
#
sub pod_errors 
{

    my (undef, $module, $output_file) = @_;

    use Pod::Checker;
    my $checker = new Pod::Checker();
    my @module = split '::', $module;

    $module = File::Spec->catfile( @module );
    return undef unless ($module) = Test::TestUtil->find_in_path( $^O, $module . '.pm');

    ## Now check the pod document for errors
    if( $output_file ) {
        $checker->parse_from_file($module, $output_file);
    }
    else {
        open (LOG, '> __null__.log');
        $checker->parse_from_file($module, \*LOG);
        close LOG;
        unlink '__null__.log';
    }

    $checker->num_errors()
}

#######
# Blank out the Verion, Date for comparision
#
#
sub scrub_file_line
{
    my (undef, $text) = @_;

    return $text unless $text;

    ######
    # Blank out version and date for comparasion
    #
    $text =~ s/\(.*?at line \d+/(xxxx.t at line 000/ig;
    $text

}


#######
# Blank out the Verion, Date for comparision
#
#
sub scrub_test_file
{
    my (undef, $text) = @_;

    return $text unless $text;

    ######
    # Blank out version and date for comparasion
    #
    $text =~ s/Running Tests.*?1\.\./Running Tests xxx.t 1../sig;
    $text

}


#######
# Blank out the Verion, Date for comparision
#
#
sub scrub_date_version
{
    my (undef, $text) = @_;

    return $text unless $text;

    ######
    # Blank out version and date for comparasion
    #
    $text =~ s/\$VERSION\s*=\s*['"].*?['"]/\$VERSION = '0.00'/ig;      
    $text =~ s/\$DATE\s*=\s*['"].*?['"]/\$DATE = 'Jan 1, 2000'/ig;
    $text =~ s/DATE:\s+.*?\n/\$DATE: Jan 1, 2000\n/ig;
    $text

}

#####
# Date changes between runs so cannot have
# a static compare file unless you eliminate
# the date. Also the ticket is different
#
sub scrub_date_ticket
{
    my (undef, $email) = @_;

    $email =~ s/Date: .*?\n/Date: Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/Subject: .*?,(.*)\n/Subject: XXXXXXXXX-X, $1\n/ig;

    $email =~ s/X-SDticket:.*?\n/X-SDticket: XXXXXXXXX-X\n/ig;

    $email =~ s/\QFrom ???@???\E .*?\n/From ???@??? Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/X-eudora-date: .*?\n/X-eudora-date: Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/X-SDmailit: sent .*?\n/X-SDmailit: sent Sat Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/X-SDmailit: dead .*?\n/X-SDmailit: dead Sat Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/Sent email \S+ to (.*?)\n/Sent email XXXXXXXXX-X to $1\n/ig;

    open OUT, '> actual.txt';  # use to gen the expected
    print OUT $email;
    close OUT;;
    $email;
}


######
# Date with year first
#
sub get_date
{
   my @d = localtime();
   @d = @d[5,4,3];
   $d[0] += 1900;
   $d[1] += 1;
   sprintf( "%04d/%02d/%02d", @d[0,1,2]);

}




####
# Find test paths
#
sub find_t_paths
{
   #######
   # Add t directories to the search path
   #
   my ($t_dir,@dirs,$vol);
   my @t_path=();
   foreach my $dir (@INC) {
       ($vol,$t_dir) = File::Spec->splitpath( $dir, 'nofile' );
       @dirs = File::Spec->splitdir($t_dir);
       $dirs[-1] = 't';
       $t_dir = File::Spec->catdir( @dirs);
       $t_dir = File::Spec->catpath( $vol, $t_dir, '');
       push @t_path,$t_dir;
   }
   @t_path;
}


####
# Find find
#
sub find_in_path
{
   my (undef, $fspec, $file, $path) = @_;

   $file = Test::TestUtil->fspec2os($fspec, $file);
   $path = \@INC unless( $path );

   ######
   # Find the file in the search path
   #
   (undef, my $dirs, $file) = File::Spec->splitpath( $file ); 
   (@dirs) = File::Spec->splitdir( $dirs );
   foreach my $path_dir (@$path) {
       my $file_abs = File::Spec->catfile( $path_dir, @dirs, $file );  
       if(-f $file_abs) {
          $path_dir =~ s|/|\\|g if $^O eq 'MSWin32';
          return ($file_abs, $path_dir) ;
       }
   }
   return undef;
}


#######
#
# Glob a file specification
#
sub fspec_glob
{
   my (undef, $fspec, @files) = @_;

   use File::Glob ':glob';

   my @glob_files = ();
   foreach my $file (@files) {
       $file = Test::TestUtil->fspec2os( $fspec, $file );
       push @glob_files, bsd_glob( $file );
   }
   @glob_files;
}

#######
# Replace variables in template
#
sub replace_variables
{
    my (undef, $template_p, $hash_p, $variables_p) = @_;

    unless( $variables_p ) {
        my @keys = sort keys %$hash_p;
        $variables_p = \@keys;
    }

    #########
    # Substitute selected content macros
    # 
    my $count = 1;
    while( $count ) {
        $count = 0;
        foreach my $variable (@$variables_p) {
            $count += $$template_p =~ s/([^\\])\$\{$variable\}/${1}$hash_p->{$variable}/g;
        }
    }
    $$template_p =~ s/\\\$/\$/g;  # unescape macro dollar

    1;
}


#####
# Determine the output generator program modules
#
sub drivers
{
   my (undef, $base_file, @dirs ) = @_;

   use Cwd;
   use File::Glob ':glob';

   my $restore_dir = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath(File::Spec->rel2abs($base_file));
   chdir $vol if $vol;
   chdir $dirs if $dirs;
   $dirs = File::Spec->catdir( @dirs );
   chdir $dirs if $dirs;
   my @drivers = bsd_glob( '*.pm' );
   foreach my $driver (@drivers) {
       $driver =~ s/\.pm$//;
   }
   chdir $restore_dir;
   @drivers
}


#####
# Determine if the output type is valid
#
sub is_driver
{
   my (undef, $driver, @drivers) = @_;

   ($driver) = $driver =~ /^\s*(.*)\s*$/; # zap leading, trailing white space
   my $length = length($driver);
   $driver = lc($driver);
   return undef unless( $length );

   my $driver_found = '';
   foreach my $driver_test (@drivers) {
       if( $driver eq  substr(lc($driver_test), 0, $length)) {
           if( $driver_found ) {
               warn "Ambiguous $driver\n";
               return undef;
           }
           $driver_found = $driver_test;
       }
   }
   return $driver_found if $driver_found;
   warn( "Cannot find driver module $driver.\n");
   undef

}



1


__END__

=head1 NAME
  
Test::TestUtil - functions that support Test::STDmaker

=head1 SYNOPSIS

  use Test::TestUtil

  $data          = Test::TestUtil->fin( $file_name )
  $success       = Test::TestUtil->fout($file_name, $data)

  $package       = Test::TestUtil->is_package_loaded($package)
  $error         = Test::TestUtil->load_package($package)
  $errors        = Test::TestUtil->pod_errors($package)

  $scrubbed_text = Test::TestUtil->scrub_date_version($script_text)
  $scrubbed_text = Test::TestUtil->scrub_file_line($script_text)
  $scrubbed_text = Test::TestUtil->scrub_test_file($script_text)
  $scrubbed_text = Test::TestUtil->scrub_date_ticket($script_text)

  $date          = Test::TestUtil->get_date( )

  $table         = Test::TestUtil->format_hash_table(\%hash_p, \@width_p, \@header_p)
  $table         = Test::TestUtil->format_array_table(\@array_p, \@width_p, \@header_p)

  $file          = Test::TestUtil->fspec2fspec($from_fspec, $to_fspec $fspec_file, [$nofile])
  $os_file       = Test::TestUtil->fspec2os($fspec, $file, [$no_file])
  $fspec_file    = Test::TestUtil->os2fspec($fspec, $file, [$no_file])
  $pm_file       = Test::TestUtil->fspec2pm( $fspec, $file )
  $file          = Test::TestUtil->pm2file($pm_file)
  $file          = Test::TestUtil->pm2require($pm_file)

  ($file, $path) = Test::TestUtil->find_in_path($fspec, $file, [\@path])
  @INC           = Test::TestUtil->test_lib2inc()
  @t_path        = Test::TestUtil->find_t_paths()

  $fh            = Test::TestUtil->pm2datah($pm_file)
  $data          = Test::TestUtil->pm2data($pm_file)

  $success       = Test::TestUtil->replace_variables( \$template, \%variable_hash, \@variable)

  @drivers       = Test::TestUtil->drivers($base_file, @dirs)
  $driver        = Test::TestUtil->is_driver($driver, @drivers)

  @globed_files  = Test::TestUtil->fspec_glob($fspec, @files)

=head1 DESCRIPTION

The methods in the C<Test::TestUtil> package are designed to support the
L<C<Test::STDmaker>|Test::STDmaker> and 
the L<C<ExtUtils::SVDmaker>|ExtUtils::SVDmaker> package.
This is the focus and no other focus.
Since C<Test::TestUtil> is a separate package, the methods
may be used elsewhere.
In all likehood, any revisions will maintain backwards compatibility
with previous revisions.
However, support and the performance of the 
L<C<Test::STDmaker>|Test::STDmaker> and 
L<C<ExtUtils::SVDmaker>|ExtUtils::SVDmaker> packages has
priority over backwards compatibility.

The methods in this package are designed to work properly on
different operating systmes.
Different operating systems have different file specifications. 
File structures are basically the same but the notation to identify 
files in a file structure are different from one operating system to
another operating system.

The input variable I<$fspec> tells the methods in this package
the file specification for file names used as input to the methods.
Supported operating system file specifications are as follows:

 MacOS
 MSWin32
 os2
 VMS
 epoc

The variable I<$^O> contains the file specification for the current operating system.

=head2 drivers method

  @drivers = Test::TestUtil->drivers($base_file, @dirs)

Placing driver objects in their own private directory provides
a method to add new drivers without changing the parent object.
The parent object finds all the available drivers by listing
the files in the driver directory using the I<drivers> method.

The driver method takes as its input a I<$base_file>, usually the
parent object, and a list of subdirectories, I<@base>, relative to
the $base. It returns the a list,  I<@drivers>, of I<*.pm> file names 
stripped of the extension I<.pm> in the identified directory.

For example, if the subdirectory I<Drivers> to the file I<__FILE__>
contains the files I<Driver.pm Generate.pm IO.pm>, then

 ==> join ',', sort Test::TestUtil->drivers( __FILE__, 'Drivers' );

 'Driver, Generate, IO'

=head2 fin fout method

  $data = Test::TestUtil->fin( $file_name )
  $success = Test::TestUtil->fout($file_name, $data, \%options)

Different operating systems have different new line sequences. Microsoft uses
\015\012 for text file, \012 for binary files, Macs \015 and Unix 012.  
Perl adapts to the operating system and uses \n as a logical new line.
The \015 is the L<ASCII|http://ascii.computerdiamonds.com> Carraige Return (CR)
character and the \012 is the L<ASCII|http://ascii.computerdiamonds.com> Line
Feed character.

The I<fin> method will translate any CR LF combination into the logical Perl
\n character. Normally I<fout> will use the Perl \n character. 
In other words I<fout> uses the CR LF combination appropriate of the operating
system and file type.
However supplying the option I<{binary => 1}> directs I<fout> to use binary mode and output the
CR LF raw without any translation.

By using the I<fin> and I<fout> methods, text files may be freely exchanged between
operating systems without any other processing. For example,

 ==> my $text = "=head1 Title Page\n\nSoftware Version Description\n\nfor\n\n";
 ==> Test::TestUtil->fout( 'test.pm', $text, {binary => 1} );
 ==> Test::TestUtil->fin( 'test.pm' );

 =head1 Title Page\n\nSoftware Version Description\n\nfor\n\n

 ==> my $text = "=head1 Title Page\r\n\r\nSoftware Version Description\r\n\r\nfor\r\n\r\n";
 ==> Test::TestUtil->fout( 'test.pm', $text, {binary => 1} );
 ==> Test::TestUtil->fin( 'test.pm' );

=head2 find_in_path method

 ($file_absolute, $path) = Test::TestUtil->find_in_path($fspec, $file_relative, [\@path])

The I<find_in_path> method looks for the I<$file_relative> in one of the directories in
the I<@INC> path or else the I<@path> in the order listed.
The file I<$file_relative> may include relative directories.
When I<find_in_path> finds the file, it returns the abolute file I<$file_absolute> and
the directory I<$path> where it found I<$file_relative>.
The input variable I<$fspec> is the file specification for I<$file_relative>.

For example, running on Microsoft windows with I<C:\Perl\Site\t> in the I<@INC> path,
and the file I<Test\TestUtil\TestUtil.t> present

 ==> Test::TestUtil->find_in_path('Unix', 'Test/TestUtil/TestUtil.t')

 C:\Perl\Site\t\Test\TestUtil\TestUtil.t
 C:\Perl\Site\t

=head2 find_t_paths method

This method operates on the assumption that the test files are a subtree to
a directory named I<t> and the I<t> directories are on the same level as
the last directory of each directory tree specified in I<@INC>.
If this assumption is not true, this method most likely will not behave
very well.

The I<find_t_paths> method returns the directory trees in I<@INC> with
the last directory changed to I<t>.

For example, 

 ==> @INC

 myperl/lib
 perl/site/lib
 perl/lib 

 => Test::TestUtil->find_t_paths()

 myperl/t
 perl/site/t
 perl/t 

=head2 format_array_table method

 $formated_table = Test::TestUtil->format_array_table(\@array, \@width, \@header)

The I<format_array_table> method provides a formatted table suitable for inclusion in
a POD. The I<\@array> variable references an array of array references.
Each array reference in the top array is for a row array that
contains the items in column order for the row.
The I<\@width> variable references the width of each column in column order
while the I<\@header> references the table column names in column order. 

For example,

 ==> @array_table 

 ([qw(module.pm 0.01 2003/5/6 new)],
 [qw(bin/script.pl 1.04 2003/5/5 generated)],
 [qw(bin/script.pod 3.01 2003/6/8), 'revised 2.03'])

 Test::TestUtil->format_array_table(\@array_table, [15,7,10,15], [qw(file version date comment)])

 file            version date       comment
 --------------- ------- ---------- ---------------
 module.pm       0.01    2003/5/6   new
 bin/script.pl   1.04    2003/5/5   generated
 bin/script.pod  3.01    2003/6/8   revised 2.03

=head2 format_hash_table method

 $table = Test::TestUtil->format_hash_table(\%hash_p, \@width_p, \@header_p)

The I<format_hash_table> method provides a formatted table suitable for inclusion in
a POD. The I<\%array> variable references a hash of array references.
Each key is the first column of a row and the value for the key references
a row array that contains the items in column order for the rest of the row.
The I<\@width> variable references the width of each column in column order
while the I<\@header> references the table column names in column order. 

For example,

 => %hash_table

 ('module.pm' => [qw(0.01 2003/5/6 new)],
 'bin/script.pl' => [qw(1.04 2003/5/5 generated)],
 'bin/script.pod' => [qw(3.01 2003/6/8), 'revised 2.03'])

 ==> Test::TestUtil->format_hash_table(\%hash_table, [15,7,10,15],[qw(file version date comment)])

 file            version date       comment
 --------------- ------- ---------- ---------------
 bin/script.pl   1.04    2003/5/5   generated
 bin/script.pod  3.01    2003/6/8   revised 2.03
 module.pm       0.01    2003/5/6   new

=head2 fspec_glob method

  @globed_files = Test::TestUtil->fspec_glob($fspec, @files)

The I<fspec_glob> method BSD globs each of the files in I<@files>
where the file specification for each of the files is I<$fspec>.

For example, running under the Microsoft operating system, that contains a
directory I<Drivers> with file I<Generators.pm Driver.pm IO.pm>
under the current directory

 => Test::TestUtil->fspec_glob('Unix','Drivers/G*.pm')

 Drivers\Generate.pm

 => Test::TestUtil->fspec_glob('MSWin32','Drivers\\I*.pm') 

 Drivers\IO.pm

=head2 fspec2fspec method

 $to_file = Test::TestUtil->fspec2fspec($from_fspec, $to_fspec $from_file, $nofile)

THe I<fspec2fspec> method translate the file specification for I<$from_file> from
the I<$from_fspec> to the I<$to_fpsce>. Supplying anything for I<$nofile>, tells
the I<fspec2fspec> method that I<$from_file> is a directory tree; otherwise, it
is a file.

For example,

 => Test::TestUtil->fspec2fspec( 'Unix', 'MSWin32', 'Test/TestUtil.pm') 

 Test\\TestUtil.pm

=head2 fspec2os method

  $os_file = Test::TestUtil->fspec2os($fspec, $file, $no_file)

The I<fspec2os> method translates a file specification, I<$file>, from the
current operating system file specification to the I<$fspec> file specification.
Supplying anything for I<$nofile>, tells
the I<fspec2fspec> method that I<$from_file> is a directory tree; otherwise, it
is a file.

For example, running under the Microsoft operating system:

 ==> Test::TestUtil->fspec2os( 'Unix', 'Test/TestUtil.pm')
 
 Test\\TestUtil.pm

=head2 fspec2pm method

 $pm_file = Test::TestUtil->fspec2pm( $fspec, $file )

The I<fspec2pm> method translates a filespecification I<$file>
in the I<$fspce> format to the Perl module formate.

For example,

 ==> Test::TestUtil->fspec2pm('Unix', 'Test/TestUtil.pm')

 Test::TestUtil

=head2 get_date method

 $date = Test::TestUtil->get_date( )

The I<get_date> method returns the data in yyyy/mm/dd format. 
This is the preferred US Department of Defense (DOD) format
because the dates sort naturally in ascending order.

For example,

 => Test::TestUtil->get_date( )
 1969/02/06

=head2 is_driver method

 $driver = Test::TestUtil->is_driver($driver, @drivers)

The I<is_driver> method determines if I<$driver> is present
in I<@drivers>. The detemination is case insensitive and
only the leading characters are needed.

For example, 

 ==> @drivers

 (Driver
 Generate
 IO)

 ==> Test::TestUtil->is_driver('dri', @drivers )

 Driver

=head2 is_package_loaded method

 $package = Test::TestUtil->is_package_loaded($package)

The I<is_package_loaded> method determines if a package
vocabulary is present.

For example, if I<File::Basename> is not loaded

 ==> Test::TestUtil->is_package_loaded('File::Basename')

 ''

=head2 load_package method

 $error = Test::TestUtil->load_package($package)

The I<load_package> method loads attempts to load a package.
The return is any I<$error> that occurred during the load
attempt. The I<load_package> will check that the package
vocabulary is present. Altough it is a Perl convention,
the package name(s) in a package file do not have to
be the same as the package file name. 
For these few cases, this method will load the packages
in the file, but fail the package vocabulary test.

For example,

 ==> Test::TestUtil->load_package( 'File::Basename' )
 ''

=head2 os2fspec method

 $file = Test::TestUtil->os2fspec($fspec, $os_file, $no_file)

The I<fspec2os> method translates a file specification, I<$file>, from the
current operating system file specification to the I<$fspec> file specification.
Supplying anything for I<$nofile>, tells
the I<fspec2fspec> method that I<$from_file> is a directory tree; otherwise, it
is a file.

For example, running under the Microsoft operating system:

 ==> Test::TestUtil->os2fspec( 'Unix', 'Test\\TestUtil.pm')

 Test/TestUtil.pm

=head2 pm2datah method

 $fh = Test::TestUtil->pm2datah($pm_file)

The I<pm2datah> method will open the I<$pm_file> and
return a handle positioned at the first I<"\n__DATA__\n">
token occuring in the file.
This function is very similar to the I<DATA> file handle
that Perl creates when loading a module file with the
I<__DATA__> token.
The differences is that I<pm2datah> works whether or
not the file module is loaded. 
The method does not close the file handle.
Unlike the I<DATA> file handle, which cannot be reused
after the module data is read the first time,
the I<pm2datah> will always return an opened file handle,
the first time, the second time, any time.

For example,

 ==> my $fh = Test::TestUtil->pm2datah('Test::TestUtil::Drivers::Driver')
 ==> join '',<$fh>;

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

=head2 pm2data method

 $data = Test::TestUtil->pm2data($pm_file)

The I<pm2data> uses the L<I<pm2datah>|Test::TestUtil/pm2datah>
to return all the data in a I<$pm_file> form the I<__DATA__>
token to the end of the file.

For example,

 ==> my $fh = Test::TestUtil->pm2data('Test::TestUtil::Drivers::Driver')

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

=head2 pm2file method

  ($file, $path) = Test::TestUtil->pm2file($pm_file)

The I<pm2file> method returns the absolute file and
the directory in I<@INC> for a the program module
I<$pm_file>.

For example, running on a Microsoft operating system,
if I<Test::TestUtil> is in the I<C:\myperl\t> directory, 
and I<C:\myperl\t> is in the I<@INC> path,

 ==> Test::TestUtil->pm2file( 'Test::TestUtil');

 (C:\myperl\t\Test\TestUtil.pm
 C:\myperl\t)

=head2 pod_errors method

 $errors = Test::TestUtil->pod_errors($package)

The I<pod_errors> uses I<Pod::Checker> to analyze
a package and returns the number of I<$errors>

For example,

 ==> Test::TestUtil->pod_errors( 'File::Basename')

 0

=head2 pm2require

 $file = Test::TestUtil->pm2require($pm_file)

The I<pm2require> method returns the file suitable
for use in a Perl I<require> given the I<$pm_file>
file.

For example, running under Microsoft Windows

 ==> Test::TestUtil->pm2require( 'Test::TestUtil')

 Test\TestUtil.pm

=head2 replace_variables

 $success = Test::TestUtil->replace_variables( \$template, \%variable_hash, \@variable)

For example

 ==> $template
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

 ==> %variables
 (TITLE => 'SVDmaker',
 REVISION => '-',
 VERSION => '0.01',
 DATE => '2003/6/10',
 END_USER => 'General Public',
 AUTHOR => 'Software Diamonds',
 COPYRIGHT => 'none',
 CLASSIFICATION => 'none')

 ==> $Test::TestUtil->replace_variables(\$template, \%variables);

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

=head2 scrub_date_ticket

 $scrubbed_text = Test::TestUtil->scrub_date_ticket($script_text)

When comparing the contents of email messages, 
the date and email ticket should not be used 
in the comparision. 
The I<scrub_date_ticket> method will replace
the date and email ticket with a generic value.
Applying the I<scrub_date_ticket> to the contents
of both files before the comparision will 
eliminate the data and ticket as factors in
the comparision.

For example,

 ==> $text

 Date: Feb 6 00 00 00 1969 +0000
 Subject: 20030506, This Week in Health
 X-SDticket: 20030205
 X-eudora-date: Feb 6 2000 00 00 2003 +0000
 X-SDmailit: dead Feb 5 2000 00 00 2003
 Sent email 20030205 to support.softwarediamonds.com
 
 ==> Test::TestUtil->scrub_date_ticket($text)

 Date: Apr 12 00 00 00 2003 +0000
 Subject: XXXXXXXXX-X,  This Week in Health'
 X-SDticket: XXXXXXXXX-X
 X-eudora-date: Apr 12 00 00 00 2003 +0000
 X-SDmailit: dead Sat Apr 12 00 00 00 2003 +0000
 Sent email XXXXXXXXX-X to support.softwarediamonds.com

=head2 scrub_date_version

 $scrubbed_text = Test::TestUtil->scrub_date_version($script_text)

When comparing the contents of two Perl program modules, 
the date and version should not be used 
in the comparision. 
The I<scrub_date_ticket> method will replace
the date and version with a generic value.
Applying the I<scrub_date_ticket> to the contents
of both files before the comparision will 
eliminate the date and version as factors in
the comparision.

For example,

 ==> $text

 $VERSION = \'0.01\';
 $DATE = \'2003/06/07\';

 ==> Test::TestUtil->scrub_date_version($text)

 $VERSION = '0.00;
 $DATE = 'Jan 1, 2000';

=head2 scrub_file_line

 $scrubbed_text = Test::TestUtil->scrub_file_line($script_text)

When comparing the ouput of I<Test> module
the file and line number should not be used 
in the comparision. 
The I<scrub_file_line> method will replace
the file and line with a generic value.
Applying the I<scrub_file_line> to the contents
of both files before the comparision will 
eliminate the file and line as factors in
the comparision.

For example,

 ==> $text 

 ok 2 # (E:/User/SoftwareDiamonds/installation/t/Test/STDmaker/tgA1.t at line 123 TODO?!)';

 ==> Test::TestUtil->scrub_file_line($text)

 ok 2 # (xxxx.t at line 000 TODO?!)

=head2 scrub_test_file

 $scrubbed_text = Test::TestUtil->scrub_test_file($script_text)

When comparing the ouput of I<Test:Harness> module
the test file should not be used 
in the comparision. 
The I<scrub_test_file> method will replace
the test file with a generic value.
Applying the I<scrub_test_file> to the contents
of both files before the comparision will 
eliminate the test file as a factor in
the comparision.

For example,

 ==>$text

 Running Tests\n\nE:/User/SoftwareDiamonds/installation/t/Test/STDmaker/tgA1.1..16 todo 2 5;

 ==> Test::TestUtil->scrub_test_file($text)

 Running Tests xxx.t 1..16 todo 2 5;

=head2 test_lib2inc method

 @INC = Test::TestUtil->test_lib2inc()

When building a distribution, the test scripts
should test the distribution modules.
The I<test_lib2inc> method assumbe that the
current directory is in the I<t> subtree and
that there is a I<lib> subtree at the same
level with the Unit Under Test (UUT).
If these assumptions are not meet, 
the I<test_lib2inc> method probably will not
behave properly.

In order to find the proper UUT, the
I<test_lib2inc> method will walk up the
tree specifcation until it finds a I<t>
directory and put the I<t> subtree on
a I<lib> subtree at the same level on
the I<@INC> array. 
The I<test_lib2inc> will return the
I<@INC> array value before the <t> and <lib>
subtrees on I<@INC>.
Use  this value to restore I<@INC> after
using the I<test_lib2inc> method.
Another way to restore I<@INC> is to 
shift two items from the top of I<@INC>

For example,

 ==> @INC
  
 (myperl/lib
 perl/site/lib
 perl/lib)
  
 ==> cwd()

 myperl/packages/Test-TestUtil-0.01/t/Test/TestUtil

 ==> my @restore_inc = $T->test_lib2inc( );

 ==> @INC

 (myperl/packages/Test-TestUtil-0.01/lib
 myperl/packages/Test-TestUtil-0.01/t
 myperl/lib
 perl/site/lib
 perl/lib)

=head1 NOTES

=head2 AUTHOR

The holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 BINDING REQUIREMENTS NOTICE

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 LICENSE

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code must retain
the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http::www.softwarediamonds.com,
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

=head1 SEE ALSO

L<Test> L<Testgen/QUALITY> L<testgen_p> L<testgen_t>

=for html
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="COPYRIGHT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

### end of file ###