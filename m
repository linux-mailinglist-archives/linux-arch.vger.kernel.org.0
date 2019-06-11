Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07F03CCE5
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2019 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfFKN1H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jun 2019 09:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfFKN1H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 09:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10EA681DE1;
        Tue, 11 Jun 2019 13:26:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-126.rdu2.redhat.com [10.10.120.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4993426FAD;
        Tue, 11 Jun 2019 13:26:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH] Add script to add/remove/rename/renumber syscalls and
 resolve conflicts
From:   David Howells <dhowells@redhat.com>
To:     arnd@arndb.de
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        sfr@canb.auug.org.au, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Jun 2019 14:26:54 +0100
Message-ID: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 11 Jun 2019 13:27:07 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a script that simplifies the process of altering system call tables in
the kernel sources.  It has five functions available:

 (1) Add a system call or compat system call:

	./scripts/syscall-manage.pl --add <name> [--compat]

 (2) Remove a system call:

	./scripts/syscall-manage.pl --rm <name>

 (3) Rename a system call:

	./scripts/syscall-manage.pl --rename <name> <new_name>

 (4) Renumber the system calls from 424 to __NR_syscalls to erase gaps:

	./scripts/syscall-manage.pl --renumber

 (5) Resolve simple git conflicts between two branches that both add system
     calls and renumber the conflicting calls.

	./scripts/syscall-manage.pl --resolve

The script alters the master uapi unistd.h, sys_ni.c and the system call
.tbl files.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/process/adding-syscalls.rst |   53 ++
 scripts/syscall-manage.pl                 |  929 +++++++++++++++++++++++++++++
 2 files changed, 982 insertions(+)
 create mode 100755 scripts/syscall-manage.pl

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 1c3a840d06b9..56515cc6d55f 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -8,6 +8,14 @@ This document describes what's involved in adding a new system call to the
 Linux kernel, over and above the normal submission advice in
 :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
 
+A script is available to alter all the system call tables in one go::
+
+	./scripts/syscall-manage.pl --add <name> [--compat]
+	./scripts/syscall-manage.pl --rm <name>
+	./scripts/syscall-manage.pl --rename <name> <new_name>
+	./scripts/syscall-manage.pl --renumber
+	./scripts/syscall-manage.pl --resolve
+
 
 System Call Alternatives
 ------------------------
@@ -247,6 +255,10 @@ To summarize, you need a commit that includes:
  - generic table entry in ``include/uapi/asm-generic/unistd.h``
  - fallback stub in ``kernel/sys_ni.c``
 
+A system call named xyzzy can be added by::
+
+    ./scripts/syscall-manage.pl --add xyzzy
+
 
 x86 System Call Implementation
 ------------------------------
@@ -352,6 +364,10 @@ To summarize, you need:
  - instance of ``__SC_COMP`` not ``__SYSCALL`` in
    ``include/uapi/asm-generic/unistd.h``
 
+A compatibility system call named xyzzy can be added by::
+
+    ./scripts/syscall-manage.pl --add xyzzy --compat
+
 
 Compatibility System Calls (x86)
 --------------------------------
@@ -491,6 +507,43 @@ The man page should be cc'ed to linux-man@vger.kernel.org
 For more details, see https://www.kernel.org/doc/man-pages/patches.html
 
 
+System Call Management Script
+-----------------------------
+
+A script is available to alter all the system call tables in one go.  It has
+five functions available:
+
+ * Add a new system call, giving it the specified name and allocating it the
+   next number and bumping __NR_syscalls.  If --compat is specified, then
+   __SC_COMP() will be used in lieu of __SYSCALL() and the script will attempt
+   to emit appropriate compatibility lines into the tables.  The command is::
+
+     ./scripts/syscall-manage.pl --add <name> [--compat]
+
+ * Remove the system call with the specified name, decrementing __NR_syscalls
+   if it was the final one.  The command is::
+
+     ./scripts/syscall-manage.pl --rm <name>
+
+ * Rename the system call with the specified name to the new name.  The command
+   is::
+
+     ./scripts/syscall-manage.pl --rename <name> <new_name>
+
+ * Renumber the system calls between 424 and __NR_syscalls to remove any
+   holes and update __NR_syscalls.  The command is::
+
+     ./scripts/syscall-manage.pl --renumber
+
+ * Resolve simple git conflicts across all system call table files resulting
+   from one branch being merged into another where both branches add system
+   calls with conflicting numbers.  The new syscalls are renumbered,
+   __NR_syscalls is updated and the conflict markers and any extra definition
+   of __NR_syscalls are removed.  The command is::
+
+     ./scripts/syscall-manage.pl --resolve
+
+
 Do not call System Calls in the Kernel
 --------------------------------------
 
