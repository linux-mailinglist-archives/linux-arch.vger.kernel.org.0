Return-Path: <linux-arch+bounces-1796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64348411C0
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A296A1C2375D
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C92815B311;
	Mon, 29 Jan 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PI2zoCmS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54A15B2E3
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551577; cv=none; b=EJ4m2RWlyOIdnVwQ+wp7AOijJjGJmp5hPzYm5tYkdGxvAzb/52JRzkbN+xy+V9Ng7UKHcGW0lFAa1wY3PM7KAwYXxXqGgKnVKAzjS5VpItXuN63VbgK+3HIcxIMySiqEYq9Y4qpYPM+Q6Z/38DlRkUl0aKvcs8/fw3p66cdf5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551577; c=relaxed/simple;
	bh=q9aqq8TxofJ+IbL58aBuKCqKThJaXrgTFJRKYbTq++8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p0LesRM/MHG99POJd4zd3V2vaWZbPV1VwMe42pGAgvOHAuwCf7JK1ILcF2mQZ5ztTAbxatKcgmGtHoDPe118grYO/7eRhndPbhB+dji/UfGN5iducPqttegETiCj39MUFRhfWxpDQIuOHGFGd7INrneN6/Arr3zNpC5Ccp5eE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PI2zoCmS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efe82b835fso61584447b3.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551574; x=1707156374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M59gqHs6X4RPZ31jkw+MshCoOf2mD10mD/ghxicfQU0=;
        b=PI2zoCmSh14+b4AA5jJR2sX2z9H17Q65a3h8bGjuLx9dY9bwym/qVfeZOru9Wwm0lx
         wiohVPoecIwJ0lUbMKsVumbnStU26Ng9U9ds8aL5kS5HJoIoqSxYHtvBrjVI3Uqj0Xru
         h96xMahc+oVaWvAm3bOxq9VcC6XzxhrZaGwCupwwFmldsahlIGhZBnMtlNKJRjpvmWB/
         S09VbtlXvSrTCWErgmoXiDi9vBZn5MQZyn6NLg/pLFj7Q0iD05slwkq4oEUsWaC1zXAU
         Y5zkQ6mD/1Kg6a7NSXJIHuKw7j+dv8AMXu4ZwBHxghuqhDjDHhpVHfMDbjbI8DBk2kfR
         ausA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551574; x=1707156374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M59gqHs6X4RPZ31jkw+MshCoOf2mD10mD/ghxicfQU0=;
        b=EjUpOpjnMBOUrn2W9MRuejqPn0o9W94kIUZxQO/mDONw579dIrPhQaAluiubkBfZBI
         F2vKG5b9LBh1QG+UAEgzjsaHWBhviyB25tFOohEA+2AyoJ847SXH+leEVT/MLhHMhjYe
         D9KME0b0EhtQJ7ORpAm/EtcaHv4Iqtyl0wrl7mUexqBpj3HvvLloNypdeo+L/o4VPG8y
         9NmtdtHlPaknQYkDfLBQMYg15qyHLa5fjjxUBHtX5SOGUZb0nAjFo43vvvQX5pFTLmxH
         WRQMSq3UfovT+LKum19LzvJQGCFKTdCSDNV+oi4/r7D3YMz2lAk5ggqWSCYs5rW5Br1I
         /IFA==
X-Gm-Message-State: AOJu0YzBrpDq6DlSaGlxGAuZSuw8L3pPLN8VvYCeypyfZrtJcmpxqOiZ
	GWdb4gUoKcOzw7sisyg1KeFu9LdZSM1p8px7U0kh4wpCbj3iA8x0UZQVGE4Frqi0fyycFw==
X-Google-Smtp-Source: AGHT+IFKsXEen3EWZg9GhnUEMC4esMp++s/hxM7yTCMDL5+CtA/pBJk6xsNb+SSidJj/K445XegU9it+
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:9a88:0:b0:5fb:63fc:fac8 with SMTP id
 r130-20020a819a88000000b005fb63fcfac8mr2074385ywg.8.1706551574143; Mon, 29
 Jan 2024 10:06:14 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:22 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=ardb@kernel.org;
 h=from:subject; bh=ZbpL85fPGajjpfnYR9ri/bu07iizUhPZX6zRx/L0fxw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7iyezZ8/20v2498Hj1helL98vOvzjH/OrvzFPD01z6
 WVvCTv1u6OUhUGMg0FWTJFFYPbfdztPT5SqdZ4lCzOHlQlkCAMXpwBMpDqI4a/I1ZMTrb8Ks7u2
 Rx90kNBJu3H3p+ZT9ir3nhQO89melQIMf0WfiB3aZdCac9RvY2/CzGcL9fXyZjqd61Fv+sBuM7d mGQcA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-40-ardb+git@google.com>
Subject: [PATCH v3 19/19] x86/startup_64: Don't bother setting up GS before
 the kernel is mapped
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

The code that executes from the early 1:1 mapping of the kernel should
set up the kernel page tables and nothing else. C code that is linked
into this code path is severely restricted in what it can do, and is
therefore required to remain uninstrumented. It also built with -fPIC
and without stack protector support.

This makes it unnecessary to enable per-CPU variable access this early,
and for the boot CPU, the initialization that occurs in the common CPU
startup path is sufficient.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index e671caafd932..ae211cb62a1e 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -76,13 +76,6 @@ SYM_CODE_START_LOCAL(primary_startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
-	/* Setup GSBASE to allow stack canary access for C code */
-	movl	$MSR_GS_BASE, %ecx
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-	movl	%edx, %eax
-	shrq	$32,  %rdx
-	wrmsr
-
 	call	startup_64_setup_env
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
-- 
2.43.0.429.g432eaa2c6b-goog


