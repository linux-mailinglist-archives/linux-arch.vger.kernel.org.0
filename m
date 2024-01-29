Return-Path: <linux-arch+bounces-1786-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957588411AA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4843F2836F7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A194159578;
	Mon, 29 Jan 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3uSkdJ1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B8159560
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551553; cv=none; b=QENKI9LUCLCpaCdQMZyc52nnIz8PsWjmXILMt+ELPkht9oyYjPCSm0ZeX/nBFf/7tFnTU1H1PN31s3r8n1eCTKyoht68nyWE3PqNIbeIQTErrIbgHsg/puVOn8g+dHhtkkgMQvJ8TviJGwWqYM2RPj1ndhxfDxoWbWxJ9Xud6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551553; c=relaxed/simple;
	bh=vnJpTtkwXP8em8CZ9TF/csF2frUk4VGX3QPQ5IolY7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i+ijttvzxm0xVhDCVzKJiIcGBx4WOY5OD11rF6fcBaOYgDHyG26u99djq+8Mqa3AcZGsYayPscB5HizsqbpNmg8TUakOdWoE6I579mSs8pwmgt9aRDhhl4DBdcIG/uE63LSdJjQ1CLwUbDxj7k9gBOfUkWousl4+UvKx8hiH4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3uSkdJ1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4757129276.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551550; x=1707156350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5x1F22voMMyYv1Zr6tqhVy0DTOzfkx0XvX+Zrp+ZGY=;
        b=S3uSkdJ16H3weJLQ/5O4Q3Epqky2y6rRWziWJTHoGi03HYXCwjBFdPoodUKn4RaYrn
         H5Cl/whowaymXw0dKReDC2Oq7XrvPmA+Xnw0i7FP+1eL8qHnImMk0wQmcL9o1K0dYfId
         P+xP9dtpb1ULTYodTcpK2L8er53Gvr+4gOHcDNeOG/BlPJ6kepZBEHsUnWWkQry7C9TX
         yUy/FIaSB+O0bCWKhlroKXmI5qx3NP7LfSapvt97FKICc0yuqEFRsA3c6RK85AuEKS/7
         yUAXmISYC+1p+WCkF6GzTFzlRPxlRS2C8k15LQP6y8HmDx7JV4dOAV/xnpjvem6ld0o9
         kV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551550; x=1707156350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5x1F22voMMyYv1Zr6tqhVy0DTOzfkx0XvX+Zrp+ZGY=;
        b=m7SIwPGzURV69/IZgjIRgRkymHm8PZZ4W2jCO48gEAQ0vPUG/mSTOEilNavEgGcTxq
         UbBOuu3tHpuZONyajFcUPt8NymdB4PeYgjaO8lfaLcyipP4meC//Hzvv3cNQwhNXCP1x
         sQiQd/ZFXca/kVx9fUz51W9+i2Bsypcf2Rppos70ApPOOXLvg/loSxPsVpHdSoRFD8Px
         UX1MFIb//6fk0GY4guItlBYIDmYr15Pbbg0v7Uy2SYNHPGdyYGET8cmr501N7PZRQcXO
         f5ZHLEzBs/n9gXOPi8ueNgN9XE+oJtrrJZmBNKQ6D1AzuhRscFYheVcy2QrQE+YTzU0h
         YovA==
X-Gm-Message-State: AOJu0Yxv0ygsZ1L7tSwWpIh0GwfJK0nPkpMOKooBMv9/7+S71Npe6j62
	3Hlggh2e7M17/xH1q7PuI+lUK77JZibHD7ZDRvGIcrALtIEcg28/f0bkyDzxW3hLqJko5w==
