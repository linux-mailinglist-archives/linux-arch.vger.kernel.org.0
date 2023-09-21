Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F137A9A14
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjIUSgP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIUSfw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 14:35:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078EECD4;
        Thu, 21 Sep 2023 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xsbwJJWQRl6v4i26c9uvT221icEnXzjXoYJDfVyH/TQ=; b=Fo6P3/MvFvvR8pAfvb8nlrxdCk
        OnjgXIeagZ73bqEbOHv6sBpNm7aVbhIlfhvEUXSLSnY4lqUuTO+9u/I5QWw63Es2TmQoz5JwiWcz1
        h5ceHTW6+tvyHmyl4oVHIM0R8pNJcJBfb/qeMYFMRCTx7WpeGf63PPlwkbUsmMJoWVCW7l+ri2x8v
        IK4+6rqRjm1NZGD/5ohORG+LiwpYxohmX1WOQkLzfuVBgizIDskFfDVqId6iY9Ue30gXrbnYxrbDJ
        vaUy+33vOL82TVWcuPuhVg8P8d1Aq2vITDIv3t2f7gpt0Z+r5aQJA5k2P68okHqmFMYru4zQXSqoj
        76ytotLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjHQO-00BTol-Tz; Thu, 21 Sep 2023 11:00:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 015323005AA; Thu, 21 Sep 2023 13:00:42 +0200 (CEST)
Message-Id: <20230921105248.164324363@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:12 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 07/15] futex: Add sys_futex_wait()
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-wait.patch
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To complement sys_futex_waitv()/wake(), add sys_futex_wait(). This
syscall implements what was previously known as FUTEX_WAIT_BITSET
except it uses 'unsigned long' for the value and bitmask arguments,
takes timespec and clockid_t arguments for the absolute timeout and
uses FUTEX2 flags.

The 'unsigned long' allows FUTEX2_SIZE_U64 on 64bit platforms.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/arm64/include/asm/unistd32.h           |    2 
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
 include/linux/syscalls.h                    |    4 
 include/uapi/asm-generic/unistd.h           |    4 
 kernel/futex/futex.h                        |    3 
 kernel/futex/syscalls.c                     |  120 +++++++++++++++++++++-------
 kernel/futex/waitwake.c                     |   67 +++++++++------
 kernel/sys_ni.c                             |    1 
 24 files changed, 159 insertions(+), 60 deletions(-)

Index: linux-2.6/arch/alpha/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/alpha/kernel/syscalls/syscall.tbl
@@ -493,3 +493,4 @@
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
 563	common	futex_wake			sys_futex_wake
