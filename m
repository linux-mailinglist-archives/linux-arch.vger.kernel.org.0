Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5453D466CEA
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349420AbhLBWhL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 17:37:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:47741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243146AbhLBWgq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Dec 2021 17:36:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236669315"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="236669315"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:33:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="576948161"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 02 Dec 2021 14:33:15 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B2MWmYe028552;
        Thu, 2 Dec 2021 22:33:12 GMT
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
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v8 13/14] Documentation: add documentation for FG-KASLR
Date:   Thu,  2 Dec 2021 23:32:13 +0100
Message-Id: <20211202223214.72888-14-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202223214.72888-1-alexandr.lobakin@intel.com>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Describe the main principles behind the FG-KASLR hardening feature
in a new doc section.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/security/fgkaslr.rst            | 172 ++++++++++++++++++
 Documentation/security/index.rst              |   1 +
 3 files changed, 179 insertions(+)
 create mode 100644 Documentation/security/fgkaslr.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d4..3940b8610140 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2224,6 +2224,12 @@
 			kernel and module base offset ASLR (Address Space
 			Layout Randomization).
 
+	nofgkaslr	[KNL]
+			When CONFIG_FG_KASLR is set, this parameter
+			disables kernel function granular ASLR
+			(Address Space Layout Randomization).
+			See Documentation/security/fgkaslr.rst.
+
 	kasan_multi_shot
 			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
 			report on every invalid memory access. Without this
