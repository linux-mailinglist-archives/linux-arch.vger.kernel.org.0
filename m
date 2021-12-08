Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE746DCF0
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbhLHU3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:29:51 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:60744 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbhLHU3v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:29:51 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:41720)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3W6-00H1iy-B1; Wed, 08 Dec 2021 13:26:18 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3W3-00CjR6-OY; Wed, 08 Dec 2021 13:26:17 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  8 Dec 2021 14:25:24 -0600
Message-Id: <20211208202532.16409-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3W3-00CjR6-OY;;;mid=<20211208202532.16409-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Cd21mic8ezKY+1p0imLhSEJgh7J03b5Q=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,T_XMDrugObfuBody_12,
        XMNoVowels,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1936 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 10 (0.5%), parse: 2.1 (0.1%),
         extract_message_metadata: 22 (1.1%), get_uri_detail_list: 11 (0.6%),
        tests_pri_-1000: 14 (0.7%), tests_pri_-950: 1.40 (0.1%),
        tests_pri_-900: 1.18 (0.1%), tests_pri_-90: 233 (12.1%), check_bayes:
        232 (12.0%), b_tokenize: 42 (2.2%), b_tok_get_all: 113 (5.8%),
        b_comp_prob: 4.6 (0.2%), b_tok_touch_all: 68 (3.5%), b_finish: 0.96
        (0.0%), tests_pri_0: 1633 (84.4%), check_dkim_signature: 1.05 (0.1%),
        check_dkim_adsp: 2.8 (0.1%), poll_dns_idle: 0.90 (0.0%), tests_pri_10:
        3.2 (0.2%), tests_pri_500: 9 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 02/10] exit: Add and use make_task_dead.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are two big uses of do_exit.  The first is it's design use to be
the guts of the exit(2) system call.  The second use is to terminate
a task after something catastrophic has happened like a NULL pointer
in kernel code.

Add a function make_task_dead that is initialy exactly the same as
do_exit to cover the cases where do_exit is called to handle
catastrophic failure.  In time this can probably be reduced to just a
light wrapper around do_task_dead. For now keep it exactly the same so
that there will be no behavioral differences introducing this new
concept.

Replace all of the uses of do_exit that use it for catastraphic
task cleanup with make_task_dead to make it clear what the code
is doing.

As part of this rename rewind_stack_do_exit
rewind_stack_and_make_dead.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/traps.c           | 6 +++---
 arch/alpha/mm/fault.c               | 2 +-
 arch/arm/kernel/traps.c             | 2 +-
 arch/arm/mm/fault.c                 | 2 +-
 arch/arm64/kernel/traps.c           | 2 +-
 arch/arm64/mm/fault.c               | 2 +-
 arch/csky/abiv1/alignment.c         | 2 +-
 arch/csky/kernel/traps.c            | 2 +-
 arch/csky/mm/fault.c                | 2 +-
 arch/h8300/kernel/traps.c           | 2 +-
 arch/h8300/mm/fault.c               | 2 +-
 arch/hexagon/kernel/traps.c         | 2 +-
 arch/ia64/kernel/mca_drv.c          | 2 +-
 arch/ia64/kernel/traps.c            | 2 +-
 arch/ia64/mm/fault.c                | 2 +-
 arch/m68k/kernel/traps.c            | 2 +-
 arch/m68k/mm/fault.c                | 2 +-
 arch/microblaze/kernel/exceptions.c | 4 ++--
 arch/mips/kernel/traps.c            | 2 +-
 arch/nds32/kernel/fpu.c             | 2 +-
 arch/nds32/kernel/traps.c           | 8 ++++----
 arch/nios2/kernel/traps.c           | 4 ++--
 arch/openrisc/kernel/traps.c        | 2 +-
 arch/parisc/kernel/traps.c          | 2 +-
 arch/powerpc/kernel/traps.c         | 8 ++++----
 arch/riscv/kernel/traps.c           | 2 +-
 arch/riscv/mm/fault.c               | 2 +-
 arch/s390/kernel/dumpstack.c        | 2 +-
 arch/s390/kernel/nmi.c              | 2 +-
 arch/sh/kernel/traps.c              | 2 +-
 arch/sparc/kernel/traps_32.c        | 4 +---
 arch/sparc/kernel/traps_64.c        | 4 +---
 arch/x86/entry/entry_32.S           | 6 +++---
 arch/x86/entry/entry_64.S           | 6 +++---
 arch/x86/kernel/dumpstack.c         | 4 ++--
 arch/xtensa/kernel/traps.c          | 2 +-
 include/linux/sched/task.h          | 1 +
 kernel/exit.c                       | 9 +++++++++
 tools/objtool/check.c               | 3 ++-
 39 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 2ae34702456c..8a66fe544c69 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -190,7 +190,7 @@ die_if_kernel(char * str, struct pt_regs *regs, long err, unsigned long *r9_15)
 		local_irq_enable();
 		while (1);
 	}
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
 
 #ifndef CONFIG_MATHEMU
