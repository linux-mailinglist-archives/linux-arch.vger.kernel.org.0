Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA654B5709
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 17:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356708AbiBNQis (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 11:38:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356551AbiBNQiD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 11:38:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB8960D88;
        Mon, 14 Feb 2022 08:37:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BAF86150D;
        Mon, 14 Feb 2022 16:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14ABC340E9;
        Mon, 14 Feb 2022 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856674;
        bh=V6/ZfWZ1PAD3Y97L2QNR1QNU/2itdbWUv5bvEuYuqFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOAf9yBvH1riDXG/nGNPY+w9Gc9bnqic4pnJ0+tu96kd19/UyQ+Onu2FZTuj/qx3H
         5DZ48NElBgU3qg/LDAY1SezCwzOrzgR1DEV7JVhEQY1s/p3xpNft39stpuEoc4sI/q
         K7roa/97KxpQjsDrcV7HwA+T3TThR5YApydcNi+mLOC0+byS8aASvctyxWuoL5KLh3
         DMrCNNigujQsLvalAFKiivzphwW9Yj5VBRBUajRIBc/jTjiD3QI/Gt/oNiPbyJR5ar
         MJMqnkbNnG0hh+1THGkOhds095tIBm/qJ0icPc9d1KZtauxvKz3+3Ip0UHfF/dGlgx
         UNo5dPaPdtkMg==
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
Subject: [PATCH 12/14] sh: remove CONFIG_SET_FS support
Date:   Mon, 14 Feb 2022 17:34:50 +0100
Message-Id: <20220214163452.1568807-13-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

sh uses set_fs/get_fs only in one file, to handle address
errors in both user and kernel memory.

It already has an abstraction to differentiate between I/O
and memory, so adding a third class for kernel memory fits
into the same scheme and lets us kill off CONFIG_SET_FS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/Kconfig                   |  1 -
 arch/sh/include/asm/processor.h   |  1 -
 arch/sh/include/asm/segment.h     | 33 -------------------------------
 arch/sh/include/asm/thread_info.h |  2 --
 arch/sh/include/asm/uaccess.h     |  4 ----
 arch/sh/kernel/io_trapped.c       |  9 ++-------
 arch/sh/kernel/process_32.c       |  2 --
 arch/sh/kernel/traps_32.c         | 30 +++++++++++++++++-----------
 8 files changed, 21 insertions(+), 61 deletions(-)
 delete mode 100644 arch/sh/include/asm/segment.h

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2474a04ceac4..f676e92b7d5b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -65,7 +65,6 @@ config SUPERH
 	select PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select RTC_LIB
-	select SET_FS
 	select SPARSE_IRQ
 	select TRACE_IRQFLAGS_SUPPORT
 	help
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 3820d698846e..85a6c1c3c16e 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -3,7 +3,6 @@
 #define __ASM_SH_PROCESSOR_H
 
 #include <asm/cpu-features.h>
-#include <asm/segment.h>
 #include <asm/cache.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sh/include/asm/segment.h b/arch/sh/include/asm/segment.h
deleted file mode 100644
index 02e54a3335d6..000000000000
--- a/arch/sh/include/asm/segment.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_SEGMENT_H
-#define __ASM_SH_SEGMENT_H
-
-#ifndef __ASSEMBLY__
-
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
-#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
-
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- */
-#define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFFUL)
-#ifdef CONFIG_MMU
-#define USER_DS		MAKE_MM_SEG(PAGE_OFFSET)
-#else
-#define USER_DS		KERNEL_DS
-#endif
-
-#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
-
-#define get_fs()	(current_thread_info()->addr_limit)
-#define set_fs(x)	(current_thread_info()->addr_limit = (x))
-
-#endif /* __ASSEMBLY__ */
-#endif /* __ASM_SH_SEGMENT_H */
diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 598d0184ffea..b119b859a0a3 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -30,7 +30,6 @@ struct thread_info {
 	__u32			status;		/* thread synchronous flags */
 	__u32			cpu;
 	int			preempt_count; /* 0 => preemptable, <0 => BUG */
-	mm_segment_t		addr_limit;	/* thread address space */
 	unsigned long		previous_sp;	/* sp of previous stack in case
 						   of nested IRQ stacks */
 	__u8			supervisor_stack[0];
@@ -58,7 +57,6 @@ struct thread_info {
 	.status		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 /* how to get the current stack pointer from C */
diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index ccd219d74851..a79609eb14be 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -2,11 +2,7 @@
 #ifndef __ASM_SH_UACCESS_H
 #define __ASM_SH_UACCESS_H
 
-#include <asm/segment.h>
 #include <asm/extable.h>
-
-#define user_addr_max()	(current_thread_info()->addr_limit.seg)
-
 #include <asm-generic/access_ok.h>
 
 /*
diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index 004ad0130b10..e803b14ef12e 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -270,7 +270,6 @@ static struct mem_access trapped_io_access = {
 
 int handle_trapped_io(struct pt_regs *regs, unsigned long address)
 {
-	mm_segment_t oldfs;
 	insn_size_t instruction;
 	int tmp;
 
@@ -281,16 +280,12 @@ int handle_trapped_io(struct pt_regs *regs, unsigned long address)
 
 	WARN_ON(user_mode(regs));
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	if (copy_from_user(&instruction, (void *)(regs->pc),
-			   sizeof(instruction))) {
-		set_fs(oldfs);
+	if (copy_from_kernel_nofault(&instruction, (void *)(regs->pc),
+				     sizeof(instruction))) {
 		return 0;
 	}
 
 	tmp = handle_unaligned_access(instruction, regs,
 				      &trapped_io_access, 1, address);
-	set_fs(oldfs);
 	return tmp == 0;
 }
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 1c28e3cddb60..ca01286a0610 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -123,7 +123,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 #if defined(CONFIG_SH_FPU)
 		childregs->sr |= SR_FD;
 #endif
-		ti->addr_limit = KERNEL_DS;
 		ti->status &= ~TS_USEDFPU;
 		p->thread.fpu_counter = 0;
 		return 0;
@@ -132,7 +131,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
 	if (usp)
 		childregs->regs[15] = usp;
-	ti->addr_limit = USER_DS;
 
 	if (clone_flags & CLONE_SETTLS)
 		childregs->gbr = tls;
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index b3c715bc254b..6cdda3a621a1 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -75,6 +75,23 @@ static struct mem_access user_mem_access = {
 	copy_to_user,
 };
 
+static unsigned long copy_from_kernel_wrapper(void *dst, const void __user *src,
+					      unsigned long cnt)
+{
+	return copy_from_kernel_nofault(dst, (const void __force *)src, cnt);
+}
+
+static unsigned long copy_to_kernel_wrapper(void __user *dst, const void *src,
+					    unsigned long cnt)
+{
+	return copy_to_kernel_nofault((void __force *)dst, src, cnt);
+}
+
+static struct mem_access kernel_mem_access = {
+	copy_from_kernel_wrapper,
+	copy_to_kernel_wrapper,
+};
+
 /*
  * handle an instruction that does an unaligned memory access by emulating the
  * desired behaviour
@@ -473,7 +490,6 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 				 unsigned long address)
 {
 	unsigned long error_code = 0;
-	mm_segment_t oldfs;
 	insn_size_t instruction;
 	int tmp;
 
@@ -489,13 +505,10 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 		local_irq_enable();
 		inc_unaligned_user_access();
 
-		oldfs = force_uaccess_begin();
 		if (copy_from_user(&instruction, (insn_size_t __user *)(regs->pc & ~1),
 				   sizeof(instruction))) {
-			force_uaccess_end(oldfs);
 			goto uspace_segv;
 		}
-		force_uaccess_end(oldfs);
 
 		/* shout about userspace fixups */
 		unaligned_fixups_notify(current, instruction, regs);
@@ -518,11 +531,9 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 			goto uspace_segv;
 		}
 
-		oldfs = force_uaccess_begin();
 		tmp = handle_unaligned_access(instruction, regs,
 					      &user_mem_access, 0,
 					      address);
-		force_uaccess_end(oldfs);
 
 		if (tmp == 0)
 			return; /* sorted */
@@ -538,21 +549,18 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 		if (regs->pc & 1)
 			die("unaligned program counter", regs, error_code);
 
-		set_fs(KERNEL_DS);
-		if (copy_from_user(&instruction, (void __user *)(regs->pc),
+		if (copy_from_kernel_nofault(&instruction, (void *)(regs->pc),
 				   sizeof(instruction))) {
 			/* Argh. Fault on the instruction itself.
 			   This should never happen non-SMP
 			*/
-			set_fs(oldfs);
 			die("insn faulting in do_address_error", regs, 0);
 		}
 
 		unaligned_fixups_notify(current, instruction, regs);
 
-		handle_unaligned_access(instruction, regs, &user_mem_access,
+		handle_unaligned_access(instruction, regs, &kernel_mem_access,
 					0, address);
-		set_fs(oldfs);
 	}
 }
 
-- 
2.29.2

