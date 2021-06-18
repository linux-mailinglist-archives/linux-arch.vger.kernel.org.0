Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45EF3AC089
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhFRB3h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 21:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbhFRB3g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jun 2021 21:29:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5923CC061574
        for <linux-arch@vger.kernel.org>; Thu, 17 Jun 2021 18:27:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q25so6410734pfh.7
        for <linux-arch@vger.kernel.org>; Thu, 17 Jun 2021 18:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XSTHhCaBsJt3mNAtVlBQxPXwkNlyk/T9G5vdaaRvwQA=;
        b=Yuxmy9lvIOTJ+DSak2qwgkVm2cPHcAsH8oCCLJBjReVBYq+tLDFFjOazOAHo8xdInx
         ZZj86VDMPeuaeg2Xv3jcGxSFLk+OcmSEOP44/85iBODr6UOczwS4gmFLta5MX9WDdaeS
         qfQySiMNHaX0mVl1tNvu4tmV2IDQdzEX3Zt3UfKZ7Ps8ZbkNjw9DCHGmLtmo4uSSJF8M
         ZyateXt2HzgjrDcHiuKzcIWHcgG/splJHd8SqmhnSzAL1iXNlBtzvjtqdyaJ94dXBMHO
         bWwb9OT6Hogb1SYhrdVMYXsp0JqVvmhkRHvQHPJ8ilalpZ6RKUq709zBw60JhO8i3PfF
         VuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XSTHhCaBsJt3mNAtVlBQxPXwkNlyk/T9G5vdaaRvwQA=;
        b=gCfOi+lucPNKOPjCeIhbKkhUcib2kyL5+lsMcD6X8l/RrS/lrHMj97c7uKMuenebnF
         GPcYPxp7ypZI+EaFE4TCMEjByoFtxOezEtvmzfH44WJewJP8NWnQC9pUIXbnmNTKyZCX
         iiGrkFQheTiPOKTaoVbLuqEfkg7yRpNVt/29ZihPmff5z+uWBe6pudzVYHRWUT4tBtSY
         qe0zDGXXp2stHNLW5LkGO+4Alpql3K/9K4TGQYK2A6XXfPOuHFkyn3fFuFyszUHX4vWf
         egqVklLCg4rx8w4pHNGZ5+Ni3VUbtgGVuD2F+FVsHm5r3jqJBRGoApf9LBMas9BlgK7o
         5CcA==
X-Gm-Message-State: AOAM532u1G5hBBAsB883eqO94793d3WWVM4YZ1nX3XFaUujyfUBSfLWJ
        g1lG4F3fnvBy7bfychxW06dYVgrKNpl7sQ==
X-Google-Smtp-Source: ABdhPJw0SxEC/W/anhO8amMuGDuGZo9MCJArdet+AS6JgCUoX35MrG5NieCe9gByeVkwlm3LHdko+w==
X-Received: by 2002:a05:6a00:238e:b029:2ef:839b:adc7 with SMTP id f14-20020a056a00238eb02902ef839badc7mr2576582pfc.54.1623979647914;
        Thu, 17 Jun 2021 18:27:27 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id w71sm6091512pfc.164.2021.06.17.18.27.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 18:27:27 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id F120C3603D8; Fri, 18 Jun 2021 13:27:23 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v2] m68k: save extra registers on more syscall entry points
Date:   Fri, 18 Jun 2021 13:27:22 +1200
Message-Id: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Multiple syscalls are liable to PTRACE_EVENT_* tracing and thus
require full user context saved on the kernel stack. We only
save those registers not preserved by C code currently.

do_exit() calls ptrace_stop() which may require access to all
saved registers. Add code to save additional registers in the
switch_stack struct for exit and exit_group syscalls (similar
to what is already done for fork, vfork and clone3). According
to Eric's analysis, execve and execveat can be traced as well,
so have been given the same treatment.

I'm not sure what to do about io_uring_setup - added code to
save full context on entry, and some more code to save/restore
additional registers on the switch stack around the kworker thread
call in ret_from_kernel_thread, but this may well be redundant.

I'd need specific test cases to exercise io_uring_setup in
particular, to see whether stack offsets for pt_regs and the
switch stack have been messed up.

Boot tested on ARAnym - earlier version including io_uring entry
save also tested on real hardware unter heavy IO load.

CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

--
Changes from v1:

- added exec, execve and io_uring_setup syscalls
- save extra registers around kworker thread calls
---
 arch/m68k/kernel/entry.S              | 41 ++++++++++++++++++++++++++++++++++-
 arch/m68k/kernel/process.c            | 39 +++++++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscall.tbl | 10 ++++-----
 3 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 9dd76fb..02bf2a1 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -76,6 +76,41 @@ ENTRY(__sys_clone3)
 	lea	%sp@(28),%sp
 	rts
 