+564	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/arm/tools/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/arm/tools/syscall.tbl
+++ linux-2.6/arch/arm/tools/syscall.tbl
@@ -467,3 +467,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/arm64/include/asm/unistd.h
===================================================================
--- linux-2.6.orig/arch/arm64/include/asm/unistd.h
+++ linux-2.6/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		455
+#define __NR_compat_syscalls		456
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
Index: linux-2.6/arch/arm64/include/asm/unistd32.h
===================================================================
--- linux-2.6.orig/arch/arm64/include/asm/unistd32.h
+++ linux-2.6/arch/arm64/include/asm/unistd32.h
@@ -913,6 +913,8 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 #define __NR_futex_wake 454
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
+#define __NR_futex_wait 455
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
 
 /*
  * Please add new compat syscalls above this comment and update
Index: linux-2.6/arch/ia64/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/ia64/kernel/syscalls/syscall.tbl
@@ -374,3 +374,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/m68k/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/m68k/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/microblaze/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/microblaze/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_n32.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -392,3 +392,4 @@
 451	n32	cachestat			sys_cachestat
 452	n32	fchmodat2			sys_fchmodat2
 454	n32	futex_wake			sys_futex_wake
+455	n32	futex_wait			sys_futex_wait
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_n64.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -368,3 +368,4 @@
 451	n64	cachestat			sys_cachestat
 452	n64	fchmodat2			sys_fchmodat2
 454	n64	futex_wake			sys_futex_wake
+455	n64	futex_wait			sys_futex_wait
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_o32.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -441,3 +441,4 @@
 451	o32	cachestat			sys_cachestat
 452	o32	fchmodat2			sys_fchmodat2
 454	o32	futex_wake			sys_futex_wake
+455	o32	futex_wait			sys_futex_wait
Index: linux-2.6/arch/parisc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/parisc/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/powerpc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -540,3 +540,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/s390/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/s390/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/s390/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
+455  common	futex_wait		sys_futex_wait			sys_futex_wait
Index: linux-2.6/arch/sh/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/sh/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/sh/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/sparc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/sparc/kernel/syscalls/syscall.tbl
@@ -499,3 +499,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/arch/x86/entry/syscalls/syscall_32.tbl
===================================================================
--- linux-2.6.orig/arch/x86/entry/syscalls/syscall_32.tbl
+++ linux-2.6/arch/x86/entry/syscalls/syscall_32.tbl
@@ -458,3 +458,4 @@
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
 454	i386	futex_wake		sys_futex_wake
+455	i386	futex_wait		sys_futex_wait
Index: linux-2.6/arch/x86/entry/syscalls/syscall_64.tbl
===================================================================
--- linux-2.6.orig/arch/x86/entry/syscalls/syscall_64.tbl
+++ linux-2.6/arch/x86/entry/syscalls/syscall_64.tbl
@@ -376,6 +376,7 @@
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
 454	common	futex_wake		sys_futex_wake
+455	common	futex_wait		sys_futex_wait
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
Index: linux-2.6/arch/xtensa/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -424,3 +424,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
Index: linux-2.6/include/linux/syscalls.h
===================================================================
--- linux-2.6.orig/include/linux/syscalls.h
+++ linux-2.6/include/linux/syscalls.h
@@ -552,6 +552,10 @@ asmlinkage long sys_futex_waitv(struct f
 
 asmlinkage long sys_futex_wake(void __user *uaddr, unsigned long mask, int nr, unsigned int flags);
 
+asmlinkage long sys_futex_wait(void __user *uaddr, unsigned long val, unsigned long mask,
+			       unsigned int flags, struct __kernel_timespec __user *timespec,
+			       clockid_t clockid);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
Index: linux-2.6/include/uapi/asm-generic/unistd.h
===================================================================
--- linux-2.6.orig/include/uapi/asm-generic/unistd.h
+++ linux-2.6/include/uapi/asm-generic/unistd.h
@@ -824,9 +824,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 #define __NR_futex_wake 454
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
+#define __NR_futex_wait 455
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
 
 #undef __NR_syscalls
-#define __NR_syscalls 455
+#define __NR_syscalls 456
 
 /*
  * 32 bit systems traditionally used different
Index: linux-2.6/kernel/futex/futex.h
===================================================================
--- linux-2.6.orig/kernel/futex/futex.h
+++ linux-2.6/kernel/futex/futex.h
@@ -332,6 +332,9 @@ extern int futex_requeue(u32 __user *uad
 			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
 			 u32 *cmpval, int requeue_pi);
 
+extern int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
+			struct hrtimer_sleeper *to, u32 bitset);
+
 extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset);
 
Index: linux-2.6/kernel/futex/syscalls.c
===================================================================
--- linux-2.6.orig/kernel/futex/syscalls.c
+++ linux-2.6/kernel/futex/syscalls.c
@@ -221,6 +221,46 @@ static int futex_parse_waitv(struct fute
 	return 0;
 }
 
+static int futex2_setup_timeout(struct __kernel_timespec __user *timeout,
+				clockid_t clockid, struct hrtimer_sleeper *to)
+{
+	int flag_clkid = 0, flag_init = 0;
+	struct timespec64 ts;
+	ktime_t time;
+	int ret;
+
+	if (!timeout)
+		return 0;
+
+	if (clockid == CLOCK_REALTIME) {
+		flag_clkid = FLAGS_CLOCKRT;
+		flag_init = FUTEX_CLOCK_REALTIME;
+	}
+
+	if (clockid != CLOCK_REALTIME && clockid != CLOCK_MONOTONIC)
+		return -EINVAL;
+
+	if (get_timespec64(&ts, timeout))
+		return -EFAULT;
+
+	/*
+	 * Since there's no opcode for futex_waitv, use
+	 * FUTEX_WAIT_BITSET that uses absolute timeout as well
+	 */
+	ret = futex_init_timeout(FUTEX_WAIT_BITSET, flag_init, &ts, &time);
+	if (ret)
+		return ret;
+
+	futex_setup_timer(&time, to, flag_clkid, 0);
+	return 0;
+}
+
+static inline void futex2_destroy_timeout(struct hrtimer_sleeper *to)
+{
+	hrtimer_cancel(&to->timer);
+	destroy_hrtimer_on_stack(&to->timer);
+}
+
 /**
  * sys_futex_waitv - Wait on a list of futexes
  * @waiters:    List of futexes to wait on
@@ -250,8 +290,6 @@ SYSCALL_DEFINE5(futex_waitv, struct fute
 {
 	struct hrtimer_sleeper to;
 	struct futex_vector *futexv;
-	struct timespec64 ts;
-	ktime_t time;
 	int ret;
 
 	/* This syscall supports no flags for now */
