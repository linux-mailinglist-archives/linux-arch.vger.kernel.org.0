Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E713207D7D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406680AbgFXUed (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406488AbgFXUdP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54418C061796
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f16so3545166ybp.5
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S7/JzDwDdHoacgX6HvX2Jr2gVU2/RbvZoPut7JAQqiU=;
        b=GbaM26uqdS3Vdn7y/4tYXw9WRnWXuMV2obYfkzVrTaJ0mYtswhFhf+0vt6bJlB8Tyg
         SsJduDBm2w+U3nsaOr1HASJhjnKenhtFzEzZEJ1BdYCYZ4WUgPZzBQtVTGMw6PiUH/Rv
         bul94Ghqr6xxTHUblFMZFutUETTCwdziKLRISNyn6cw0oFgemCdB69tmR7KshvVBvCrb
         lr/U4Ye5y8RJiY4ppLsyOzho5N14wDkBdTPJK9avH04PiX2+sruAUeNKN/W0VXCW4DS5
         BLaS1bJ+bnHCjleMO2kHOyBPUN8uMtrR8cqySobnViK77k3HeWm/l1v826SwgG3uVULl
         /5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S7/JzDwDdHoacgX6HvX2Jr2gVU2/RbvZoPut7JAQqiU=;
        b=juci5D3RZBERXfioju42OMDiAtRjvisRrED7ise+8YHHIZNt0/+r+FF1pytktBjBkM
         jngsun++ehQGB0zSImBSpb5BabAOhVv4J+0REmvp/FZg5CXzfZWcB488gRVj5ekq4r/j
         GOtGY9FrQ6FvEUGpInQs9QUNb7lIL0m9wVk3PbF/9ZxBOcV+8zQjR83fUW8BmhgVTjut
         A0ctDZw3EVjiKilgPkGKy9sf+6eVtgTKT4BdtL+Io7UAmCsEnK8LbFVKQ1lCeZRwLRRG
         JykSnxSKWBhblax4g1ki+QXSOt0eNunptDku87CcBwAJN9e2ZDZaMHRhAwUhZ7RxFJ+G
         8EAg==
X-Gm-Message-State: AOAM530bxzUrb6BkV4oqXs3e2f4qZll00NDo7gv6mFzeXtqtQnqrkG0j
        xIzItkrIAAK76epTXkZXMXXE/EL6omLLHouoEEQ=
X-Google-Smtp-Source: ABdhPJzyJsK9nvJbVcqyv2JogyV+HhGhFMYJ3uGRw+AE0p+Je0Oon8fPN8IIasUK4xLrPwCevx7L9/glgNckOd8vEzE=
X-Received: by 2002:a25:6d02:: with SMTP id i2mr36280555ybc.365.1593030794516;
 Wed, 24 Jun 2020 13:33:14 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:47 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 09/22] init: lto: ensure initcall ordering
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With LTO, the compiler doesn't necessarily obey the link order for
initcalls, and initcall variables need globally unique names to avoid
collisions at link time.

This change exports __KBUILD_MODNAME and adds the initcall_id() macro,
which uses it together with __COUNTER__ and __LINE__ to help ensure
these variables have unique names, and moves each variable to its own
section when LTO is enabled, so the correct order can be specified using
a linker script.

The generate_initcall_ordering.pl script uses nm to find initcalls from
the object files passed to the linker, and generates a linker script
that specifies the intended order. With LTO, the script is called in
link-vmlinux.sh.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/init.h               |  52 +++++-
 scripts/Makefile.lib               |   6 +-
 scripts/generate_initcall_order.pl | 270 +++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh            |  14 ++
 4 files changed, 333 insertions(+), 9 deletions(-)
 create mode 100755 scripts/generate_initcall_order.pl

diff --git a/include/linux/init.h b/include/linux/init.h
index 212fc9e2f691..af638cd6dd52 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -184,19 +184,57 @@ extern bool initcall_debug;
  * as KEEP() in the linker script.
  */
 
