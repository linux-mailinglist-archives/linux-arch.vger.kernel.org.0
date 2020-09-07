Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35A25FD62
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgIGPqt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 11:46:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbgIGPil (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 11:38:41 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKsax-1jz1mO2Uaj-00LArU; Mon, 07 Sep 2020 17:37:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] ARM: traps: use get_kernel_nofault instead of set_fs()
Date:   Mon,  7 Sep 2020 17:36:43 +0200
Message-Id: <20200907153701.2981205-3-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200907153701.2981205-1-arnd@arndb.de>
References: <20200907153701.2981205-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bqL9TqSlLxoRFFmGo0QZlOzE4loGzIV2al/StD8nh0dRqmEo/zl
 r64AuU+j3zZIcpJ6aJRTDhH/hcUIRPN0v5Ce+f7pq0+Pp8u9hWU8oEVPjpBBwogE+XZO5No
 yCZBEAexPXzjyNtW8kovGgln9eIgE+krcRPWvUn/+8dWvPjezJSouRZiuckvQOO9eR1YOws
 VWiVkFvqGHaxoJfst5xjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CSTeWP/Fmbs=:E8ArNtSucnOwkJb173KkVn
 IFhVpT/SayTL0XFhu8YBu2d7K0bL9QnhCHK4fB2CFn0Zj2g3TMFjdioycUx2V4BaIKupaQDIs
 wI8mBHmGHVyoVjvlcdlZKLSdfELYqVeHF4kmrwxRpDKJvcnOCJME7Rej/KDkpE6ag+Ku18u+S
 yd5YNp33A9tdwdJii9LINoc87+IuZ8zULpSiWFjGT21fQAbi2xLWVJitEDlOpFnANCjlFLXWo
 b3LLS4keCz7+qN55MsLOE0S2XYC2Ysbw7ubVOFa+rkW55p+wPt4i/ksIxd4nQWX5qC5FKKVCE
 AB4ZmIdysWUCXUadYMP2Zemix0HlSGwjRIFgkVaqVCcd3rrUY17VT3dRZQr4ZUUe5mzItwpQV
 vmVNrXP59siGL3uPhFAlQt+SqGN1gQnL2bE1lisYTdl8TsepO6sI3UQslea4PhVZ4hnbn8N65
 jZeoWlAB8KyTCeFQsJxCfzZisUI4uigMcagsHFoDxwLdGQDdNdU4NVx49T2eWg6mlWPLsBnGy
 7GFt3Qm4BIQdDXksjITSF7oh5hslqPcyZ9W6JFvoxNEGUs89KFfPsJ1ckPAEqgZ35a7RC+UVj
 JODqUytSWQ4zgyD1qO+Pdsl8SCVlDnUaibLrcEPawVKITJ90Mo+8rlFAn7IOM4ITlIwbATXZ6
 P0l1KLrLU85ifgidC5vUKDxqq0+jv/cdc8O46AzDbsmqfld29FWhTZo6Vy2L0ZFDCkhMnUDw7
 OsZTugwqnbpd/JGAfSwg31t+KdQOl+uCFV8vCxlBfxS0Vi2wY3bW7ToTBVFZ8qcTG4Prq1Gus
 YX+14gkcMYMMyV9PS2ocYDIj1r+hUM9KDPzRnhOLzrwatKBB8vtTe4ANv9ofKnBAKb49ftq
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The stack dumping code needs to work for both kernel and user mode,
and currently this works by using set_fs() and then calling get_user()
to carefully access a potentially invalid pointer.

Change both locations to handle user and kernel mode differently, using
get_kernel_nofault() in case of kernel pointers.

I change __get_user() to get_user() here for consistency, as user space
stacks should not point into kernel memory.

In dump_backtrace_entry() I assume that dump_mem() can only operate on
kernel pointers when in_entry_text(from) is true, rather than checking
the mode register.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/traps.c | 69 ++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 17d5a785df28..ebed261b356f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -60,7 +60,7 @@ static int __init user_debug_setup(char *str)
 __setup("user_debug=", user_debug_setup);
 #endif
 
