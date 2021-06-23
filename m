Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825E03B1109
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 02:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFWAYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWAX7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 20:23:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2FC06175F
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 17:21:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso221431pjp.5
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 17:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lhUb3jZlTu6gAKs2wWK6rpO2+cL4RD1k7Iga+zzzTUo=;
        b=tsnKcRSEG9TrqOQfJIcacGBvEPL5iHqxVMwXukRX/Myf76ofMMdcainEZnLoP62L4m
         LzfdeES96jv23JtzvOEv7JffBslWj7AGKpKAG86rptpLuq1xEbXoTibvRvMKnUO/KRlr
         IOUp6G9BXphvEU+j5it41Gj2ob4+uz0puaituXgBBYiLpJ56Jdh1NArpv9bEncWnXg7Y
         I8vz3JIk9d4K0o7MFJjLgMr9q0jPn4LOblrGGswEqrvmXCiRjv4/cB3+o1cGTb38L4bj
         /UsgelS0bRz6ViQxYgYhOAgM0RN3fTPZn4Xr3v/FYjThqCxrZ+3prmqr1ga5Wox30Boc
         z8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lhUb3jZlTu6gAKs2wWK6rpO2+cL4RD1k7Iga+zzzTUo=;
        b=AA5LGZ4RSbh+QM1edreDpqlVjSVm6R43bkN0rFwjixi0JCf0JMYbGseOUWRDhx04Cr
         PsLAsoba1XAeLz34nqkL/oHU2IyMJ8QZTaml4PFP6qUO3O/CQ2+VsY/apOzrqKgSoJYK
         MQLeIEfv/wxkYya6qf8s9ZqhSjbS1BklMGFPDjmfjZPVM9gkmgnc3bGJ/tPXdy5weRS5
         yYDKtHyq5mVD18GxBmqcpBlFtnEJi5gZykZZ4peGfcsfE6X2jGw3shV3qlbdmw6Zhydx
         8SAPKiYHCp6ak69VLt2KIg3bn771P+fGx0m2XX0VC2HGIQIwqn3h4+U76ayTnySi+mHf
         ekNg==
X-Gm-Message-State: AOAM5302xLHvQXPXaIvwZupDXQjOEmm5qyOezRU2QSPhMVKB+9sFpsFQ
        4Pbz24taXHIJ11Ph7J6U6aQ=
X-Google-Smtp-Source: ABdhPJzW9vTGoemKFhpiq3MVZPxDtWu6V1USOoiv4sVrcJ7Xx/KuFD1NcLxkul+TfAxpJgWku7W1KQ==
X-Received: by 2002:a17:90a:6ba3:: with SMTP id w32mr6802383pjj.33.1624407703255;
        Tue, 22 Jun 2021 17:21:43 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id m16sm376265pfk.192.2021.06.22.17.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 17:21:42 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 5FBD73603D9; Wed, 23 Jun 2021 12:21:39 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v4 1/3] m68k: save extra registers on more syscall entry points
Date:   Wed, 23 Jun 2021 12:21:34 +1200
Message-Id: <1624407696-20180-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
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

Tested on both ARAnyM and Falcon hardware.

CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

--
Changes from v2:
- drop handling of io_uring_setup syscall

Changes from v1:

- added exec, execve and io_uring_setup syscalls
- save extra registers around kworker thread calls

drop io_uring_setup handling
---
 arch/m68k/kernel/entry.S              | 28 ++++++++++++++++++++++++++++
 arch/m68k/kernel/process.c            | 33 +++++++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscall.tbl |  8 ++++----
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 9dd76fb..275452a 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -76,6 +76,34 @@ ENTRY(__sys_clone3)
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
 ENTRY(sys_sigreturn)
 	SAVE_SWITCH_STACK
 	movel	%sp,%sp@-		  | switch_stack pointer
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index da83cc8..6f2f2ab 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -138,6 +138,39 @@ asmlinkage int m68k_clone3(struct pt_regs *regs)
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
+			(const char __user *const __user *)regs->d2,
+			(const char __user *const __user *)regs->d3);
+}
+
+/* Same for sys_exit_group ... */
+asmlinkage int m68k_execveat(struct pt_regs *regs)
+{
+	return sys_execveat(regs->d1, (const char __user *)regs->d2,
+			(const char __user *const __user *)regs->d3,
+			(const char __user *const __user *)regs->d4,
+			regs->d5);
+}
+
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 		struct task_struct *p, unsigned long tls)
 {
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 0dd019d..13dd02e 100644
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
-- 
2.7.4

