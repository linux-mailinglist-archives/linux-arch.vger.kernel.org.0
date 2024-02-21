Return-Path: <linux-arch+bounces-2561-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B9385D717
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BD8282F2A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7EA4597C;
	Wed, 21 Feb 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sa0rlvb6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90E45945
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515339; cv=none; b=OgbUSyHJsFJ+9lQNwHEp5qAf51tHIzHkIKluPIe9SxPG17gj/Zav+hWxKjxuS/f6fNLbZUwONx4KOS4It+6lpPSy7ivYvm+X79aqXYK5FX7/YZKUtpsMDvk2MPr4uiZ7/u65ygTL4uWFs9zr15a+Y7Ztmg2zam9nE+tlnZyZSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515339; c=relaxed/simple;
	bh=py9Y+djzPQO6EmF7F9NJ1i5hAa8K3oSBQk/6uhAH298=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPUPLE0oPDHH2XP3RhtuocBLzffz7qRkUcnl4PHg80RtbSOIdYSxw6ezvpOYKlA4I8K44mRzODamBXC0aBtjXhB5avoB5Snnz4Jps5ihfti3ykdm2Hpk5WpLQta9LcVJlwdja3ZrQSPY2SjD5hAliUwIPlJ7Vqo3E6Zm8mVhyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sa0rlvb6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60802b0afd2so44802507b3.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515336; x=1709120136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qW/A0wjJqrnttxBCkESXpcpyFK56vfk0Gs3tCOMJv4Y=;
        b=sa0rlvb67bK7UGBfCneNhuTBOusj6yh3gqY3BLcjqsMfCLkpbHkoRkce95XIrG3E/5
         PBxSwov3CEboQPxyDsJU8zqMQDyD5Y6hDz748psgvN19HJY2jm7umu6H6NX2R6gbubEi
         movYjlZ8hvQRzvIJcgorqjSJ0fwggFF8INj9lUGuPtjJTghM34Gg22J18u6qlcp8PObu
         oz1MK/MfP0TWm6ObVmghApWma7jWjB4DC88TLFMt8tGsfFvdCZwmwzL/zgzGubsa5I89
         32+HFAKu8+VJ+apj8JrWjrniU0+lJ1RZ++mU+ejZOdC0OvFjFzfZGdCU0wcnU6LsMnBD
         wAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515336; x=1709120136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qW/A0wjJqrnttxBCkESXpcpyFK56vfk0Gs3tCOMJv4Y=;
        b=j7B5XWMh3sKyiolGBOrLPXyIVjAumcakj6V04A07/FxEFMmF5jM9a0s+3AihNontUQ
         eKZ5kmT+YjLms4dQTpoQk7T+gcMGlsv8p40lSt7+wkB29hLxt7XwO+5FynkcwgpNd6Pw
         ZV1+QXFiAleZNkFDy7gjopey2r/mT38hZCQPDRVQ4sJwHyIZZzwx+6/GWeIktTCt1r4m
         H/3x7XwR3VHQvwZVTkNlfnfWSCuS/GUdhxzR5tR3EAoF/YK971Z1nwofyDn85U+L9JEq
         5S+Mo5FPO0efdE5VxNLfSNvY5Nvk066pvWWykx2PehtRBKFio0YdvVFkHahEQs2cZRml
         +VqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlo9bf5Du020DbKkxBWVjj2BzwW2dZm0qJmZRsOmPpXAKojyHjw3aSGOX/b1Wj8nfs84NNnhAsez+Kp85r4fXJeOTDQU0tff8A7Q==
X-Gm-Message-State: AOJu0YwKzMtlI/pZEKuFh2zBwavjw8LH2hkD7M6XBkHjVwRslqCgqEWx
	m44St37hT1Y5KZgsvEvyhGZXSgRED12k0avb5C+Pp8JXSKYeP6v4HlgctrdY9NfgXrtsbA==
X-Google-Smtp-Source: AGHT+IGiMJD52uZON/RU30Dr1ARXomCp+ofU7VN13ZzAwGe5Q0FoIxKq+Mo7hRtI+nMB9sdyP7jtj8yX
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:e904:0:b0:607:8f65:5433 with SMTP id
 s4-20020a0de904000000b006078f655433mr4327050ywe.4.1708515336661; Wed, 21 Feb
 2024 03:35:36 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:08 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6347; i=ardb@kernel.org;
 h=from:subject; bh=znXuPAQkSUWGkxlryxVinIdceSOSj8FHbeDMB1myZ+Q=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/dflrwLZVwhePf5QQEj9QfXG/7v/HGuIPGUQaL4k9
 aSVsZJ7RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIPj9GhvVz7Ln//KirE/HO
 rxD0imif0jvh897z5Y2batlfK2p+dGVk2LPefEc0wx0r3Q1pNjeEfbl4ux32JMmnPYsL7BZdLKv JBwA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-19-ardb+git@google.com>
