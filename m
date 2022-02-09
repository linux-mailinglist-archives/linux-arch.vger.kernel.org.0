Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568854AFCB3
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiBITBv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:01:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbiBITAz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:00:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E341C03E979;
        Wed,  9 Feb 2022 11:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433251; x=1675969251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PTeOZ6wKDX3cB7PGjpgNbRHEUmYTEIk9wVKxU4z6mig=;
  b=A6HZ/AyENUBNJ+JS7jCHJgJOHYWosLJyRSjirJl5NAlo5hC8Lin/tbGT
   rbGjKsDIW7UT233t3uqe3df4VuFRo4yHqLf3FfMu7BM2SD7h+9moT0bAU
   RXXe2nu27wYPVHrBjyZbiFDQDIF3g4iyItd7OXhXPeoSRn37vkoXMMnf2
   OAI876341PR/PmabGgXBO0U3K5+xTb1yW+QnBDsx8jSKKQEbmqCwa4Oom
   /iwpk+doQSDzXK1kAjdyKUj44ZheSaGo4mkcjRG7CiXYTw7g967+r7pvG
   X8VVCLHpdRqljeZxt/z2OBH9pDt1RsBW7QpCA3zicx0VqkxLm18FXQIW0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="232869414"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="232869414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:59:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701372275"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2022 10:59:09 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQX031082;
        Wed, 9 Feb 2022 18:59:07 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v10 10/15] FG-KASLR: use a scripted approach to handle .text.* sections
Date:   Wed,  9 Feb 2022 19:57:47 +0100
Message-Id: <20220209185752.1226407-11-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

We also keep tracking the maximum alignment we found while
traversing through the readelf output and the number of times we
spotted it. It's actual only for values >= 128 and is required to
reserve some space between the last .text.* section and the _etext
marker.
The reason is that e.g. x86 has at least 3 asm sections (4 with
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
 scripts/link-vmlinux.sh           |  30 +++++-
 5 files changed, 217 insertions(+), 2 deletions(-)
 create mode 100755 scripts/generate_text_sections.pl

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 54f16801e9d6..06ba33f5bc58 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -146,9 +146,11 @@ SECTIONS
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
index 26f9a6e52dbd..5fbd1c294df4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2076,6 +2076,20 @@ config FG_KASLR
 
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
index 000000000000..999e1b68181f
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
+# Copyright (C) 2021-2022, Intel Corporation.
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
+## (which aligns every function to 64b) would explode the $count then
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
+	## If we have asm function sections, we shouldn't have anything
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
+	## If we have text sections aligned with 128 bytes or more, make
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
index 666f7bbc13eb..701cf540c12e 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -70,6 +70,23 @@ gen_symversions()
 	done
 }
 
+# If CONFIG_FG_KASLR is selected, generate a linker script which will
+# declare all custom text sections for future boottime shuffling
+gen_text_sections()
+{
+	local shift=$(sed -n 's/^CONFIG_FG_KASLR_SHIFT=\(.*\)$/\1/p' include/config/auto.conf)
+	local assert=""
+
+	is_enabled CONFIG_HAVE_ASM_FUNCTION_SECTIONS && assert="-a"
+
+	info GEN .tmp_vmlinux.lds
+
+	${PERL} ${srctree}/scripts/generate_text_sections.pl	\
+		${assert} -s "${shift}" vmlinux.o		\
+		< "${objtree}/${KBUILD_LDS}"			\
+		> .tmp_vmlinux.lds
+}
+
 # Link of vmlinux.o used for section mismatch analysis
 # ${1} output file
 modpost_link()
@@ -162,12 +179,19 @@ vmlinux_link()
 	local ld
 	local ldflags
 	local ldlibs
+	local lds
 
 	info LD ${output}
 
 	# skip output file argument
 	shift
 
+	if is_enabled CONFIG_FG_KASLR; then
+		lds=".tmp_vmlinux.lds"
+	else
+		lds="${objtree}/${KBUILD_LDS}"
+	fi
+
 	if is_enabled CONFIG_LTO_CLANG; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
@@ -189,7 +213,7 @@ vmlinux_link()
 		ldlibs=
 	fi
 
-	ldflags="${ldflags} ${wl}--script=${objtree}/${KBUILD_LDS}"
+	ldflags="${ldflags} ${wl}--script=${lds}"
 
 	# The kallsyms linking does not need debug symbols included.
 	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
@@ -346,6 +370,10 @@ info GEN modules.builtin
 tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
 	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
 
+if is_enabled CONFIG_FG_KASLR; then
+	gen_text_sections
+fi
+
 btf_vmlinux_bin_o=""
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
-- 
2.34.1

