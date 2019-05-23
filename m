Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203B0273FB
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfEWB25 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:28:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52996 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWB25 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:28:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnC-0002Du-Ii; Wed, 22 May 2019 18:41:10 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbn6-0005Z3-Np; Wed, 22 May 2019 18:41:10 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:38:59 -0500
Message-Id: <20190523003916.20726-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbn6-0005Z3-Np;;;mid=<20190523003916.20726-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18d9QLkZqYTYGo5XEr2ufK2jcuJizlGm4g=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *******
X-Spam-Status: No, score=7.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,TR_Symld_Words,T_TooManySym_01,
        T_XMDrugObfuBody_08,XMNoVowels,XMSubLong,XM_Body_Dirty_Words,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *******;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 4748 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.1%), b_tie_ro: 2.0 (0.0%), parse: 3.3
        (0.1%), extract_message_metadata: 38 (0.8%), get_uri_detail_list: 27
        (0.6%), tests_pri_-1000: 13 (0.3%), tests_pri_-950: 1.51 (0.0%),
        tests_pri_-900: 1.27 (0.0%), tests_pri_-90: 147 (3.1%), check_bayes:
        144 (3.0%), b_tokenize: 96 (2.0%), b_tok_get_all: 30 (0.6%),
        b_comp_prob: 7 (0.1%), b_tok_touch_all: 8 (0.2%), b_finish: 0.79
        (0.0%), tests_pri_0: 4515 (95.1%), check_dkim_signature: 2.2 (0.0%),
        check_dkim_adsp: 3.1 (0.1%), poll_dns_idle: 1.17 (0.0%), tests_pri_10:
        5 (0.1%), tests_pri_500: 12 (0.2%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 09/26] signal: Remove task parameter from force_sig
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All of the remaining callers pass current into force_sig so
remove the task parameter to make this obvious and to make
misuse more difficult in the future.

This also makes it clear force_sig passes current into force_sig_info.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/signal.c              |  4 +--
 arch/arc/kernel/process.c               |  2 +-
 arch/arc/kernel/signal.c                |  2 +-
 arch/arm/kernel/signal.c                |  4 +--
 arch/arm64/kernel/traps.c               |  2 +-
 arch/c6x/kernel/signal.c                |  2 +-
 arch/csky/kernel/signal.c               |  4 +--
 arch/h8300/kernel/ptrace_h.c            |  4 +--
 arch/h8300/kernel/ptrace_s.c            |  2 +-
 arch/h8300/kernel/signal.c              |  2 +-
 arch/hexagon/kernel/signal.c            |  2 +-
 arch/hexagon/kernel/traps.c             | 10 +++----
 arch/ia64/kernel/signal.c               |  2 +-
 arch/ia64/kernel/traps.c                |  6 ++---
 arch/m68k/kernel/signal.c               |  4 +--
 arch/m68k/kernel/traps.c                | 16 +++++------
 arch/microblaze/kernel/signal.c         |  2 +-
 arch/mips/kernel/branch.c               | 18 ++++++-------
 arch/mips/kernel/kprobes.c              |  2 +-
 arch/mips/kernel/signal.c               |  8 +++---
 arch/mips/kernel/signal_n32.c           |  4 +--
 arch/mips/kernel/signal_o32.c           |  8 +++---
 arch/mips/kernel/traps.c                | 36 ++++++++++++-------------
 arch/mips/kernel/unaligned.c            | 20 +++++++-------
 arch/mips/sgi-ip22/ip22-berr.c          |  2 +-
 arch/mips/sgi-ip22/ip28-berr.c          |  2 +-
 arch/mips/sgi-ip27/ip27-berr.c          |  2 +-
 arch/mips/sgi-ip32/ip32-berr.c          |  2 +-
 arch/nds32/kernel/signal.c              |  2 +-
 arch/nds32/kernel/traps.c               |  6 ++---
 arch/nios2/kernel/signal.c              |  2 +-
 arch/openrisc/kernel/signal.c           |  2 +-
 arch/openrisc/kernel/traps.c            |  4 +--
 arch/parisc/kernel/signal.c             |  2 +-
 arch/powerpc/kernel/signal_32.c         |  6 ++---
 arch/powerpc/kernel/signal_64.c         |  2 +-
 arch/powerpc/platforms/cell/spufs/run.c |  2 +-
 arch/riscv/kernel/signal.c              |  2 +-
 arch/s390/kernel/compat_signal.c        |  4 +--
 arch/s390/kernel/signal.c               |  4 +--
 arch/sh/kernel/cpu/sh2a/fpu.c           |  2 +-
 arch/sh/kernel/cpu/sh4/fpu.c            |  2 +-
 arch/sh/kernel/cpu/sh5/fpu.c            |  4 +--
 arch/sh/kernel/ptrace_64.c              |  4 +--
 arch/sh/kernel/signal_32.c              |  4 +--
 arch/sh/kernel/signal_64.c              |  4 +--
 arch/sh/kernel/traps.c                  |  4 +--
 arch/sh/kernel/traps_32.c               |  8 +++---
 arch/sh/kernel/traps_64.c               |  2 +-
 arch/sparc/kernel/process_64.c          |  2 +-
 arch/sparc/kernel/signal32.c            |  4 +--
 arch/sparc/kernel/signal_32.c           |  4 +--
 arch/sparc/kernel/signal_64.c           |  6 ++---
 arch/sparc/kernel/traps_64.c            |  2 +-
 arch/sparc/mm/fault_32.c                |  2 +-
 arch/um/kernel/exec.c                   |  2 +-
 arch/um/kernel/tlb.c                    |  4 +--
 arch/um/kernel/trap.c                   |  2 +-
 arch/unicore32/kernel/signal.c          |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c   |  2 +-
 arch/x86/kernel/cpu/mce/core.c          |  2 +-
 arch/x86/kernel/signal.c                |  2 +-
 arch/x86/kernel/traps.c                 |  4 +--
 arch/x86/kernel/uprobes.c               |  2 +-
 arch/x86/kernel/vm86_32.c               |  2 +-
 arch/x86/mm/mpx.c                       |  2 +-
 arch/x86/um/signal.c                    |  4 +--
 arch/xtensa/kernel/signal.c             |  2 +-
 arch/xtensa/kernel/traps.c              |  6 ++---
 drivers/misc/lkdtm/bugs.c               |  2 +-
 include/linux/sched/signal.h            |  2 +-
 include/linux/syscalls.h                |  2 +-
 kernel/events/uprobes.c                 |  4 +--
 kernel/rseq.c                           |  2 +-
 kernel/signal.c                         |  6 ++---
 security/safesetid/lsm.c                |  4 +--
 76 files changed, 160 insertions(+), 166 deletions(-)

diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index 33e904a05881..a813020d2f11 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -225,7 +225,7 @@ do_sigreturn(struct sigcontext __user *sc)
 	return;
 
 give_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 asmlinkage void
@@ -253,7 +253,7 @@ do_rt_sigreturn(struct rt_sigframe __user *frame)
 	return;
 
 give_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 725e556678a4..deee16d5c03f 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -100,7 +100,7 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
 		 goto again;
 
 fail:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return ret;
 }
 
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 1bfb7de696bd..547c8f0cdc3a 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -197,7 +197,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return regs->r0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index be5edfdde558..3870e0588d53 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -250,7 +250,7 @@ asmlinkage int sys_sigreturn(struct pt_regs *regs)
 	return regs->ARM_r0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
@@ -283,7 +283,7 @@ asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
 	return regs->ARM_r0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0feb17bdcaa0..39a391adf222 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -284,7 +284,7 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 
 		if (signo == SIGKILL) {
 			arm64_show_signal(signo, str);
-			force_sig(signo, current);
+			force_sig(signo);
 			return;
 		}
 		arm64_force_sig_fault(signo, sicode, addr, str);
diff --git a/arch/c6x/kernel/signal.c b/arch/c6x/kernel/signal.c
index 33b9f69c38f7..775de34b233a 100644
--- a/arch/c6x/kernel/signal.c
+++ b/arch/c6x/kernel/signal.c
@@ -93,7 +93,7 @@ asmlinkage int do_rt_sigreturn(struct pt_regs *regs)
 	return regs->a4;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 04a43cfd4e09..7c09adeb58bb 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -61,7 +61,6 @@ SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
-	struct task_struct *task;
 	sigset_t set;
 
 	/* Always make any pending restarted system calls return -EINTR */
@@ -86,8 +85,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return regs->a0;
 
 badframe:
-	task = current;
-	force_sig(SIGSEGV, task);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/h8300/kernel/ptrace_h.c b/arch/h8300/kernel/ptrace_h.c
index f5ff3b794c85..15db45a03b04 100644
--- a/arch/h8300/kernel/ptrace_h.c
+++ b/arch/h8300/kernel/ptrace_h.c
@@ -250,7 +250,7 @@ asmlinkage void trace_trap(unsigned long bp)
 {
 	if ((unsigned long)current->thread.breakinfo.addr == bp) {
 		user_disable_single_step(current);
-		force_sig(SIGTRAP, current);
+		force_sig(SIGTRAP);
 	} else
-		force_sig(SIGILL, current);
+		force_sig(SIGILL);
 }
diff --git a/arch/h8300/kernel/ptrace_s.c b/arch/h8300/kernel/ptrace_s.c
index c0af930052c0..ee21f37b7ed4 100644
--- a/arch/h8300/kernel/ptrace_s.c
+++ b/arch/h8300/kernel/ptrace_s.c
@@ -40,5 +40,5 @@ void user_enable_single_step(struct task_struct *child)
 asmlinkage void trace_trap(unsigned long bp)
 {
 	(void)bp;
-	force_sig(SIGTRAP, current);
+	force_sig(SIGTRAP);
 }
diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
index e0f2b708e5d9..ef7489b7c459 100644
--- a/arch/h8300/kernel/signal.c
+++ b/arch/h8300/kernel/signal.c
@@ -126,7 +126,7 @@ asmlinkage int sys_rt_sigreturn(void)
 	return er0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/hexagon/kernel/signal.c b/arch/hexagon/kernel/signal.c
