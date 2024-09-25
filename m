Return-Path: <linux-arch+bounces-7404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2912D986268
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73F628B848
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CAA18B498;
	Wed, 25 Sep 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6dMyRxK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDF8175F
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276529; cv=none; b=WQUOQtEklNml1X/IOfWUfCqxd9FEPqnGn+hoy44pN+wCcpl3qXGg7bVwZmSXyPQFgZjN0M1vIs52hM+cvWCU8xbgZPHDgsv3rLAVODW0x5GQt+GVQu1eh1ZUIimqkF9Vk0ZD53VdVwzuvY448YtZCkI/J/Z/PQoUSXKPKXiYang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276529; c=relaxed/simple;
	bh=J79MxP7lqCLqptP8R42gKw+nj8+FT+gfetDjKcKkNS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIJIyvwdJ963vSWUdWKLGxqQk72UDzG3KD0if9VTKThPyhokcuifXdFBwk25ILfcAVPFliGP0relMM3n2bDdVUs4R67ZniZgN+UhZ/KzsMB0EwKo1Bt/EanfhiHlQ+LF7B4FPyxhngIznjXViejRVJGjaANQlVkCiXLRwpDHLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6dMyRxK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1dc0585fbfso9533526276.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276525; x=1727881325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDSZAaST0F7o2pedlrN6lklBaOasvLDlFvV5LwnRCP8=;
        b=f6dMyRxKEh/badlNRLcmlg18jSpjvrDmYWxQ7EYbyWsfM9GAk/9cJfeqtthFBSO2QE
         tmr4Y8dW+RZ7AI2xlbBYV8GQJ0M5ZCm/1FXm9nQl+xGG38Gk72HRI81G0Vx6QxYBg522
         cZt8fvb3jQBfwNVQaPg0Lw9QLYK7r0CUkbgNNCVhv2U5L5o1t8Lto/ATXHiV4KdnTizz
         7CFRUdGaQKLn6Q+RoVRdtx4B8nRG1c80c7oVtSc+3pvLZHWdkR+HrdPBusieBrnsltZE
         WkbzMUMLLLSx0FLzA7ZkhwfzxmUWJuCTHzkzMUXD2IaA1o6jwe5GYsOKg2AIFgU5sD2t
         FVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276525; x=1727881325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDSZAaST0F7o2pedlrN6lklBaOasvLDlFvV5LwnRCP8=;
        b=JU8KrHzuEqvAghI1y8/KA8L4A1fta38nnoNiuibqf4FVN6bbhzEVh/xdTCS6lI9sl7
         06fuPoFoo2EJYFj1qHcHyj+gINatIpTPnfiSwfSaE+KV+uGj3vm/rSwMWAZPAT8J9yjk
         TtKNgHZOgRK5qTH+4VrIG2lIw411eai1yMvokhUTgJ2v+ZvHhS5kbPDV8iNgpgIP+44H
         j7jX+CH478dzCKs9O2vbPSk6fzyxxzqPwaEa/8QBUTid7gAwexfPKOGmRZTphAu9JQo1
         EoZ4L3SfNIxu0qRmLPPAntpdMVblZXfyYTOIv567CPYlOqA69rfSJrWH6rCAExIgqVif
         xutg==
X-Forwarded-Encrypted: i=1; AJvYcCVEobXdAWG+bWZIreMNsVSYid8GJM1lPvL1ZmhqclNqiyvod3bWZAyA2kU4q9cDYvXJ+3HrUz+1WKVB@vger.kernel.org
X-Gm-Message-State: AOJu0YykAg+Ze48wAhWrpfNE0PpsLv6Tv6etjk+80tvUBX1g6J2fN6NG
	aupTTA8OP8IVTY2bB05RLObLu0ls5prsm1rVB4CZEzW3b54K0xkyZai4Vy7LjymPLBAQcg==
X-Google-Smtp-Source: AGHT+IFVWEnfWJexNr1qxNhJJA6KdWYKxMoVe8Dw+8wG1wSOr4X5mOwe9MyKjjmZekWIuFcjH9KvW3oI
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6902:1782:b0:e0b:958a:3344 with SMTP id
 3f1490d57ef6-e24da39b0c3mr17932276.10.1727276524782; Wed, 25 Sep 2024
 08:02:04 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:06 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=12230; i=ardb@kernel.org;
 h=from:subject; bh=d8zrHLLRsaJb8rjIFgQ7EHO+u22pN8JK1vGiiuXj4lQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6pZHteaXk89IXLoXMatcXipz+8w88ZqbTc8vrDt5e
 99Nu9mbO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE3LsZ/oo9TvHP2+umfelZ
 ulBlzIGvqg9nBs08XVmsmMPN+vzurvOMDNcdmH9HcnIw6q7iylwgUHny+rJVkzYJbJk791Zkl/v XRQwA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-36-ardb+git@google.com>
