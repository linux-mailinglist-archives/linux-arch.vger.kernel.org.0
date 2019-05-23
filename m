Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E323C2736A
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 02:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfEWAnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 20:43:11 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60223 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWAnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp6-0004Gg-5E; Wed, 22 May 2019 18:43:08 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnq-0005Z3-57; Wed, 22 May 2019 18:41:52 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:09 -0500
Message-Id: <20190523003916.20726-20-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnq-0005Z3-57;;;mid=<20190523003916.20726-20-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ePo+/Er3WoqfC2e6rQlL8F4PlN8NWr0Y=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1875 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.3 (0.1%), b_tie_ro: 1.66 (0.1%), parse: 1.11
        (0.1%), extract_message_metadata: 15 (0.8%), get_uri_detail_list: 5
        (0.3%), tests_pri_-1000: 12 (0.7%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 38 (2.0%), check_bayes: 37
        (2.0%), b_tokenize: 20 (1.1%), b_tok_get_all: 8 (0.4%), b_comp_prob:
        2.2 (0.1%), b_tok_touch_all: 4.9 (0.3%), b_finish: 0.54 (0.0%),
        tests_pri_0: 1784 (95.1%), check_dkim_signature: 0.68 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 0.73 (0.0%), tests_pri_10:
        3.6 (0.2%), tests_pri_500: 14 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 19/26] signal: Explicitly call force_sig_fault on current
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update the calls of force_sig_fault that pass in a variable that is
set to current earlier to explicitly use current.

This is to make the next change that removes the task parameter
from force_sig_fault easier to verify.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/kernel/traps.c   | 2 +-
 arch/arc/mm/fault.c       | 4 ++--
 arch/arm/mm/fault.c       | 2 +-
 arch/mips/mm/fault.c      | 4 ++--
 arch/nds32/kernel/traps.c | 2 +-
 arch/nds32/mm/fault.c     | 4 ++--
 arch/openrisc/mm/fault.c  | 4 ++--
 arch/riscv/kernel/traps.c | 2 +-
 arch/sh/math-emu/math.c   | 2 +-
 arch/unicore32/mm/fault.c | 2 +-
 arch/x86/kernel/ptrace.c  | 2 +-
 arch/x86/kernel/traps.c   | 4 ++--
 arch/x86/kernel/umip.c    | 2 +-
 arch/x86/mm/fault.c       | 6 +++---
 14 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index a7fcbc0d3943..e618fbb3e28d 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -50,7 +50,7 @@ unhandled_exception(const char *str, struct pt_regs *regs,
 
 		tsk->thread.fault_address = (__force unsigned int)addr;
 
-		force_sig_fault(signo, si_code, addr, tsk);
+		force_sig_fault(signo, si_code, addr, current);
 
 	} else {
 		/* If not due to copy_(to|from)_user, we are doomed */
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 8df1638259f3..d5d4758d7e75 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -202,7 +202,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		tsk->thread.fault_address = address;
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
 		return;
 	}
 
@@ -237,5 +237,5 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		goto no_context;
 
 	tsk->thread.fault_address = address;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 }
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 324def0279b2..03007ea4cc72 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -184,7 +184,7 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	force_sig_fault(sig, code, (void __user *)addr, tsk);
+	force_sig_fault(sig, code, (void __user *)addr, current);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 73d8a0f0b810..e63abd492f65 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -223,7 +223,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 			pr_cont("\n");
 		}
 		current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
 		return;
 	}
 
@@ -279,7 +279,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 #endif
 	current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
 	tsk->thread.cp0_badvaddr = address;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 
 	return;
 #ifndef CONFIG_64BIT
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 66f197efcec9..a16e97f7bc75 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -263,7 +263,7 @@ static void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
 	tsk->thread.error_code = error_code;
 
 	force_sig_fault(SIGTRAP, si_code,
-			(void __user *)instruction_pointer(regs), tsk);
+			(void __user *)instruction_pointer(regs), current);
 }
 
 void do_debug_trap(unsigned long entry, unsigned long addr,
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 68d5f2a27f38..38441113c202 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -271,7 +271,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 		tsk->thread.address = addr;
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = entry;
-		force_sig_fault(SIGSEGV, si_code, (void __user *)addr, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)addr, current);
 		return;
 	}
 
