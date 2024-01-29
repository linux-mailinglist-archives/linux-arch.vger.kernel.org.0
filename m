Return-Path: <linux-arch+bounces-1783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BB8411A5
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05351289868
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C91215705A;
	Mon, 29 Jan 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0lxUEwbD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549115704E
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551546; cv=none; b=cr8xqnWKH16hz7O9NKjtJhiqPOxKwunad3+ROkE+bFsdzq0wc5zQMAC9YNRiXcOBRs5hrjdfaqRLEPMV+aX+xcNTbhC0qzi3oVx1+fHVBCvBQmJI6d5rd8cvVwt61qcpJa4yR0UDD7D56JcVd7nc9w0gaIu/Pc/FUGWurFO8J8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551546; c=relaxed/simple;
	bh=H7fHoFCfZwfyk1oPodR7EeB+4BUH/Qm6LmEtPz6akBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NWFabsy4KVDqQ+OK8VmAHOT8yJtsVeKdED+f1aim64MY+yB7BSMeZXAZvuTHnM/evbkrUVQQJ1PxwJlXrTSJt9TcqmXkSow2brniGIdvcTDesigM+9mru7F7iC4sUh6dlwZ2hlPK1f2gzk8CD7uKYhBgK/NhxRu98dG1cWFjfRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0lxUEwbD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6029c85922dso59739727b3.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551543; x=1707156343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hn0YC42oF3TvJQQuUnzb1vQnmOgTTWKFEwunsc8Y+bs=;
        b=0lxUEwbDi3bxMo9AiAXS9NCT5E52hZtWz7cXbB4azapFFSu/iCzfvzLt1W47R3NH80
         1weBQTAe3ksxpwzSmwShO8L1eRxHEPU9mtD8AsiCNiL7tTy5ZeRLFetzE7BnWUtYjtrL
         WNz213IZTncPhbSJq9JoblcVAPtTLtLbZgxDkKE5599oWeG1fzSmzT46AQXqL+Tuaw8S
         pscRVvin8fjaEm0jm35glURZl+TngCJ/6RL4vnJXKim0X9KSQwAyiekAkXMyjn/tHci2
         L04CgnuhhT0jbGGnqYSnG6y7Qo7fqXxDKRLfRdAWQkLaGBeJP1/7XxNpxFB+GdJaT9pL
         HCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551543; x=1707156343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hn0YC42oF3TvJQQuUnzb1vQnmOgTTWKFEwunsc8Y+bs=;
        b=iTPIqMJB2hfNXB8rjHeeaVuDZIDAft8WWcI10w5nPOa41SR5qx/jJAGFM4wrlNWmpk
         /nD6ZUq9mEdev3lIwlGemDSLeZK0t9O8UK+G59bwcc/swJ2+VL7JyD6LvqWtmwKSx1fO
         fCFC4Ij8NYFBSpoVFvKnG/XlSOKJvtXS6Q97wgzerCmVSxvm4R5+ZcpQ4aYh3eJzE8pG
         FLhVmgnMkATGIgUCuWEjTzAbhnHzuduTpLj9qP8/c3/Dz0QJotHw2UJ401p6vqJ5R5Kr
         RFP9pFs1FEuhgkGGQfVpbfObyEofMKcXGH6B6I5JN4f1P2xvjkjeMrgBdXYTBqIPa2jg
         7wFw==
X-Gm-Message-State: AOJu0YxdFS57cn3zt19ZmWk8Y9Eiou44lGv8DQGfbEh4vE7zQGb6Gvlb
	JT+BCwhKw5GhklVb7ZJtNlpoQ2xuYRB/i8atyyjdyR2qOQqGayZOrNlrnowznU8PmxPFNw==
X-Google-Smtp-Source: AGHT+IHc9J6Eygu67jBTVvQmRSn+tap7OMqKPbaRL96GW4Z6K516VElaEAOe7eg6d1emn1ED83GOQ4Dj
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:5743:0:b0:5ff:88f9:96f1 with SMTP id
 l64-20020a815743000000b005ff88f996f1mr1973294ywb.9.1706551543658; Mon, 29 Jan
 2024 10:05:43 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:09 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7926; i=ardb@kernel.org;
 h=from:subject; bh=8VKMuF0Y9EN2NaZalEvyHBoCi3s4P0N7R6CaJlurDdk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i6tezr9nH/kcv/2l1P3V6mknuU5z5epaJe1z2nzpu
 eT271zKHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiMuWMDAu+dK/vvZPRIz7F
 PILH0+XDdhN2J1b3A7O7Qh8GhT59fIKRYXfYxQOhxt1fRWfMZK4WfqN/5mx286LrPi43qpeI57Z yswEA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-27-ardb+git@google.com>
Subject: [PATCH v3 06/19] x86/startup_64: Drop global variables keeping track
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
index 06466f6d5966..2e195866a7fe 100644
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