Subject: [RFC PATCH 06/28] x86/percpu: Get rid of absolute per-CPU variable placement
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

For historic reasons, per-CPU symbols on x86_64 are emitted in an
address space that is disjoint from the ordinary kernel VA space,
starting at address 0x0. This splits a per-CPU symbol reference into a
base plus offset, where the base is programmed into the GS segment
register.

This deviates from the usual approach adopted by other SMP
architectures, where the base is a reference to the variable in the
kernel image's per-CPU template area, and the offset is a per-CPU value
accounting for the displacement of that particular CPU's per-CPU region
with respect to the template area. This gives per-CPU variable
references a range that is identical to ordinary references, and
requires no special handling for the startup code, as the offset will
simply be 0x0 up until the point where per-CPU variables are initialized
properly.

The x86_64 approach was needed to accommodate per-task stack protector
cookies, which used to live at a fixed offset of GS+40, requiring GS to
be treated as a base register. This is no longer the case, though, and
so GS can be repurposed as a true per-CPU offset, adopting the same
strategy as other architectures.

This also removes the need for linker tricks to emit the per-CPU ELF
segment at a different virtual address. It also means RIP-relative
per-CPU variables no longer need to be relocated in the opposite
direction when KASLR is applied, which was necessary because the 0x0
based per-CPU region remains in place even when the kernel is moved
around.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/desc.h      |  1 -
 arch/x86/include/asm/percpu.h    | 22 --------------
 arch/x86/include/asm/processor.h |  5 ++--
 arch/x86/kernel/head64.c         |  2 +-
 arch/x86/kernel/head_64.S        | 12 ++------
 arch/x86/kernel/irq_64.c         |  1 -
 arch/x86/kernel/setup_percpu.c   |  9 +-----
 arch/x86/kernel/vmlinux.lds.S    | 30 --------------------
 arch/x86/platform/pvh/head.S     |  6 ++--
 arch/x86/tools/relocs.c          |  8 +-----
 arch/x86/xen/xen-head.S          | 10 ++-----
 init/Kconfig                     |  1 -
 12 files changed, 13 insertions(+), 94 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 62dc9f59ea76..ec95fe44fa3a 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -46,7 +46,6 @@ struct gdt_page {
 } __attribute__((aligned(PAGE_SIZE)));
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
-DECLARE_INIT_PER_CPU(gdt_page);
 
 /* Provide the original GDT */
 static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..1ded1207528d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -20,12 +20,6 @@
 
 #define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
 
-#ifdef CONFIG_X86_64_SMP
-# define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
-#else
-# define INIT_PER_CPU_VAR(var)  var
-#endif
-
 #else /* !__ASSEMBLY__: */
 
 #include <linux/build_bug.h>
@@ -97,22 +91,6 @@
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
-/*
- * Initialized pointers to per-CPU variables needed for the boot
- * processor need to use these macros to get the proper address
- * offset from __per_cpu_load on SMP.
- *
- * There also must be an entry in vmlinux_64.lds.S
- */
-#define DECLARE_INIT_PER_CPU(var) \
-       extern typeof(var) init_per_cpu_var(var)
-
-#ifdef CONFIG_X86_64_SMP
-# define init_per_cpu_var(var)  init_per_cpu__##var
-#else
-# define init_per_cpu_var(var)  var
-#endif
-
 /*
  * For arch-specific code, we can use direct single-insn ops (they
  * don't give an lvalue though).
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 56bc36116814..d7219e149f24 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -409,11 +409,12 @@ struct fixed_percpu_data {
 };
 
 DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
-DECLARE_INIT_PER_CPU(fixed_percpu_data);
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
-	return (unsigned long)&per_cpu(fixed_percpu_data, cpu);
+	extern unsigned long __per_cpu_offset[];
+
+	return IS_ENABLED(CONFIG_SMP) ? __per_cpu_offset[cpu] : 0;
 }
 
 extern asmlinkage void entry_SYSCALL32_ignore(void);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4b9d4557fc94..d4398261ad81 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -559,7 +559,7 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
-	struct desc_struct *gdt = (void *)(__force unsigned long)init_per_cpu_var(gdt_page.gdt);
+	struct desc_struct *gdt = (void *)(__force unsigned long)gdt_page.gdt;
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 330922b328bf..ab6ccee81493 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -68,11 +68,10 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	__top_init_kernel_stack(%rip), %rsp
 
-	/* Setup GSBASE to allow stack canary access for C code */
+	/* Clear %gs so early per-CPU references target the per-CPU load area */
 	movl	$MSR_GS_BASE, %ecx
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-	movl	%edx, %eax
-	shrq	$32,  %rdx
+	xorl	%eax, %eax
+	cdq
 	wrmsr
 
 	call	startup_64_setup_gdt_idt