index 31e2cf95f189..0433fcbb496c 100644
--- a/arch/hexagon/kernel/signal.c
+++ b/arch/hexagon/kernel/signal.c
@@ -265,6 +265,6 @@ asmlinkage int sys_rt_sigreturn(void)
 	return regs->r00;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 91ee04842c22..e634414361df 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -252,7 +252,7 @@ int die_if_kernel(char *str, struct pt_regs *regs, long err)
 static void misaligned_instruction(struct pt_regs *regs)
 {
 	die_if_kernel("Misaligned Instruction", regs, 0);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 }
 
 /*
@@ -263,19 +263,19 @@ static void misaligned_instruction(struct pt_regs *regs)
 static void misaligned_data_load(struct pt_regs *regs)
 {
 	die_if_kernel("Misaligned Data Load", regs, 0);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 }
 
 static void misaligned_data_store(struct pt_regs *regs)
 {
 	die_if_kernel("Misaligned Data Store", regs, 0);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 }
 
 static void illegal_instruction(struct pt_regs *regs)
 {
 	die_if_kernel("Illegal Instruction", regs, 0);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 /*
@@ -285,7 +285,7 @@ static void illegal_instruction(struct pt_regs *regs)
 static void precise_bus_error(struct pt_regs *regs)
 {
 	die_if_kernel("Precise Bus Error", regs, 0);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 }
 
 /*
diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
index 518cceb5d4af..e5044aed9452 100644
--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -152,7 +152,7 @@ ia64_rt_sigreturn (struct sigscratch *scr)
 	return retval;
 
   give_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return retval;
 }
 
diff --git a/arch/ia64/kernel/traps.c b/arch/ia64/kernel/traps.c
index 85d8616ac4f6..0a3adbfebc2a 100644
--- a/arch/ia64/kernel/traps.c
+++ b/arch/ia64/kernel/traps.c
@@ -589,14 +589,14 @@ ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
 		printk(KERN_ERR "Unexpected IA-32 exception (Trap 45)\n");
 		printk(KERN_ERR "  iip - 0x%lx, ifa - 0x%lx, isr - 0x%lx\n",
 		       iip, ifa, isr);
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 		return;
 
 	      case 46:
 		printk(KERN_ERR "Unexpected IA-32 intercept trap (Trap 46)\n");
 		printk(KERN_ERR "  iip - 0x%lx, ifa - 0x%lx, isr - 0x%lx, iim - 0x%lx\n",
 		       iip, ifa, isr, iim);
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 		return;
 
 	      case 47:
@@ -608,5 +608,5 @@ ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
 		break;
 	}
 	if (!die_if_kernel(buf, &regs, error))
-		force_sig(SIGILL, current);
+		force_sig(SIGILL);
 }
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 87e7f3639839..05610e6924c1 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -803,7 +803,7 @@ asmlinkage int do_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
 	return regs->d0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
@@ -825,7 +825,7 @@ asmlinkage int do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
 	return regs->d0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index b2fd000b9285..2b6e143abd73 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -431,7 +431,7 @@ static inline void bus_error030 (struct frame *fp)
 			pr_err("BAD KERNEL BUSERR\n");
 
 			die_if_kernel("Oops", &fp->ptregs,0);
-			force_sig(SIGKILL, current);
+			force_sig(SIGKILL);
 			return;
 		}
 	} else {
@@ -463,7 +463,7 @@ static inline void bus_error030 (struct frame *fp)
 				 !(ssw & RW) ? "write" : "read", addr,
 				 fp->ptregs.pc);
 			die_if_kernel ("Oops", &fp->ptregs, buserr_type);
-			force_sig (SIGBUS, current);
+			force_sig (SIGBUS);
 			return;
 		}
 
@@ -493,7 +493,7 @@ static inline void bus_error030 (struct frame *fp)
 			do_page_fault (&fp->ptregs, addr, 0);
        } else {
 		pr_debug("protection fault on insn access (segv).\n");
-		force_sig (SIGSEGV, current);
+		force_sig (SIGSEGV);
        }
 }
 #else
@@ -571,7 +571,7 @@ static inline void bus_error030 (struct frame *fp)
 			       !(ssw & RW) ? "write" : "read", addr,
 			       fp->ptregs.pc);
 			die_if_kernel("Oops",&fp->ptregs,mmusr);
-			force_sig(SIGSEGV, current);
+			force_sig(SIGSEGV);
 			return;
 		} else {
 #if 0
@@ -598,7 +598,7 @@ static inline void bus_error030 (struct frame *fp)
 #endif
 			pr_debug("Unknown SIGSEGV - 1\n");
 			die_if_kernel("Oops",&fp->ptregs,mmusr);
-			force_sig(SIGSEGV, current);
+			force_sig(SIGSEGV);
 			return;
 		}
 
@@ -621,7 +621,7 @@ static inline void bus_error030 (struct frame *fp)
 	buserr:
 		pr_err("BAD KERNEL BUSERR\n");
 		die_if_kernel("Oops",&fp->ptregs,0);
-		force_sig(SIGKILL, current);
+		force_sig(SIGKILL);
 		return;
 	}
 
@@ -660,7 +660,7 @@ static inline void bus_error030 (struct frame *fp)
 			addr, fp->ptregs.pc);
 		pr_debug("Unknown SIGSEGV - 2\n");
 		die_if_kernel("Oops",&fp->ptregs,mmusr);
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 		return;
 	}
 
@@ -804,7 +804,7 @@ asmlinkage void buserr_c(struct frame *fp)
 	default:
 	  die_if_kernel("bad frame format",&fp->ptregs,0);
 	  pr_debug("Unknown SIGSEGV - 4\n");
-	  force_sig(SIGSEGV, current);
+	  force_sig(SIGSEGV);
 	}
 }
 
diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index 0685696349bb..cdd4feb279c5 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -108,7 +108,7 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	return rval;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 180ad081afcf..1db29957a931 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -32,7 +32,7 @@ int __isa_exception_epc(struct pt_regs *regs)
 	/* Calculate exception PC in branch delay slot. */
 	if (__get_user(inst, (u16 __user *) msk_isa16_mode(epc))) {
 		/* This should never happen because delay slot was checked. */
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 		return epc;
 	}
 	if (cpu_has_mips16) {
@@ -305,7 +305,7 @@ int __microMIPS_compute_return_epc(struct pt_regs *regs)
 	return 0;
 
 sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return -EFAULT;
 }
 
@@ -328,7 +328,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
 	/* Read the instruction. */
 	addr = (u16 __user *)msk_isa16_mode(epc);
 	if (__get_user(inst.full, addr)) {
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 		return -EFAULT;
 	}
 
@@ -343,7 +343,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
 	case MIPS16e_jal_op:
 		addr += 1;
 		if (__get_user(inst2, addr)) {
-			force_sig(SIGSEGV, current);
+			force_sig(SIGSEGV);
 			return -EFAULT;
 		}
 		fullinst = ((unsigned)inst.full << 16) | inst2;
@@ -829,17 +829,17 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 sigill_dsp:
 	pr_debug("%s: DSP branch but not DSP ASE - sending SIGILL.\n",
 		 current->comm);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 	return -EFAULT;
 sigill_r2r6:
 	pr_debug("%s: R2 branch but r2-to-r6 emulator is not present - sending SIGILL.\n",
 		 current->comm);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 	return -EFAULT;
 sigill_r6:
 	pr_debug("%s: R6 branch but no MIPSr6 ISA support - sending SIGILL.\n",
 		 current->comm);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(__compute_return_epc_for_insn);
@@ -859,7 +859,7 @@ int __compute_return_epc(struct pt_regs *regs)
 	 */
 	addr = (unsigned int __user *) epc;
 	if (__get_user(insn.word, addr)) {
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 		return -EFAULT;
 	}
 
@@ -867,7 +867,7 @@ int __compute_return_epc(struct pt_regs *regs)
 
 unaligned:
 	printk("%s: unaligned epc - sending SIGBUS.\n", current->comm);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 	return -EFAULT;
 }
 
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 54cd675c5d1d..62af3ed65794 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -232,7 +232,7 @@ static int evaluate_branch_instruction(struct kprobe *p, struct pt_regs *regs,
 
 unaligned:
 	pr_notice("%s: unaligned epc - sending SIGBUS.\n", current->comm);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 	return -EFAULT;
 
 }
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index d75337974ee9..f6efabcb4e92 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -641,7 +641,7 @@ asmlinkage void sys_sigreturn(void)
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
-		force_sig(sig, current);
+		force_sig(sig);
 
 	/*
 	 * Don't let your children do this ...
@@ -654,7 +654,7 @@ asmlinkage void sys_sigreturn(void)
 	/* Unreached */
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 #endif /* CONFIG_TRAD_SIGNALS */
 
@@ -678,7 +678,7 @@ asmlinkage void sys_rt_sigreturn(void)
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
-		force_sig(sig, current);
+		force_sig(sig);
 
 	if (restore_altstack(&frame->rs_uc.uc_stack))
 		goto badframe;
@@ -694,7 +694,7 @@ asmlinkage void sys_rt_sigreturn(void)
 	/* Unreached */
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 #ifdef CONFIG_TRAD_SIGNALS
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index c498b027823e..a7601e862261 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -84,7 +84,7 @@ asmlinkage void sysn32_rt_sigreturn(void)
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
-		force_sig(sig, current);
+		force_sig(sig);
 
 	if (compat_restore_altstack(&frame->rs_uc.uc_stack))
 		goto badframe;
