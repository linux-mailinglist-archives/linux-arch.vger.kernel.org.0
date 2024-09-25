Return-Path: <linux-arch+bounces-7416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DB9862EA
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0346287E77
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B250192B84;
	Wed, 25 Sep 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4Rppe0o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A01922F5
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276560; cv=none; b=RxoobmmXM+39K9H8LfrmhgA7jc4ziiBDfTFiK8zSTNogVkUQanCRlL5HmbnXwzG9DgSiMpKSoht8FMCbeI/Af3ZMqRru+GoGdGHUZkn/bKNxS98Q3UhSiGLUq1kWJGGeOpcNs3A+sroocAsF1FRq9gRy+vzDZgVFXH1Ope3kIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276560; c=relaxed/simple;
	bh=i/QYg4imAjIe1bwTsD55fhiHAflGFWUqPqRf587cmXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgzoE777BNWqdW7LPPolRJtmsZ0uanPUnrWUOEGXp4or/E1HjhwjcdE7fWon5gVgnMH4SR+qDKNSaqeWzn77ds6U3fybSmtbNz4xgEjZfCslSF5r3xl2eKuYJ7G9Nbyqtnmbcu+2Qc4XWEI2Xady1IGDbYLrOCKg85RVxBWz10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4Rppe0o; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1dc0585fbfso9534349276.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276556; x=1727881356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDR79FvO/p7pnSynPl14YMv6NBkHhQBDE9t/OHYGGd4=;
        b=t4Rppe0oOZrM8rrVvSNlggls1ZRJPpECq26qFnMncuOtFgzJr46mGusEymy3qWdvjG
         OkmwarU5hNsJqz/Wh5t61KCFoWUz+AuEgMqrOJ1TazD5+6aIFjevSDXJbKGmDSqTX7Ew
         CCDANtXnw+qfm76PgKJlBQWSB6BVvF38zmAyKZeZifaZ3dAQZc/naSXMoWSrWh54iiZu
         19+JCAkmeYxbqwZHm1oMglO4xPvB/zNYVQddPlc5M9ZsGsOYzlPE3GC8tDYY4nhgyeBS
         TJ5ONJAIqyf9vEuBbIouLLhXZfht7FqE/E141vxkUC/oXnxa2811TyADIndgQmoWmG7P
         kKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276556; x=1727881356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDR79FvO/p7pnSynPl14YMv6NBkHhQBDE9t/OHYGGd4=;
        b=Dd2jFZ5Qcaz/Hu5i+Ofpiyp3A7vRtQdXxrAaxZa87bbFrB2USQxRw8AyhOXdhCYim7
         Y8QC/am/KplAtIlvkQhBQ6NrlmexhTskkFaOEkAkod3/Iqhp5/EhP4NpobCfNMIyX0ps
         4ujsfC1juxaV6r5tQotaRK1EGDII4+1RlU7NjAuAq+roYFTthRAL1kajPXfXh7V7129G
         CeQZQ6crShHIupfeqXYoRbcB3N81fjfS7DmGlZ0FlBeFqz4wfL0mKZxRkRlzp45rl1nM
         aYsmY0RaxnVh428F0HOpo3aofA1c9w/p4N8n4GIozjxIQ5A82dqCHaQxgo/k21C+qBsS
         esJw==
X-Forwarded-Encrypted: i=1; AJvYcCXeyzTv+8wTof5njmuWa2Lp2ADWgk/YSO/e5wGziZaMuRlLRy6Zx/Aq5Jnx7g3mHV7xnar0mcFu4cN7@vger.kernel.org
X-Gm-Message-State: AOJu0YzYy4pHxYxPnn48k6Hc8ZrabuhJTg9uPMVGHRo0DK1c8wv5clq4
	rfxytcmqI5Rfx+dNUD3a7If7C9Th924/fNnMbpqavIDdL8whuHa1tgLTAi6+TEJPkDdmag==
X-Google-Smtp-Source: AGHT+IHZ4KYfHMEhV3OEcung24V1cc8XfcFAbHD7O3r+Hgg2lidAI5AomtBdq038iHk4HR3+YtV8+eXL
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5b:ec8:0:b0:e0b:f93:fe8c with SMTP id
 3f1490d57ef6-e24d47abf13mr23895276.0.1727276555668; Wed, 25 Sep 2024 08:02:35
 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:18 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4435; i=ardb@kernel.org;
 h=from:subject; bh=GHJcalcWc5Qb+zlhfpCjetJZ0xMQ4h6Eadch5mSu/kI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6tGDolHZO8I/hR3x3e/2aucUz1XW9pJNyVMcgt6LK
 d6perupo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkjgkjw6k/n413NQiwSlie
 DnVk14nq3/xeMf2gfMyRHcx1Ja3nuRj+h2Vr7vj9abJ2U31nzqv2/TMymqLWPwla++d7/1o/hhv mDAA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-48-ardb+git@google.com>
Subject: [RFC PATCH 18/28] x86/boot/64: Determine VA/PA offset before entering
 C code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Implicit absolute symbol references (e.g., taking the address of a
global variable) must be avoided in the C code that runs from the early
1:1 mapping of the kernel, given that this is a practice that violates
assumptions on the part of the toolchain. I.e., RIP-relative and
absolute references are expected to produce the same values, and so the
compiler is free to choose either. However, the code currently assumes
that RIP-relative references are never emitted here.

So an explicit virtual-to-physical offset needs to be used instead to
derive the kernel virtual addresses of _text and _end, instead of simply
taking the addresses and assuming that the compiler will not choose to
use a RIP-relative references in this particular case.

Currently, phys_base is already used to perform such calculations, but
it is derived from the kernel virtual address of _text, which is taken
using an implicit absolute symbol reference. So instead, derive this
VA-to-PA offset in asm code, using the kernel VA of common_startup_64
(which we already keep in a global variable for other reasons), and pass
it to the C startup code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/setup.h | 2 +-
 arch/x86/kernel/head64.c     | 8 +++++---
 arch/x86/kernel/head_64.S    | 9 ++++++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 0667b2a88614..85f4fde3515c 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -49,7 +49,7 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index d4398261ad81..de33ac34773c 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -138,12 +138,14 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be accessed using RIP_REL_REF().
+ * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
+ * by subtracting p2v_offset from the RIP-relative address.
  */
-unsigned long __head __startup_64(unsigned long physaddr,
+unsigned long __head __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
+	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
 	pgdval_t *pgd;
@@ -163,7 +165,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = __START_KERNEL_map + p2v_offset;
 	RIP_REL_REF(phys_base) = load_delta;
 
 	/* Is the address not 2M aligned? */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index ab6ccee81493..db71cf64204b 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -99,13 +99,20 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
+	/*
+	 * Use the 1:1 physical and kernel virtual addresses of
+	 * common_startup_64 to determine the physical-to-virtual offset, and
+	 * pass it as the first argument to __startup_64().
+	 */
+	leaq	common_startup_64(%rip), %rdi
+	subq	0f(%rip), %rdi
+
 	/*
 	 * Perform pagetable fixups. Additionally, if SME is active, encrypt
 	 * the kernel and retrieve the modifier (SME encryption mask if SME
 	 * is active) to be added to the initial pgdir entry that will be
 	 * programmed into CR3.
 	 */
-	leaq	_text(%rip), %rdi
 	movq	%r15, %rsi
 	call	__startup_64
 
-- 
2.46.0.792.g87dc391469-goog


