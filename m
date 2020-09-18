Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E4226FD5E
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIRMri (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 08:47:38 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60693 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRMrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 08:47:01 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MMoOy-1k0cTH1t1o-00IjeX; Fri, 18 Sep 2020 14:46:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 4/9] ARM: syscall: always store thread_info->syscall
Date:   Fri, 18 Sep 2020 14:46:19 +0200
Message-Id: <20200918124624.1469673-5-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918124624.1469673-1-arnd@arndb.de>
References: <20200918124624.1469673-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oYbsUpC7iW/8Uz8fjl5NJEZ6YNi0H9qnT9Jm+ZYvgswXJGPeqSV
 bhUcYLv/xDzIBjqVc6MjVmMlF7JZalcV+3/Q7of7qmFllWrLNW63+jVKT1T/YMZgNMiwnMX
 +pkmssiDTvvTNYFjalidxInFqjQ5jcM3S5E4Z/GsqvnZiMypxNAvzda2B60Iw35ofXdSbMs
 YUbV8Z0aHsSrGU+ZQiGBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TjZZlTlaR60=:2fdE+jOcrb1YH2bgwD8Xke
 SuRyc8Oz2mtKsEVpefh1Uu2kYfnWbyF+jrgSr5wb62vQvxDaIl8Uz/tdbANmAoRJr10I8ARm+
 4d+12YrYfGXRrZj52FjmTOZBINDPSGe+QiFma8Skcf1DXaMgG1+fnWxgamIXFj9mkwvdX97uy
 SDqcNDdXdYCA4Svk5qm/p/SUgLV4R/7k9T+4heHkSstmHg32aQHUOi/h63EuMnaZ8Ksb30QOo
 iyas2/Rnt2RbQaUPzXnSlUII3ZzL7HT1URu+AXxsu56orSIiCEve32E5e+X/QY+YmKoaona1d
 EO5qxGAm9Ikrt7EwnRSKX+NDWr26pPkP+PeHt3DGfK81oTgn/y69xdDuUKaKjmhl7YTqEKy3x
 aR0S03+lsvzQo9C35zCQpnjF4H0CA5vs3BbYla7x4i1aCggG0Salua3KS8KOELbbqzU24M6nO
 Q7sqEsZequ0MAvFN00gT9RRxTlkQRz9Ev7E85DSwepKQAQ3Afed15dmfSTGTDfkv2L0XZ+8Lb
 li9A1upiGsTkc2mJopRvz83BOFwprQcfdCzhcax/8JylgWtdNRLp5oE/3+f8jK+A6aqZveIoP
 K08mTTcsqwfSLwpmi804K2P3ZUtg3gDwZtn/BHQuocZ6trUljg4Lcc71Oa9C+6d5513SS+gND
 CaxxX2jLKSf7j8uUtNvPuEMEGbodh4OWXl5C7bCg8O0FqTd8dgpJoijuB1Mf9givq8FvMbKHN
 VA0qrxNrJ7kkQd6w6R8ptjoTfBvU4oNagxEx8TNqSmCK9XG2WCqhvoApxjhx8lYMEImxzTX0S
 Vh/o+ghDotvwTFKIHR092E6j+irvP4k4i6+AAfX1f+dz02v6cQyxkRV+uX8Ic7gTaS3OjFx
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
 arch/arm/include/asm/syscall.h | 5 ++++-
 arch/arm/kernel/asm-offsets.c  | 1 +
 arch/arm/kernel/entry-common.S | 7 +++++--
 arch/arm/kernel/ptrace.c       | 4 ++--
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index fd02761ba06c..855aa7cc9b8e 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -22,7 +22,10 @@ extern const unsigned long sys_call_table[];
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
 {
-	return task_thread_info(task)->syscall;
+	if (!IS_ENABLED(CONFIG_OABI_COMPAT))
+		return task_thread_info(task)->syscall;
+
+	return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;
 }
 
 static inline void syscall_rollback(struct task_struct *task,
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

