Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3048C43519B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTRrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:04 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43236 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhJTRrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50106)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdt-00EwFv-6u; Wed, 20 Oct 2021 11:44:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdr-001NdN-Pm; Wed, 20 Oct 2021 11:44:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
        Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 20 Oct 2021 12:43:48 -0500
Message-Id: <20211020174406.17889-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFdr-001NdN-Pm;;;mid=<20211020174406.17889-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19nG1BU9vuOxSJ3RVrs7nPXsAhjXwuaEMI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 823 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.5%), b_tie_ro: 3.1 (0.4%), parse: 1.62
        (0.2%), extract_message_metadata: 33 (4.0%), get_uri_detail_list: 6
        (0.8%), tests_pri_-1000: 25 (3.1%), tests_pri_-950: 1.10 (0.1%),
        tests_pri_-900: 0.88 (0.1%), tests_pri_-90: 164 (20.0%), check_bayes:
        137 (16.6%), b_tokenize: 16 (2.0%), b_tok_get_all: 13 (1.6%),
        b_comp_prob: 3.1 (0.4%), b_tok_touch_all: 101 (12.3%), b_finish: 0.76
        (0.1%), tests_pri_0: 578 (70.3%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 5 (0.7%), poll_dns_idle: 0.17 (0.0%), tests_pri_10:
        2.6 (0.3%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 02/20] exit: Remove calls of do_exit after noreturn versions of die
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On nds32, openrisc, s390, sh, and xtensa the function die never
returns.  Mark die __noreturn so that no one expects die to return.
Remove the do_exit calls after die as they will never be reached.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Fixes: 2.3.16
Fixes: 2.3.99-pre8
Fixes: 3f65ce4d141e ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 5")
Fixes: 664eec400bf8 ("nds32: MMU fault handling and page table management")
Fixes: 61e85e367535 ("OpenRISC: Memory management")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nds32/kernel/traps.c      | 2 +-
 arch/nds32/mm/fault.c          | 6 +-----
 arch/openrisc/kernel/traps.c   | 2 +-
 arch/openrisc/mm/fault.c       | 4 +---
 arch/s390/include/asm/kdebug.h | 2 +-
 arch/s390/kernel/dumpstack.c   | 2 +-
 arch/s390/mm/fault.c           | 2 --
 arch/sh/kernel/traps.c         | 2 +-
 arch/sh/mm/fault.c             | 2 --
 arch/xtensa/kernel/traps.c     | 2 +-
 arch/xtensa/mm/fault.c         | 3 +--
 11 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index f06421c645af..ca75d475eda4 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -118,7 +118,7 @@ DEFINE_SPINLOCK(die_lock);
 /*
  * This function is protected against re-entrancy.
  */
-void die(const char *str, struct pt_regs *regs, int err)
+void __noreturn die(const char *str, struct pt_regs *regs, int err)
 {
 	struct task_struct *tsk = current;
 	static int die_counter;
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index f02524eb6d56..1d139b117168 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -13,7 +13,7 @@
 
 #include <asm/tlbflush.h>
 
-extern void die(const char *str, struct pt_regs *regs, long err);
+extern void __noreturn die(const char *str, struct pt_regs *regs, long err);
 
 /*
  * This is useful to dump out the page tables associated with
@@ -299,10 +299,6 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 
 	show_pte(mm, addr);
 	die("Oops", regs, error_code);
-	bust_spinlocks(0);
-	do_exit(SIGKILL);
-
-	return;
 
 	/*
 	 * We ran out of memory, or some other thing happened to us that made
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index aa1e709405ac..0898cb159fac 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -197,7 +197,7 @@ void nommu_dump_state(struct pt_regs *regs,
 }
 
 /* This is normally the 'Oops' routine */
-void die(const char *str, struct pt_regs *regs, long err)
+void __noreturn die(const char *str, struct pt_regs *regs, long err)
 {
 
 	console_verbose();
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index c730d1a51686..f0fa6394a58e 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -32,7 +32,7 @@ unsigned long pte_errors;	/* updated by do_page_fault() */
  */
 volatile pgd_t *current_pgd[NR_CPUS];
 
-extern void die(char *, struct pt_regs *, long);
+extern void __noreturn die(char *, struct pt_regs *, long);
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -248,8 +248,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	die("Oops", regs, write_acc);
 
-	do_exit(SIGKILL);
-
 	/*
 	 * We ran out of memory, or some other thing happened to us that made
 	 * us unable to handle the page fault gracefully.
diff --git a/arch/s390/include/asm/kdebug.h b/arch/s390/include/asm/kdebug.h
index d5327f064799..4377238e4752 100644
--- a/arch/s390/include/asm/kdebug.h
+++ b/arch/s390/include/asm/kdebug.h
@@ -23,6 +23,6 @@ enum die_val {
 	DIE_NMI_IPI,
 };
 
-extern void die(struct pt_regs *, const char *);
+extern void __noreturn die(struct pt_regs *, const char *);
 
 #endif
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index db1bc00229ca..f45e66b8bed6 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -192,7 +192,7 @@ void show_regs(struct pt_regs *regs)
 
 static DEFINE_SPINLOCK(die_lock);
 
-void die(struct pt_regs *regs, const char *str)
+void __noreturn die(struct pt_regs *regs, const char *str)
 {
 	static int die_counter;
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 212632d57db9..d30f5986fa85 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -260,7 +260,6 @@ static noinline void do_no_context(struct pt_regs *regs)
 		       " in virtual user address space\n");
 	dump_fault_info(regs);
 	die(regs, "Oops");
-	do_exit(SIGKILL);
 }
 
 static noinline void do_low_address(struct pt_regs *regs)
@@ -270,7 +269,6 @@ static noinline void do_low_address(struct pt_regs *regs)
 	if (regs->psw.mask & PSW_MASK_PSTATE) {
 		/* Low-address protection hit in user mode 'cannot happen'. */
 		die (regs, "Low-address protection");
-		do_exit(SIGKILL);
 	}
 
 	do_no_context(regs);
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index e76b22157099..cbe3201d4f21 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -20,7 +20,7 @@
 
 static DEFINE_SPINLOCK(die_lock);
 
-void die(const char *str, struct pt_regs *regs, long err)
+void __noreturn die(const char *str, struct pt_regs *regs, long err)
 {
 	static int die_counter;
 
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 88a1f453d73e..1e1aa75df3ca 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -238,8 +238,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	show_fault_oops(regs, address);
 
 	die("Oops", regs, error_code);
-	bust_spinlocks(0);
-	do_exit(SIGKILL);
 }
 
 static void
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 874b6efc6fb3..fb056a191339 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -527,7 +527,7 @@ void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 
 DEFINE_SPINLOCK(die_lock);
 
-void die(const char * str, struct pt_regs * regs, long err)
+void __noreturn die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
 	const char *pr = "";
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 95a74890c7e9..fd6a70635962 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -238,7 +238,7 @@ void do_page_fault(struct pt_regs *regs)
 void
 bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 {
-	extern void die(const char*, struct pt_regs*, long);
+	extern void __noreturn die(const char*, struct pt_regs*, long);
 	const struct exception_table_entry *entry;
 
 	/* Are we prepared to handle this kernel fault?  */
@@ -257,5 +257,4 @@ bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 		 "address %08lx\n pc = %08lx, ra = %08lx\n",
 		 address, regs->pc, regs->areg[0]);
 	die("Oops", regs, sig);
-	do_exit(sig);
 }
-- 
2.20.1