@@ -100,7 +100,7 @@ asmlinkage void sysn32_rt_sigreturn(void)
 	/* Unreached */
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
diff --git a/arch/mips/kernel/signal_o32.c b/arch/mips/kernel/signal_o32.c
index df259618e834..299a7a28ca33 100644
--- a/arch/mips/kernel/signal_o32.c
+++ b/arch/mips/kernel/signal_o32.c
@@ -171,7 +171,7 @@ asmlinkage void sys32_rt_sigreturn(void)
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
-		force_sig(sig, current);
+		force_sig(sig);
 
 	if (compat_restore_altstack(&frame->rs_uc.uc_stack))
 		goto badframe;
@@ -187,7 +187,7 @@ asmlinkage void sys32_rt_sigreturn(void)
 	/* Unreached */
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
@@ -273,7 +273,7 @@ asmlinkage void sys32_sigreturn(void)
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
-		force_sig(sig, current);
+		force_sig(sig);
 
 	/*
 	 * Don't let your children do this ...
@@ -286,5 +286,5 @@ asmlinkage void sys32_sigreturn(void)
 	/* Unreached */
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c52766a5b85f..a6031b045b95 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -482,7 +482,7 @@ asmlinkage void do_be(struct pt_regs *regs)
 		goto out;
 
 	die_if_kernel("Oops", regs);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 
 out:
 	exception_exit(prev_state);
@@ -765,7 +765,7 @@ int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 		return 1;
 
 	default:
-		force_sig(sig, current);
+		force_sig(sig);
 		return 1;
 	}
 }
@@ -947,7 +947,7 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 		break;
 	case BRK_BUG:
 		die_if_kernel("Kernel bug detected", regs);
-		force_sig(SIGTRAP, current);
+		force_sig(SIGTRAP);
 		break;
 	case BRK_MEMU:
 		/*
@@ -962,7 +962,7 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 			return;
 
 		die_if_kernel("Math emu break/trap", regs);
-		force_sig(SIGTRAP, current);
+		force_sig(SIGTRAP);
 		break;
 	default:
 		scnprintf(b, sizeof(b), "%s instruction in kernel code", str);
@@ -970,7 +970,7 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 		if (si_code) {
 			force_sig_fault(SIGTRAP, si_code, NULL,	current);
 		} else {
-			force_sig(SIGTRAP, current);
+			force_sig(SIGTRAP);
 		}
 	}
 }
@@ -1063,7 +1063,7 @@ asmlinkage void do_bp(struct pt_regs *regs)
 	return;
 
 out_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	goto out;
 }
 
@@ -1105,7 +1105,7 @@ asmlinkage void do_tr(struct pt_regs *regs)
 	return;
 
 out_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	goto out;
 }
 
@@ -1191,7 +1191,7 @@ asmlinkage void do_ri(struct pt_regs *regs)
 	if (unlikely(status > 0)) {
 		regs->cp0_epc = old_epc;		/* Undo skip-over.  */
 		regs->regs[31] = old31;
-		force_sig(status, current);
+		force_sig(status);
 	}
 
 out:
@@ -1220,7 +1220,7 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
 
 	die_if_kernel("COP2: Unhandled kernel unaligned access or invalid "
 			      "instruction", regs);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 
 	return NOTIFY_OK;
 }
@@ -1383,7 +1383,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 		if (unlikely(status > 0)) {
 			regs->cp0_epc = old_epc;	/* Undo skip-over.  */
 			regs->regs[31] = old31;
-			force_sig(status, current);
+			force_sig(status);
 		}
 
 		break;
@@ -1403,7 +1403,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 		 * emulator too.
 		 */
 		if (raw_cpu_has_fpu || !cpu_has_mips_4_5_64_r2_r6) {
-			force_sig(SIGILL, current);
+			force_sig(SIGILL);
 			break;
 		}
 		/* Fall through.  */
@@ -1437,7 +1437,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 #else /* CONFIG_MIPS_FP_SUPPORT */
 	case 1:
 	case 3:
-		force_sig(SIGILL, current);
+		force_sig(SIGILL);
 		break;
 #endif /* CONFIG_MIPS_FP_SUPPORT */
 
@@ -1464,7 +1464,7 @@ asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
 	local_irq_enable();
 
 	die_if_kernel("do_msa_fpe invoked from kernel context!", regs);
-	force_sig(SIGFPE, current);
+	force_sig(SIGFPE);
 out:
 	exception_exit(prev_state);
 }
@@ -1477,7 +1477,7 @@ asmlinkage void do_msa(struct pt_regs *regs)
 	prev_state = exception_enter();
 
 	if (!cpu_has_msa || test_thread_flag(TIF_32BIT_FPREGS)) {
-		force_sig(SIGILL, current);
+		force_sig(SIGILL);
 		goto out;
 	}
 
@@ -1485,7 +1485,7 @@ asmlinkage void do_msa(struct pt_regs *regs)
 
 	err = enable_restore_fp_context(1);
 	if (err)
-		force_sig(SIGILL, current);
+		force_sig(SIGILL);
 out:
 	exception_exit(prev_state);
 }
@@ -1495,7 +1495,7 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
 	enum ctx_state prev_state;
 
 	prev_state = exception_enter();
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 	exception_exit(prev_state);
 }
 
@@ -1592,7 +1592,7 @@ asmlinkage void do_mt(struct pt_regs *regs)
 	}
 	die_if_kernel("MIPS MT Thread exception in kernel", regs);
 
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 
@@ -1601,7 +1601,7 @@ asmlinkage void do_dsp(struct pt_regs *regs)
 	if (cpu_has_dsp)
 		panic("Unexpected DSP exception");
 
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 asmlinkage void do_reserved(struct pt_regs *regs)
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 76e33f940971..92bd2b0f0548 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -1365,20 +1365,20 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		return;
 
 	die_if_kernel("Unhandled kernel unaligned access", regs);
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 
 	return;
 
 sigbus:
 	die_if_kernel("Unhandled kernel unaligned access", regs);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 
 	return;
 
 sigill:
 	die_if_kernel
 	    ("Unhandled kernel unaligned access or invalid instruction", regs);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 /* Recode table from 16-bit register notation to 32-bit GPR. */
