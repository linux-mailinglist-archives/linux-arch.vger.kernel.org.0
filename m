Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8163FCA2C
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbhHaOnl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:43:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:36597 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238678AbhHaOnT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:43:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="205617096"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="205617096"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="466478286"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2021 07:42:19 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmfe002209;
        Tue, 31 Aug 2021 15:42:16 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org
Cc:     "Kristen C Accardi" <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        "Marta A Plantykow" <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v6 kspp-next 14/22] FG-KASLR: use a scripted approach to handle .text.* sections
Date:   Tue, 31 Aug 2021 16:41:06 +0200
Message-Id: <20210831144114.154-15-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
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

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/kernel/vmlinux.lds.S     |   4 +-
 include/asm-generic/vmlinux.lds.h |   6 ++
 init/Kconfig                      |  14 +++
 scripts/generate_text_sections.pl | 144 ++++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh           |  25 +++++-
 5 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100755 scripts/generate_text_sections.pl

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9692e990145b..4ed3b3b2b0e7 100644
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
index 01fdeb5dd216..70fac18c786e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -127,6 +127,12 @@
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
index cd1440b6a566..e72633f4f8a9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2033,6 +2033,20 @@ config FG_KASLR
 
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
index 000000000000..5f3ece2ee0ea
--- /dev/null
+++ b/scripts/generate_text_sections.pl
@@ -0,0 +1,144 @@
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
+my $expecting = 0;
+my $shift = 0;
+my $file;
+
+foreach (@ARGV) {
+	if ($_ eq '-s') {
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
+		die "$0: usage: $0 [-s shift] binary < linker script";
+	}
+}
+
+if (!defined($file)) {
+	die "$0: usage: $0 [-s shift] binary < linker script";
+}
+
+## environment
+my $readelf = $ENV{'READELF'} || die "$0: ERROR: READELF not set?";
+
+## text sections array
+my @sections = ();
+
+## max alignment found to reserve some space
+my $max_align = 64;
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
+		if (!($name =~ /^\.text\.[0-9a-zA-Z_]*((\.constprop|\.isra|\.part)\.[0-9])*(|\.[0-9cfi]*)$/)) {
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
+	print "\tASSERT(SIZEOF(.text.0) == 0, \"Plain .text is not empty!\")\n\n";
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
+	## If we have text sections aligned with 64 bytes or more, make sure
+	## we reserve some space for them to not overlap _etext while shuffling
+	## sections
+
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
index d74cee5c4326..b4e6578371bc 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -66,6 +66,18 @@ gen_symversions()
 	done
 }
 
+# If CONFIG_FG_KASLR is selected, generate a linker script which will
+# declare all custom text sections for future boottime shuffling
+gen_text_sections()
+{
+	info GEN .tmp_vmlinux.lds
+
+	${PERL} ${srctree}/scripts/generate_text_sections.pl	\
+		-s "${CONFIG_FG_KASLR_SHIFT}" vmlinux.o		\
+		< "${objtree}/${KBUILD_LDS}"			\
+		> .tmp_vmlinux.lds
+}
+
 # Link of vmlinux.o used for section mismatch analysis
 # ${1} output file
 modpost_link()
@@ -155,12 +167,19 @@ vmlinux_link()
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
@@ -182,7 +201,7 @@ vmlinux_link()
 		ldlibs=
 	fi
 
-	ldflags="${ldflags} ${wl}--script=${objtree}/${KBUILD_LDS}"
+	ldflags="${ldflags} ${wl}--script=${lds}"
 
 	# The kallsyms linking does not need debug symbols included.
 	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
@@ -351,6 +370,10 @@ info GEN modules.builtin
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
2.31.1

