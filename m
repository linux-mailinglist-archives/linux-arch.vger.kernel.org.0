Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD8772446
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjHGMh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjHGMhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14118170B;
        Mon,  7 Aug 2023 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Xi18wbHB7VNHKYqwwPbXtDuzrsECrr9c5XSVyiI+TAw=; b=KqO2kuHfKLrv5u2OY576yuyqTS
        MpbOyrVFRvo7ba296aw60KiAk4fzQqtj8P72vWN0T9Hc1gT0+aqIWFhqLtPjy5vx0RzYrpumAIOG/
        Aek+ye7WtBQr+4HWa5BCSjSCLXADV6kA8mvRfog3zxySGaAosFLdQH4qVcVj/HMrnrwcm+msHG8EC
        SbcijN7kTPA+UjQ9oTgsiSnlToZ4gjGygc+kq3ct6wQXAoIbErA5zu4gYUNuHSB7VDf7yhdnBnpOd
        yBQagzYNZhTMX0CGgF0nOZVyjZajZX9sDU6NaMQtsXEEShakqKKrGTlx5US3CXnxVos3p5Kx7zVd9
        0aOFqbDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qSzTl-00AxGN-Ho; Mon, 07 Aug 2023 12:36:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 287AA30334C;
        Mon,  7 Aug 2023 14:36:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B074B2021C3DC; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123323.366498604@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH  v2 09/14] futex: Add sys_futex_requeue()
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

Finish of the 'simple' futex2 syscall group by adding
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

--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -493,3 +493,4 @@
 561	common	cachestat			sys_cachestat
 562	common	futex_wake			sys_futex_wake
 563	common	futex_wait			sys_futex_wait
+564	common	futex_requeue			sys_futex_requeue
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -467,3 +467,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		454
+#define __NR_compat_syscalls		455
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -913,6 +913,8 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 #define __NR_futex_wait 453
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
+#define __NR_futex_requeue 454
+__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
 /*
  * Please add new compat syscalls above this comment and update
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -374,3 +374,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -392,3 +392,4 @@
 451	n32	cachestat			sys_cachestat
 452	n32	futex_wake			sys_futex_wake
 453	n32	futex_wait			sys_futex_wait
+454	n32	futex_requeue			sys_futex_requeue
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -368,3 +368,4 @@
 451	n64	cachestat			sys_cachestat
 452	n64	futex_wake			sys_futex_wake
 453	n64	futex_wait			sys_futex_wait
+454	n64	futex_requeue			sys_futex_requeue
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -441,3 +441,4 @@
 451	o32	cachestat			sys_cachestat
 452	o32	futex_wake			sys_futex_wake
 453	o32	futex_wait			sys_futex_wait
+454	o32	futex_requeue			sys_futex_requeue
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -540,3 +540,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	futex_wake		sys_futex_wake			sys_futex_wake
 453  common	futex_wait		sys_futex_wait			sys_futex_wait
+454  common	futex_requeue		sys_futex_requeue			sys_futex_requeue
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -499,3 +499,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -458,3 +458,4 @@
 451	i386	cachestat		sys_cachestat
 452	i386	futex_wake		sys_futex_wake
 453	i386	futex_wait		sys_futex_wait
+454	i386	futex_requeue		sys_futex_requeue
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,7 @@
 451	common	cachestat		sys_cachestat
 452	common	futex_wake		sys_futex_wake
 453	common	futex_wait		sys_futex_wait
+454	common	futex_requeue		sys_futex_requeue
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -424,3 +424,4 @@
 451	common	cachestat			sys_cachestat
 452	common	futex_wake			sys_futex_wake
 453	common	futex_wait			sys_futex_wait
+454	common	futex_requeue			sys_futex_requeue
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -570,6 +570,9 @@ asmlinkage long sys_futex_wait(void __us
 			       unsigned int flags, struct __kernel_timespec __user *timespec,
 			       clockid_t clockid);
 
+asmlinkage long sys_futex_requeue(struct futex_waitv __user *waiters,
+				  unsigned int flags, int nr_wake, int nr_requeue);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -822,9 +822,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 #define __NR_futex_wait 453
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
+#define __NR_futex_requeue 454
+__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
 #undef __NR_syscalls
-#define __NR_syscalls 454
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
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
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -89,6 +89,7 @@ COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
 COND_SYSCALL(futex_wake);
 COND_SYSCALL(futex_wait);
+COND_SYSCALL(futex_requeue);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);


