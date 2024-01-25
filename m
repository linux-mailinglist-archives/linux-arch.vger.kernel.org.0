Return-Path: <linux-arch+bounces-1569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF383C0EC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3236CB26F35
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514904F89A;
	Thu, 25 Jan 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LecD1d6T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FD4F218
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182375; cv=none; b=OMFErpo+BV2YnJtoxBf5CL9mXKMB+6jKQ6BYqmfQCGl6WVtLufwgKigpY/TAItE8DipDFaJcrVKgrBQQaIU9CNs+bbggKEceF8dSUaGGHZ1P1RWENxWKRV0Ucr1qy6sDeAinMnkadrLab8o0ZCDl4JLDFULzyIufdxitB7KvTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182375; c=relaxed/simple;
	bh=1jRwFT8KP5Sc2cp3hWq0TIt5gMnbctAz1NiKEF7cRfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X7DGR2z9zi/F1TUfLFW/wch5y9feKM2+nE77SKA7mHc/vwvoD1MortniNxWlG6FgLFIvS/1pS9AN7rP8tWLaLHBEENDCSlbu1W15+VWkUSWqLqPy+uOaPwWEUoT2M9IM4PdkO41EJDDUYfJdmeGSp3sMwm7LUpXQohqLmdlN41E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LecD1d6T; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e61491b81so2747225e9.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182371; x=1706787171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Kz7C+ixPzKX7RlC+dwS9psnBzxi2S77hDKHtKWjxqM=;
        b=LecD1d6TQ2ViDFF7DSxGHbMZealbvT2rcLpPji4ylD0OQy4ZeiE2cg6wNoWi7XDc9l
         1KFrOMUEabKBp+wqZ5h4Iln5wJ6IdgyF5fW0M9mept1x/1OiXqqVWV3IjNJGRFwe0dn/
         C2qA79F/We6WEZmWzZgOaKBNubIos2r/Jj8R4EcAOBQ7joBQ2firhx6NEA+9iuVwXewN
         6ChsOXjBkbTUIJRd3G1j6AwgTz+67PWctKRwlKB8Q8n303kcE1jCGxFL+PTW53M5s+cK
         nC/l0zvPNr+OtCQlwD4jNss2t84CuegaiMfhc+gOtzF+7wHaxGpR5jVmLQSogpbO7Eqo
         ZwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182371; x=1706787171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Kz7C+ixPzKX7RlC+dwS9psnBzxi2S77hDKHtKWjxqM=;
        b=KeZdxSHHDtGY8INhHhQh8OtubzxaOE09pATORBbUBGAd11oaEmVqPjBgkW7i8s7JBu
         jhTzQ/3CFRnswvcgVu+h7P+I8DkU6Muukp+tRvWFwh8+nwjQyXo1TIygv1bvY7u8cuUK
         xrL+oeJQ+Rm6UJ+nIiQEWbNQRhSeHhcfLl/gHWZWwc4k28YEwqvmLd0uvy4Pip4rUTX0
         /+3IxOuUrY4vTp6/wokZcN417XEx9KRbCAizSf9RtiWjgH8IuUCXW2BUEHusQZhd5fu5
         z+iQwg5YhlkCE/jrDtT9AWAT4VCg8Bic15G0xgWCma1x7ZtDZq7N8lhhJ3GFkjaHbzLB
         eDxQ==
X-Gm-Message-State: AOJu0YzPxMBSg5RA0ORGRm+RbIODhbUL3/yTDRmdPqa2CewndC1sr+Vc
	LsmLHKN2rz8Yj3VlyDq6fGEy8AhERcSQDnasBMFkiiJyrAytTs6iQMumtJhoRyJcEEInSA==
