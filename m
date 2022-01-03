Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AFD483880
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiACVeP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:34:15 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55732 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiACVeA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:34:00 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:54216)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxr-008wCI-UK; Mon, 03 Jan 2022 14:33:59 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxq-006zvm-VO; Mon, 03 Jan 2022 14:33:59 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:07 -0600
Message-Id: <20220103213312.9144-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxq-006zvm-VO;;;mid=<20220103213312.9144-12-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19dmJ8eKxvuQTy3KtHmk9FlXTI4tuhzGNw=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 370 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (3.2%), b_tie_ro: 10 (2.8%), parse: 1.08
        (0.3%), extract_message_metadata: 13 (3.4%), get_uri_detail_list: 1.61
        (0.4%), tests_pri_-1000: 14 (3.7%), tests_pri_-950: 1.19 (0.3%),
        tests_pri_-900: 0.99 (0.3%), tests_pri_-90: 89 (24.0%), check_bayes:
        87 (23.6%), b_tokenize: 6 (1.7%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.91 (0.5%), b_tok_touch_all: 70 (18.8%), b_finish: 0.94
        (0.3%), tests_pri_0: 226 (60.9%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.8 (0.8%), poll_dns_idle: 1.08 (0.3%), tests_pri_10:
        3.0 (0.8%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 12/17] signal: Compute the process exit_code in get_signal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In prepartion for moving the work of sys_exit and sys_group_exit into
get_signal compute exit_code in get_signal, make PF_SIGNALED depend on
the exit_code and pass the exit_code to do_group_exit.

Anytime there is a group exit the exit_code may differ from the signal
number.

To match the historical precedent as best I can make the exit_code 0
during exec. (The exit_code field would not have been set but probably
would have been left at a value of 0).

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index fd3c404de8b6..2a24cca00ca1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2707,6 +2707,7 @@ bool get_signal(struct ksignal *ksig)
 	for (;;) {
 		struct k_sigaction *ka;
 		enum pid_type type;
+		int exit_code;
 
 		/* Has this task already been marked for death? */
 		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
@@ -2716,6 +2717,10 @@ bool get_signal(struct ksignal *ksig)
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
 				&sighand->action[SIGKILL - 1]);
 			recalc_sigpending();
+			if (signal->flags & SIGNAL_GROUP_EXIT)
+				exit_code = signal->group_exit_code;
+			else
+				exit_code = 0;
 			goto fatal;
 		}
 
@@ -2837,15 +2842,17 @@ bool get_signal(struct ksignal *ksig)
 			continue;
 		}
 
+		/*
+		 * Anything else is fatal, maybe with a core dump.
+		 */
+		exit_code = signr;
 	fatal:
 		spin_unlock_irq(&sighand->siglock);
 		if (unlikely(cgroup_task_frozen(current)))
 			cgroup_leave_frozen(true);
 
-		/*
-		 * Anything else is fatal, maybe with a core dump.
-		 */
-		current->flags |= PF_SIGNALED;
+		if (exit_code & 0x7f)
+			current->flags |= PF_SIGNALED;
 
 		if (sig_kernel_coredump(signr)) {
 			if (print_fatal_signals)
@@ -2873,7 +2880,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Death signals, no core dump.
 		 */
-		do_group_exit(ksig->info.si_signo);
+		do_group_exit(exit_code);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-- 
2.29.2

