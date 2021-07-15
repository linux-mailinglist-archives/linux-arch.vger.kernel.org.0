Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E643CA517
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhGOSP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 14:15:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48242 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhGOSP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 14:15:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m45qb-00BetQ-1G; Thu, 15 Jul 2021 12:12:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57078 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m45qX-00Aowo-8D; Thu, 15 Jul 2021 12:12:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <87a6mnzbx2.fsf_-_@disp2133>
Date:   Thu, 15 Jul 2021 13:12:22 -0500
In-Reply-To: <87a6mnzbx2.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 15 Jul 2021 13:09:45 -0500")
Message-ID: <87mtqnxx89.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m45qX-00Aowo-8D;;;mid=<87mtqnxx89.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19By38Gj/ji0SKJTJQ/ai4ehN8lLz5KTi8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3157 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (0.3%), b_tie_ro: 7 (0.2%), parse: 7 (0.2%),
        extract_message_metadata: 19 (0.6%), get_uri_detail_list: 7 (0.2%),
        tests_pri_-1000: 14 (0.4%), tests_pri_-950: 1.36 (0.0%),
        tests_pri_-900: 1.00 (0.0%), tests_pri_-90: 101 (3.2%), check_bayes:
        99 (3.1%), b_tokenize: 26 (0.8%), b_tok_get_all: 14 (0.4%),
        b_comp_prob: 3.3 (0.1%), b_tok_touch_all: 51 (1.6%), b_finish: 1.60
        (0.1%), tests_pri_0: 2983 (94.5%), check_dkim_signature: 1.29 (0.0%),
        check_dkim_adsp: 3.0 (0.1%), poll_dns_idle: 0.71 (0.0%), tests_pri_10:
        2.5 (0.1%), tests_pri_500: 13 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/6] signal/sparc: si_trapno is only used with SIGILL ILL_ILLTRP
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


While reviewing the signal handlers on sparc it became clear that
si_trapno is only set to a non-zero value when sending SIGILL with
si_code ILL_ILLTRP.

Add force_sig_fault_trapno and send SIGILL ILL_ILLTRP with it.

Remove the define of __ARCH_SI_TRAPNO and remove the always zero
si_trapno parameter from send_sig_fault and force_sig_fault.

v1: https://lkml.kernel.org/r/m1eeers7q7.fsf_-_@fess.ebiederm.org
v2: https://lkml.kernel.org/r/20210505141101.11519-7-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/include/uapi/asm/siginfo.h |  3 --
 arch/sparc/kernel/process_64.c        |  2 +-
 arch/sparc/kernel/sys_sparc_32.c      |  2 +-
 arch/sparc/kernel/sys_sparc_64.c      |  2 +-
 arch/sparc/kernel/traps_32.c          | 22 +++++++-------
 arch/sparc/kernel/traps_64.c          | 44 ++++++++++++---------------
 arch/sparc/kernel/unaligned_32.c      |  2 +-
 arch/sparc/mm/fault_32.c              |  2 +-
 arch/sparc/mm/fault_64.c              |  2 +-
 include/linux/sched/signal.h          |  1 +
 kernel/signal.c                       | 19 ++++++++++++
 11 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
index 68bdde4c2a2e..0e7c27522aed 100644
--- a/arch/sparc/include/uapi/asm/siginfo.h
+++ b/arch/sparc/include/uapi/asm/siginfo.h
@@ -8,9 +8,6 @@
 
 #endif /* defined(__sparc__) && defined(__arch64__) */
 
