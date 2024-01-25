Return-Path: <linux-arch+bounces-1567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6883C0F2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF89B23089
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66945C0B;
	Thu, 25 Jan 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwMLQVLV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B54502A
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182369; cv=none; b=gLiIINdYwas1ZGrj2DelqL5qLXWDqsrGYEbX7gGEKJt6x51m5VO6O3DJzWOrk8RTH1UYshg/dJHns9RuiNS77Y0mpQ4K6SQWNA5K5cLa+cs1XeOiaQmK8oECJBAyA5JegDythevhBeUMSBhlBsiHG3zA5aVsGk9nhMMiqFJyGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182369; c=relaxed/simple;
	bh=EKses+iAL1UalTo7h086P7oqMox/oN2hrVZ5jU93KrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DY14lDfkVwviowMKUuRE+PYlEEV0A578Yfii3ZddPnmvSXO9sB7sLSOYo6BACrIlziFsHWzdXiWwq73RmvOul6JXn9/z5H5Qnm1XG8LW4P3g/608eNbUD/HIq6uA1y80q7jUvmKyqeW0LEo+XAEjn50d1pSWn6skVZxIm5KZSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwMLQVLV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc2284779caso7564679276.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182367; x=1706787167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnt2FLKZgiwEBYPehLp29kLTMnOKVwtNBBB/C6C+Er8=;
        b=kwMLQVLVI3r2POP1CxwjAUn10vQY1N88eWSfsrEvzljcBrE/nnGm+9VKB44FLYm/5A
         P2LqNHftlCsvCREn9Cot3Qyy4a1Zbw6V+cqsnWzuNo0ltbOnjq6q/w0EFWAgm40+UwbU
         L0OxGebMCnteWhg6b3Hxgk3gOp6P4/yjdeoPnX2OjeY7PTwkp+lzPHkTLJaLw6kI9nzB
         NL7mWawFOqZPR3vtV496a30uorAC4A1nsI1t07OxD7IiQxxCIz0lX4C05KjC8z7ABlUi
         YN5XP8I6FzuWyNv31Nq/O4i+tZ8Mug5OixBtPup7GLbiU0wWMscW6F+Y5M3JaTHMYj5T
         3hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182367; x=1706787167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnt2FLKZgiwEBYPehLp29kLTMnOKVwtNBBB/C6C+Er8=;
        b=klB7/4pNV1uY1DEOQLZUDnLFyQYhE2zp+Ivx6AiVM29QtH5OlOmmDEXVLEPYFYzOCA
         zgaPsW9Po+87dnHls9fZfLpLyQlo74ryjb3IBJPhbQY42o+AgA3pGbMEc8kGN2SjZUvU
         /helXom7rfx5FmXBMy3Py9RcpptQc6LC/Ft+aee0hwKF3NChdSKzZxGzpQqnPZ+/tNpC
         N8Q5f2JP+kj0a9IfXNxI//vUC7GwgLkuxiMGStl2IpWNYAi6bRTo8lVKAB6XQlfrB/8l
         4/h6HwSwLt19rkzAM8XaOjH/730M3sowmpv7kK3sm+OS+h4vhdJn8+Dhvlt827bbQ7fz
         p/rQ==
X-Gm-Message-State: AOJu0YxECsH0fuTIZiB71KZn+HQ2NqkawyhVL29InNM6MmKOPDNlYtzE
	gfjmHlIIBYB/Pscxc9imtfsmIcVDpNgqRbEn9MaZr52TWFPdoYk+XuQDxldHW0EkM4l0FA==
X-Google-Smtp-Source: AGHT+IEgj0jVG/r+L2YTZT5AgiYzvaqxof1w95YjxAlnWrBAjXcvZY8fIbdK5wQkQPkM1EFxmwkwYZGu
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5b:ece:0:b0:dc6:207d:7797 with SMTP id
 a14-20020a5b0ece000000b00dc6207d7797mr60231ybs.3.1706182367074; Thu, 25 Jan
 2024 03:32:47 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:23 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7926; i=ardb@kernel.org;
 h=from:subject; bh=3eah7XU3z29gWglaF/LixaexnChg/lgSOeC5moLmsUE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT6133PIb1SfHPmS+aX/j2c+EPb78zV5keLtcujM/lu
 OX9d71oRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjItz5Ghmlf//zyvLg17Yjh
 lNeSDW815f558k0o/XrmxLWJlZfv8rAzMlyqefc15QXLc5t1eSdreD3LO3446/yZJX9m2a582QO RK/kA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-23-ardb+git@google.com>
Subject: [PATCH v2 04/17] x86/startup_64: Drop global variables to keep track
 of LA57 state
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

On x86_64, the core kernel is entered in long mode, which implies that
paging is enabled. This means that the CR4.LA57 control bit is
guaranteed to be in sync with the number of paging levels used by the
kernel, and there is no need to store this in a variable.

