Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24726273BF
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfEWBDm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:03:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51064 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBDm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:03:42 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp6-0002Kv-MP; Wed, 22 May 2019 18:43:08 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnR-0005Z3-V0; Wed, 22 May 2019 18:41:27 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:04 -0500
Message-Id: <20190523003916.20726-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnR-0005Z3-V0;;;mid=<20190523003916.20726-15-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX198nWOmUK3Py8VI44L4UWTcum7rWXYlsGU=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4970]
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1393 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.9 (0.3%), b_tie_ro: 2.7 (0.2%), parse: 1.49
        (0.1%), extract_message_metadata: 19 (1.4%), get_uri_detail_list: 3.2
        (0.2%), tests_pri_-1000: 19 (1.4%), tests_pri_-950: 1.80 (0.1%),
        tests_pri_-900: 1.39 (0.1%), tests_pri_-90: 27 (2.0%), check_bayes: 25
        (1.8%), b_tokenize: 11 (0.8%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        2.5 (0.2%), b_tok_touch_all: 3.4 (0.2%), b_finish: 0.73 (0.1%),
        tests_pri_0: 1301 (93.4%), check_dkim_signature: 0.58 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.62 (0.0%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 11 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 14/26] signal/riscv: Remove tsk parameter from do_trap
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The do_trap function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This also makes it clear that do_trap calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/riscv/include/asm/bug.h | 2 +-
 arch/riscv/kernel/traps.c    | 7 ++++---
 arch/riscv/mm/fault.c        | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 52a1fbdeab3b..f1390914ba7a 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -94,7 +94,7 @@ struct task_struct;
 
 extern void die(struct pt_regs *regs, const char *str);
 extern void do_trap(struct pt_regs *regs, int signo, int code,
-	unsigned long addr, struct task_struct *tsk);
+	unsigned long addr);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3d1a651dc54c..71445a928c1b 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -63,9 +63,10 @@ void die(struct pt_regs *regs, const char *str)
 		do_exit(SIGSEGV);
 }
 
-void do_trap(struct pt_regs *regs, int signo, int code,
-	unsigned long addr, struct task_struct *tsk)
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
+	struct task_struct *tsk = current;
+
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -82,7 +83,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	unsigned long addr, const char *str)
 {
 	if (user_mode(regs)) {
-		do_trap(regs, signo, code, addr, current);
+		do_trap(regs, signo, code, addr);
 	} else {
 		if (!fixup_exception(regs))
 			die(regs, str);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index cec8be9e2d6a..0a0081d9b766 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -181,7 +181,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	up_read(&mm->mmap_sem);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
-		do_trap(regs, SIGSEGV, code, addr, tsk);
+		do_trap(regs, SIGSEGV, code, addr);
 		return;
 	}
 
@@ -217,7 +217,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
 		goto no_context;
-	do_trap(regs, SIGBUS, BUS_ADRERR, addr, tsk);
+	do_trap(regs, SIGBUS, BUS_ADRERR, addr);
 	return;
 
 vmalloc_fault:
@@ -231,7 +231,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 
 		/* User mode accesses just cause a SIGSEGV */
 		if (user_mode(regs))
-			return do_trap(regs, SIGSEGV, code, addr, tsk);
+			return do_trap(regs, SIGSEGV, code, addr);
 
 		/*
 		 * Synchronize this task's top level page-table
-- 
2.21.0

