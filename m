Return-Path: <linux-arch+bounces-2388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F9856502
	for <lists+linux-arch@lfdr.de>; Thu, 15 Feb 2024 14:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12ED11C244B1
	for <lists+linux-arch@lfdr.de>; Thu, 15 Feb 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA79912FF7B;
	Thu, 15 Feb 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="if3JtnOl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3413246A;
	Thu, 15 Feb 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005195; cv=none; b=rmudaNwvuUdtlKamucq40UHAkGBHnmEIOWcu3s4CAsrtWzzK08N8RBhjQXo3l/o0mx8SMSSnwKdHfqlgXhBm7Ki6LUtbL/Z/SHB5Gtsbli6MVaLPI9SXz6qeGUweMe5KU5+TzpAMYkOQGWLFrnqY84zaXc0ITmLJk27nM/2e85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005195; c=relaxed/simple;
	bh=rvX6RnOAGGQyJIg0dJjMvKyh7NRfV8yF4YJiANMP+tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnnbTWB9cW++rr+5YIl1uBe3BGSygIe21U0TFgE+nVa/Dr6q6YkohMhoVji+ZWQa5KWe/J6kOTHb7uHUArv5qIeWwxKVVLzO1rKToNq/zPvYnH+feOWkjvUv53ihHqGKLIUEwKrvtHDzTrc+v3RBPBpAH+foW6+bZ41m7iQ6d3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=if3JtnOl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A6FE840E00B2;
	Thu, 15 Feb 2024 13:53:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fQxdII7x4b3R; Thu, 15 Feb 2024 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708005181; bh=fwRh/0oyLIGoZozzIhDH8nJqo40bBjBkFxCW3lPnVPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if3JtnOluEbsHGe3vRDp3u5uO6VuGXzf2MpReQTiQzZyKVL1byGpVSiJORr0rEyIt
	 9LR3NmrJNtvkGS6Hx5OzjGPZZZWWfF01xaDWBlhNRXNG6m2deixZRgg+4joMj/3ZRh
	 WT56pheYZ3fw9BF573COFPDzCWUt+Arsp/JAAW/DKdns0jGi9JGTeGh1z4udxD9iqL
	 cwRAAegyQyXI1ED2XTzaMRr4Zney/Y73e79S4QG8PsLqcVlmrPUSXQcNzNuaXlUqEC
	 wl/sM6bX8nfFnymx2Q2/q4OpOEfAhwTGDMUsRL5PQh/wN0N2BeqrHuc/CROnF165IS
	 +G4L90a5ef6rar+S5ooBj5/CiGZblq+UBpLopzKGXCmpqf6SYwUgxpkz7rjQYN2Kzo
	 eqqde30q578i6c7fXI1leY55iPGjca01fiurtsyKJSC4lqwaIBYcwUK+bAKWBrmpeb
	 jBj4kdlisQ+mj+G2Gkc+luZIHD1GZ78GVTOBYZmnYo9q4qSMi9r7g4lucebS1ZgifQ
	 0vTkpZgmATujQeMM+Hd28eWZ6IV6BinxGr/7I9Gj6XrkQ3kNaDanRCYZ/QlbX5JhZU
	 Q8nDiXVx9rbvFv71KKq/cftrcdhML0qg/NA7172ti13x3av0J3Rhc3sF+DE/mbIEPt
	 jmQcv/9YyZSz5+PI1oHYzevA=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FD5740E016C;
	Thu, 15 Feb 2024 13:52:43 +0000 (UTC)
Date: Thu, 15 Feb 2024 14:52:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 01/11] x86/startup_64: Simplify global variable
 accesses in GDT/IDT programming
Message-ID: <20240215135237.GAZc4XJevmqCjEbbBC@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-14-ardb+git@google.com>
 <20240213200553.GYZcvLoYUNJOPGxoid@fat_crate.local>
 <CAMj1kXG4rSGaB8Q2qFcgOH=dqS0yvR8Ofur=h5C-jq_TqiFzVg@mail.gmail.com>
 <CAMj1kXFdUD_kCh0h1HcpOVoQJNcP11OHB+FJ-=HGfP3RRdy81w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFdUD_kCh0h1HcpOVoQJNcP11OHB+FJ-=HGfP3RRdy81w@mail.gmail.com>

On Wed, Feb 14, 2024 at 08:28:41AM +0100, Ard Biesheuvel wrote:
> Actually, we can merge set_bringup_idt_handler() into its caller as well:

Yap, here's the final version I have here and yes, it boots fine as
a SNP guest:

From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 Feb 2024 13:41:45 +0100
Subject: [PATCH] x86/startup_64: Simplify global variable accesses in GDT/IDT
 programming

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240213124143.1484862-14-ardb+git@google.com
---
 arch/x86/include/asm/setup.h |  2 +-
 arch/x86/kernel/head64.c     | 75 +++++++++++++++---------------------
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
index dc0956067944..cdff748bf5cb 100644
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
+		.size	 = sizeof(bringup_idt_table) - 1,
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
+		.address	= (unsigned long)&RIP_REL_REF(startup_gdt),
+		.size		= sizeof(startup_gdt) - 1,
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
index a8eaecbd5c81..bcbebab2cc03 100644
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
2.43.0

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