@@ -1991,20 +1991,20 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
 		return;
 
 	die_if_kernel("Unhandled kernel unaligned access", regs);
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 
 	return;
 
 sigbus:
 	die_if_kernel("Unhandled kernel unaligned access", regs);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 
 	return;
 
 sigill:
 	die_if_kernel
 	    ("Unhandled kernel unaligned access or invalid instruction", regs);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
@@ -2271,20 +2271,20 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
 		return;
 
 	die_if_kernel("Unhandled kernel unaligned access", regs);
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 
 	return;
 
 sigbus:
 	die_if_kernel("Unhandled kernel unaligned access", regs);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 
 	return;
 
 sigill:
 	die_if_kernel
 	    ("Unhandled kernel unaligned access or invalid instruction", regs);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 asmlinkage void do_ade(struct pt_regs *regs)
@@ -2364,7 +2364,7 @@ asmlinkage void do_ade(struct pt_regs *regs)
 
 sigbus:
 	die_if_kernel("Kernel unaligned instruction access", regs);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 
 	/*
 	 * XXX On return from the signal handler we should advance the epc
diff --git a/arch/mips/sgi-ip22/ip22-berr.c b/arch/mips/sgi-ip22/ip22-berr.c
index 34bb9801d5ff..dc0110a607a5 100644
--- a/arch/mips/sgi-ip22/ip22-berr.c
+++ b/arch/mips/sgi-ip22/ip22-berr.c
@@ -98,7 +98,7 @@ void ip22_be_interrupt(int irq)
 	       field, regs->cp0_epc, field, regs->regs[31]);
 	/* Assume it would be too dangerous to continue ... */
 	die_if_kernel("Oops", regs);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 }
 
 static int ip22_be_handler(struct pt_regs *regs, int is_fixup)
diff --git a/arch/mips/sgi-ip22/ip28-berr.c b/arch/mips/sgi-ip22/ip28-berr.c
index 082541d33161..c0cf7baee36d 100644
--- a/arch/mips/sgi-ip22/ip28-berr.c
+++ b/arch/mips/sgi-ip22/ip28-berr.c
@@ -462,7 +462,7 @@ void ip22_be_interrupt(int irq)
 	if (ip28_be_interrupt(regs) != MIPS_BE_DISCARD) {
 		/* Assume it would be too dangerous to continue ... */
 		die_if_kernel("Oops", regs);
-		force_sig(SIGBUS, current);
+		force_sig(SIGBUS);
 	} else if (debug_be_interrupt)
 		show_regs(regs);
 }
diff --git a/arch/mips/sgi-ip27/ip27-berr.c b/arch/mips/sgi-ip27/ip27-berr.c
index 83efe03d5c60..73ad29b180fb 100644
--- a/arch/mips/sgi-ip27/ip27-berr.c
+++ b/arch/mips/sgi-ip27/ip27-berr.c
@@ -74,7 +74,7 @@ int ip27_be_handler(struct pt_regs *regs, int is_fixup)
 	show_regs(regs);
 	dump_tlb_all();
 	while(1);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 }
 
 void __init ip27_be_init(void)
diff --git a/arch/mips/sgi-ip32/ip32-berr.c b/arch/mips/sgi-ip32/ip32-berr.c
index c1f12a9cf305..c860f95ab7ed 100644
--- a/arch/mips/sgi-ip32/ip32-berr.c
+++ b/arch/mips/sgi-ip32/ip32-berr.c
@@ -29,7 +29,7 @@ static int ip32_be_handler(struct pt_regs *regs, int is_fixup)
 	show_regs(regs);
 	dump_tlb_all();
 	while(1);
-	force_sig(SIGBUS, current);
+	force_sig(SIGBUS);
 }
 
 void __init ip32_be_init(void)
diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
index 5f7660aa2d68..fe61513982b4 100644
--- a/arch/nds32/kernel/signal.c
+++ b/arch/nds32/kernel/signal.c
@@ -163,7 +163,7 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	return regs->uregs[0];
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 5aa7c17da27a..8d84b8b30eb6 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -288,7 +288,7 @@ void unhandled_interruption(struct pt_regs *regs)
 	show_regs(regs);
 	if (!user_mode(regs))
 		do_exit(SIGKILL);
-	force_sig(SIGKILL, current);
+	force_sig(SIGKILL);
 }
 
 void unhandled_exceptions(unsigned long entry, unsigned long addr,
@@ -299,7 +299,7 @@ void unhandled_exceptions(unsigned long entry, unsigned long addr,
 	show_regs(regs);
 	if (!user_mode(regs))
 		do_exit(SIGKILL);
-	force_sig(SIGKILL, current);
+	force_sig(SIGKILL);
 }
 
 extern int do_page_fault(unsigned long entry, unsigned long addr,
@@ -326,7 +326,7 @@ void do_revinsn(struct pt_regs *regs)
 	show_regs(regs);
 	if (!user_mode(regs))
 		do_exit(SIGILL);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 #ifdef CONFIG_ALIGNMENT_TRAP
diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
index 9bf38531b189..a42dd09c6578 100644
--- a/arch/nios2/kernel/signal.c
+++ b/arch/nios2/kernel/signal.c
@@ -120,7 +120,7 @@ asmlinkage int do_rt_sigreturn(struct switch_stack *sw)
 	return rval;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 5ac9d3b1d615..0337d1e1d2d5 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -99,7 +99,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
 	return regs->gpr[11];
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 6ed7293ef007..0fad2e46ff43 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -376,7 +376,7 @@ static inline void simulate_lwa(struct pt_regs *regs, unsigned long address,
 
 	if (get_user(value, lwa_addr)) {
 		if (user_mode(regs)) {
-			force_sig(SIGSEGV, current);
+			force_sig(SIGSEGV);
 			return;
 		}
 
@@ -423,7 +423,7 @@ static inline void simulate_swa(struct pt_regs *regs, unsigned long address,
 
 	if (put_user(regs->gpr[rb], vaddr)) {
 		if (user_mode(regs)) {
-			force_sig(SIGSEGV, current);
+			force_sig(SIGSEGV);
 			return;
 		}
 
diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
index 848c1934680b..02895a8f2c55 100644
--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -164,7 +164,7 @@ sys_rt_sigreturn(struct pt_regs *regs, int in_syscall)
 
 give_sigsegv:
 	DBG(1,"sys_rt_sigreturn: Sending SIGSEGV\n");
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return;
 }
 
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index ede4f04281ae..fd48cdc0a4ff 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1249,7 +1249,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 				   current->comm, current->pid,
 				   rt_sf, regs->nip, regs->link);
 
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
@@ -1338,7 +1338,7 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
 					   current->comm, current->pid,
 					   ctx, regs->nip, regs->link);
 
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 		goto out;
 	}
 
@@ -1516,6 +1516,6 @@ SYSCALL_DEFINE0(sigreturn)
 				   current->comm, current->pid,
 				   addr, regs->nip, regs->link);
 
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 06c299ef6132..ea08d848f558 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -812,7 +812,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 				   current->comm, current->pid, "rt_sigreturn",
 				   (long)uc, regs->nip, regs->link);
 
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index 07f82d7395ff..3f2380f40f99 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -443,7 +443,7 @@ long spufs_run_spu(struct spu_context *ctx, u32 *npc, u32 *event)
 
 	else if (unlikely((status & SPU_STATUS_STOPPED_BY_STOP)
 	    && (status >> SPU_STOP_STATUS_SHIFT) == 0x3fff)) {
-		force_sig(SIGTRAP, current);
+		force_sig(SIGTRAP);
 		ret = -ERESTARTSYS;
 	}
 
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 804d6ee4f3c5..50c0e64372b0 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -139,7 +139,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 			task->comm, task_pid_nr(task), __func__,
 			frame, (void *)regs->sepc, (void *)regs->sp);
 	}
