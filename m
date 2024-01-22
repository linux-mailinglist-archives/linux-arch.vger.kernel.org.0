Return-Path: <linux-arch+bounces-1414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F145B835DC9
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 10:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F09287A2F
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D453987D;
	Mon, 22 Jan 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSyIx2XL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352C39FF7
	for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914775; cv=none; b=VP57bCH0CDx+dx0AaZEfQRjj4O62bYRBLoZk87VFZCz8o5EW7LQ5Tpe13sBztXeUC8yRS5fCPnl/0UtzRLG7jG03QCAO783p7OMQ9vNKi5xrPKqkgPbc1HgQijHPMwDOMhBWMLSXz40ewyCiIt0LGRLtMRBtAawFyudeSoWCd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914775; c=relaxed/simple;
	bh=ASNAVMifMJd8QWZCGmHV1XRCtmfYXVarhOOObTd7G9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AjqT/9NCp9a5Sim0razgecCcZHwdP/t2KrZJvWCW7/ZqIxTOPI/g3sE5Zegb6H2zMsUTMasc7T6JmQtbGHfT3ZbDxIqT80UPOSCslP11yhSD4PXzidKuVCqO4xy5h8kebwXrKdLDYQKZ4w9WmbwtUBZ6otfAGcxr0PriGw7l2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSyIx2XL; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33770774fe4so1914003f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 01:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705914772; x=1706519572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfnnJzbo8UZ3onwnncaopOvG+BfrFgnNq0Hm48mm5EQ=;
        b=QSyIx2XLO3Ukws5iNR8IEj25V24mlpKUdoiYh5du7xe8WewTjRBtKFs/g6uYarQKzO
         VRoGNrke37rbCP0KyTL0di9N6puNLhMH788rivA4R5WWiXC7zYgypUjtq4gWqExt6m3i
         3v6ekKoT+VWzEQgDq8zsV/wks/T2Fs7dpZqR846ASleYjmvXU/b+VPGw3KDbHHfX4xci
         a1BSuIqRh4W/B3FmbYcZW+A2YngkM0Q3HbrSe/XOMYHwudy/F26h98ck4mwXjdp94iDk
         faKpEjNQNq6SICdtf2kHy4LSi0pRdZhNBzJoJzq8eU08Cp2EeR9KM1MuIuCMe6ihRthK
         KKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914772; x=1706519572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfnnJzbo8UZ3onwnncaopOvG+BfrFgnNq0Hm48mm5EQ=;
        b=a4joyMlHHVpHslp+jXUpw1tG+egC+TxeOF3z0nxvhFJRv3wLP6Mj377QQWYzVVMFcS
         FYBunUMU/+Qn4UOzV9v85c8HpB8DQdJ5dcX3Zf//a6DBDt3cvlHM9o99FgUeBQhfsMRt
         /ez02j73HFbyDPdoDcR+PJeVmKoOddF5AFhETKuczHs+c4nVtl12SSFURjbODZ6LEH6h
         +7yj0LKuf9xaHUjzs42FiDZVZBeyFogMUJnmQNXs5edKOey5HZb6jlg1t3aEGCJjbw5L
         pg28wkXXQ6gKXsy/c4p0/SILfidtcrMepOeFCaPADuboP6FzL5+FNUANWDnJgoWMI0o8
         Y7Tg==
X-Gm-Message-State: AOJu0YxciYDIhntPRhT247tWsIxh9EPHtI+7VKohmR48Hv4ZdI3hYUjc
	yBE+Rg3euryxd2RV7K49T41Hv4jZfhRFjcANelVEsXg+0vqWHVLadKRz96m3UnRs+xYUnA==
X-Google-Smtp-Source: AGHT+IGGwJvK6K0kvpr7smqRaLSPupVq4s+Irs0sV0zDvqPfgLWKJFQfvR+unHa7FQWKXM5m3EfB5UaP
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:edd1:0:b0:337:c61c:8543 with SMTP id
 v17-20020adfedd1000000b00337c61c8543mr14303wro.12.1705914772059; Mon, 22 Jan
 2024 01:12:52 -0800 (PST)
Date: Mon, 22 Jan 2024 10:08:56 +0100
In-Reply-To: <20240122090851.851120-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122090851.851120-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=13097; i=ardb@kernel.org;
 h=from:subject; bh=/1VPj9HH1Zq9gl0WszFeYn5sVhTk4UiVd+cWeq9d1/A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWdwYrHX8M+PtC4ZFul4688vfaifPGEn1IXK7av/X32r
 Iq92bbajlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRNa8Y/hdaHkgpeGsWoSRr
 Zu72bmYma+pD83SVn1I+C94/eH1v0iNGhtv1Tr8mR6932nnVNPTRzSipkOU6/9kOxtvdTl8x/WL ddU4A
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122090851.851120-11-ardb+git@google.com>
Subject: [RFC PATCH 4/5] x86/head64: Replace pointer fixups with PIE codegen
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev
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