There is also no need to use variables for storing the calculations of
pgdir_shift and ptrs_per_p4d, as they are easily determined on the fly.
Other assignments of global variables related to the number of paging
levels can be deferred to the primary C entrypoint that actually runs
from the kernel virtual mapping.

This removes the need for writing to __ro_after_init from the code that
executes extremely early via the 1:1 mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/pgtable_64.c   |  2 -
 arch/x86/include/asm/pgtable_64_types.h | 15 +++---
 arch/x86/kernel/cpu/common.c            |  2 -
 arch/x86/kernel/head64.c                | 52 ++++----------------
 arch/x86/mm/kasan_init_64.c             |  3 --
 arch/x86/mm/mem_encrypt_identity.c      |  9 ----
 6 files changed, 15 insertions(+), 68 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 51f957b24ba7..0586cc216aa6 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -128,8 +128,6 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 
 		/* Initialize variables for 5-level paging */
 		__pgtable_l5_enabled = 1;
-		pgdir_shift = 48;
-		ptrs_per_p4d = 512;
 	}
 
 	/*
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 38b54b992f32..ecc010fbb377 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -22,28 +22,25 @@ typedef struct { pteval_t pte; } pte_t;
 typedef struct { pmdval_t pmd; } pmd_t;
 
 #ifdef CONFIG_X86_5LEVEL
+#ifdef USE_EARLY_PGTABLE_L5
 extern unsigned int __pgtable_l5_enabled;
 
-#ifdef USE_EARLY_PGTABLE_L5
 /*
- * cpu_feature_enabled() is not available in early boot code.
- * Use variable instead.
+ * CR4.LA57 may not be set to its final value yet in the early boot code.
+ * Use a variable instead.
  */
 static inline bool pgtable_l5_enabled(void)
 {
 	return __pgtable_l5_enabled;
 }
 #else
-#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
+#define pgtable_l5_enabled() !!(native_read_cr4() & X86_CR4_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
 #else
 #define pgtable_l5_enabled() 0
 #endif /* CONFIG_X86_5LEVEL */
 
-extern unsigned int pgdir_shift;
-extern unsigned int ptrs_per_p4d;
-
 #endif	/* !__ASSEMBLY__ */
 
 #define SHARED_KERNEL_PMD	0
@@ -53,7 +50,7 @@ extern unsigned int ptrs_per_p4d;
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
-#define PGDIR_SHIFT	pgdir_shift
+#define PGDIR_SHIFT	(pgtable_l5_enabled() ? 48 : 39)
 #define PTRS_PER_PGD	512
 
 /*
@@ -61,7 +58,7 @@ extern unsigned int ptrs_per_p4d;
  */
 #define P4D_SHIFT		39
 #define MAX_PTRS_PER_P4D	512
-#define PTRS_PER_P4D		ptrs_per_p4d
+#define PTRS_PER_P4D		(pgtable_l5_enabled() ? 512 : 1)
 #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE - 1))
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcde70c6..20ac11a2c06b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
 
 #include <linux/memblock.h>
 #include <linux/linkage.h>
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index dc0956067944..d636bb02213f 100644
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
@@ -50,14 +47,6 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
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
@@ -95,37 +84,6 @@ static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
 	return fixup_pointer(ptr, physaddr);
 }
 
-#ifdef CONFIG_X86_5LEVEL
-static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
-
-static bool __head check_la57_support(unsigned long physaddr)
-{
-	/*
-	 * 5-level paging is detected and enabled at kernel decompression
-	 * stage. Only check if it has been enabled there.
-	 */
-	if (!(native_read_cr4() & X86_CR4_LA57))
-		return false;
-
-	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
-	*fixup_int(&pgdir_shift, physaddr) = 48;
-	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
-	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
-	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
-	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
-
-	return true;
-}
-#else
-static bool __head check_la57_support(unsigned long physaddr)
-{
-	return false;
-}
-#endif
-
 static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
 	unsigned long vaddr, vaddr_end;
@@ -189,7 +147,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	int i;
 	unsigned int *next_pgt_ptr;
 
-	la57 = check_la57_support(physaddr);
+	la57 = pgtable_l5_enabled();
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -486,6 +444,14 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
+#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
+	if (pgtable_l5_enabled()) {
+		page_offset_base	= __PAGE_OFFSET_BASE_L5;
+		vmalloc_base		= __VMALLOC_BASE_L5;
+		vmemmap_base		= __VMEMMAP_BASE_L5;
+	}
+#endif
+
 	cr4_init_shadow();
 
 	/* Kill off the identity-map trampoline */
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
index d73aeb16417f..67d4530548ce 100644
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
2.43.0.429.g432eaa2c6b-goog


