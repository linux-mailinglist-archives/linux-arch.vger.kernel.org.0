Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC32736B
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 02:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfEWAnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 20:43:11 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60230 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfEWAnK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:10 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp7-0004Gu-Ak; Wed, 22 May 2019 18:43:09 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbo6-0005Z3-UC; Wed, 22 May 2019 18:42:15 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:12 -0500
Message-Id: <20190523003916.20726-23-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbo6-0005Z3-UC;;;mid=<20190523003916.20726-23-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19f1D+e/1BfTbUenFf81yBjfafK2F1Fs2A=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMGappySubj_01,XMNoVowels,XMSubLong,XM_H_QuotedFrom
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 8015 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.4 (0.0%), b_tie_ro: 2.4 (0.0%), parse: 0.99
        (0.0%), extract_message_metadata: 11 (0.1%), get_uri_detail_list: 1.49
        (0.0%), tests_pri_-1000: 9 (0.1%), tests_pri_-950: 1.09 (0.0%),
        tests_pri_-900: 0.82 (0.0%), tests_pri_-90: 16 (0.2%), check_bayes: 15
        (0.2%), b_tokenize: 4.4 (0.1%), b_tok_get_all: 4.9 (0.1%),
        b_comp_prob: 1.15 (0.0%), b_tok_touch_all: 2.5 (0.0%), b_finish: 0.62
        (0.0%), tests_pri_0: 1173 (14.6%), check_dkim_signature: 0.36 (0.0%),
        check_dkim_adsp: 2.1 (0.0%), poll_dns_idle: 6785 (84.7%),
        tests_pri_10: 2.8 (0.0%), tests_pri_500: 6794 (84.8%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 22/26] signal: Properly set TRACE_SIGNAL_LOSE_INFO in __send_signal
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Any time siginfo is not stored in the signal queue information is
lost.  Therefore set TRACE_SIGNAL_LOSE_INFO every time the code does
not allocate a signal queue entry, and a queue overflow abort is not
triggered.

Fixes: ba005e1f4172 ("tracepoint: Add signal loss events")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d92b636b4e9d..b2f0cf3a68aa 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1131,23 +1131,22 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 			copy_siginfo(&q->info, info);
 			break;
 		}
-	} else if (!is_si_special(info)) {
-		if (sig >= SIGRTMIN && info->si_code != SI_USER) {
-			/*
-			 * Queue overflow, abort.  We may abort if the
-			 * signal was rt and sent by user using something
-			 * other than kill().
-			 */
-			result = TRACE_SIGNAL_OVERFLOW_FAIL;
-			ret = -EAGAIN;
-			goto ret;
-		} else {
-			/*
-			 * This is a silent loss of information.  We still
-			 * send the signal, but the *info bits are lost.
-			 */
-			result = TRACE_SIGNAL_LOSE_INFO;
-		}
+	} else if (!is_si_special(info) &&
+		   sig >= SIGRTMIN && info->si_code != SI_USER) {
+		/*
+		 * Queue overflow, abort.  We may abort if the
+		 * signal was rt and sent by user using something
+		 * other than kill().
+		 */
+		result = TRACE_SIGNAL_OVERFLOW_FAIL;
+		ret = -EAGAIN;
+		goto ret;
+	} else {
+		/*
+		 * This is a silent loss of information.  We still
+		 * send the signal, but the *info bits are lost.
+		 */
+		result = TRACE_SIGNAL_LOSE_INFO;
 	}
 
 out_set:
-- 
2.21.0