+ENTRY(__sys_exit)
+	SAVE_SWITCH_STACK
+	pea	%sp@(SWITCH_STACK_SIZE)
+	jbsr	m68k_exit
+	lea	%sp@(28),%sp
+	rts
+
+ENTRY(__sys_exit_group)
+	SAVE_SWITCH_STACK
+	pea	%sp@(SWITCH_STACK_SIZE)
+	jbsr	m68k_exit_group
+	lea	%sp@(28),%sp
+	rts
+
+ENTRY(__sys_execve)
+	SAVE_SWITCH_STACK
+	pea	%sp@(SWITCH_STACK_SIZE)
+	jbsr	m68k_execve
+	lea	%sp@(28),%sp
+	rts
+
+ENTRY(__sys_execveat)
+	SAVE_SWITCH_STACK
+	pea	%sp@(SWITCH_STACK_SIZE)
+	jbsr	m68k_execveat
+	lea	%sp@(28),%sp
+	rts
+
+ENTRY(__sys_io_uring_setup)
+	SAVE_SWITCH_STACK
+	pea	%sp@(SWITCH_STACK_SIZE)
+	jbsr	m68k_io_uring_setup
+	lea	%sp@(28),%sp
+	rts
+
 ENTRY(sys_sigreturn)
 	SAVE_SWITCH_STACK
 	movel	%sp,%sp@-		  | switch_stack pointer
@@ -123,9 +158,13 @@ ENTRY(ret_from_kernel_thread)
 	| a3 contains the kernel thread payload, d7 - its argument
 	movel	%d1,%sp@-
 	jsr	schedule_tail
-	movel	%d7,(%sp)
+	addql	#4,%sp
+	| kernel threads can be traced!
+	SAVE_SWITCH_STACK
+	movel	%d7,%sp@-
 	jsr	%a3@
 	addql	#4,%sp
+	RESTORE_SWITCH_STACK
 	jra	ret_from_exception
 
 #if defined(CONFIG_COLDFIRE) || !defined(CONFIG_MMU)
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index da83cc8..298ac99 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -138,6 +138,45 @@ asmlinkage int m68k_clone3(struct pt_regs *regs)
 	return sys_clone3((struct clone_args __user *)regs->d1, regs->d2);
 }
 
+/*
+ * Because extra registers are saved on the stack after the sys_exit()
+ * arguments, this C wrapper extracts them from pt_regs * and then calls the
+ * generic sys_exit() implementation.
+ */
+asmlinkage int m68k_exit(struct pt_regs *regs)
+{
+	return sys_exit(regs->d1);
+}
+
+/* Same for sys_exit_group ... */
+asmlinkage int m68k_exit_group(struct pt_regs *regs)
+{
+	return sys_exit_group(regs->d1);
+}
+
+/* Same for sys_exit_group ... */
+asmlinkage int m68k_execve(struct pt_regs *regs)
+{
+	return sys_execve((const char __user *)regs->d1,
+			(const char __user *const __user*)regs->d2,
+			(const char __user *const __user*)regs->d3);
+}
+
+/* Same for sys_exit_group ... */
+asmlinkage int m68k_execveat(struct pt_regs *regs)
+{
+	return sys_execveat(regs->d1, (const char __user *)regs->d2,
+			(const char __user *const __user*)regs->d3,
+			(const char __user *const __user*)regs->d4,
+			regs->d5);
+}
+
+/* and for sys_io_uring_create */
+asmlinkage int m68k_io_uring_setup(struct pt_regs *regs)
+{
+	return sys_io_uring_setup(regs->d1,(struct io_uring_params __user *)regs->d2);
+}
+
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 		struct task_struct *p, unsigned long tls)
 {
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 0dd019d..4a1ba1d 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -8,7 +8,7 @@
 # The <abi> is always "common" for this file
 #
 0	common	restart_syscall			sys_restart_syscall
-1	common	exit				sys_exit
+1	common	exit				__sys_exit
 2	common	fork				__sys_fork
 3	common	read				sys_read
 4	common	write				sys_write
@@ -18,7 +18,7 @@
 8	common	creat				sys_creat
 9	common	link				sys_link
 10	common	unlink				sys_unlink
-11	common	execve				sys_execve
+11	common	execve				__sys_execve
 12	common	chdir				sys_chdir
 13	common	time				sys_time32
 14	common	mknod				sys_mknod
@@ -254,7 +254,7 @@
 244	common	io_submit			sys_io_submit
 245	common	io_cancel			sys_io_cancel
 246	common	fadvise64			sys_fadvise64
-247	common	exit_group			sys_exit_group
+247	common	exit_group			__sys_exit_group
 248	common	lookup_dcookie			sys_lookup_dcookie
 249	common	epoll_create			sys_epoll_create
 250	common	epoll_ctl			sys_epoll_ctl
@@ -362,7 +362,7 @@
 352	common	getrandom			sys_getrandom
 353	common	memfd_create			sys_memfd_create
 354	common	bpf				sys_bpf
-355	common	execveat			sys_execveat
+355	common	execveat			__sys_execveat
 356	common	socket				sys_socket
 357	common	socketpair			sys_socketpair
 358	common	bind				sys_bind
@@ -424,7 +424,7 @@
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
 424	common	pidfd_send_signal		sys_pidfd_send_signal
-425	common	io_uring_setup			sys_io_uring_setup
+425	common	io_uring_setup			__sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
 428	common	open_tree			sys_open_tree
-- 
2.7.4

