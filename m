Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498BC7A9D52
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 21:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjIUTa7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIUTaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 15:30:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D326D580BB;
        Thu, 21 Sep 2023 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=f+fo5qtlWKdma6yR33ByQC30fFdCan4IPhCDTk6tKSM=; b=HEloi5chIkoAzJ1qmH9doIMMLS
        ZkNSD4N2RkkbqgCewVxvAHggRdWZnFRlWj4IhTeRhItbbFVErm62/CTGDqCmyjsnOp4ZuteeOoFdF
        yIEIu8bnwVXPVpe6KPzotIKluKJ0e+mnwy062T62ceHSKleg0fzg6/b1LE8m/A4OlmlXuCwJfqVcV
        xHMQu5W5PZqXS6brx0IevaeO27f1kU1m0gjva+SDK5AWHjcO2nWlE/J9+3FVfPKfua0pNdfZVpV3Y
        v4a1PegmFDKYJ5+tOvwtgzugAgCj5s7ib09/wtVoAKIabLs7TIX8znLpx9OXnGZG8oI1jFkcJns8j
        3bUiJ+NA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjHQN-00FJvu-1M;
        Thu, 21 Sep 2023 11:00:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 10D1E300642; Thu, 21 Sep 2023 13:00:43 +0200 (CEST)
Message-Id: <20230921105248.511860556@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:15 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 10/15] futex: Add sys_futex_requeue()
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-requeue.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Finish off the 'simple' futex2 syscall group by adding
sys_futex_requeue(). Unlike sys_futex_{wait,wake}() its arguments are
too numerous to fit into a regular syscall. As such, use struct
futex_waitv to pass the 'source' and 'destination' futexes to the
syscall.

This syscall implements what was previously known as FUTEX_CMP_REQUEUE
and uses {val, uaddr, flags} for source and {uaddr, flags} for
destination.

This design explicitly allows requeueing between different types of
futex by having a different flags word per uaddr.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 -
 arch/arm64/include/asm/unistd32.h           |    2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 include/linux/syscalls.h                    |    3 ++
 include/uapi/asm-generic/unistd.h           |    4 ++
 kernel/futex/syscalls.c                     |   38 ++++++++++++++++++++++++++++
 kernel/sys_ni.c                             |    1 
 22 files changed, 64 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/alpha/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/alpha/kernel/syscalls/syscall.tbl
@@ -494,3 +494,4 @@
 562	common	fchmodat2			sys_fchmodat2
 563	common	futex_wake			sys_futex_wake
 564	common	futex_wait			sys_futex_wait
