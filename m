Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57805273C3
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfEWBDr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:03:47 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51066 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBDq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:03:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp6-0002Kz-SW; Wed, 22 May 2019 18:43:08 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnx-0005Z3-8z; Wed, 22 May 2019 18:42:05 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:11 -0500
Message-Id: <20190523003916.20726-22-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnx-0005Z3-8z;;;mid=<20190523003916.20726-22-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+PGUP1EOFxta2XQYEGPHF3VpDbY5btrK0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 7430 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 1.93 (0.0%), b_tie_ro: 1.35 (0.0%), parse: 2.9
        (0.0%), extract_message_metadata: 37 (0.5%), get_uri_detail_list: 28
        (0.4%), tests_pri_-1000: 9 (0.1%), tests_pri_-950: 1.16 (0.0%),
        tests_pri_-900: 0.87 (0.0%), tests_pri_-90: 120 (1.6%), check_bayes:
        118 (1.6%), b_tokenize: 80 (1.1%), b_tok_get_all: 25 (0.3%),
        b_comp_prob: 3.4 (0.0%), b_tok_touch_all: 7 (0.1%), b_finish: 0.54
        (0.0%), tests_pri_0: 3398 (45.7%), check_dkim_signature: 1.03 (0.0%),
        check_dkim_adsp: 2.4 (0.0%), poll_dns_idle: 3841 (51.7%),
        tests_pri_10: 2.9 (0.0%), tests_pri_500: 3849 (51.8%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 21/26] signal: Remove the task parameter from force_sig_fault
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As synchronous exceptions really only make sense against the current
task (otherwise how are you synchronous) remove the task parameter
from from force_sig_fault to make it explicit that is what is going
on.

The two known exceptions that deliver a synchronous exception to a
stopped ptraced task have already been changed to
force_sig_fault_to_task.

The callers have been changed with the following emacs regular expression
(with obvious variations on the architectures that take more arguments)
to avoid typos:

force_sig_fault[(]\([^,]+\)[,]\([^,]+\)[,]\([^,]+\)[,]\W+current[)]
->
force_sig_fault(\1,\2,\3)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/traps.c                 |  2 +-
 arch/alpha/mm/fault.c                     |  4 +--
 arch/arc/kernel/traps.c                   |  2 +-
 arch/arc/mm/fault.c                       |  4 +--
 arch/arm/kernel/ptrace.c                  |  2 +-
 arch/arm/kernel/traps.c                   |  2 +-
 arch/arm/mm/alignment.c                   |  2 +-
 arch/arm/mm/fault.c                       |  2 +-
 arch/arm64/kernel/traps.c                 |  2 +-
 arch/c6x/kernel/traps.c                   |  2 +-
 arch/csky/abiv1/alignment.c               |  2 +-
 arch/csky/abiv2/fpu.c                     |  2 +-
 arch/csky/kernel/traps.c                  |  2 +-
 arch/csky/mm/fault.c                      |  4 +--
 arch/hexagon/kernel/traps.c               |  2 +-
 arch/hexagon/mm/vm_fault.c                |  4 +--
 arch/ia64/kernel/brl_emu.c                |  6 ++--
 arch/ia64/kernel/traps.c                  | 18 +++++------
 arch/ia64/kernel/unaligned.c              |  2 +-
 arch/ia64/mm/fault.c                      |  2 +-
 arch/m68k/kernel/traps.c                  |  4 +--
 arch/m68k/mm/fault.c                      |  4 +--
 arch/microblaze/kernel/exceptions.c       |  2 +-
 arch/microblaze/mm/fault.c                |  2 +-
 arch/mips/kernel/traps.c                  | 12 +++----
 arch/mips/mm/fault.c                      |  4 +--
 arch/nds32/kernel/fpu.c                   |  2 +-
 arch/nds32/kernel/traps.c                 |  4 +--
 arch/nds32/mm/fault.c                     |  4 +--
 arch/nios2/kernel/traps.c                 |  2 +-
 arch/openrisc/kernel/traps.c              |  8 ++---
 arch/parisc/kernel/traps.c                | 14 ++++----
 arch/parisc/kernel/unaligned.c            |  4 +--
 arch/parisc/math-emu/driver.c             |  2 +-
 arch/parisc/mm/fault.c                    |  2 +-
 arch/powerpc/kernel/process.c             |  2 +-
 arch/powerpc/kernel/traps.c               |  4 +--
 arch/powerpc/mm/fault.c                   |  2 +-
 arch/powerpc/platforms/cell/spufs/fault.c |  9 +++---
 arch/riscv/kernel/traps.c                 |  4 +--
 arch/s390/kernel/traps.c                  |  6 ++--
 arch/s390/mm/fault.c                      |  6 ++--
 arch/sh/kernel/hw_breakpoint.c            |  2 +-
 arch/sh/kernel/traps_32.c                 |  2 +-
 arch/sh/math-emu/math.c                   |  2 +-
 arch/sh/mm/fault.c                        |  2 +-
 arch/sparc/kernel/process_64.c            |  2 +-
 arch/sparc/kernel/sys_sparc_32.c          |  2 +-
 arch/sparc/kernel/sys_sparc_64.c          |  2 +-
 arch/sparc/kernel/traps_32.c              |  4 +--
 arch/sparc/kernel/traps_64.c              | 39 +++++++++++------------
 arch/sparc/mm/fault_32.c                  |  2 +-
 arch/sparc/mm/fault_64.c                  |  2 +-
 arch/um/kernel/ptrace.c                   |  3 +-
 arch/um/kernel/trap.c                     | 12 +++----
 arch/unicore32/kernel/traps.c             |  2 +-
 arch/unicore32/mm/fault.c                 |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c     |  2 +-
 arch/x86/kernel/ptrace.c                  |  2 +-
 arch/x86/kernel/traps.c                   |  4 +--
 arch/x86/kernel/umip.c                    |  2 +-
 arch/x86/mm/fault.c                       |  7 ++--
 arch/xtensa/kernel/traps.c                |  2 +-
 arch/xtensa/mm/fault.c                    |  4 +--
 include/linux/sched/signal.h              |  3 +-
 kernel/signal.c                           |  5 ++-
 66 files changed, 134 insertions(+), 148 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index bc9627698796..f6b9664ac504 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -402,7 +402,7 @@ do_entDbg(struct pt_regs *regs)
 {
 	die_if_kernel("Instruction fault", regs, 0, NULL);
 
-	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc, 0, current);
+	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc, 0);
 }
 
 
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 188fc9256baf..741e61ef9d3f 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -221,13 +221,13 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	up_read(&mm->mmap_sem);
 	/* Send a sigbus, regardless of whether we were in kernel
 	   or user mode.  */
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address, 0, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address, 0);
 	if (!user_mode(regs))
 		goto no_context;
 	return;
 
  do_sigsegv:
