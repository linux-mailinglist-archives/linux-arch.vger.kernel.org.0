Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EB575C53C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGULAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjGUK7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0342735;
        Fri, 21 Jul 2023 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MbiyL9h+1k5eBqWcaS863zQjxcb9GdsKTgaiCBDYOPw=; b=lSsRZMc9T3tGB9Ieux+7hvkxfF
        Vnz5Lsvm2DYmHmKQq3w/c4FK8AjTU2Bn7kUeQQhdbWn3QC7/C19EOf9rMc1/nPR5qOXneVXZbRsq1
        An6V+XSLXnXUzrTm6QDiDdqrn7CA+eNyOilPo535fQwcD2Uqn8nAFnL0Jk58B4Rm2X2DaXC+KGlHy
        e+/4vpaEz7u1OpNNH/QRx5XJ3ZTNTHG7OgWZs30fD+Q9Db443cfgxgP8iWplL4EkKCrhxYRcZcqf7
        i2rJlSJHM/XGAFME3I/tS1FmavMMFlmDe/UQBu4NlDwPbDDB88QOQvq0znfdtwO856yNKhRC21CKZ
        rETTZ9zg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMnqK-0012Oc-7m; Fri, 21 Jul 2023 10:58:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DAD9300C24;
        Fri, 21 Jul 2023 12:58:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 064873157E61E; Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Message-ID: <20230721105744.022509272@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 05/14] futex: Add sys_futex_wake()
References: <20230721102237.268073801@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To complement sys_futex_waitv() add sys_futex_wake(). This syscall
implements what was previously known as FUTEX_WAKE_BITSET except it
uses 'unsigned long' for the bitmask and takes FUTEX2 flags.

The 'unsigned long' allows FUTEX2_64 on 64bit platforms.

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
 include/uapi/asm-generic/unistd.h           |    5 ++--
 kernel/futex/syscalls.c                     |   30 ++++++++++++++++++++++++++++
 kernel/sys_ni.c                             |    1 
 21 files changed, 55 insertions(+), 2 deletions(-)

--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -491,3 +491,4 @@
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
+562	common	futex_wake			sys_futex_wake
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -465,3 +465,4 @@
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -909,6 +909,8 @@ __SYSCALL(__NR_futex_waitv, sys_futex_wa
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
+#define __NR_futex_wake 452
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
 
 /*
  * Please add new compat syscalls above this comment and update
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -372,3 +372,4 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -457,3 +457,4 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -390,3 +390,4 @@
 449	n32	futex_waitv			sys_futex_waitv
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
+452	n32	futex_wake			sys_futex_wake
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -366,3 +366,4 @@
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
+452	n64	futex_wake			sys_futex_wake
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -439,3 +439,4 @@
 449	o32	futex_waitv			sys_futex_waitv
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
+452	o32	futex_wake			sys_futex_wake
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -450,3 +450,4 @@
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -538,3 +538,4 @@
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -454,3 +454,4 @@
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
+452  common	futex_wake		sys_futex_wake			sys_futex_wake
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -454,3 +454,4 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -497,3 +497,4 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -456,3 +456,4 @@
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
+452	i386	futex_wake		sys_futex_wake
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,7 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
+452	common	futex_wake		sys_futex_wake
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -422,3 +422,4 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	futex_wake			sys_futex_wake
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -563,6 +563,9 @@ asmlinkage long sys_set_robust_list(stru
 asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
 				unsigned int nr_futexes, unsigned int flags,
 				struct __kernel_timespec __user *timeout, clockid_t clockid);
+
+asmlinkage long sys_futex_wake(void __user *uaddr, unsigned long mask, int nr, unsigned int flags);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -816,12 +816,13 @@ __SYSCALL(__NR_process_mrelease, sys_pro
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
-
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
+#define __NR_futex_wake 452
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
 
 #undef __NR_syscalls
-#define __NR_syscalls 452
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -306,6 +306,36 @@ SYSCALL_DEFINE5(futex_waitv, struct fute
 	return ret;
 }
 
+/*
+ * sys_futex_wake - Wake a number of futexes
+ * @uaddr:	Address of the futex(es) to wake
+ * @mask:	bitmask
+ * @nr:		Number of the futexes to wake
+ * @flags:	FUTEX2 flags
+ *
+ * Identical to the traditional FUTEX_WAKE_BITSET op, except it is part of the
+ * futex2 family of calls.
+ */
+
+SYSCALL_DEFINE4(futex_wake,
+		void __user *, uaddr,
+		unsigned long, mask,
+		int, nr,
+		unsigned int, flags)
+{
+	if (flags & ~FUTEX2_MASK)
+		return -EINVAL;
+
+	flags = futex2_to_flags(flags);
+	if (!futex_flags_valid(flags))
+		return -EINVAL;
+
+	if (!futex_validate_input(flags, mask))
+		return -EINVAL;
+
+	return futex_wake(uaddr, flags, nr, mask);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -87,6 +87,7 @@ COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
+COND_SYSCALL(futex_wake);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);