+/* Format: <modname>__<counter>_<line>_<fn> */
+#define __initcall_id(fn)					\
+	__PASTE(__KBUILD_MODNAME,				\
+	__PASTE(__,						\
+	__PASTE(__COUNTER__,					\
+	__PASTE(_,						\
+	__PASTE(__LINE__,					\
+	__PASTE(_, fn))))))
+
+/* Format: __<prefix>__<iid><id> */
+#define __initcall_name(prefix, __iid, id)			\
+	__PASTE(__,						\
+	__PASTE(prefix,						\
+	__PASTE(__,						\
+	__PASTE(__iid, id))))
+
+#ifdef CONFIG_LTO_CLANG
+/*
+ * With LTO, the compiler doesn't necessarily obey link order for
+ * initcalls. In order to preserve the correct order, we add each
+ * variable into its own section and generate a linker script (in
+ * scripts/link-vmlinux.sh) to specify the order of the sections.
+ */
+#define __initcall_section(__sec, __iid)			\
+	#__sec ".init.." #__iid
+#else
+#define __initcall_section(__sec, __iid)			\
+	#__sec ".init"
+#endif
+
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define ___define_initcall(fn, id, __sec)			\
+#define ____define_initcall(fn, __name, __sec)			\
 	__ADDRESSABLE(fn)					\
