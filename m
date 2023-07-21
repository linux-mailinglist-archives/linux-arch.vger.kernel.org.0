Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7369175C551
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGULBP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGUK7q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B230E3;
        Fri, 21 Jul 2023 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Ig3IvWIPDNo35V2b21H7Fs7QX8J2CTYfRUu1uDDpQU0=; b=OTY0sIeG/A30Uddn/mZpQmAVr+
        nHBklxGbArWRT9fKn3CEpycGefV3tU2tdMr2tgP3rGgR52soiFLjwm9UMmCMu0dQo1rEftQ606kAK
        FRY5ZJkq0mqFDSVor7h4dM3unSe87zDPSvy5SL2kYSTZtCGOmyIfKrjAYsy7hUYK8RWw+xCOgIzGq
        tCeIwUswoQ6vsd7/W+9qyLrPDYpoRg4Q7aohFOR9hDpOY6/dDXTrGqBaKZ5ZAKN/yAUC93w68LKzq
        7OHgvMn/RmbE3U15Q0tPRi8px7I3kod3wcAXglpM+K9n4+o+jUbI8sR+C/sSOnick6eVF3RqS/HBa
        nw5uykJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMnqK-0000L7-1l;
        Fri, 21 Jul 2023 10:58:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DA76300C1D;
        Fri, 21 Jul 2023 12:58:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 18AD53157E622; Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Message-ID: <20230721105744.298661259@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 09/14] futex: Add sys_futex_requeue()
References: <20230721102237.268073801@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Finish of the 'simple' futex2 syscall group by adding
sys_futex_requeue(). Unlike sys_futex_{wait,wake}() it's arguments are
too numerous to fit into a regular syscall. As such, use struct
futex_waitv to pass the 'source' and 'destination' futexes to the
syscall.

This syscall implements what was previously known as FUTEX_CMP_REQUEUE
and uses {val, uaddr, flags} for source and {uaddr, flags} for
destination.

This design explicitly allows requeueing between different types of
futex by having a different flags word per uaddr.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
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
 21 files changed, 63 insertions(+), 1 deletion(-)

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


