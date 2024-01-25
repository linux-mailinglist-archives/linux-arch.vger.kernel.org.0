Return-Path: <linux-arch+bounces-1568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B5483C0E1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8401C233A1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81648791;
	Thu, 25 Jan 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnH1Vm06"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282CD45C1C
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182371; cv=none; b=R7n1GaZXshBzVZwOdSd9siIsBpyKH6WI7MmyPdahYE25av7DnwFeY61PlB/JNRjyGIvLQUVzKSmTaw1y+Vaj7uVS8oc7g5LXRIab8dnHPLjbQmSsjb0sI+3kjfcZjByumyHDbZOYl7I917KJAOrJLuCj5nsFJFp9P+y7+rbUUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182371; c=relaxed/simple;
	bh=g6w4YKbdWdUPESXVeFJEr3y36v0ES/R9hznFmwq1kAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k3O300VXClCh1cWvWKa+9zjE/PdUs4lQWz2ZIAxd1y61fV1SU0GJLKCy4VK/wRgA3pkk/OsOYDeoFioTFRWkPETBe9wAub2qJDvZu4l7pOggX9pYQUXJTbEsljHbnXVsWq+CTd+sFIjATKyMBahQbfARYkZx7kl9P73xKw2qwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnH1Vm06; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff84361ac3so7796327b3.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182369; x=1706787169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJoL2/hFc4gkGtzEyAanpsFO97W15h/UiL7Bxz9040w=;
        b=mnH1Vm06WU4xdC8JIDlrHVpu+RgHWAlQ3lbx6dgdi3Zsh01r7+gLgT0q2XLlfncgl/
         Rbn9GGt7zgBMwyijWQ+1t60q/ULLQHFkz97jbxWD2+QpZxVInRQSD8pPsDFd/Q7ENqut
         /w3FmxdTn2Mqxf8NjMVckX5qyuhUTauirJY9lo5/cC3AKxNWrqmKmfKXN+UqOxjFRn5K
         ha2DQwzA8yPdI6h6BnddYSmJWeAepqVI2UAazsG9qeBFWo/DbZWXS3qDEPISWqLJ9JUV
         4UhjM40ihUMaNwKbCXyN6QwKNZeWN13py64Y84n4spENfgR4k9SpjqMuSMd4yrsQsg9I
         dE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182369; x=1706787169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJoL2/hFc4gkGtzEyAanpsFO97W15h/UiL7Bxz9040w=;
        b=omrsdYCEHcEoiI0/Fto0q6By84MRYQCWXIaPdjuT24K0D5NpjNP5J/oyCkxw7iIQfK
         +q6+D2xZAw/8HPHSRo2rwVHtNGMi8ot8DL9e2uXRLR34SXOfr4VMcJKns0SDUUhVkXVD
         0Yau7QjPJ0snq0lpVj+N5uHIXVTvf/NoliYw3UKisH3F1wTGJowTRluulCWUO8LZElEH
         BJuh1j0xj73d3l5w1ws2ZqLvYGBZ9tp/6Lvd1HbV+SrGL7UWnDcSN63zC30Ye0OBy9xh
         UXZdwDG9Lh2qJEUNCtQMRsSyZIHlrKSAlzAUn/CMRsNVulyMmchX+W8i9QhuEu+XWFeh
         zkZg==
X-Gm-Message-State: AOJu0YyP3EhtfFSRDrn65QgUDcRIwERvv7twZo6n1WR8Bs6QG7ERREMC
	D2STb69VbXYc+s3luDr8Gv5DuX7/zsocwMEeGqBFObTZ74Kvt8UHYm3Mq4tMwegJ+yyFWQ==
X-Google-Smtp-Source: AGHT+IFIXYOVy79M0sDfejfnwAr2/oscWHhuxbZVWwG4AyQkGvPhguUOlUksSNYnNbT51xwwVh/vONM2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2509:b0:dc2:51f6:9168 with SMTP id
 dt9-20020a056902250900b00dc251f69168mr447093ybb.2.1706182369248; Thu, 25 Jan
 2024 03:32:49 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:24 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319; i=ardb@kernel.org;
 h=from:subject; bh=t2swCS3/CT0QPpEAks7skAwmTJcH02OXVCoaa0u+RH0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT6z2rFV3aYh/+hMbW2pT79zN9nPJ7uduxr3f6Xjc+2
 PFLP721o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyksYORYWFhVXFRQ+RcS7Hf
 vydLr3wt9ekEW7PGnoatB5+F3An6UMvw32GH9BnTl5Fz+AP4/srfvS7w5cfdXe5Tl62+rRU9Qes OPz8A
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-24-ardb+git@google.com>
Subject: [PATCH v2 05/17] x86/startup_64: Simplify virtual switch on primary boot
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
into startup_64() as well.

Given that the secondary startup code does not require a special
placement inside the executable, move it to the .text section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 41 +++++++++-----------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 2d361e0ac74e..399241dcdbb5 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -39,7 +39,6 @@ L4_START_KERNEL = l4_index(__START_KERNEL_map)
 
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
-	.text
 	__HEAD
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
@@ -128,9 +127,19 @@ SYM_CODE_START_NOALIGN(startup_64)
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
+	movq	$common_startup_64, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rax
 SYM_CODE_END(startup_64)
 
+	.text
 SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -176,8 +185,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
+	ANNOTATE_NOENDBR // above
 
 	/*
 	 * Define a mask of CR4 bits to preserve. PAE and LA57 cannot be
@@ -195,17 +211,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 */
 	orl	$X86_CR4_MCE, %edx
 #endif
-
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
@@ -216,14 +221,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%rcx, %cr4
 	jc	0b
 
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
2.43.0.429.g432eaa2c6b-goog


