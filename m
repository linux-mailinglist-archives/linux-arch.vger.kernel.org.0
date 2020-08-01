Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02BC234F32
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHABOn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgHABOm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:42 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4380D21744;
        Sat,  1 Aug 2020 01:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244481;
        bh=Gt3T63qeSEbTGQW92bcmdwvx1A2o1wWaghakhMqZrYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AloPVAAL2dv/NMXJOz3X12Jag1rZwV7R5s2THJK7aoBOSU33/PfVQvIBz4DD/QkOT
         xxys6K5vMUBfSkd4YxTU3mNDGdAmW/G+5a/mB8z0HdpaBypClVsOKsbEiGOhlUM6Xk
         b/nJD6OMcXFSUtHCZO2qsnGaFkNWlqvWBSFdCUEk=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 02/13] csky: Add SECCOMP_FILTER supported
Date:   Sat,  1 Aug 2020 01:14:02 +0000
Message-Id: <1596244453-98575-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

secure_computing() is called first in syscall_trace_enter() so that
a system call will be aborted quickly without doing succeeding syscall
tracing if seccomp rules want to deny that system call.

TODO:
 - Update https://github.com/seccomp/libseccomp csky support

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                             | 14 ++++++++++++++
 arch/csky/include/asm/Kbuild                  |  1 +
 arch/csky/include/asm/thread_info.h           |  2 +-
 arch/csky/kernel/entry.S                      |  3 +++
 arch/csky/kernel/ptrace.c                     |  8 ++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 13 ++++++++++++-
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index bd31ab1..822362d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -38,6 +38,7 @@ config CSKY
 	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DYNAMIC_FTRACE
@@ -296,3 +297,16 @@ endmenu
 source "arch/csky/Kconfig.platforms"
 
 source "kernel/Kconfig.hz"
+
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 9337225..64876e59 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -4,5 +4,6 @@ generic-y += gpio.h
 generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += qrwlock.h
+generic-y += seccomp.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 8980e4e..68e7a12 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -85,6 +85,6 @@ static inline struct thread_info *current_thread_info(void)
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-				 _TIF_SYSCALL_TRACEPOINT)
+				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP)
 
 #endif	/* _ASM_CSKY_THREAD_INFO_H */
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index f138003..efd2e69 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -168,6 +168,8 @@ ENTRY(csky_systemcall)
 csky_syscall_trace:
 	mov	a0, sp                  /* sp = pt_regs pointer */
 	jbsr	syscall_trace_enter
+	cmpnei	a0, 0
+	bt	1f
 	/* Prepare args before do system call */
 	ldw	a0, (sp, LSAVE_A0)
 	ldw	a1, (sp, LSAVE_A1)
@@ -188,6 +190,7 @@ csky_syscall_trace:
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
+1:
 #ifdef CONFIG_DEBUG_RSEQ
 	mov	a0, sp
 	jbsr	rseq_syscall
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 944ca2f..0de10f7 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -320,16 +320,20 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-asmlinkage void syscall_trace_enter(struct pt_regs *regs)
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		if (tracehook_report_syscall_entry(regs))
-			syscall_set_nr(current, regs, -1);
+			return -1;
+
+	if (secure_computing() == -1)
+		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 
 	audit_syscall_entry(regs_syscallid(regs), regs->a0, regs->a1, regs->a2, regs->a3);
+	return 0;
 }
 
 asmlinkage void syscall_trace_exit(struct pt_regs *regs)
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 252140a..8d18a0d 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -116,6 +116,8 @@ struct seccomp_data {
 #  define __NR_seccomp 277
 # elif defined(__riscv)
 #  define __NR_seccomp 277
+# elif defined(__csky__)
+#  define __NR_seccomp 277
 # elif defined(__hppa__)
 #  define __NR_seccomp 338
 # elif defined(__powerpc__)
@@ -1603,6 +1605,14 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS	struct user_regs_struct
 # define SYSCALL_NUM	a7
 # define SYSCALL_RET	a0
+#elif defined(__csky__)
+# define ARCH_REGS	struct pt_regs
+#if defined(__CSKYABIV2__)
+# define SYSCALL_NUM	regs[3]
+#else
+# define SYSCALL_NUM	regs[9]
+#endif
+# define SYSCALL_RET	a0
 #elif defined(__hppa__)
 # define ARCH_REGS	struct user_regs_struct
 # define SYSCALL_NUM	gr[20]
@@ -1693,7 +1703,8 @@ void change_syscall(struct __test_metadata *_metadata,
 	EXPECT_EQ(0, ret) {}
 
 #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
-	defined(__s390__) || defined(__hppa__) || defined(__riscv)
+	defined(__s390__) || defined(__hppa__) || defined(__riscv) || \
+	defined(__csky__)
 	{
 		regs.SYSCALL_NUM = syscall;
 	}
-- 
2.7.4

