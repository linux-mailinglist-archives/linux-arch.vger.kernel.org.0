Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663232736F
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfEWAnO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 20:43:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60238 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfEWAnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbpA-0004H8-5y; Wed, 22 May 2019 18:43:12 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnY-0005Z3-C9; Wed, 22 May 2019 18:41:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:06 -0500
Message-Id: <20190523003916.20726-17-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnY-0005Z3-C9;;;mid=<20190523003916.20726-17-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DU0GZ9Kh8Uxq96KL7LRdVwgLDFTxyl7M=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1411 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 7 (0.5%), b_tie_ro: 4.7 (0.3%), parse: 0.90
        (0.1%), extract_message_metadata: 12 (0.9%), get_uri_detail_list: 1.74
        (0.1%), tests_pri_-1000: 12 (0.9%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.05 (0.1%), tests_pri_-90: 20 (1.4%), check_bayes: 18
        (1.3%), b_tokenize: 6 (0.5%), b_tok_get_all: 5 (0.4%), b_comp_prob:
        1.64 (0.1%), b_tok_touch_all: 2.9 (0.2%), b_finish: 0.64 (0.0%),
        tests_pri_0: 1301 (92.2%), check_dkim_signature: 0.51 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.83 (0.1%), tests_pri_10:
        3.2 (0.2%), tests_pri_500: 49 (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 16/26] signal/arm: Remove tsk parameter from ptrace_break
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The ptrace_break function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This also makes it clear that ptrace_break calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/include/asm/traps.h | 2 +-
 arch/arm/kernel/ptrace.c     | 6 +++---
 arch/arm/kernel/traps.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index a00288d75ee6..172b08ff3760 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -30,7 +30,7 @@ static inline int __in_irqentry_text(unsigned long ptr)
 
 extern void __init early_trap_init(void *);
 extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
-extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
+extern void ptrace_break(struct pt_regs *regs);
 
 extern void *vectors_page;
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 6fa5b6387556..f9cbd08a9075 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -201,15 +201,15 @@ void ptrace_disable(struct task_struct *child)
 /*
  * Handle hitting a breakpoint.
  */
-void ptrace_break(struct task_struct *tsk, struct pt_regs *regs)
+void ptrace_break(struct pt_regs *regs)
 {
 	force_sig_fault(SIGTRAP, TRAP_BRKPT,
-			(void __user *)instruction_pointer(regs), tsk);
+			(void __user *)instruction_pointer(regs), current);
 }
 
 static int break_trap(struct pt_regs *regs, unsigned int instr)
 {
-	ptrace_break(current, regs);
+	ptrace_break(regs);
 	return 0;
 }
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 33af097c454b..288989c7355d 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -606,7 +606,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 
 	case NR(breakpoint): /* SWI BREAK_POINT */
 		regs->ARM_pc -= thumb_mode(regs) ? 2 : 4;
-		ptrace_break(current, regs);
+		ptrace_break(regs);
 		return regs->ARM_r0;
 
 	/*
-- 
2.21.0