@@ -575,7 +575,7 @@ do_entUna(void * va, unsigned long opcode, unsigned long reg,
 
 	printk("Bad unaligned kernel access at %016lx: %p %lx %lu\n",
 		pc, va, opcode, reg);
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 
 got_exception:
 	/* Ok, we caught the exception, but we don't want it.  Is there
@@ -630,7 +630,7 @@ do_entUna(void * va, unsigned long opcode, unsigned long reg,
 		local_irq_enable();
 		while (1);
 	}
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
 
 /*
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index eee5102c3d88..e9193d52222e 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -204,7 +204,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	printk(KERN_ALERT "Unable to handle kernel paging request at "
 	       "virtual address %016lx\n", address);
 	die_if_kernel("Oops", regs, cause, (unsigned long*)regs - 16);
-	do_exit(SIGKILL);
+	make_task_dead(SIGKILL);
 
 	/* We ran out of memory, or some other thing happened to us that
 	   made us unable to handle the page fault gracefully.  */
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 195dff58bafc..b4bd2e5f17c1 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -333,7 +333,7 @@ static void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	if (panic_on_oops)
 		panic("Fatal exception");
 	if (signr)
-		do_exit(signr);
+		make_task_dead(signr);
 }
 
 /*
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bc8779d54a64..bf1a0c618c49 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -111,7 +111,7 @@ static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 	show_pte(KERN_ALERT, mm, addr);
 	die("Oops", regs, fsr);
 	bust_spinlocks(0);
-	do_exit(SIGKILL);
+	make_task_dead(SIGKILL);
 }
 
 /*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7b21213a570f..bdd456e4e7f4 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -235,7 +235,7 @@ void die(const char *str, struct pt_regs *regs, int err)
 	raw_spin_unlock_irqrestore(&die_lock, flags);
 
 	if (ret != NOTIFY_STOP)
-		do_exit(SIGSEGV);
+		make_task_dead(SIGSEGV);
 }
 
 static void arm64_show_signal(int signo, const char *str)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9ae24e3b72be..11a28cace2d2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -302,7 +302,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	show_pte(addr);
 	die("Oops", regs, esr);
 	bust_spinlocks(0);
-	do_exit(SIGKILL);
+	make_task_dead(SIGKILL);
 }
 
 #ifdef CONFIG_KASAN_HW_TAGS
diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index cb2a0d94a144..5e2fb45d605c 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -294,7 +294,7 @@ void csky_alignment(struct pt_regs *regs)
 				__func__, opcode, rz, rx, imm, addr);
 		show_regs(regs);
 		bust_spinlocks(0);
-		do_exit(SIGKILL);
+		make_dead_task(SIGKILL);
 	}
 
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index e5fbf8653a21..88a47035b925 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -109,7 +109,7 @@ void die(struct pt_regs *regs, const char *str)
 	if (panic_on_oops)
 		panic("Fatal exception");
 	if (ret != NOTIFY_STOP)
-		do_exit(SIGSEGV);
+		make_dead_task(SIGSEGV);
 }
 
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 466ad949818a..7215a46b6b8e 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -67,7 +67,7 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 	pr_alert("Unable to handle kernel paging request at virtual "
 		 "addr 0x%08lx, pc: 0x%08lx\n", addr, regs->pc);
 	die(regs, "Oops");
-	do_exit(SIGKILL);
+	make_task_dead(SIGKILL);
 }
 
 static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
index bdbe988d8dbc..3d4e0bde37ae 100644
--- a/arch/h8300/kernel/traps.c
+++ b/arch/h8300/kernel/traps.c
@@ -106,7 +106,7 @@ void die(const char *str, struct pt_regs *fp, unsigned long err)
 	dump(fp);
 
 	spin_unlock_irq(&die_lock);
-	do_exit(SIGSEGV);
+	make_dead_task(SIGSEGV);
 }
 
 static int kstack_depth_to_print = 24;
diff --git a/arch/h8300/mm/fault.c b/arch/h8300/mm/fault.c
index d4bc9c16f2df..0223528565dd 100644
--- a/arch/h8300/mm/fault.c
+++ b/arch/h8300/mm/fault.c
@@ -51,7 +51,7 @@ asmlinkage int do_page_fault(struct pt_regs *regs, unsigned long address,
 	printk(" at virtual address %08lx\n", address);
 	if (!user_mode(regs))
 		die("Oops", regs, error_code);
-	do_exit(SIGKILL);
+	make_dead_task(SIGKILL);
 
 	return 1;
 }
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index edfc35dafeb1..6dd6cf0ab711 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -214,7 +214,7 @@ int die(const char *str, struct pt_regs *regs, long err)
 		panic("Fatal exception");
 
 	oops_exit();
-	do_exit(err);
+	make_dead_task(err);
 	return 0;
 }
 
diff --git a/arch/ia64/kernel/mca_drv.c b/arch/ia64/kernel/mca_drv.c
index 5bfc79be4cef..23c203639a96 100644
--- a/arch/ia64/kernel/mca_drv.c
+++ b/arch/ia64/kernel/mca_drv.c
@@ -176,7 +176,7 @@ mca_handler_bh(unsigned long paddr, void *iip, unsigned long ipsr)
 	spin_unlock(&mca_bh_lock);
 
 	/* This process is about to be killed itself */