-
-#define __ARCH_SI_TRAPNO
-
 #include <asm-generic/siginfo.h>
 
 
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d33c58a58d4f..547b06b49ce3 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -518,7 +518,7 @@ void synchronize_user_stack(void)
 
 static void stack_unaligned(unsigned long sp)
 {
-	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp, 0);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp);
 }
 
 static const char uwfault32[] = KERN_INFO \
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index be77538bc038..082a551897ed 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -151,7 +151,7 @@ sparc_breakpoint (struct pt_regs *regs)
 #ifdef DEBUG_SPARC_BREAKPOINT
         printk ("TRAP: Entering kernel PC=%x, nPC=%x\n", regs->pc, regs->npc);
 #endif
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc, 0);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
 
 #ifdef DEBUG_SPARC_BREAKPOINT
 	printk ("TRAP: Returning to space: PC=%x nPC=%x\n", regs->pc, regs->npc);
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 6b92fadb6ec7..1e9a9e016237 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -514,7 +514,7 @@ asmlinkage void sparc_breakpoint(struct pt_regs *regs)
 #ifdef DEBUG_SPARC_BREAKPOINT
         printk ("TRAP: Entering kernel PC=%lx, nPC=%lx\n", regs->tpc, regs->tnpc);
 #endif
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->tpc, 0);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->tpc);
 #ifdef DEBUG_SPARC_BREAKPOINT
 	printk ("TRAP: Returning to space: PC=%lx nPC=%lx\n", regs->tpc, regs->tnpc);
 #endif
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 247a0d9683b2..5630e5a395e0 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -102,8 +102,8 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 	if(regs->psr & PSR_PS)
 		die_if_kernel("Kernel bad trap", regs);
 
-	force_sig_fault(SIGILL, ILL_ILLTRP,
-			(void __user *)regs->pc, type - 0x80);
+	force_sig_fault_trapno(SIGILL, ILL_ILLTRP,
+			       (void __user *)regs->pc, type - 0x80);
 }
 
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
@@ -116,7 +116,7 @@ void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned lon
 	       regs->pc, *(unsigned long *)regs->pc);
 #endif
 
-	send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, 0, current);
+	send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, current);
 }
 
 void do_priv_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
@@ -124,7 +124,7 @@ void do_priv_instruction(struct pt_regs *regs, unsigned long pc, unsigned long n
 {
 	if(psr & PSR_PS)
 		die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);
-	send_sig_fault(SIGILL, ILL_PRVOPC, (void __user *)pc, 0, current);
+	send_sig_fault(SIGILL, ILL_PRVOPC, (void __user *)pc, current);
 }
 
 /* XXX User may want to be allowed to do this. XXX */
@@ -145,7 +145,7 @@ void do_memaccess_unaligned(struct pt_regs *regs, unsigned long pc, unsigned lon
 #endif
 	send_sig_fault(SIGBUS, BUS_ADRALN,
 		       /* FIXME: Should dig out mna address */ (void *)0,
-		       0, current);
+		       current);
 }
 
 static unsigned long init_fsr = 0x0UL;
@@ -291,7 +291,7 @@ void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 		else if (fsr & 0x01)
 			code = FPE_FLTRES;
 	}
-	send_sig_fault(SIGFPE, code, (void __user *)pc, 0, fpt);
+	send_sig_fault(SIGFPE, code, (void __user *)pc, fpt);
 #ifndef CONFIG_SMP
 	last_task_used_math = NULL;
 #endif
@@ -305,7 +305,7 @@ void handle_tag_overflow(struct pt_regs *regs, unsigned long pc, unsigned long n
 {
 	if(psr & PSR_PS)
 		die_if_kernel("Penguin overflow trap from kernel mode", regs);
-	send_sig_fault(SIGEMT, EMT_TAGOVF, (void __user *)pc, 0, current);
+	send_sig_fault(SIGEMT, EMT_TAGOVF, (void __user *)pc, current);
 }
 
 void handle_watchpoint(struct pt_regs *regs, unsigned long pc, unsigned long npc,
@@ -327,13 +327,13 @@ void handle_reg_access(struct pt_regs *regs, unsigned long pc, unsigned long npc
 	printk("Register Access Exception at PC %08lx NPC %08lx PSR %08lx\n",
 	       pc, npc, psr);
 #endif
-	force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)pc, 0);
+	force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)pc);
 }
 
 void handle_cp_disabled(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			unsigned long psr)
 {
-	send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, 0, current);
+	send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, current);
 }
 
 void handle_cp_exception(struct pt_regs *regs, unsigned long pc, unsigned long npc,
@@ -343,13 +343,13 @@ void handle_cp_exception(struct pt_regs *regs, unsigned long pc, unsigned long n
 	printk("Co-Processor Exception at PC %08lx NPC %08lx PSR %08lx\n",
 	       pc, npc, psr);
 #endif
-	send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, 0, current);
+	send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, current);
 }
 
 void handle_hw_divzero(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 		       unsigned long psr)
 {
-	send_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)pc, 0, current);
+	send_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)pc, current);
 }
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index a850dccd78ea..6863025ed56d 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -107,8 +107,8 @@ void bad_trap(struct pt_regs *regs, long lvl)
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGILL, ILL_ILLTRP,
-			(void __user *)regs->tpc, lvl);
+	force_sig_fault_trapno(SIGILL, ILL_ILLTRP,
+			       (void __user *)regs->tpc, lvl);
 }
 
 void bad_trap_tl1(struct pt_regs *regs, long lvl)
