Return-Path: <linux-arch+bounces-10775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8669A609A2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EE24601F4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D67015749C;
	Fri, 14 Mar 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8RsGwJX"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931A1DF242
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936312; cv=none; b=Wlh54SInCn9YdotlQ4qEfJfx5cCAFhmzX11oNFYzORi/KljDb2RGo+a984dADCkw0YBqCTO31VfRucDIKsvGDvXve2X0vYowaQqPQK/fn8wA2GbZvnMLL+ey+5xMYk/mRVx3PzgkBhkbt0cZM/ZX+ThcbwgosM9C60NNHNGCYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936312; c=relaxed/simple;
	bh=CecADtPkvKa7C1FJO42d6lUANDXsd7y2XwNZg3H+HiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAIqQFlye/vWnR0WkAAR363O/Rq/NYDDgzYvUjEXsJrK09w8htkXU0BfXMpN3xYLGdSy8LDThDU4UUnkjeRMwJK1MK0EuKKE0xC/Bz1SJ/iYXFWjmSienjIQD/nK2GPn/YaOwD4knVna/4XYbMWdTulqbY3z6vtgay2HDtmbz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8RsGwJX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jE+PuGLyDDSLrHeUBErXQINgI1Rhx/GDc37B6SZVms=;
	b=N8RsGwJXcKsUbv5/1j99I04K47McmqaAAbcpnvAUoQ+Oy9Czfz91LxBO9Qumo3KA8VH+Fx
	sOxkniXAXUI0aMa+/AMUBwHh0x8RCnJuSdZ9MLPV7UZI/G4owYFn025oGoCgEwSJdUcmpa
	5PLFsPlH+ylScE/VL88sxLJ9zgP7VZE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-6YrMTv4zNryKlquRwdHP1g-1; Fri,
 14 Mar 2025 03:11:45 -0400
X-MC-Unique: 6YrMTv4zNryKlquRwdHP1g-1
X-Mimecast-MFC-AGG-ID: 6YrMTv4zNryKlquRwdHP1g_1741936303
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D459180035E;
	Fri, 14 Mar 2025 07:11:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 208261801747;
	Fri, 14 Mar 2025 07:11:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Michal Simek <monstr@monstr.eu>
Subject: [PATCH 18/41] microblaze: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:09:49 +0100
Message-ID: <20250314071013.1575167-19-thuth@redhat.com>
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

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/microblaze/include/asm/asm-compat.h       |  2 +-
 arch/microblaze/include/asm/current.h          |  4 ++--
 arch/microblaze/include/asm/entry.h            |  4 ++--
 arch/microblaze/include/asm/exceptions.h       |  4 ++--
 arch/microblaze/include/asm/fixmap.h           |  4 ++--
 arch/microblaze/include/asm/ftrace.h           |  2 +-
 arch/microblaze/include/asm/kgdb.h             |  4 ++--
 arch/microblaze/include/asm/mmu.h              |  4 ++--
 arch/microblaze/include/asm/page.h             |  8 ++++----
 arch/microblaze/include/asm/pgtable.h          | 18 +++++++++---------
 arch/microblaze/include/asm/processor.h        |  8 ++++----
 arch/microblaze/include/asm/ptrace.h           |  4 ++--
 arch/microblaze/include/asm/sections.h         |  4 ++--
 arch/microblaze/include/asm/setup.h            |  4 ++--
 arch/microblaze/include/asm/thread_info.h      |  4 ++--
 arch/microblaze/include/asm/unistd.h           |  4 ++--
 .../microblaze/include/asm/xilinx_mb_manager.h |  4 ++--
 17 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/microblaze/include/asm/asm-compat.h b/arch/microblaze/include/asm/asm-compat.h
index c05259ce2d2c2..9f04614762319 100644
--- a/arch/microblaze/include/asm/asm-compat.h
+++ b/arch/microblaze/include/asm/asm-compat.h
@@ -4,7 +4,7 @@
 
 #include <asm/types.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #  define stringify_in_c(...)	__VA_ARGS__
 #  define ASM_CONST(x)		x
 #else
diff --git a/arch/microblaze/include/asm/current.h b/arch/microblaze/include/asm/current.h
index a4bb45be30e69..099e69f32bf97 100644
--- a/arch/microblaze/include/asm/current.h
+++ b/arch/microblaze/include/asm/current.h
@@ -14,13 +14,13 @@
  * but check asm/microblaze/kernel/entry.S to be sure.
  */
 #define CURRENT_TASK	r31
