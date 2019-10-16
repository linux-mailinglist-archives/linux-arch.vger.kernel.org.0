Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410A9D8B68
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 10:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbfJPIlk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 04:41:40 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:52392 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391760AbfJPIlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 04:41:39 -0400
Received: by mail-wm1-f74.google.com with SMTP id m6so670641wmf.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7ROjjIT0dSiqK7weicBG4sWceIh3b0q1ZAIHDJ8V6Dk=;
        b=NSrpYdVj6fvXpFrnYfMPpaxzWB8tZgAHeQar0WnBSBStaLWhUFgVJk9C/oS/EQde3j
         MN4Pu2PiFyorxV2NAx67TfVsuapiiUeipddfWo7q/H/WBwZUnkM+6M8rF64LWI1zqnod
         u5c2hdeezFE94Xt0CqiWPN9JZ+XWZGa2LmHJ17RvhMuYF8jJYNzHYmLp4bSOyQhnLb5n
         wcTS/OQn6cmqiOthUHvG8diywSJRIpleWQFeeW+APiJo3NuWVCMKVB3OAzacpbRddg+g
         eGRi/qTPu5x/ubxado+lIc7l9pv4VKTx9GmOiVRvCsEI/RgIn0MQsYWgNaf1gyqvzMor
         8Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ROjjIT0dSiqK7weicBG4sWceIh3b0q1ZAIHDJ8V6Dk=;
        b=rEBKVi8+8JIvhhrjCKzJZcw1DaVTohwT5MGNGeAHaAXifzO75F64XbUP0DLmPPO1Hw
         TaIdGq5QFOK8103jEDjmzsB69LiQUTqfU9nK4UTXPhx/d+kSFzwXAzItt5nK5cqviRTs
         7YVKiShlzQjwRNi4wVB2FU9X6tVLxu9ioAENC2RyMQ/+v+utwCInSCfvUi9FOw3IxCpG
         /FrO6K0L3y6rkSrYEjkwxBtODH8eqHcHc0sP5g8Cg0GulmdLMqY69JH28H64q+0Xafjy
         8/BaLy/rzhUrcDOd92qQhC3rFL+MldN2PJGChb8oxbPF3QO8NFM6L9CiwkLBsrp9TzF7
         iq6g==
X-Gm-Message-State: APjAAAXI4T+SSYeI+oxn8TwVp8NjxqEb8c+wU4jMj3oXJz0B5PYhIzpS
        NyCnSUv723VRL76cdllLSh7L+J9xyg==
X-Google-Smtp-Source: APXvYqyPTbF4tMvD/+6fq80mlU+ztvS58zl/Ed2jENLqLLVlUfZnkS670w03BnK/IEZ6vSaVSsQZVxJcuQ==
X-Received: by 2002:adf:e983:: with SMTP id h3mr1520622wrm.95.1571215294184;
 Wed, 16 Oct 2019 01:41:34 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:39:59 +0200
In-Reply-To: <20191016083959.186860-1-elver@google.com>
Message-Id: <20191016083959.186860-9-elver@google.com>
Mime-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 8/8] x86, kcsan: Enable KCSAN for x86
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
 arch/x86/Kconfig                      | 1 +
 arch/x86/boot/Makefile                | 1 +
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/entry/vdso/Makefile          | 1 +
 arch/x86/include/asm/bitops.h         | 2 +-
 arch/x86/kernel/Makefile              | 6 ++++++
 arch/x86/kernel/cpu/Makefile          | 3 +++
 arch/x86/lib/Makefile                 | 2 ++
 arch/x86/mm/Makefile                  | 3 +++
 arch/x86/purgatory/Makefile           | 1 +
 arch/x86/realmode/Makefile            | 1 +
 arch/x86/realmode/rm/Makefile         | 1 +
 drivers/firmware/efi/libstub/Makefile | 1 +
 13 files changed, 23 insertions(+), 1 deletion(-)

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
index e2839b5c246c..2f9e928acae6 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -10,6 +10,7 @@
 #
 
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Kernel does not boot with kcov instrumentation here.
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afdd7538..0921689f7c70 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -18,6 +18,7 @@
 #	compressed vmlinux.bin.all + u32 size of vmlinux.bin.all
 
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0f2154106d01..d2cd34d2ac4e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -12,6 +12,7 @@ include $(srctree)/lib/vdso/Makefile
 KBUILD_CFLAGS += $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 7d1f6a49bfae..a36d900960e4 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -201,7 +201,7 @@ arch_test_and_change_bit(long nr, volatile unsigned long *addr)
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
-static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
+static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3578ad248bc9..adccbbfa47e4 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -28,6 +28,12 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 
+KCSAN_SANITIZE_head$(BITS).o				:= n
+KCSAN_SANITIZE_dumpstack.o				:= n
+KCSAN_SANITIZE_dumpstack_$(BITS).o			:= n
+KCSAN_SANITIZE_stacktrace.o				:= n
+KCSAN_SANITIZE_paravirt.o				:= n
+
 OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o	:= y
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index d7a1e5a9331c..7651c4f37e5e 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -3,6 +3,9 @@
 # Makefile for x86-compatible CPU details, features and quirks
 #
 
+KCSAN_SANITIZE_common.o = n
+KCSAN_SANITIZE_perf_event.o = n
+
 # Don't trace early stages of a secondary CPU boot
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_common.o = -pg
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 5246db42de45..4e4b74f525f2 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -5,11 +5,13 @@
 
 # Produces uninteresting flaky coverage.
 KCOV_INSTRUMENT_delay.o	:= n
+KCSAN_SANITIZE_delay.o := n
 
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
index fb4ee5444379..72060744f34f 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -18,6 +18,7 @@ LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefa
 targets += purgatory.ro
 
 KASAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
 KCOV_INSTRUMENT := n
 
 # These are adjustments to the compiler flags used for objects that
diff --git a/arch/x86/realmode/Makefile b/arch/x86/realmode/Makefile
index 682c895753d9..4fc7ce2534dd 100644
--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -7,6 +7,7 @@
 #
 #
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 subdir- := rm
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index f60501a384f9..6f7fbe9dfda6 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -7,6 +7,7 @@
 #
 #
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0460c7581220..a56981286623 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -32,6 +32,7 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
-- 
2.23.0.700.g56cf767bdb-goog

