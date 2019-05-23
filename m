Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD37273CA
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfEWBGs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:06:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51341 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfEWBGr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:06:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp8-0002LN-Sc; Wed, 22 May 2019 18:43:10 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnO-0005Z3-JK; Wed, 22 May 2019 18:41:24 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:03 -0500
Message-Id: <20190523003916.20726-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnO-0005Z3-JK;;;mid=<20190523003916.20726-14-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Dez3gsl4HM7Z/Ie2zWYu2qafvElswi/Y=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMGappySubj_01,
        XMNoVowels,XMSubLong,XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1314 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.2 (0.2%), b_tie_ro: 2.2 (0.2%), parse: 0.86
        (0.1%), extract_message_metadata: 11 (0.8%), get_uri_detail_list: 1.20
        (0.1%), tests_pri_-1000: 12 (0.9%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 19 (1.4%), check_bayes: 17
        (1.3%), b_tokenize: 6 (0.4%), b_tok_get_all: 4.9 (0.4%), b_comp_prob:
        1.63 (0.1%), b_tok_touch_all: 3.0 (0.2%), b_finish: 0.63 (0.0%),
        tests_pri_0: 1251 (95.3%), check_dkim_signature: 0.50 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.57 (0.0%), tests_pri_10:
        3.3 (0.3%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 13/26] signal/sh: Remove tsk parameter from force_sig_info_fault
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The force_sig_info_fault function is always called with tsk == current.
Make that explicit by removing the tsk parameter.

This also makes it clear that the sh force_sig_info_fault passes
current into force_sig_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sh/mm/fault.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 6defd2c6d9b1..851a3cbb2b9c 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -39,10 +39,9 @@ static inline int notify_page_fault(struct pt_regs *regs, int trap)
 }
 
 static void
-force_sig_info_fault(int si_signo, int si_code, unsigned long address,
-		     struct task_struct *tsk)
+force_sig_info_fault(int si_signo, int si_code, unsigned long address)
 {
-	force_sig_fault(si_signo, si_code, (void __user *)address, tsk);
+	force_sig_fault(si_signo, si_code, (void __user *)address, current);
 }
 
 /*
@@ -244,8 +243,6 @@ static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, int si_code)
 {
-	struct task_struct *tsk = current;
-
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		/*
@@ -253,7 +250,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		 */
 		local_irq_enable();
 
-		force_sig_info_fault(SIGSEGV, si_code, address, tsk);
+		force_sig_info_fault(SIGSEGV, si_code, address);
 
 		return;
 	}
@@ -308,7 +305,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 	if (!user_mode(regs))
 		no_context(regs, error_code, address);
 
-	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
+	force_sig_info_fault(SIGBUS, BUS_ADRERR, address);
 }
 
 static noinline int
-- 
2.21.0

