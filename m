Return-Path: <linux-arch+bounces-2570-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C7285D729
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523F91C22FFB
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2074D9F8;
	Wed, 21 Feb 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2qOAi1N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC894644E
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515361; cv=none; b=jOjz15AvrxGOYM3Da7NwilS6iiZyC+DbGVwlniU9U+H3V23PaKp4cMgHGuAg1KkZQoqYTJQrKTPZjTN1uxLSmVILeeC/U5xmiaIAu54RI2n98De0sWKChJq6w1ejf8noztnHOW5psatxQcJZdMV+7ZWthAzlsdfgpBGChIbqxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515361; c=relaxed/simple;
	bh=G1DG06D2aqp4pwBOMLdzbyqBLE1i1IBpz8O+pTeBX18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLii0nej7EI7Tlh8zU8bYXpro8PkJmvzoGE1MIoHgD6hnGugx+wQ6qb78rgAesCNP92KyQPIeOC2H8YSxKM3qqchfEveN79vFIV6YtKN4VyDHEXJSyMYyHiKM3bBSteY0U09IeboBuZ78GMq0TlBMjWzCCa3pNVv0pCsOjVfmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2qOAi1N; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-410e860c087so24505485e9.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515358; x=1709120158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTqJ99P6i6SBAIAH+IAXdMn7P2pIU1w2UuJtp90ikvg=;
        b=H2qOAi1NnE+xdycvAp6K9GqJPLQFvq8M5o8OLDhNVnf1ra//QYJzEjZ1TqcuqrxuwV
         Fhhnoky2dLlVvUJ8vGmprcNQQdkVbUEwVv5XSJFPV7qz2zWdZpnlkLGwaYdbM4RY7Lqs
         jPAL6GCQM2j1z0o4PPCNc2UicoDdpeP3K8FFz2k/B0hgQbVMEaribaksN7qLnZQZyECF
         qpea9OWuOr/lQgIm9dUtvxO59Tsm8VnM9Wg9p5Egde3BM2lvD/Aw9lx7Seoh5pp8dmY5
         89uOkmOOcyI4JH4CInyTn/tyoV4hNiIEi1qAMQ91wo9FrFt0ONZkujX86YiLoxLqXnFT
         vqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515358; x=1709120158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTqJ99P6i6SBAIAH+IAXdMn7P2pIU1w2UuJtp90ikvg=;
        b=kJ5UE4lnyVMRR+4gMEx+oaFS3mpgdQghu1PcWUOTlLSJNj2fkGsA4RDYFC5UZzPy8P
         AllLP6sK6h1uhEOLA+9o1LuFdSfPX1w27uapt9Oh+YAh8y4AHcY3qg64v7cd2s/X4Mmd
         jxHVyS+Bxk/pHOdvsD5thvyj48zYfvawKJ0HWz84fuQDsopCj6hMt7KZWWF3FwNReMKu
         9DBOYPsgePGrsx6903zZB18/oosbX7MoswUE/u+LDcIYMaYPl1eKOjpzsfM8JRwxC23l
         3mtBrDxPkwmaQdW1fpqppgASuqJXl6JIIilPF00CGxiUtDuF+NZ98q5EuxlOMs4e8Zy6
         1aEA==
X-Forwarded-Encrypted: i=1; AJvYcCX9ulVJDbx/lHfkJNimy185k1RTr1arbcXC9WTYB1ZPYmUtrdDNSoUvWhAUfSwrV6CMidjAAeoc3zdq8vV65Clzdi4itGn0VzQnjg==
X-Gm-Message-State: AOJu0YwvHsa6ExtIdv9ZWYjXtaun2IM9vxVLUJ1rwb1B65zaIOdIgCN1
	GTueVKoY4wEjs9jpjFKfhSA2D1JVVkOkLZB2VAaBmsLm0aQP5sWE9fMbjEYz2vVeBACEgQ==
