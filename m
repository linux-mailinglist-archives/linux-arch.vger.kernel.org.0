Return-Path: <linux-arch+bounces-1781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D708411A1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854A81C23A6A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E557604A;
	Mon, 29 Jan 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MX9uMOEP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F96F097
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551541; cv=none; b=Ilk8jLx/ONNDNF89JwAUjMwUAtuQE8pHEpBEw/TBXfWiA51g1p74lczvV4qgorVib0T3oKNMmaA4bJpLdhBCM5fVqJEmCOj1Vk95r+zzEMapMbnRk0u2WtDqNiOAtmxMcVLm89uPighNlmPDYzP/RgXX6WnnHg6cA4Jojx8mzWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551541; c=relaxed/simple;
	bh=NfXCrvSrRHu5/o/a38jIuQQEOM5CDJx3GD3fZgnkl0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S7elWN3q9JG90DNhaU04iQC46g9MC0O9bWFbX+K1vYNP9kGVK1JLv5pD2G7ScL3zgtvIy6S0hzBbVuZLWIvv6O1nx/1N36f59fMIuDZ1mXoehrigM7llZ3BlTj5EMJAMwuS5ML2Mr7RQDe9mFjoaSLx8JLd+O/UqRwTLd41z2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MX9uMOEP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f874219ff9so39678227b3.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551538; x=1707156338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHVLq9Wa6m8PRjV68aukFNmIoFWxPV4eVUMjwp/oWNk=;
        b=MX9uMOEPvqCEzuFwVNq0sK6GsmH4zreaoZnLFIPuSq2JEuMNrYywE6eiti9DFDJQAd
         +ZDzDoAg54m6NW5y5DLrHlQZryjay+LdBDLUGUWP5VdV3C6ey4LELYpkUs9fZ2wqrGY9
         pO7Gf/q2oKFFAd1ANNHlPDPXik++WcaTbMZbdQVb5fb7aqvH8a8eIiwDCzmCWKMbdSMg
         /Nz4gpIVvHvJUaGP9wCky3ed4DoR2qxK7Bbu6WrCkIcL2tfJdHwthY1WSP/13NPtSl/1
         kZhTHVGYF15Xawdl8H0Q5a9b3mpYupt45KPnfQBDzu+zjcgIqNFWscDaawS6MLEPyBjE
         sdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551538; x=1707156338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHVLq9Wa6m8PRjV68aukFNmIoFWxPV4eVUMjwp/oWNk=;
        b=GR+bGng8q8BTCn33ArQuwzXHIsNLoy8MemGn+Ni02Pksodlmhmws3imhYmhFTFYLNH
         GRGhspY/Xzpn81UePhwt2ZWNt+k+yEicdWR2fFs2vWLQp87Yzeydhrm7CFffpEvTPmti
         siybia6y7lMokZIosNhgHezIHk+Qz2daZNJdMYnriID7qcpjLAlKDMd3UPjPVQgurnJN
         8EYVhXkHenJxUlIemAGu4GL2MkDaPTg0oxvVMG09zyYDM2XZXU2rto11xO6PmLOP/dLs
         sCCK0Sn77QgUw3ETmjwDH43bt38RXompHQBlU036msIL0J+uSj7yld9RPpSuxZUBzPxw
         sedA==
X-Gm-Message-State: AOJu0YyyL9a6cn84PBYGJiB1N7KsSwmp4s7TIgjH/ssvO8vVRMXWzu9Y
	3TiFbXnz4cXQsK+WvfKYXsUmu23M8FAyUickONhitrgeg3VX3myEljtyU5n3j35cKkuFXA==
X-Google-Smtp-Source: AGHT+IHxjP1IrVdmFk3AwDM0KDLSJNYxWIU38kLAEN4S3NCDdU+0TDUv7tiHgHfqnBU0X6ZiOaX62S1y
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:9991:0:b0:5ff:6ec3:b8da with SMTP id
 q139-20020a819991000000b005ff6ec3b8damr1836537ywg.1.1706551538650; Mon, 29
 Jan 2024 10:05:38 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:07 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=ardb@kernel.org;
 h=from:subject; bh=XmOltJN4+bmiY4MWHeNLYuJPJ6TOu7DKSx2rFcdng6s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i8s8r3v1rr9Z/GV7jFFs1hRBhh+bbvyp+1p6tmPOX
 ONr6Zvfd5SyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJfDjF8Feyh+FfQIWc0h5F
 mWnGdoteLW5T478Teqbpf/okTp82pz5GhoaqDJOa37f3eH7suSHndEf1SL5VeaCY8gMVjT/qvzf rcQAA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-25-ardb+git@google.com>
Subject: [PATCH v3 04/19] x86/startup_64: Simplify calculation of initial page
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

This is all very straight-forward, but the current code makes a mess of
this. Clean this up.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 25 ++++++--------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 4017a49d7b76..6d24c2014759 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -113,13 +113,11 @@ SYM_CODE_START_NOALIGN(startup_64)
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
@@ -128,12 +126,6 @@ SYM_CODE_START_NOALIGN(startup_64)
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
@@ -173,18 +165,18 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
 
 #ifdef CONFIG_X86_MCE
@@ -211,9 +203,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #endif
 	movq	%rcx, %cr4
 
-	/* Setup early boot stage 4-/5-level pagetables. */
-	addq	phys_base(%rip), %rax
-
 	/*
 	 * Switch to new page-table
 	 *
-- 
2.43.0.429.g432eaa2c6b-goog