-	force_sig_fault(SIGSEGV, si_code, (void __user *) address, 0, current);
+	force_sig_fault(SIGSEGV, si_code, (void __user *) address, 0);
 	return;
 
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index e618fbb3e28d..fc56efc25488 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -50,7 +50,7 @@ unhandled_exception(const char *str, struct pt_regs *regs,
 
 		tsk->thread.fault_address = (__force unsigned int)addr;
 
-		force_sig_fault(signo, si_code, addr, current);
+		force_sig_fault(signo, si_code, addr);
 
 	} else {
 		/* If not due to copy_(to|from)_user, we are doomed */
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index d5d4758d7e75..5001f6418e92 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -202,7 +202,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		tsk->thread.fault_address = address;
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 		return;
 	}
 
@@ -237,5 +237,5 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		goto no_context;
 
 	tsk->thread.fault_address = address;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index f9cbd08a9075..1512d6b5e1cf 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -204,7 +204,7 @@ void ptrace_disable(struct task_struct *child)
 void ptrace_break(struct pt_regs *regs)
 {
 	force_sig_fault(SIGTRAP, TRAP_BRKPT,
-			(void __user *)instruction_pointer(regs), current);
+			(void __user *)instruction_pointer(regs));
 }
 
 static int break_trap(struct pt_regs *regs, unsigned int instr)
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 288989c7355d..a32342fa3e4a 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -372,7 +372,7 @@ void arm_notify_die(const char *str, struct pt_regs *regs,
 		current->thread.error_code = err;
 		current->thread.trap_no = trap;
 
-		force_sig_fault(signo, si_code, addr, current);
+		force_sig_fault(signo, si_code, addr);
 	} else {
 		die(str, regs, err);
 	}
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index e376883ab35b..a6fffd788c9c 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -948,7 +948,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		goto fixup;
 
 	if (ai_usermode & UM_SIGNAL) {
-		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr, current);
+		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
 	} else {
 		/*
 		 * We're about to disable the alignment trap and return to
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 03007ea4cc72..49e8ec2e9e7b 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -184,7 +184,7 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	force_sig_fault(sig, code, (void __user *)addr, current);
+	force_sig_fault(sig, code, (void __user *)addr);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 65ca953abc53..381f053d91c3 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -256,7 +256,7 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
 			   const char *str)
 {
 	arm64_show_signal(signo, str);
-	force_sig_fault(signo, code, addr, current);
+	force_sig_fault(signo, code, addr);
 }
 
 void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
index 5c60aea3b75a..ca54d1dd2aee 100644
--- a/arch/c6x/kernel/traps.c
+++ b/arch/c6x/kernel/traps.c
@@ -253,7 +253,7 @@ static void do_trap(struct exception_info *except_info, struct pt_regs *regs)
 	die_if_kernel(except_info->kernel_str, regs, addr);
 
 	force_sig_fault(except_info->signo, except_info->code,
-			(void __user *)addr, current);
+			(void __user *)addr);
 }
 
 /*
diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index d789be36eb4f..27ef5b2c43ab 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -283,7 +283,7 @@ void csky_alignment(struct pt_regs *regs)
 		do_exit(SIGKILL);
 	}
 
-	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr, current);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
 }
 
 static struct ctl_table alignment_tbl[4] = {
diff --git a/arch/csky/abiv2/fpu.c b/arch/csky/abiv2/fpu.c
index e7e11344005a..86d187d4e5af 100644
--- a/arch/csky/abiv2/fpu.c
+++ b/arch/csky/abiv2/fpu.c
@@ -124,7 +124,7 @@ void fpu_fpe(struct pt_regs *regs)
 			code = FPE_FLTRES;
 	}
 
-	force_sig_fault(sig, code, (void __user *)regs->pc, current);
+	force_sig_fault(sig, code, (void __user *)regs->pc);
 }
 
 #define FMFVR_FPU_REGS(vrx, vry)	\
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index f487a9b996ae..2792e9601ac5 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -106,7 +106,7 @@ void buserr(struct pt_regs *regs)
 	pr_err("User mode Bus Error\n");
 	show_regs(regs);
 
-	force_sig_fault(SIGSEGV, 0, (void __user *)regs->pc, current);
+	force_sig_fault(SIGSEGV, 0, (void __user *)regs->pc);
 }
 
 #define USR_BKPT 0x1464
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 18041f46ded1..f76618b630f9 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -179,7 +179,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 		return;
 	}
 
@@ -212,5 +212,5 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	if (!user_mode(regs))
 		goto no_context;
 
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index e634414361df..b8a69b2e3f3d 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -420,7 +420,7 @@ void do_trap0(struct pt_regs *regs)
 			 * may want to use a different trap0 flavor.
 			 */
 			force_sig_fault(SIGTRAP, TRAP_BRKPT,
-					(void __user *) pt_elr(regs), current);
+					(void __user *) pt_elr(regs));
 		} else {
 #ifdef CONFIG_KGDB
 			kgdb_handle_exception(pt_cause(regs), SIGTRAP,
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index eb263e61daf4..2b3e22509cdf 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -148,14 +148,14 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 		si_signo = SIGSEGV;
 		si_code  = SEGV_ACCERR;
 	}
-	force_sig_fault(si_signo, si_code, (void __user *)address, current);
+	force_sig_fault(si_signo, si_code, (void __user *)address);
 	return;
 
 bad_area:
 	up_read(&mm->mmap_sem);
 
 	if (user_mode(regs)) {
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 		return;
 	}
 	/* Kernel-mode fault falls through */
diff --git a/arch/ia64/kernel/brl_emu.c b/arch/ia64/kernel/brl_emu.c
index c0239bf77a09..782c481d7052 100644
--- a/arch/ia64/kernel/brl_emu.c
+++ b/arch/ia64/kernel/brl_emu.c
@@ -197,21 +197,21 @@ ia64_emulate_brl (struct pt_regs *regs, unsigned long ar_ec)
 		 */
 		printk(KERN_DEBUG "Woah! Unimplemented Instruction Address Trap!\n");
 		force_sig_fault(SIGILL, ILL_BADIADDR, (void __user *)NULL,
-				0, 0, 0, current);
+				0, 0, 0);
 	} else if (ia64_psr(regs)->tb) {
 		/*
 		 *  Branch Tracing is enabled.
 		 *  Force a taken branch signal.
 		 */
 		force_sig_fault(SIGTRAP, TRAP_BRANCH, (void __user *)NULL,
-				0, 0, 0, current);
+				0, 0, 0);
 	} else if (ia64_psr(regs)->ss) {
 		/*
 		 *  Single Step is enabled.
 		 *  Force a trace signal.
 		 */
 		force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)NULL,