-# ifndef __ASSEMBLY__
+# ifndef __ASSEMBLER__
 /*
  * Dedicate r31 to keeping the current task pointer
  */
 register struct task_struct *current asm("r31");
 
 # define get_current()	current
-# endif /* __ASSEMBLY__ */
+# endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_MICROBLAZE_CURRENT_H */
diff --git a/arch/microblaze/include/asm/entry.h b/arch/microblaze/include/asm/entry.h
index 6c42bed411662..9efadf12397ca 100644
--- a/arch/microblaze/include/asm/entry.h
+++ b/arch/microblaze/include/asm/entry.h
@@ -21,7 +21,7 @@
 
 #define PER_CPU(var) var
 
-# ifndef __ASSEMBLY__
+# ifndef __ASSEMBLER__
 DECLARE_PER_CPU(unsigned int, KSP); /* Saved kernel stack pointer */
 DECLARE_PER_CPU(unsigned int, KM); /* Kernel/user mode */
 DECLARE_PER_CPU(unsigned int, ENTRY_SP); /* Saved SP on kernel entry */
@@ -29,6 +29,6 @@ DECLARE_PER_CPU(unsigned int, R11_SAVE); /* Temp variable for entry */
 DECLARE_PER_CPU(unsigned int, CURRENT_SAVE); /* Saved current pointer */
 
 extern asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall);
-# endif /* __ASSEMBLY__ */
+# endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_MICROBLAZE_ENTRY_H */
diff --git a/arch/microblaze/include/asm/exceptions.h b/arch/microblaze/include/asm/exceptions.h
index 967f175173e14..c4591e4f7175b 100644
--- a/arch/microblaze/include/asm/exceptions.h
+++ b/arch/microblaze/include/asm/exceptions.h
@@ -11,7 +11,7 @@
 #define _ASM_MICROBLAZE_EXCEPTIONS_H
 
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Macros to enable and disable HW exceptions in the MSR */
 /* Define MSR enable bit for HW exceptions */
@@ -64,6 +64,6 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig);
 void die(const char *str, struct pt_regs *fp, long err);
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr);
 
-#endif /*__ASSEMBLY__ */
+#endif /*__ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_EXCEPTIONS_H */
diff --git a/arch/microblaze/include/asm/fixmap.h b/arch/microblaze/include/asm/fixmap.h
index e6e9288bff761..f9797849e4d43 100644
--- a/arch/microblaze/include/asm/fixmap.h
+++ b/arch/microblaze/include/asm/fixmap.h
@@ -15,7 +15,7 @@
 #ifndef _ASM_FIXMAP_H
 #define _ASM_FIXMAP_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/kernel.h>
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
@@ -62,5 +62,5 @@ extern void __set_fixmap(enum fixed_addresses idx,
 
 #include <asm-generic/fixmap.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/microblaze/include/asm/ftrace.h b/arch/microblaze/include/asm/ftrace.h
index 4ca38b92a3a20..27c1bafb669c3 100644
--- a/arch/microblaze/include/asm/ftrace.h
+++ b/arch/microblaze/include/asm/ftrace.h
@@ -7,7 +7,7 @@
 #define MCOUNT_ADDR		((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE	8 /* sizeof mcount call */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void _mcount(void);
 extern void ftrace_call_graph(void);
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr);
diff --git a/arch/microblaze/include/asm/kgdb.h b/arch/microblaze/include/asm/kgdb.h
index 8dc5ebb07fd5a..321c3c8bfcf27 100644
--- a/arch/microblaze/include/asm/kgdb.h
+++ b/arch/microblaze/include/asm/kgdb.h
@@ -3,7 +3,7 @@
 #ifndef __MICROBLAZE_KGDB_H__
 #define __MICROBLAZE_KGDB_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define CACHE_FLUSH_IS_SAFE	1
 #define BUFMAX			2048
@@ -27,6 +27,6 @@ static inline void arch_kgdb_breakpoint(void)
 struct pt_regs;
 asmlinkage void microblaze_kgdb_break(struct pt_regs *regs);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __MICROBLAZE_KGDB_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/microblaze/include/asm/mmu.h b/arch/microblaze/include/asm/mmu.h
