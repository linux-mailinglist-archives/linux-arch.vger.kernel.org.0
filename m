Return-Path: <linux-arch+bounces-2295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D28530CA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8876328A729
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BD54F8B;
	Tue, 13 Feb 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRfgM7yY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130654BE2
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828149; cv=none; b=AkQO9t4SWz5ogim1JwwIBi8bRrAwtss7c+iAwu4uIvnQ11BOeYe5LLU30bXL/8UjebZzfuuaLS3m3D5KMzCHcBvKrAH/QUZGdGNAQZqN5x04ii4eT2+p7emMmwTlvNh6Dto4LUpMkH2JvHK40kkaPnTeI0CEmBQy9eKrlJRhGBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828149; c=relaxed/simple;
	bh=rh+KrQSf0b7lqlGXVSURT3xNxNpwVXF3RneXnbnQKA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BXH+gpJYhYrDYzISLjkYBgHgSbADsVzMuSFIB6QK0sXqGKY/M1s++g/utyMNosdaMt0xiEPGVU2k92zzWvy/pS1SbpY4mJfh3KVxELn9suW9cUNQjF8JgUDoWjaO/6v1OBoyqhsby5OjgKpaKlAG4d3YAOSbUGNWQM9pOxo7oP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRfgM7yY; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-410e99e25a9so3930675e9.3
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 04:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828146; x=1708432946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vFuPudIhOhGYqZnhT5ckh2P37048hBhXa1jox3ZGCc=;
        b=MRfgM7yYvgtxGf3DgibcVC5NsI2HNCbGPI2g2khZXJ0IM+zG/9wimAh1kRhvhbiIvG
         oIZpv+XiALLQUtfOeKU8gJ9AN7A9DQlvvMr2VlBRn+yTMAcB8to945plKbqMbe2AUA3J
         YNb0t1BRxoQxHhL3axUKTv2LT746ykS7JFUZaKTrXZ/GVKwQS35ezF8GMVlnYr57Sr5u
         qJ2C4kLZ9uC9IgmjV3/l43XmPxFxK8qsu2RJhdFwy2nQfEQcuyUGGw1pVUuAQUhxQrC4
         2cH3n790yXCVG26awdUrOVa2AbfLVY8ITgk7g8Ec8qCFoulnu/OHd92p2RCGby7yRWO+
         3Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828146; x=1708432946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vFuPudIhOhGYqZnhT5ckh2P37048hBhXa1jox3ZGCc=;
        b=vALVFV4Zpov8VfoLV7P/QcudFm2sqCQ/k5m257Mgr1aQwibVkflbBa28zMvd8XrWe5
         mU6GbYVqbFV5FMOpPkWXyA+TJIUCkGykeEuyKhXtN8HnU2ttUS3UUKW3tWPxgI9S42km
         +fX+eK5mu6fGqb1pTrNTaeh0piwmZF+qLFRphYBcNV+Q2kHSSgDTt8LmhzbXJ0cPPQ5R
         OfMlZ91RhW10V8qlvZ9NQSTZaAFksYXf3GzuzX/6uWIn8vrVVHYjVYF7xYniTXKXcsi5
         URwgT1Z022Ncypt8Tk6wEbTXZZcDnwP+iD86+MOuxqTZpoHJ12t1nxNgbutVizbA9O5U
         Ondg==
X-Forwarded-Encrypted: i=1; AJvYcCXnUv4rUTG0jOOy7dopszwYiRLzVZ9fvrHs4wh9+YF5EsDTreMa6ipadeZNA/wIysyyWBiWRfGTdKAWbxjBodrA34TsCT6iV87ifw==
X-Gm-Message-State: AOJu0YzojvrwNlbDblPTJEb7Lg80hpguU4k9RWycHWlVgnMajsUkFc5Y
	q55VI1pUK08VvTwoTrfiCwndFjsOo7mn7UO4W/BnDmkvHHJGPaiOp5AywcwruX8TkEqB6A==