-				0, 0, 0, current);
+				0, 0, 0);
 	}
 	return rv;
 }
diff --git a/arch/ia64/kernel/traps.c b/arch/ia64/kernel/traps.c
index 0a3adbfebc2a..e13cb905930f 100644
--- a/arch/ia64/kernel/traps.c
+++ b/arch/ia64/kernel/traps.c
@@ -176,7 +176,7 @@ __kprobes ia64_bad_break (unsigned long break_num, struct pt_regs *regs)
 	}
 	force_sig_fault(sig, code,
 			(void __user *) (regs->cr_iip + ia64_psr(regs)->ri),
-			break_num, 0 /* clear __ISR_VALID */, 0, current);
+			break_num, 0 /* clear __ISR_VALID */, 0);
 }
 
 /*
@@ -353,7 +353,7 @@ handle_fpu_swa (int fp_fault, struct pt_regs *regs, unsigned long isr)
 			}
 			force_sig_fault(SIGFPE, si_code,
 					(void __user *) (regs->cr_iip + ia64_psr(regs)->ri),
-					0, __ISR_VALID, isr, current);
+					0, __ISR_VALID, isr);
 		}
 	} else {
 		if (exception == -1) {
@@ -373,7 +373,7 @@ handle_fpu_swa (int fp_fault, struct pt_regs *regs, unsigned long isr)
 			}
 			force_sig_fault(SIGFPE, si_code,
 					(void __user *) (regs->cr_iip + ia64_psr(regs)->ri),
-					0, __ISR_VALID, isr, current);
+					0, __ISR_VALID, isr);
 		}
 	}
 	return 0;
@@ -408,7 +408,7 @@ ia64_illegal_op_fault (unsigned long ec, long arg1, long arg2, long arg3,
 
 	force_sig_fault(SIGILL, ILL_ILLOPC,
 			(void __user *) (regs.cr_iip + ia64_psr(&regs)->ri),
-			0, 0, 0, current);
+			0, 0, 0);
 	return rv;
 }
 
@@ -483,7 +483,7 @@ ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
 							+ ia64_psr(&regs)->ri);
 			}
 			force_sig_fault(sig, code, addr,
-					vector, __ISR_VALID, isr, current);
+					vector, __ISR_VALID, isr);
 			return;
 		} else if (ia64_done_with_exception(&regs))
 			return;
@@ -493,7 +493,7 @@ ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
 	      case 31: /* Unsupported Data Reference */
 		if (user_mode(&regs)) {
 			force_sig_fault(SIGILL, ILL_ILLOPN, (void __user *) iip,
-					vector, __ISR_VALID, isr, current);
+					vector, __ISR_VALID, isr);
 			return;
 		}
 		sprintf(buf, "Unsupported data reference");
@@ -542,7 +542,7 @@ ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
 			       	== NOTIFY_STOP)
 			return;
 		force_sig_fault(SIGTRAP, si_code, (void __user *) ifa,
-				0, __ISR_VALID, isr, current);
+				0, __ISR_VALID, isr);
 		return;
 
 	      case 32: /* fp fault */
@@ -550,7 +550,7 @@ ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
 		result = handle_fpu_swa((vector == 32) ? 1 : 0, &regs, isr);
 		if ((result < 0) || (current->thread.flags & IA64_THREAD_FPEMU_SIGFPE)) {
 			force_sig_fault(SIGFPE, FPE_FLTINV, (void __user *) iip,
-					0, __ISR_VALID, isr, current);
+					0, __ISR_VALID, isr);
 		}
 		return;
 
@@ -578,7 +578,7 @@ ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
 			if (user_mode(&regs)) {
 				force_sig_fault(SIGILL, ILL_BADIADDR,
 						(void __user *) iip,
-						0, 0, 0, current);
+						0, 0, 0);
 				return;
 			}
 			sprintf(buf, "Unimplemented Instruction Address fault");
diff --git a/arch/ia64/kernel/unaligned.c b/arch/ia64/kernel/unaligned.c
index a167a3824b35..eb7d5df59fa3 100644
--- a/arch/ia64/kernel/unaligned.c
+++ b/arch/ia64/kernel/unaligned.c
@@ -1537,6 +1537,6 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 	}
   force_sigbus:
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) ifa,
-			0, 0, 0, current);
+			0, 0, 0);
 	goto done;
 }
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 5baeb022f474..3c3a283d3172 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -249,7 +249,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	}
 	if (user_mode(regs)) {
 		force_sig_fault(signal, code, (void __user *) address,
-				0, __ISR_VALID, isr, current);
+				0, __ISR_VALID, isr);
 		return;
 	}
 
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 2b6e143abd73..344f93d36a9a 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1127,7 +1127,7 @@ asmlinkage void trap_c(struct frame *fp)
 		addr = (void __user*) fp->un.fmtb.daddr;
 		break;
 	}
-	force_sig_fault(sig, si_code, addr, current);
+	force_sig_fault(sig, si_code, addr);
 }
 
 void die_if_kernel (char *str, struct pt_regs *fp, int nr)