index b928a87c00766..7262dc4da3385 100644
--- a/arch/microblaze/include/asm/mmu.h
+++ b/arch/microblaze/include/asm/mmu.h
@@ -9,7 +9,7 @@
 #define _ASM_MICROBLAZE_MMU_H
 
 #  ifdef __KERNEL__
-#   ifndef __ASSEMBLY__
+#   ifndef __ASSEMBLER__
 
 /* Default "unsigned long" context */
 typedef unsigned long mm_context_t;
@@ -56,7 +56,7 @@ extern void _tlbia(void);		/* invalidate all TLB entries */
  * mapping has to increase tlb_skip size.
  */
 extern u32 tlb_skip;
-#   endif /* __ASSEMBLY__ */
+#   endif /* __ASSEMBLER__ */
 
 /*
  * The MicroBlaze processor has a TLB architecture identical to PPC-40x. The
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index 90fc9c81debda..90ac9f34b4b49 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -25,7 +25,7 @@
 
 #define PTE_SHIFT	(PAGE_SHIFT - 2)	/* 1024 ptes per page */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * PAGE_OFFSET -- the first address of the first page of memory. With MMU
@@ -100,7 +100,7 @@ extern int page_is_ram(unsigned long pfn);
 #  define page_to_virt(page)   __va(page_to_pfn(page) << PAGE_SHIFT)
 
 #  define ARCH_PFN_OFFSET	(memory_start >> PAGE_SHIFT)
-# endif /* __ASSEMBLY__ */
+# endif /* __ASSEMBLER__ */
 
 /* Convert between virtual and physical address for MMU. */
 /* Handle MicroBlaze processor with virtual memory. */
@@ -113,7 +113,7 @@ extern int page_is_ram(unsigned long pfn);
 #define tovirt(rd, rs) \
 	addik rd, rs, (CONFIG_KERNEL_START - CONFIG_KERNEL_BASE_ADDR)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 # define __pa(x)	__virt_to_phys((unsigned long)(x))
 # define __va(x)	((void *)__phys_to_virt((unsigned long)(x)))
@@ -130,7 +130,7 @@ static inline const void *pfn_to_virt(unsigned long pfn)
 
 #define	virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define TOPHYS(addr)  __virt_to_phys(addr)
 
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index e4ea2ec3642f0..eadc73d22dda6 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -10,14 +10,14 @@
 
 #include <asm/setup.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern int mem_init_done;
 #endif
 
 #include <asm-generic/pgtable-nopmd.h>
 
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/sched.h>
 #include <linux/threads.h>
@@ -39,7 +39,7 @@ extern pte_t *va_to_pte(unsigned long address);
 #define VMALLOC_START	(CONFIG_KERNEL_START + CONFIG_LOWMEM_SIZE)
 #define VMALLOC_END	ioremap_bot
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Macro to mark a page protection value as "uncacheable".
@@ -208,7 +208,7 @@ extern pte_t *va_to_pte(unsigned long address);
  * Also, write permissions imply read permissions.
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
@@ -216,7 +216,7 @@ extern pte_t *va_to_pte(unsigned long address);
 extern unsigned long empty_zero_page[1024];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
