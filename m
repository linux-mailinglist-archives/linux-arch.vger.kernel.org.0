Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588B3273D8
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfEWBLG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:11:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59223 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfEWBLF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:11:05 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp8-0008Ry-Km; Wed, 22 May 2019 18:43:10 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnL-0005Z3-9t; Wed, 22 May 2019 18:41:20 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:02 -0500
Message-Id: <20190523003916.20726-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnL-0005Z3-9t;;;mid=<20190523003916.20726-13-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18NF+NSl/MsPbgYEADSVfa30hNfSipaa4g=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
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
X-Spam-Timing: total 1291 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.2%), b_tie_ro: 2.0 (0.2%), parse: 0.80
        (0.1%), extract_message_metadata: 10 (0.8%), get_uri_detail_list: 0.95
        (0.1%), tests_pri_-1000: 12 (0.9%), tests_pri_-950: 1.47 (0.1%),
        tests_pri_-900: 1.16 (0.1%), tests_pri_-90: 20 (1.5%), check_bayes: 18
        (1.4%), b_tokenize: 5 (0.4%), b_tok_get_all: 4.8 (0.4%), b_comp_prob:
        1.84 (0.1%), b_tok_touch_all: 2.6 (0.2%), b_finish: 0.64 (0.0%),
        tests_pri_0: 1229 (95.2%), check_dkim_signature: 0.50 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 1.01 (0.1%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 12/26] signal/um: Remove task parameter from send_sigtrap
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The send_sigtrap function is always called with task == current.  Make
that explicit by removing the task parameter.

This also makes it clear that the uml send_sigtrap passes current
into force_sig_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/ptrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 5f47422401e1..1797dfe9ce6d 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -112,13 +112,13 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-static void send_sigtrap(struct task_struct *tsk, struct uml_pt_regs *regs,
-		  int error_code)
+static void send_sigtrap(struct uml_pt_regs *regs, int error_code)
 {
 	/* Send us the fake SIGTRAP */
 	force_sig_fault(SIGTRAP, TRAP_BRKPT,
 			/* User-mode eip? */
-			UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL, tsk);
+			UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL,
+			current);
 }
 
 /*
@@ -147,7 +147,7 @@ void syscall_trace_leave(struct pt_regs *regs)
 
 	/* Fake a debug trap */
 	if (ptraced & PT_DTRACE)
-		send_sigtrap(current, &regs->regs, 0);
+		send_sigtrap(&regs->regs, 0);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
-- 
2.21.0