@@ -1159,6 +1159,6 @@ asmlinkage void fpsp040_die(void)
 #ifdef CONFIG_M68KFPU_EMU
 asmlinkage void fpemu_signal(int signal, int code, void *addr)
 {
-	force_sig_fault(signal, code, addr, current);
+	force_sig_fault(signal, code, addr);
 }
 #endif
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 9b6163c05a75..e9b1d7585b43 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -30,13 +30,13 @@ int send_fault_sig(struct pt_regs *regs)
 	pr_debug("send_fault_sig: %p,%d,%d\n", addr, signo, si_code);
 
 	if (user_mode(regs)) {
-		force_sig_fault(signo, si_code, addr, current);
+		force_sig_fault(signo, si_code, addr);
 	} else {
 		if (fixup_exception(regs))
 			return -1;
 
 		//if (signo == SIGBUS)
-		//	force_sig_fault(si_signo, si_code, addr, current);
+		//	force_sig_fault(si_signo, si_code, addr);
 
 		/*
 		 * Oops. The kernel tried to access some bad page. We'll have to
diff --git a/arch/microblaze/kernel/exceptions.c b/arch/microblaze/kernel/exceptions.c
index eafff21fcb0e..cf99c411503e 100644
--- a/arch/microblaze/kernel/exceptions.c
+++ b/arch/microblaze/kernel/exceptions.c
@@ -63,7 +63,7 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	if (kernel_mode(regs))
 		die("Exception in kernel mode", regs, signr);
 
-	force_sig_fault(signr, code, (void __user *)addr, current);
+	force_sig_fault(signr, code, (void __user *)addr);
 }
 
 asmlinkage void full_exception(struct pt_regs *regs, unsigned int type,
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 202ad6a494f5..e6a810b0c7ad 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -289,7 +289,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 do_sigbus:
 	up_read(&mm->mmap_sem);
 	if (user_mode(regs)) {
-		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 		return;
 	}
 	bad_page_fault(regs, address, SIGBUS);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 62df48b6fb46..be4a7b25269c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -705,7 +705,7 @@ asmlinkage void do_ov(struct pt_regs *regs)
 	prev_state = exception_enter();
 	die_if_kernel("Integer overflow", regs);
 
-	force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->cp0_epc, current);
+	force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->cp0_epc);
 	exception_exit(prev_state);
 }
 
@@ -750,7 +750,7 @@ int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 		return 1;
 
 	case SIGBUS:
-		force_sig_fault(SIGBUS, BUS_ADRERR, fault_addr, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, fault_addr);
 		return 1;
 
 	case SIGSEGV:
@@ -761,7 +761,7 @@ int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 		else
 			si_code = SEGV_MAPERR;
 		up_read(&current->mm->mmap_sem);
-		force_sig_fault(SIGSEGV, si_code, fault_addr, current);
+		force_sig_fault(SIGSEGV, si_code, fault_addr);
 		return 1;
 
 	default:
@@ -943,7 +943,7 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 		die_if_kernel(b, regs);
 		force_sig_fault(SIGFPE,
 				code == BRK_DIVZERO ? FPE_INTDIV : FPE_INTOVF,
-				(void __user *) regs->cp0_epc, current);
+				(void __user *) regs->cp0_epc);
 		break;
 	case BRK_BUG:
 		die_if_kernel("Kernel bug detected", regs);
@@ -968,7 +968,7 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 		scnprintf(b, sizeof(b), "%s instruction in kernel code", str);
 		die_if_kernel(b, regs);
 		if (si_code) {
-			force_sig_fault(SIGTRAP, si_code, NULL,	current);
+			force_sig_fault(SIGTRAP, si_code, NULL);
 		} else {
 			force_sig(SIGTRAP);
 		}
@@ -1521,7 +1521,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
 		mips_read_watch_registers();
 		local_irq_enable();
-		force_sig_fault(SIGTRAP, TRAP_HWBKPT, NULL, current);
+		force_sig_fault(SIGTRAP, TRAP_HWBKPT, NULL);
 	} else {
 		mips_clear_watch_registers();
 		local_irq_enable();
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index e63abd492f65..f589aa8f47d9 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -223,7 +223,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 			pr_cont("\n");
 		}
 		current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 		return;
 	}
 
@@ -279,7 +279,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 #endif
 	current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
 	tsk->thread.cp0_badvaddr = address;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 
 	return;
 #ifndef CONFIG_64BIT
diff --git a/arch/nds32/kernel/fpu.c b/arch/nds32/kernel/fpu.c
index fddd40c7a16f..1f8694c6bd5a 100644
--- a/arch/nds32/kernel/fpu.c
+++ b/arch/nds32/kernel/fpu.c
@@ -246,7 +246,7 @@ inline void handle_fpu_exception(struct pt_regs *regs)
 	}
 
 	force_sig_fault(si_signo, si_code,
-			(void __user *)instruction_pointer(regs), current);
+			(void __user *)instruction_pointer(regs));
 done:
 	own_fpu();
 }
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index a16e97f7bc75..f4d386b52622 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -205,7 +205,7 @@ int bad_syscall(int n, struct pt_regs *regs)
 	}
 
 	force_sig_fault(SIGILL, ILL_ILLTRP,
-			(void __user *)instruction_pointer(regs) - 4, current);
+			(void __user *)instruction_pointer(regs) - 4);
 	die_if_kernel("Oops - bad syscall", regs, n);
 	return regs->uregs[0];
 }
@@ -263,7 +263,7 @@ static void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
 	tsk->thread.error_code = error_code;
 
 	force_sig_fault(SIGTRAP, si_code,
-			(void __user *)instruction_pointer(regs), current);
+			(void __user *)instruction_pointer(regs));
 }
 
 void do_debug_trap(unsigned long entry, unsigned long addr,
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 38441113c202..064ae5d2159d 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -271,7 +271,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 		tsk->thread.address = addr;
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = entry;
-		force_sig_fault(SIGSEGV, si_code, (void __user *)addr, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)addr);
 		return;
 	}
 
@@ -340,7 +340,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = entry;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr);
 
 	return;
 
diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index 3bc3cd22b750..486db793923c 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -26,7 +26,7 @@ static DEFINE_SPINLOCK(die_lock);
 
 static void _send_sig(int signo, int code, unsigned long addr)
 {
-	force_sig_fault(signo, code, (void __user *) addr, current);
+	force_sig_fault(signo, code, (void __user *) addr);
 }
 
 void die(const char *str, struct pt_regs *regs, long err)
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 0fad2e46ff43..a4cc6e59c57f 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -249,7 +249,7 @@ void __init trap_init(void)
 
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
-	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address, current);
+	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address);
 
 	regs->pc += 4;
 }
@@ -258,7 +258,7 @@ asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 {
 	if (user_mode(regs)) {
 		/* Send a SIGBUS */
-		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)address, current);
+		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)address);
 	} else {
 		printk("KERNEL: Unaligned Access 0x%.8lx\n", address);
 		show_registers(regs);
@@ -271,7 +271,7 @@ asmlinkage void do_bus_fault(struct pt_regs *regs, unsigned long address)
 {
 	if (user_mode(regs)) {
 		/* Send a SIGBUS */
-		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 	} else {		/* Kernel mode */
 		printk("KERNEL: Bus error (SIGBUS) 0x%.8lx\n", address);
 		show_registers(regs);
@@ -466,7 +466,7 @@ asmlinkage void do_illegal_instruction(struct pt_regs *regs,
 
 	if (user_mode(regs)) {
 		/* Send a SIGILL */
-		force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)address, current);
+		force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)address);
 	} else {		/* Kernel mode */
 		printk("KERNEL: Illegal instruction (SIGILL) 0x%.8lx\n",
 		       address);
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 096e319adeb3..58dcf445e32f 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -275,7 +275,7 @@ void die_if_kernel(char *str, struct pt_regs *regs, long err)
 static void handle_gdb_break(struct pt_regs *regs, int wot)
 {
 	force_sig_fault(SIGTRAP, wot,
-			(void __user *) (regs->iaoq[0] & ~3), current);
+			(void __user *) (regs->iaoq[0] & ~3));
 }
 
 static void handle_break(struct pt_regs *regs)