@@ -237,7 +237,7 @@ extern unsigned long empty_zero_page[1024];
 #define pfn_pte(pfn, prot) \
 	__pte(((pte_basic_t)(pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
@@ -444,13 +444,13 @@ extern int mem_init_done;
 
 asmlinkage void __init mmu_init(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long ioremap_bot, ioremap_base;
 
 void setup_memory(void);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_MICROBLAZE_PGTABLE_H */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 4e193c7550dfa..d59bdfffca7cc 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -14,7 +14,7 @@
 #include <asm/entry.h>
 #include <asm/current.h>
 
-# ifndef __ASSEMBLY__
+# ifndef __ASSEMBLER__
 /* from kernel/cpu/mb.c */
 extern const struct seq_operations cpuinfo_op;
 
@@ -29,7 +29,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long usp);
 extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
 
-# endif /* __ASSEMBLY__ */
+# endif /* __ASSEMBLER__ */
 
 /*
  * This is used to define STACK_TOP, and with MMU it must be below
@@ -45,7 +45,7 @@ extern void ret_from_kernel_thread(void);
 
 # define THREAD_KSP	0
 
-#  ifndef __ASSEMBLY__
+#  ifndef __ASSEMBLER__
 
 /* If you change this, you must change the associated assembly-languages
  * constants defined below, THREAD_*.
@@ -88,5 +88,5 @@ unsigned long __get_wchan(struct task_struct *p);
 extern struct dentry *of_debugfs_root;
 #endif
 
-#  endif /* __ASSEMBLY__ */
+#  endif /* __ASSEMBLER__ */
 #endif /* _ASM_MICROBLAZE_PROCESSOR_H */
diff --git a/arch/microblaze/include/asm/ptrace.h b/arch/microblaze/include/asm/ptrace.h
index bfcb89df5e26f..17982292a64fd 100644
--- a/arch/microblaze/include/asm/ptrace.h
+++ b/arch/microblaze/include/asm/ptrace.h
@@ -7,7 +7,7 @@
 
 #include <uapi/asm/ptrace.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define kernel_mode(regs)		((regs)->pt_mode)
 #define user_mode(regs)			(!kernel_mode(regs))
 
@@ -20,5 +20,5 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return regs->r3;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_MICROBLAZE_PTRACE_H */
diff --git a/arch/microblaze/include/asm/sections.h b/arch/microblaze/include/asm/sections.h
index a9311ad84a67f..f5008f5e7a5c1 100644
--- a/arch/microblaze/include/asm/sections.h
+++ b/arch/microblaze/include/asm/sections.h
@@ -10,11 +10,11 @@
 
 #include <asm-generic/sections.h>
 
-# ifndef __ASSEMBLY__
+# ifndef __ASSEMBLER__
 extern char _ssbss[], _esbss[];
 extern unsigned long __ivt_start[], __ivt_end[];
 
 extern u32 _fdt_start[], _fdt_end[];
 
-# endif /* !__ASSEMBLY__ */
+# endif /* !__ASSEMBLER__ */
 #endif /* _ASM_MICROBLAZE_SECTIONS_H */
diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index bf2600f759593..837ed0bbae4b5 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -9,7 +9,7 @@
 
 #include <uapi/asm/setup.h>
 
-# ifndef __ASSEMBLY__
+# ifndef __ASSEMBLER__
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 extern char *klimit;
@@ -25,5 +25,5 @@ void machine_shutdown(void);
 void machine_halt(void);
 void machine_power_off(void);
 
-# endif /* __ASSEMBLY__ */
+# endif /* __ASSEMBLER__ */
 #endif /* _ASM_MICROBLAZE_SETUP_H */
diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index a0ddd2a36fb94..0153f7c2717c9 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -13,7 +13,7 @@
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 #define THREAD_SIZE_ORDER	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 # include <linux/types.h>
 # include <asm/processor.h>
 
@@ -86,7 +86,7 @@ static inline struct thread_info *current_thread_info(void)
 }
 
 /* thread information allocation */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * thread information flags
diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index cfe3f888b432b..fedda9908aa94 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/unistd.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* #define __ARCH_WANT_OLD_READDIR */
 /* #define __ARCH_WANT_OLD_STAT */
@@ -33,6 +33,6 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_MICROBLAZE_UNISTD_H */
diff --git a/arch/microblaze/include/asm/xilinx_mb_manager.h b/arch/microblaze/include/asm/xilinx_mb_manager.h
index 7b6995722b0c0..121a3224882b2 100644
--- a/arch/microblaze/include/asm/xilinx_mb_manager.h
+++ b/arch/microblaze/include/asm/xilinx_mb_manager.h
@@ -5,7 +5,7 @@
 #ifndef _XILINX_MB_MANAGER_H
 #define _XILINX_MB_MANAGER_H
 
-# ifndef __ASSEMBLY__
+# ifndef __ASSEMBLER__
 
 #include <linux/of_address.h>
 
@@ -21,7 +21,7 @@ void xmb_manager_register(uintptr_t phys_baseaddr, u32 cr_val,
 			  void *priv, void (*reset_callback)(void *data));
 asmlinkage void xmb_inject_err(void);
 
-# endif /* __ASSEMBLY__ */
+# endif /* __ASSEMBLER__ */
 
 /* Error injection offset */
 #define XMB_INJECT_ERR_OFFSET	0x200
-- 
2.48.1