-	force_sig(SIGSEGV, task);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index 6f2a193ccccc..38d4bdbc34b9 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -194,7 +194,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 	load_sigregs();
 	return regs->gprs[2];
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
@@ -217,7 +217,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	load_sigregs();
 	return regs->gprs[2];
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }	
 
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 22f08245aa5d..e6fca5498e1f 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -232,7 +232,7 @@ SYSCALL_DEFINE0(sigreturn)
 	load_sigregs();
 	return regs->gprs[2];
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
@@ -256,7 +256,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	load_sigregs();
 	return regs->gprs[2];
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/sh/kernel/cpu/sh2a/fpu.c b/arch/sh/kernel/cpu/sh2a/fpu.c
index 74b48db86dd7..0bcff11a4843 100644
--- a/arch/sh/kernel/cpu/sh2a/fpu.c
+++ b/arch/sh/kernel/cpu/sh2a/fpu.c
@@ -568,5 +568,5 @@ BUILD_TRAP_HANDLER(fpu_error)
 		return;
 	}
 
-	force_sig(SIGFPE, tsk);
+	force_sig(SIGFPE);
 }
diff --git a/arch/sh/kernel/cpu/sh4/fpu.c b/arch/sh/kernel/cpu/sh4/fpu.c
index 1ff56e5ba990..03ffd8cdf542 100644
--- a/arch/sh/kernel/cpu/sh4/fpu.c
+++ b/arch/sh/kernel/cpu/sh4/fpu.c
@@ -421,5 +421,5 @@ BUILD_TRAP_HANDLER(fpu_error)
 		}
 	}
 
-	force_sig(SIGFPE, tsk);
+	force_sig(SIGFPE);
 }
diff --git a/arch/sh/kernel/cpu/sh5/fpu.c b/arch/sh/kernel/cpu/sh5/fpu.c
index 9218d9ed787e..3966b5ee8e93 100644
--- a/arch/sh/kernel/cpu/sh5/fpu.c
+++ b/arch/sh/kernel/cpu/sh5/fpu.c
@@ -100,9 +100,7 @@ void restore_fpu(struct task_struct *tsk)
 
 asmlinkage void do_fpu_error(unsigned long ex, struct pt_regs *regs)
 {
-	struct task_struct *tsk = current;
-
 	regs->pc += 4;
 
-	force_sig(SIGFPE, tsk);
+	force_sig(SIGFPE);
 }
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 3390349ff976..11085e48eaa6 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -550,7 +550,7 @@ asmlinkage void do_single_step(unsigned long long vec, struct pt_regs *regs)
 	   continually stepping. */
 	local_irq_enable();
 	regs->sr &= ~SR_SSTEP;
-	force_sig(SIGTRAP, current);
+	force_sig(SIGTRAP);
 }
 
 /* Called with interrupts disabled */
@@ -561,7 +561,7 @@ BUILD_TRAP_HANDLER(breakpoint)
 	/* We need to forward step the PC, to counteract the backstep done
 	   in signal.c. */
 	local_irq_enable();
-	force_sig(SIGTRAP, current);
+	force_sig(SIGTRAP);
 	regs->pc += 4;
 }
 
diff --git a/arch/sh/kernel/signal_32.c b/arch/sh/kernel/signal_32.c
index 2a2121ba8ebe..24473fa6c3b6 100644
--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -176,7 +176,7 @@ asmlinkage int sys_sigreturn(void)
 	return r0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
@@ -207,7 +207,7 @@ asmlinkage int sys_rt_sigreturn(void)
 	return r0;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
index f1f1598879c2..b9aaa9266b34 100644
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -277,7 +277,7 @@ asmlinkage int sys_sigreturn(unsigned long r2, unsigned long r3,
 	return (int) ret;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
@@ -311,7 +311,7 @@ asmlinkage int sys_rt_sigreturn(unsigned long r2, unsigned long r3,
 	return (int) ret;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 8b49cced663d..63cf17bc760d 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -141,7 +141,7 @@ BUILD_TRAP_HANDLER(debug)
 		       SIGTRAP) == NOTIFY_STOP)
 		return;
 
-	force_sig(SIGTRAP, current);
+	force_sig(SIGTRAP);
 }
 
 /*
@@ -167,7 +167,7 @@ BUILD_TRAP_HANDLER(bug)
 	}
 #endif
 
-	force_sig(SIGTRAP, current);
+	force_sig(SIGTRAP);
 }
 
 BUILD_TRAP_HANDLER(nmi)
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index f2a18b5fafd8..bd5568c8e7f0 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -611,7 +611,6 @@ asmlinkage void do_reserved_inst(void)
 {
 	struct pt_regs *regs = current_pt_regs();
 	unsigned long error_code;
-	struct task_struct *tsk = current;
 
 #ifdef CONFIG_SH_FPU_EMU
 	unsigned short inst = 0;
@@ -633,7 +632,7 @@ asmlinkage void do_reserved_inst(void)
 		/* Enable DSP mode, and restart instruction. */
 		regs->sr |= SR_DSP;
 		/* Save DSP mode */
-		tsk->thread.dsp_status.status |= SR_DSP;
+		current->thread.dsp_status.status |= SR_DSP;
 		return;
 	}
 #endif
@@ -641,7 +640,7 @@ asmlinkage void do_reserved_inst(void)
 	error_code = lookup_exception_vector();
 
 	local_irq_enable();
