Return-Path: <linux-arch+bounces-2569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F285D728
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31BE2B23572
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FDA4645B;
	Wed, 21 Feb 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOEY4Zuw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5E4DA11
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515360; cv=none; b=kbIOgn3PH9t8wIr6xPbfmi5ENBzeHGLI1wubxdDiB3CiIC6QGAVSGbRi6g6V6IZWDamExoO7BdrQsDJvhLh1B5HcgHlyJ6MM3D9nOZ4sqcWCenQsyLhsbxhriq8S8SJ+0lhOYXDHLgSk70ujQbh/C0hGAQ+3o7qANZHAMF+Wv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515360; c=relaxed/simple;
	bh=sFg81TTWm8wXNN7PrKjakH1R2yINKbC6VHscAn/WI6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=slPSsQIFL4chmYOtYhHXcGnmnk2NX16T2G3pR6j9l3yu+IfXBerdmyqSM+leQ0NJ6bvE+5UV/RC9OPHvybDx57/6x3rlAV8So4BRfQDf9wzAG9kI4X4/8WkB9G5xYjkWbVELJaPvnzOl70+9ClVLnoTde+t/V26HmqI2Yc/TJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOEY4Zuw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso10041732276.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515356; x=1709120156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=StiHl4wqKJLROSGDCkKhKFhOVcRJSTp0SGrZr/uAC14=;
        b=nOEY4ZuwYnUemy5QE8lfocHWUrTUBMlf7x2hSNcNuKDt0JVRMtBGocvfZUoG8yd6QW
         IvFaKhOuDnTxRwG3f2ClgiC0OSs1qVW9wKn/JYqPIXM5sDQOjCMJcx5lEFQMxVmkbsG4
         DXmqtlhGXMZMJbqSho8m4yiXLSgJMJE5F+McItHYyo248tCjyAfiK28zFYFksuD/sEP7
         ftjbbhNhvdNYUnpk4ExA1AYDfYKJbYUjsyw9yaaVeKhyR8q2MK73WEk+7N42hRJ8zHhZ
         49BZ2o1yREoTEcB5zdn6F5Jje0arYAFecz6I1qtppAJYhrs+RTOUZ5exO/keAuU3J7DA
         zhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515356; x=1709120156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StiHl4wqKJLROSGDCkKhKFhOVcRJSTp0SGrZr/uAC14=;
        b=iyM35yD1FgW2uVmANozRRl2m7K/Ln9Fc2NP1mGoWccn8vtxbj96zTGI1K3WR50KAuz
         IyUur/3Ga+tA1jIOzqh4uSQSppql1D7+sffCMiUPC8bARgD8aW+nPlOaMvtQ4iYn8Elz
         vneZBdZK3d42D4sRMZFFw1jgxc6arS41KrOMK7TPc8C/EFwzmIw2utzP858ZLL0bmEfQ
         XI+dCNVsRXgSGqmqx/m2GPU+p9vKrqJulc01xW5UjIBntcOtKoAVbAVOREY882eUkVoC
         v9Su9HDXtedzE3eam7d3oE5p3hvGoAHCnQIGmR+IZUB3RRFZOCpoYNdbY22YKGd/yPiI
         mnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXdQtjHkOVG/Zsy6U3tF44FEvrIYuaN2w//MkMNuWARyoX8dZOWMGtS8mecYCbzmkCik9IjDWdkxckt6cBQlZcSPV0DyWgVv+IlQ==
X-Gm-Message-State: AOJu0Yzf5enecu9bD9xtkHX3C8A3FdNIAIPMBABDrNUTTJeKrVdDpgZ7
	YXmKB5gdnkPbeE7lVN+4iJmi4UB8cnH7AX86yCXpW6QVmXmuDiy42kfiajju+mYfJ1wbUg==
X-Google-Smtp-Source: AGHT+IH3u9lmmHz2WBCVjo782BmL6ANcoOP05nHtuzMs5I0/PWpWryQ5PAJpU7/DdMkawVIILbrYldDL
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP id
 w1-20020a056902100100b00dcc79abe522mr731868ybt.11.1708515356342; Wed, 21 Feb
 2024 03:35:56 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:16 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=ardb@kernel.org;
 h=from:subject; bh=l8yZBrOFoYa/63WN0vjjrRhrZ18bZIs3VDCL1kGdQvs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/Y/SAgpzDwQo/t+8UsaGgZGnNTtB0tP6SOMEvj7r9
 bnBk8M7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESuczEy7HkrtmrlmlsVE/6y
 rebZrWbY2Ru8c/L2xheu/8PPScle6mP4za68hrVhTciUbfzS0/YXybbfFL7BPKVxwclLnTWynnf ZmQE=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-27-ardb+git@google.com>
Subject: [PATCH v5 09/16] x86/startup_64: Simplify calculation of initial page
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
index 426f6fdc0075..b92031d7e006 100644
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
@@ -204,9 +196,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/* Setup early boot stage 4-/5-level pagetables. */
-	addq	phys_base(%rip), %rax
-
 	/*
 	 * Switch to new page-table
 	 *
-- 
2.44.0.rc0.258.g7320e95886-goog