-	do_exit(SIGKILL);
+	make_task_dead(SIGKILL);
 }
 
 /**
diff --git a/arch/ia64/kernel/traps.c b/arch/ia64/kernel/traps.c
index e13cb905930f..753642366e12 100644
--- a/arch/ia64/kernel/traps.c
+++ b/arch/ia64/kernel/traps.c
@@ -85,7 +85,7 @@ die (const char *str, struct pt_regs *regs, long err)
 	if (panic_on_oops)
 		panic("Fatal exception");
 
-  	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 02de2e70c587..4796cccbf74f 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -259,7 +259,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		regs = NULL;
 	bust_spinlocks(0);
 	if (regs)
-		do_exit(SIGKILL);
+		make_task_dead(SIGKILL);
 	return;
 
   out_of_memory:
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 34d6458340b0..59fc63feb0dc 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1131,7 +1131,7 @@ void die_if_kernel (char *str, struct pt_regs *fp, int nr)
 	pr_crit("%s: %08x\n", str, nr);
 	show_registers(fp);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
 
 asmlinkage void set_esp0(unsigned long ssp)
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index ef46e77e97a5..fcb3a0d8421c 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -48,7 +48,7 @@ int send_fault_sig(struct pt_regs *regs)
 			pr_alert("Unable to handle kernel access");
 		pr_cont(" at virtual address %p\n", addr);
 		die_if_kernel("Oops", regs, 0 /*error_code*/);
-		do_exit(SIGKILL);
+		make_task_dead(SIGKILL);
 	}
 
 	return 1;
diff --git a/arch/microblaze/kernel/exceptions.c b/arch/microblaze/kernel/exceptions.c
index 908788497b28..fd153d5fab98 100644
--- a/arch/microblaze/kernel/exceptions.c
+++ b/arch/microblaze/kernel/exceptions.c
@@ -44,10 +44,10 @@ void die(const char *str, struct pt_regs *fp, long err)
 	pr_warn("Oops: %s, sig: %ld\n", str, err);
 	show_regs(fp);
 	spin_unlock_irq(&die_lock);
-	/* do_exit() should take care of panic'ing from an interrupt
+	/* make_task_dead() should take care of panic'ing from an interrupt
 	 * context so we don't handle it here
 	 */
-	do_exit(err);
+	make_task_dead(err);
 }
 
 /* for user application debugging */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d26b0fb8ea06..a486486b2355 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -422,7 +422,7 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	if (regs && kexec_should_crash(current))
 		crash_kexec(regs);
 
-	do_exit(sig);
+	make_task_dead(sig);
 }
 
 extern struct exception_table_entry __start___dbe_table[];
diff --git a/arch/nds32/kernel/fpu.c b/arch/nds32/kernel/fpu.c
index 9edd7ed7d7bf..701c09a668de 100644
--- a/arch/nds32/kernel/fpu.c
+++ b/arch/nds32/kernel/fpu.c
@@ -223,7 +223,7 @@ inline void handle_fpu_exception(struct pt_regs *regs)
 		}
 	} else if (fpcsr & FPCSR_mskRIT) {
 		if (!user_mode(regs))
-			do_exit(SIGILL);
+			make_task_dead(SIGILL);
 		si_signo = SIGILL;
 	}
 
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index ca75d475eda4..c0a8f3344fb9 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -141,7 +141,7 @@ void __noreturn die(const char *str, struct pt_regs *regs, int err)
 
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
 
 EXPORT_SYMBOL(die);
