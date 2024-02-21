Return-Path: <linux-arch+bounces-2574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAA185D731
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D702846A3
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C84F896;
	Wed, 21 Feb 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpXvLEuM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7904F605
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515370; cv=none; b=NkRjeXbwhKzX39t9BLRWrKsPPTDWPWb8XnVaqxRg8kG5PVwNVMncp9HEj3sffgJLBIbNB9lc8EH3et/op4mrVNPVLUzUEYYgeV8K6Zowtq3RIfGENShBxIqeoa3ivs1iiBA37UzyWKh5g4wnpPwvb/03eCN0QwG3EG+p4VAjDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515370; c=relaxed/simple;
	bh=WZPNjU+tKWbG1/7EwXfp1HjOJvLOdEPU1KuRuZ22CGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bv9GAN0g0relBxGJgGtHpDrvEEbKCTyuhAkTEZ3rhGapI9Rxs/wVcaSH6B8XiTVsiC863o90ZT8OhFGIUnly2+KRofQqgI+LSeuaUAh8RasLJ3nl/K/9R7JSTspcHs8yVjWWvlB0vucalDcruN0beGjWA433oNnPzs3a2laLZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpXvLEuM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc15b03287so9028330276.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515368; x=1709120168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHBDJ41pn3iOna4rTXtxPzeJ6vfMVADf3iDfGB7g+R4=;
        b=PpXvLEuMPM38gThvJ/6wj9PxYDyk7+h3DzW+dUxCFhEmIaDfO/O7HkjBPZdwnWjPmG
         FCvL8/67tc5gF4VF/1jBsEDOqW5MAivIASZYunc8kWdluLzidjBGRtuJj2i//g0SXnFF
         StbRwWUmu9qyezvb9Ybl0Iy+NFpLa0rmmVaPdUNbMkNVqlu5LmSIR45Z5mUNkC0AoE8W
         nYXmm9utes/CY10liKfc7KrAV7b5qH7R6EdgbZEaOQIZUxvvsvtKvDVDKr4OrcZm2PSn
         myAwnFknOSPZkMkDLjYV+w67IHEfK7mHtP/RET6oQw0S4cOimqrdI2+AEDckh5kXzuVM
         5nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515368; x=1709120168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHBDJ41pn3iOna4rTXtxPzeJ6vfMVADf3iDfGB7g+R4=;
        b=KDHU1W3aBsFlHOCMUBv+BM8ovxHFMcwCgGuQCYKKHs7HsVIqrSqzT7UDjX/9xjv9fO
         nCFBJ5v78xYP6942lUDf5uK6Quwa5MZ9FkKOBxl1tPOquOOF5J7Y0fe0Y252J2Vj2qcQ
         bav1CAjRIUyPB2tgFMkpQWUcy8j13IpYs+wKet+qedTffG+nMI6YsEgd3TJA+y0dfrjF
         8oCgU60PtAlHdpQWEKIe8m+qIOiG1XZGMOXgX2QBZPGAGMIJIb4hmlVAdLqz6AgLyg2W
         h78ENuhf7hUzk+9tjb2V8m7ZTuGcaRuIpG53dufSU1ZVZbRqNI3LI3zjIU10fYCxfp27
         CUtw==
X-Forwarded-Encrypted: i=1; AJvYcCXdLlr9etmCympjzx2/o3JPTDTrGs5XEoA02bWC5zhUzvAeFCW18Pz6xEFe9VfjMKKAlubYwiKr+ErSinHFSbnJhIFPvj9exIQLnQ==
X-Gm-Message-State: AOJu0YzL+/sz6FpzYBwcyZdvBt8aiKqOLDJlmEvUjGAGhzQ8+6KXajvV
	I8walDCvSLpaOLaWcnCvXCoi9dgma8JR3FO77PjqU1ZBqdvZKSbKMnFnUNjLUyqjw6xt8g==
