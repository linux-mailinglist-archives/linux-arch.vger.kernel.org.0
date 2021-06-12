Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5473A5166
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jun 2021 01:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhFLXla (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 19:41:30 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:35565 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhFLXla (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 19:41:30 -0400
Received: by mail-pl1-f181.google.com with SMTP id x19so4671776pln.2
        for <linux-arch@vger.kernel.org>; Sat, 12 Jun 2021 16:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6DYIKrUXMcsL4MIVy/dc7Q9toGqp4qAGWl+gq54bqdk=;
        b=N53F1VinuVv0AWyAoc7M3J+1r59cTqMdDJ4f4JVqPQeMdsbm546Tpx6LTzuBd9/gTz
         L7HxF/MbrHGnrtAwIF/LL/FWQCxLEfRaf1X16VvkC/33S3oHeEtCRz3zgVejelgpmw26
         pduA5sUg8/2G7hRi5j/J0Zy+pPisYuhVPqfgZbSkkWJ7cMCvZ8ShqWxFTmMHfUrs1RbN
         o3ZwlAqMIIrRB8XQjLzIrtkX1bVuoK/xm4jhdLlN8r1euWxALcI/jwit0VauIIF/3wC2
         n9h/zs/A25hWBrMjPk9LFdDXIGNQPxCIoWtVXovWUvy11+e7nXMzNVe4P9o05kzezxp5
         5hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6DYIKrUXMcsL4MIVy/dc7Q9toGqp4qAGWl+gq54bqdk=;
        b=pt/rTx9/V50eoUhvo1QEu2qP3IrcXcMlbizp0uVkCN67IRW4ofu9goyIjdFeyJHZnw
         CDiUxfaw3RHN6ft/TxPbT5pGqdVHQE8JInKqLJ/GxXX7GfBTjBfuLy/fb6jJdOfZewcF
         g/8KDInxfzdVlQ7obX108KQMHFUnJMFLO77mHo8yAgndz92CuXRRR3dfNw//kC8iusGc
         N8mvAdLmomAstYeb4fos/flPuDK4gzKX+1Y1yZsHT+m+baprWW0PR0imPGfTspXTyiyG
         UeYiK6gfTyAlGmPCJRlAKRT0n4Yt/1UCQoCJKwZtaEA/Cumfqsdkn0L9nuJMnk8HYmNy
         3feA==
X-Gm-Message-State: AOAM531Jm2CleWfK2aNwMK3fAN5LHBcQZJrKpyXoCfOhXQ3OVFOSEZSV
        moJ0Yma4Vl405r9ImDSKgXs=
X-Google-Smtp-Source: ABdhPJwU4fpMmMl7S0gj2YqbLjrsWqvDhDcG/GGfh6anjev0C45OjP7b3hwW0Kpk2L8MmhLfZcGNmg==
X-Received: by 2002:a17:90a:17c8:: with SMTP id q66mr16070296pja.154.1623541103926;
        Sat, 12 Jun 2021 16:38:23 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id j9sm7876809pjy.25.2021.06.12.16.38.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jun 2021 16:38:23 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id CE17736040F; Sun, 13 Jun 2021 11:38:19 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v1] m68k: save extra registers on sys_exit and sys_exit_group syscall entry
Date:   Sun, 13 Jun 2021 11:38:18 +1200
Message-Id: <1623541098-6532-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <87sg1p30a1.fsf@disp2133>
References: <87sg1p30a1.fsf@disp2133>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

do_exit() calls prace_stop() which may require access to all saved
registers. We only save those registers not preserved by C code
currently.

Provide a special syscall entry for exit and exit_group syscalls
similar to that used by clone and clone3, which have the same
requirements.

No fix to io_uring appears to be needed, because m68k copy_thread
treats kernel threads the same as e.g. alpha does, and copies only
a subset of registers in that case.

CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/kernel/entry.S              | 14 ++++++++++++++
 arch/m68k/kernel/process.c            | 16 ++++++++++++++++
 arch/m68k/kernel/syscalls/syscall.tbl |  4 ++--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 9dd76fb..1e067e6 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -76,6 +76,20 @@ ENTRY(__sys_clone3)
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
 ENTRY(sys_sigreturn)
 	SAVE_SWITCH_STACK
 	movel	%sp,%sp@-		  | switch_stack pointer
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index da83cc8..df4e5f1 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -138,6 +138,22 @@ asmlinkage int m68k_clone3(struct pt_regs *regs)
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
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 		struct task_struct *p, unsigned long tls)
 {
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 0dd019d..3d5b6fbc 100644
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
@@ -254,7 +254,7 @@
 244	common	io_submit			sys_io_submit
 245	common	io_cancel			sys_io_cancel
 246	common	fadvise64			sys_fadvise64
-247	common	exit_group			sys_exit_group
+247	common	exit_group			__sys_exit_group
 248	common	lookup_dcookie			sys_lookup_dcookie
 249	common	epoll_create			sys_epoll_create
 250	common	epoll_ctl			sys_epoll_ctl
-- 
2.7.4