+565	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/arm/tools/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/arm/tools/syscall.tbl
+++ linux-2.6/arch/arm/tools/syscall.tbl
@@ -468,3 +468,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/arm64/include/asm/unistd.h
===================================================================
--- linux-2.6.orig/arch/arm64/include/asm/unistd.h
+++ linux-2.6/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		456
+#define __NR_compat_syscalls		457
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
Index: linux-2.6/arch/arm64/include/asm/unistd32.h
===================================================================
--- linux-2.6.orig/arch/arm64/include/asm/unistd32.h
+++ linux-2.6/arch/arm64/include/asm/unistd32.h
@@ -915,6 +915,8 @@ __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 #define __NR_futex_wait 455
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
+#define __NR_futex_requeue 456
+__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
 /*
  * Please add new compat syscalls above this comment and update
Index: linux-2.6/arch/ia64/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/ia64/kernel/syscalls/syscall.tbl
@@ -375,3 +375,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/m68k/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/m68k/kernel/syscalls/syscall.tbl
@@ -454,3 +454,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/microblaze/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/microblaze/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -460,3 +460,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_n32.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -393,3 +393,4 @@
 452	n32	fchmodat2			sys_fchmodat2
 454	n32	futex_wake			sys_futex_wake
 455	n32	futex_wait			sys_futex_wait
+456	n32	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_n64.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -369,3 +369,4 @@
 452	n64	fchmodat2			sys_fchmodat2
 454	n64	futex_wake			sys_futex_wake
 455	n64	futex_wait			sys_futex_wait
+456	n64	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_o32.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -442,3 +442,4 @@
 452	o32	fchmodat2			sys_fchmodat2
 454	o32	futex_wake			sys_futex_wake
 455	o32	futex_wait			sys_futex_wait
+456	o32	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/parisc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/parisc/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/powerpc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -541,3 +541,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/s390/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/s390/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/s390/kernel/syscalls/syscall.tbl
@@ -457,3 +457,4 @@
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
+456  common	futex_requeue		sys_futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/sh/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/sh/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/sh/kernel/syscalls/syscall.tbl
@@ -457,3 +457,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/sparc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/sparc/kernel/syscalls/syscall.tbl
@@ -500,3 +500,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/arch/x86/entry/syscalls/syscall_32.tbl
===================================================================
--- linux-2.6.orig/arch/x86/entry/syscalls/syscall_32.tbl
+++ linux-2.6/arch/x86/entry/syscalls/syscall_32.tbl
@@ -459,3 +459,4 @@
 452	i386	fchmodat2		sys_fchmodat2
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
+456	i386	futex_requeue		sys_futex_requeue
Index: linux-2.6/arch/x86/entry/syscalls/syscall_64.tbl
===================================================================
--- linux-2.6.orig/arch/x86/entry/syscalls/syscall_64.tbl
+++ linux-2.6/arch/x86/entry/syscalls/syscall_64.tbl
@@ -377,6 +377,7 @@
 453	64	map_shadow_stack	sys_map_shadow_stack
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
+456	common	futex_requeue		sys_futex_requeue
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
Index: linux-2.6/arch/xtensa/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -425,3 +425,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
Index: linux-2.6/include/linux/syscalls.h
===================================================================
--- linux-2.6.orig/include/linux/syscalls.h
+++ linux-2.6/include/linux/syscalls.h
@@ -556,6 +556,9 @@ asmlinkage long sys_futex_wait(void __us
 			       unsigned int flags, struct __kernel_timespec __user *timespec,
 			       clockid_t clockid);
 
+asmlinkage long sys_futex_requeue(struct futex_waitv __user *waiters,
+				  unsigned int flags, int nr_wake, int nr_requeue);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
Index: linux-2.6/include/uapi/asm-generic/unistd.h
===================================================================
--- linux-2.6.orig/include/uapi/asm-generic/unistd.h
+++ linux-2.6/include/uapi/asm-generic/unistd.h
@@ -826,9 +826,11 @@ __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 #define __NR_futex_wait 455
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
+#define __NR_futex_requeue 456
+__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
 #undef __NR_syscalls
-#define __NR_syscalls 456
+#define __NR_syscalls 457
 
 /*
  * 32 bit systems traditionally used different
Index: linux-2.6/kernel/futex/syscalls.c
===================================================================
--- linux-2.6.orig/kernel/futex/syscalls.c
+++ linux-2.6/kernel/futex/syscalls.c
@@ -396,6 +396,44 @@ SYSCALL_DEFINE6(futex_wait,
 	return ret;
 }
 
+/*
+ * sys_futex_requeue - Requeue a waiter from one futex to another
+ * @waiters:	array describing the source and destination futex
+ * @flags:	unused
+ * @nr_wake:	number of futexes to wake
+ * @nr_requeue:	number of futexes to requeue
+ *
+ * Identical to the traditional FUTEX_CMP_REQUEUE op, except it is part of the
+ * futex2 family of calls.
+ */
+
+SYSCALL_DEFINE4(futex_requeue,
+		struct futex_waitv __user *, waiters,
+		unsigned int, flags,
+		int, nr_wake,
+		int, nr_requeue)
+{
+	struct futex_vector futexes[2];
+	u32 cmpval;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	if (!waiters)
+		return -EINVAL;
+
+	ret = futex_parse_waitv(futexes, waiters, 2);
+	if (ret)
+		return ret;
+
+	cmpval = futexes[0].w.val;
+
+	return futex_requeue(u64_to_user_ptr(futexes[0].w.uaddr), futexes[0].w.flags,
+			     u64_to_user_ptr(futexes[1].w.uaddr), futexes[1].w.flags,
+			     nr_wake, nr_requeue, &cmpval, 0);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
Index: linux-2.6/kernel/sys_ni.c
===================================================================
--- linux-2.6.orig/kernel/sys_ni.c
+++ linux-2.6/kernel/sys_ni.c
@@ -89,6 +89,7 @@ COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
 COND_SYSCALL(futex_wake);
 COND_SYSCALL(futex_wait);
+COND_SYSCALL(futex_requeue);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);


