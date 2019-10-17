Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5ADDAF7D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 16:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439967AbfJQOOD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 10:14:03 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:34830 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439969AbfJQONy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 10:13:54 -0400
Received: by mail-wm1-f74.google.com with SMTP id k9so1236892wmb.0
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C4dnsunAWNHT00RdRPhWuKYLNPc5AUOyg3b62948kqU=;
        b=mYDkEQ8s9nyfgNFH6dyVQNAgzsXlrRV1iBjO1G2mlkdxxfUL1b9pBU2fZj01uKk3xK
         bJSL/XJ78IWTPHDtuuQJZfDwVLdV/DZDh8OWLAyTAJqcQ6RR9mKMlceynqWJyAKRHDrV
         pAdv2SlemLu8wAmizHk2OrRk0ZBfUmbZdNKRJuhMj0pSkKNSK9FPvAviZfBJ4A2Plcvo
         FbxT4oj+W+EZPkYk2lR4RUcqF4CHyosk4dqGUgC6w2jivQkV/1tMZo/6w0U9pJhbYmUZ
         dzBKwmSaWGSfKMH2NDnxD39B+WXuxqgQGRV8K4tjlWUjiGBpzOPoHZnl3nb8UHORf61N
         gvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C4dnsunAWNHT00RdRPhWuKYLNPc5AUOyg3b62948kqU=;
        b=hDJwhmp6eZReDWLrm4OZp8sLb/kt3U1gC2TGmSydG0T3f1rjcPUEIVRCR5GJ0rIF2Q
         TOymKlC3Q/Gc4x4ygN+Pot7XYNdZkKiZTxZ8H1SWRCEcFXV+Js7KJibCzaTcpfGlbmaJ
         Ayv0pE79FNbRcd4IkoqB64CC4fMWOl0isXgHwT77i3tvYYo1jdPwUNcx3kmtawKvdUAo
         2rycqXiSlrYsjjJ5I62tp/SuYPgujv0D0cA4rlW47CWLVjtwkDXcOXFFa+JDJVDq96mq
         AiiStwNr1ipJTxdCqY8cEFIUPZ05k0fLDN6307E1ytFtOneGWVuMEdFq8Oybb8I9D/zk
         JQUw==
X-Gm-Message-State: APjAAAVYik6BFkjUEv11DuaNDzpBQY3dk34wsZviVtDDv9q54ZLL2YhM
        GvRdKYYvREYqw/r8g6bHLCtE+aZ/tA==
X-Google-Smtp-Source: APXvYqwRrm7mSLgK02eK8Gmh7tMc4aMZPJHDzATL1Tbd4StzBgi/Gl/z1DGR6sft7R44frqI0MAEbmcDTw==
X-Received: by 2002:a5d:674e:: with SMTP id l14mr3127939wrw.45.1571321631237;
 Thu, 17 Oct 2019 07:13:51 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:13:05 +0200
In-Reply-To: <20191017141305.146193-1-elver@google.com>
Message-Id: <20191017141305.146193-9-elver@google.com>
Mime-Version: 1.0
References: <20191017141305.146193-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 8/8] x86, kcsan: Enable KCSAN for x86
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch enables KCSAN for x86, with updates to build rules to not use
KCSAN for several incompatible compilation units.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Document build exceptions where no previous above comment explained
  why we cannot instrument.
---
 arch/x86/Kconfig                      | 1 +
 arch/x86/boot/Makefile                | 2 ++
 arch/x86/boot/compressed/Makefile     | 2 ++
 arch/x86/entry/vdso/Makefile          | 3 +++
 arch/x86/include/asm/bitops.h         | 6 +++++-
 arch/x86/kernel/Makefile              | 7 +++++++
 arch/x86/kernel/cpu/Makefile          | 3 +++
 arch/x86/lib/Makefile                 | 4 ++++
 arch/x86/mm/Makefile                  | 3 +++
 arch/x86/purgatory/Makefile           | 2 ++
 arch/x86/realmode/Makefile            | 3 +++
 arch/x86/realmode/rm/Makefile         | 3 +++
 drivers/firmware/efi/libstub/Makefile | 2 ++
 13 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa28c58..81859be4a005 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -226,6 +226,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select HAVE_ARCH_KCSAN if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index e2839b5c246c..9c7942794164 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -9,7 +9,9 @@
 # Changed by many, many contributors over the years.
 #
 
+# Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Kernel does not boot with kcov instrumentation here.
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afdd7538..a1c248b8439f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -17,7 +17,9 @@
 #	(see scripts/Makefile.lib size_append)
 #	compressed vmlinux.bin.all + u32 size of vmlinux.bin.all
 
+# Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0f2154106d01..a23debaad5b9 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -10,8 +10,11 @@ ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
 include $(srctree)/lib/vdso/Makefile
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 7d1f6a49bfae..ee08917d3d92 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -201,8 +201,12 @@ arch_test_and_change_bit(long nr, volatile unsigned long *addr)
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
-static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
+static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
+	/*
+	 * Because this is a plain access, we need to disable KCSAN here to
+	 * avoid double instrumentation via bitops-instrumented.h.
+	 */
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3578ad248bc9..2aa122d94956 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -28,6 +28,13 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 
+# Do not instrument early boot code.
+KCSAN_SANITIZE_head$(BITS).o				:= n
+# Do not instrument debug code to avoid corrupting bug reporting.
+KCSAN_SANITIZE_dumpstack.o				:= n
+KCSAN_SANITIZE_dumpstack_$(BITS).o			:= n
+KCSAN_SANITIZE_stacktrace.o				:= n
+
 OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o	:= y
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index d7a1e5a9331c..1f1b0edc0187 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -13,6 +13,9 @@ endif
 KCOV_INSTRUMENT_common.o := n
 KCOV_INSTRUMENT_perf_event.o := n
 
+# As above, instrumenting secondary CPU boot code causes boot hangs.
+KCSAN_SANITIZE_common.o := n
+
 # Make sure load_percpu_segment has no stackprotector
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_common.o		:= $(nostackp)
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 5246db42de45..432a07705677 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -6,10 +6,14 @@
 # Produces uninteresting flaky coverage.
 KCOV_INSTRUMENT_delay.o	:= n
 
+# KCSAN uses udelay for introducing watchpoint delay; avoid recursion.
+KCSAN_SANITIZE_delay.o := n
+
 # Early boot use of cmdline; don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
 KCOV_INSTRUMENT_cmdline.o := n
 KASAN_SANITIZE_cmdline.o  := n
+KCSAN_SANITIZE_cmdline.o  := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_cmdline.o = -pg
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 84373dc9b341..ee871602f96a 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -7,6 +7,9 @@ KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 
+KCSAN_SANITIZE_mem_encrypt.o		:= n
+KCSAN_SANITIZE_mem_encrypt_identity.o	:= n
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index fb4ee5444379..69379bce9574 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -17,7 +17,9 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
 KCOV_INSTRUMENT := n
 
 # These are adjustments to the compiler flags used for objects that
diff --git a/arch/x86/realmode/Makefile b/arch/x86/realmode/Makefile
index 682c895753d9..6b1f3a4eeb44 100644
--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -6,7 +6,10 @@
 # for more details.
 #
 #
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 subdir- := rm
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index f60501a384f9..fdbbb945c216 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -6,7 +6,10 @@
 # for more details.
 #
 #
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0460c7581220..693d0a94b118 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -31,7 +31,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__DISABLE_EXPORTS
 
 GCOV_PROFILE			:= n
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
-- 
2.23.0.866.gb869b98d4c-goog

