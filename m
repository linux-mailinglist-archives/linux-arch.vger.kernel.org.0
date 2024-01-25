Return-Path: <linux-arch+bounces-1565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB98F83C0DD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2E2289F68
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF1A405F9;
	Thu, 25 Jan 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="le7noE1q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095332C96
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182366; cv=none; b=jEyCbNs78k41+FzmCXNpd7pfXTgSPE4iHosaaCXEGuDoE7Pyu/OblBbIuHY3UDHpmRpEcquQFSA3LZc/bZzaN3VVDIvTklB0EbXJSlFiRg9Ufa5XZbJyVRK1Iz3Ae4F39RveLgg0XTBZ3bAif3xTgqW/rXgW7rYP2fY9UFnQ6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182366; c=relaxed/simple;
	bh=NfXCrvSrRHu5/o/a38jIuQQEOM5CDJx3GD3fZgnkl0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k6Llx7Zb95ccAQYcbyFdm7CWRMHB0lz/B+LqV4V6qTJFWNUsyH/1dQ+mBCDRw9o1IJiQuD63zbLkuNmBCunIitZ/g0FqFRMBcxUVfdUgggEdltwGmCiBsmWK70993S5pSZn+guU/EQqQGBJEXoQNfafbJvm0kkIlHW2Ce4TwBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=le7noE1q; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33921ffe6b4so282600f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182362; x=1706787162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHVLq9Wa6m8PRjV68aukFNmIoFWxPV4eVUMjwp/oWNk=;
        b=le7noE1qf7mBa1wSBSLwLBSR76Pa9kx7N7YBkZGuTxppl23kHAp6gMLMWmAOvoeKEL
         DEVQTKZt21rJCv5Sp4O8o02+tEGPAawBRpOaLN2GIXyArDf4H0e5HuIIuUgDy9kSOnyx
         oTg81+DcEv3iwigMp7lBwpKw1gO7koP+yxrCC5205dutFJRoYqK41P3zR563vQdpaRAC
         emzZM9lCrfvEgFQd+hFPEJu4Fl+fDLmrNLRR3ap6t19ILXLptkxVRE13cMCv6YhQMlm3
         YcFj5tzSdUjk7frSunXiFfx7VXm2G+xalp+5nkwllU95ZvJ8VA/n7APcnkJADVOQE6Zb
         SmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182362; x=1706787162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHVLq9Wa6m8PRjV68aukFNmIoFWxPV4eVUMjwp/oWNk=;
        b=KUw0nA5CfzDO7fx6mRFnNe/mdyiTq/zmKsabPN6hOEq3V5v3p/+Buyv79+kO5JESYN
         V+S1gSyex3U+dG/qTQC1DPNUT//yu3Xrsx80RxXDVAIisRlOY6lPneXdhPsDsZKMN8Az
         Qy0Z621OTZmHaieCTGnS/QNwyx/6D4Ab0BBSydimTENQOaUz9sUmDw3utwUV6TXTKi5A
         l7uxBqvJBKsWqlDXtjrR92ObACmdIkbxmkN5z9WEf7kpnEhMlAfzqZ+T82o1Bcy2YeFw
         wChe0VYCAtPs0K5MbKC/6HEqWRU+KigHMLasIAt+MIhQX3pvolR4k7GCC1pMvVQL4qU1
         q6Yg==
X-Gm-Message-State: AOJu0Yxm4NDdJ80onpDMzGNpuojjNHLpH3YO8lD3eVWLxdnojc+X//Cg
	FPL9CPeT5VyZVCG4S8dn1Qp55farNJb/h5WFXPgAkEP2tHMWNezrZqSn5Tw8sDXq+XdjXg==
X-Google-Smtp-Source: AGHT+IHXC86EhWoFkLRT9cd7CM6iYaIQkqHD0Lry2mDtup+eJG8gYdxNz3bR9quI7xeAlJTdWFKJ4laU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3489:b0:40e:d20f:6e43 with SMTP id
 a9-20020a05600c348900b0040ed20f6e43mr21711wmq.1.1706182362257; Thu, 25 Jan
 2024 03:32:42 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:21 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=ardb@kernel.org;
 h=from:subject; bh=XmOltJN4+bmiY4MWHeNLYuJPJ6TOu7DKSx2rFcdng6s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT63We1716198s/rI9xig2a4ogw49NN/7UfS092zFnr
 vG19M3vO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE5M0YGfpWObw/1+Pu4DHj
 O3NQwTOG9GOlO/nK+iwWHXXX36D7O43hn7nK/YsyjduO3U2/XPBoM3+7+M7T4tcKePreLt7y9RX 3D0YA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-21-ardb+git@google.com>
Subject: [PATCH v2 02/17] x86/startup_64: Simplify calculation of initial page
 table address
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


