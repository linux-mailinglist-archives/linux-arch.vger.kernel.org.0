Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2E273CC
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfEWBGy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:06:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51358 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfEWBGy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:06:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp8-0002LD-6H; Wed, 22 May 2019 18:43:10 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTboN-0005Z3-6H; Wed, 22 May 2019 18:42:24 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:15 -0500
Message-Id: <20190523003916.20726-26-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTboN-0005Z3-6H;;;mid=<20190523003916.20726-26-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+g8DFysIKhXEKVK8Zn0fgdaKJhS9xr850=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ******
X-Spam-Status: No, score=6.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_Symld_Words,T_TooManySym_01,
        XMGappySubj_01,XMGappySubj_02,XMNoVowels,XMSubLong,XM_H_QuotedFrom
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.0 XMGappySubj_02 Gappier still
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1315 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.3 (0.3%), b_tie_ro: 2.3 (0.2%), parse: 0.79
        (0.1%), extract_message_metadata: 11 (0.8%), get_uri_detail_list: 1.32
        (0.1%), tests_pri_-1000: 12 (0.9%), tests_pri_-950: 1.28 (0.1%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 19 (1.5%), check_bayes: 18
        (1.3%), b_tokenize: 6 (0.4%), b_tok_get_all: 5 (0.4%), b_comp_prob:
        1.77 (0.1%), b_tok_touch_all: 2.7 (0.2%), b_finish: 0.58 (0.0%),
        tests_pri_0: 1255 (95.4%), check_dkim_signature: 0.51 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.76 (0.1%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 6 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 25/26] signal: Factor force_sig_info_to_task out of force_sig_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All callers of force_sig_info pass info.si_signo in for the signal
by definition as well as in practice.

Further all callers of force_sig_info except force_sig_fault_to_task
pass current as the target task to force_sig_info.

Factor out a static force_sig_info_to_task that
force_sig_fault_to_task can call.

This prepares the way for force_sig_info to have it's task and signal
parameters removed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d5f9ed5da9c5..0984158cd41a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1294,12 +1294,13 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
  * We don't want to have recursive SIGSEGV's etc, for example,
  * that is why we also clear SIGNAL_UNKILLABLE.
  */
-int
-force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
+static int
+force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 {
 	unsigned long int flags;
 	int ret, blocked, ignored;
 	struct k_sigaction *action;
+	int sig = info->si_signo;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action = &t->sighand->action[sig-1];
@@ -1324,6 +1325,11 @@ force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
 	return ret;
 }
 
+int force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
+{
+	return force_sig_info_to_task(info, t);
+}
+
 /*
  * Nuke all other threads in the group.
  */
@@ -1656,7 +1662,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 	info.si_flags = flags;
 	info.si_isr = isr;
 #endif
-	return force_sig_info(info.si_signo, &info, t);
+	return force_sig_info_to_task(&info, t);
 }
 
 int force_sig_fault(int sig, int code, void __user *addr
-- 
2.21.0