X-Google-Smtp-Source: AGHT+IFszoOKN6JLHtofQFLA4WFXrcVonVG9B/lEyTsCvSmmLVPMSC07ced1LbM49VuO+fqBB9TEcxPU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:c89:b0:411:d2c4:5998 with SMTP id
 fj9-20020a05600c0c8900b00411d2c45998mr6065wmb.6.1707828146355; Tue, 13 Feb
 2024 04:42:26 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:55 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10523; i=ardb@kernel.org;
 h=from:subject; bh=9YEkQOcO7b0gYqcHXm2fnYoXEzE3Uz6Y26otXMUNnOQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV08pQ1PwyXtqyf8nCBSezmoPWz3d4/Xvl6870Z8Xvms
 ZTx/LYT6ShlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQAT+cbI8E9nja/NA3/bL3OU
 8x09nJ6dTVs9MWjmLJtjZptZHvLVhIQw/DNfu1znrZ8CL0PBOs4zHy/aiUvUaV942/NpU4/+1Ry Lm9wA
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-24-ardb+git@google.com>
Subject: [PATCH v4 11/11] x86/startup_64: Drop global variables keeping track
 of LA57 state
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

On x86_64, the core kernel is entered in long mode, which implies that
paging is enabled. This means that the CR4.LA57 control bit is
guaranteed to be in sync with the number of paging levels used by the
kernel, and there is no need to store this in a variable.

There is also no need to use variables for storing the calculations of
pgdir_shift and ptrs_per_p4d, as they are easily determined on the fly.

This removes the need for two different sources of truth for determining
whether 5-level paging is in use: CR4.LA57 always reflects the actual
state, and never changes from the point of view of the 64-bit core
kernel. The only potential concern is the cost of CR4 accesses, which
can be mitigated using alternatives patching based on feature detection.

Note that even the decompressor does not manipulate any page tables
before updating CR4.LA57, so it can also avoid the associated global
variables entirely. However, as it does not implement alternatives
patching, the associated ELF sections need to be discarded.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.h         |  4 --
 arch/x86/boot/compressed/pgtable_64.c   | 12 ----
 arch/x86/boot/compressed/vmlinux.lds.S  |  1 +
 arch/x86/include/asm/pgtable_64_types.h | 58 ++++++++------------
 arch/x86/kernel/cpu/common.c            |  2 -
 arch/x86/kernel/head64.c                | 33 +----------
 arch/x86/mm/kasan_init_64.c             |  3 -
 arch/x86/mm/mem_encrypt_identity.c      |  9 ---
 8 files changed, 27 insertions(+), 95 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index bc2f0f17fb90..2b15ddd0e177 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -16,9 +16,6 @@
 
 #define __NO_FORTIFY
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 /*
  * Boot stub deals with identity mappings, physical and virtual addresses are
  * the same, so override these defines.
@@ -178,7 +175,6 @@ static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
 
 /* ident_map_64.c */
-extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
 extern void kernel_add_identity_map(unsigned long start, unsigned long end);
 
 /* Used by PAGE_KERN* macros: */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 51f957b24ba7..ae72f53f5e77 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -9,13 +9,6 @@
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
-#ifdef CONFIG_X86_5LEVEL
-/* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
-unsigned int __section(".data") __pgtable_l5_enabled;
-unsigned int __section(".data") pgdir_shift = 39;
-unsigned int __section(".data") ptrs_per_p4d = 1;
-#endif
-
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
@@ -125,11 +118,6 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
 		l5_required = true;
-
-		/* Initialize variables for 5-level paging */
-		__pgtable_l5_enabled = 1;
-		pgdir_shift = 48;
-		ptrs_per_p4d = 512;
 	}
 
 	/*
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 083ec6d7722a..06358bb067fe 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -81,6 +81,7 @@ SECTIONS
 		*(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
 		*(.hash) *(.gnu.hash)
 		*(.note.*)
+		*(.altinstructions .altinstr_replacement)
 	}
 
 	.got.plt (INFO) : {
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 38b54b992f32..6a57bfdff52b 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -6,7 +6,10 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <asm/alternative.h>
+#include <asm/cpufeatures.h>
 #include <asm/kaslr.h>
+#include <asm/processor-flags.h>
 
 /*
  * These are used to make use of C type-checking..
@@ -21,63 +24,50 @@ typedef unsigned long	pgprotval_t;
 typedef struct { pteval_t pte; } pte_t;
 typedef struct { pmdval_t pmd; } pmd_t;
 
-#ifdef CONFIG_X86_5LEVEL
-extern unsigned int __pgtable_l5_enabled;
-
-#ifdef USE_EARLY_PGTABLE_L5
-/*
- * cpu_feature_enabled() is not available in early boot code.
- * Use variable instead.
- */
-static inline bool pgtable_l5_enabled(void)
+static __always_inline __pure bool pgtable_l5_enabled(void)
 {
-	return __pgtable_l5_enabled;
-}
-#else
-#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
-#endif /* USE_EARLY_PGTABLE_L5 */
+	unsigned long r;
+	bool ret;
 
