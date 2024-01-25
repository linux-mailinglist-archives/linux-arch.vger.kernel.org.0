Return-Path: <linux-arch+bounces-1580-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7F83C0FF
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DA7B24A26
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF65A7AF;
	Thu, 25 Jan 2024 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AliCO759"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE15A783
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182400; cv=none; b=j294Uhh3uKs0og0NUA9rILTPWB98+sD2mHImhknoyEJw6jWheSG4Gt5nAbRgfytmZHnf1gBSo8UkZ+4mtLUC76MntffER6mWW/wo5kfdx+tCe45g+o5jIV6neY0JpZNN/G5HSxXP/6gsz3QdvCWd1i4otUh82YPcIslbNYiF5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182400; c=relaxed/simple;
	bh=OwW6wBuNpjoZwXNRvFnESPahBXLxFOjLZ++ayooCsxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YtxZuSFWpwb6d/wWws6rNqd8h6LHGmDLSXMtq5ol1MrYBHM82BpQTJoboLNgiz0cLs7jbPbYHRHGsQ9+Esr66ri9EKWS7ZwhObbpZXdOhLyhEXI0quAGFSa6x7hyfGM7FypHdcs03tguWVWYnszM+fDYNTYsZZ1iFJ5E46wft5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AliCO759; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-337d70f889cso4211947f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182396; x=1706787196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0LWk2oJk+i7OdHacQS8szXmAws8+WmD6+X8i7Byook=;
        b=AliCO7597hXDkmnwdTs4yN9FpwyZtGs8MJLIoO6nhqoMCS1ngx14/9gZEfasOV+3UD
         AS8u+5+/MDi9atK1hY6r9X4pRwS8k5KKptAhhhzrQlinyEIRkwRVZdyjWbfvWxX/Zquv
         zMcfDNHDAYlRs7qx3zpTgY6dTdBpIypI6sZqjlPzhqSjRUqoNja8l3A4pdl/y2JS+ePe
         wAiNUDUHqwZ3BbJDoSulu3XEwl+PrrHCL2oe2F5E1wfx/TsV065Z9+WUPnHG6kqMCthn
         SqTpFXbaBc3SAlqdLeinoI0/fVUMpb/WnhcdGQ4zZBWIofF445V/png7mgxZFlWf88Ah
         q/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182396; x=1706787196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0LWk2oJk+i7OdHacQS8szXmAws8+WmD6+X8i7Byook=;
        b=Fu8nYw77P1dAGDjF+CmI+r4AKg4Yaz6KwNfGy2I03E3y2SJpZFj58XDyXI9GQ8oj3O
         ACyNfzOPaS+NUr0aq+wb4e4yKK/hAamcyU/I0o1CTAnXklmh3NP9AiNkdOjUW12ngG/s
         nbYeIPFGmHl4NJUq+ypXbyH1rzdhtN7a0YFeJjmShRmVK2zAgExxm52hR3STNqC+n+R9
         MVssiWCSW+RAlFLv61p6QQ+kMD6Id4wjbzvWbA3mu7D2XXPnmjv0S8DVW/pxJT/1vbWN
         jNkcV3Hn24x2EZ/3dAXWEUoH868qYWwEOunkQnyOiF2rqLYV0Gb65ICvPejETc1fpd+S
         lMyQ==
X-Gm-Message-State: AOJu0Yw3q5meaZP78vPp7m23sg6Dth0x7P0qluVogUZr3zwv3KhBV/mV
	Fcx6n1NqrQ6rjbxSIrIyP3fYEyrgECOUtnvvMPq0EXVHQu9YHt9ZucfLt3HhUrqECbkk7g==
X-Google-Smtp-Source: AGHT+IG/Nfpuzk7bgzrZNwvHbfRYXZf+jimIHipf+XjfpPJSWyU5yyhZ8rY9HrGdokg9HeoZMcEye6SG
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:4a04:0:b0:33a:d182:fda1 with SMTP id
 m4-20020a5d4a04000000b0033ad182fda1mr704wrq.11.1706182396410; Thu, 25 Jan
 2024 03:33:16 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:36 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=ardb@kernel.org;
 h=from:subject; bh=hctyhPpJV0WOf9z7vrzpK1P7aPRf6ODhgzfVMyHZJzc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWTG8sTO09G1eh3s38HbSvasYtlpd3913LP1YUZb+y3l
 Gtsejy1o4SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkgx7D94wEFmeVtglT7X2n
 ae2pfHhf8JzyxIQtHd+dJiq5nqrMYmTYsNiqaMdW0aOzHgsVla44+tL+ZWwd59c1V192eaTtZ4v iBAA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-36-ardb+git@google.com>
Subject: [PATCH v2 17/17] x86/startup_64: Don't bother setting up GS before
 the kernel is mapped
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
index 5defefcc7f50..2cce53b2cd70 100644
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