@@ -240,7 +240,7 @@ void unhandled_interruption(struct pt_regs *regs)
 	pr_emerg("unhandled_interruption\n");
 	show_regs(regs);
 	if (!user_mode(regs))
-		do_exit(SIGKILL);
+		make_task_dead(SIGKILL);
 	force_sig(SIGKILL);
 }
 
@@ -251,7 +251,7 @@ void unhandled_exceptions(unsigned long entry, unsigned long addr,
 		 addr, type);
 	show_regs(regs);
 	if (!user_mode(regs))
-		do_exit(SIGKILL);
+		make_task_dead(SIGKILL);
 	force_sig(SIGKILL);
 }
 
@@ -278,7 +278,7 @@ void do_revinsn(struct pt_regs *regs)
 	pr_emerg("Reserved Instruction\n");
 	show_regs(regs);
 	if (!user_mode(regs))
-		do_exit(SIGILL);
+		make_task_dead(SIGILL);
 	force_sig(SIGILL);
 }
 
diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index 596986a74a26..85ac49d64cf7 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -37,10 +37,10 @@ void die(const char *str, struct pt_regs *regs, long err)
 	show_regs(regs);
 	spin_unlock_irq(&die_lock);
 	/*
-	 * do_exit() should take care of panic'ing from an interrupt
+	 * make_task_dead() should take care of panic'ing from an interrupt
 	 * context so we don't handle it here
 	 */
-	do_exit(err);
+	make_task_dead(err);
 }
 
 void _exception(int signo, struct pt_regs *regs, int code, unsigned long addr)
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 0898cb159fac..0446a3c34372 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -212,7 +212,7 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 	__asm__ __volatile__("l.nop   1");
 	do {} while (1);
 #endif
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
 
 /* This is normally the 'Oops' routine */
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index b11fb26ce299..df2122c50d78 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -269,7 +269,7 @@ void die_if_kernel(char *str, struct pt_regs *regs, long err)
 		panic("Fatal exception");
 
 	oops_exit();
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
 
 /* gdb uses break 4,8 */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 11741703d26e..a08bb7cefdc5 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -245,7 +245,7 @@ static void oops_end(unsigned long flags, struct pt_regs *regs,
 
 	if (panic_on_oops)
 		panic("Fatal exception");
-	do_exit(signr);
+	make_task_dead(signr);
 }
 NOKPROBE_SYMBOL(oops_end);
 
@@ -792,9 +792,9 @@ int machine_check_generic(struct pt_regs *regs)
 void die_mce(const char *str, struct pt_regs *regs, long err)
 {
 	/*
-	 * The machine check wants to kill the interrupted context, but
-	 * do_exit() checks for in_interrupt() and panics in that case, so
-	 * exit the irq/nmi before calling die.
+	 * The machine check wants to kill the interrupted context,
+	 * but make_task_dead() checks for in_interrupt() and panics
+	 * in that case, so exit the irq/nmi before calling die.
 	 */
 	if (in_nmi())
 		nmi_exit();
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0daaa3e4630d..fe92e119e6a3 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -54,7 +54,7 @@ void die(struct pt_regs *regs, const char *str)
 	if (panic_on_oops)
 		panic("Fatal exception");
 	if (ret != NOTIFY_STOP)
-		do_exit(SIGSEGV);
+		make_task_dead(SIGSEGV);
 }
 
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index aa08dd2f8fae..42118bc728f9 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -31,7 +31,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 
 	bust_spinlocks(0);
 	die(regs, "Oops");
-	do_exit(SIGKILL);
+	make_task_dead(SIGKILL);
 }
 
 static inline void no_context(struct pt_regs *regs, unsigned long addr)
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 0681c55e831d..1e3233eb510a 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -224,5 +224,5 @@ void __noreturn die(struct pt_regs *regs, const char *str)
 	if (panic_on_oops)
 		panic("Fatal exception: panic_on_oops");
 	oops_exit();
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 20f8e1868853..a4d8c058dd27 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -175,7 +175,7 @@ void __s390_handle_mcck(void)
 		       "malfunction (code 0x%016lx).\n", mcck.mcck_code);
 		printk(KERN_EMERG "mcck: task: %s, pid: %d.\n",
 		       current->comm, current->pid);
-		do_exit(SIGSEGV);
+		make_task_dead(SIGSEGV);
 	}
 }
 
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index cbe3201d4f21..01884054aeb2 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -57,7 +57,7 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 	if (panic_on_oops)
 		panic("Fatal exception");
 
-	do_exit(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
 
 void die_if_kernel(const char *str, struct pt_regs *regs, long err)
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 5630e5a395e0..179aabfa712e 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -86,9 +86,7 @@ void __noreturn die_if_kernel(char *str, struct pt_regs *regs)
 	}
 	printk("Instruction DUMP:");
 	instruction_dump ((unsigned long *) regs->pc);
