Return-Path: <linux-arch+bounces-2289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9508530BD
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F4C1F24DB3
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D852F82;
	Tue, 13 Feb 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEDkLskT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8103524DE
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828136; cv=none; b=lBubVZNRcEwgzZQnFcsZfMEGRDwgklUKl0FmWpx8VUhh7s6XHG+8pYOrsBEKf2FlBvKQPyeUtTEfDi3ZqxTN0oeDhtwdDl96WNXsRmYPlyEtoukMJrfMgXg1g5StLQmQ1uvQLbgF0Bxv91fcwx580S2h6HlTR0vlllF/ACRUhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828136; c=relaxed/simple;
	bh=wDmKde0tt5a+Yu2oaRGJYKH5vQlM4NHmT0UJ0NId53U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SPd0Cs33FlB2NhkK+8BJgDTIksOLSyq/V5SjDn3Uhi3KD1K/3MTqLj/e4aAizKIChYLoy+Xj/oJssv01A5QlOSljALNXI4UjMhQNeG4s5mbPSXGdjSOesKflUZEaA9Ly/OYpQpC4luDGzUSbDzRzcJr+rFPWs70q8fNnfambPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEDkLskT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-410e6b59df4so8895315e9.3
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 04:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828133; x=1708432933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eklaQMdtNqfp+JT1Cu4F0dtN+dys2QKIDEY8as5i074=;
        b=gEDkLskTpAQmj210Vf1KkahynByQ/4C45xu+UjvPmjzxo2Z83CVEhxAGG5KtyblACz
         vqWvMYg57EG3tiHW2l7nK2D1yJSzCz0QI2vNP5wYiK4r6KBjJG0qpXXlFuSN0riBLjv2
         Om4ZgURY5mLyt9aYT5Ag8aMlGF8VR2ltJaztm8ePydrw5EHVat4SLp7QtVkOVEihJY+t
         o/rUWZ3MoElQauVL2O+eXtKwutLVF+0RK1MkEevSTy7PbWeF2NTBzly6rheehrPYgVSM
         oNOjfBjXQni9rGnvgj94CIWeWA0JdP10OMquLl1PWMoauZ1/JILziYv9tC30YnfhRknd
         fJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828133; x=1708432933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eklaQMdtNqfp+JT1Cu4F0dtN+dys2QKIDEY8as5i074=;
        b=WCNE8flNovLov2PbXenC0uuRKGC+uRcwdTNS2ifM55Hu54KuTiaQDN0gFecjSEBzYq
         vGXWeUdpR5U0nqOe4MLqkz77ctJoDAtkqbPh/D05/N09LsjAFjIHACvY6GXFcm4GV169
         k32t1+imVExYSNgNjbjrFGHGzV+ibqGNpgEaEhvMuxbGXz0fl4NoAuleYIah3MEYSAwI
         0G2WwZzSMwxskELdiVCwY+wjsMCRmkw6oP0Z03c+gsQFaxFMz9WHqzZVy+iiVd1FI7Z5
         TjEIEWhWgtxrE0ilLfJ9pBQQsyTUA/aOWdQpq+ebYjc3S2SzQG87FWslWBOcvrizbVeb
         rYAw==
X-Forwarded-Encrypted: i=1; AJvYcCXJjUrqQycKHWVBZ4wctcBDWBWM0wJa2l5PDfs3XJTL5tdNCS/Ti/lphuWCoINm3ymsPWYTZJYY6bVtriPGK7C/rpx0SDJVSZ7GMA==
X-Gm-Message-State: AOJu0YwEmBQowcka8cfAwkjyCPYZkhjPha8IQeBC2PV3g6hfaRgDzgTs
	IqOzXhFT/B/d5Aq4+qO/6yprJtwbMiw7eFyV7bIcdGImFuu/tZnFTuRIt1NK7/ezmm3SvA==
X-Google-Smtp-Source: AGHT+IGZbejiN7TznW8T3B/x/Ca4HP68vuSayNcVVjDhmT0KxX8EqQvGm/LGI+OFFOjg+4DcU3KGT1C2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3f87:b0:40f:c77e:55d with SMTP id
 fs7-20020a05600c3f8700b0040fc77e055dmr50227wmb.6.1707828133083; Tue, 13 Feb
 2024 04:42:13 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:49 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=ardb@kernel.org;
 h=from:subject; bh=y4u3TSGDXd+Oc4OLRl0ssIJXn6VCieIfI1jk/RL3A6A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV0cu+FuNtRM/c+mCxqoVS+ZmblR6mdWd1rg+e7MTeYT
 b8pnhfYUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyZwojQ6N35pVJP01mHeos
 +nPkABd/pusnc7vnqy/8vs/fJL/paRHDf7dWvRWzNq1zN994durenpnXXGO9TzcsSPmX7xXPIDF 7Pi8A
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-18-ardb+git@google.com>
Subject: [PATCH v4 05/11] x86/startup_64: Simplify calculation of initial page
 table address
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

Determining the address of the initial page table to program into CR3
involves:
- taking the physical address
- adding the SME encryption mask

On the primary entry path, the code is mapped using a 1:1 virtual to
physical translation, so the physical address can be taken directly
using a RIP-relative LEA instruction.

On the secondary entry path, the address can be obtained by taking the
offset from the virtual kernel base (__START_kernel_map) and adding the
physical kernel base.

This is implemented in a slightly confusing way, so clean this up.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 25 ++++++--------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 7e76cc0b442a..6dcc2f7f4108 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -111,13 +111,11 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	__startup_64
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	leaq	early_top_pgt(%rip), %rcx
+	addq	%rcx, %rax
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	mov	%rax, %rdi
-	mov	%rax, %r14
-
-	addq	phys_base(%rip), %rdi
 
 	/*
 	 * For SEV guests: Verify that the C-bit is correct. A malicious
@@ -126,12 +124,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * the next RET instruction.
 	 */
 	call	sev_verify_cbit
-
-	/*
-	 * Restore CR3 value without the phys_base which will be added
-	 * below, before writing %cr3.
-	 */
-	 mov	%r14, %rax
 #endif
 
 	jmp 1f
@@ -171,18 +163,18 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Clear %R15 which holds the boot_params pointer on the boot CPU */
 	xorq	%r15, %r15
 
+	/* Derive the runtime physical address of init_top_pgt[] */
+	movq	phys_base(%rip), %rax
+	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
 	 */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	movq	sme_me_mask, %rax
-#else
-	xorq	%rax, %rax
+	addq	sme_me_mask(%rip), %rax
 #endif
 
-	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
 1:
 
 	/* Create a mask of CR4 bits to preserve */
@@ -202,9 +194,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/* Setup early boot stage 4-/5-level pagetables. */
-	addq	phys_base(%rip), %rax
-
 	/*
 	 * Switch to new page-table
 	 *
-- 
2.43.0.687.g38aa6559b0-goog