@@ -609,13 +609,13 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 		si_code = ILL_PRVREG;
 	give_sigill:
 		force_sig_fault(SIGILL, si_code,
-				(void __user *) regs->iaoq[0], current);
+				(void __user *) regs->iaoq[0]);
 		return;
 
 	case 12:
 		/* Overflow Trap, let the userland signal handler do the cleanup */
 		force_sig_fault(SIGFPE, FPE_INTOVF,
-				(void __user *) regs->iaoq[0], current);
+				(void __user *) regs->iaoq[0]);
 		return;
 		
 	case 13:
@@ -627,7 +627,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 			 * to by si_addr.
 			 */
 			force_sig_fault(SIGFPE, FPE_CONDTRAP,
-					(void __user *) regs->iaoq[0], current);
+					(void __user *) regs->iaoq[0]);
 			return;
 		} 
 		/* The kernel doesn't want to handle condition codes */
@@ -739,7 +739,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 		force_sig_fault(SIGSEGV, SEGV_MAPERR,
 				(code == 7)?
 				((void __user *) regs->iaoq[0]) :
-				((void __user *) regs->ior), current);
+				((void __user *) regs->ior));
 		return;
 
 	case 28: 
@@ -754,7 +754,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 				task_pid_nr(current), current->comm);
 			/* SIGBUS, for lack of a better one. */
 			force_sig_fault(SIGBUS, BUS_OBJERR,
-					(void __user *)regs->ior, current);
+					(void __user *)regs->ior);
 			return;
 		}
 		pdc_chassis_send_status(PDC_CHASSIS_DIRECT_PANIC);
@@ -770,7 +770,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 				code, fault_space,
 				task_pid_nr(current), current->comm);
 		force_sig_fault(SIGSEGV, SEGV_MAPERR,
-				(void __user *)regs->ior, current);
+				(void __user *)regs->ior);
 		return;
 	    }
 	}
diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index 932bfc0b7cd8..3ccc3a69469c 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -690,14 +690,14 @@ void handle_unaligned(struct pt_regs *regs)
 		if (ret == ERR_PAGEFAULT)
 		{
 			force_sig_fault(SIGSEGV, SEGV_MAPERR,
-					(void __user *)regs->ior, current);
+					(void __user *)regs->ior);
 		}
 		else
 		{
 force_sigbus:
 			/* couldn't handle it ... */
 			force_sig_fault(SIGBUS, BUS_ADRALN,
-					(void __user *)regs->ior, current);
+					(void __user *)regs->ior);
 		}
 		
 		return;
diff --git a/arch/parisc/math-emu/driver.c b/arch/parisc/math-emu/driver.c
index 0590e05571d1..f3e0bddcbb38 100644
--- a/arch/parisc/math-emu/driver.c
+++ b/arch/parisc/math-emu/driver.c
@@ -117,7 +117,7 @@ handle_fpe(struct pt_regs *regs)
 	memcpy(regs->fr, frcopy, sizeof regs->fr);
 	if (signalcode != 0) {
 	    force_sig_fault(signalcode >> 24, signalcode & 0xffffff,
-			    (void __user *) regs->iaoq[0], current);
+			    (void __user *) regs->iaoq[0]);
 	    return -1;
 	}
 
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 56ceacb3401d..6dd4669ce7a5 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -409,7 +409,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 #endif
 		show_signal_msg(regs, code, address, tsk, vma);
 
-		force_sig_fault(signo, si_code, (void __user *) address, current);
+		force_sig_fault(signo, si_code, (void __user *) address);
 		return;
 	}
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 87da40129927..1b5b1477afa2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -643,7 +643,7 @@ void do_break (struct pt_regs *regs, unsigned long address,
 	hw_breakpoint_disable();
 
 	/* Deliver the signal to userspace */
-	force_sig_fault(SIGTRAP, TRAP_HWBKPT, (void __user *)address, current);
+	force_sig_fault(SIGTRAP, TRAP_HWBKPT, (void __user *)address);
 }
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 83e59fdaa62d..dfc61f2f69a0 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -301,7 +301,7 @@ NOKPROBE_SYMBOL(die);
 
 void user_single_step_report(struct pt_regs *regs)
 {
-	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)regs->nip, current);
+	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)regs->nip);
 }
 
 static void show_signal_msg(int signr, struct pt_regs *regs, int code,
@@ -367,7 +367,7 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	if (!exception_common(signr, regs, code, addr))
 		return;
 
-	force_sig_fault(signr, code, (void __user *)addr, current);
+	force_sig_fault(signr, code, (void __user *)addr);
 }
 
 /*
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 6ed6c341c670..02c70fa535ef 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -187,7 +187,7 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 	}
 
 #endif
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
index 971ac43b5d60..6634c0c5ed9e 100644
--- a/arch/powerpc/platforms/cell/spufs/fault.c
+++ b/arch/powerpc/platforms/cell/spufs/fault.c
@@ -44,22 +44,21 @@ static void spufs_handle_event(struct spu_context *ctx,
 
 	switch (type) {
 	case SPE_EVENT_INVALID_DMA:
-		force_sig_fault(SIGBUS, BUS_OBJERR, NULL, current);
+		force_sig_fault(SIGBUS, BUS_OBJERR, NULL);
 		break;
 	case SPE_EVENT_SPE_DATA_STORAGE:
 		ctx->ops->restart_dma(ctx);
-		force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *)ea,
-				current);
+		force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *)ea);
 		break;
 	case SPE_EVENT_DMA_ALIGNMENT:
 		/* DAR isn't set for an alignment fault :( */
-		force_sig_fault(SIGBUS, BUS_ADRALN, NULL, current);
+		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
 		break;
 	case SPE_EVENT_SPE_ERROR:
 		force_sig_fault(
 			SIGILL, ILL_ILLOPC,
 			(void __user *)(unsigned long)
-			ctx->ops->npc_read(ctx) - 4, current);
+			ctx->ops->npc_read(ctx) - 4);
 		break;
 	}
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 6d67892dfc82..859ab550d52a 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -76,7 +76,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		show_regs(regs);
 	}
 
