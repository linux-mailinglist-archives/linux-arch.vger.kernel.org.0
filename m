Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB75C77244A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjHGMha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjHGMhW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539DE10F6;
        Mon,  7 Aug 2023 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EZIyQFpYSmr+EWjOL5a+M3dpjuZvxzS495rTXOpv4ME=; b=ehEsNfwSZ0jDg9NlrPMsn1dqWe
        hSHvvBaaop3p/hC7EAiKB3mpSXaMcVk/pLfS3vCEm+SJXLH2YTa3jWAswyPgX7W0OWD6DXywxUBwM
        SlQXRDZUWVskUJ+Jqofi1maJKT60zqta/JoGUMiaYEc6b1f2GrVs0bGoV2QSG7365xb+ZKUIdY6+x
        X2rgtzAC3ytHrhfdOSjAWDYVC8v6xsHIHRouK6CmddiPPOjmDTrleNbDqa6KGqrcn2f5WjhMHd/na
        XqN6fR5rZfVtevfu35gZqoqbaHihhri3Ks90q59ukzBFu9teGEpzIi7owwqWXBCS+9kSDOcOPL3Kh
        Tj0gpo2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSzTl-003oSm-1l;
        Mon, 07 Aug 2023 12:36:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 277CA301C41;
        Mon,  7 Aug 2023 14:36:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A15492021C3D9; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123323.159400076@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH  v2 06/14] futex: Add sys_futex_wait()
References: <20230807121843.710612856@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -492,3 +492,4 @@
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
 562	common	futex_wake			sys_futex_wake
+563	common	futex_wait			sys_futex_wait
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -466,3 +466,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		453
+#define __NR_compat_syscalls		454
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -911,6 +911,8 @@ __SYSCALL(__NR_set_mempolicy_home_node,
 __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_futex_wake 452
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
+#define __NR_futex_wait 453
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
 
 /*
  * Please add new compat syscalls above this comment and update
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -373,3 +373,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -458,3 +458,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -391,3 +391,4 @@
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
 452	n32	futex_wake			sys_futex_wake
+453	n32	futex_wait			sys_futex_wait
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -367,3 +367,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
 452	n64	futex_wake			sys_futex_wake
+453	n64	futex_wait			sys_futex_wait
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -440,3 +440,4 @@
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
 452	o32	futex_wake			sys_futex_wake
+453	o32	futex_wait			sys_futex_wait
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -539,3 +539,4 @@
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	futex_wake		sys_futex_wake			sys_futex_wake
+453  common	futex_wait		sys_futex_wait			sys_futex_wait
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -498,3 +498,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,4 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	futex_wake		sys_futex_wake
+453	i386	futex_wait		sys_futex_wait
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -374,6 +374,7 @@
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
 452	common	futex_wake		sys_futex_wake
+453	common	futex_wait		sys_futex_wait
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -423,3 +423,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
+453	common	futex_wait			sys_futex_wait
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -566,6 +566,10 @@ asmlinkage long sys_futex_waitv(struct f
 
 asmlinkage long sys_futex_wake(void __user *uaddr, unsigned long mask, int nr, unsigned int flags);
 
+asmlinkage long sys_futex_wait(void __user *uaddr, unsigned long val, unsigned long mask,
+			       unsigned int flags, struct __kernel_timespec __user *timespec,
+			       clockid_t clockid);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -820,9 +820,11 @@ __SYSCALL(__NR_set_mempolicy_home_node,
 __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_futex_wake 452
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
+#define __NR_futex_wait 453
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
 
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 454
 
 /*
  * 32 bit systems traditionally used different
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -331,6 +331,9 @@ extern int futex_requeue(u32 __user *uad
 			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
 			 u32 *cmpval, int requeue_pi);
 
+extern int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
+			struct hrtimer_sleeper *to, u32 bitset);
+
 extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset);
 
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
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
 	return futex_wake(uaddr, flags, nr, mask);
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
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -629,20 +629,18 @@ int futex_wait_setup(u32 __user *uaddr,
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
@@ -650,18 +648,17 @@ int futex_wait(u32 __user *uaddr, unsign
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
@@ -670,24 +667,38 @@ int futex_wait(u32 __user *uaddr, unsign
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
 
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -88,6 +88,7 @@ COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
 COND_SYSCALL(futex_wake);
+COND_SYSCALL(futex_wait);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);