X-Google-Smtp-Source: AGHT+IGgNqs4arPCH5rAGfnn6yAEx3ibS3mxOByBiz/gXz1ea0MTq5J9nfV4BBbOTaOTO6X7O+L/ylT4
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:108f:b0:dc2:23d8:722d with SMTP id
 v15-20020a056902108f00b00dc223d8722dmr2386953ybu.13.1706551550415; Mon, 29
 Jan 2024 10:05:50 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:12 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4031; i=ardb@kernel.org;
 h=from:subject; bh=GRGmQn1xgXFPK1qedgfyRwvXHekb7bPD6uUy2cYh0y8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i5vrWbMWbRB/pTXhQYTroe6r825LXbbdoZi54/syE
 faa5cFLOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEGP4y/OFJ1fCZvC+r871W
 QXDCwtItz6p5Qo1+Beg0rJB627tLQ5mR4Wub4nvV5lBLhY6ik+UvEn+ZrPQ889P7+dUNae+vLHl 0ixcA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-30-ardb+git@google.com>
Subject: [PATCH v3 09/19] x86/head64: Simplify GDT/IDT initialization code
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

There used to be two separate code paths for programming the IDT early:
one that was called via the 1:1 mapping, and one via the kernel virtual
mapping, where the former used explicit pointer fixups to obtain 1:1
mapped addresses.

That distinction is now gone so the GDT/IDT init code can be unified and
simplified accordingly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 57 +++++++-------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a4a380494703..58c58c66dec9 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -59,21 +59,12 @@ EXPORT_SYMBOL(vmemmap_base);
 /*
  * GDT used on the boot CPU before switching to virtual addresses.
  */
-static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
+static struct desc_struct startup_gdt[GDT_ENTRIES] __initconst = {
 	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
 	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
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
 #define __va_symbol(sym) ({						\
 	unsigned long __v;						\
 	asm("movq $" __stringify(sym) ", %0":"=r"(__v));		\
@@ -517,47 +508,32 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
  */
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
-static struct desc_ptr bringup_idt_descr = {
-	.size		= (NUM_EXCEPTION_VECTORS * sizeof(gate_desc)) - 1,
-	.address	= 0, /* Set at runtime */
-};
-
-static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
-{
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	struct idt_data data;
-	gate_desc desc;
-
-	init_idt_data(&data, n, handler);
-	idt_init_desc(&desc, &data);
-	native_write_idt_entry(idt, n, &desc);
-#endif
-}
-
-/* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(void)
+static void early_load_idt(void (*handler)(void))
 {
 	gate_desc *idt = bringup_idt_table;
+	struct desc_ptr bringup_idt_descr;
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		struct idt_data data;
+		gate_desc desc;
 
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
 		/* VMM Communication Exception */
-		set_bringup_idt_handler(idt, X86_TRAP_VC, vc_no_ghcb);
+		init_idt_data(&data, X86_TRAP_VC, handler);
+		idt_init_desc(&desc, &data);
+		native_write_idt_entry(idt, X86_TRAP_VC, &desc);
+	}
 
 	bringup_idt_descr.address = (unsigned long)idt;
+	bringup_idt_descr.size = sizeof(bringup_idt_table);
 	native_load_idt(&bringup_idt_descr);
 }
 
-/* This is used when running on kernel addresses */
 void early_setup_idt(void)
 {
-	/* VMM Communication Exception */
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
 		setup_ghcb();
-		set_bringup_idt_handler(bringup_idt_table, X86_TRAP_VC, vc_boot_ghcb);
-	}
 
-	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
-	native_load_idt(&bringup_idt_descr);
+	early_load_idt(vc_boot_ghcb);
 }
 
 /*
@@ -565,8 +541,11 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_env(void)
 {
+	struct desc_ptr startup_gdt_descr;
+
 	/* Load GDT */
 	startup_gdt_descr.address = (unsigned long)startup_gdt;
+	startup_gdt_descr.size = sizeof(startup_gdt) - 1;
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
@@ -574,5 +553,5 @@ void __head startup_64_setup_env(void)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt();
+	early_load_idt(vc_no_ghcb);
 }
-- 
2.43.0.429.g432eaa2c6b-goog