@@ -340,7 +340,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = entry;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr, current);
 
 	return;
 
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index dc4dbafc1d83..f8b3a5a6ba3a 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -213,7 +213,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	/* User mode accesses just cause a SIGSEGV */
 
 	if (user_mode(regs)) {
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
 		return;
 	}
 
@@ -278,7 +278,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 71445a928c1b..6d67892dfc82 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -76,7 +76,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		show_regs(regs);
 	}
 
-	force_sig_fault(signo, code, (void __user *)addr, tsk);
+	force_sig_fault(signo, code, (void __user *)addr, current);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index a0fa8fc88739..fe261b0983cc 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -560,7 +560,7 @@ static int ieee_fpe_handler(struct pt_regs *regs)
 			task_thread_info(tsk)->status |= TS_USEDFPU;
 		} else {
 			force_sig_fault(SIGFPE, FPE_FLTINV,
-					(void __user *)regs->pc, tsk);
+					(void __user *)regs->pc, current);
 		}
 
 		regs->pc = nextpc;
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index cadee0b3b4e0..313547a93513 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -124,7 +124,7 @@ static void __do_user_fault(unsigned long addr, unsigned int fsr,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	force_sig_fault(sig, code, (void __user *)addr, tsk);
+	force_sig_fault(sig, code, (void __user *)addr, current);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 00148141f138..34d27b2dc7a1 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1369,7 +1369,7 @@ void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
 
 	/* Send us the fake SIGTRAP */
 	force_sig_fault(SIGTRAP, si_code,
-			user_mode(regs) ? (void __user *)regs->ip : NULL, tsk);
+			user_mode(regs) ? (void __user *)regs->ip : NULL, current);
 }
 
 void user_single_step_report(struct pt_regs *regs)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 30a9b843ef04..945b9a0719dd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -256,7 +256,7 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 	if (!sicode)
 		force_sig(signr);
 	else
-		force_sig_fault(signr, sicode, addr, tsk);
+		force_sig_fault(signr, sicode, addr, current);
 }
 NOKPROBE_SYMBOL(do_trap);
 
@@ -856,7 +856,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 		return;
 
 	force_sig_fault(SIGFPE, si_code,
-			(void __user *)uprobe_get_trap_addr(regs), task);
+			(void __user *)uprobe_get_trap_addr(regs), current);
 }
 
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index f8f3cfda01ae..68cdcd717c85 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -277,7 +277,7 @@ static void force_sig_info_umip_fault(void __user *addr, struct pt_regs *regs)
 	tsk->thread.error_code	= X86_PF_USER | X86_PF_WRITE;
 	tsk->thread.trap_nr	= X86_TRAP_PF;
 
-	force_sig_fault(SIGSEGV, SEGV_MAPERR, addr, tsk);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, addr, current);
 
 	if (!(show_unhandled_signals && unhandled_signal(tsk, SIGSEGV)))
 		return;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index c431326ee3fa..16a5d1b615a7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -757,7 +757,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 
 			/* XXX: hwpoison faults will set the wrong code. */
 			force_sig_fault(signal, si_code, (void __user *)address,
-					tsk);
+					current);
 		}
 
 		/*
@@ -918,7 +918,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		if (si_code == SEGV_PKUERR)
 			force_sig_pkuerr((void __user *)address, pkey);
 
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
 
 		return;
 	}
@@ -1044,7 +1044,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		return;
 	}
 #endif
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 }
 
 static noinline void
-- 
2.21.0

