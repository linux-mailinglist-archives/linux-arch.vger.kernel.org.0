Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8D813D0E5
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 01:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbgAPAJx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 19:09:53 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39148 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729186AbgAPAJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 19:09:53 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6D728C0525;
        Thu, 16 Jan 2020 00:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579133391; bh=wGe7qKxUwSLqkYniadVYIK/uchv8SHM51LLFaYp1I6A=;
        h=From:To:Cc:Subject:Date:From;
        b=V9LY1ZT/7QJRkwbuI7X3qOU9aauI0DaSZp6F1mFP9qOU4400k/fCZxOxuCde/Japw
         tt7TrJOxHZCCr3wHrvwPh3pG7ePhfpAMdi6ArDTN9/pEqR0uBMrVpF1k9HEFnz5ndJ
         HU3D/g3r2bw8N9DGLrH+Bt61aTCLb6+t22w5utPT8OUhl115pjYfJ0hGLkFTrygMjS
         aPEc1vCRbdpTPiSGFj0x2fN76p6zkSD5gWvVizUKTjBUgAeZFd663EdECQTxQt+XEf
         DMAhmWS2iYzdXwFYF72qn4nyDGHX/T8NtzSGfJbpUjtamvsRG+R37MNZ1YSU67FIbM
         TNs4drFWmYCww==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.20])
        by mailhost.synopsys.com (Postfix) with ESMTP id B8647A00C2;
        Thu, 16 Jan 2020 00:09:49 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Christian Brauner <christian@brauner.io>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] ARC: wireup clone3 syscall
Date:   Wed, 15 Jan 2020 16:09:48 -0800
Message-Id: <20200116000948.17646-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig                   |  1 +
 arch/arc/include/asm/syscalls.h    |  1 +
 arch/arc/include/uapi/asm/unistd.h |  1 +
 arch/arc/kernel/entry.S            | 12 ++++++++++++
 arch/arc/kernel/process.c          |  7 +++----
 arch/arc/kernel/sys.c              |  1 +
 6 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 26108ea785c2..c4409eab07a9 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -28,6 +28,7 @@ config ARC
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_FUTEX_CMPXCHG if FUTEX
diff --git a/arch/arc/include/asm/syscalls.h b/arch/arc/include/asm/syscalls.h
index 7ddba13e9b59..c3f4714a4f5c 100644
--- a/arch/arc/include/asm/syscalls.h
+++ b/arch/arc/include/asm/syscalls.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 
 int sys_clone_wrapper(int, int, int, int, int);
+int sys_clone3_wrapper(void *, size_t);
 int sys_cacheflush(uint32_t, uint32_t uint32_t);
 int sys_arc_settls(void *);
 int sys_arc_gettls(void);
diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
index 5eafa1115162..fa2713ae6bea 100644
--- a/arch/arc/include/uapi/asm/unistd.h
+++ b/arch/arc/include/uapi/asm/unistd.h
@@ -21,6 +21,7 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_TIME32_SYSCALLS
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 72be01270e24..7e5109dab4e8 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -35,6 +35,18 @@ ENTRY(sys_clone_wrapper)
 	b .Lret_from_system_call
 END(sys_clone_wrapper)
 
+ENTRY(sys_clone3_wrapper)
+	SAVE_CALLEE_SAVED_USER
+	bl  @sys_clone3
+	DISCARD_CALLEE_SAVED_USER
+
+	GET_CURR_THR_INFO_FLAGS   r10
+	btst r10, TIF_SYSCALL_TRACE
+	bnz  tracesys_exit
+
+	b .Lret_from_system_call
+END(sys_clone3_wrapper)
+
 ENTRY(ret_from_fork)
 	; when the forked child comes here from the __switch_to function
 	; r0 has the last task pointer.
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index e1889ce3faf9..bfd4cbe74aa3 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -171,9 +171,8 @@ asmlinkage void ret_from_fork(void);
  * |    user_r25    |
  * ------------------  <===== END of PAGE
  */
-int copy_thread(unsigned long clone_flags,
-		unsigned long usp, unsigned long kthread_arg,
-		struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+	unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
 {
 	struct pt_regs *c_regs;        /* child's pt_regs */
 	unsigned long *childksp;       /* to unwind out of __switch_to() */
@@ -231,7 +230,7 @@ int copy_thread(unsigned long clone_flags,
 		 * set task's userland tls data ptr from 4th arg
 		 * clone C-lib call is difft from clone sys-call
 		 */
-		task_thread_info(p)->thr_ptr = regs->r3;
+		task_thread_info(p)->thr_ptr = tls;
 	} else {
 		/* Normal fork case: set parent's TLS ptr in child */
 		task_thread_info(p)->thr_ptr =
diff --git a/arch/arc/kernel/sys.c b/arch/arc/kernel/sys.c
index fddecc76efb7..1069446bdc58 100644
--- a/arch/arc/kernel/sys.c
+++ b/arch/arc/kernel/sys.c
@@ -7,6 +7,7 @@
 #include <asm/syscalls.h>
 
 #define sys_clone	sys_clone_wrapper
+#define sys_clone3	sys_clone3_wrapper
 
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
-- 
2.20.1

