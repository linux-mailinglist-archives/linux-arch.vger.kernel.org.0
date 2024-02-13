Return-Path: <linux-arch+bounces-2290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB48530C1
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2611F262F9
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB45339F;
	Tue, 13 Feb 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4kCWYai"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B152F7E
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828139; cv=none; b=hPT0n2fLfExx8C+fzGsnC2OEsqHcAQRBYxNg79rAg5NVAvW6CmC5dYzkN4ATACppeHOyT5hd9D/ZJKRX6GuLLe5cSXXz/dNRNsqFIObpK6T2AYuRKvHiShrZ4+xq+Q6MaGMPNHXU5rTiLDUJhtdH8SbuEfGGsKVdkr8HrbTgQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828139; c=relaxed/simple;
	bh=V43RwcksINAVGLrcC9zNozM9sOBz5XCNbWyT4FUAcEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kCviCOZY80V5svsb6EWRDyMiZGCKm1KY7DV61Ps2vn/eFckdnE6jByb7t0J35yZrkvKtkE2xHjkr/5CGJbHvuQz1my1l1oLrbJA8ZzZJLKFLh88RES2iQnmc9FDYXS4iQvYHf+L3cjuwQzF25SNN1OABVNNEmrH9yQOXT5r0kNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4kCWYai; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so6437718276.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 04:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828135; x=1708432935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9PGLkbb8+qoug2ZrrnwKu6zhcSycBxmHA7JvTLYhJc=;
        b=r4kCWYai+0z+MLg4WaOkHuJmakMAZ91VFPT+1f408MTofIGUD3p/+pL28YA0p6yjft
         owaf+C+2dj8bL8gawo2hWlD9l7eoy/9K62lSt96Iss77DODdXy2HVhVhwq6Twvh+Fxuv
         1m9ToZNWOSH2epX0uxyGpfVC1F7kcuqu4LNPRACokkycXD5Dj4DtTOKUWsQNnUWhPeLT
         yrkRt6Ag8abtKIut6lCVdWUI7Yw2HRhMFU3wJzzwk4ND3gIAvNxcRINNUn1OT5IwzdQw
         bpFJW9eMqS6AwkzRpxF8rFSWDDoKdlTSmoaNznZyEw+YWCK7D44AeqE+hesjt82Vx6G5
         68LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828135; x=1708432935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9PGLkbb8+qoug2ZrrnwKu6zhcSycBxmHA7JvTLYhJc=;
        b=AZSuNqxLuErMSE3OS0aCbXiYD2Gy/PA8e4eBdJArxY5nhRi89FGCyMTmdQYmK7HLiH
         0q4cv4aUw/nIB3B8I9vInoJsOPol3cPaj5Ci/6TgSNVvnFk1+P0iq2M1hiyjigF3EpNB
         dLNnbkWXPLcnLgrYZBOxRgY4yrTopa+rnZvRUp3oyyiVHp9/BkIv5IQ9zlbuoQjZ+atm
         8FhpAM2cv5qn1BIhKNXw1BLyXm2Urye4NRkplAhpGe1T+utYEKb5EhWGq/cMpYsFaS4s
         nWOLhejwK0JKqk/6+bR3Lh0T0Tb0Z5FNm//2Hwq3PWqtApDHw3Ex8l4nSltBcnSoPhPj
         0k/g==
X-Forwarded-Encrypted: i=1; AJvYcCWcDnT/AIQGS04SK1Ud6qqtMH1B0gUnbEB8EEHJs7LZWgIZFj+9DasydoV9aOAGdFFv7aDSBmYTg71dkqE3hJ5OvJ+5hyGQO0lyTQ==
X-Gm-Message-State: AOJu0YznkN4Jta79JyjXp9i/XLDSNa3hYG+Ko8/q76KwO52nCEc/jHhF
	QeSK6DVhnwONqfd2VezfiPPuPXPyL4z7yBsZhlUyRxTgB7NTiFdi2ruz+cMLmP3mPQSeSA==
X-Google-Smtp-Source: AGHT+IGjASN7m5SPQBlNVx8g7TNhkNeiu4Ck9pU388+ZGMgbalmk2tWU7OABlbaYA4+Y9UUbzFj+uv94
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:c702:0:b0:dcc:9f24:692b with SMTP id
 w2-20020a25c702000000b00dcc9f24692bmr44649ybe.13.1707828135418; Tue, 13 Feb
 2024 04:42:15 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:50 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664; i=ardb@kernel.org;
 h=from:subject; bh=CIHrtmfTIHf1nWX5y4HvnUdj+zcQXCO5URm4j2f8Yss=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV0cl/Gzc7Pj0827Z2x7tTrdlcrJTWWepkfL7+1Tvbfv
 L0+de/ajlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRZENGhp1XJhx+OvtJ0OQd
 t66/4Tg4Z981saPGcaoTv3fmC4oZKr1gZNjyhGdrtnH11bPX511KKZxqfenAYamIjWsevWM+0XN NcyYnAA==
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-19-ardb+git@google.com>
Subject: [PATCH v4 06/11] x86/startup_64: Simplify virtual switch on primary boot
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 42 ++++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 6dcc2f7f4108..3fed0aafcb41 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -39,7 +39,6 @@ L4_START_KERNEL = l4_index(__START_KERNEL_map)
 
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
-	.text
 	__HEAD
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
@@ -126,9 +125,21 @@ SYM_CODE_START_NOALIGN(startup_64)
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
 SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -174,8 +185,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
@@ -194,16 +212,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
@@ -211,14 +219,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
2.43.0.687.g38aa6559b0-goog