-	force_sig(SIGILL, tsk);
+	force_sig(SIGILL);
 	die_if_no_fixup("reserved instruction", regs, error_code);
 }
 
@@ -697,7 +696,6 @@ asmlinkage void do_illegal_slot_inst(void)
 {
 	struct pt_regs *regs = current_pt_regs();
 	unsigned long inst;
-	struct task_struct *tsk = current;
 
 	if (kprobe_handle_illslot(regs->pc) == 0)
 		return;
@@ -716,7 +714,7 @@ asmlinkage void do_illegal_slot_inst(void)
 	inst = lookup_exception_vector();
 
 	local_irq_enable();
-	force_sig(SIGILL, tsk);
+	force_sig(SIGILL);
 	die_if_no_fixup("illegal slot instruction", regs, inst);
 }
 
diff --git a/arch/sh/kernel/traps_64.c b/arch/sh/kernel/traps_64.c
index 8ce90a7da67d..37046f3a26d3 100644
--- a/arch/sh/kernel/traps_64.c
+++ b/arch/sh/kernel/traps_64.c
@@ -599,7 +599,7 @@ static void do_unhandled_exception(int signr, char *str, unsigned long error,
 				   struct pt_regs *regs)
 {
 	if (user_mode(regs))
-		force_sig(signr, current);
+		force_sig(signr);
 
 	die_if_no_fixup(str, regs, error);
 }
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 59eaf6227af1..c4bccd97f3cf 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -570,7 +570,7 @@ void fault_in_user_windows(struct pt_regs *regs)
 
 barf:
 	set_thread_wsaved(window + 1);
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 asmlinkage long sparc_do_fork(unsigned long clone_flags,
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index fb431d47a532..a237810aa9f4 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -170,7 +170,7 @@ void do_sigreturn32(struct pt_regs *regs)
 	return;
 
 segv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 asmlinkage void do_rt_sigreturn32(struct pt_regs *regs)
@@ -256,7 +256,7 @@ asmlinkage void do_rt_sigreturn32(struct pt_regs *regs)
 	set_current_blocked(&set);
 	return;
 segv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs, unsigned long framesize)
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 83953780ca01..42c3de313fd6 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -137,7 +137,7 @@ asmlinkage void do_sigreturn(struct pt_regs *regs)
 	return;
 
 segv_and_exit:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 asmlinkage void do_rt_sigreturn(struct pt_regs *regs)
@@ -196,7 +196,7 @@ asmlinkage void do_rt_sigreturn(struct pt_regs *regs)
 	set_current_blocked(&set);
 	return;
 segv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 static inline void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs, unsigned long framesize)
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 9d50190cf312..69ae814b7e90 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -134,7 +134,7 @@ asmlinkage void sparc64_set_context(struct pt_regs *regs)
 	exception_exit(prev_state);
 	return;
 do_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	goto out;
 }
 
@@ -228,7 +228,7 @@ asmlinkage void sparc64_get_context(struct pt_regs *regs)
 	exception_exit(prev_state);
 	return;
 do_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	goto out;
 }
 
@@ -320,7 +320,7 @@ void do_rt_sigreturn(struct pt_regs *regs)
 	set_current_blocked(&set);
 	return;
 segv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 }
 
 static inline void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs, unsigned long framesize)
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 0cd02a64a451..12bfc7e215ca 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2181,7 +2181,7 @@ bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
 				addr += PAGE_SIZE;
 			}
 		}
-		force_sig(SIGKILL, current);
+		force_sig(SIGKILL);
 
 		return true;
 	}
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index b0440b0edd97..2731faf415ba 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -425,7 +425,7 @@ static void force_user_fault(unsigned long address, int write)
 static void check_stack_aligned(unsigned long sp)
 {
 	if (sp & 0x7UL)
-		force_sig(SIGILL, current);
+		force_sig(SIGILL);
 }
 
 void window_overflow_fault(void)
diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index a43d42bf0a86..783b9247161f 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -32,7 +32,7 @@ void flush_thread(void)
 	if (ret) {
 		printk(KERN_ERR "flush_thread - clearing address space failed, "
 		       "err = %d\n", ret);
-		force_sig(SIGKILL, current);
+		force_sig(SIGKILL);
 	}
 	get_safe_registers(current_pt_regs()->regs.gp,
 			   current_pt_regs()->regs.fp);
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 8347161c2ae0..45f739bf302f 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -329,7 +329,7 @@ void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 		       "process: %d\n", task_tgid_vnr(current));
 		/* We are under mmap_sem, release it such that current can terminate */
 		up_write(&current->mm->mmap_sem);
-		force_sig(SIGKILL, current);
+		force_sig(SIGKILL);
 		do_signal(&current->thread.regs);
 	}
 }
@@ -487,7 +487,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 
 kill:
 	printk(KERN_ERR "Failed to flush page for address 0x%lx\n", address);
-	force_sig(SIGKILL, current);
+	force_sig(SIGKILL);
 }
 
 pgd_t *pgd_offset_proc(struct mm_struct *mm, unsigned long address)
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 646059402ab3..1c943c66063f 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -309,7 +309,7 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 	} else {
 		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code = %d) with errno %d\n",
 		       sig, code, err);
-		force_sig(sig, current);
+		force_sig(sig);
 	}
 }
 
diff --git a/arch/unicore32/kernel/signal.c b/arch/unicore32/kernel/signal.c
index 75f27dc68bd0..070fa58d23a9 100644
--- a/arch/unicore32/kernel/signal.c
+++ b/arch/unicore32/kernel/signal.c
@@ -129,7 +129,7 @@ asmlinkage int __sys_rt_sigreturn(struct pt_regs *regs)
 	return regs->UCreg_00;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index d9d81ad7a400..7ea87f4ad0b7 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -268,7 +268,7 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	return true;
 
 sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return true;
 }
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5112a50e6486..e11ac124dd37 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1329,7 +1329,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		local_irq_enable();
 
 		if (kill_it || do_memory_failure(&m))
-			force_sig(SIGBUS, current);
+			force_sig(SIGBUS);
 		local_irq_disable();
 		ist_end_non_atomic();
 	} else {
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 364813cea647..7cf508f78c8c 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -857,7 +857,7 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 		pr_cont("\n");
 	}
 
-	force_sig(SIGSEGV, me);
+	force_sig(SIGSEGV);
 }
 
 #ifdef CONFIG_X86_X32_ABI
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 8b6d03e55d2f..e54f0cad4b2e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -254,7 +254,7 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 	show_signal(tsk, signr, "trap ", str, regs, error_code);
 
 	if (!sicode)