-	force_sig_fault(signo, code, (void __user *)addr, current);
+	force_sig_fault(signo, code, (void __user *)addr);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -149,7 +149,7 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 	}
 #endif /* CONFIG_GENERIC_BUG */
 
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc), current);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc));
 }
 
 #ifdef CONFIG_GENERIC_BUG
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 82e81a9f7112..ac44dbfc4a7e 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -45,7 +45,7 @@ int is_valid_bugaddr(unsigned long addr)
 void do_report_trap(struct pt_regs *regs, int si_signo, int si_code, char *str)
 {
 	if (user_mode(regs)) {
-		force_sig_fault(si_signo, si_code, get_trap_ip(regs), current);
+		force_sig_fault(si_signo, si_code, get_trap_ip(regs));
 		report_user_fault(regs, si_signo, 0);
         } else {
                 const struct exception_table_entry *fixup;
@@ -79,7 +79,7 @@ void do_per_trap(struct pt_regs *regs)
 	if (!current->ptrace)
 		return;
 	force_sig_fault(SIGTRAP, TRAP_HWBKPT,
-		(void __force __user *) current->thread.per_event.address, current);
+		(void __force __user *) current->thread.per_event.address);
 }
 NOKPROBE_SYMBOL(do_per_trap);
 
@@ -165,7 +165,7 @@ void illegal_op(struct pt_regs *regs)
 			return;
 		if (*((__u16 *) opcode) == S390_BREAKPOINT_U16) {
 			if (current->ptrace)
-				force_sig_fault(SIGTRAP, TRAP_BRKPT, location, current);
+				force_sig_fault(SIGTRAP, TRAP_BRKPT, location);
 			else
 				signal = SIGILL;
 #ifdef CONFIG_UPROBES
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index c220399ae196..79afed544cac 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -243,8 +243,7 @@ static noinline void do_sigsegv(struct pt_regs *regs, int si_code)
 {
 	report_user_fault(regs, SIGSEGV, 1);
 	force_sig_fault(SIGSEGV, si_code,
-			(void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK),
-			current);
+			(void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK));
 }
 
 const struct exception_table_entry *s390_search_extables(unsigned long addr)
@@ -305,8 +304,7 @@ static noinline void do_sigbus(struct pt_regs *regs)
 	 * or user mode.
 	 */
 	force_sig_fault(SIGBUS, BUS_ADRERR,
-			(void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK),
-			current);
+			(void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK));
 }
 
 static noinline int signal_return(struct pt_regs *regs)
diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index bc96b16288c1..3bd010b4c55f 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -338,7 +338,7 @@ static int __kprobes hw_breakpoint_handler(struct die_args *args)
 		/* Deliver the signal to userspace */
 		if (!arch_check_bp_in_kernelspace(&bp->hw.info)) {
 			force_sig_fault(SIGTRAP, TRAP_HWBKPT,
-					(void __user *)NULL, current);
+					(void __user *)NULL);
 		}
 
 		rcu_read_unlock();
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index bd5568c8e7f0..d3b2c1373a2d 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -533,7 +533,7 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 		       "access (PC %lx PR %lx)\n", current->comm, regs->pc,
 		       regs->pr);
 
-		force_sig_fault(SIGBUS, si_code, (void __user *)address, current);
+		force_sig_fault(SIGBUS, si_code, (void __user *)address);
 	} else {
 		inc_unaligned_kernel_access();
 
diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index fe261b0983cc..e8be0eca0444 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -560,7 +560,7 @@ static int ieee_fpe_handler(struct pt_regs *regs)
 			task_thread_info(tsk)->status |= TS_USEDFPU;
 		} else {
 			force_sig_fault(SIGFPE, FPE_FLTINV,
-					(void __user *)regs->pc, current);
+					(void __user *)regs->pc);
 		}
 
 		regs->pc = nextpc;
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 851a3cbb2b9c..3093bc372138 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -41,7 +41,7 @@ static inline int notify_page_fault(struct pt_regs *regs, int trap)
 static void
 force_sig_info_fault(int si_signo, int si_code, unsigned long address)
 {
-	force_sig_fault(si_signo, si_code, (void __user *)address, current);
+	force_sig_fault(si_signo, si_code, (void __user *)address);
 }
 
 /*
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index c4bccd97f3cf..4282116e28e7 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -519,7 +519,7 @@ void synchronize_user_stack(void)
 
 static void stack_unaligned(unsigned long sp)
 {
-	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp, 0, current);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp, 0);
 }
 
 static const char uwfault32[] = KERN_INFO \
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 452e4d080855..be77538bc038 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -151,7 +151,7 @@ sparc_breakpoint (struct pt_regs *regs)
 #ifdef DEBUG_SPARC_BREAKPOINT
         printk ("TRAP: Entering kernel PC=%x, nPC=%x\n", regs->pc, regs->npc);
 #endif
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc, 0, current);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc, 0);
 
 #ifdef DEBUG_SPARC_BREAKPOINT
 	printk ("TRAP: Returning to space: PC=%x nPC=%x\n", regs->pc, regs->npc);
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 9825ca6a6020..ccc88926bc00 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -511,7 +511,7 @@ asmlinkage void sparc_breakpoint(struct pt_regs *regs)
 #ifdef DEBUG_SPARC_BREAKPOINT
         printk ("TRAP: Entering kernel PC=%lx, nPC=%lx\n", regs->tpc, regs->tnpc);
 #endif
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->tpc, 0, current);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->tpc, 0);
 #ifdef DEBUG_SPARC_BREAKPOINT
 	printk ("TRAP: Returning to space: PC=%lx nPC=%lx\n", regs->tpc, regs->tnpc);
 #endif
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index bcdfc6168dd5..4ceecad556a9 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -103,7 +103,7 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 		die_if_kernel("Kernel bad trap", regs);
 
 	force_sig_fault(SIGILL, ILL_ILLTRP,
-			(void __user *)regs->pc, type - 0x80, current);
+			(void __user *)regs->pc, type - 0x80);
 }
 
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
@@ -327,7 +327,7 @@ void handle_reg_access(struct pt_regs *regs, unsigned long pc, unsigned long npc
 	printk("Register Access Exception at PC %08lx NPC %08lx PSR %08lx\n",
 	       pc, npc, psr);
 #endif
-	force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)pc, 0, current);
+	force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)pc, 0);
 }
 
 void handle_cp_disabled(struct pt_regs *regs, unsigned long pc, unsigned long npc,
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 12bfc7e215ca..614d92c18506 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -107,7 +107,7 @@ void bad_trap(struct pt_regs *regs, long lvl)
 		regs->tnpc &= 0xffffffff;
 	}
 	force_sig_fault(SIGILL, ILL_ILLTRP,
-			(void __user *)regs->tpc, lvl, current);
+			(void __user *)regs->tpc, lvl);
 }
 
 void bad_trap_tl1(struct pt_regs *regs, long lvl)
@@ -201,7 +201,7 @@ void spitfire_insn_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 		regs->tnpc &= 0xffffffff;
 	}
 	force_sig_fault(SIGSEGV, SEGV_MAPERR,
-			(void __user *)regs->tpc, 0, current);
+			(void __user *)regs->tpc, 0);
 out:
 	exception_exit(prev_state);
 }
@@ -236,7 +236,7 @@ void sun4v_insn_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *) addr, 0, current);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *) addr, 0);
 }
 
 void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, unsigned long type_ctx)
@@ -321,7 +321,7 @@ void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 	if (is_no_fault_exception(regs))
 		return;
 
-	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)sfar, 0, current);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)sfar, 0);
 out:
 	exception_exit(prev_state);
 }
@@ -385,16 +385,13 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 	 */
 	switch (type) {
 	case HV_FAULT_TYPE_INV_ASI:
-		force_sig_fault(SIGILL, ILL_ILLADR, (void __user *)addr, 0,
-				current);
+		force_sig_fault(SIGILL, ILL_ILLADR, (void __user *)addr, 0);
 		break;
 	case HV_FAULT_TYPE_MCD_DIS:
-		force_sig_fault(SIGSEGV, SEGV_ACCADI, (void __user *)addr, 0,
-				current);
+		force_sig_fault(SIGSEGV, SEGV_ACCADI, (void __user *)addr, 0);
 		break;
 	default:
-		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr, 0,
-				current);
+		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr, 0);
 		break;
 	}
 }