diff --git a/Documentation/security/fgkaslr.rst b/Documentation/security/fgkaslr.rst
new file mode 100644
index 000000000000..50dc24f675b5
--- /dev/null
+++ b/Documentation/security/fgkaslr.rst
@@ -0,0 +1,172 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================================
+Function Granular Kernel Address Space Layout Randomization (fgkaslr)
+=====================================================================
+
+:Date: 6 April 2020
+:Author: Kristen Accardi
+
+Kernel Address Space Layout Randomization (KASLR) was merged into the kernel
+with the objective of increasing the difficulty of code reuse attacks. Code
+reuse attacks reused existing code snippets to get around existing memory
+protections. They exploit software bugs which expose addresses of useful code
+snippets to control the flow of execution for their own nefarious purposes.
+KASLR as it was originally implemented moves the entire kernel code text as a
+unit at boot time in order to make addresses less predictable. The order of the
+code within the segment is unchanged - only the base address is shifted. There
+are a few shortcomings to this algorithm.
+
+1. Low Entropy - there are only so many locations the kernel can fit in. This
+   means an attacker could guess without too much trouble.
+2. Knowledge of a single address can reveal the offset of the base address,
+   exposing all other locations for a published/known kernel image.
+3. Info leaks abound.
+
+Finer grained ASLR has been proposed as a way to make ASLR more resistant
+to info leaks. It is not a new concept at all, and there are many variations
+possible. Function reordering is an implementation of finer grained ASLR
+which randomizes the layout of an address space on a function level
+granularity. The term "fgkaslr" is used in this document to refer to the
+technique of function reordering when used with KASLR, as well as finer grained
+KASLR in general.
+
+The objective of this patch set is to improve a technology that is already
+merged into the kernel (KASLR). This code will not prevent all code reuse
+attacks, and should be considered as one of several tools that can be used.
+
+Implementation Details
+======================
+
+The over-arching objective of the fgkaslr implementation is incremental
+improvement over the existing KASLR algorithm. It is designed to work with
+the existing solution, and there are two main area where code changes occur:
+Build time, and Load time.
+
+Build time
+----------
+
+GCC has had an option to place functions into individual .text sections
+for many years now (-ffunction-sections). This option is used to implement
+function reordering at load time. The final compiled vmlinux retains all the
+section headers, which can be used to help find the address ranges of each
+function. Using this information and an expanded table of relocation addresses,
+individual text sections can be shuffled immediately after decompression.
+Some data tables inside the kernel that have assumptions about order
+require sorting after the update. In order to modify these tables,
+a few key symbols from the objcopy symbol stripping process are preserved
+for use after shuffling the text segments. Any special input sections which are
+defined by the kernel build process and collected into the .text output
+segment are left unmodified and will still be present inside the .text segment,
+unrandomized other than normal base address randomization.
+
+Load time
+---------
+
+The boot kernel was modified to parse the vmlinux elf file after
+decompression to check for symbols for modifying data tables, and to
+look for any .text.* sections to randomize. The sections are then shuffled,
+and tables are updated or resorted. The existing code which updated relocation
+addresses was modified to account for not just a fixed delta from the load
+address, but the offset that the function section was moved to. This requires
+inspection of each address to see if it was impacted by a randomization.
+
+In order to hide the new layout, symbols reported through /proc/kallsyms will
+be displayed in a random order.
+
+Performance Impact
+==================
+
+There are two areas where function reordering can impact performance: boot
+time latency, and run time performance.
+
+Boot time latency
+-----------------
+
+This implementation of finer grained KASLR impacts the boot time of the kernel
+in several places. It requires additional parsing of the kernel ELF file to
+obtain the section headers of the sections to be randomized. It calls the
+random number generator for each section to be randomized to determine that
+section's new memory location. It copies the decompressed kernel into a new
+area of memory to avoid corruption when laying out the newly randomized
+sections. It increases the number of relocations the kernel has to perform at
+boot time vs. standard KASLR, and it also requires a lookup on each address
+that needs to be relocated to see if it was in a randomized section and needs
+to be adjusted by a new offset. Finally, it re-sorts a few data tables that
+are required to be sorted by address.
+
+Booting a test VM on a modern, well appointed system showed an increase in
+latency of approximately 1 second.
+
+Run time
+--------
+
+The performance impact at run-time of function reordering varies by workload.
+Randomly reordering the functions will cause an increase in cache misses
+for some workloads. Some workloads perform significantly worse under FGKASLR,
+while others stay the same or even improve. In general, it will depend on the
+code flow whether or not finer grained KASLR will impact a workload, and how
+the underlying code was designed. Because the layout changes per boot, each
+time a system is rebooted the performance of a workload may change.
+
+Image Size
+==========
+
+fgkaslr increases the size of the kernel binary due to the extra section
+headers that are included, as well as the extra relocations that need to
+be added. You can expect fgkaslr to increase the size of the resulting
+vmlinux by about 3%, and the compressed image (bzImage) by 15%.
+
+Memory Usage
+============
+
+fgkaslr increases the amount of heap that is required at boot time,
+although this extra memory is released when the kernel has finished
+decompression. As a result, it may not be appropriate to use this feature
+on systems without much memory.
+
+Building
+========
+
+To enable fine grained KASLR, you need to have the following config options
+set (including all the ones you would use to build normal KASLR)
+
+``CONFIG_FG_KASLR=y``
+
+fgkaslr for the kernel is only supported for the X86_64 architecture.
+
+Modules
+=======
+
+Modules are randomized similarly to the rest of the kernel by shuffling
+the sections at load time prior to moving them into memory. The module must
+also have been build with the -ffunction-sections compiler option.
+
+Although fgkaslr for the kernel is only supported for the X86_64 architecture,
+it is possible to use fgkaslr with modules on other architectures. To enable
+this feature, select the following config option:
+
+``CONFIG_MODULE_FG_KASLR``
+
+This option is selected automatically for X86_64 when CONFIG_FG_KASLR is set.
+
+Disabling
+=========
+
+Disabling normal kaslr using the nokaslr command line option also disables
+fgkaslr. In addition, it is possible to disable fgkaslr separately by booting
+with "nofgkaslr" on the commandline.
+
+Further Information
+===================
+
+There are a lot of academic papers which explore finer grained ASLR.
+This paper in particular contributed significantly to the implementation design.
+
+Selfrando: Securing the Tor Browser against De-anonymization Exploits,
+M. Conti, S. Crane, T. Frassetto, et al.
+
+For more information on how function layout impacts performance, see:
+
+Optimizing Function Placement for Large-Scale Data-Center Applications,
+G. Ottoni, B. Maher
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 16335de04e8c..41444124090f 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -7,6 +7,7 @@ Security Documentation
 
    credentials
    IMA-templates
+   fgkaslr
    keys/index
    lsm
    lsm-development
-- 
2.33.1

