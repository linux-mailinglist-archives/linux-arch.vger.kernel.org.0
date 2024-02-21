Return-Path: <linux-arch+bounces-2571-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D485D72B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FCA1C22E53
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274634E1D6;
	Wed, 21 Feb 2024 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xWTU47Dk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F24E1BC
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515364; cv=none; b=gdIFjXQVi0lh63bMcxkXIq5+ngFQ4x2pXY3r0iXmyGXdURk1aTbWQ/Bb4VN/yD+NdIdFieb9/VBelpYP85oBrtcr8aDB5eFMkgCEwrmVf0n9wf/pSxVc20amz8wOmes8YzTqwdzhZz+v4Uu0/xzYobWn1R9yNTW5ixX1RRVdfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515364; c=relaxed/simple;
	bh=iv8WXooCR9hoiH3pMKa/9TfgmsuasaiYtcPtFFzw3QI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SndZMASpAwZtA2R4SLvbd4cBjm7NHnquIlxiRsU7x54GSxT4iCzA1gNtf7et4RZfOqb6EvdixKC6yLL312dmd8xRpbZG9Bt9osBJWKHEF2JVshE1g2f8/rBGU2TXfWe3WZc3tkuICQCEc2+XHTyDzhukZeIysGW4+cwFEhDLMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xWTU47Dk; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33d10bd57d7so2183594f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515361; x=1709120161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tevHFXJ+OOPc1/guz1Xb2v+32aOKjnUq6Qv962Lc8AE=;
        b=xWTU47DkRFKzKWef6Xy3xIpCrckMs8ylSGlcHq6QG2fGWjUr25x7s0JdtdL4v+iT4k
         /CJIZ/jWUUXvGNfbgu1unMo/ZbrSI9vY85IykkoTZjLCm4FD+p1T6vW/s/P614pfHMJz
         nlUv+GOQjbXf5GfqvM4B5IFw6yZdRtIa5V3mLWVX6KMplqdp8Ykgo7B1Q4sOaIfbOkP7
         HepGp0lf1xSk9v/4U3Mrp2+TjCKNKSvOrM32hOq0qKntB/tiOyS2VrjMX54deER415ek
         MAhmGMDg5eoKvIPePnzOMOjIqsw+B0KqYmWg/xT6d7LN+UGqEis5P+yHGJlKCfwUVPE/
         Ugzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515361; x=1709120161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tevHFXJ+OOPc1/guz1Xb2v+32aOKjnUq6Qv962Lc8AE=;
        b=C8wNqv8kbvuyF+ZjFQGPdCHmQX0vTkx4r61X9DkeS20H1AoehSholCiqT1q9vgUMqW
         5+X8vrUfmky+av2ohDH9EE7e9YHrif1tUTdYR7PkwaR8Mw8Y1RmT9DLu5Ohx5phpvblz
         j1yI5IqvzW3IEbg2ixPQCCjfypSkLBzhbfP6qmqpCrsockMZlIAh31tymO1ZrDLzRO76
         uOk1/BcB/XK9uzltJpiw/9B+Egwia8Ptdpvj6M/1FFPxFFj8RbErLswlkBfjeRe50KcC
         W5677oCCaIPF0HTHZwjSPdAXvrNYhvH2z1o2zLMfaNpyKE/ge30L6p0tp+ImFGOBsE/Q
         kdLA==
X-Forwarded-Encrypted: i=1; AJvYcCX+r780lv0Ebch1Yw3b0QvTSznTkBAaWddymp7Wzy7brxPh3RDRZgaGWZskttzykxoNqLxeTx2fPSe1+aHMmxyF/kUJ8ie2Pqolcg==
X-Gm-Message-State: AOJu0YzUcXotWdO1pcgCv25RYp5VgtvVsU9S9IWHUx1ZG3/7Ohqwm9hM
	50xwHBpb3zd9OShaf2QTRnwlw3RKU2kTNqOcesOM8blHwl5qnNEOx0e3Jx4lYsRox4zKOg==
X-Google-Smtp-Source: AGHT+IHrJdSqq3WRZEYfXkYjOhgk7FO7uJiJt+JPUYxdVmt4RCgu0u0vbJUG7dvL25hHy3uKZa8NbzKH
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:6d8f:0:b0:33d:4dc7:ee2 with SMTP id
 l15-20020a5d6d8f000000b0033d4dc70ee2mr57756wrs.5.1708515360743; Wed, 21 Feb
 2024 03:36:00 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:18 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3958; i=ardb@kernel.org;
 h=from:subject; bh=PHNTEzBLgbyUsxeGtN9QWmwRz8NSWIe83iLY3QrvkGo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/U9ZK1dd2mLOnCwavPTfm2Pn2/Vrn9zLPzbvtSdvW
 JNl16R7HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiPr6MDE0nLl1Z69QwX87h
 H+/V5a/uLhVSuvys+d217dnHq66W6eYw/C+Zf6v8zv6ogAtOaxmU4y/sNfu1tKlEzUAxfNnSZ89 u/eUAAA==
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-29-ardb+git@google.com>
Subject: [PATCH v5 11/16] x86/sme: Avoid SME/SVE related checks on non-SME/SVE platforms
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

Reorganize the early SME/SVE init code so that SME/SVE related calls are
deferred until it has been determined that the platform actually
supports this, and so those calls could actually make sense.

This removes logic from the early boot path that executes from the 1:1
mapping when booting a CONFIG_AMD_MEM_ENCRYPT=y kernel on a system that
does not implement that (i.e., 99% of distro kernels)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/mem_encrypt.h | 4 ++--
 arch/x86/kernel/head64.c           | 6 +++---
 arch/x86/mm/mem_encrypt_identity.c | 8 +++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b31eb9fd5954..b1437ba0b3b8 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,7 +48,7 @@ void __init sme_unmap_bootdata(char *real_mode_data);
 void __init sme_early_init(void);
 
 void __init sme_encrypt_kernel(struct boot_params *bp);
-void __init sme_enable(struct boot_params *bp);
+void sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
@@ -82,7 +82,7 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 static inline void __init sme_early_init(void) { }
 
 static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
-static inline void __init sme_enable(struct boot_params *bp) { }
+static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0b827cbf6ee4..b33f47489505 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -98,9 +98,6 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	unsigned long vaddr, vaddr_end;
 	int i;
 
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
 	/*
 	 * Clear the memory encryption mask from the .bss..decrypted section.
 	 * The bss section will be memset to zero later in the initialization so
@@ -108,6 +105,9 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
+		/* Encrypt the kernel and related */
+		sme_encrypt_kernel(bp);
+
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0166ab1780cc..7ddcf960e92a 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -45,6 +45,7 @@
 #include <asm/sections.h>
 #include <asm/cmdline.h>
 #include <asm/coco.h>
+#include <asm/init.h>
 #include <asm/sev.h>
 
 #include "mm_internal.h"
@@ -502,18 +503,15 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init sme_enable(struct boot_params *bp)
+void __head sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
 	char buffer[16];
-	bool snp;
 	u64 msr;
 
-	snp = snp_init(bp);
-
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
@@ -546,7 +544,7 @@ void __init sme_enable(struct boot_params *bp)
 	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
-	if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
+	if (snp_init(bp) && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
 	/* Check if memory encryption is enabled */
-- 
2.44.0.rc0.258.g7320e95886-goog