@@ -261,30 +299,8 @@ SYSCALL_DEFINE5(futex_waitv, struct fute
 	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
 		return -EINVAL;
 
-	if (timeout) {
-		int flag_clkid = 0, flag_init = 0;
-
-		if (clockid == CLOCK_REALTIME) {
-			flag_clkid = FLAGS_CLOCKRT;
-			flag_init = FUTEX_CLOCK_REALTIME;
-		}
-
-		if (clockid != CLOCK_REALTIME && clockid != CLOCK_MONOTONIC)
-			return -EINVAL;
-
-		if (get_timespec64(&ts, timeout))
-			return -EFAULT;
-
-		/*
-		 * Since there's no opcode for futex_waitv, use
-		 * FUTEX_WAIT_BITSET that uses absolute timeout as well
-		 */
-		ret = futex_init_timeout(FUTEX_WAIT_BITSET, flag_init, &ts, &time);
-		if (ret)
-			return ret;
-
-		futex_setup_timer(&time, &to, flag_clkid, 0);
-	}
+	if (timeout && (ret = futex2_setup_timeout(timeout, clockid, &to)))
+		return ret;
 
 	futexv = kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
 	if (!futexv) {
@@ -299,10 +315,8 @@ SYSCALL_DEFINE5(futex_waitv, struct fute
 	kfree(futexv);
 
 destroy_timer:
-	if (timeout) {
-		hrtimer_cancel(&to.timer);
-		destroy_hrtimer_on_stack(&to.timer);
-	}
+	if (timeout)
+		futex2_destroy_timeout(&to);
 	return ret;
 }
 
@@ -336,6 +350,52 @@ SYSCALL_DEFINE4(futex_wake,
 	return futex_wake(uaddr, FLAGS_STRICT | flags, nr, mask);
 }
 
+/*
+ * sys_futex_wait - Wait on a futex
+ * @uaddr:	Address of the futex to wait on
+ * @val:	Value of @uaddr
+ * @mask:	bitmask
+ * @flags:	FUTEX2 flags
+ * @timeout:	Optional absolute timeout
+ * @clockid:	Clock to be used for the timeout, realtime or monotonic
+ *
+ * Identical to the traditional FUTEX_WAIT_BITSET op, except it is part of the
+ * futex2 familiy of calls.
+ */
+
+SYSCALL_DEFINE6(futex_wait,
+		void __user *, uaddr,
+		unsigned long, val,
+		unsigned long, mask,
+		unsigned int, flags,
+		struct __kernel_timespec __user *, timeout,
+		clockid_t, clockid)
+{
+	struct hrtimer_sleeper to;
+	int ret;
+
+	if (flags & ~FUTEX2_VALID_MASK)
+		return -EINVAL;
+
+	flags = futex2_to_flags(flags);
+	if (!futex_flags_valid(flags))
+		return -EINVAL;
+
+	if (!futex_validate_input(flags, val) ||
+	    !futex_validate_input(flags, mask))
+		return -EINVAL;
+
+	if (timeout && (ret = futex2_setup_timeout(timeout, clockid, &to)))
+		return ret;
+
+	ret = __futex_wait(uaddr, flags, val, timeout ? &to : NULL, mask);
+
+	if (timeout)
+		futex2_destroy_timeout(&to);
+
+	return ret;
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
Index: linux-2.6/kernel/futex/waitwake.c
===================================================================
--- linux-2.6.orig/kernel/futex/waitwake.c
+++ linux-2.6/kernel/futex/waitwake.c
@@ -632,20 +632,18 @@ retry_private:
 	return ret;
 }
 
-int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
+int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
+		 struct hrtimer_sleeper *to, u32 bitset)
 {
-	struct hrtimer_sleeper timeout, *to;
-	struct restart_block *restart;
-	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
+	struct futex_hash_bucket *hb;
 	int ret;
 
 	if (!bitset)
 		return -EINVAL;
+
 	q.bitset = bitset;
 
-	to = futex_setup_timer(abs_time, &timeout, flags,
-			       current->timer_slack_ns);
 retry:
 	/*
 	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
@@ -653,18 +651,17 @@ retry:
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* futex_queue and wait for wakeup, timeout, or a signal. */
 	futex_wait_queue(hb, &q, to);
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
-	ret = 0;
 	if (!futex_unqueue(&q))
-		goto out;
-	ret = -ETIMEDOUT;
+		return 0;
+
 	if (to && !to->task)
-		goto out;
+		return -ETIMEDOUT;
 
 	/*
 	 * We expect signal_pending(current), but we might be the
@@ -673,24 +670,38 @@ retry:
 	if (!signal_pending(current))
 		goto retry;
 
-	ret = -ERESTARTSYS;
-	if (!abs_time)
-		goto out;
-
-	restart = &current->restart_block;
-	restart->futex.uaddr = uaddr;
-	restart->futex.val = val;
-	restart->futex.time = *abs_time;
-	restart->futex.bitset = bitset;
-	restart->futex.flags = flags | FLAGS_HAS_TIMEOUT;
-
-	ret = set_restart_fn(restart, futex_wait_restart);
-
-out:
-	if (to) {
-		hrtimer_cancel(&to->timer);
-		destroy_hrtimer_on_stack(&to->timer);
+	return -ERESTARTSYS;
+}
+
+int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
+{
+	struct hrtimer_sleeper timeout, *to;
+	struct restart_block *restart;
+	int ret;
+
+	to = futex_setup_timer(abs_time, &timeout, flags,
+			       current->timer_slack_ns);
+
+	ret = __futex_wait(uaddr, flags, val, to, bitset);
+
+	/* No timeout, nothing to clean up. */
+	if (!to)
+		return ret;
+
+	hrtimer_cancel(&to->timer);
+	destroy_hrtimer_on_stack(&to->timer);
+
+	if (ret == -ERESTARTSYS) {
+		restart = &current->restart_block;
+		restart->futex.uaddr = uaddr;
+		restart->futex.val = val;
+		restart->futex.time = *abs_time;
+		restart->futex.bitset = bitset;
+		restart->futex.flags = flags | FLAGS_HAS_TIMEOUT;
+
+		return set_restart_fn(restart, futex_wait_restart);
 	}
+
 	return ret;
 }
 
Index: linux-2.6/kernel/sys_ni.c
===================================================================
--- linux-2.6.orig/kernel/sys_ni.c
+++ linux-2.6/kernel/sys_ni.c
@@ -88,6 +88,7 @@ COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
 COND_SYSCALL(futex_wake);
+COND_SYSCALL(futex_wait);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);