-	if(regs->psr & PSR_PS)
-		do_exit(SIGKILL);
-	do_exit(SIGSEGV);
+	make_task_dead((regs->psr & PSR_PS) ? SIGKILL : SIGSEGV);
 }
 
 void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 6863025ed56d..21077821f427 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2559,9 +2559,7 @@ void __noreturn die_if_kernel(char *str, struct pt_regs *regs)
 	}
 	if (panic_on_oops)
 		panic("Fatal exception");
-	if (regs->tstate & TSTATE_PRIV)
-		do_exit(SIGKILL);
-	do_exit(SIGSEGV);
+	make_task_dead((regs->tstate & TSTATE_PRIV)? SIGKILL : SIGSEGV);
 }
 EXPORT_SYMBOL(die_if_kernel);
 
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ccb9d32768f3..7738fad6a85e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1248,14 +1248,14 @@ SYM_CODE_START(asm_exc_nmi)
 SYM_CODE_END(asm_exc_nmi)
 
 .pushsection .text, "ax"
-SYM_CODE_START(rewind_stack_do_exit)
+SYM_CODE_START(rewind_stack_and_make_dead)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
 	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esi
 	leal	-TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
 
-	call	do_exit
+	call	make_task_dead
 1:	jmp 1b
-SYM_CODE_END(rewind_stack_do_exit)
+SYM_CODE_END(rewind_stack_and_make_dead)
 .popsection
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..f09276457942 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1429,7 +1429,7 @@ SYM_CODE_END(ignore_sysret)
 #endif
 
 .pushsection .text, "ax"
-SYM_CODE_START(rewind_stack_do_exit)
+SYM_CODE_START(rewind_stack_and_make_dead)
 	UNWIND_HINT_FUNC
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
@@ -1438,6 +1438,6 @@ SYM_CODE_START(rewind_stack_do_exit)
 	leaq	-PTREGS_SIZE(%rax), %rsp
 	UNWIND_HINT_REGS
 
-	call	do_exit
-SYM_CODE_END(rewind_stack_do_exit)
+	call	make_task_dead
+SYM_CODE_END(rewind_stack_and_make_dead)
 .popsection
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index ea4fe192189d..53de044e5654 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -351,7 +351,7 @@ unsigned long oops_begin(void)
 }
 NOKPROBE_SYMBOL(oops_begin);
 
-void __noreturn rewind_stack_do_exit(int signr);
+void __noreturn rewind_stack_and_make_dead(int signr);
 
 void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 {
@@ -386,7 +386,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	 * reuse the task stack and that existing poisons are invalid.
 	 */
 	kasan_unpoison_task_stack(current);
-	rewind_stack_do_exit(signr);
+	rewind_stack_and_make_dead(signr);
 }
 NOKPROBE_SYMBOL(oops_end);
 
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 4b4dbeb2d612..9345007d474d 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -552,5 +552,5 @@ void __noreturn die(const char * str, struct pt_regs * regs, long err)
 	if (panic_on_oops)
 		panic("Fatal exception");
 
-	do_exit(err);
+	make_task_dead(err);
 }
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ba88a6987400..2d4bbd9c3278 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -59,6 +59,7 @@ extern void sched_post_fork(struct task_struct *p,
 extern void sched_dead(struct task_struct *p);
 
 void __noreturn do_task_dead(void);
+void __noreturn make_task_dead(int signr);
 
 extern void proc_caches_init(void);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index f702a6a63686..bfa513c5b227 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -884,6 +884,15 @@ void __noreturn do_exit(long code)
 }
 EXPORT_SYMBOL_GPL(do_exit);
 
+void __noreturn make_task_dead(int signr)
+{
+	/*
+	 * Take the task off the cpu after something catastrophic has
+	 * happened.
+	 */
+	do_exit(signr);
+}
+
 void complete_and_exit(struct completion *comp, long code)
 {
 	if (comp)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 21735829b860..e6ab5687770b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -168,6 +168,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"panic",
 		"do_exit",
 		"do_task_dead",
+		"make_task_dead",
 		"__module_put_and_exit",
 		"complete_and_exit",
 		"__reiserfs_panic",
@@ -175,7 +176,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"fortify_panic",
 		"usercopy_abort",
 		"machine_real_restart",
-		"rewind_stack_do_exit",
+		"rewind_stack_and_make_dead"
 		"kunit_try_catch_throw",
 		"xen_start_kernel",
 		"cpu_bringup_and_idle",
-- 
2.29.2

