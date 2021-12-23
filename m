Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2517047DBDA
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbhLWAYA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:24:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:60588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345641AbhLWAXm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219022; x=1671755022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sAVEUm78aFn8dsIZXm3eQrfx/zIC7rgNCykiemsRC0c=;
  b=hkgEcq7WdkOipcXaHxQPytw+/NjyJO49G5PkM89YgqJjUDSbYErbR/m/
   QYe7Entn/3Xbz4Pkr0ix82yys/yK2THS04dR13WIRQLMvBGDAi8w7Y9BE
   91jWe6nkuWz3PPAuN65KDSbLtcw/e5UtVxNy+z8WpviIfz4WDmNGLmeX8
   mXLB3i7pYLOYiGeT+7thU+1ngFMy7CX1K3aE4Oba7XwijlP2cyDWHomCu
   o1brUJI24L1mSEwld41lXE4sEEOYqKJFt9ufOb5s1uONujf0cxrKKipmv
   XYgl8W43dvkZyYxGos2tDivosOkC8Mwdti2yWc01y3B9iYCpzGgeHYTuL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="220739056"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="220739056"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="614013904"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2021 16:23:29 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79F032467;
        Thu, 23 Dec 2021 00:23:27 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v9 10/15] FG-KASLR: use a scripted approach to handle .text.* sections
Date:   Thu, 23 Dec 2021 01:22:04 +0100
Message-Id: <20211223002209.1092165-11-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of relying on the linker and his heuristics about where to
place (orphan) .text.* section, use a script to read vmlinux.o and
generate a new .tmp_vmlinux.lds which will contain an entry for
each of them. It relies on a magic marker inside the preprocessed
vmlinux.lds (which is harmless in case FG-KASLR is disabled) and
injects a list of input text sections there.

As a bonus, this approach allows us to configure FG-KASLR in terms
of number of functions per each section. The zero value means one
section per each functions, it is the strongest choice, but the
resulting vmlinux also has the biggest size here, as well as the
total number of sections and the boottime delay (which is still
barely noticeable). The values of 4-8 are still strong enough and
allows to save some space, and so on.

We also keep tracking the maximal alignment we found while
traversing through the readelf output and the number of times we
spotted it. It's actual only for values >= 64 and is required to
reserve some space between the last .text.* section and the _etext
marker.
The reason is that e.g. x86 has at least 3 ASM sections (4 with
ClangCFI) aligned to 4096, and when mixing them with the small
sections, we could go past the _etext and render the kernel
unbootable. This reserved space ensures this won't happen.

When CONFIG_HAVE_ASM_FUNCTION_SECTIONS=y, the generated script makes
sure you don't have anything in "plain" ".text" to not leak random
code. This assertion is omitted otherwise.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/kernel/vmlinux.lds.S     |   4 +-
 include/asm-generic/vmlinux.lds.h |   6 ++
 init/Kconfig                      |  14 +++
 scripts/generate_text_sections.pl | 165 ++++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh           |  29 +++++-
 5 files changed, 216 insertions(+), 2 deletions(-)
 create mode 100755 scripts/generate_text_sections.pl

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6620f069b7ef..6f039bf9de34 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -147,9 +147,11 @@ SECTIONS
 #endif
 	} :text =0xcccc
 
+	TEXT_FG_KASLR
+
 	/* End of text section, which should occupy whole number of pages */
-	_etext = .;
 	. = ALIGN(PAGE_SIZE);
+	_etext = .;
 
 	X86_ALIGN_RODATA_BEGIN
 	RO_DATA(PAGE_SIZE)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 586465b2abb2..e63d5a69f1bc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -130,6 +130,12 @@
 #define TEXT_MAIN		.text
 #endif
 
