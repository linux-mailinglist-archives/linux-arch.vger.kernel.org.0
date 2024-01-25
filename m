Return-Path: <linux-arch+bounces-1566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C083C0DE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123DD1F240A5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038CE45029;
	Thu, 25 Jan 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+MagZOv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395303D55F
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182367; cv=none; b=P8ea4+j7Vi9k8ohx+InMYmxoY5NgmjySLuvbjexnLZkqCM25vbB5Vmhwy+V02RfEiSZeLPVEhFx7XtnsMnM2uVWX3xX9kBuIt8QhxGuiSSVjgGObEyVzCZ56Um7XR8tZNQabY6bGA7JwgwlJU3MfWHmU+KUJXCUJ7mYaMSkzQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182367; c=relaxed/simple;
	bh=mnmwDuuQkke36VfancYNvAaxHSgDhivKxa5loDOkS2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TlGRlAdhSrSnRKSNtDo+blxjkqx60gk9RC8hoih+2ifYXFWp7+nGO2tinRLX5Oo7QixA+dzgHXa56z1DUrLc87hO/EQwTnAJ2gMW9wmirQLQgZM7cxBQXAiK/tjQgg5v/GjwHDsyyKVu8h6oGqv+M2+vXQ3Sv5UAKe5IABG53/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+MagZOv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e40126031so62680075e9.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182364; x=1706787164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0g+jX4epnZI/ommXCdUCoMP4YiUzpooZ3mcs3Px4Jg=;
        b=K+MagZOv/qW3jBL7GrJ79jVEq+DDab+17l56cMSSiHHEdqMq0BmpXIWEjiP8gL5xLT
         9Fbiwv9HSENDClqlDIzU4GYyW4+WXyZdm2FsDBL5jgRgmcsPJw8cpk6/x2Do/LrM/sRG
         my+oYRxr/HbxkGfMQR+MDEcQwA2GPRG+uwSyVnvo0r2f4DDvYVKi09jqXC9w2hk8iUa2
         QlXwwrHHTh05IqB/oKpuRKhm+0rgo3i1OHvvQr6xTDacwR1qOzqteEyt9MttzoxdxD75
         cMDWL7vv8vrOO+tkeF4FIae7MRHhKxTYf8ZKY8PRHSq551x7y7gq6e4Uda9sT+HNF0+3
         inBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182364; x=1706787164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0g+jX4epnZI/ommXCdUCoMP4YiUzpooZ3mcs3Px4Jg=;
        b=Yb3aEW48/IT6+2v0VdBEjR9n2Tmj2hRoGkcQR8Tz40VQDVkNuMEXqUlbCODeIsGNto
         KYnnIo4zyVIVZ29H4gIAh/qqyq624Cf9jxEAQaJSXDWwtoLNbZbCsZtlhqZML+Kdn13v
         BKu1lWdbXlMt7aigL6NqLVFKwDjd+KqCxwLOkzlL8o4+wbnBAXT/QBnE4zm3QLH+HaqT
         /FeZOFYKqJ/qbbh5iQZWVSqXVkuJMBqJDDIAoGMu8H6zGk/4e8h33qegvbDSI2ZE3VKP
         DLSZZmbqZmZxjI0SQzG5DT6ulyrR7mZXSLcMoIZPL562G9WFEDPGsu5xcgn0JX9AbJDs
         64jA==
X-Gm-Message-State: AOJu0YxWmxCCPKPi5f+hS/E2ZIeoB2OecumxahaQmPKVHNpCQZBXHTCA
	Xxf0SM1QtmjBLaJs7pGtmy5PxPtaQohg2nhrmCHxn5nWLc5HcP4rPqAziRSqHBo/NsgqGg==
X-Google-Smtp-Source: AGHT+IHxHkUOeTSt0Ck1N2rcGF0weh2NwynRQjYw7G2qn2pRshjv8yqjuJbYZCLEIEAF1JGZCZRhGeLn
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:b8e:b0:40e:cee1:a3f1 with SMTP id
 fl14-20020a05600c0b8e00b0040ecee1a3f1mr9662wmb.1.1706182364321; Thu, 25 Jan
 2024 03:32:44 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:22 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; i=ardb@kernel.org;
 h=from:subject; bh=PKWmule5OrE2bPivbVWTqIoJwY0uJ2wdrmc5K/+7smk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT663+0nAxozus5wUbzy1OXrD+cV2V7v20XxsYTc5+k
 f13z29xRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI9L2MDL372TmuvJBbWXus
 /djCrQU5T59Uznngy6q5dE+XJs/UljWMDHfzts/v7rPvUt7NVRC76GbrZakMA56gShW1vI1qEt2 P2AA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-22-ardb+git@google.com>
Subject: [PATCH v2 03/17] x86/startup_64: Simplify CR4 handling in startup code
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
index 6d24c2014759..2d361e0ac74e 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -179,6 +179,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 1:
 
+	/*
+	 * Define a mask of CR4 bits to preserve. PAE and LA57 cannot be
+	 * modified while paging remains enabled. PGE will be toggled below if
+	 * it is already set.
+	 */
+	orl	$(X86_CR4_PAE | X86_CR4_PGE | X86_CR4_LA57), %edx
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