@@ -201,8 +201,7 @@ void spitfire_insn_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGSEGV, SEGV_MAPERR,
-			(void __user *)regs->tpc, 0);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)regs->tpc);
 out:
 	exception_exit(prev_state);
 }
@@ -237,7 +236,7 @@ void sun4v_insn_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *) addr, 0);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *) addr);
 }
 
 void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, unsigned long type_ctx)
@@ -321,7 +320,7 @@ void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 	if (is_no_fault_exception(regs))
 		return;
 
-	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)sfar, 0);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)sfar);
 out:
 	exception_exit(prev_state);
 }
@@ -385,13 +384,13 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 	 */
 	switch (type) {
 	case HV_FAULT_TYPE_INV_ASI:
-		force_sig_fault(SIGILL, ILL_ILLADR, (void __user *)addr, 0);
+		force_sig_fault(SIGILL, ILL_ILLADR, (void __user *)addr);
 		break;
 	case HV_FAULT_TYPE_MCD_DIS:
-		force_sig_fault(SIGSEGV, SEGV_ACCADI, (void __user *)addr, 0);
+		force_sig_fault(SIGSEGV, SEGV_ACCADI, (void __user *)addr);
 		break;
 	default:
-		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr, 0);
+		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr);
 		break;
 	}
 }
@@ -568,7 +567,7 @@ static void spitfire_ue_log(unsigned long afsr, unsigned long afar, unsigned lon
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGBUS, BUS_OBJERR, (void *)0, 0);
+	force_sig_fault(SIGBUS, BUS_OBJERR, (void *)0);
 }
 
 void spitfire_access_error(struct pt_regs *regs, unsigned long status_encoded, unsigned long afar)
@@ -2069,8 +2068,7 @@ void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
 	/* Send SIGSEGV to the userspace process with the right signal
 	 * code
 	 */