X-Google-Smtp-Source: AGHT+IFLhuT2W4YOcdOCwXt+5j7fxZ5kUyX+RMPsaDQFfyrGWogvNozu8z3/pOl1/TgxuiD28sWm47hg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:b2a7:0:b0:dcc:4785:b51e with SMTP id
 k39-20020a25b2a7000000b00dcc4785b51emr727479ybj.12.1708515368119; Wed, 21 Feb
 2024 03:36:08 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:21 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7470; i=ardb@kernel.org;
 h=from:subject; bh=gAHUpSDGEhZGPmJ7iJbqEh4bp+wwMJqFxMSwv/jUH1s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/a+RU19XXOhsNn20b8ZGvf/ZyurTjzOFMn3Uupqxq
 LFbrSmwo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkoTrD//SojHvRAk8W7pCT
 vV3PW/42OqTXeOu2fQGHcpgPFKdqtTMynO2vZfljffNVm9olH/9Fv1+o1F5bW3/HVnF1LL/2eQ9 OFgA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-32-ardb+git@google.com>
Subject: [PATCH v5 14/16] x86/sme: Move early SME kernel encryption handling
 into .head.text
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

The .head.text section is the initial primary entrypoint of the core
kernel, and is entered with the CPU executing from a 1:1 mapping of
memory. Such code must never access global variables using absolute
references, as these are based on the kernel virtual mapping which is
not active yet at this point.

Given that the SME startup code is also called from this early execution
context, move it into .head.text as well. This will allow more thorough
build time checks in the future to ensure that early startup code only
uses RIP-relative references to global variables.

Also replace some occurrences of __pa_symbol() [which relies on the
compiler generating an absolute reference, which is not guaranteed] and
an open coded RIP-relative access with RIP_REL_REF().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/mem_encrypt.h |  4 +-
 arch/x86/mm/mem_encrypt_identity.c | 40 ++++++++------------
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b1437ba0b3b8..f922b682b9b4 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -47,7 +47,7 @@ void __init sme_unmap_bootdata(char *real_mode_data);
 
 void __init sme_early_init(void);
 
-void __init sme_encrypt_kernel(struct boot_params *bp);
+void sme_encrypt_kernel(struct boot_params *bp);
 void sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
@@ -81,7 +81,7 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 
 static inline void __init sme_early_init(void) { }
 
-static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
+static inline void sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0180fbbcc940..174a7192c9cb 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -41,6 +41,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 
+#include <asm/init.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/coco.h>
@@ -95,7 +96,7 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -110,7 +111,7 @@ static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -147,7 +148,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 	return pud;
 }
 
-static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -163,7 +164,7 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -189,7 +190,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -199,7 +200,7 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -209,7 +210,7 @@ static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -233,22 +234,22 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 	__sme_map_range_pte(ppd);
 }
 
-static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
-static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
 }
 
-static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
 }
 
-static unsigned long __init sme_pgtable_calc(unsigned long len)
+static unsigned long __head sme_pgtable_calc(unsigned long len)
 {
 	unsigned long entries = 0, tables = 0;
 
@@ -285,7 +286,7 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+void __head sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -320,9 +321,8 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *     memory from being cached.
 	 */
 
-	/* Physical addresses gives us the identity mapped virtual addresses */
-	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
+	kernel_start = (unsigned long)RIP_REL_REF(_text);
+	kernel_end = ALIGN((unsigned long)RIP_REL_REF(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -339,14 +339,6 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif
 
-	/*
-	 * We're running identity mapped, so we must obtain the address to the
-	 * SME encryption workarea using rip-relative addressing.
-	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
-
 	/*
 	 * Calculate required number of workarea bytes needed:
 	 *   executable encryption area size:
@@ -356,7 +348,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start;
+	execute_start = workarea_start = (unsigned long)RIP_REL_REF(sme_workarea);
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
-- 
2.44.0.rc0.258.g7320e95886-goog


