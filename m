Return-Path: <linux-arch+bounces-1795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EAA8411BD
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892C01C248D8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2A515B2FE;
	Mon, 29 Jan 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdadTvfA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689915B2E7
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551574; cv=none; b=SBvl5aDL9FcC/RXM4tRSEtQVL/zewezfB+IgOtJalWjwcs2PWgtWmJfMt6Ru3Fmpo50NLe2OHi+GU1NuyXJZyAdV7TYq9CDne07nwG8ZQn7p+SYYzIV7wPFFbkPt3OyoIqc0W65JSaG/QEIuAWs2nZ+/uHhl4c+hUusPNisBpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551574; c=relaxed/simple;
	bh=+rYahPmzXDYe/IO3FyUv8LMIVG+yTpD3LpxEPcnxKUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qTHKFP0xJPaTIYWJKTsRDlZgx+2wXBD/rbxFOAWrtKMlTfPrvj1yzyvzv2uwiQo99cStlGngsIml3vVN4KvSOW2on1UbZDWtTh2sfFm1TLP9nb9EX4lqH6Opte5rZXDeS1k4NBNKCYysyQ5YN2+C0/02bbK2qmo+7hJI2RVO/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdadTvfA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e8810b5f3so25162765e9.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551571; x=1707156371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1we6nPeM2Zvq3sHnH1EZ2vSDoW7zEMVGBC8FJkE9Ugc=;
        b=DdadTvfAZ1Bu1GNzTRVMfCuyQYsxk57eo7/d6flgQ1FbFi8SpMCBwhaH442wCgGjPQ
         JZDFTGoZsOpab0fZ7TULk2S3HVef6YsY3PHLV7WlwcNnr1d70QYV+JhLNGFc4J/DdHZm
         fN88GRVttOUlcpMSieXEl1N7eUr+CLo+ZQjKLokpvMkQ/q9cy466bnBaXdtqsTOcgNtw
         YjyY5UAyFli8JLtRypCguh9ZGpZk3D2h8aIvJoCXbc4nGdJuOaMevloLbosAMOYYk6Pi
         TYkPiG+u+gmt1/ttB6wwm2SKZLkJJ4G2NsqtVmDL/eo2z29/LOGRCq7pscBZEaNIM7Y4
         d+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551571; x=1707156371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1we6nPeM2Zvq3sHnH1EZ2vSDoW7zEMVGBC8FJkE9Ugc=;
        b=IJevDEoTO8tCvvPgCgigEGH7ZKlA0as0chYsY/SvrnIslLXsIGMNYPo8mhGCHI1Neq
         bMyCkwxV+g2K2jZva9+7vVKra8EDma5mMwvT2+D1Z4dx2Xutj9pifJVUIKA1o08Ypjzi
         RBnM9bvJZMtgJ9/XdJV1Ovj4lv2ZLgBuyZEUYCfbcJt3Lys4ZNQSLfh91l8aWLooFtO7
         qVUW6rpBHawAI/OiiQLENgTgOdfL+wXkp9WyutdGeOwPr2/8iPMh/EVJ69o0wobHf4EP
         6ZogDWyBBQ5tg60qbXH1rUi2EMtcKfXFWXjUHn3uO+LwLyPXQdkiwktcdP1T11KD4ZQj
         ayNg==
X-Gm-Message-State: AOJu0Yy+RX5eiHmlyQAhYLGFAle2NJp6+p2B2OTBStYoe2DtL2KYkUU9
	x2l2UAVN/zG8wdrywzv2yI30Ygch/JUnGzFO3bRYDbCEB+B8R5Fkyl3Xv5kEW9lrNy2qCw==
X-Google-Smtp-Source: AGHT+IHZlPWQchy0J38KpxwD5TmOBCD6HsGG1BLHK/s1BgvvkdecR9aOkvWWPLTFP29XujBFiYmoqpYE
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:6012:b0:40e:fa6b:cda8 with SMTP id
 az18-20020a05600c601200b0040efa6bcda8mr10582wmb.7.1706551571814; Mon, 29 Jan
 2024 10:06:11 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:21 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=ardb@kernel.org;
 h=from:subject; bh=b16vPiy6Nf2YAluruWpP640zmYr0MIrigfShg9HjlpU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i0evc6pO7Ltxi++Y3aTSOvsf+18vOOEd7XDs37FJk
 kwxfyOaO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBENp1nZHho+2iy3+ZYHdd9
 a8y1g98YMW3T67f1jI++f8Ps+2uORbmMDB2/ps69muN/7KifQ8rL5Sl2RxY49nk1iJ1N+VQpkCn mzAsA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-39-ardb+git@google.com>
Subject: [PATCH v3 18/19] x86/sev: Drop inline asm LEA instructions for
 RIP-relative references
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

The SEV code that may run early is now built with -fPIC and so there is
no longer a need for explicit RIP-relative references in inline asm,
given that is what the compiler will emit as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/sev-shared.c       | 14 +-------------
 arch/x86/mm/mem_encrypt_identity.c | 11 +----------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 481dbd009ce9..1cfbc6d0df89 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -325,21 +325,9 @@ static int __pitext sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		    : __sev_cpuid_hv_msr(leaf);
 }
 
-/*
- * This may be called early while still running on the initial identity
- * mapping. Use RIP-relative addressing to obtain the correct address
- * while running with the initial identity mapping as well as the
- * switch-over to kernel virtual addresses later.
- */
 static const struct snp_cpuid_table *snp_cpuid_get_table(void)
 {
-	void *ptr;
-
-	asm ("lea cpuid_table_copy(%%rip), %0"
-	     : "=r" (ptr)
-	     : "p" (&cpuid_table_copy));
-
-	return ptr;
+	return &cpuid_table_copy;
 }
 
 /*
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index bc39e04de980..d01e6b1256c6 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -85,7 +85,6 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-
 static void __pitext sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -329,14 +328,6 @@ void __pitext sme_encrypt_kernel(struct boot_params *bp)
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
@@ -346,7 +337,7 @@ void __pitext sme_encrypt_kernel(struct boot_params *bp)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start;
+	execute_start = workarea_start = (unsigned long)sme_workarea;
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
-- 
2.43.0.429.g432eaa2c6b-goog