-	asm(".section	\"" #__sec ".init\", \"a\"	\n"	\
-	"__initcall_" #fn #id ":			\n"	\
+	asm(".section	\"" __sec "\", \"a\"		\n"	\
+	    __stringify(__name) ":			\n"	\
 	    ".long	" #fn " - .			\n"	\
 	    ".previous					\n");
 #else
-#define ___define_initcall(fn, id, __sec) \
-	static initcall_t __initcall_##fn##id __used \
-		__attribute__((__section__(#__sec ".init"))) = fn;
+#define ____define_initcall(fn, __name, __sec)			\
+	static initcall_t __name __used 			\
+		__attribute__((__section__(__sec))) = fn;
 #endif
 
+#define __unique_initcall(fn, id, __sec, __iid)			\
+	____define_initcall(fn,					\
+		__initcall_name(initcall, __iid, id),		\
+		__initcall_section(__sec, __iid))
+
+#define ___define_initcall(fn, id, __sec)			\
+	__unique_initcall(fn, id, __sec, __initcall_id(fn))
+
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
 /*
@@ -236,7 +274,7 @@ extern bool initcall_debug;
 #define __exitcall(fn)						\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
+#define console_initcall(fn)	___define_initcall(fn, con, .con_initcall)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 99ac59c59826..17447354b543 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -106,9 +106,11 @@ target-stem = $(basename $(patsubst $(obj)/%,%,$@))
 # These flags are needed for modversions and compiling, so we define them here
 # $(modname_flags) defines KBUILD_MODNAME as the name of the module it will
 # end up in (or would, if it gets compiled in)
-name-fix = $(call stringify,$(subst $(comma),_,$(subst -,_,$1)))
+name-fix-token = $(subst $(comma),_,$(subst -,_,$1))
+name-fix = $(call stringify,$(call name-fix-token,$1))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
-modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
+modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \
+		 -D__KBUILD_MODNAME=$(call name-fix-token,$(modname))
 modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
 
 orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
diff --git a/scripts/generate_initcall_order.pl b/scripts/generate_initcall_order.pl
new file mode 100755
index 000000000000..fe83aec2b51e
--- /dev/null
+++ b/scripts/generate_initcall_order.pl
@@ -0,0 +1,270 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generates a linker script that specifies the correct initcall order.
+#
+# Copyright (C) 2019 Google LLC
+
+use strict;
+use warnings;
+use IO::Handle;
+use IO::Select;
+use POSIX ":sys_wait_h";
+
+my $nm = $ENV{'NM'} || die "$0: ERROR: NM not set?";
+my $objtree = $ENV{'objtree'} || '.';
+
+## currently active child processes
+my $jobs = {};		# child process pid -> file handle
+## results from child processes
+my $results = {};	# object index -> [ { level, secname }, ... ]
+
+## reads _NPROCESSORS_ONLN to determine the maximum number of processes to
+## start
+sub get_online_processors {
+	open(my $fh, "getconf _NPROCESSORS_ONLN 2>/dev/null |")
+		or die "$0: ERROR: failed to execute getconf: $!";
+	my $procs = <$fh>;
+	close($fh);
+
+	if (!($procs =~ /^\d+$/)) {
+		return 1;
+	}
+
+	return int($procs);
+}
+
+## writes results to the parent process
+## format: <file index> <initcall level> <base initcall section name>
+sub write_results {
+	my ($index, $initcalls) = @_;
+
+	# sort by the counter value to ensure the order of initcalls within
+	# each object file is correct
+	foreach my $counter (sort { $a <=> $b } keys(%{$initcalls})) {
+		my $level = $initcalls->{$counter}->{'level'};
+
+		# section name for the initcall function
+		my $secname = $initcalls->{$counter}->{'module'} . '__' .
+			      $counter . '_' .
+			      $initcalls->{$counter}->{'line'} . '_' .
+			      $initcalls->{$counter}->{'function'};
+
+		print "$index $level $secname\n";
+	}
+}
+
+## reads a result line from a child process and adds it to the $results array
+sub read_results{
+	my ($fh) = @_;
+
+	# each child prints out a full line w/ autoflush and exits after the
+	# last line, so even if buffered I/O blocks here, it shouldn't block
+	# very long
+	my $data = <$fh>;
+
+	if (!defined($data)) {
+		return 0;
+	}
+
+	chomp($data);
+
+	my ($index, $level, $secname) = $data =~
+		/^(\d+)\ ([^\ ]+)\ (.*)$/;
+
+	if (!defined($index) ||
+		!defined($level) ||
+		!defined($secname)) {
+		die "$0: ERROR: child process returned invalid data: $data\n";
+	}
+
+	$index = int($index);
+
+	if (!exists($results->{$index})) {
+		$results->{$index} = [];
+	}
+
+	push (@{$results->{$index}}, {
+		'level'   => $level,
+		'secname' => $secname
+	});
+
+	return 1;
+}
+
+## finds initcalls from an object file or all object files in an archive, and
+## writes results back to the parent process
+sub find_initcalls {
+	my ($index, $file) = @_;
+
+	die "$0: ERROR: file $file doesn't exist?" if (! -f $file);
+
+	open(my $fh, "\"$nm\" --defined-only \"$file\" 2>/dev/null |")
+		or die "$0: ERROR: failed to execute \"$nm\": $!";
+
+	my $initcalls = {};
+
+	while (<$fh>) {
+		chomp;
+
+		# check for the start of a new object file (if processing an
+		# archive)
+		my ($path)= $_ =~ /^(.+)\:$/;
+
+		if (defined($path)) {
+			write_results($index, $initcalls);
+			$initcalls = {};
+			next;
+		}
+
+		# look for an initcall
+		my ($module, $counter, $line, $symbol) = $_ =~
+			/[a-z]\s+__initcall__(\S*)__(\d+)_(\d+)_(.*)$/;
+
+		if (!defined($module)) {
+			$module = ''
+		}
+
+		if (!defined($counter) ||
+			!defined($line) ||
+			!defined($symbol)) {
+			next;
+		}
+
+		# parse initcall level
+		my ($function, $level) = $symbol =~
+			/^(.*)((early|rootfs|con|[0-9])s?)$/;
+
+		die "$0: ERROR: invalid initcall name $symbol in $file($path)"
+			if (!defined($function) || !defined($level));
+
+		$initcalls->{$counter} = {
+			'module'   => $module,
+			'line'     => $line,
+			'function' => $function,
+			'level'    => $level,
+		};
+	}
+
+	close($fh);
+	write_results($index, $initcalls);
+}
+
+## waits for any child process to complete, reads the results, and adds them to
+## the $results array for later processing
+sub wait_for_results {
+	my ($select) = @_;
+
+	my $pid = 0;
+	do {
+		# unblock children that may have a full write buffer
+		foreach my $fh ($select->can_read(0)) {
+			read_results($fh);
+		}
+
+		# check for children that have exited, read the remaining data
+		# from them, and clean up
+		$pid = waitpid(-1, WNOHANG);
+		if ($pid > 0) {
+			if (!exists($jobs->{$pid})) {
+				next;
+			}
+
+			my $fh = $jobs->{$pid};
+			$select->remove($fh);
+
+			while (read_results($fh)) {
+				# until eof
+			}
+
+			close($fh);
+			delete($jobs->{$pid});
+		}
+	} while ($pid > 0);
+}
+
+## forks a child to process each file passed in the command line and collects
+## the results
+sub process_files {
+	my $index = 0;
+	my $njobs = get_online_processors();
+	my $select = IO::Select->new();
+
+	while (my $file = shift(@ARGV)) {
+		# fork a child process and read it's stdout
+		my $pid = open(my $fh, '-|');
+
+		if (!defined($pid)) {
+			die "$0: ERROR: failed to fork: $!";
+		} elsif ($pid) {
+			# save the child process pid and the file handle
+			$select->add($fh);
+			$jobs->{$pid} = $fh;
+		} else {
+			# in the child process
+			STDOUT->autoflush(1);
+			find_initcalls($index, "$objtree/$file");
+			exit;
+		}
+
+		$index++;
+
+		# limit the number of children to $njobs
+		if (scalar(keys(%{$jobs})) >= $njobs) {
+			wait_for_results($select);
+		}
+	}
+
+	# wait for the remaining children to complete
+	while (scalar(keys(%{$jobs})) > 0) {
+		wait_for_results($select);
+	}
+}
+
+sub generate_initcall_lds() {
+	process_files();
+
+	my $sections = {};	# level -> [ secname, ...]
+
+	# sort results to retain link order and split to sections per
+	# initcall level
+	foreach my $index (sort { $a <=> $b } keys(%{$results})) {
+		foreach my $result (@{$results->{$index}}) {
+			my $level = $result->{'level'};
+
+			if (!exists($sections->{$level})) {
+				$sections->{$level} = [];
+			}
+
+			push(@{$sections->{$level}}, $result->{'secname'});
+		}
+	}
+
+	die "$0: ERROR: no initcalls?" if (!keys(%{$sections}));
+
+	# print out a linker script that defines the order of initcalls for
+	# each level
+	print "SECTIONS {\n";
+
+	foreach my $level (sort(keys(%{$sections}))) {
+		my $section;
+
+		if ($level eq 'con') {
+			$section = '.con_initcall.init';
+		} else {
+			$section = ".initcall${level}.init";
+		}
+
+		print "\t${section} : {\n";
+
+		foreach my $secname (@{$sections->{$level}}) {
+			print "\t\t*(${section}..${secname}) ;\n";
+		}
+
+		print "\t}\n";
+	}
+
+	print "}\n";
+}
+
+generate_initcall_lds();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c72f5d0238f1..42c73e24e820 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -39,6 +39,16 @@ info()
 	fi
 }
 
+# Generate a linker script to ensure correct ordering of initcalls.
+gen_initcalls()
+{
+	info GEN .tmp_initcalls.lds
+
+	${srctree}/scripts/generate_initcall_order.pl \
+		${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS} \
+		> .tmp_initcalls.lds
+}
+
 # If CONFIG_LTO_CLANG is selected, collect generated symbol versions into
 # .tmp_symversions.lds
 gen_symversions()
@@ -70,6 +80,9 @@ modpost_link()
 		--end-group"
 
 	if [ -n "${CONFIG_LTO_CLANG}" ]; then
+		gen_initcalls
+		lds="-T .tmp_initcalls.lds"
+
 		if [ -n "${CONFIG_MODVERSIONS}" ]; then
 			gen_symversions
 			lds="${lds} -T .tmp_symversions.lds"
@@ -283,6 +296,7 @@ cleanup()
 {
 	rm -f .btf.*
 	rm -f .tmp_System.map
+	rm -f .tmp_initcalls.lds
 	rm -f .tmp_symversions.lds
 	rm -f .tmp_vmlinux*
 	rm -f System.map
-- 
2.27.0.212.ge8ba1cc988-goog

