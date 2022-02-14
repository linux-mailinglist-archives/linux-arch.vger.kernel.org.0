Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF414B569D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 17:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356632AbiBNQhx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 11:37:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356630AbiBNQhs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 11:37:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83D60D9B;
        Mon, 14 Feb 2022 08:37:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D322ECE19DE;
        Mon, 14 Feb 2022 16:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364C2C340EB;
        Mon, 14 Feb 2022 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856654;
        bh=qlMd8rKvrr7wJQut+MJjWASUZxJ8noHUfphyHHpK8zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZTZdvp3HO/Gbio6pUMfS3VPBiBUrjIxOQFnfXj6gp1TgHkIcBbgGCmUf4okn70pR
         Kkitb3y9JYkIxvpGFR2P253lfPB7ByEuPu2t6M+s5fOTCIVC4HGEoL7B1SslRlUUhH
         Foa+uU+W8IycwOBmVeoy95ItqwtBxi1GpAIb6jmn+lshQSU6w30xxEbfsYhbUNMwSA
         T45LdTjRLx6+br9T8NNqETDat7ql0BhdzYX6sAt3QhQ4Ey3WRS6iz6d584cFXweToe
         GZif6HVQZqMsE1QQ1g9vW8lVohYZmWKnjnjeSA+XlIMnXxhxoRI8MCBxEoz6NoXOyB
         UE5fXaIrZY82w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 10/14] uaccess: remove most CONFIG_SET_FS users
Date:   Mon, 14 Feb 2022 17:34:48 +0100
Message-Id: <20220214163452.1568807-11-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On almost all architectures, there are no remaining callers
of set_fs(), so CONFIG_SET_FS can be disabled, along with
removing the thread_info field and any references to it.

This turns access_ok() into a cheaper check against TASK_SIZE_MAX.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/Kconfig                        |  1 -
 arch/alpha/include/asm/processor.h        |  4 --
 arch/alpha/include/asm/thread_info.h      |  2 -
 arch/alpha/include/asm/uaccess.h          | 19 ------
 arch/arc/Kconfig                          |  1 -
 arch/arc/include/asm/segment.h            | 20 -------
 arch/arc/include/asm/thread_info.h        |  3 -
 arch/arc/include/asm/uaccess.h            |  1 -
 arch/csky/Kconfig                         |  1 -
 arch/csky/include/asm/processor.h         |  2 -
 arch/csky/include/asm/segment.h           | 10 ----
 arch/csky/include/asm/thread_info.h       |  2 -
 arch/csky/include/asm/uaccess.h           |  3 -
 arch/csky/kernel/asm-offsets.c            |  1 -
 arch/h8300/Kconfig                        |  1 -
 arch/h8300/include/asm/processor.h        |  1 -
 arch/h8300/include/asm/segment.h          | 40 -------------
 arch/h8300/include/asm/thread_info.h      |  3 -
 arch/h8300/kernel/entry.S                 |  1 -
 arch/h8300/kernel/head_ram.S              |  1 -
 arch/h8300/mm/init.c                      |  6 --
 arch/h8300/mm/memory.c                    |  1 -
 arch/hexagon/Kconfig                      |  1 -
 arch/hexagon/include/asm/thread_info.h    |  6 --
 arch/hexagon/kernel/process.c             |  1 -
 arch/microblaze/Kconfig                   |  1 -
 arch/microblaze/include/asm/thread_info.h |  6 --
 arch/microblaze/include/asm/uaccess.h     | 24 --------
 arch/microblaze/kernel/asm-offsets.c      |  1 -
 arch/microblaze/kernel/process.c          |  1 -
 arch/nds32/Kconfig                        |  1 -
 arch/nds32/include/asm/thread_info.h      |  4 --
 arch/nds32/include/asm/uaccess.h          | 15 +----
 arch/nds32/mm/alignment.c                 |  3 -
 arch/nios2/Kconfig                        |  1 -
 arch/nios2/include/asm/thread_info.h      |  9 ---
 arch/nios2/include/asm/uaccess.h          | 12 ----
 arch/openrisc/Kconfig                     |  1 -
 arch/openrisc/include/asm/thread_info.h   |  7 ---
 arch/openrisc/include/asm/uaccess.h       | 23 --------
 arch/sparc/Kconfig                        |  2 +-
 arch/sparc/include/asm/processor_32.h     |  6 --
 arch/sparc/include/asm/uaccess_32.h       | 13 -----
 arch/sparc/kernel/process_32.c            |  2 -
 arch/xtensa/Kconfig                       |  1 -
 arch/xtensa/include/asm/asm-uaccess.h     | 71 -----------------------
 arch/xtensa/include/asm/processor.h       |  7 ---
 arch/xtensa/include/asm/thread_info.h     |  3 -
 arch/xtensa/include/asm/uaccess.h         | 16 -----
 arch/xtensa/kernel/asm-offsets.c          |  3 -
 include/asm-generic/uaccess.h             | 25 +-------
 51 files changed, 3 insertions(+), 387 deletions(-)
 delete mode 100644 arch/arc/include/asm/segment.h
 delete mode 100644 arch/csky/include/asm/segment.h
 delete mode 100644 arch/h8300/include/asm/segment.h

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 4e87783c90ad..eee8b5b0a58b 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -35,7 +35,6 @@ config ALPHA
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
 	select MMU_GATHER_NO_RANGE