-	force_sig_fault(SIGSEGV, SEGV_ADIDERR, (void __user *)ent.err_raddr,
-			0);
+	force_sig_fault(SIGSEGV, SEGV_ADIDERR, (void __user *)ent.err_raddr);
 }
 
 /* We run with %pil set to PIL_NORMAL_MAX and PSTATE_IE enabled in %pstate.
@@ -2184,7 +2182,7 @@ bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
 	}
 	if (attrs & SUN4V_ERR_ATTRS_PIO) {
 		force_sig_fault(SIGBUS, BUS_ADRERR,
-				(void __user *)sun4v_get_vaddr(regs), 0);
+				(void __user *)sun4v_get_vaddr(regs));
 		return true;
 	}
 
@@ -2340,8 +2338,7 @@ static void do_fpe_common(struct pt_regs *regs)
 			else if (fsr & 0x01)
 				code = FPE_FLTRES;
 		}
-		force_sig_fault(SIGFPE, code,
-				(void __user *)regs->tpc, 0);
+		force_sig_fault(SIGFPE, code, (void __user *)regs->tpc);
 	}
 }
 
@@ -2395,8 +2392,7 @@ void do_tof(struct pt_regs *regs)
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGEMT, EMT_TAGOVF,
-			(void __user *)regs->tpc, 0);
+	force_sig_fault(SIGEMT, EMT_TAGOVF, (void __user *)regs->tpc);
 out:
 	exception_exit(prev_state);
 }
@@ -2415,8 +2411,7 @@ void do_div0(struct pt_regs *regs)
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGFPE, FPE_INTDIV,
-			(void __user *)regs->tpc, 0);
+	force_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)regs->tpc);
 out:
 	exception_exit(prev_state);
 }
@@ -2612,7 +2607,7 @@ void do_illegal_instruction(struct pt_regs *regs)
 			}
 		}
 	}
-	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, 0);
+	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc);
 out:
 	exception_exit(prev_state);
 }
@@ -2632,7 +2627,7 @@ void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned lo
 	if (is_no_fault_exception(regs))
 		return;
 
-	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)sfar, 0);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)sfar);
 out:
 	exception_exit(prev_state);
 }
@@ -2650,7 +2645,7 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
 	if (is_no_fault_exception(regs))
 		return;
 
-	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) addr, 0);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) addr);
 }
 
 /* sun4v_mem_corrupt_detect_precise() - Handle precise exception on an ADI
@@ -2697,7 +2692,7 @@ void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGSEGV, SEGV_ADIPERR, (void __user *)addr, 0);
+	force_sig_fault(SIGSEGV, SEGV_ADIPERR, (void __user *)addr);
 }
 
 void do_privop(struct pt_regs *regs)
@@ -2712,8 +2707,7 @@ void do_privop(struct pt_regs *regs)
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	force_sig_fault(SIGILL, ILL_PRVOPC,
-			(void __user *)regs->tpc, 0);
+	force_sig_fault(SIGILL, ILL_PRVOPC, (void __user *)regs->tpc);
 out:
 	exception_exit(prev_state);
 }
diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
index ef5c5207c9ff..455f0258c745 100644
--- a/arch/sparc/kernel/unaligned_32.c
+++ b/arch/sparc/kernel/unaligned_32.c
@@ -278,5 +278,5 @@ asmlinkage void user_unaligned_trap(struct pt_regs *regs, unsigned int insn)
 {
 	send_sig_fault(SIGBUS, BUS_ADRALN,
 		       (void __user *)safe_compute_effective_address(regs, insn),
-		       0, current);
+		       current);
 }
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index de2031c2b2d7..fa858626b85b 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -83,7 +83,7 @@ static void __do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 		show_signal_msg(regs, sig, code,
 				addr, current);
 
-	force_sig_fault(sig, code, (void __user *) addr, 0);
+	force_sig_fault(sig, code, (void __user *) addr);
 }
 
 static unsigned long compute_si_addr(struct pt_regs *regs, int text_fault)
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 0a6bcc85fba7..9a9652a15fed 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -176,7 +176,7 @@ static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 	if (unlikely(show_unhandled_signals))
 		show_signal_msg(regs, sig, code, addr, current);
 
-	force_sig_fault(sig, code, (void __user *) addr, 0);
+	force_sig_fault(sig, code, (void __user *) addr);
 }
 
 static unsigned int get_fault_insn(struct pt_regs *regs, unsigned int insn)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b9126fe06c3f..99a9ab2b169a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -329,6 +329,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey);
 int force_sig_perf(void __user *addr, u32 type, u64 sig_data);
 
 int force_sig_ptrace_errno_trap(int errno, void __user *addr);
+int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno);
 
 extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern void force_sigsegv(int sig);
diff --git a/kernel/signal.c b/kernel/signal.c
index a3229add4455..87a374225277 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1808,6 +1808,22 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
 	return force_sig_info(&info);
 }
 
+/* For the rare architectures that include trap information using
+ * si_trapno.
+ */
+int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code  = code;
+	info.si_addr  = addr;
+	info.si_trapno = trapno;
+	return force_sig_info(&info);
+}
+
 int kill_pgrp(struct pid *pid, int sig, int priv)
 {
 	int ret;
@@ -3243,6 +3259,9 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 #endif
 			else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
 				layout = SIL_PERF_EVENT;
+			else if (IS_ENABLED(CONFIG_SPARC) &&
+				 (sig == SIGILL) && (si_code == ILL_ILLTRP))
+				layout = SIL_FAULT_TRAPNO;
 #ifdef __ARCH_SI_TRAPNO
 			else if (layout == SIL_FAULT)
 				layout = SIL_FAULT_TRAPNO;
-- 
2.20.1