-#else
-#define pgtable_l5_enabled() 0
-#endif /* CONFIG_X86_5LEVEL */
+	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+		return false;
+
+	asm(ALTERNATIVE_TERNARY(
+		"movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
+		%P[feat], "stc", "clc")
+		: [reg] "=&r" (r), CC_OUT(c) (ret)
+		: [feat] "i"  (X86_FEATURE_LA57),
+		  [la57] "i"  (X86_CR4_LA57_BIT)
+		: "cc");
 
-extern unsigned int pgdir_shift;
-extern unsigned int ptrs_per_p4d;
+	return ret;
+}
 
 #endif	/* !__ASSEMBLY__ */
 
 #define SHARED_KERNEL_PMD	0
 
-#ifdef CONFIG_X86_5LEVEL
-
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
-#define PGDIR_SHIFT	pgdir_shift
+#define PGDIR_SHIFT	(pgtable_l5_enabled() ? 48 : 39)
 #define PTRS_PER_PGD	512
 
 /*
  * 4th level page in 5-level paging case
  */
 #define P4D_SHIFT		39
+#ifdef CONFIG_X86_5LEVEL
 #define MAX_PTRS_PER_P4D	512
-#define PTRS_PER_P4D		ptrs_per_p4d
+#else
+#define MAX_PTRS_PER_P4D	1
+#endif
+#define PTRS_PER_P4D		(pgtable_l5_enabled() ? 512 : 1)
 #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE - 1))
 
 #define MAX_POSSIBLE_PHYSMEM_BITS	52
 
-#else /* CONFIG_X86_5LEVEL */
-
-/*
- * PGDIR_SHIFT determines what a top-level page table entry can map
- */
-#define PGDIR_SHIFT		39
-#define PTRS_PER_PGD		512
-#define MAX_PTRS_PER_P4D	1
-
-#endif /* CONFIG_X86_5LEVEL */
-
 /*
  * 3rd level page
  */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9e35e276c55a..d88e4be88868 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
 
 #include <linux/memblock.h>
 #include <linux/linkage.h>
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4bcbd4ae2dc6..aee99cfda4eb 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -7,9 +7,6 @@
 
 #define DISABLE_BRANCH_PROFILING
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/types.h>
@@ -52,14 +49,6 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
-#ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled __ro_after_init;
-unsigned int pgdir_shift __ro_after_init = 39;
-EXPORT_SYMBOL(pgdir_shift);
-unsigned int ptrs_per_p4d __ro_after_init = 1;
-EXPORT_SYMBOL(ptrs_per_p4d);
-#endif
-
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
@@ -78,21 +67,6 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
-static inline bool check_la57_support(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
-		return false;
-
-	/*
-	 * 5-level paging is detected and enabled at kernel decompression
-	 * stage. Only check if it has been enabled there.
-	 */
-	if (!(native_read_cr4() & X86_CR4_LA57))
-		return false;
-
-	return true;
-}
-
 static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
 	unsigned long vaddr, vaddr_end;
@@ -155,7 +129,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	bool la57;
 	int i;
 
-	la57 = check_la57_support();
+	la57 = pgtable_l5_enabled();
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -438,10 +412,7 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
-	if (check_la57_support()) {
-		__pgtable_l5_enabled	= 1;
-		pgdir_shift		= 48;
-		ptrs_per_p4d		= 512;
+	if (pgtable_l5_enabled()) {
 		page_offset_base	= __PAGE_OFFSET_BASE_L5;
 		vmalloc_base		= __VMALLOC_BASE_L5;
 		vmemmap_base		= __VMEMMAP_BASE_L5;
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0302491d799d..85ae1ef840cc 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -2,9 +2,6 @@
 #define DISABLE_BRANCH_PROFILING
 #define pr_fmt(fmt) "kasan: " fmt
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/memblock.h>
 #include <linux/kasan.h>
 #include <linux/kdebug.h>
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 64b5005d49e5..a857945af177 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -27,15 +27,6 @@
 #undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 
-/*
- * This code runs before CPU feature bits are set. By default, the
- * pgtable_l5_enabled() function uses bit X86_FEATURE_LA57 to determine if
- * 5-level paging is active, so that won't work here. USE_EARLY_PGTABLE_L5
- * is provided to handle this situation and, instead, use a variable that
- * has been set by the early boot code.
- */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
-- 
2.43.0.687.g38aa6559b0-goog