X-Google-Smtp-Source: AGHT+IFITrStDY8qkTtuSdIIdzMUYcaY2nSms8BthZQq6Td2kpNAr50Wg4EXwQUrpgtDrocBPdUr8Ddn
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1f17:b0:412:72d3:cfdb with SMTP id
 bd23-20020a05600c1f1700b0041272d3cfdbmr10352wmb.2.1708515358491; Wed, 21 Feb
 2024 03:35:58 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:17 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361; i=ardb@kernel.org;
 h=from:subject; bh=i7YTwnF8QsOAYHIVebyuOmPcW0rncRMhxzgGUyIgY38=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/U/vplsk/HzNuOys4hb23w4nvt/7HBDut6vewlGn6
 NxOleWtHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiIYsYGS7F3dGZ7vRpnUPq
 w7kBIQdLeRyv/F3AEvfgbefPCUflymwZGfYpGMxXyxfjX+4aMyFzvdIWPnWn14yXL3sF7Tljten 9XxYA
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-28-ardb+git@google.com>
Subject: [PATCH v5 10/16] x86/startup_64: Simplify virtual switch on primary boot
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

The secondary startup code is used on the primary boot path as well, but
in this case, the initial part runs from a 1:1 mapping, until an
explicit cross-jump is made to the kernel virtual mapping of the same
code.

On the secondary boot path, this jump is pointless as the code already
executes from the mapping targeted by the jump. So combine this
cross-jump with the jump from startup_64() into the common boot path.
This simplifies the execution flow, and clearly separates code that runs
from a 1:1 mapping from code that runs from the kernel virtual mapping.

Note that this requires a page table switch, so hoist the CR3 assignment
into startup_64() as well. And since absolute symbol references will no
longer be permitted in .head.text once we enable the associated build
time checks, a RIP-relative memory operand is used in the JMP
instruction, referring to an absolute constant in the .init.rodata
section.

Given that the secondary startup code does not require a special
placement inside the executable, move it to the .noinstr.text section.
This requires the use of a subsection so that the payload is placed
after the page aligned Xen hypercall page, as otherwise, objtool will
complain about the resulting JMP instruction emitted by the assembler
being unreachable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c  |  2 +-
 arch/x86/kernel/head_64.S | 43 ++++++++++----------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index deaaea3280d9..0b827cbf6ee4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -553,7 +553,7 @@ static void __head startup_64_load_idt(void *vc_handler)
 }
 
 /* This is used when running on kernel addresses */
-void early_setup_idt(void)
+void noinstr early_setup_idt(void)
 {
 	void *handler = NULL;
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index b92031d7e006..03268bf0214a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -39,7 +39,6 @@ L4_START_KERNEL = l4_index(__START_KERNEL_map)
 
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
-	.text
 	__HEAD
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
@@ -126,9 +125,22 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	sev_verify_cbit
 #endif
 
-	jmp 1f
+	/*
+	 * Switch to early_top_pgt which still has the identity mappings
+	 * present.
+	 */
+	movq	%rax, %cr3
+
+	/* Branch to the common startup code at its kernel virtual address */
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*0f(%rip)
 SYM_CODE_END(startup_64)
 
+	__INITRODATA
+0:	.quad	common_startup_64
+
+	.section .noinstr.text, "ax"
+	.subsection 1
 SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -174,8 +186,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	addq	sme_me_mask(%rip), %rax
 #endif
+	/*
+	 * Switch to the init_top_pgt here, away from the trampoline_pgd and
+	 * unmap the identity mapped ranges.
+	 */
+	movq	%rax, %cr3
 
-1:
+SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
+	UNWIND_HINT_END_OF_STACK
+	ANNOTATE_NOENDBR
 
 	/* Create a mask of CR4 bits to preserve */
 	movl	$(X86_CR4_PAE | X86_CR4_LA57), %edx
@@ -196,16 +215,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/*
-	 * Switch to new page-table
-	 *
-	 * For the boot CPU this switches to early_top_pgt which still has the
-	 * identity mappings present. The secondary CPUs will switch to the
-	 * init_top_pgt here, away from the trampoline_pgd and unmap the
-	 * identity mapped ranges.
-	 */
-	movq	%rax, %cr3
-
 	/*
 	 * Do a global TLB flush after the CR3 switch to make sure the TLB
 	 * entries from the identity mapping are flushed.
@@ -213,14 +222,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
-	ANNOTATE_RETPOLINE_SAFE
-	jmp	*%rax
-1:
-	UNWIND_HINT_END_OF_STACK
-	ANNOTATE_NOENDBR // above
-
 #ifdef CONFIG_SMP
 	/*
 	 * For parallel boot, the APIC ID is read from the APIC, and then
-- 
2.44.0.rc0.258.g7320e95886-goog


