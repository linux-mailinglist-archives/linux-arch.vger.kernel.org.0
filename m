Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D82772445
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjHGMh2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjHGMhV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F239110F3;
        Mon,  7 Aug 2023 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=e0ODiErkiAW6GZEr+QWyQaocRNB5DYuNqCHK8u2llMY=; b=WsiTil+cp9p9DlcqmRAr0x3S3V
        JnAuedsnn3FQ2guRfve4/1h7VbOAMNu9jEcjXnC1yU3KcSUEPnkCS5lQxwf9Tg/izo/NuwcjkDwxS
        wrRzof95u3tqna3Mx86ezjdGyx6Af0iTHczZR1lV7GmwnE0zpiqxtB2FOLFcyzxHAv1gLC5ZTxIRB
        BaYW/z1bWWOyMGePPfiMBtzg9G/xaCgMVQ4Cgp8Eb7nQoaA8gcJP4cLnojosKq4NfsLuN8zVpIu9B
        /W6S7fNKBXiwiIGZovqxWCFaIZjxYZNZJ39sUbq3p4bZ88ttFaHL7mI5zGGvv2U3Xl+YP4vjrCQ+M
        USoTyOhw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSzTl-003oSn-1l;
        Mon, 07 Aug 2023 12:36:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 287E73033AE;
        Mon,  7 Aug 2023 14:36:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9EA5E2021C3D8; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123323.090897260@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH  v2 05/14] futex: Add sys_futex_wake()
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

To complement sys_futex_waitv() add sys_futex_wake(). This syscall
implements what was previously known as FUTEX_WAKE_BITSET except it
uses 'unsigned long' for the bitmask and takes FUTEX2 flags.

The 'unsigned long' allows FUTEX2_SIZE_U64 on 64bit platforms.

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
 include/uapi/asm-generic/unistd.h           |    5 ++--
 kernel/futex/syscalls.c                     |   30 ++++++++++++++++++++++++++++
 kernel/sys_ni.c                             |    1 
 22 files changed, 56 insertions(+), 3 deletions(-)

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
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		452
+#define __NR_compat_syscalls		453
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
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
+	if (flags & ~FUTEX2_VALID_MASK)
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