-		force_sig(signr, tsk);
+		force_sig(signr);
 	else
 		force_sig_fault(signr, sicode, addr, tsk);
 }
@@ -566,7 +566,7 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
-	force_sig(SIGSEGV, tsk);
+	force_sig(SIGSEGV);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index ccf03416e434..18239d5a8b53 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1087,7 +1087,7 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 		pr_err("return address clobbered: pid=%d, %%sp=%#lx, %%ip=%#lx\n",
 		       current->pid, regs->sp, regs->ip);
 
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 	}
 
 	return -1;
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 6a38717d179c..a76c12b38e92 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -583,7 +583,7 @@ int handle_vm86_trap(struct kernel_vm86_regs *regs, long error_code, int trapno)
 		return 1; /* we let this handle by the calling routine */
 	current->thread.trap_nr = trapno;
 	current->thread.error_code = error_code;
-	force_sig(SIGTRAP, current);
+	force_sig(SIGTRAP);
 	return 0;
 }
 
diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index 0d1c47cbbdd6..895fb7a9294d 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -912,7 +912,7 @@ void mpx_notify_unmap(struct mm_struct *mm, unsigned long start,
 
 	ret = mpx_unmap_tables(mm, start, end);
 	if (ret)
-		force_sig(SIGSEGV, current);
+		force_sig(SIGSEGV);
 }
 
 /* MPX cannot handle addresses above 47 bits yet. */
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 8b4a71efe7ee..7c11c9e5d7ea 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -471,7 +471,7 @@ long sys_sigreturn(void)
 	return PT_REGS_SYSCALL_RET(&current->thread.regs);
 
  segfault:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
@@ -577,6 +577,6 @@ long sys_rt_sigreturn(void)
 	return PT_REGS_SYSCALL_RET(&current->thread.regs);
 
  segfault:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index dc22a238ed9c..fbedf2aba09d 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -270,7 +270,7 @@ asmlinkage long xtensa_rt_sigreturn(long a0, long a1, long a2, long a3,
 	return ret;
 
 badframe:
-	force_sig(SIGSEGV, current);
+	force_sig(SIGSEGV);
 	return 0;
 }
 
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 454d53096bc9..6f26b254091b 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -184,7 +184,7 @@ void do_unhandled(struct pt_regs *regs, unsigned long exccause)
 			    "\tEXCCAUSE is %ld\n",
 			    current->comm, task_pid_nr(current), regs->pc,
 			    exccause);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 /*
@@ -306,7 +306,7 @@ do_illegal_instruction(struct pt_regs *regs)
 
 	pr_info_ratelimited("Illegal Instruction in '%s' (pid = %d, pc = %#010lx)\n",
 			    current->comm, task_pid_nr(current), regs->pc);
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 }
 
 
@@ -354,7 +354,7 @@ do_debug(struct pt_regs *regs)
 
 	/* If in user mode, send SIGTRAP signal to current process */
 
-	force_sig(SIGTRAP, current);
+	force_sig(SIGTRAP);
 }
 
 
diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 7eebbdfbcacd..86556adb1482 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -225,7 +225,7 @@ void lkdtm_CORRUPT_USER_DS(void)
 	set_fs(KERNEL_DS);
 
 	/* Make sure we do not keep running with a KERNEL_DS! */
-	force_sig(SIGKILL, current);
+	force_sig(SIGKILL);
 }
 
 /* Test that VMAP_STACK is actually allocating with a leading guard page */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 8af3101da782..e9df3f0cce48 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -335,7 +335,7 @@ extern int kill_pgrp(struct pid *pid, int sig, int priv);
 extern int kill_pid(struct pid *pid, int sig, int priv);
 extern __must_check bool do_notify_parent(struct task_struct *, int);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
-extern void force_sig(int, struct task_struct *);
+extern void force_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..fd6e0f5ebfdf 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -266,7 +266,7 @@ static inline void addr_limit_user_check(void)
 
 	if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
 				  "Invalid address limit on user-mode return"))
-		force_sig(SIGKILL, current);
+		force_sig(SIGKILL);
 
 #ifdef TIF_FSCHECK
 	clear_thread_flag(TIF_FSCHECK);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 78f61bfc6b79..359122185cfb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2112,7 +2112,7 @@ static void handle_trampoline(struct pt_regs *regs)
 
  sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
-	force_sig(SIGILL, current);
+	force_sig(SIGILL);
 
 }
 
@@ -2228,7 +2228,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 
 	if (unlikely(err)) {
 		uprobe_warn(current, "execute the probed insn, sending SIGILL.");
-		force_sig(SIGILL, current);
+		force_sig(SIGILL);
 	}
 }
 
diff --git a/kernel/rseq.c b/kernel/rseq.c
index e1aa3ebee291..27c48eb7de40 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -296,7 +296,7 @@ void rseq_syscall(struct pt_regs *regs)
 		return;
 	if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
 	    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
-		force_sig(SIGSEGV, t);
+		force_sig(SIGSEGV);
 }
 
 #endif
diff --git a/kernel/signal.c b/kernel/signal.c
index f7669d240ce4..20878c4c28c2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1595,9 +1595,9 @@ send_sig(int sig, struct task_struct *p, int priv)
 }
 EXPORT_SYMBOL(send_sig);
 
-void force_sig(int sig, struct task_struct *p)
+void force_sig(int sig)
 {
-	force_sig_info(sig, SEND_SIG_PRIV, p);
+	force_sig_info(sig, SEND_SIG_PRIV, current);
 }
 EXPORT_SYMBOL(force_sig);
 
@@ -1617,7 +1617,7 @@ void force_sigsegv(int sig)
 		p->sighand->action[sig - 1].sa.sa_handler = SIG_DFL;
 		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	}
-	force_sig(SIGSEGV, p);
+	force_sig(SIGSEGV);
 }
 
 int force_sig_fault(int sig, int code, void __user *addr
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index cecd38e2ac80..06d4259f9ab1 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -111,7 +111,7 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
 	 * that could arise from a missing whitelist entry preventing a
 	 * privileged process from dropping to a lesser-privileged one.
 	 */
-	force_sig(SIGKILL, current);
+	force_sig(SIGKILL);
 	return -EACCES;
 }
 
@@ -203,7 +203,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
 		break;
 	default:
 		pr_warn("Unknown setid state %d\n", flags);
-		force_sig(SIGKILL, current);
+		force_sig(SIGKILL);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.21.0

