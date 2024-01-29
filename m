Return-Path: <linux-arch+bounces-1789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA248411B2
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBDB1C24794
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825C215AAA8;
	Mon, 29 Jan 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZD8UOIxr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4015A4A4
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551561; cv=none; b=a6/DSb2m6j7FANCcw9/gQEwc1hyBGEnItB4fJO2BYObdwK/R/vL3+mmcokZO3yzGNS+Cnyt6Jf/XZsr5boSrHf/7/Pfdelj8RTPNqGli4aLCvZ/qo1boRxKyDbzUVO8GUov9lBfiyyl3dR0qJUFGYxT9r7UHcuv/Lxwpd1cIlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551561; c=relaxed/simple;
	bh=7IrvxjfmjsArA7ueoVb4ihX33flmNaxHeDwW0+SLbEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZIkd5BzhqSuoJGorTS752bPtW/MZ5F5ogJ/gBCPieZBx4V2PwKwxiH4sUwDIXdVMzDPncp2NQ36d7QEUBCVjP1oI/dgXuVVhTGcYSe9WcI53mJHCpgRpMWc3V3KpukDmIBCGIH+hyRbLV1343dKfn58UB8o7jjxWPD7H1xokiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZD8UOIxr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603c0e020a6so19774227b3.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551557; x=1707156357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5uVNAFoC2AEC7S4OvYtDKlpwaA5zaGsPfiWByf41yo=;
        b=ZD8UOIxrEwMCy4JAInsIJ84bcGwJ13h74rpJAoc75IU+KOQoUi2vH1aJcYF/XSclWY
         zpBnpXjvKMdlVaVmG9XskEVa3xyjfW5N9yedLFWz2wROXKa+4csMDgoHmg0Lu3vmWHTd
         lQa0mXAoy2ED5R7myb0nNQCbJBWpk8jSO4boAJGvSS+ANQQuI3ZcVVVBkZPjLU3K+XR7
         FrfB/+4VRAZF6dNdXPEq9bK2BHA5ydHXMYqxG/NUsclLsePKeDhsjM1mJZQsTFYT+12V
         Umya7gcN5QORstvgV//AoI72+WLjSl5TpnGB8VoEw9Gio/wvK5gWNlbbu8PDUUKH8qkH
         vK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551557; x=1707156357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5uVNAFoC2AEC7S4OvYtDKlpwaA5zaGsPfiWByf41yo=;
        b=GruALaug8WJjW5YXKLZxmPXKjSTSi6QYT0qT0bWmlXspGDikP06hNfevz42q67DqbM
         OW7s9+gGQrkzpKE3Oh8i7tnA/dP60REeLTWmPrMb2o05XoANUJl3jDkFQHoFX36RNouq
         1VVrw6+hZbGaFfr+lpXCpYTnI2FGNgMkt7Jrggsf9QZ3QwCZzZ15a2vs+sMKkP7saAx8
         biLfKhxZRHMB98fbg7L84ziJSj8d9LsVq7bM8Xyg1LASIm2Kn5HalNBypmGtIFi1+Ic3
         KvL3T/+y8krTmr8M0mDdDYQavIMOYayxcV19xqtxX2vKEvwkOQeJ6VugOe1Ux+Ff1cLw
         7/pw==
X-Gm-Message-State: AOJu0YxQqp5DAPZpdL1LTI+wRIymRUdBLjbwTF4z5w/VL7tDfv30RK3B
	VtzTrYIaCd7gxVu4c32BekzmGhNrQq40FN+6h9PQ/ewd9rPMH7M8YxpkoGuI7b5L9aGi9A==
X-Google-Smtp-Source: AGHT+IEPX/1mTvU9tBV1ZCJamBy0TSW0W0te8Jq+ZIXXz1GsefoW/9OUoSqy2sCKC6Re0GCQKvyvAqLx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:9a14:0:b0:5ff:b07b:fb83 with SMTP id
 r20-20020a819a14000000b005ffb07bfb83mr1279875ywg.4.1706551557485; Mon, 29 Jan
 2024 10:05:57 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:15 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4435; i=ardb@kernel.org;
 h=from:subject; bh=abTz563MnS4V6kIRqijux/WQS0ziAyixwK6axwUq9ik=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7izvdP/zFc827r854em9X48c7So/Wl4U/sPv6fnqQ1
 vE/rD0WHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiB9MYGU5+s3TRaOITdaiq
 bFmgo9uVJuPi6GWe92HL9PRPGv0TzzH8L8t5IjR7i2tZqmH80rqXhUs+b550MjtqX5HksRuOXfK vuQE=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-33-ardb+git@google.com>