-static void dump_mem(const char *, const char *, unsigned long, unsigned long);
+static void dump_mem(const char *, const char *, unsigned long, unsigned long, bool kernel_mode);
 
 void dump_backtrace_entry(unsigned long where, unsigned long from,
 			  unsigned long frame, const char *loglvl)
@@ -76,7 +76,7 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 #endif
 
 	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
-		dump_mem(loglvl, "Exception stack", frame + 4, end);
+		dump_mem(loglvl, "Exception stack", frame + 4, end, true);
 }
 
 void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
@@ -119,20 +119,11 @@ static int verify_stack(unsigned long sp)
  * Dump out the contents of some memory nicely...
  */
 static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
-		     unsigned long top)
+		     unsigned long top, bool kernel_mode)
 {
 	unsigned long first;
-	mm_segment_t fs;
 	int i;
 
-	/*
-	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.  Note that we now dump the
-	 * code first, just in case the backtrace kills us.
-	 */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	printk("%s%s(0x%08lx to 0x%08lx)\n", lvl, str, bottom, top);
 
 	for (first = bottom & ~31; first < top; first += 32) {
@@ -144,20 +135,25 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 
 		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
 			if (p >= bottom && p < top) {
-				unsigned long val;
-				if (__get_user(val, (unsigned long *)p) == 0)
-					sprintf(str + i * 9, " %08lx", val);
+				u32 val;
+				int err;
+
+				if (kernel_mode)
+					err = get_kernel_nofault(val, (u32 *)p);
+				else
+					err = get_user(val, (u32 *)p);
+
+				if (!err)
+					sprintf(str + i * 9, " %08x", val);
 				else
 					sprintf(str + i * 9, " ????????");
 			}
 		}
 		printk("%s%04lx:%s\n", lvl, first & 0xffff, str);
 	}
-
-	set_fs(fs);
 }
 
-static void __dump_instr(const char *lvl, struct pt_regs *regs)
+static void dump_instr(const char *lvl, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
 	const int thumb = thumb_mode(regs);
@@ -173,10 +169,20 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
 	for (i = -4; i < 1 + !!thumb; i++) {
 		unsigned int val, bad;
 
-		if (thumb)
-			bad = get_user(val, &((u16 *)addr)[i]);
-		else
-			bad = get_user(val, &((u32 *)addr)[i]);
+		if (!user_mode(regs)) {
+			if (thumb) {
+				u16 val16;
+				bad = get_kernel_nofault(val16, &((u16 *)addr)[i]);
+				val = val16;
+			} else {
+				bad = get_kernel_nofault(val, &((u32 *)addr)[i]);
+			}
+		} else {
+			if (thumb)
+				bad = get_user(val, &((u16 *)addr)[i]);
+			else
+				bad = get_user(val, &((u32 *)addr)[i]);
+		}
 
 		if (!bad)
 			p += sprintf(p, i == 0 ? "(%0*x) " : "%0*x ",
@@ -189,20 +195,6 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
 
-static void dump_instr(const char *lvl, struct pt_regs *regs)
-{
-	mm_segment_t fs;
-
-	if (!user_mode(regs)) {
-		fs = get_fs();
-		set_fs(KERNEL_DS);
-		__dump_instr(lvl, regs);
-		set_fs(fs);
-	} else {
-		__dump_instr(lvl, regs);
-	}
-}
-
 #ifdef CONFIG_ARM_UNWIND
 static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 				  const char *loglvl)
@@ -276,6 +268,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	struct task_struct *tsk = current;
 	static int die_counter;
 	int ret;
+	bool kernel_mode = !user_mode(regs);
 
 	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP S_ISA "\n",
 	         str, err, ++die_counter);
@@ -290,9 +283,9 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
 
-	if (!user_mode(regs) || in_interrupt()) {
+	if (kernel_mode || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
+			 THREAD_SIZE + (unsigned long)task_stack_page(tsk), kernel_mode);
 		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
 	}
-- 
2.27.0