@@ -571,7 +568,7 @@ static void spitfire_ue_log(unsigned long afsr, unsigned long afar, unsigned lon
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGBUS, BUS_OBJERR, (void *)0, 0, current);
+	force_sig_fault(SIGBUS, BUS_OBJERR, (void *)0, 0);
 }
 
 void spitfire_access_error(struct pt_regs *regs, unsigned long status_encoded, unsigned long afar)
@@ -2073,7 +2070,7 @@ void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
 	 * code
 	 */
 	force_sig_fault(SIGSEGV, SEGV_ADIDERR, (void __user *)ent.err_raddr,
-			0, current);
+			0);
 }
 
 /* We run with %pil set to PIL_NORMAL_MAX and PSTATE_IE enabled in %pstate.
@@ -2187,7 +2184,7 @@ bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
 	}
 	if (attrs & SUN4V_ERR_ATTRS_PIO) {
 		force_sig_fault(SIGBUS, BUS_ADRERR,
-				(void __user *)sun4v_get_vaddr(regs), 0, current);
+				(void __user *)sun4v_get_vaddr(regs), 0);
 		return true;
 	}
 
@@ -2344,7 +2341,7 @@ static void do_fpe_common(struct pt_regs *regs)
 				code = FPE_FLTRES;
 		}
 		force_sig_fault(SIGFPE, code,
-				(void __user *)regs->tpc, 0, current);
+				(void __user *)regs->tpc, 0);
 	}
 }
 
@@ -2399,7 +2396,7 @@ void do_tof(struct pt_regs *regs)
 		regs->tnpc &= 0xffffffff;
 	}
 	force_sig_fault(SIGEMT, EMT_TAGOVF,
-			(void __user *)regs->tpc, 0, current);
+			(void __user *)regs->tpc, 0);
 out:
 	exception_exit(prev_state);
 }
@@ -2419,7 +2416,7 @@ void do_div0(struct pt_regs *regs)
 		regs->tnpc &= 0xffffffff;
 	}
 	force_sig_fault(SIGFPE, FPE_INTDIV,
-			(void __user *)regs->tpc, 0, current);
+			(void __user *)regs->tpc, 0);
 out:
 	exception_exit(prev_state);
 }
@@ -2615,7 +2612,7 @@ void do_illegal_instruction(struct pt_regs *regs)
 			}
 		}
 	}
-	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, 0, current);
+	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, 0);
 out:
 	exception_exit(prev_state);
 }
@@ -2635,7 +2632,7 @@ void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned lo
 	if (is_no_fault_exception(regs))
 		return;
 
-	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)sfar, 0, current);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)sfar, 0);
 out:
 	exception_exit(prev_state);
 }
@@ -2653,7 +2650,7 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
 	if (is_no_fault_exception(regs))
 		return;
 
-	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) addr, 0, current);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) addr, 0);
 }
 
 /* sun4v_mem_corrupt_detect_precise() - Handle precise exception on an ADI
@@ -2700,7 +2697,7 @@ void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGSEGV, SEGV_ADIPERR, (void __user *)addr, 0, current);
+	force_sig_fault(SIGSEGV, SEGV_ADIPERR, (void __user *)addr, 0);
 }
 
 void do_privop(struct pt_regs *regs)
@@ -2716,7 +2713,7 @@ void do_privop(struct pt_regs *regs)
 		regs->tnpc &= 0xffffffff;
 	}
 	force_sig_fault(SIGILL, ILL_PRVOPC,
-			(void __user *)regs->tpc, 0, current);
+			(void __user *)regs->tpc, 0);
 out:
 	exception_exit(prev_state);
 }
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 2731faf415ba..8d69de111470 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -131,7 +131,7 @@ static void __do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 		show_signal_msg(regs, sig, code,
 				addr, current);
 
-	force_sig_fault(sig, code, (void __user *) addr, 0, current);
+	force_sig_fault(sig, code, (void __user *) addr, 0);
 }
 
 static unsigned long compute_si_addr(struct pt_regs *regs, int text_fault)
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 8f8a604c1300..83fda4d9c3b2 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -187,7 +187,7 @@ static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 	if (unlikely(show_unhandled_signals))
 		show_signal_msg(regs, sig, code, addr, current);
 
-	force_sig_fault(sig, code, (void __user *) addr, 0, current);
+	force_sig_fault(sig, code, (void __user *) addr, 0);
 }
 
 static unsigned int get_fault_insn(struct pt_regs *regs, unsigned int insn)
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 1797dfe9ce6d..da1e96b1ec3e 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -117,8 +117,7 @@ static void send_sigtrap(struct uml_pt_regs *regs, int error_code)
 	/* Send us the fake SIGTRAP */
 	force_sig_fault(SIGTRAP, TRAP_BRKPT,
 			/* User-mode eip? */
-			UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL,
-			current);
+			UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL);
 }
 
 /*
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 1c943c66063f..58fe36856182 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -163,8 +163,7 @@ static void show_segv_info(struct uml_pt_regs *regs)
 static void bad_segv(struct faultinfo fi, unsigned long ip)
 {
 	current->thread.arch.faultinfo = fi;
-	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *) FAULT_ADDRESS(fi),
-			current);
+	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *) FAULT_ADDRESS(fi));
 }
 
 void fatal_sigsegv(void)
@@ -268,13 +267,11 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 
 	if (err == -EACCES) {
 		current->thread.arch.faultinfo = fi;
-		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address,
-				current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 	} else {
 		BUG_ON(err != -EFAULT);
 		current->thread.arch.faultinfo = fi;
-		force_sig_fault(SIGSEGV, si_code, (void __user *) address,
-				current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *) address);
 	}
 
 out:
@@ -304,8 +301,7 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 	if ((err == 0) && (siginfo_layout(sig, code) == SIL_FAULT)) {
 		struct faultinfo *fi = UPT_FAULTINFO(regs);
 		current->thread.arch.faultinfo = *fi;
-		force_sig_fault(sig, code, (void __user *)FAULT_ADDRESS(*fi),
-				current);
+		force_sig_fault(sig, code, (void __user *)FAULT_ADDRESS(*fi));
 	} else {
 		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code = %d) with errno %d\n",
 		       sig, code, err);
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index fb376d83e043..a0878035cda7 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -248,7 +248,7 @@ void uc32_notify_die(const char *str, struct pt_regs *regs,
 		current->thread.error_code = err;
 		current->thread.trap_no = trap;
 
-		force_sig_fault(sig, code, addr, current);
+		force_sig_fault(sig, code, addr);
 	} else
 		die(str, regs, err);
 }
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 313547a93513..c85ba5339c1f 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -124,7 +124,7 @@ static void __do_user_fault(unsigned long addr, unsigned int fsr,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	force_sig_fault(sig, code, (void __user *)addr, current);
+	force_sig_fault(sig, code, (void __user *)addr);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 7ea87f4ad0b7..2f31faf339d5 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -106,7 +106,7 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 		thread->cr2		= ptr;
 		thread->trap_nr		= X86_TRAP_PF;
 
-		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)ptr, current);
+		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)ptr);
 		return false;
 	} else {
 		return true;
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 34d27b2dc7a1..8f8f197389db 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1369,7 +1369,7 @@ void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
 
 	/* Send us the fake SIGTRAP */
 	force_sig_fault(SIGTRAP, si_code,
-			user_mode(regs) ? (void __user *)regs->ip : NULL, current);
+			user_mode(regs) ? (void __user *)regs->ip : NULL);
 }
 
 void user_single_step_report(struct pt_regs *regs)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 945b9a0719dd..87095a477154 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -256,7 +256,7 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 	if (!sicode)
 		force_sig(signr);
 	else
