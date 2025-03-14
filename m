Return-Path: <linux-arch+bounces-10790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99581A609D4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D368814D2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8B1F8BA4;
	Fri, 14 Mar 2025 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJlCZ8OP"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE81A316F
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936372; cv=none; b=N9VCN11uh/QTlRl+8yvwoP6QOc/uVp+mZqjw0DZidQHe5wZXbZfwkEcG+CwERTLtAgRaeiA8Z60YiaMi84RyLXKrORKWk6xvWpPn2n2n3v/lQ+MD7ZkLmWP5xpVYoLxRiEVFClCRTuItpLvOk89Wg28/fcVCPc8qhrjcC18CSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936372; c=relaxed/simple;
	bh=2Pm8Qfgx1rAQFSZZ/KujPVW01NL96Bnjrn3g9jmjMxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VX8Um/z1hVb/Pirv3yZb38cneAdwxlwkCCv4O/Fjm0J512NZsIqBV/I9Kb+ouHPKCMeXqcP5MBOHj6UkiAQxPZTtSqL1Avv2j70JKVlihTuNqTj83/Qq3aJ7DbPajR/hDp2LduVvlCSmq3TdC6dOqVgvfNe0EkACb63iyoKnuiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJlCZ8OP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gg+uHMCtBNOMo25f1eYHIrRmrlhiPZdlaGpijiZ0xq0=;
	b=GJlCZ8OPwXjyT7MUQ3QorBaPHpPL4mD3qX6zPNExr/PL+X2APHicFl7wKnOFzK6M/kM11w
	Em73e03SrHoCm31qEsCjJAKvAPbmKgYb/2elFmX1BAD0N+Vhuq8syauJUnPPiY0PuFBlIj
	c+ffLK8BrJAbiTdrRFO3tt1cJTefx88=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-jrRVWq1vMl6WoZqTJrE6ow-1; Fri,
 14 Mar 2025 03:12:46 -0400
X-MC-Unique: jrRVWq1vMl6WoZqTJrE6ow-1
X-Mimecast-MFC-AGG-ID: jrRVWq1vMl6WoZqTJrE6ow_1741936365
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1C511956087;
	Fri, 14 Mar 2025 07:12:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D050818001DE;
	Fri, 14 Mar 2025 07:12:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Subject: [PATCH 32/41] sh: Replace __ASSEMBLY__ with __ASSEMBLER__ in the SuperH headers
Date: Fri, 14 Mar 2025 08:10:03 +0100
Message-ID: <20250314071013.1575167-33-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize on
the __ASSEMBLER__ macro that is provided by the compilers now.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/sh/include/asm/cache.h                   |  4 ++--
 arch/sh/include/asm/dwarf.h                   |  6 +++---
 arch/sh/include/asm/fpu.h                     |  4 ++--
 arch/sh/include/asm/ftrace.h                  |  8 ++++----
 arch/sh/include/asm/mmu.h                     |  4 ++--
 arch/sh/include/asm/page.h                    |  8 ++++----
 arch/sh/include/asm/pgtable.h                 |  4 ++--
 arch/sh/include/asm/pgtable_32.h              |  8 ++++----
 arch/sh/include/asm/processor.h               |  4 ++--
 arch/sh/include/asm/smc37c93x.h               |  4 ++--
 arch/sh/include/asm/suspend.h                 |  2 +-
 arch/sh/include/asm/thread_info.h             | 10 +++++-----
 arch/sh/include/asm/tlb.h                     |  4 ++--
 arch/sh/include/asm/types.h                   |  4 ++--
 arch/sh/include/mach-common/mach/romimage.h   |  6 +++---
 arch/sh/include/mach-ecovec24/mach/romimage.h |  6 +++---
 arch/sh/include/mach-kfr2r09/mach/romimage.h  |  6 +++---
 17 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/sh/include/asm/cache.h b/arch/sh/include/asm/cache.h
index b38dbc9755811..e7ac9c9502751 100644
--- a/arch/sh/include/asm/cache.h
+++ b/arch/sh/include/asm/cache.h
@@ -22,7 +22,7 @@
 
 #define __read_mostly __section(".data..read_mostly")
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct cache_info {
 	unsigned int ways;		/* Number of cache ways */
 	unsigned int sets;		/* Number of cache sets */
@@ -48,5 +48,5 @@ struct cache_info {
 
 	unsigned long flags;
 };
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_SH_CACHE_H */
diff --git a/arch/sh/include/asm/dwarf.h b/arch/sh/include/asm/dwarf.h
index 5719544741221..f46d18b84833f 100644
--- a/arch/sh/include/asm/dwarf.h
+++ b/arch/sh/include/asm/dwarf.h
@@ -189,7 +189,7 @@
  */
 #define DWARF_ARCH_RA_REG	17
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <linux/bug.h>
@@ -379,7 +379,7 @@ extern int module_dwarf_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 				 struct module *);
 extern void module_dwarf_cleanup(struct module *);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define CFI_STARTPROC	.cfi_startproc
 #define CFI_ENDPROC	.cfi_endproc
