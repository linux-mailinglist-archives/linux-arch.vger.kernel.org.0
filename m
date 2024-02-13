Return-Path: <linux-arch+bounces-2288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E748530BB
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28CE281C30
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51425524AD;
	Tue, 13 Feb 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqgCL7dM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420951C40
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828133; cv=none; b=dtyUkHLH1gXaBCrb6qYaX+ZvIrswUawn689rNSo6E8uPuibLHnHdmFjy3FQ8EI0GJ83WBXYyLQ6AJ4biIWW6B56kA/+SDxdRbw4PY7rELhrsmsX5RIlElXeVzDl8G07L+TFwKr0bkPJkSsk2O1HEn1nMUFWzCbkySuBF1DsdMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828133; c=relaxed/simple;
	bh=y9rxsCe7t3+BoRvciY7zzDK+lsJfA46YxMM4xo0hlg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=clfEwnu0L5CF6M5fFvOm5EO9Mqkpirqbz+4AG3FGDkTZRVgt7icAL/EjgR9KH1UIqA8vKyJHsq/T+0IxwXXv2TWxgI041W8BG3tdtCzx2cWleZJSImptjMGb1OCM8tbnPGVbLayHbmrFxETVUkQiir/ZFeKaMddIeq5sltEQsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqgCL7dM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604832bcbd0so92477467b3.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 04:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828131; x=1708432931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCp/zoIzhRhhb9JUvWveq8Y/lRzJCxLp1biyCfwnfq0=;
        b=vqgCL7dMY/OFJl8YlLz32pwDD/XuxbQr5hLcfE4Gq0b+kPvmqrflXFRbpGLnIszomv
         BsnEKi82TtH8Sjs9c0g06lplf5Cxmryt9EQIRlvy9sc8WkgxbxPfH8+03WdFZkiFdbIU
         SS6H2buQAdnY82a8LZs8nBuVFtyM5Ii3gdBYb7DQoAyI1ZVKNOSXC0+8XbQ1bUqlhpjw
         fdxTva6JI6b8IapQF3mrfkuVPcHE+cmpvTThBGYLHfdAvazfo+ac5LyBLirMx51fY60i
         H3v7L9OFgccwAFEQ1fo3emfMczMcfCF+u4MsZXdVGKIzqAm3i6+Fxm7b4XilbJUi6eEt
         54FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828131; x=1708432931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCp/zoIzhRhhb9JUvWveq8Y/lRzJCxLp1biyCfwnfq0=;
        b=VeWuU4uRjHL1nHqWnxl/ChcJe37mw6qQrmeEAaSoSE9YOnLPv1OwAZJbcAezLeWlli
         +wH4AnGZhEnB+ViEb2yigpetagomxQ2Z1OzOUZmyNxnVey+rVTtAf2hLGT0wuJXZEJPy
         e7vZWC/JjRJJ+js8sMZSe7plNtP3o4h1ZuPTH/SlmajONh5iR99vBa3Vl4RibCGEFNcD
         Wc70vgdfO7KmhAOF+GkvMqng79FHLjZMF8BKOx+ldo8sJrVbz7/AjLdCrBMVl0XeiDaD
         EjhlYTcUnX8c3uFJ6oZ5Koynl/wXIQAuyMQaNrxUpSS6fQp7Ca1ahV/YM6U+cxK9jbB3
         /rtg==
X-Gm-Message-State: AOJu0YzZWP7wLDSxd68JCV6v8kz6EW9w2ktG+UVaNMBfSQGJLaOAR+Wv
	yZzhKuqEhxOumcJCkx6hv+0Fk/1wOuTkvYK5I3r8nt9Qlvx/w9hopGu9ZyojIV9gx/qRHA==
X-Google-Smtp-Source: AGHT+IGsW3keBZXPy7F4/9lZjwJJzWayDCo+seSOOyeUx9r/VQaHkToEqzRzO0F2HfL5SWo3gImg3hPS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:6d05:0:b0:607:9963:2dd4 with SMTP id
 i5-20020a816d05000000b0060799632dd4mr90739ywc.9.1707828130803; Tue, 13 Feb
 2024 04:42:10 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:48 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3321; i=ardb@kernel.org;
 h=from:subject; bh=z98YWbAEHVe7Ntbv2WAOVJQ9O8vTY0tfpKYTE0xX9/E=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV0ck841z3bDM4lraYBmROE2A0KGp8WRh3hbUm0T2C9Z
 bj2lENHKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmMj+XYwM8/bZqcV2fOwPq966
 6h2LxWvenZlbOGWbAk95ne/M2CKXxshwU41PiU1nTfbReNcy8diKz7P1jp4JEnhypeRl+8m1ga9 ZAA==
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-17-ardb+git@google.com>
Subject: [PATCH v4 04/11] x86/startup_64: Defer assignment of 5-level paging
 global variables
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

Assigning the 5-level paging related global variables from the earliest
C code using explicit references that use the 1:1 translation of memory
is unnecessary, as the startup code itself does not rely on them to
create the initial page tables, and this is all it should be doing. So
defer these assignments to the primary C entry code that executes via
the ordinary kernel virtual mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 44 +++++++-------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4b08e321d168..4bcbd4ae2dc6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -23,6 +23,7 @@
 #include <linux/pgtable.h>
 
 #include <asm/asm.h>
+#include <asm/page_64.h>
 #include <asm/processor.h>
 #include <asm/proto.h>
 #include <asm/smp.h>
@@ -77,24 +78,11 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
-#ifdef CONFIG_X86_5LEVEL
-static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
-{
-	return ptr - (void *)_text + (void *)physaddr;
-}
-
-static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
+static inline bool check_la57_support(void)
 {
-	return fixup_pointer(ptr, physaddr);
-}
-
-static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
+	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+		return false;
 
-static bool __head check_la57_support(unsigned long physaddr)
-{
 	/*
 	 * 5-level paging is detected and enabled at kernel decompression
 	 * stage. Only check if it has been enabled there.
@@ -102,21 +90,8 @@ static bool __head check_la57_support(unsigned long physaddr)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
-	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
-	*fixup_int(&pgdir_shift, physaddr) = 48;
-	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
-	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
-	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
-	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
-
 	return true;
 }
-#else
-static bool __head check_la57_support(unsigned long physaddr)
-{
-	return false;
-}
-#endif
 
 static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
@@ -180,7 +155,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	bool la57;
 	int i;
 
-	la57 = check_la57_support(physaddr);
+	la57 = check_la57_support();
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -463,6 +438,15 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
+	if (check_la57_support()) {
+		__pgtable_l5_enabled	= 1;
+		pgdir_shift		= 48;
+		ptrs_per_p4d		= 512;
+		page_offset_base	= __PAGE_OFFSET_BASE_L5;
+		vmalloc_base		= __VMALLOC_BASE_L5;
+		vmemmap_base		= __VMEMMAP_BASE_L5;
+	}
+
 	cr4_init_shadow();
 
 	/* Kill off the identity-map trampoline */
-- 
2.43.0.687.g38aa6559b0-goog