-		force_sig_fault(signr, sicode, addr, current);
+		force_sig_fault(signr, sicode, addr);
 }
 NOKPROBE_SYMBOL(do_trap);
 
@@ -856,7 +856,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 		return;
 
 	force_sig_fault(SIGFPE, si_code,
-			(void __user *)uprobe_get_trap_addr(regs), current);
+			(void __user *)uprobe_get_trap_addr(regs));
 }
 
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 68cdcd717c85..5b345add550f 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -277,7 +277,7 @@ static void force_sig_info_umip_fault(void __user *addr, struct pt_regs *regs)
 	tsk->thread.error_code	= X86_PF_USER | X86_PF_WRITE;
 	tsk->thread.trap_nr	= X86_TRAP_PF;
 
-	force_sig_fault(SIGSEGV, SEGV_MAPERR, addr, current);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, addr);
 
 	if (!(show_unhandled_signals && unhandled_signal(tsk, SIGSEGV)))
 		return;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 16a5d1b615a7..46ac96aa7c81 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -756,8 +756,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 			set_signal_archinfo(address, error_code);
 
 			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_fault(signal, si_code, (void __user *)address,
-					current);
+			force_sig_fault(signal, si_code, (void __user *)address);
 		}
 
 		/*
@@ -918,7 +917,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		if (si_code == SEGV_PKUERR)
 			force_sig_pkuerr((void __user *)address, pkey);
 
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 
 		return;
 	}
@@ -1044,7 +1043,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		return;
 	}
 #endif
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
 static noinline void
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 6f26b254091b..f060348c1b23 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -330,7 +330,7 @@ do_unaligned_user (struct pt_regs *regs)
 			    "(pid = %d, pc = %#010lx)\n",
 			    regs->excvaddr, current->comm,
 			    task_pid_nr(current), regs->pc);
-	force_sig_fault(SIGBUS, BUS_ADRALN, (void *) regs->excvaddr, current);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void *) regs->excvaddr);
 }
 #endif
 
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 2ab0e0dcd166..f81b1478da61 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -157,7 +157,7 @@ void do_page_fault(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		current->thread.bad_vaddr = address;
 		current->thread.error_code = is_write;
-		force_sig_fault(SIGSEGV, code, (void *) address, current);
+		force_sig_fault(SIGSEGV, code, (void *) address);
 		return;
 	}
 	bad_page_fault(regs, address, SIGSEGV);
@@ -182,7 +182,7 @@ void do_page_fault(struct pt_regs *regs)
 	 * or user mode.
 	 */
 	current->thread.bad_vaddr = address;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void *) address, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void *) address);
 
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 507af66a1fc8..7f872506e1de 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -313,8 +313,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 	, struct task_struct *t);
 int force_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
-	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
-	, struct task_struct *t);
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr));
 int send_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
diff --git a/kernel/signal.c b/kernel/signal.c
index e420489ac4c9..d92b636b4e9d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1645,12 +1645,11 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 
 int force_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
-	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
-	, struct task_struct *t)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr))
 {
 	return force_sig_fault_to_task(sig, code, addr
 				       ___ARCH_SI_TRAPNO(trapno)
-				       ___ARCH_SI_IA64(imm, flags, isr), t);
+				       ___ARCH_SI_IA64(imm, flags, isr), current);
 }
 
 int send_sig_fault(int sig, int code, void __user *addr
-- 
2.21.0