-	select SET_FS
 	select SPARSEMEM_EXTREME if SPARSEMEM
 	select ZONE_DMA
 	help
diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index 090499c99c1c..43e234c518b1 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -26,10 +26,6 @@
 #define TASK_UNMAPPED_BASE \
   ((current->personality & ADDR_LIMIT_32BIT) ? 0x40000000 : TASK_SIZE / 2)
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 /* This is dead.  Everything has been moved to thread_info.  */
 struct thread_struct { };
 #define INIT_THREAD  { }
diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 2592356e3215..fdc485d7787a 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -19,7 +19,6 @@ struct thread_info {
 	unsigned int		flags;		/* low level flags */
 	unsigned int		ieee_state;	/* see fpu.h */
 
-	mm_segment_t		addr_limit;	/* thread address space */
 	unsigned		cpu;		/* current CPU */
 	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 	unsigned int		status;		/* thread-synchronous flags */
@@ -35,7 +34,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.addr_limit	= KERNEL_DS,		\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
 
diff --git a/arch/alpha/include/asm/uaccess.h b/arch/alpha/include/asm/uaccess.h
index 82c5743fc9cd..c32c2584c0b7 100644
--- a/arch/alpha/include/asm/uaccess.h
+++ b/arch/alpha/include/asm/uaccess.h
@@ -2,26 +2,7 @@
 #ifndef __ALPHA_UACCESS_H
 #define __ALPHA_UACCESS_H
 
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * Or at least it did once upon a time.  Nowadays it is a mask that
- * defines which bits of the address space are off limits.  This is a
- * wee bit faster than the above.
- *
- * For historical reasons, these macros are grossly misnamed.
- */
-
-#define KERNEL_DS	((mm_segment_t) { 0UL })
-#define USER_DS		((mm_segment_t) { -0x40000000000UL })
-
-#define get_fs()  (current_thread_info()->addr_limit)
-#define set_fs(x) (current_thread_info()->addr_limit = (x))
-
 #include <asm-generic/access_ok.h>
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 3c2a4753d09b..e0a60a27e14d 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -45,7 +45,6 @@ config ARC
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 
 config LOCKDEP_SUPPORT
diff --git a/arch/arc/include/asm/segment.h b/arch/arc/include/asm/segment.h
deleted file mode 100644
index 871f8ab11bfd..000000000000
--- a/arch/arc/include/asm/segment.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef __ASMARC_SEGMENT_H
-#define __ASMARC_SEGMENT_H
-
-#ifndef __ASSEMBLY__
-
-typedef unsigned long mm_segment_t;
-
-#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
-
-#define KERNEL_DS		MAKE_MM_SEG(0)
-#define USER_DS			MAKE_MM_SEG(TASK_SIZE)
-#define uaccess_kernel()	(get_fs() == KERNEL_DS)
-
-#endif /* __ASSEMBLY__ */
-#endif /* __ASMARC_SEGMENT_H */
diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index d36863e34bfc..1e0b2e3914d5 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -27,7 +27,6 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/thread_info.h>
-#include <asm/segment.h>
 
 /*
  * low level task data that entry.S needs immediate access to
@@ -40,7 +39,6 @@ struct thread_info {
 	unsigned long flags;		/* low level flags */
 	int preempt_count;		/* 0 => preemptable, <0 => BUG */
 	struct task_struct *task;	/* main task structure */
-	mm_segment_t addr_limit;	/* thread address space */
 	__u32 cpu;			/* current CPU */
 	unsigned long thr_ptr;		/* TLS ptr */
 };
@@ -56,7 +54,6 @@ struct thread_info {
 	.flags      = 0,			\
 	.cpu        = 0,			\
 	.preempt_count  = INIT_PREEMPT_COUNT,	\
-	.addr_limit = KERNEL_DS,		\
 }
 
 static inline __attribute_const__ struct thread_info *current_thread_info(void)
diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 30f80b4be2ab..99712471c96a 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -638,7 +638,6 @@ extern unsigned long arc_clear_user_noinline(void __user *to,
 #define __clear_user(d, n)		arc_clear_user_noinline(d, n)
 #endif
 
-#include <asm/segment.h>
 #include <asm-generic/uaccess.h>
 
 #endif
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 132f43f12dd8..75ef86605d69 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -79,7 +79,6 @@ config CSKY
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_SYSCALL if PCI
 	select PCI_MSI if PCI
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 
 config LOCKDEP_SUPPORT
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 817dd60ff152..688c7548b559 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -4,7 +4,6 @@
 #define __ASM_CSKY_PROCESSOR_H
 
 #include <linux/bitops.h>
-#include <asm/segment.h>
 #include <asm/ptrace.h>
 #include <asm/current.h>
 #include <asm/cache.h>
@@ -59,7 +58,6 @@ struct thread_struct {
  */
 #define start_thread(_regs, _pc, _usp)					\
 do {									\
-	set_fs(USER_DS); /* reads from user space */			\
 	(_regs)->pc = (_pc);						\
 	(_regs)->regs[1] = 0; /* ABIV1 is R7, uClibc_main rtdl arg */	\
 	(_regs)->regs[2] = 0;						\
diff --git a/arch/csky/include/asm/segment.h b/arch/csky/include/asm/segment.h
deleted file mode 100644
index 5bc1cc62b87f..000000000000
--- a/arch/csky/include/asm/segment.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_CSKY_SEGMENT_H
-#define __ASM_CSKY_SEGMENT_H
-
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
-#endif /* __ASM_CSKY_SEGMENT_H */
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 8c349a8f904d..b5ed788f0c68 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -16,7 +16,6 @@ struct thread_info {
 	unsigned long		flags;
 	int			preempt_count;
 	unsigned long		tp_value;
-	mm_segment_t		addr_limit;
 	struct restart_block	restart_block;
 	struct pt_regs		*regs;
 	unsigned int		cpu;
@@ -26,7 +25,6 @@ struct thread_info {
 {						\
 	.task		= &tsk,			\
 	.preempt_count  = INIT_PREEMPT_COUNT,	\
-	.addr_limit     = KERNEL_DS,		\
 	.cpu		= 0,			\
 	.restart_block = {			\
 		.fn = do_no_restart_syscall,	\
diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index fec8f77ffc99..2e927c21d8a1 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -3,8 +3,6 @@
 #ifndef __ASM_CSKY_UACCESS_H
 #define __ASM_CSKY_UACCESS_H
 
-#define user_addr_max() (current_thread_info()->addr_limit.seg)
-
 /*
  * __put_user_fn
  */
@@ -200,7 +198,6 @@ unsigned long raw_copy_to_user(void *to, const void *from, unsigned long n);
 unsigned long __clear_user(void __user *to, unsigned long n);
 #define __clear_user __clear_user
 
-#include <asm/segment.h>
 #include <asm-generic/uaccess.h>
 
 #endif /* __ASM_CSKY_UACCESS_H */
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
index 1cbcba4b0dd1..d1e903579473 100644
--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -25,7 +25,6 @@ int main(void)
 	/* offsets into the thread_info struct */
 	DEFINE(TINFO_FLAGS,       offsetof(struct thread_info, flags));
 	DEFINE(TINFO_PREEMPT,     offsetof(struct thread_info, preempt_count));
-	DEFINE(TINFO_ADDR_LIMIT,  offsetof(struct thread_info, addr_limit));
 	DEFINE(TINFO_TP_VALUE,   offsetof(struct thread_info, tp_value));
 	DEFINE(TINFO_TASK,        offsetof(struct thread_info, task));
 
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 3e3e0f16f7e0..fe48c4f26cc8 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -24,7 +24,6 @@ config H8300
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_HASH
 	select CPU_NO_EFFICIENT_FFS
-	select SET_FS
 	select UACCESS_MEMCPY
 
 config CPU_BIG_ENDIAN
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
index 141a23eb62b7..ba171aa4dacb 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -13,7 +13,6 @@
 #define __ASM_H8300_PROCESSOR_H
 
 #include <linux/compiler.h>
-#include <asm/segment.h>
 #include <asm/ptrace.h>
 #include <asm/current.h>
 
diff --git a/arch/h8300/include/asm/segment.h b/arch/h8300/include/asm/segment.h
deleted file mode 100644
index 37950725d9b9..000000000000
--- a/arch/h8300/include/asm/segment.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _H8300_SEGMENT_H
-#define _H8300_SEGMENT_H
-
-/* define constants */
-#define USER_DATA     (1)
-#ifndef __USER_DS
-#define __USER_DS     (USER_DATA)
-#endif
-#define USER_PROGRAM  (2)
-#define SUPER_DATA    (3)
-#ifndef __KERNEL_DS
-#define __KERNEL_DS   (SUPER_DATA)
-#endif
-#define SUPER_PROGRAM (4)
-
-#ifndef __ASSEMBLY__
-
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
-#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
-#define USER_DS		MAKE_MM_SEG(__USER_DS)
-#define KERNEL_DS	MAKE_MM_SEG(__KERNEL_DS)
-
-/*
- * Get/set the SFC/DFC registers for MOVES instructions
- */
-
-static inline mm_segment_t get_fs(void)
-{
-	return USER_DS;
-}
-
-#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* _H8300_SEGMENT_H */
diff --git a/arch/h8300/include/asm/thread_info.h b/arch/h8300/include/asm/thread_info.h
index a518214d4ddd..ff2d873749a4 100644
--- a/arch/h8300/include/asm/thread_info.h
+++ b/arch/h8300/include/asm/thread_info.h
@@ -10,7 +10,6 @@
 #define _ASM_THREAD_INFO_H
 
 #include <asm/page.h>
-#include <asm/segment.h>
 
 #ifdef __KERNEL__
 
@@ -31,7 +30,6 @@ struct thread_info {
 	unsigned long	   flags;		/* low level flags */
 	int		   cpu;			/* cpu we're on */
 	int		   preempt_count;	/* 0 => preemptable, <0 => BUG */
-	mm_segment_t		addr_limit;
 };
 
 /*
@@ -43,7 +41,6 @@ struct thread_info {
 	.flags =	0,			\
 	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 /* how to get the thread information struct from C */
diff --git a/arch/h8300/kernel/entry.S b/arch/h8300/kernel/entry.S
index c6e289b5f1f2..42db87c17917 100644
--- a/arch/h8300/kernel/entry.S
+++ b/arch/h8300/kernel/entry.S
@@ -17,7 +17,6 @@
 #include <linux/sys.h>
 #include <asm/unistd.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
diff --git a/arch/h8300/kernel/head_ram.S b/arch/h8300/kernel/head_ram.S
index dbf8429f5fab..489462f0ee57 100644
--- a/arch/h8300/kernel/head_ram.S
+++ b/arch/h8300/kernel/head_ram.S
@@ -4,7 +4,6 @@
 #include <linux/init.h>
 #include <asm/unistd.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index f7bf4693e3b2..9fa13312720a 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -34,7 +34,6 @@
 #include <linux/gfp.h>
 
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 
@@ -71,11 +70,6 @@ void __init paging_init(void)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 		      __func__, PAGE_SIZE, PAGE_SIZE);
 
-	/*
-	 * Set up SFC/DFC registers (user data space).
-	 */
-	set_fs(USER_DS);
-
 	pr_debug("before free_area_init\n");
 
 	pr_debug("free_area_init -> start_mem is %#lx\nvirtual_end is %#lx\n",
diff --git a/arch/h8300/mm/memory.c b/arch/h8300/mm/memory.c
index 4a60e2b5eb96..c950571064d2 100644
--- a/arch/h8300/mm/memory.c
+++ b/arch/h8300/mm/memory.c
@@ -24,7 +24,6 @@
 #include <linux/types.h>
 
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/traps.h>
 #include <asm/io.h>
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 15dd8f38b698..54eadf265178 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -30,7 +30,6 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
-	select SET_FS
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select TRACE_IRQFLAGS_SUPPORT
 	help
diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index 535976665bf0..e90f280b9ce3 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -22,10 +22,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 /*
  * This is union'd with the "bottom" of the kernel stack.
  * It keeps track of thread info which is handy for routines
@@ -37,7 +33,6 @@ struct thread_info {
 	unsigned long		flags;          /* low level flags */
 	__u32                   cpu;            /* current cpu */
 	int                     preempt_count;  /* 0=>preemptible,<0=>BUG */
-	mm_segment_t            addr_limit;     /* segmentation sux */
 	/*
 	 * used for syscalls somehow;
 	 * seems to have a function pointer and four arguments
@@ -66,7 +61,6 @@ struct thread_info {
 	.flags          = 0,                    \
 	.cpu            = 0,                    \
 	.preempt_count  = 1,                    \
-	.addr_limit     = KERNEL_DS,            \
 	.sp = 0,				\
 	.regs = NULL,			\
 }
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 232dfd8956aa..dfa6b2757c05 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -105,7 +105,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	/*
 	 * Parent sees new pid -- not necessary, not even possible at
 	 * this point in the fork process
-	 * Might also want to set things like ti->addr_limit
 	 */
 
 	return 0;
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 59798e43cdb0..1fb1cec087b7 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -42,7 +42,6 @@ config MICROBLAZE
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE
 	select SPARSE_IRQ
-	select SET_FS
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
 
diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index 44f5ca331862..a0ddd2a36fb9 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -56,17 +56,12 @@ struct cpu_context {
 	__u32	fsr;
 };
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 struct thread_info {
 	struct task_struct	*task; /* main task structure */
 	unsigned long		flags; /* low level flags */
 	unsigned long		status; /* thread-synchronous flags */
 	__u32			cpu; /* current CPU */
 	__s32			preempt_count; /* 0 => preemptable,< 0 => BUG*/
-	mm_segment_t		addr_limit; /* thread address space */
 
 	struct cpu_context	cpu_context;
 };
@@ -80,7 +75,6 @@ struct thread_info {
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 /* how to get the thread information struct from C */
diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index dd82e90adb52..ea0c1f11035f 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -15,30 +15,6 @@
 #include <linux/pgtable.h>
 #include <asm/extable.h>
 #include <linux/string.h>
-
-/*
- * On Microblaze the fs value is actually the top of the corresponding
- * address space.
- *
- * The fs value determines whether argument validity checking should be
- * performed or not. If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- *
- * For non-MMU arch like Microblaze, KERNEL_DS and USER_DS is equal.
- */
-# define MAKE_MM_SEG(s)       ((mm_segment_t) { (s) })
-
-#  define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFF)
-#  define USER_DS	MAKE_MM_SEG(TASK_SIZE - 1)
-
-# define get_fs()	(current_thread_info()->addr_limit)
-# define set_fs(val)	(current_thread_info()->addr_limit = (val))
-# define user_addr_max() get_fs().seg
-
-# define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
-
 #include <asm-generic/access_ok.h>
 
 # define __FIXUP_SECTION	".section .fixup,\"ax\"\n"
diff --git a/arch/microblaze/kernel/asm-offsets.c b/arch/microblaze/kernel/asm-offsets.c
index b77dd188dec4..47ee409508b1 100644
--- a/arch/microblaze/kernel/asm-offsets.c
+++ b/arch/microblaze/kernel/asm-offsets.c
@@ -86,7 +86,6 @@ int main(int argc, char *argv[])
 	/* struct thread_info */
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
-	DEFINE(TI_ADDR_LIMIT, offsetof(struct thread_info, addr_limit));
 	DEFINE(TI_CPU_CONTEXT, offsetof(struct thread_info, cpu_context));
 	DEFINE(TI_PREEMPT_COUNT, offsetof(struct thread_info, preempt_count));
 	BLANK();
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 5e2b91c1e8ce..1b944d319d73 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -18,7 +18,6 @@
 #include <linux/tick.h>
 #include <linux/bitops.h>
 #include <linux/ptrace.h>
-#include <linux/uaccess.h> /* for USER_DS macros */
 #include <asm/cacheflush.h>
 
 void show_regs(struct pt_regs *regs)
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 4d1421b18734..013249430fa3 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -44,7 +44,6 @@ config NDS32
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 	help
 	  Andes(nds32) Linux support.
diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
index d3967ad184f0..bd8f81cf2ce5 100644
--- a/arch/nds32/include/asm/thread_info.h
+++ b/arch/nds32/include/asm/thread_info.h
@@ -16,8 +16,6 @@ struct task_struct;
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
-typedef unsigned long mm_segment_t;
-
 /*
  * low level task data that entry.S needs immediate access to.
  * __switch_to() assumes cpu_context follows immediately after cpu_domain.
@@ -25,12 +23,10 @@ typedef unsigned long mm_segment_t;
 struct thread_info {
 	unsigned long flags;	/* low level flags */
 	__s32 preempt_count;	/* 0 => preemptable, <0 => bug */
-	mm_segment_t addr_limit;	/* address limit */
 };
 #define INIT_THREAD_INFO(tsk)						\
 {									\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
-	.addr_limit	= KERNEL_DS,					\
 }
 #define thread_saved_pc(tsk) ((unsigned long)(tsk->thread.cpu_context.pc))
 #define thread_saved_fp(tsk) ((unsigned long)(tsk->thread.cpu_context.fp))
diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 832d642a4068..377548d4451a 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -11,6 +11,7 @@
 #include <asm/errno.h>
 #include <asm/memory.h>
 #include <asm/types.h>
+#include <asm-generic/access_ok.h>
 
 #define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
 
@@ -33,20 +34,6 @@ struct exception_table_entry {
 
 extern int fixup_exception(struct pt_regs *regs);
 
-#define KERNEL_DS 	((mm_segment_t) { ~0UL })
-#define USER_DS		((mm_segment_t) {TASK_SIZE - 1})
-
-#define get_fs()	(current_thread_info()->addr_limit)
-#define user_addr_max	get_fs
-#define uaccess_kernel() (get_fs() == KERNEL_DS)
-
-static inline void set_fs(mm_segment_t fs)
-{
-	current_thread_info()->addr_limit = fs;
-}
-
-#include <asm-generic/access_ok.h>
-
 /*
  * Single-value transfer routines.  They automatically use the right
  * size if we just have the right pointer type.  Note that the functions
diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index 1eb7ded6992b..9c2c0a454da8 100644
--- a/arch/nds32/mm/alignment.c
+++ b/arch/nds32/mm/alignment.c
@@ -512,7 +512,6 @@ int do_unaligned_access(unsigned long addr, struct pt_regs *regs)
 {
 	unsigned long inst;
 	int ret = -EFAULT;
-	mm_segment_t seg;
 
 	inst = get_inst(regs->ipc);
 
@@ -520,12 +519,10 @@ int do_unaligned_access(unsigned long addr, struct pt_regs *regs)
 	      "Faulting addr: 0x%08lx, pc: 0x%08lx [inst: 0x%08lx ]\n", addr,
 	      regs->ipc, inst);
 
-	seg = force_uaccess_begin();
 	if (inst & NDS32_16BIT_INSTRUCTION)
 		ret = do_16((inst >> 16) & 0xffff, regs);
 	else
 		ret = do_32(inst, regs);
-	force_uaccess_end(seg);
 
 	return ret;
 }
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 33fd06f5fa41..4167f1eb4cd8 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -24,7 +24,6 @@ config NIOS2
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE if MMU
-	select SET_FS
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 272d2c72a727..bcc0e9915ebd 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -26,10 +26,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 /*
  * low level task data that entry.S needs immediate access to
  * - this struct should fit entirely inside of one cache line
@@ -42,10 +38,6 @@ struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable,<0 => BUG */
-	mm_segment_t		addr_limit;	/* thread address space:
-						  0-0x7FFFFFFF for user-thead
-						  0-0xFFFFFFFF for kernel-thread
-						*/
 	struct pt_regs		*regs;
 };
 
@@ -60,7 +52,6 @@ struct thread_info {
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 /* how to get the thread information struct from C */
diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index 9a7658df7f8d..6d364e459458 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -18,18 +18,6 @@
 #include <asm/page.h>
 
 #include <asm/extable.h>
-
-/*
- * Segment stuff
- */
-#define MAKE_MM_SEG(s)		((mm_segment_t) { (s) })
-#define USER_DS			MAKE_MM_SEG(0x80000000UL)
-#define KERNEL_DS		MAKE_MM_SEG(0)
-
-
-#define get_fs()		(current_thread_info()->addr_limit)
-#define set_fs(seg)		(current_thread_info()->addr_limit = (seg))
-
 #include <asm-generic/access_ok.h>
 
 # define __EX_TABLE_SECTION	".section __ex_table,\"a\"\n"
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index f724b3f1aeed..0d68adf6e02b 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -36,7 +36,6 @@ config OPENRISC
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select MMU_GATHER_NO_RANGE if MMU
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 
 config CPU_BIG_ENDIAN
diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
index 659834ab87fa..4af3049c34c2 100644
--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -40,18 +40,12 @@
  */
 #ifndef __ASSEMBLY__
 
-typedef unsigned long mm_segment_t;
-
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
-	mm_segment_t		addr_limit; /* thread address space:
-					       0-0x7FFFFFFF for user-thead
-					       0-0xFFFFFFFF for kernel-thread
-					     */
 	__u8			supervisor_stack[0];
 
 	/* saved context data */
@@ -71,7 +65,6 @@ struct thread_info {
 	.flags		= 0,				\
 	.cpu		= 0,				\
 	.preempt_count	= INIT_PREEMPT_COUNT,		\
-	.addr_limit	= KERNEL_DS,			\
 	.ksp            = 0,                            \
 }
 
diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 8f049ec99b3e..d6500a374e18 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -22,29 +22,6 @@
 #include <linux/string.h>
 #include <asm/page.h>
 #include <asm/extable.h>
-
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- */
-
-/* addr_limit is the maximum accessible address for the task. we misuse
- * the KERNEL_DS and USER_DS values to both assign and compare the
- * addr_limit values through the equally misnamed get/set_fs macros.
- * (see above)
- */
-
-#define KERNEL_DS	(~0UL)
-
-#define USER_DS		(TASK_SIZE)
-#define get_fs()	(current_thread_info()->addr_limit)
-#define set_fs(x)	(current_thread_info()->addr_limit = (x))
-
-#define uaccess_kernel()	(get_fs() == KERNEL_DS)
-
 #include <asm-generic/access_ok.h>
 
 /*
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 1cab1b284f1a..875388835a58 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -46,7 +46,6 @@ config SPARC
 	select LOCKDEP_SMALL if LOCKDEP
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 
 config SPARC32
@@ -100,6 +99,7 @@ config SPARC64
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select SET_FS
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index 647bf0ac7beb..b26c35336b51 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -32,10 +32,6 @@ struct fpq {
 };
 #endif
 
-typedef struct {
-	int seg;
-} mm_segment_t;
-
 /* The Sparc processor specific thread struct. */
 struct thread_struct {
 	struct pt_regs *kregs;
@@ -50,11 +46,9 @@ struct thread_struct {
 	unsigned long   fsr;
 	unsigned long   fpqdepth;
 	struct fpq	fpqueue[16];
-	mm_segment_t current_ds;
 };
 
 #define INIT_THREAD  { \
-	.current_ds = KERNEL_DS, \
 	.kregs = (struct pt_regs *)(init_stack+THREAD_SIZE)-1 \
 }
 
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index 367747116260..9fd6c53644b6 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -12,19 +12,6 @@
 #include <linux/string.h>
 
 #include <asm/processor.h>
-
-/* Sparc is not segmented, however we need to be able to fool access_ok()
- * when doing system calls from kernel mode legitimately.
- *
- * "For historical reasons, these macros are grossly misnamed." -Linus
- */
-
-#define KERNEL_DS   ((mm_segment_t) { 0 })
-#define USER_DS     ((mm_segment_t) { -1 })
-
-#define get_fs()	(current->thread.current_ds)
-#define set_fs(val)	((current->thread.current_ds) = (val))
-
 #include <asm-generic/access_ok.h>
 
 /* Uh, these should become the main single-value transfer routines..
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 2dc0bf9fe62e..88c0c14aaff0 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -300,7 +300,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
-		p->thread.current_ds = KERNEL_DS;
 		ti->kpc = (((unsigned long) ret_from_kernel_thread) - 0x8);
 		childregs->u_regs[UREG_G1] = sp; /* function */
 		childregs->u_regs[UREG_G2] = arg;
@@ -311,7 +310,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	}
 	memcpy(new_stack, (char *)regs - STACKFRAME_SZ, STACKFRAME_SZ + TRACEREG_SZ);
 	childregs->u_regs[UREG_FP] = sp;
-	p->thread.current_ds = USER_DS;
 	ti->kpc = (((unsigned long) ret_from_fork) - 0x8);
 	ti->kpsr = current->thread.fork_kpsr | PSR_PIL;
 	ti->kwim = current->thread.fork_kwim;
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 8ac599aa6d99..09f7616a0b46 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -40,7 +40,6 @@ config XTENSA
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 	select VIRT_TO_BUS
 	help
diff --git a/arch/xtensa/include/asm/asm-uaccess.h b/arch/xtensa/include/asm/asm-uaccess.h
index 7f6cf4151843..7cec869136e3 100644
--- a/arch/xtensa/include/asm/asm-uaccess.h
+++ b/arch/xtensa/include/asm/asm-uaccess.h
@@ -23,76 +23,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/processor.h>
 
-/*
- * These assembly macros mirror the C macros in asm/uaccess.h.  They
- * should always have identical functionality.  See
- * arch/xtensa/kernel/sys.S for usage.
- */
-
-#define KERNEL_DS	0
-#define USER_DS		1
-
-/*
- * get_fs reads current->thread.current_ds into a register.
- * On Entry:
- * 	<ad>	anything
- * 	<sp>	stack
- * On Exit:
- * 	<ad>	contains current->thread.current_ds
- */
-	.macro	get_fs	ad, sp
-	GET_CURRENT(\ad,\sp)
-#if THREAD_CURRENT_DS > 1020
-	addi	\ad, \ad, TASK_THREAD
-	l32i	\ad, \ad, THREAD_CURRENT_DS - TASK_THREAD
-#else
-	l32i	\ad, \ad, THREAD_CURRENT_DS
-#endif
-	.endm
-
-/*
- * set_fs sets current->thread.current_ds to some value.
- * On Entry:
- *	<at>	anything (temp register)
- *	<av>	value to write
- *	<sp>	stack
- * On Exit:
- *	<at>	destroyed (actually, current)
- *	<av>	preserved, value to write
- */
-	.macro	set_fs	at, av, sp
-	GET_CURRENT(\at,\sp)
-	s32i	\av, \at, THREAD_CURRENT_DS
-	.endm
-
-/*
- * kernel_ok determines whether we should bypass addr/size checking.
- * See the equivalent C-macro version below for clarity.
- * On success, kernel_ok branches to a label indicated by parameter
- * <success>.  This implies that the macro falls through to the next
- * insruction on an error.
- *
- * Note that while this macro can be used independently, we designed
- * in for optimal use in the access_ok macro below (i.e., we fall
- * through on error).
- *
- * On Entry:
- * 	<at>		anything (temp register)
- * 	<success>	label to branch to on success; implies
- * 			fall-through macro on error
- * 	<sp>		stack pointer
- * On Exit:
- * 	<at>		destroyed (actually, current->thread.current_ds)
- */
-
-#if ((KERNEL_DS != 0) || (USER_DS == 0))
-# error Assembly macro kernel_ok fails
-#endif
-	.macro	kernel_ok  at, sp, success
-	get_fs	\at, \sp
-	beqz	\at, \success
-	.endm
-
 /*
  * user_ok determines whether the access to user-space memory is allowed.
  * See the equivalent C-macro version below for clarity.
@@ -147,7 +77,6 @@
  * 	<at>	destroyed
  */
 	.macro	access_ok  aa, as, at, sp, error
-	kernel_ok  \at, \sp, .Laccess_ok_\@
 	user_ok    \aa, \as, \at, \error
 .Laccess_ok_\@:
 	.endm
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 37d3e9887fe7..abad7c3df46f 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -152,18 +152,12 @@
  */
 #define SPILL_SLOT_CALL12(sp, reg) (*(((unsigned long *)(sp)) - 16 + (reg)))
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 struct thread_struct {
 
 	/* kernel's return address and stack pointer for context switching */
 	unsigned long ra; /* kernel's a0: return address and window call size */
 	unsigned long sp; /* kernel's a1: stack pointer */
 
-	mm_segment_t current_ds;    /* see uaccess.h for example uses */
-
 	/* struct xtensa_cpuinfo info; */
 
 	unsigned long bad_vaddr; /* last user fault */
@@ -186,7 +180,6 @@ struct thread_struct {
 {									\
 	ra:		0, 						\
 	sp:		sizeof(init_stack) + (long) &init_stack,	\
-	current_ds:	{0},						\
 	/*info:		{0}, */						\
 	bad_vaddr:	0,						\
 	bad_uaddr:	0,						\
diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index a312333a9add..f6fcbba1d02f 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -52,8 +52,6 @@ struct thread_info {
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count;	/* 0 => preemptable,< 0 => BUG*/
 
-	mm_segment_t		addr_limit;	/* thread address space */
-
 	unsigned long		cpenable;
 #if XCHAL_HAVE_EXCLUSIVE
 	/* result of the most recent exclusive store */
@@ -81,7 +79,6 @@ struct thread_info {
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 /* how to get the thread information struct from C */
diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 0edd9e4b23d0..56aec6d504fe 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -19,22 +19,6 @@
 #include <linux/prefetch.h>
 #include <asm/types.h>
 #include <asm/extable.h>
-
-/*
- * The fs value determines whether argument validity checking should
- * be performed or not.  If get_fs() == USER_DS, checking is
- * performed, with get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons (Data Segment Register?), these macros are
- * grossly misnamed.
- */
-
-#define KERNEL_DS	((mm_segment_t) { 0 })
-#define USER_DS		((mm_segment_t) { 1 })
-
-#define get_fs()	(current->thread.current_ds)
-#define set_fs(val)	(current->thread.current_ds = (val))
-
 #include <asm-generic/access_ok.h>
 
 /*
diff --git a/arch/xtensa/kernel/asm-offsets.c b/arch/xtensa/kernel/asm-offsets.c
index dc5c83cad9be..f1fd1390d069 100644
--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -87,7 +87,6 @@ int main(void)
 	OFFSET(TI_STSTUS, thread_info, status);
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
-	OFFSET(TI_ADDR_LIMIT, thread_info, addr_limit);
 
 	/* struct thread_info (offset from start_struct) */
 	DEFINE(THREAD_RA, offsetof (struct task_struct, thread.ra));
@@ -108,8 +107,6 @@ int main(void)
 #endif
 	DEFINE(THREAD_XTREGS_USER, offsetof (struct thread_info, xtregs_user));
 	DEFINE(XTREGS_USER_SIZE, sizeof(xtregs_user_t));
-	DEFINE(THREAD_CURRENT_DS, offsetof (struct task_struct, \
-	       thread.current_ds));
 
 	/* struct mm_struct */
 	DEFINE(MM_USERS, offsetof(struct mm_struct, mm_users));
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index ebc685dc8d74..a5be9e61a2a2 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -8,6 +8,7 @@
  * address space, e.g. all NOMMU machines.
  */
 #include <linux/string.h>
+#include <asm-generic/access_ok.h>
 
 #ifdef CONFIG_UACCESS_MEMCPY
 #include <asm/unaligned.h>
@@ -94,30 +95,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 #define INLINE_COPY_TO_USER
 #endif /* CONFIG_UACCESS_MEMCPY */
 
-#ifdef CONFIG_SET_FS
-#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
-
-#ifndef KERNEL_DS
-#define KERNEL_DS	MAKE_MM_SEG(~0UL)
-#endif
-
-#ifndef USER_DS
-#define USER_DS		MAKE_MM_SEG(TASK_SIZE - 1)
-#endif
-
-#ifndef get_fs
-#define get_fs()	(current_thread_info()->addr_limit)
-
-static inline void set_fs(mm_segment_t fs)
-{
-	current_thread_info()->addr_limit = fs;
-}
-#endif
-
-#endif /* CONFIG_SET_FS */
-
-#include <asm-generic/access_ok.h>
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
-- 
2.29.2

