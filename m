Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932A725FD49
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgIGPk1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 11:40:27 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbgIGPim (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 11:38:42 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDQqe-1kMUkb2t1S-00AYvP; Mon, 07 Sep 2020 17:38:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] ARM: syscall: always store thread_info->syscall
Date:   Mon,  7 Sep 2020 17:36:45 +0200
Message-Id: <20200907153701.2981205-5-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200907153701.2981205-1-arnd@arndb.de>
References: <20200907153701.2981205-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uU+TecuTqu0R9F35nqN09r3ArM9MaO4zXOfC9fDMIDMEVEKC175
 eHZUfwQdTB/7fFkfB+W0xXhaL/XvLVtfh3ZII8xq2BsysD5q1nM3wenG7EjjevHA85Ih0AQ
 mlXzjl7IH/NziTpdbHjgoDEHpe7jzEJLgqK6PF4xOwmTCdV9zJyccr74NZVuFw3sxfvZd7S
 1XP2KfBS6lM4e4HWdXgDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z/SwDeuaCd0=:/46zD3F6r+k7KbKrKJm1ST
 V4MN6RGZ+H8tKnSPMQ+oAHnTre6MUpHwHidwDxZ7ty7CnjAPZxSZYfVivHg3KZFy7A/x5nMSE
 sXprY3IsstN25hPLLiGjkm2HlrJt0i67Dq/9Xa9T6FVkZRs0oMgjT8NW6Uh4Ddq4PO3Hmnr0p
 V1yS0OD8FAkDDJ2FmZIUTCDoQ6bq8vDbzTUV0x5MkULGCQRP8G2JowviiZIBEl14AtOX7moWs
 Yg0TrDqtfQzAcBZ9kKD1HOuailFV/WXNLQpfYBxCMHR7D3t/qWjlOy002kCPtCN2BP+KeQL07
 Jpr/dKZAKy+TRbTicE4OM/jNBu5qMlxQo6Il4OkBp/UqOH6qEBfggVcyXeyw0PgtGIXBFndA2
 xXNFHYa87PqLRbeE3tafQLd76jeYC9eB+s0+Zxk8dwPaYYDi2YO+vVzsZ2ZxZWIx8uMZu3LHJ
 jZqbY4rkdNYyuAe09LIQeDPHvXLn2refM0ZgHYHjSmvyQIpYPiaKNLeeCgEtVS03UZdtLfHtC
 hTAYWDucfXShXAR+cHKaE0M96whTL+Q14f22PHX0E8VVOIxoqrhwebvpc3MfZ2ovrYW0YGK+q
 TIjxM1ZdJMnbbWaXKJ8aEp+I8iumE+pV7jlMjAi3pkS62KvSO0TkAT27iW3rKBRFSFjmdD22B
 aRFUozwW4aXk+RsX6dxUObqOIQXGsNwpSnkSOoIDmqR0wiEOQBMzznBi5Rs+wpWVDeVPY82qN
 D/sPt8sRdQRhxegfrLVm3g2NzxwJh09lh3qXuFCI/SUKoJ4UkbI9bOBygLAbDzomJR1gZL4va
 Wc1hhmPUEokG2APXShmXD//MqjIAM9d5dcAYfSF77VJ/zvGS5FIC6NCQ75rzLAynBQaNqHs
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The system call number is used in a a couple of places, in particular
ptrace, seccomp and /proc/<pid>/syscall.

The last one apparently never worked reliably on ARM for tasks
that are not currently getting traced.

Storing the syscall number in the normal entry path makes it work,
as well as allowing us to see if the current system call is for
OABI compat mode, which is the next thing I want to hook into.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/syscall.h | 3 +++
 arch/arm/kernel/asm-offsets.c  | 1 +
 arch/arm/kernel/entry-common.S | 7 +++++--
 arch/arm/kernel/ptrace.c       | 4 ++--
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index fd02761ba06c..ff6cc365eaf7 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -22,6 +22,9 @@ extern const unsigned long sys_call_table[];
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
 {
+	if (IS_ENABLED(CONFIG_OABI_COMPAT))
+		return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;
+
 	return task_thread_info(task)->syscall;
 }
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index a1570c8bab25..97af6735172b 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -46,6 +46,7 @@ int main(void)
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
+  DEFINE(TI_SYSCALL,		offsetof(struct thread_info, syscall));
   DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 271cb8a1eba1..2ea3a1989fed 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -223,6 +223,7 @@ ENTRY(vector_swi)
 	/* saved_psr and saved_pc are now dead */
 
 	uaccess_disable tbl
+	get_thread_info tsk
 
 	adr	tbl, sys_call_table		@ load syscall table pointer
 
@@ -234,13 +235,16 @@ ENTRY(vector_swi)
 	 * get the old ABI syscall table address.
 	 */
 	bics	r10, r10, #0xff000000
+	str	r10, [tsk, #TI_SYSCALL]
 	eorne	scno, r10, #__NR_OABI_SYSCALL_BASE
 	ldrne	tbl, =sys_oabi_call_table
 #elif !defined(CONFIG_AEABI)
 	bic	scno, scno, #0xff000000		@ mask off SWI op-code
+	str	scno, [tsk, #TI_SYSCALL]
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
+#else
+	str	scno, [tsk, #TI_SYSCALL]
 #endif
-	get_thread_info tsk
 	/*
 	 * Reload the registers that may have been corrupted on entry to
 	 * the syscall assembly (by tracing or context tracking.)
@@ -285,7 +289,6 @@ ENDPROC(vector_swi)
 	 * context switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	mov	r1, scno
 	add	r0, sp, #S_OFF
 	bl	syscall_trace_enter
 	mov	scno, r0
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 2771e682220b..252060663b00 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -885,9 +885,9 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	regs->ARM_ip = ip;
 }
 
-asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	current_thread_info()->syscall = scno;
+	int scno;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
-- 
2.27.0