+/*
+ * Used by scripts/generate_text_sections.pl to inject text sections,
+ * harmless if FG-KASLR is disabled.
+ */
+#define TEXT_FG_KASLR		__fg_kaslr_magic = .;
+
 /*
  * GCC 4.5 and later have a 32 bytes section alignment for structures.
  * Except GCC 4.9, that feels the need to align on 64 bytes.
diff --git a/init/Kconfig b/init/Kconfig
index a74b3c3acb49..381b063b4925 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2079,6 +2079,20 @@ config FG_KASLR
 
 	  If unsure, say N.
 
+config FG_KASLR_SHIFT
+	int "FG-KASLR granularity (number of functions per section shift)"
+	depends on FG_KASLR
+	range 0 16
+	default 0
+	help
+	  This sets the number of functions that will be put in each section
+	  as a power of two.
+	  Decreasing the value increases the randomization, but also increases
+	  the size of the final kernel/vmlinux due to the amount of sections.
+	  0 means that a separate section will be created for each function.
+	  16 almost disables the randomization, leaving only the manual
+	  separation.
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/scripts/generate_text_sections.pl b/scripts/generate_text_sections.pl
new file mode 100755
index 000000000000..c95b9be28920
--- /dev/null
+++ b/scripts/generate_text_sections.pl
@@ -0,0 +1,165 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Generates a new LD script with every .text.* section described for FG-KASLR
+# to avoid orphan/heuristic section placement and double-checks we don't have
+# any symbols in plain .text section.
+#
+# Copyright (C) 2021, Intel Corporation.
+# Author: Alexander Lobakin <alexandr.lobakin@intel.com>
+#
+
+use strict;
+use warnings;
+
+## parameters
+my $add_assert = 0;
+my $expecting = 0;
+my $shift = 0;
+my $file;
+
+foreach (@ARGV) {
+	if ($_ eq '-a') {
+		$add_assert = 1;
+	} elsif ($_ eq '-s') {
+		$expecting = 1;
+	} elsif ($expecting) {
+		$shift = $_ + 0;
+		if ($shift < 0) {
+			$shift = 0;
+		} elsif ($shift > 16) {
+			$shift = 16;
+		}
+		$expecting = 0;
+	} elsif (!defined($file)) {
+		$file = $_;
+	} else {
+		die "$0: usage: $0 [-a] [-s shift] binary < linker script";
+	}
+}
+
+if (!defined($file)) {
+	die "$0: usage: $0 [-a] [-s shift] binary < linker script";
+}
+
+## environment
+my $readelf = $ENV{'READELF'} || die "$0: ERROR: READELF not set?";
+
+## text sections array
+my @sections = ();
+my $has_ccf = 0;
+
+## max alignment found to reserve some space. It would probably be
+## better to start from 64, but CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B
+## (which aligns every function to 64b) would kill us then
+my $max_align = 128;
+my $count = 0;
+
+sub read_sections {
+	open(my $fh, "\"$readelf\" -SW \"$file\" 2>/dev/null |")
+		or die "$0: ERROR: failed to execute \"$readelf\": $!";
+
+	while (<$fh>) {
+		my $name;
+		my $align;
+		chomp;
+
+		($name, $align) = $_ =~ /^\s*\[[\s0-9]*\]\s*(\.\S*)\s*[A-Z]*\s*[0-9a-f]{16}\s*[0-9a-f]*\s*[0-9a-f]*\s*[0-9a-f]*\s*[0-9a-f]{2}\s*[A-Z]{2}\s*[0-9]\s*[0-9]\s*([0-9]*)$/;
+
+		if (!defined($name)) {
+			next;
+		}
+
+		## Clang 13 onwards emits __cfi_check_fail only on final
+		## linking, so it won't appear in .o files and will be
+		## missing in @sections. Add it manually to prevent
+		## spawning orphans.
+		if ($name eq ".text.__cfi_check_fail") {
+			$has_ccf = 1;
+		}
+
+		if (!($name =~ /^\.text(\.(?!hot\.|unknown\.|unlikely\.|.san\.)[0-9a-zA-Z_]*){1,2}((\.constprop|\.isra|\.part)\.[0-9]){0,2}(|\.[0-9cfi]*)$/)) {
+			next;
+		}
+
+		if ($align > $max_align) {
+			$max_align = $align;
+			$count = 1;
+		} elsif ($align == $max_align) {
+			$count++;
+		}
+
+		push(@sections, $name);
+	}
+
+	close($fh);
+
+	if (!$has_ccf) {
+		push(@sections, ".text.__cfi_check_fail");
+	}
+
+	@sections = sort @sections;
+}
+
+sub print_sections {
+	my $fps = 1 << $shift;
+	my $counter = 1;
+
+	print "\t.text.0 : ALIGN(16) {\n";
+	print "\t\t*(.text)\n";
+	print "\t}\n";
+
+	## If we have ASM function sections, we shouldn't have anything
+	## in here.
+	if ($add_assert) {
+		print "\tASSERT(SIZEOF(.text.0) == 0, \"Plain .text is not empty!\")\n\n";
+	}
+
+	if (!@sections) {
+		return;
+	}
+
+	while () {
+		print "\t.text.$counter : ALIGN(16) {\n";
+
+		my @a = (($counter - 1) * $fps .. ($counter * $fps) - 1);
+		for (@a) {
+			print "\t\t*($sections[$_])\n";
+
+			if ($sections[$_] eq $sections[-1]) {
+				print "\t}\n";
+				return;
+			}
+		}
+
+		print "\t}\n";
+		$counter++;
+	}
+}
+
+sub print_reserve {
+	## If we have text sections aligned with 64 bytes or more, make
+	## sure we reserve some space for them to not overlap _etext
+	## while shuffling sections.
+	if (!$count) {
+		return;
+	}
+
+	print "\n\t. += $max_align * $count;\n";
+}
+
+sub print_lds {
+	while (<STDIN>) {
+		if ($_ =~ /^\s*__fg_kaslr_magic = \.;$/) {
+			print_sections();
+			print_reserve();
+		} else {
+			print $_;
+		}
+	}
+}
+
+## main
+
+read_sections();
+print_lds();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5cdd9bc5c385..9d8894cb1c21 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -66,6 +66,22 @@ gen_symversions()
 	done
 }
 
+# If CONFIG_FG_KASLR is selected, generate a linker script which will
+# declare all custom text sections for future boottime shuffling
+gen_text_sections()
+{
+	local a=""
+
+	[ -n "${CONFIG_HAVE_ASM_FUNCTION_SECTIONS}" ] && a="-a"
+
+	info GEN .tmp_vmlinux.lds
+
+	${PERL} ${srctree}/scripts/generate_text_sections.pl	\
+		${a} -s "${CONFIG_FG_KASLR_SHIFT}" vmlinux.o	\
+		< "${objtree}/${KBUILD_LDS}"			\
+		> .tmp_vmlinux.lds
+}
+
 # Link of vmlinux.o used for section mismatch analysis
 # ${1} output file
 modpost_link()
@@ -155,12 +171,19 @@ vmlinux_link()
 	local ld
 	local ldflags
 	local ldlibs
+	local lds
 
 	info LD ${output}
 
 	# skip output file argument
 	shift
 
+	if [ -n "${CONFIG_FG_KASLR}" ]; then
+		lds=".tmp_vmlinux.lds"
+	else
+		lds="${objtree}/${KBUILD_LDS}"
+	fi
+
 	if [ -n "${CONFIG_LTO_CLANG}" ]; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
@@ -182,7 +205,7 @@ vmlinux_link()
 		ldlibs=
 	fi
 
-	ldflags="${ldflags} ${wl}--script=${objtree}/${KBUILD_LDS}"
+	ldflags="${ldflags} ${wl}--script=${lds}"
 
 	# The kallsyms linking does not need debug symbols included.
 	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
@@ -342,6 +365,10 @@ info GEN modules.builtin
 tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
 	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
 
+if [ -n "${CONFIG_FG_KASLR}" ]; then
+	gen_text_sections
+fi
+
 btf_vmlinux_bin_o=""
 if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
 	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
-- 
2.33.1

