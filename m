Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9FB27367
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 02:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfEWAnJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 20:43:09 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60219 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWAnI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp5-0004Gc-Tg; Wed, 22 May 2019 18:43:07 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnH-0005Z3-I1; Wed, 22 May 2019 18:41:17 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:01 -0500
Message-Id: <20190523003916.20726-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnH-0005Z3-I1;;;mid=<20190523003916.20726-12-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+jkMCLauOPdUuvIO2RUyqNlzjpQFku4Kc=
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
X-Spam-Timing: total 1316 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.3 (0.2%), b_tie_ro: 1.66 (0.1%), parse: 0.77
        (0.1%), extract_message_metadata: 11 (0.8%), get_uri_detail_list: 1.52
        (0.1%), tests_pri_-1000: 12 (0.9%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 20 (1.5%), check_bayes: 18
        (1.4%), b_tokenize: 7 (0.5%), b_tok_get_all: 5 (0.4%), b_comp_prob:
        1.77 (0.1%), b_tok_touch_all: 2.9 (0.2%), b_finish: 0.58 (0.0%),
        tests_pri_0: 1258 (95.6%), check_dkim_signature: 0.52 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.87 (0.1%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 11/26] signal/x86: Remove task parameter from send_sigtrap
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The send_sigtrap function is always called with task == current.  Make
that explicit by removing the task parameter.

This also makes it clear that the x86 send_sigtrap passes current
into force_sig_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/include/asm/ptrace.h | 3 +--
 arch/x86/kernel/ptrace.c      | 7 ++++---
 arch/x86/kernel/traps.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 8a7fc0cca2d1..28779bf7951f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -102,8 +102,7 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 
 extern unsigned long
 convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
-extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
-			 int error_code, int si_code);
+extern void send_sigtrap(struct pt_regs *regs, int error_code, int si_code);
 
 
 static inline unsigned long regs_return_value(struct pt_regs *regs)
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4b8ee05dd6ad..00148141f138 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1360,9 +1360,10 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 #endif
 }
 
-void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
-					 int error_code, int si_code)
+void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
 {
+	struct task_struct *tsk = current;
+
 	tsk->thread.trap_nr = X86_TRAP_DB;
 	tsk->thread.error_code = error_code;
 
@@ -1373,5 +1374,5 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 
 void user_single_step_report(struct pt_regs *regs)
 {
-	send_sigtrap(current, regs, 0, TRAP_BRKPT);
+	send_sigtrap(regs, 0, TRAP_BRKPT);
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e54f0cad4b2e..30a9b843ef04 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -805,7 +805,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	}
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(tsk, regs, error_code, si_code);
+		send_sigtrap(regs, error_code, si_code);
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
 
-- 
2.21.0