Subject: [PATCH v3 12/19] x86/head64: Move early startup code into __pitext
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

The boot CPU runs some early startup C code using a 1:1 mapping of
memory, which deviates from the normal kernel virtual mapping that is
used for calculating statically initialized pointer variables.

This makes it necessary to strictly limit which C code will actually be
called from that early boot path. Implement this by moving the early
startup code into __pitext.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/init.h |  2 --
 arch/x86/kernel/head64.c    |  9 ++++----
 arch/x86/kernel/head_64.S   | 24 ++++++++++++--------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index cc9ccf61b6bd..5f1d3c421f68 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
-#define __head	__section(".head.text")
-
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
 	void *context;			 /* context for alloc_pgt_page */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 58c58c66dec9..0ecd36f5326a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -70,7 +70,8 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initconst = {
 	asm("movq $" __stringify(sym) ", %0":"=r"(__v));		\
 	__v; })
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+static unsigned long __pitext sme_postprocess_startup(struct boot_params *bp,
+						      pmdval_t *pmd)
 {
 	unsigned long vaddr, vaddr_end;
 	int i;
@@ -113,7 +114,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	return sme_get_me_mask();
 }
 
-unsigned long __head __startup_64(struct boot_params *bp)
+unsigned long __pitext __startup_64(struct boot_params *bp)
 {
 	unsigned long physaddr = (unsigned long)_text;
 	unsigned long load_delta, *p;
@@ -508,7 +509,7 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
  */
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
-static void early_load_idt(void (*handler)(void))
+static void __pitext early_load_idt(void (*handler)(void))
 {
 	gate_desc *idt = bringup_idt_table;
 	struct desc_ptr bringup_idt_descr;
@@ -539,7 +540,7 @@ void early_setup_idt(void)
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(void)
+void __pitext startup_64_setup_env(void)
 {
 	struct desc_ptr startup_gdt_descr;
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index b0508e84f756..e671caafd932 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -42,6 +42,15 @@ L3_START_KERNEL = pud_index(__START_KERNEL_map)
 	__HEAD
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
+	UNWIND_HINT_END_OF_STACK
+	jmp	primary_startup_64
+SYM_CODE_END(startup_64)
+
+	__PITEXT
+#include "verify_cpu.S"
+#include "sev_verify_cbit.S"
+
+SYM_CODE_START_LOCAL(primary_startup_64)
 	UNWIND_HINT_END_OF_STACK
 	/*
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
@@ -131,10 +140,12 @@ SYM_CODE_START_NOALIGN(startup_64)
 	movq	%rax, %cr3
 
 	/* Branch to the common startup code at its kernel virtual address */
-	movq	$common_startup_64, %rax
 	ANNOTATE_RETPOLINE_SAFE
-	jmp	*%rax
-SYM_CODE_END(startup_64)
+	jmp	*.Lcommon_startup_64(%rip)
+SYM_CODE_END(primary_startup_64)
+
+	__INITRODATA
+SYM_DATA_LOCAL(.Lcommon_startup_64, .quad common_startup_64)
 
 	.text
 SYM_CODE_START(secondary_startup_64)
@@ -410,9 +421,6 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	int3
 SYM_CODE_END(secondary_startup_64)
 
-#include "verify_cpu.S"
-#include "sev_verify_cbit.S"
-
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_AMD_MEM_ENCRYPT)
 /*
  * Entry point for soft restart of a CPU. Invoked from xxx_play_dead() for
@@ -539,10 +547,8 @@ SYM_CODE_END(early_idt_handler_common)
  * paravirtualized INTERRUPT_RETURN and pv-ops don't work that early.
  *
  * XXX it does, fix this.
- *
- * This handler will end up in the .init.text section and not be
- * available to boot secondary CPUs.
  */
+	__PITEXT
 SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	UNWIND_HINT_IRET_REGS offset=8
 	ENDBR
-- 
2.43.0.429.g432eaa2c6b-goog


