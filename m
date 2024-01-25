Return-Path: <linux-arch+bounces-1573-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D01183C0EA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F2B1C2048B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0450A85;
	Thu, 25 Jan 2024 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCgvnz8T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839B45037
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182382; cv=none; b=ceGPVORKqFvrqF9UrQiiiip9DJz0yFDQqcP43Ns/adC015Mdpmk9FcJcqvLDnJDz0mpbcQk6iXdWEsBjxXTpcFODNG7vTtbxCf2jaUYoUthHHo2zvFyIIK/3sfTa+mwmTUN/kOrGqUi56AQnDLkt1pPIiOLXQcS/CsjTLSL0tC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182382; c=relaxed/simple;
	bh=nW9SmCdlADHOE6Omr4PFRwdaZThbp8qbwCml5fp8EWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULD4/h5Lm7Ht1bws4MUQIq/PfA0Th5yPGAHh3WNV2/yp+FZ4fpamKQ0mbJYUe1zhP/ivijAAVHhuPCGjlQojok0YUyZzThVEggjpHReDDtniGaRZGhXm8OX2pzEho2FMW3pl3mCldw6pTsJvppg7NXnmsCL1DlTd19c4VsCzRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCgvnz8T; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc221ed88d9so8738842276.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182380; x=1706787180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdRmN5FNC9Qw8qYorfxYqmWorkk70z2Gc350vuxR288=;
        b=bCgvnz8Txbo20T4ZGLux/SN/pZi6d96ER9IuSuaxP3Gk0zphk0+N2Ppkp4Cc/TeLC7
         pnHrNQTLf2n+UXXUbEnrE+p2zgbErCIQ4ruCbW5pSzMdwiVjGWbnpkrpdawgEFFCCWdA
         X3DcfNwr8Zn3SP67M8B/uG8R2FdS+FuV5lQ/Xw9LQ9RDlRoUgGrtdaRW58cFBZgl0xNC
         Qpwnt+4DX/IKygmLj03jF0eqVmugP6QB3B4Gqv74lhxkKukq0Hb4p1+rc1E1DAykFpmu
         Xj+BAARNwWMt0jNwvQG/DI2Ro22zMPYy0NeH8Ey18fbDk7ApNkqENThkKMfAzYvVYosj
         mKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182380; x=1706787180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdRmN5FNC9Qw8qYorfxYqmWorkk70z2Gc350vuxR288=;
        b=RIh2q9hQzq3uEmSUHyKkYeN6EdvHWoG3zMuVHel9ZbzpvOW44558nwfHywxe1EuLs4
         IVsOJnY8Dv5ySRRmFd0tGZ6CDFVlBDEWSrFUapvprvR7S4LbLYMcjcsTskWwIJUyjYxl
         bpEi56AiyrUBxUHUe5b5ZquPKP1+ZqmBLh6MpH5D2L1jmdp/eCMx+hf8gQ76A/pUeKsu
         yCu3wQjGrt0UpowyVsbbVPn9SJgXQP723kdXgkO2FtMx+XmdAAX1lFdK1zbbNGrfq5wi
         ZtHxabRzMrdDwHiQzEfl8csA92eYjRy9dzQbAgNbo79K8SYf8bHwRDKM/4OGcFgT2zvD
         VREg==
X-Gm-Message-State: AOJu0YwHbr1eMEM4ewfiXJB0OGlcVxIRYF17+YyzEOiaENp3yOqtD2oz
	DaAPcfC60KXl1RpMTPxTttOWRSDTqcN0hmTnAgw8zJZ/QMFO81rXKGZNNwd0yIFJndeK+w==
X-Google-Smtp-Source: AGHT+IHDc2/5/0E5j8SgTMQ5k2iNKR0mjItM/KC4Qufeqbxsivnk6byCOTNas7euch7jxZEFWYQe7+SR
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2407:b0:dc2:65e2:58f3 with SMTP id
 dr7-20020a056902240700b00dc265e258f3mr85436ybb.7.1706182380556; Thu, 25 Jan
 2024 03:33:00 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:29 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3942; i=ardb@kernel.org;
 h=from:subject; bh=NDQz8Ub0YeUmHEZHj1/2gw+nBRrbtOLR0AuDt5JEbB0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT6+tOhnUbZt/4pv7feq263bHT+yJ7HN1ebknYPeV/T
 kbiHuunHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAifKYMf+Ue7yjove9+NW3v
 qrOrE8WS/Cq02Bf8ZNqfx9ay/nlsqxDDHy67p271b9cX1GyKdPLS1Im3nZDa0XjGtoK/97ZL+Rx VXgA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-29-ardb+git@google.com>
Subject: [PATCH v2 10/17] x86/head64: Move early startup code into __pitext
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

The boot CPU runs some early startup C code using a 1:1 mapping of
memory, which deviates from the normal kernel virtual mapping that is
used for calculating statically initialized pointer variables.

This makes it necessary to strictly limit which C code will actually be
called from that early boot path. Implement this by moving the early
startup code into __pitext.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c  |  9 ++++----
 arch/x86/kernel/head_64.S | 24 ++++++++++++--------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 993d888a3172..079e1adc6121 100644
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
index b8704ac1a4da..5defefcc7f50 100644
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