X-Google-Smtp-Source: AGHT+IFvb+AxZqcepMntmtakmbX+GSO7S2RKei4QgyNas0aBvm9PxNuxDhuLVUl+P04CE9IGzewXh21Z
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3489:b0:40e:d20f:6e43 with SMTP id
 a9-20020a05600c348900b0040ed20f6e43mr21720wmq.1.1706182371411; Thu, 25 Jan
 2024 03:32:51 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:25 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=11891; i=ardb@kernel.org;
 h=from:subject; bh=PzzWp9ixYoJ19nSdSRUo8K5t8tOJCydzPxdlM74OpZs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT68PDJS839fA9XjdFTNBbZ5HLrO9tm63D9yocXXlZ+
 M4Kk1vLOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEAr8x/OHevmDJd4ttvtP9
 ReZN4p7dasPwKryKa1LuLw7diQkc584wMiyflRHO0nMyY6WDvk2S8u76iwt25X999OpCQQ77Nuv UfRwA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-25-ardb+git@google.com>
Subject: [PATCH v2 06/17] x86/head64: Replace pointer fixups with PIE codegen
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

Some of the C code in head64.c may be called from a different virtual
address than it was linked at. Currently, we deal with this by using
ordinary, position dependent codegen, and fixing up all symbol
references on the fly. This is fragile and tricky to maintain. It is
also unnecessary: we can use position independent codegen (with hidden
visibility) to ensure that all compiler generated symbol references are
RIP-relative, removing the need for fixups entirely.

It does mean we need explicit references to kernel virtual addresses to
be generated by hand, so generate those using a movabs instruction in
inline asm in the handful places where we actually need this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                 |  5 ++
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/include/asm/setup.h      |  4 +-
 arch/x86/kernel/Makefile          |  4 +
 arch/x86/kernel/head64.c          | 88 +++++++-------------
 arch/x86/kernel/head_64.S         |  5 +-
 6 files changed, 45 insertions(+), 63 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..3c3c07cccd47 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -168,6 +168,11 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
+
+	PIE_CFLAGS := -fpie -mcmodel=small -fno-stack-protector \
+		      -include $(srctree)/include/linux/hidden.h
+
+	export PIE_CFLAGS
 endif
 
 #
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f19c038409aa..bccee07eae60 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,7 +84,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 5c83729c8e71..b004f1b9a052 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -47,8 +47,8 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
-extern void startup_64_setup_env(unsigned long physbase);
+extern unsigned long __startup_64(struct boot_params *bp);
+extern void startup_64_setup_env(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..65194ca79b5c 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -21,6 +21,10 @@ CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
 
+# head64.c contains C code that may execute from a different virtual address
+# than it was linked at, so we always build it using PIE codegen
+CFLAGS_head64.o += $(PIE_CFLAGS)
+
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index d636bb02213f..a4a380494703 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -74,15 +74,10 @@ static struct desc_ptr startup_gdt_descr __initdata = {
 	.address = 0,
 };
 
-static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
-{
-	return ptr - (void *)_text + (void *)physaddr;
-}
-
-static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
+#define __va_symbol(sym) ({						\
+	unsigned long __v;						\
+	asm("movq $" __stringify(sym) ", %0":"=r"(__v));		\
+	__v; })
 
 static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
@@ -99,8 +94,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
+		vaddr = __va_symbol(__start_bss_decrypted);
+		vaddr_end = __va_symbol(__end_bss_decrypted);
 
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
 			/*
@@ -127,25 +122,17 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	return sme_get_me_mask();
 }
 
-/* Code in __startup_64() can be relocated during execution, but the compiler
- * doesn't have to generate PC-relative relocations when accessing globals from
- * that function. Clang actually does not generate them, which leads to
- * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer().
- */
-unsigned long __head __startup_64(unsigned long physaddr,
-				  struct boot_params *bp)
+unsigned long __head __startup_64(struct boot_params *bp)
 {
+	unsigned long physaddr = (unsigned long)_text;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
-	pteval_t *mask_ptr;
 	bool la57;
 	int i;
-	unsigned int *next_pgt_ptr;
 
 	la57 = pgtable_l5_enabled();
 
@@ -157,7 +144,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = physaddr - (__va_symbol(_text) - __START_KERNEL_map);
 
 	/* Is the address not 2M aligned? */
 	if (load_delta & ~PMD_MASK)
@@ -168,26 +155,24 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* Fixup the physical addresses in the page table */
 
-	pgd = fixup_pointer(early_top_pgt, physaddr);
+	pgd = (pgdval_t *)early_top_pgt;
 	p = pgd + pgd_index(__START_KERNEL_map);
 	if (la57)
 		*p = (unsigned long)level4_kernel_pgt;
 	else
 		*p = (unsigned long)level3_kernel_pgt;
-	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
+	*p += _PAGE_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
+		p4d = (p4dval_t *)level4_kernel_pgt;
 		p4d[511] += load_delta;
 	}
 
