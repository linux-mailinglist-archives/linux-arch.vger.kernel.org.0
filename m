Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A69E7AA191
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 23:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjIUVDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjIUVDR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 17:03:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC80535AD;
        Thu, 21 Sep 2023 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2DTgjumfpm1XkZ715bEL5OW+Lzt/Am5TA3vJOTBLXZU=; b=XtAFaLhmRfTSIAepdy7Z15s9Wy
        b1BqY+tCKhG7iyZKLYYRNBZJwy94StzYUTqTRb4lHlI1R2dX7EN+UPkoJULC5vToF96NtZbh7DJNr
        pTY0V1ZnfaiE7UbbbZJByPuN2HXlor7S6wiQ/LCk7IplNknLy93ZOB92k8zpLDFoFIiUeIsaRFSe0
        +XpYMy8qnNT2sPEYPDdBo65fv2TLQ/McFO5r8jj1XGaBf5mkd6OJSbAm2arUAPFUaGHhGx0kK0UNg
        //TgiNaI26sQrDaKAHt9H9bCJt3yGOC9sNcWBcNm0DUfZlETWKVXDYWK3X05N72GmLWsjWXc9s9d4
        Cfr8LB7Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjHQO-00BTok-R7; Thu, 21 Sep 2023 11:00:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id E749B300585; Thu, 21 Sep 2023 13:00:42 +0200 (CEST)
Message-Id: <20230921105247.936205525@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:10 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 05/15] futex: Add sys_futex_wake()
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-wake.patch
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 include/uapi/asm-generic/unistd.h           |    5 ++--
 kernel/futex/syscalls.c                     |   33 ++++++++++++++++++++++++++++
 kernel/sys_ni.c                             |    1 
 22 files changed, 59 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/alpha/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/alpha/kernel/syscalls/syscall.tbl
@@ -492,3 +492,4 @@
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
+563	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/arm/tools/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/arm/tools/syscall.tbl
+++ linux-2.6/arch/arm/tools/syscall.tbl
@@ -466,3 +466,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/arm64/include/asm/unistd.h
===================================================================
--- linux-2.6.orig/arch/arm64/include/asm/unistd.h
+++ linux-2.6/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		453
+#define __NR_compat_syscalls		455
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
Index: linux-2.6/arch/arm64/include/asm/unistd32.h
===================================================================
--- linux-2.6.orig/arch/arm64/include/asm/unistd32.h
+++ linux-2.6/arch/arm64/include/asm/unistd32.h
@@ -911,6 +911,8 @@ __SYSCALL(__NR_set_mempolicy_home_node,
 __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_futex_wake 454
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
 
 /*
  * Please add new compat syscalls above this comment and update
Index: linux-2.6/arch/ia64/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/ia64/kernel/syscalls/syscall.tbl
@@ -373,3 +373,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/m68k/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/m68k/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/microblaze/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/microblaze/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -458,3 +458,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_n32.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -391,3 +391,4 @@
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
 452	n32	fchmodat2			sys_fchmodat2
+454	n32	futex_wake			sys_futex_wake
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_n64.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -367,3 +367,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
 452	n64	fchmodat2			sys_fchmodat2
+454	n64	futex_wake			sys_futex_wake
Index: linux-2.6/arch/mips/kernel/syscalls/syscall_o32.tbl
===================================================================
--- linux-2.6.orig/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ linux-2.6/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -440,3 +440,4 @@
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
 452	o32	fchmodat2			sys_fchmodat2
+454	o32	futex_wake			sys_futex_wake
Index: linux-2.6/arch/parisc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/parisc/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/powerpc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -539,3 +539,4 @@
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/s390/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/s390/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/s390/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
+454  common	futex_wake		sys_futex_wake			sys_futex_wake
Index: linux-2.6/arch/sh/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/sh/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/sh/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/sparc/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/sparc/kernel/syscalls/syscall.tbl
@@ -498,3 +498,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/arch/x86/entry/syscalls/syscall_32.tbl
===================================================================
--- linux-2.6.orig/arch/x86/entry/syscalls/syscall_32.tbl
+++ linux-2.6/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,4 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+454	i386	futex_wake		sys_futex_wake
Index: linux-2.6/arch/x86/entry/syscalls/syscall_64.tbl
===================================================================
--- linux-2.6.orig/arch/x86/entry/syscalls/syscall_64.tbl
+++ linux-2.6/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,7 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	futex_wake		sys_futex_wake
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
Index: linux-2.6/arch/xtensa/kernel/syscalls/syscall.tbl
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/syscalls/syscall.tbl
+++ linux-2.6/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -423,3 +423,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
Index: linux-2.6/include/linux/syscalls.h
===================================================================
--- linux-2.6.orig/include/linux/syscalls.h
+++ linux-2.6/include/linux/syscalls.h
@@ -549,6 +549,9 @@ asmlinkage long sys_set_robust_list(stru
 asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
 				unsigned int nr_futexes, unsigned int flags,
 				struct __kernel_timespec __user *timeout, clockid_t clockid);
+
+asmlinkage long sys_futex_wake(void __user *uaddr, unsigned long mask, int nr, unsigned int flags);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
Index: linux-2.6/include/uapi/asm-generic/unistd.h
===================================================================
--- linux-2.6.orig/include/uapi/asm-generic/unistd.h
+++ linux-2.6/include/uapi/asm-generic/unistd.h
@@ -822,9 +822,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_futex_wake 454
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
 
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
Index: linux-2.6/kernel/futex/syscalls.c
===================================================================
--- linux-2.6.orig/kernel/futex/syscalls.c
+++ linux-2.6/kernel/futex/syscalls.c
@@ -306,6 +306,36 @@ destroy_timer:
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
Index: linux-2.6/kernel/sys_ni.c
===================================================================
--- linux-2.6.orig/kernel/sys_ni.c
+++ linux-2.6/kernel/sys_ni.c
@@ -87,6 +87,7 @@ COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
+COND_SYSCALL(futex_wake);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);


