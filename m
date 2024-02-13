Return-Path: <linux-arch+bounces-2293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320608530C6
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5714E1C262A0
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E054677;
	Tue, 13 Feb 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtAkottt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2BA53E17
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828144; cv=none; b=byC7SHeVElxxa/G1s8Hl4vD+5xlRFqoe+Rv+LiJkqHIrgjLKquDMeoXQ4qhVXANeBJYUh6Vqy30Pgl2upDz8YvCHuhM0BuyfqDdFZ6N3FTxWzie/u68bM8x2QB+N4DtvCafRXri/63IGpFqlkr4ZZQxMxOL6Q/dAFMmcCNZPsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828144; c=relaxed/simple;
	bh=HgCoBP1Ar8xIzQYCsjFkSLzQsHIbfD1/fXOVPSZuf2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=prwme26uOdpgTvJ1mh2F3+jmSEU4LOxJRmcfIRvjSR7X4UM5Q6dJKu8d3kKx+5P5Jbz66PZ9mtFRKKlXvZFDYgy3lgwmhbCC1h88cqVjXcqrse23ilzhfSYCDDax056PwSzxlMU3pltK+8qXW+Lt6PLieQlJXbJpIHCP+A5zKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtAkottt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so6437777276.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 04:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828142; x=1708432942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ll+Sw/hEe0JqYepYgLfYwl4wc3XtSlKf28OWCE7h1Rg=;
        b=mtAkotttdHWN9Hum8bT+dAmEG6P25a6eT+07DCKNkvJYvvxVT1XfOl+kxIyNeHlx35
         nwX3ZG/EMaxb6KOdFfzmxgXOhYo13AK5M4A3W1lGsHwcS8aYK+l8MewVgEta/aLSe9n0
         p1TLnZuHhKj12IkHz1sKx4TTFwhuZakSgKPs0pxm2O/5imHTfoePRDNj0xbnun3e7sIp
         eJCrvNluNJiVb9cDzuL0VBTURGDGnrDdzjVRAvaK0hJm6Xl7ro2qxbf0DdBxM8jCPQkY
         4AbUKHzjGqOfJR2HkscY2FodFHfXkMwnF/xIRN3SZoL88Yw1YZCqHYjGqYn5fy8lVfhH
         UXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828142; x=1708432942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ll+Sw/hEe0JqYepYgLfYwl4wc3XtSlKf28OWCE7h1Rg=;
        b=qLHv0C0grA/rG/V+JOrzmjh74j63FfH4VC0ktE2/dFcTS2a6F5SWfIaGtMW0w269IG
         fUFyNaHpsqopS+6Dj9RB/lBeUKnc7t74LIlxm516W5D2Ph660aJdfdbfg9Z4E+As3Pw1
         TErkIgTi2jgqcv7W0Eu1UL6ilMH3l8b/XZVUP76MJaMseFRQgSFyoyCCH1mrFT99Eb7+
         f9s3MhBp45GRipyTip25hJdllNeZpM0t3IjG8jgSBVE3vNeNXKlkqIPBrZzKvmTqd32j
         mLyhUOZtsccg9COmyybupV9ZaKMTUbVdhWJLqVWMmt2XeGuSlhHaJoZMEZW5oWHBnJSP
         HaUw==
X-Gm-Message-State: AOJu0YwAh/HznNOAvIJJ6bz1C25qDDlAuKtqp5OP3uEgPNtzQx2yDF9Q
	dUoz040Bk9VFlEAz453NsNFsEw1awkRyhqOJVscGEUCNCUgKLcMK6FbOp58GayMttkbZ+A==
X-Google-Smtp-Source: AGHT+IGz5rXKE4ok3lyc9Ph61zn43E8fW8QAcs8pUUmKPB+KA26Bp5VEIyCzX68h9spY8DVufWeu+JwH
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:10c1:b0:dc6:e823:9edb with SMTP id
 w1-20020a05690210c100b00dc6e8239edbmr268852ybu.12.1707828142047; Tue, 13 Feb
 2024 04:42:22 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:53 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7964; i=ardb@kernel.org;
 h=from:subject; bh=FdrHvH/vioxw/rDTZ5Ktwi3pb2GEozrF10ixhskLdq4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV08qQlq84+38H7dulr9Y5axXtblTMs4kOyV/Me0FmQL
 c2aEizQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaypJiR4bLGz8mWNsr2K6b8
 y97wV/jQE73OnAkvtrH29+vUd0uwf2FkWL9q/8pj7XGV4uzbmf9sefyCfc23XbrT1uu1b1aR+/j HiBMA
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-22-ardb+git@google.com>
Subject: [PATCH v4 09/11] x86/sme: Move early SME kernel encryption handling
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
 arch/x86/include/asm/mem_encrypt.h |  8 ++--
 arch/x86/mm/mem_encrypt_identity.c | 42 ++++++++------------
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b31eb9fd5954..f922b682b9b4 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -47,8 +47,8 @@ void __init sme_unmap_bootdata(char *real_mode_data);
 
 void __init sme_early_init(void);
 
-void __init sme_encrypt_kernel(struct boot_params *bp);
-void __init sme_enable(struct boot_params *bp);
+void sme_encrypt_kernel(struct boot_params *bp);
+void sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
@@ -81,8 +81,8 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 
 static inline void __init sme_early_init(void) { }
 
-static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
-static inline void __init sme_enable(struct boot_params *bp) { }
+static inline void sme_encrypt_kernel(struct boot_params *bp) { }
+static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index d210c7fc8fa2..64b5005d49e5 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -41,6 +41,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 
+#include <asm/init.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/coco.h>
@@ -94,7 +95,7 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -109,7 +110,7 @@ static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -146,7 +147,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 	return pud;
 }
 
-static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -162,7 +163,7 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -188,7 +189,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -198,7 +199,7 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -208,7 +209,7 @@ static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -232,22 +233,22 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
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
 
@@ -284,7 +285,7 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+void __head sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -319,9 +320,8 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *     memory from being cached.
 	 */
 
-	/* Physical addresses gives us the identity mapped virtual addresses */
-	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
+	kernel_start = (unsigned long)RIP_REL_REF(_text);
+	kernel_end = ALIGN((unsigned long)RIP_REL_REF(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -338,14 +338,6 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
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
@@ -355,7 +347,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start;
+	execute_start = workarea_start = (unsigned long)RIP_REL_REF(sme_workarea);
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
@@ -498,7 +490,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init sme_enable(struct boot_params *bp)
+void __head sme_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
-- 
2.43.0.687.g38aa6559b0-goog