@@ -402,7 +402,7 @@ extern void module_dwarf_cleanup(struct module *);
 #define CFI_REL_OFFSET	CFI_IGNORE
 #define CFI_UNDEFINED	CFI_IGNORE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline void dwarf_unwinder_init(void)
 {
 }
diff --git a/arch/sh/include/asm/fpu.h b/arch/sh/include/asm/fpu.h
index 0379f4cce5ed2..a086e38b70eef 100644
--- a/arch/sh/include/asm/fpu.h
+++ b/arch/sh/include/asm/fpu.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SH_FPU_H
 #define __ASM_SH_FPU_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/ptrace.h>
 
@@ -67,6 +67,6 @@ static inline void clear_fpu(struct task_struct *tsk, struct pt_regs *regs)
 void float_raise(unsigned int flags);
 int float_rounding_mode(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_SH_FPU_H */
diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
index 1c10e10663909..d35781ab716ef 100644
--- a/arch/sh/include/asm/ftrace.h
+++ b/arch/sh/include/asm/ftrace.h
@@ -7,7 +7,7 @@
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
 #define FTRACE_SYSCALL_MAX	NR_syscalls
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void mcount(void);
 
 #define MCOUNT_ADDR		((unsigned long)(mcount))
@@ -35,10 +35,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* arch/sh/kernel/return_address.c */
 extern void *return_address(unsigned int);
@@ -53,6 +53,6 @@ static inline void arch_ftrace_nmi_enter(void) { }
 static inline void arch_ftrace_nmi_exit(void) { }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_SH_FTRACE_H */
diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
index 172e329fd92d0..b9c9f91e66165 100644
--- a/arch/sh/include/asm/mmu.h
+++ b/arch/sh/include/asm/mmu.h
@@ -33,7 +33,7 @@
 
 #define PMB_NO_ENTRY		(-1)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/errno.h>
 #include <linux/threads.h>
 #include <asm/page.h>
@@ -102,6 +102,6 @@ pmb_remap(phys_addr_t phys, unsigned long size, pgprot_t prot)
 	return pmb_remap_caller(phys, size, prot, __builtin_return_address(0));
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __MMU_H */
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index 3990cbd9aa044..def4205491ec9 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -30,7 +30,7 @@
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/uncached.h>
 
 extern unsigned long shm_align_mask;
@@ -85,7 +85,7 @@ typedef struct page *pgtable_t;
 
 #define pte_pgprot(x) __pgprot(pte_val(x) & PTE_FLAGS_MASK)
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * __MEMORY_START and SIZE are the physical addresses and size of RAM.
@@ -126,10 +126,10 @@ typedef struct page *pgtable_t;
 #define ___va(x)	((x)+PAGE_OFFSET)
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define __pa(x)		___pa((unsigned long)x)
 #define __va(x)		(void *)___va((unsigned long)x)
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef CONFIG_UNCACHED_MAPPING
 #if defined(CONFIG_29BIT)
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 729f5c6225fbb..10fa8f2bb8d1f 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -17,7 +17,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/addrspace.h>
 #include <asm/fixmap.h>
 
@@ -28,7 +28,7 @@
 extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * Effective and physical address definitions, to aid with sign
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index f939f1215232c..bb9f9a2fc85c0 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -170,7 +170,7 @@ static inline unsigned long copy_ptea_attributes(unsigned long x)
 	(PTE_MASK | _PAGE_ACCESSED | _PAGE_CACHABLE | \
 	 _PAGE_DIRTY | _PAGE_SPECIAL)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if defined(CONFIG_X2TLB) /* SH-X2 TLB */
 #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_CACHABLE | \
@@ -287,9 +287,9 @@ static inline unsigned long copy_ptea_attributes(unsigned long x)
 				__pgprot(0)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Certain architectures need to do special things when PTEs
@@ -486,5 +486,5 @@ static inline int pte_swp_exclusive(pte_t pte)
 PTE_BIT_FUNC(low, swp_mkexclusive, |= _PAGE_SWP_EXCLUSIVE);
 PTE_BIT_FUNC(low, swp_clear_exclusive, &= ~_PAGE_SWP_EXCLUSIVE);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_SH_PGTABLE_32_H */
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 73fba7c922f92..2a0b5713ab80e 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -5,7 +5,7 @@
 #include <asm/cpu-features.h>
 #include <asm/cache.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  *  CPU type and hardware bug flags. Kept separately for each CPU.
  *
@@ -168,7 +168,7 @@ extern unsigned int instruction_size(unsigned int insn);
 
 void select_idle_routine(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #include <asm/processor_32.h>
 
diff --git a/arch/sh/include/asm/smc37c93x.h b/arch/sh/include/asm/smc37c93x.h
index 891f2f8f2fd03..caf4cd8dd2411 100644
--- a/arch/sh/include/asm/smc37c93x.h
+++ b/arch/sh/include/asm/smc37c93x.h
@@ -67,7 +67,7 @@
 #define UART_DLL	0x0	/* Divisor Latch (LS) */
 #define UART_DLM	0x2	/* Divisor Latch (MS) */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef struct uart_reg {
 	volatile __u16 rbr;
 	volatile __u16 ier;
@@ -78,7 +78,7 @@ typedef struct uart_reg {
 	volatile __u16 msr;
 	volatile __u16 scr;
 } uart_reg;
-#endif /* ! __ASSEMBLY__ */
+#endif /* ! __ASSEMBLER__ */
 
 /* Alias for Write Only Register */
 
diff --git a/arch/sh/include/asm/suspend.h b/arch/sh/include/asm/suspend.h
index 47db17520261e..0f991babc5597 100644
--- a/arch/sh/include/asm/suspend.h
+++ b/arch/sh/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_SH_SUSPEND_H
 #define _ASM_SH_SUSPEND_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/notifier.h>
 
 #include <asm/ptrace.h>
diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 9f19a682d315f..471db51730361 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -21,7 +21,7 @@
 #define FAULT_CODE_PROT		(1 << 3)	/* protection fault */
 #define FAULT_CODE_USER		(1 << 4)	/* user-mode access */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/processor.h>
 
 struct thread_info {
@@ -49,7 +49,7 @@ struct thread_info {
 /*
  * macros/functions for gaining access to the thread information structure
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
@@ -86,7 +86,7 @@ static inline struct thread_info *current_thread_info(void)
 
 extern void init_thread_xstate(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Thread information flags
@@ -144,7 +144,7 @@ extern void init_thread_xstate(void);
  */
 #define TS_USEDFPU		0x0002	/* FPU used by this task this quantum */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define TI_FLAG_FAULT_CODE_SHIFT	24
 
@@ -164,5 +164,5 @@ static inline unsigned int get_thread_fault_code(void)
 	return ti->flags >> TI_FLAG_FAULT_CODE_SHIFT;
 }
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 #endif /* __ASM_SH_THREAD_INFO_H */
diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index ddf324bfb9a09..39df40d0ebc29 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SH_TLB_H
 #define __ASM_SH_TLB_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/pagemap.h>
 #include <asm-generic/tlb.h>
 
@@ -29,5 +29,5 @@ asmlinkage int handle_tlbmiss(struct pt_regs *regs, unsigned long error_code,
 			      unsigned long address);
 
 #endif /* CONFIG_MMU */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_SH_TLB_H */
diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
index 9b3fc923ee287..fec3e89df0b10 100644
--- a/arch/sh/include/asm/types.h
+++ b/arch/sh/include/asm/types.h
@@ -7,10 +7,10 @@
 /*
  * These aren't exported outside the kernel to avoid name space clashes
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef u16 insn_size_t;
 typedef u32 reg_size_t;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_SH_TYPES_H */
diff --git a/arch/sh/include/mach-common/mach/romimage.h b/arch/sh/include/mach-common/mach/romimage.h
index 1915714263aab..22fb47ec9b152 100644
--- a/arch/sh/include/mach-common/mach/romimage.h
+++ b/arch/sh/include/mach-common/mach/romimage.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* do nothing here by default */
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 static inline void mmcif_update_progress(int nr)
 {
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/sh/include/mach-ecovec24/mach/romimage.h b/arch/sh/include/mach-ecovec24/mach/romimage.h
index 2da6ff326cbd0..f93d494736c3d 100644
--- a/arch/sh/include/mach-ecovec24/mach/romimage.h
+++ b/arch/sh/include/mach-ecovec24/mach/romimage.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* EcoVec board specific boot code:
  * converts the "partner-jet-script.txt" script into assembly
@@ -22,7 +22,7 @@
 1 :	.long 0xa8000000
 2 :
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 /* Ecovec board specific information:
  *
@@ -45,4 +45,4 @@ static inline void mmcif_update_progress(int nr)
 	__raw_writeb(1 << (nr - 1), PGDR);
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/sh/include/mach-kfr2r09/mach/romimage.h b/arch/sh/include/mach-kfr2r09/mach/romimage.h
index 209275872ff06..f68bb480d3784 100644
--- a/arch/sh/include/mach-kfr2r09/mach/romimage.h
+++ b/arch/sh/include/mach-kfr2r09/mach/romimage.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* kfr2r09 board specific boot code:
  * converts the "partner-jet-script.txt" script into assembly
@@ -22,10 +22,10 @@
 1:	.long 0xa8000000
 2:
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 static inline void mmcif_update_progress(int nr)
 {
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
-- 
2.48.1