diff --git a/scripts/syscall-manage.pl b/scripts/syscall-manage.pl
new file mode 100755
index 000000000000..3a0cf76d5c15
--- /dev/null
+++ b/scripts/syscall-manage.pl
@@ -0,0 +1,929 @@
+#!/usr/bin/perl -w
+#
+# This script can be used to add, remove, rename and renumber system calls in
+# the kernel sources and resolve simple git conflicts when a branch carrying
+# new system calls is merged into another that also has new system calls with
+# conflicting numbers.
+#
+# Usage:
+#
+#  ./scripts/syscall-manage.pl --add <name> [--compat]
+#
+#	Add a new system call, giving it the specified name and allocating it
+#	the next number, bumping __NR_syscalls.  If --compat is specified, then
+#	__SC_COMP() will be used in lieu of __SYSCALL() and the script will
+#	attempt to emit appropriate compatibility lines into the tables.
+#
+#  ./scripts/syscall-manage.pl --rm <name>
+#
+#	Remove the system call with the specified name, decrementing
+#	__NR_syscalls if it was the final one.
+#
+#  ./scripts/syscall-manage.pl --rename <name> <new_name>
+#
+#	Rename the system call with the specified name to the new name.
+#
+#  ./scripts/syscall-manage.pl --renumber
+#
+#	Renumber the system calls between 424 and __NR_syscalls to remove any
+#	holes and update __NR_syscalls.
+#
+#  ./scripts/syscall-manage.pl --resolve
+#
+#	Resolve simple git conflicts across all system call table files
+#	resulting from one branch being merged into another where both branches
+#	add system calls with conflicting numbers.  The new syscalls are
+#	renumbered, __NR_syscalls is updated and the conflict markers and any
+#	extra definition of __NR_syscalls are removed.
+#
+use strict;
+
+#
+# List of files that need to be altered and their insertion patterns
+#
+my $master = "include/uapi/asm-generic/unistd.h";
+my $sys_ni = "kernel/sys_ni.c";
+my @tables = (
+    { file	=> "arch/alpha/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME",
+      num_offset => 110 },
+    { file	=> "arch/arm/tools/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME" },
+    { file	=> "arch/ia64/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME" },
+    { file	=> "arch/m68k/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME" },
+    { file	=> "arch/microblaze/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME" },
+    { file	=> "arch/mips/kernel/syscalls/syscall_n32.tbl",
+      pattern	=> "%NUM n32 %NAME sys_%NAME",
+      compat	=> 0 },
+    { file	=> "arch/mips/kernel/syscalls/syscall_n32.tbl",
+      pattern	=> "%NUM n32 %NAME compat_sys_%NAME",
+      compat	=> 1 },
+    { file	=> "arch/mips/kernel/syscalls/syscall_n64.tbl",
+      pattern	=> "%NUM n64 %NAME sys_%NAME" },
+    { file	=> "arch/mips/kernel/syscalls/syscall_o32.tbl",
+      pattern	=> "%NUM o32 %NAME sys_%NAME",
+      compat	=> 0 },
+    { file	=> "arch/mips/kernel/syscalls/syscall_o32.tbl",
+      pattern	=> "%NUM o32 %NAME sys_%NAME compat_sys_%NAME",
+      compat	=> 1 },
+    { file	=> "arch/parisc/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME",
+      compat	=> 0 },
+    { file	=> "arch/parisc/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME compat_sys_%NAME",
+      compat	=> 1 },
+    { file	=> "arch/powerpc/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME",
+      compat	=> 0 },
+    { file	=> "arch/powerpc/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME compat_sys_%NAME",
+      compat	=> 1 },
+    { file	=> "arch/s390/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME sys_%NAME",
+      widths	=> [ 8, 8, 24, 32, 32],
+      compat	=> 0 },
+    { file	=> "arch/s390/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME compat_sys_%NAME",
+      widths	=> [ 8, 8, 24, 32, 32],
+      compat	=> 1 },
+    { file	=> "arch/sh/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME" },
+    { file	=> "arch/sparc/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME",
+      compat	=> 0 },
+    { file	=> "arch/sparc/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME compat_sys_%NAME",
+      compat	=> 1 },
+    { file	=> "arch/x86/entry/syscalls/syscall_32.tbl",
+      pattern	=> "%NUM i386 %NAME sys_%NAME __ia32_sys_%NAME",
+      widths	=> [ 8, 8, 24, 32, 32],
+      compat	=> 0 },
+    { file	=> "arch/x86/entry/syscalls/syscall_32.tbl",
+      pattern	=> "%NUM i386 %NAME sys_%NAME __ia32_compat_sys_%NAME",
+      widths	=> [ 8, 8, 24, 32, 32],
+      compat	=> 1 },
+    { file	=> "arch/x86/entry/syscalls/syscall_64.tbl",
+      pattern	=> "%NUM common %NAME __x64_sys_%NAME",
+      widths	=> [ 8, 8, 24, 32, 32] },
+    { file	=> "arch/xtensa/kernel/syscalls/syscall.tbl",
+      pattern	=> "%NUM common %NAME sys_%NAME" },
+    #{ file	=> "tools/perf/arch/powerpc/entry/syscalls/syscall.tbl",
+    #  pattern	=> "%NUM common %NAME sys_%NAME" },
+    #{ file	=> "tools/perf/arch/s390/entry/syscalls/syscall.tbl",
+    #  pattern	=> "%NUM common %NAME sys_%NAME sys_%NAME" },
+    #{ file	=> "tools/perf/arch/x86/entry/syscalls/syscall_64.tbl",
+    #  pattern	=> "%NUM common %NAME __x64_sys_%NAME" },
+    );
+
+my $common_base = 424;
+
+#
+# Helpers
+#
+sub read_file($)
+{
+    my ($file) = @_;
+    my @lines;
+
+    open(FD, "<" . "$file") || die $file;
+    while (<FD>) {
+	chomp($_);
+	push @lines, $_;
+    }
+    close(FD) || die $file;
+    return \@lines;
+}
+
+sub write_file($$)
+{
+    my ($file, $lines) = @_;
+
+    print "Writing $file\n";
+    open(FD, ">" . "$file") || die $file;
+    print FD $_, "\n" foreach(@{$lines});
+    close(FD) || die $file;
+}
+
+###############################################################################
+#
+# Add a new syscall to the master list and return the syscall number allocated.
+#
+###############################################################################
+sub add_to_master($$)
+{
+    my ($name, $compat) = @_;
+    my $f = $master;
+    my $lines = read_file($f);
+    my $num = -1;
+    my $nr = -1;
+    my $i;
+    my $j = -1;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	if ($l =~ /^#define\s+__NR_syscalls\s+([0-9]+)/) {
+	    die "$f:$i: Multiple __NR_syscalls definitions\n" if ($nr != -1);
+	    $nr = $1;
+	    $j = $i;
+	}
+
+	if ($l =~ /^#define\s+__NR_([a-zA-Z0-9_]+)\s+([0-9]+)/) {
+	    if ($1 eq $name) {
+		die "$f:$i: Syscall multiply defined (", $num, ")\n" if ($num != -1);
+		print STDERR "$f:$i: Syscall already exists (", $2, ")\n";
+		$num = $2;
+	    }
+	}
+    }
+
+    die "$f: error: Can't find __NR_syscalls\n" if ($nr == -1);
+
+    if ($num == -1) {
+	# Update the last syscall number
+	$num = $nr;
+	print "Allocating syscall number ", $num, "\n";
+	$lines->[$j] = "#define __NR_syscalls " . ($nr + 1);
+
+	# Rewind to the last syscall number definition
+	while ($j--, $j >= 0 && $lines->[$j] eq "") {}
+	die "$f:$j: error: Expecting #undef __NR_syscalls\n"
+	    unless ($lines->[$j] =~ /^#undef\s+__NR_syscalls/);
+	while ($j--, $j >= 0 && $lines->[$j] eq "") {}
+	die "$f:%j: error: Expecting __SYSCALL or __SC_COMP\n"
+	    unless ($lines->[$j] =~ /^(__SYSCALL|__SC_COMP|__SC_3264|__SC_COMP_3264)/);
+	if ($lines->[$j - 1] =~ /^#define __NR_([a-zA-Z0-9_]+) ([0-9]+)/) {
+	    die "$f:$j: error: Incorrect syscall number ($2 != $num)\n"
+		if ($2 != $num - 1);
+	} else {
+	    die "$f:$j: error: Expecting #define __NR_*\n";
+	}
+	$j++;
+
+	# Insert the new syscall number
+	if ($compat == 0) {
+	    splice(@{$lines}, $j, 0,
+		   ( "#define __NR_$name $num",
+		     "__SYSCALL(__NR_$name, sys_$name)" ));
+	} elsif ($compat == 1) {
+	    splice(@{$lines}, $j, 0,
+		   ( "#define __NR_$name $num",
+		     "__SC_COMP(__NR_$name, sys_$name, compat_sys_$name)" ));
+	} else {
+	    die;
+	}
+
+	write_file($f, $lines);
+    }
+
+    return $num;
+}
+
+###############################################################################
+#
+# Add tabs to a string to pad it out
+#
+###############################################################################
+sub tab_to($$)
+{
+    my ($s, $width) = @_;
+
+    if ($width == 8) {
+	return $s . "\t";
+    } elsif ($width == 16) {
+	return $s . "\t" if (length($s) > 7);
+	return $s . "\t\t";
+    } elsif ($width == 24) {
+	return $s . "\t" if (length($s) > 15);
+	return $s . "\t\t" if (length($s) > 7);
+	return $s . "\t\t\t";
+    } elsif ($width == 32) {
+	return $s . "\t" if (length($s) > 23);
+	return $s . "\t\t" if (length($s) > 15);
+	return $s . "\t\t\t" if (length($s) > 7);
+	return $s . "\t\t\t\t";
+    } else {
+	die "Width $width\n";
+    }
+}
+
+###############################################################################
+#
+# Tabulate a table line appropriately.
+#
+###############################################################################
+sub tabulate($$)
+{
+    my ($l, $widths) = @_;
+    my @bits = split(/\s+/, $l);
+
+    my $rl = tab_to($bits[0], $widths->[0]);	# Syscall number
+    $rl .= tab_to($bits[1], $widths->[1]);	# Syscall type
+    $rl .= tab_to($bits[2], $widths->[2]);	# Syscall name
+
+    # Add the syscall handlers
+    if ($#bits == 3) {
+	$rl .= $bits[3];
+    } elsif ($#bits == 4) {
+	$rl .= tab_to($bits[3], $widths->[3]);
+	$rl .= $bits[4];
+    } elsif ($#bits == 5) {
+	$rl .= tab_to($bits[3], $widths->[4]);
+	$rl .= tab_to($bits[4], $widths->[5]);
+	$rl .= $bits[5];
+    } else {
+	die "Too many handlers\n";
+    }
+}
+
+###############################################################################
+#
+# Add a new syscall to a syscall.tbl file.
+#
+###############################################################################
+sub add_to_table($$$)
+{
+    my ($name, $num, $table) = @_;
+    my $f = $table->{file};
+    my $pattern = $table->{pattern};
+    my $widths = $table->{widths} ? $table->{widths} : [ 8, 8, 32, 32, 32 ];
+    my $lines = read_file($f);
+    my $i;
+    my $j = -1;
+
+    $num += $table->{num_offset} if (exists $table->{num_offset});
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	my @bits = split(/\s+/, $l);
+	next if ($#bits == -1);
+	if ($bits[0] eq $num - 1) {
+	    die "$f:$i: Duplicate syscall ", $num - 1, "\n" if $j != -1;
+	    $j = $i;
+	}
+	if ($bits[0] eq $num) {
+	    if ($bits[2] eq $name) {
+		print STDERR "$f:$i: Ignoring already-added syscall ", $num, "\n";
+		return;
+	    }
+	    die "$f:$i: Conflicting syscall ", $num, "\n";
+	}
+    }
+
+    die "$f: error: Can't find syscall ", $num - 1, "\n" if ($j == -1);
+
+    $pattern =~ s/%NAME/$name/g;
+    $pattern =~ s/%NUM/$num/g;
+    $pattern = tabulate($pattern, $widths);
+
+    # Insert the new syscall entry after the preceding one.
+    splice(@{$lines}, $j + 1, 0, ( $pattern ));
+
+    write_file($f, $lines);
+}
+
+###############################################################################
+#
+# Remove a syscall from the master list.
+#
+###############################################################################
+sub remove_from_master($)
+{
+    my ($name) = @_;
+    my $f = $master;
+    my $lines = read_file($f);
+    my $num = -1;
+    my $nr = -1;
+    my $i;
+    my $i_nr = -1;
+    my $i_num = -1;
+    my $c = 1;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	if ($l =~ /^#define\s+__NR_syscalls\s+([0-9]+)/) {
+	    die "$f:$i: Multiple __NR_syscalls definitions\n" if ($nr != -1);
+	    $nr = $1;
+	    $i_nr = $i;
+	}
+
+	if ($l =~ /^#define\s+__NR_([a-zA-Z0-9_]+)\s+([0-9]+)/) {
+	    if ($1 eq $name) {
+		if ($num != -1) {
+		    print STDERR "$f:$i: Syscall multiply defined (", $num, ")\n"
+		}
+		$num = $2; # Remove the last instance only
+		$i_num = $i;
+	    }
+	}
+    }
+
+    die "$f: error: Can't find __NR_syscalls\n" if ($i_nr == -1);
+
+    if ($i_num == -1) {
+	print "Syscall not found in unistd.h\n";
+	return;
+    }
+
+    # If the syscall number is the last one, deallocate it
+    if ($nr == $num + 1) {
+	print "Deallocating syscall number ", $num, "\n";
+	$lines->[$i_nr] = "#define __NR_syscalls " . ($nr - 1);
+    }
+
+    # Remove the __SYSCALL or __SC_COMP line also
+    if ($lines->[$i_num + 1] =~ /^(__SYSCALL|__SC_COMP|__SC_3264|__SC_COMP_3264)[(]__NR_$name,/) {
+	$c++;
+	$c++ if ($lines->[$i_num + 1] =~ /\\$/);
+    }
+
+    splice(@{$lines}, $i_num, $c, ());
+    write_file($f, $lines);
+}
+
+###############################################################################
+#
+# Remove a syscall from a syscall.tbl file.
+#
+###############################################################################
+sub remove_from_table($$)
+{
+    my ($name, $table) = @_;
+    my $f = $table->{file};
+    my $lines = read_file($f);
+    my $i;
+    my $j = -1;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	my @bits = split(/\s+/, $l);
+	my $num = $bits[0];
+	next if ($#bits < 2);
+
+	if ($bits[2] eq $name) {
+	    print STDERR "$f:$i: Duplicate syscall ", $num, "\n" if ($j != -1);
+	    $j = $i;
+	}
+    }
+
+    if ($j == -1) {
+	print STDERR "$f: error: Can't find syscall ", $name, "\n";
+	return;
+    }
+
+    # Remove the syscall entry
+    splice(@{$lines}, $j, 1, ());
+
+    write_file($f, $lines);
+}
+
+###############################################################################
+#
+# Remove a syscall from kernel/sys_ni.c
+#
+###############################################################################
+sub remove_from_sys_ni($)
+{
+    my ($name) = @_;
+    my $f = $sys_ni;
+    my $lines = read_file($f);
+    my $i;
+    my $j = -1;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+
+	if ($l =~ /COND_SYSCALL[_A-Z]*[(]$name[)]/) {
+	    if ($j == -1) {
+		$j = $i;
+	    } else {
+		print STDERR "$f:$i: Multiple COND_SYSCALLs\n";
+	    }
+	}
+    }
+
+    return if ($j == -1);
+
+    # Remove the COND_SYSCALL entry
+    splice(@{$lines}, $j, 1, ());
+
+    write_file($f, $lines);
+}
+
+###############################################################################
+#
+# Rename a syscall in the master list.
+#
+###############################################################################
+sub rename_in_master($$)
+{
+    my ($name, $name2) = @_;
+    my $f = $master;
+    my $lines = read_file($f);
+    my $num = -1;
+    my $i;
+    my $i_num = -1;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	if ($l =~ /^#define\s+__NR_([a-zA-Z0-9_]+)\s+([0-9]+)/) {
+	    if ($1 eq $name) {
+		if ($num != -1) {
+		    print STDERR "$f:$i: Syscall multiply defined (", $num, ")\n"
+		}
+		$num = $2; # Rename the last instance only
+		$i_num = $i;
+	    }
+	}
+    }
+
+    if ($i_num == -1) {
+	print "Syscall not found in unistd.h\n";
+	return;
+    }
+
+    # Rename the __SYSCALL or __SC_COMP line also
+    $lines->[$i_num] =~ s/$name/$name2/g;
+    if ($lines->[$i_num + 1] =~ /^(__SYSCALL|__SC_COMP|__SC_3264|__SC_COMP_3264)[(]__NR_$name,/) {
+	$lines->[$i_num + 1] =~ s/$name/$name2/g;
+	$lines->[$i_num + 2] =~ s/$name/$name2/g if ($lines->[$i_num + 1] =~ /\\$/);
+    }
+
+    write_file($f, $lines);
+}
+
+###############################################################################
+#
+# Rename a syscall in a syscall.tbl file.
+#
+###############################################################################
+sub rename_in_table($$$)
+{
+    my ($name, $name2, $table) = @_;
+    my $f = $table->{file};
+    my $pattern = $table->{pattern};
+    my $widths = $table->{widths} ? $table->{widths} : [ 8, 8, 32, 32, 32 ];
+    my $lines = read_file($f);
+    my $i;
+    my $j = -1;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	my @bits = split(/\s+/, $l);
+	my $num = $bits[0];
+	next if ($#bits < 2);
+
+	if ($bits[2] eq $name) {
+	    print STDERR "$f:$i: Duplicate syscall ", $num, "\n" if ($j != -1);
+	    $j = $i;
+	}
+    }
+
+    if ($j == -1) {
+	print STDERR "$f: error: Can't find syscall ", $name, "\n";
+	return;
+    }
+
+    # Rename the syscall entry
+    my $l = $lines->[$j];
+    $l =~ s/$name/$name2/g;
+    $lines->[$j] = $pattern = tabulate($l, $widths);
+
+    write_file($f, $lines);
+}
+
+###############################################################################
+#
+# Rename a syscall in kernel/sys_ni.c
+#
+###############################################################################
+sub rename_in_sys_ni($$)
+{
+    my ($name, $name2) = @_;
+    my $f = $sys_ni;
+    my $lines = read_file($f);
+    my $changed = 0;
+    my $i;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+
+	if ($l =~ /COND_SYSCALL[_A-Z]*[(]$name[)]/) {
+	    $lines->[$i] =~ s/$name/$name2/;
+	    $changed = 1;
+	}
+    }
+
+    write_file($f, $lines) if ($changed);
+}
+
+###############################################################################
+#
+# Resolve git-conflicted syscalls in the master list.
+#
+###############################################################################
+sub resolve_conflicts_in_master()
+{
+    my $f = $master;
+    my $lines = read_file($f);
+    my $nr = -1;
+    my $i;
+    my $i_nr = -1;
+    my $begin = -1;
+    my $mid = -1;
+    my $end = -1;
+    my $mode = 0;
+    my $nr_mode = 0;
+    my %conflict_list = ();
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+
+	if ($l =~ /^#define\s+__NR_syscalls\s+([0-9]+)/) {
+	    if ($mode == 0 && $i_nr != -1) {
+		$nr_mode = 4;
+		$nr = $1;
+		$i_nr = $i;
+	    } elsif ($mode == 1 && $nr_mode == 0) {
+		$nr_mode = 1;
+		$nr = $1;
+		$i_nr = $i;
+	    } elsif ($mode == 2 && $nr_mode == 1) {
+		$nr_mode = 2;
+		$i_nr = $i;
+	    } elsif ($mode == 3 && $nr_mode == 0) {
+		$nr_mode = 3;
+		$nr = $1;
+		$i_nr = $i;
+	    } else {
+		die "$f:$i: Multiple __NR_syscalls definitions\n";
+	    }
+	    next;
+	}
+	next if ($mode == 3);
+
+	if ($l =~ /^<<<<<<</) {
+	    $begin = $i;
+	    $mode = 1;
+	    next;
+	}
+	if ($l =~ /^=======/) {
+	    $mid = $i;
+	    $mode = 2;
+	    next;
+	}
+	if ($l =~ /^>>>>>>>/) {
+	    $end = $i;
+	    $mode = 3;
+	    next;
+	}
+	next if ($mode == 0);
+    }
+
+    if ($mode == 0) {
+	print "$f: Couldn't find section to be resolved\n";
+	return;
+    }
+
+    die "$f: error: Can't find __NR_syscalls\n" if ($i_nr == -1);
+
+    # Analyse what we're merging into.
+    my $top = -1;
+    for ($i = $begin + 1; $i < $mid; $i++) {
+	my $l = $lines->[$i];
+
+	next if ($l =~ /^#define\s+__NR_syscalls\s+[0-9]+/);
+
+	if ($l =~ /^#define\s+__NR_([a-zA-Z0-9_]+)\s+([0-9]+)/) {
+	    my $name = $1;
+	    my $num = $2;
+	    die "$f:$i: Redefinition of $name\n" if (exists($conflict_list{$name}));
+	    die "$f:$i: Number regression\n" if ($num < $top);
+	    $top = $num;
+	    $conflict_list{$name} = $num;
+	    print "Keep __NR_", $name, " as ", $num, "\n";
+	}
+    }
+
+    die "$f: Last number (", $top, ") different to limit-1 (", $nr - 1, ")\n"
+	if ($top != -1 && $top != $nr - 1);
+
+    # Renumber what we're merging in.
+    for ($i = $mid + 1; $i < $end; $i++) {
+	my $l = $lines->[$i];
+
+	next if ($l =~ /^#define\s+__NR_syscalls\s+[0-9]+/);
+
+	if ($l =~ /^#define\s+__NR_([a-zA-Z0-9_]+)\s+([0-9]+)/) {
+	    my $name = $1;
+	    my $num = $2;
+	    die "$f:$i: Definition of $name in both branches\n"
+		if (exists($conflict_list{$name}));
+	    my $new = $nr;
+	    $conflict_list{$name} = $new;
+	    $l =~ s/(\s)$num/${1}$new/;
+	    print "Reassign __NR_", $name, " to ", $new, "\n";
+	    $lines->[$i] = $l;
+	    $nr++;
+	}
+    }
+
+    # Adjust __NR_syscalls
+    if ($lines->[$i_nr] =~ /^#define\s+__NR_syscalls\s+([0-9]+)/) {
+	my $num = $1;
+	$lines->[$i_nr] =~ s/(\s)$num/${1}$nr/;
+	print "__NR_syscalls set to $nr\n";
+    }
+
+    # Delete various bits, starting with the highest index and working towards
+    # the lowest so as not to displace the higher indices.
+    splice(@{$lines}, $end, 1, ());
+    splice(@{$lines}, $mid, 1, ());
+    for ($i = $mid - 1; $i > $begin; $i--) {
+	my $l = $lines->[$i];
+
+	splice(@{$lines}, $i, 1, ()) if ($l =~ /^#undef\s+__NR_syscalls\s*$/);
+	splice(@{$lines}, $i, 1, ()) if ($l =~ /^#define\s+__NR_syscalls\s+([0-9]+)/);
+	splice(@{$lines}, $i, 1, ()) if ($l =~ /^$/);
+    }
+    splice(@{$lines}, $begin, 1, ());
+
+    write_file($f, $lines);
+    return \%conflict_list;
+}
+
+###############################################################################
+#
+# Resolve git-conflicted syscalls in a syscall.tbl file.
+#
+###############################################################################
+sub resolve_conflicts_in_table($$)
+{
+    my ($conflict_list, $table) = @_;
+    my $f = $table->{file};
+    my $lines = read_file($f);
+    my $i;
+    my $begin = -1;
+    my $mid = -1;
+    my $end = -1;
+    my $mode = 0;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+
+	if ($l =~ /^<<<<<<</) {
+	    $begin = $i;
+	    $mode = 1;
+	    next;
+	}
+	if ($l =~ /^=======/) {
+	    $mid = $i;
+	    $mode = 2;
+	    next;
+	}
+	if ($l =~ /^>>>>>>>/) {
+	    $end = $i;
+	    $mode = 3;
+	    last;
+	}
+	next if ($mode == 0);
+    }
+
+    if ($mode == 0) {
+	print "$f: Couldn't find section to be resolved\n";
+	return;
+    }
+
+    my %used = ();
+    for ($i = $begin + 1; $i < $mid; $i++) {
+	my $l = $lines->[$i];
+	next unless ($l =~ /^[0-9]/);
+	my @bits = split(/\s+/, $l);
+	my $num = $bits[0];
+	my $name = $bits[2];
+	next if ($#bits < 2);
+
+	die "$f:$i: Undefined syscall '", $name, "'\n"
+	    unless (exists($conflict_list->{$name}));
+
+	my $new = $conflict_list->{$name};
+	$new += $table->{num_offset} ? $table->{num_offset} : 0;
+	die "$f:$i: Redefined syscall '", $name, "'\n" if (exists($used{$name}));
+	$used{$name} = 1;
+	next if ($num == $new);
+    }
+
+    for ($i = $mid + 1; $i < $end; $i++) {
+	my $l = $lines->[$i];
+	next unless ($l =~ /^[0-9]/);
+	my @bits = split(/\s+/, $l);
+	my $num = $bits[0];
+	next if ($#bits < 2);
+	my $name = $bits[2];
+
+	die "$f:$i: Undefined syscall '", $name, "'\n"
+	    unless (exists($conflict_list->{$name}));
+
+	my $new = $conflict_list->{$name};
+	$new += $table->{num_offset} ? $table->{num_offset} : 0;
+	die "$f:$i: Redefined syscall '", $name, "'\n" if (exists($used{$name}));
+	$used{$name} = 1;
+	next if ($num == $new);
+	$lines->[$i] =~ s/^$num/$new/;
+    }
+
+    # Delete the git markers, starting with the highest index and working
+    # towards the lowest so as not to displace the higher indices.
+    splice(@{$lines}, $end, 1, ());
+    splice(@{$lines}, $mid, 1, ());
+    splice(@{$lines}, $begin, 1, ());
+
+    write_file($f, $lines);
+}
+
+###############################################################################
+#
+# Renumber the syscall numbers in the master list that are between 424 and
+# __NR_syscalls and reduce __NR_syscalls.
+#
+###############################################################################
+sub renumber_master()
+{
+    my $f = $master;
+    my $lines = read_file($f);
+    my $nr = -1;
+    my $next = $common_base;
+    my $i;
+    my $i_nr = -1;
+    my %num_list = ();
+
+    # Find the __NR_syscalls value.
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	if ($l =~ /^#define\s+__NR_syscalls\s+([0-9]+)/) {
+	    die "$f:$i: Redefinition of __NR_syscalls\n" if ($i_nr != -1);
+	    $nr = $1;
+	    $i_nr = $i;
+	}
+    }
+    die "$f: error: Can't find __NR_syscalls\n" if ($i_nr == -1);
+
+    # Renumber the definitions.
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	if ($l =~ /^#define\s+__NR_([a-zA-Z0-9_]+)\s+([0-9]+)/) {
+	    my $name = $1;
+	    my $num = $2;
+
+	    next if ($num < $common_base || $num >= $nr);
+	    if ($num != $next) {
+		print "Renumber ", $name, " from ", $num, " to ", $next, "\n";
+		$lines->[$i] =~ s/(\s)$num/${1}$next/;
+		$num_list{$name} = $next;
+	    }
+
+	    $next++;
+	}
+    }
+
+    # Adjust __NR_syscalls
+    $lines->[$i_nr] =~ s/(\s)$nr/${1}$next/;
+    print "__NR_syscalls set to $next\n";
+
+    write_file($f, $lines);
+    return \%num_list;
+}
+
+###############################################################################
+#
+# Renumber the syscall numbers in a syscall.tbl file to match the master.
+#
+###############################################################################
+sub renumber_table($$)
+{
+    my ($num_list, $table) = @_;
+    my $f = $table->{file};
+    my $lines = read_file($f);
+    my $i;
+
+    for ($i = 0; $i <= $#{$lines}; $i++) {
+	my $l = $lines->[$i];
+	my @bits = split(/\s+/, $l);
+	next if ($#bits < 2);
+	my $num = $bits[0];
+	my $name = $bits[2];
+
+	next unless (exists($num_list->{$name}));
+	my $new = $num_list->{$name};
+	$new += $table->{num_offset} ? $table->{num_offset} : 0;
+	next if ($num eq $new);
+
+	$lines->[$i] =~ s/^$num/$new/;
+    }
+
+    write_file($f, $lines);
+}
+
+###############################################################################
+#
+# Decide what to do based on the script parameters
+#
+###############################################################################
+sub format_error()
+{
+    print("Format: syscall-manage.pl --add <name> [--compat]\n");
+    print("                          --rm <name>\n");
+    print("                          --rename <name>\n");
+    print("                          --renumber\n");
+    print("                          --resolve\n");
+    exit(2);
+}
+
+format_error() if ($#ARGV < 0);
+
+if ($ARGV[0] eq "--add") {
+    format_error() if ($#ARGV < 1);
+
+    my $name = $ARGV[1];
+    my $compat = 0;
+    $compat = 1 if ($#ARGV == 2 && $ARGV[2] eq "--compat");
+
+    my $num = add_to_master($name, $compat);
+    foreach my $table (@tables) {
+	next if (exists($table->{compat}) && $compat != $table->{compat});
+	add_to_table($name, $num, $table);
+    }
+} elsif ($ARGV[0] eq "--rm") {
+    format_error() if ($#ARGV < 1);
+
+    my $name = $ARGV[1];
+    remove_from_master($name);
+    foreach (@tables) {
+	remove_from_table($name, $_);
+    }
+    remove_from_sys_ni($name);
+} elsif ($ARGV[0] eq "--rename") {
+    format_error() if ($#ARGV < 2);
+
+    my $name = $ARGV[1];
+    my $name2 = $ARGV[2];
+    rename_in_master($name, $name2);
+    foreach (@tables) {
+	rename_in_table($name, $name2, $_);
+    }
+    rename_in_sys_ni($name, $name2);
+} elsif ($ARGV[0] eq "--resolve") {
+    my $conflict_list = resolve_conflicts_in_master();
+    foreach (@tables) {
+	resolve_conflicts_in_table($conflict_list, $_);
+    }
+} elsif ($ARGV[0] eq "--renumber") {
+    my $num_list = renumber_master();
+    foreach (@tables) {
+	renumber_table($num_list, $_);
+    }
+} else {
+    format_error();
+}

