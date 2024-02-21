Return-Path: <linux-arch+bounces-2576-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D9785D735
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB420283F6D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D85E47784;
	Wed, 21 Feb 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHzQDN2E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AD46B83
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515377; cv=none; b=BtOGdmAdWHjM8kpxDApv6G2Rbt0r1e4gfqJHyrTfEIZxs24bRrmvpkAgRt0jyXSHQlwY/3S0sqlkGjyutrdjxFZEMAm/pUep5MxdzP1HJiDG1n+xP+1acvb/04W+eo/l9/IGtaEGImweTiZSoAxN2kCQrscVer7yTv3Tw/YwXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515377; c=relaxed/simple;
	bh=9RvLk+Y/2nEp04FCrDQs7qdDqW4evXdzWDP9s3Ohwys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xxejy//dideuwInGaUZEB25aC2PROOGVpC8Bx1K5C9z1WeDmJRfQr5ueDg8YApyfFiS/7goco2dmNtu2fVDVRGgody76nba9LE4MRPUC2b6kfyy1qArS4TfcwIZGKwQzxerYzDLiW2voTd0caH3V2pGemajwIgnzQHrstM6mzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHzQDN2E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607efc8e173so76692097b3.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515374; x=1709120174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0sTN6yoDasV9agD6pu51ddL9MvEfa3HQq1IU+fzHuI=;
        b=nHzQDN2E//v0W3b2dHEtEXRRm1NTgcD0mJdbKJZELZAvEGqc1JhjZCSygxfHf7m+rR
         n4K/8dNsi3OQ2p7Rq7TVZQtqqEVsrpECsgPpptIH7gkHQAO33P/s57uYRH810yaqmUhN
         XiXLGgn+27jFHnGi3d6hWzmIbP/1rIVVjWMNSnCSIBbSGW35Ahhw/6tMkAmG6l4r0bnz
         uYhboSvcp89jQPpoYSg6D3r1AFNCX8/q29DKQ8TMRTMghBklZIHtj3ZcBhzRtvhVkeFL
         MHSWtZU1sZF4H2IG7FnzNT2bQsPF6mGu5ldaB2dJdZhT6j3EEHLdlsPCRCXHiFDnDvdj
         RQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515374; x=1709120174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0sTN6yoDasV9agD6pu51ddL9MvEfa3HQq1IU+fzHuI=;
        b=EUpQtsHrHq+ccgn4g0PHFlYE/VjHHtuoKEGgqjKIEuHHKfuF2wyt6y5dvfNTTn08qg
         0ujqWs1Qgm29pi++cFgyIODOQRhjVYTm45g8vgRm1BMyCgmfRoL0McNzqFQmVWdgHnno
         E/HTZLYV2szKWzpf85wSG7+Yn1uYtzzFt/k30q02Z/CKPUDXYigLPzyF6WQ3AGyc+w9B
         IgPv+eMz0Kp2zG183Zx0Qo5r2Jl/0H7qyGVxlCNg15KjMfNYCLEqaCcETTQhy+xm13Y5
         b31lZzUWiDNrPD5otb5TFSpQtzHoUtLAp9x88KsMdpypFaOH7utlRdiEteKTzwP2NU2O
         siyw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ddvDbfANfCizqA/ApUGs/++fgQu6/aM6dLHAbqOC+3wZjTKsmnOv9A9+1s4oTpxgDli9wTPwv2VRaTsa5Tct2MilSsx7DMR1cA==
X-Gm-Message-State: AOJu0YzbCNUBIcpF//jK5Wo/xGYuhEO1shDni2T2/Ontir82bGt+998N
	Gyy2B5o/CqVIX04uB06pOcsvKio7tYN4IUxnUg4OJPlJ8XWTGMAP2iaAsTgxzK9LI/Qx2g==
X-Google-Smtp-Source: AGHT+IFSSuCpsTsuV51xm151JgnVLEiirYnaEcPmsk653d5XaDVZYtmJquTIptvvhJFVMzyjcTMJVbGB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:c946:0:b0:602:b7ce:f382 with SMTP id
 l67-20020a0dc946000000b00602b7cef382mr3316293ywd.7.1708515374295; Wed, 21 Feb
 2024 03:36:14 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:23 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10347; i=ardb@kernel.org;
 h=from:subject; bh=W61hwMuIbwuGpPHigUY6x0LoOWZL0dAdP6qiyZqzCxY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/W95xu/OveqIrnvltGR6qfaMTjYduQc77eUDJh4Nc
 pKcpV/QUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayr4ThN5uiqViuT2fydCXx
 lXu61aKf7vwtaLSAVyA9JcRPstmijeG/d9fR7tQHnkntrWbi1VosjDMM1n4IkYlb86az6Zf0dXY +AA==
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-34-ardb+git@google.com>
Subject: [PATCH v5 16/16] x86/startup_64: Drop global variables keeping track
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
 arch/x86/boot/compressed/pgtable_64.c   | 12 ------
 arch/x86/boot/compressed/vmlinux.lds.S  |  1 +
 arch/x86/include/asm/pgtable_64_types.h | 43 ++++++++++----------
 arch/x86/kernel/cpu/common.c            |  2 -
 arch/x86/kernel/head64.c                | 33 +--------------
 arch/x86/mm/kasan_init_64.c             |  3 --
 arch/x86/mm/mem_encrypt_identity.c      |  9 ----
 8 files changed, 25 insertions(+), 82 deletions(-)

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
index 9053dfe9fa03..2fac8ba9564a 100644
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
@@ -21,28 +24,24 @@ typedef unsigned long	pgprotval_t;
 typedef struct { pteval_t pte; } pte_t;
 typedef struct { pmdval_t pmd; } pmd_t;
 
-extern unsigned int __pgtable_l5_enabled;
-
-#ifdef CONFIG_X86_5LEVEL
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
 
-extern unsigned int pgdir_shift;
-extern unsigned int ptrs_per_p4d;
+	asm(ALTERNATIVE_TERNARY(
+		"movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
+		%P[feat], "stc", "clc")
+		: [reg] "=&r" (r), CC_OUT(c) (ret)
+		: [feat] "i"  (X86_FEATURE_LA57),
+		  [la57] "i"  (X86_CR4_LA57_BIT)
+		: "cc");
+
+	return ret;
+}
 
 #endif	/* !__ASSEMBLY__ */
 
@@ -53,7 +52,7 @@ extern unsigned int ptrs_per_p4d;
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
-#define PGDIR_SHIFT	pgdir_shift
+#define PGDIR_SHIFT	(pgtable_l5_enabled() ? 48 : 39)
 #define PTRS_PER_PGD	512
 
 /*
@@ -61,7 +60,7 @@ extern unsigned int ptrs_per_p4d;
  */
 #define P4D_SHIFT		39
 #define MAX_PTRS_PER_P4D	512
-#define PTRS_PER_P4D		ptrs_per_p4d
+#define PTRS_PER_P4D		(pgtable_l5_enabled() ? 512 : 1)
 #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE - 1))
 
@@ -76,6 +75,8 @@ extern unsigned int ptrs_per_p4d;
 #define PTRS_PER_PGD		512
 #define MAX_PTRS_PER_P4D	1
 
+#define MAX_POSSIBLE_PHYSMEM_BITS	46
+
 #endif /* CONFIG_X86_5LEVEL */
 
 /*
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
index b33f47489505..348fd69252ac 100644
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
@@ -440,10 +414,7 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
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
index 174a7192c9cb..3da15e9a8c7d 100644
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
2.44.0.rc0.258.g7320e95886-goog


