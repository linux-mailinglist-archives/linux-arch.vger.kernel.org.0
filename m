Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA21273DB
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfEWBPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:15:35 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59429 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWBPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:15:35 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp7-0008Ri-Nd; Wed, 22 May 2019 18:43:09 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnf-0005Z3-5l; Wed, 22 May 2019 18:41:48 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:08 -0500
Message-Id: <20190523003916.20726-19-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnf-0005Z3-5l;;;mid=<20190523003916.20726-19-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+bKbUzlq5gxopT7fPoQdp0fJB4iJOIX4M=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 9053 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.3 (0.0%), b_tie_ro: 2.3 (0.0%), parse: 0.99
        (0.0%), extract_message_metadata: 11 (0.1%), get_uri_detail_list: 1.60
        (0.0%), tests_pri_-1000: 9 (0.1%), tests_pri_-950: 1.07 (0.0%),
        tests_pri_-900: 0.83 (0.0%), tests_pri_-90: 17 (0.2%), check_bayes: 16
        (0.2%), b_tokenize: 4.7 (0.1%), b_tok_get_all: 5 (0.1%), b_comp_prob:
        1.38 (0.0%), b_tok_touch_all: 2.9 (0.0%), b_finish: 0.60 (0.0%),
        tests_pri_0: 1179 (13.0%), check_dkim_signature: 0.36 (0.0%),
        check_dkim_adsp: 2.1 (0.0%), poll_dns_idle: 7818 (86.4%),
        tests_pri_10: 1.78 (0.0%), tests_pri_500: 7826 (86.4%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 18/26] signal/unicore32: Remove tsk parameter from __do_user_fault
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The __do_user_fault function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This makes it clear that __do_user_fault calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/mm/fault.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index b9a3a50644c1..cadee0b3b4e0 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -116,10 +116,11 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
  * Something tried to access memory that isn't in our memory map..
  * User mode accesses just cause a SIGSEGV
  */
-static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
-		unsigned int fsr, unsigned int sig, int code,
-		struct pt_regs *regs)
+static void __do_user_fault(unsigned long addr, unsigned int fsr,
+			    unsigned int sig, int code,	struct pt_regs *regs)
 {
+	struct task_struct *tsk = current;
+
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
@@ -136,7 +137,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * have no context to handle this fault with.
 	 */
 	if (user_mode(regs))
-		__do_user_fault(tsk, addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	else
 		__do_kernel_fault(mm, addr, fsr, regs);
 }
@@ -310,7 +311,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		code = fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR;
 	}
 
-	__do_user_fault(tsk, addr, fsr, sig, code, regs);
+	__do_user_fault(addr, fsr, sig, code, regs);
 	return 0;
 
 no_context:
-- 
2.21.0

