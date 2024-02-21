Return-Path: <linux-arch+bounces-2568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47B385D725
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79E71C22FE8
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440D04DA10;
	Wed, 21 Feb 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwF6MfSe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EF4D9ED
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515357; cv=none; b=tJvK7DJrnuqQ7XLKdgJuM/ywZdnlPwtaRw1lB05j/rSV56qm4AdHOzDVxma71u0XD3jGMq8PaKE6niw7ey8/XnNghI27z8N9N7EiHcGMOUvovfjYoEjuUjmzJPcMBRF3mIttMDPduyHUubu8dLnO4fJLIMOT5ji8iUl7seIHxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515357; c=relaxed/simple;
	bh=IKzSvD/LgGiOgyH8nDLzJUWhN/QyWc5LsEQ67nR9hkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTHqK1KqlT0F97fvHmwAVMbbgL1V+pCV4ivXFeJNCscmAwNxyX25zIWyXnTl8uR/N5VXAzDCAy9UIqd0hSHG28AW7/uz4CKpmAXgCOYrH3ph/Ns5B7EGiTsZkNnSC5m0IMV6aRhnCJITwhEMYBVDYi6LN55gpbVcPOMLEwX7UQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwF6MfSe; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33d29de76abso1976601f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515354; x=1709120154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMaXkJDSba/rz2ejEwTszeJPuP18TapiV6QGh3kcGw8=;
        b=mwF6MfSeJzcARIy20xygLsVbqpermBNOVRlehzAQ/Ekcw1vTyPZNoQ0zkHohP99j7A
         q2M+Zsl2KzXwq5g4Kyzo/RViIjQAZ0k7rSnHw4mkfj3yhCIjEsFDHkhOJ2ONfEltlTsb
         pZ9eStKVUcS4ZI1XJa4ez6n/v5869ge1NgSYtZF7QTf3FWbitU+8jUSpqStDbIc72FXR
         Gi+k9T09Y7+Is/dMAACWtMpuyaYFkHOl2H/qZyYT1kNaTtruJBJRPMApkq2Zr5jx82VT
         6TDc2F5gLJYo/bQNbEuoLg+xm6piWeuQQF2Qol/JEpZ+2ZveDZeq54yjsb04Mv2crxfl
         Db2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515354; x=1709120154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMaXkJDSba/rz2ejEwTszeJPuP18TapiV6QGh3kcGw8=;
        b=OnsXnbYDr7zWgp6+WV7ZTikII+klninX9SOTYwzJC/3ogMD6OvOH7Dvv84+QJB/If+
         OPouYDxsBQ9n2tXv+YxwIufdx/lssH2YRycGeVmLe0gk5vXxbP7QRi6uvmwFhssaUnXu
         WnLZgdHhbuY40Rp1n5ba5OKG0gSHplrBKQGYB50v+NKicHRN+Qfoh37pdtVGdpBYG2oS
         vgMucryDlzwvOvVRGeve6oUeh/p+36xGcgErwAyMENTdDz6VwNeBbi7Q4HNi/KC1JJYG
         W5gAsPxENQJNIPj9grE/nwJxE+QNdVbPPD0LdbghgLO7mrCuZFB41sskx9TuAh2mpDOP
         me9A==
X-Forwarded-Encrypted: i=1; AJvYcCVp1I/13q/outnl0LpIaRwjHDLuQ3ch5Qd3cpf+I1/d7v/kEBGbxB8VT0c41Avz463bPtybiaeQd1salGvkQd0FmVmZSxaT9WZd5g==
X-Gm-Message-State: AOJu0YxlyKBATI5Ezek3DhXMNNm736ORxO2/p8rSGC3ZN962fPALAJE9
	gWV0CJQoSJZAG1u/ayfVltpNwo2l8tskJUQj7hCHaU0o15SU2FQIn2h3SVVDzWXFbSB33A==
X-Google-Smtp-Source: AGHT+IHjbsQ99wPRfqvTZnh9jI8yDBCMg/ZDepDe9U8HKt1m2JxIMbi2AiQhPQh+6hbftqgNMrl4Ini5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:5a8f:0:b0:33d:1720:87e5 with SMTP id
 bp15-20020a5d5a8f000000b0033d172087e5mr31048wrb.7.1708515353734; Wed, 21 Feb
 2024 03:35:53 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:15 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3963; i=ardb@kernel.org;
 h=from:subject; bh=94XZSCg7mCe31gx3p7nGco09u3mc8zaP+76NhJPF6Y4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/Q/T726tcz/f/oVTLUTl/2l27j+Pc11F7+nPCk591
 RSXHezZUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSu52R4eCDV/8SvmkZ+zZJ
 7Vv3NmFm4aOAZ0oPxJpFP1+Tlll/r5qR4RHzlsOMhtcT5jyK6uDS/rHj/b4luWd+coh0iKfMOip nxQkA
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-26-ardb+git@google.com>
Subject: [PATCH v5 08/16] x86/startup_64: Defer assignment of 5-level paging
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
 arch/x86/include/asm/pgtable_64_types.h |  2 +-
 arch/x86/kernel/head64.c                | 44 +++++++-------------
 2 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 38b54b992f32..9053dfe9fa03 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -21,9 +21,9 @@ typedef unsigned long	pgprotval_t;
 typedef struct { pteval_t pte; } pte_t;
 typedef struct { pmdval_t pmd; } pmd_t;
 
-#ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled;
 
+#ifdef CONFIG_X86_5LEVEL
 #ifdef USE_EARLY_PGTABLE_L5
 /*
  * cpu_feature_enabled() is not available in early boot code.
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 72351c3121a6..deaaea3280d9 100644
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
@@ -465,6 +440,15 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
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
2.44.0.rc0.258.g7320e95886-goog