-	pud = fixup_pointer(level3_kernel_pgt, physaddr);
-	pud[510] += load_delta;
-	pud[511] += load_delta;
+	level3_kernel_pgt[510].pud += load_delta;
+	level3_kernel_pgt[511].pud += load_delta;
 
-	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
 	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
-		pmd[i] += load_delta;
+		level2_fixmap_pgt[i].pmd += load_delta;
 
 	/*
 	 * Set up the identity mapping for the switchover.  These
@@ -196,15 +181,13 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * it avoids problems around wraparound.
 	 */
 
-	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
-	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
-	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
+	pud = (pudval_t *)early_dynamic_pgts[next_early_pgt++];
+	pmd = (pmdval_t *)early_dynamic_pgts[next_early_pgt++];
 
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
-				    physaddr);
+		p4d = (p4dval_t *)early_dynamic_pgts[next_early_pgt++];
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
@@ -225,8 +208,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
-	pmd_entry &= *mask_ptr;
+	pmd_entry &= __supported_pte_mask;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
@@ -252,14 +234,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * error, causing the BIOS to halt the system.
 	 */
 
-	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
+	pmd = (pmdval_t *)level2_kernel_pgt;
 
 	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+	for (i = 0; i < pmd_index(__va_symbol(_text)); i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
 	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index((unsigned long)_end); i++)
+	for (; i <= pmd_index(__va_symbol(_end)); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 
@@ -271,7 +253,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Fixup phys_base - remove the memory encryption mask to obtain
 	 * the true physical address.
 	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
+	phys_base += load_delta - sme_get_me_mask();
 
 	return sme_postprocess_startup(bp, pmd);
 }
@@ -553,22 +535,16 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(unsigned long physbase)
+static void __head startup_64_load_idt(void)
 {
-	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
-	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
-
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		void *handler;
+	gate_desc *idt = bringup_idt_table;
 
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
 		/* VMM Communication Exception */
-		handler = fixup_pointer(vc_no_ghcb, physbase);
-		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
-	}
+		set_bringup_idt_handler(idt, X86_TRAP_VC, vc_no_ghcb);
 
-	desc->address = (unsigned long)idt;
-	native_load_idt(desc);
+	bringup_idt_descr.address = (unsigned long)idt;
+	native_load_idt(&bringup_idt_descr);
 }
 
 /* This is used when running on kernel addresses */
@@ -587,10 +563,10 @@ void early_setup_idt(void)
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_env(void)
 {
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
+	startup_gdt_descr.address = (unsigned long)startup_gdt;
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
@@ -598,5 +574,5 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt(physbase);
+	startup_64_load_idt();
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 399241dcdbb5..b8704ac1a4da 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -67,8 +67,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
-	leaq	_text(%rip), %rdi
-
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
 	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
@@ -107,8 +105,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * is active) to be added to the initial pgdir entry that will be
 	 * programmed into CR3.
 	 */
-	leaq	_text(%rip), %rdi
-	movq	%r15, %rsi
+	movq	%r15, %rdi
 	call	__startup_64
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-- 
2.43.0.429.g432eaa2c6b-goog