@@ -361,15 +360,10 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-#ifndef CONFIG_SMP
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-#endif
 	movl	%edx, %eax
 	shrq	$32, %rdx
 	wrmsr
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index ade0043ce56e..56bdeecd8ee0 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -27,7 +27,6 @@
 #include <asm/apic.h>
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
-DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_VMAP_STACK
 /*
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index b30d6e180df7..57482420ff42 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -23,17 +23,10 @@
 #include <asm/cpumask.h>
 #include <asm/cpu.h>
 
-#ifdef CONFIG_X86_64
-#define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
-#else
-#define BOOT_PERCPU_OFFSET 0
-#endif
-
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) = BOOT_PERCPU_OFFSET;
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) = 0;
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
 unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init = {
-	[0 ... NR_CPUS-1] = BOOT_PERCPU_OFFSET,
 };
 EXPORT_SYMBOL(__per_cpu_offset);
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 7f060d873f75..00f82db7b3e1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -103,9 +103,6 @@ PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_SMP
-	percpu PT_LOAD FLAGS(6);        /* RW_ */
-#endif
 	init PT_LOAD FLAGS(7);          /* RWE */
 #endif
 	note PT_NOTE FLAGS(0);          /* ___ */
@@ -225,17 +222,6 @@ SECTIONS
 		__init_begin = .; /* paired with __init_end */
 	}
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
-	/*
-	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
-	 * output PHDR, so the next output section - .init.text - should
-	 * start another segment - init.
-	 */
-	PERCPU_VADDR(INTERNODE_CACHE_BYTES, 0, :percpu)
-	ASSERT(SIZEOF(.data..percpu) < CONFIG_PHYSICAL_START,
-	       "per-CPU data too large - increase CONFIG_PHYSICAL_START")
-#endif
-
 	INIT_TEXT_SECTION(PAGE_SIZE)
 #ifdef CONFIG_X86_64
 	:init
@@ -356,9 +342,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
-#endif
 
 	RUNTIME_CONST(shift, d_hash_shift)
 	RUNTIME_CONST(ptr, dentry_hashtable)
@@ -497,20 +481,6 @@ SECTIONS
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
 #ifdef CONFIG_X86_64
-/*
- * Per-cpu symbols which need to be offset from __per_cpu_load
- * for the boot processor.
- */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
-INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
-INIT_PER_CPU(irq_stack_backing_store);
-
-#ifdef CONFIG_SMP
-. = ASSERT((fixed_percpu_data == 0),
-           "fixed_percpu_data is not at start of per-cpu area");
-#endif
-
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index a308b79a887c..11245ecdc08d 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -95,9 +95,9 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	/* 64-bit entry point. */
 	.code64
 1:
-	/* Set base address in stack canary descriptor. */
+	/* Clear %gs so early per-CPU references target the per-CPU load area */
 	mov $MSR_GS_BASE,%ecx
-	mov $_pa(canary), %eax
+	xor %eax, %eax
 	xor %edx, %edx
 	wrmsr
 
@@ -161,8 +161,6 @@ SYM_DATA_START_LOCAL(gdt_start)
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
-SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
-
 SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 880f0f2e465e..10add45b99f1 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -88,7 +88,6 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
 	"__per_cpu_load|"
-	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
 	"__vvar_page|"
@@ -785,10 +784,6 @@ static void percpu_init(void)
  * The GNU linker incorrectly associates:
  *	__init_begin
  *	__per_cpu_load
- *
- * The "gold" linker incorrectly associates:
- *	init_per_cpu__fixed_percpu_data
- *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 {
@@ -796,8 +791,7 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 
 	return (shndx == per_cpu_shndx) &&
 		strcmp(symname, "__init_begin") &&
-		strcmp(symname, "__per_cpu_load") &&
-		strncmp(symname, "init_per_cpu_", 13);
+		strcmp(symname, "__per_cpu_load");
 }
 
 
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 758bcd47b72d..faadac7c29e6 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -51,15 +51,9 @@ SYM_CODE_START(startup_xen)
 
 	leaq	__top_init_kernel_stack(%rip), %rsp
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.  If the
-	 * stack protector canary is enabled, it is located at %gs:40.
-	 * Note that, on SMP, the boot cpu uses init data section until
-	 * the per cpu areas are set up.
-	 */
+	/* Clear %gs so early per-CPU references target the per-CPU load area */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
+	xorl	%eax, %eax
 	cdq
 	wrmsr
 
diff --git a/init/Kconfig b/init/Kconfig
index b05467014041..be8a9a786d3c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1838,7 +1838,6 @@ config KALLSYMS_ALL
 config KALLSYMS_ABSOLUTE_PERCPU
 	bool
 	depends on KALLSYMS
-	default X86_64 && SMP
 
 # end of the "standard kernel features (expert users)" menu
 
-- 
2.46.0.792.g87dc391469-goog


