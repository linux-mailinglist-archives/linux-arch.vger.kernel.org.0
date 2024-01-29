Return-Path: <linux-arch+bounces-1782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5CF8411A3
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010431F2285A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FE015698A;
	Mon, 29 Jan 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1WrCPS/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4333F9E9
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551543; cv=none; b=HVDeK9ZwTuOQX2v2Yux6Q5IT7zXSquZeV4mDMUjEWYdVaqlod4/hAFjR9UEU/qfieJOaV1oTDc2lYbrUNidW11QUhfqzKYuMquYOzZyThFHQTzXZjw3L0uLM4PEY/704LCgZ8J+pH8r8D18sBMgaQJOI8U7IMucCFLRXlS4HVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551543; c=relaxed/simple;
	bh=eEloesx5WYIVvdIkhwITl3KfZCfyKY4osgEzAPlzJuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pf1L5TqjXJyqI9qX+H5VDqAoZWYvHVa4zFEcNKEJivHwst5/Ng7c166Irie91/g/pAMWLvhpuO5bxEJxX9dOp3JciqEwKe6/SZK5+FF8Mwcp2cyS2Zz+fKYo9jQDHwPGWtbA+meoDj3Kzj0OlxyY5AJ9MUqporVY6JBQz3EquAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1WrCPS/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc2284779caso4194969276.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551541; x=1707156341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zW2Nb503VpTEmBC1IeOy5LYeXYJ6a1J8kf+z75WkqKU=;
        b=Z1WrCPS/4+R/EvI2fSSa4gSVK1FU7pbLA5GaL3tWhRQUfs1pwlf+lH5LrxACuRn79Y
         vE8L82E61vy8ogm3lIczvMhpBsEuEI6dPvh8f733kQXXiXjekXoi0RGyklkpVEGMa7MJ
         ONFh4VGsHRXDh4mKw9X9vTKOIpHIEAzyB/EvKbfQ4KgEhMajcVFUNjCry3n53Yk+fAUR
         pyQy8fLsXFj/794CCHnVzHJRx0SK3HR980ss6jpOTp6NKetiYrLjR4AHKWQI9aqB0EU0
         klrn3dZ41aV3zSdYe0KreWabGbTakOo5VcoBUfTgWQbKC/klJw+7hq8A5TLjB+GMVpgG
         AcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551541; x=1707156341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zW2Nb503VpTEmBC1IeOy5LYeXYJ6a1J8kf+z75WkqKU=;
        b=iKNwvfDGUIIqMAIgJT83mlwXajStgOI0TBMsXpdyC6ccQ27rndo+5U9MWOTZLrF/7i
         mufUm2aWOX2BCW3wp3s3tkY0Ux9dkKdiJb8Rtm+ilX21VbAGqrFl9Z+Inw8/BhpsR3L8
         iEhd9L93T4ToT6bqMPLBettRJvnTkdDg2o2B4tiXMWK7U9t7kaQ/XiRKeXAsMkcqQKpz
         KX2GXdmPj3yNxQwQHoA/euuGPFjYgG95nz0Ih4ITqj/IDF8MCoeO9sWZTHF0hX6jfZCd
         x7eh87oC41wZ0rlfTDOPGKTw1Jepz0eIPdVVI0YS4g7hAJi19VSmLh2HKqfy4GUbPjbM
         KIiw==
X-Gm-Message-State: AOJu0YxHHm22drPtdqLCxaF7K/GenOKcak1z3bUbH4Q/+uD5JsMDPy5i
	Ee//5tqGHLDuJiX/KzeWgkmdbWa99Bnh3RR8aNvbsQ9kKIjwbClorWilI3agnZwXMvCLmg==
X-Google-Smtp-Source: AGHT+IHoG1nlT9xH7OrNUFwSwleSuhPvAk+iQSlpUq4EhaCK8UijteKSY+nXx9/XbYd43g38b4ws0dig
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2503:b0:dc2:661d:11fc with SMTP id
 dt3-20020a056902250300b00dc2661d11fcmr358172ybb.8.1706551541086; Mon, 29 Jan
 2024 10:05:41 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:08 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=ardb@kernel.org;
 h=from:subject; bh=N1gJDIfI4P+Gstfr/XNIaKJ5tEagJPCWb57TREbNgFg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7iytN/vLW339JiJ8PO9e3Z/3ET1Pub2Zt2uCvYNRvv
 M//oB1XRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIbwgjw//8s5OSP57Rn9Hh
 f71rV/YhgY/1/IprLy4+HWhSn3qj6wHDP+1tetd/u38wCl61S0asJVPs5xlJU6n+D+77zl9u8m6 LYwUA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-26-ardb+git@google.com>
Subject: [PATCH v3 05/19] x86/startup_64: Simplify CR4 handling in startup code
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

When executing in long mode, the CR4.PAE and CR4.LA57 control bits
cannot be updated, and so they can simply be preserved rather than
reason about whether or not they need to be set. CR4.PSE has no effect
in long mode so it can be omitted.

CR4.PGE is used to flush the TLBs, by clearing it if it was set, and
subsequently re-enabling it. So there is no need to set it just to
disable and re-enable it later.

CR4.MCE must be preserved unless the kernel was built without
CONFIG_X86_MCE, in which case it must be cleared.

Reimplement the above logic in a more straight-forward way, by defining
a mask of CR4 bits to preserve, and applying that to CR4 at the point
where it needs to be updated anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 27 ++++++++------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 6d24c2014759..ca46995205d4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -179,6 +179,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 1:
 
+	/*
+	 * Define a mask of CR4 bits to preserve. PAE and LA57 cannot be
+	 * modified while paging remains enabled. PGE will be toggled below if
+	 * it is already set.
+	 */
+	movl	$(X86_CR4_PAE | X86_CR4_PGE | X86_CR4_LA57), %edx
 #ifdef CONFIG_X86_MCE
 	/*
 	 * Preserve CR4.MCE if the kernel will enable #MC support.
@@ -187,22 +193,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * configured will crash the system regardless of the CR4.MCE value set
 	 * here.
 	 */
-	movq	%cr4, %rcx
-	andl	$X86_CR4_MCE, %ecx
-#else
-	movl	$0, %ecx
+	orl	$X86_CR4_MCE, %edx
 #endif
 
-	/* Enable PAE mode, PSE, PGE and LA57 */
-	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
-#ifdef CONFIG_X86_5LEVEL
-	testb	$1, __pgtable_l5_enabled(%rip)
-	jz	1f
-	orl	$X86_CR4_LA57, %ecx
-1:
-#endif
-	movq	%rcx, %cr4
-
 	/*
 	 * Switch to new page-table
 	 *
@@ -218,10 +211,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * entries from the identity mapping are flushed.
 	 */
 	movq	%cr4, %rcx
-	movq	%rcx, %rax
-	xorq	$X86_CR4_PGE, %rcx
+	andl	%edx, %ecx
+0:	btcl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
-	movq	%rax, %cr4
+	jc	0b
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
-- 
2.43.0.429.g432eaa2c6b-goog


