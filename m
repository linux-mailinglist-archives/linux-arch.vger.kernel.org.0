Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7243558D
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 23:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJTVy1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 17:54:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51492 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTVy0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 17:54:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:40000)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdJVD-00FiWe-CQ; Wed, 20 Oct 2021 15:52:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:59328 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdJVA-002PXD-JP; Wed, 20 Oct 2021 15:52:02 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Maciej Rozycki <macro@orcam.me.uk>, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <87y26nmwkb.fsf@disp2133>
Date:   Wed, 20 Oct 2021 16:51:52 -0500
In-Reply-To: <87y26nmwkb.fsf@disp2133> (Eric W. Biederman's message of "Wed,
        20 Oct 2021 12:32:20 -0500")
Message-ID: <877de7jrev.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdJVA-002PXD-JP;;;mid=<877de7jrev.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ePEKUK1liVK4VGBQcsP6jPz9QJs+YQsA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_Symld_Words,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1553 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.12
        (0.1%), extract_message_metadata: 13 (0.8%), get_uri_detail_list: 2.4
        (0.2%), tests_pri_-1000: 17 (1.1%), tests_pri_-950: 1.59 (0.1%),
        tests_pri_-900: 1.24 (0.1%), tests_pri_-90: 85 (5.5%), check_bayes: 83
        (5.4%), b_tokenize: 16 (1.1%), b_tok_get_all: 10 (0.7%), b_comp_prob:
        3.1 (0.2%), b_tok_touch_all: 49 (3.2%), b_finish: 0.85 (0.1%),
        tests_pri_0: 1408 (90.7%), check_dkim_signature: 0.63 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.55 (0.0%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 9 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 21/20] signal: Replace force_sigsegv(SIGSEGV) with force_fatal_sig(SIGSEGV)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Now that force_fatal_sig exists it is unnecessary and a bit confusing
to use force_sigsegv in cases where the simpler force_fatal_sig is
wanted.  So change every instance we can to make the code clearer.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/kernel/process.c       | 2 +-
 arch/m68k/kernel/traps.c        | 2 +-
 arch/powerpc/kernel/signal_32.c | 2 +-
 arch/powerpc/kernel/signal_64.c | 4 ++--
 arch/s390/kernel/traps.c        | 2 +-
 arch/um/kernel/trap.c           | 2 +-
 arch/x86/kernel/vm86_32.c       | 2 +-
 fs/exec.c                       | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 3793876f42d9..8e90052f6f05 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -294,7 +294,7 @@ int elf_check_arch(const struct elf32_hdr *x)
 	eflags = x->e_flags;
 	if ((eflags & EF_ARC_OSABI_MSK) != EF_ARC_OSABI_CURRENT) {
 		pr_err("ABI mismatch - you need newer toolchain\n");
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 		return 0;
 	}
 
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 5b19fcdcd69e..74045d164ddb 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1150,7 +1150,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	force_sigsegv(SIGSEGV);
+	force_fatal_sig(SIGSEGV);
 }
 
 #ifdef CONFIG_M68KFPU_EMU
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 666f3da41232..933ab95805a6 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1063,7 +1063,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
 	if (do_setcontext(new_ctx, regs, 0)) {
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 		return -EFAULT;
 	}
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index d8de622c9e4a..8ead9b3f47c6 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -704,7 +704,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 */
 
 	if (__get_user_sigset(&set, &new_ctx->uc_sigmask)) {
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 		return -EFAULT;
 	}
 	set_current_blocked(&set);
@@ -713,7 +713,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 		return -EFAULT;
 	if (__unsafe_restore_sigcontext(current, NULL, 0, &new_ctx->uc_mcontext)) {
 		user_read_access_end();
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 		return -EFAULT;
 	}
 	user_read_access_end();
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 51729ea2cf8e..01a7c68dcfb6 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		report_user_fault(regs, SIGSEGV, 0);
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 	} else
 		die(regs, "Unknown program exception");
 }
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 3198c4767387..c32efb09db21 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -158,7 +158,7 @@ static void bad_segv(struct faultinfo fi, unsigned long ip)
 
 void fatal_sigsegv(void)
 {
-	force_sigsegv(SIGSEGV);
+	force_fatal_sig(SIGSEGV);
 	do_signal(&current->thread.regs);
 	/*
 	 * This is to tell gcc that we're not returning - do_signal
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 040fd01be8b3..7ff0f622abd4 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -159,7 +159,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	user_access_end();
 Efault:
 	pr_alert("could not access userspace vm86 info\n");
-	force_sigsegv(SIGSEGV);
+	force_fatal_sig(SIGSEGV);
 }
 
 static int do_vm86_irq_handling(int subfunction, int irqnumber);
diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..ac7b51b51f38 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1852,7 +1852,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	 * SIGSEGV.
 	 */
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 
 out_unmark:
 	current->fs->in_exec = 0;
-- 
2.20.1