Subject: [PATCH v5 01/16] x86/startup_64: Simplify global variable accesses in
 GDT/IDT programming
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

There are two code paths in the startup code to program an IDT: one that
runs from the 1:1 mapping and one that runs from the virtual kernel
mapping. Currently, these are strictly separate because fixup_pointer()
is used on the 1:1 path, which will produce the wrong value when used
while executing from the virtual kernel mapping.

Switch to RIP_REL_REF() so that the two code paths can be merged. Also,
move the GDT and IDT descriptors to the stack so that they can be
referenced directly, rather than via RIP_REL_REF().

Rename startup_64_setup_env() to startup_64_setup_gdt_idt() while at it,
to make the call from assembler self-documenting.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/setup.h |  2 +-
 arch/x86/kernel/head64.c     | 75 ++++++++------------
 arch/x86/kernel/head_64.S    |  4 +-
 3 files changed, 32 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 5c83729c8e71..e61e68d71cba 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -48,7 +48,7 @@ extern unsigned long saved_video_mode;
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
-extern void startup_64_setup_env(unsigned long physbase);
+extern void startup_64_setup_gdt_idt(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index dc0956067944..1d6865eafe6a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
+#include <asm/asm.h>
 #include <asm/processor.h>
 #include <asm/proto.h>
 #include <asm/smp.h>
@@ -76,15 +77,6 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
-/*
- * Address needs to be set at runtime because it references the startup_gdt
- * while the kernel still uses a direct mapping.
- */
-static struct desc_ptr startup_gdt_descr __initdata = {
-	.size = sizeof(startup_gdt)-1,
-	.address = 0,
-};
-
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
@@ -569,62 +561,52 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
  */
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
-static struct desc_ptr bringup_idt_descr = {
-	.size		= (NUM_EXCEPTION_VECTORS * sizeof(gate_desc)) - 1,
-	.address	= 0, /* Set at runtime */
-};
-
-static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
+/* This may run while still in the direct mapping */
+static void __head startup_64_load_idt(void *vc_handler)
 {
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+	struct desc_ptr desc = {
+		.address = (unsigned long)&RIP_REL_REF(bringup_idt_table),
+		.size    = sizeof(bringup_idt_table) - 1,
+	};
 	struct idt_data data;
-	gate_desc desc;
-
-	init_idt_data(&data, n, handler);
-	idt_init_desc(&desc, &data);
-	native_write_idt_entry(idt, n, &desc);
-#endif
-}
+	gate_desc idt_desc;
 
-/* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(unsigned long physbase)
-{
-	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
-	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
-
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		void *handler;
-
-		/* VMM Communication Exception */
-		handler = fixup_pointer(vc_no_ghcb, physbase);
-		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
+	/* @vc_handler is set only for a VMM Communication Exception */
+	if (vc_handler) {
+		init_idt_data(&data, X86_TRAP_VC, vc_handler);
+		idt_init_desc(&idt_desc, &data);
+		native_write_idt_entry((gate_desc *)desc.address, X86_TRAP_VC, &idt_desc);
 	}
 
-	desc->address = (unsigned long)idt;
-	native_load_idt(desc);
+	native_load_idt(&desc);
 }
 
 /* This is used when running on kernel addresses */
 void early_setup_idt(void)
 {
-	/* VMM Communication Exception */
+	void *handler = NULL;
+
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 		setup_ghcb();
-		set_bringup_idt_handler(bringup_idt_table, X86_TRAP_VC, vc_boot_ghcb);
+		handler = vc_boot_ghcb;
 	}
 
-	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
-	native_load_idt(&bringup_idt_descr);
+	startup_64_load_idt(handler);
 }
 
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_gdt_idt(void)
 {
+	void *handler = NULL;
+
+	struct desc_ptr startup_gdt_descr = {
+		.address = (unsigned long)&RIP_REL_REF(startup_gdt),
+		.size    = sizeof(startup_gdt) - 1,
+	};
+
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
@@ -632,5 +614,8 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt(physbase);
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		handler = &RIP_REL_REF(vc_no_ghcb);
+
+	startup_64_load_idt(handler);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d03efb4..3cac98c61066 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -68,8 +68,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
-	leaq	_text(%rip), %rdi
-
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
 	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
@@ -77,7 +75,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
-	call	startup_64_setup_env
+	call	startup_64_setup_gdt_idt
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
-- 
2.44.0.rc0.258.g7320e95886-goog