While at it, move these routines to .inittext where they belong.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                 |  11 ++
 arch/x86/boot/compressed/Makefile |   2 +-
 arch/x86/include/asm/init.h       |   2 -
 arch/x86/include/asm/setup.h      |   2 +-
 arch/x86/kernel/Makefile          |   4 +
 arch/x86/kernel/head64.c          | 117 +++++++-------------
 6 files changed, 60 insertions(+), 78 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..bed0850d91b0 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -168,6 +168,17 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
+
+	PIE_CFLAGS := -fpie -mcmodel=small \
+		      -include $(srctree)/include/linux/hidden.h
+
+	ifeq ($(CONFIG_STACKPROTECTOR),y)
+		ifeq ($(CONFIG_SMP),y)
+			PIE_CFLAGS += -mstack-protector-guard-reg=gs
+		endif
+	endif
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
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 5c83729c8e71..dc657b1d7e14 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -48,7 +48,7 @@ extern unsigned long saved_video_mode;
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
-extern void startup_64_setup_env(unsigned long physbase);
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
index dc0956067944..21f6c2a7061b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -85,23 +85,8 @@ static struct desc_ptr startup_gdt_descr __initdata = {
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
-
 #ifdef CONFIG_X86_5LEVEL
-static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
-
-static bool __head check_la57_support(unsigned long physaddr)
+static bool __init check_la57_support(void)
 {
 	/*
 	 * 5-level paging is detected and enabled at kernel decompression
@@ -110,23 +95,28 @@ static bool __head check_la57_support(unsigned long physaddr)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
-	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
-	*fixup_int(&pgdir_shift, physaddr) = 48;
-	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
-	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
-	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
-	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
+	__pgtable_l5_enabled	= 1;
+	pgdir_shift		= 48;
+	ptrs_per_p4d		= 512;
+	page_offset_base	= __PAGE_OFFSET_BASE_L5;
+	vmalloc_base		= __VMALLOC_BASE_L5;
+	vmemmap_base		= __VMEMMAP_BASE_L5;
 
 	return true;
 }
 #else
-static bool __head check_la57_support(unsigned long physaddr)
+static bool __init check_la57_support(void)
 {
 	return false;
 }
 #endif
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+#define __va_symbol(sym) ({						\
+	unsigned long __v;						\
+	asm("movabsq $" __stringify(sym) ", %0":"=r"(__v));		\
+	__v; })
+
+static unsigned long __init sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
 	unsigned long vaddr, vaddr_end;
 	int i;
@@ -141,8 +131,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
+		vaddr = __va_symbol(__start_bss_decrypted);
+		vaddr_end = __va_symbol(__end_bss_decrypted);
 
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
 			/*
@@ -169,13 +159,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	return sme_get_me_mask();
 }
 
-/* Code in __startup_64() can be relocated during execution, but the compiler
- * doesn't have to generate PC-relative relocations when accessing globals from
- * that function. Clang actually does not generate them, which leads to
- * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer().
- */
-unsigned long __head __startup_64(unsigned long physaddr,
+unsigned long __init __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
 	unsigned long load_delta, *p;
@@ -184,12 +168,10 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
-	pteval_t *mask_ptr;
 	bool la57;
 	int i;
-	unsigned int *next_pgt_ptr;
 
-	la57 = check_la57_support(physaddr);
+	la57 = check_la57_support();
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -199,7 +181,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = physaddr - (__va_symbol(_text) - __START_KERNEL_map);
 
 	/* Is the address not 2M aligned? */
 	if (load_delta & ~PMD_MASK)
@@ -210,26 +192,22 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
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
 
-	if (la57) {
-		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
-		p4d[511] += load_delta;
-	}
+	if (la57)
+		level4_kernel_pgt[511].p4d += load_delta;
 
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
@@ -238,15 +216,13 @@ unsigned long __head __startup_64(unsigned long physaddr,
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
@@ -267,8 +243,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
-	pmd_entry &= *mask_ptr;
+	pmd_entry &= __supported_pte_mask;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
@@ -294,14 +269,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
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
 
@@ -313,7 +288,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Fixup phys_base - remove the memory encryption mask to obtain
 	 * the true physical address.
 	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
+	phys_base += load_delta - sme_get_me_mask();
 
 	return sme_postprocess_startup(bp, pmd);
 }
@@ -587,22 +562,16 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(unsigned long physbase)
+static void startup_64_load_idt(void)
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
@@ -621,10 +590,10 @@ void early_setup_idt(void)
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __init startup_64_setup_env(void)
 {
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
+	startup_gdt_descr.address = (unsigned long)startup_gdt;
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
@@ -632,5 +601,5 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt(physbase);
+	startup_64_load_idt();
 }
-- 
2.43.0.429.g432eaa2c6b-goog


