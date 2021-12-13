Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC50147380B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbhLMWym (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:54:42 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:41786 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbhLMWyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:54:41 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:50904)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDQ-0081Vk-QH; Mon, 13 Dec 2021 15:54:40 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60446 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDP-007pqT-NN; Mon, 13 Dec 2021 15:54:40 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 13 Dec 2021 16:53:44 -0600
Message-Id: <20211213225350.27481-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mwuDP-007pqT-NN;;;mid=<20211213225350.27481-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+c92wFPwUv8392NprGtfCDOlVLwBLUWmE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5011]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 394 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 14 (3.6%), b_tie_ro: 12 (3.1%), parse: 1.12
        (0.3%), extract_message_metadata: 13 (3.3%), get_uri_detail_list: 1.89
        (0.5%), tests_pri_-1000: 13 (3.4%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 1.19 (0.3%), tests_pri_-90: 79 (20.2%), check_bayes:
        78 (19.7%), b_tokenize: 6 (1.6%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 56 (14.1%), b_finish: 1.36
        (0.3%), tests_pri_0: 257 (65.4%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 3.5 (0.9%), poll_dns_idle: 1.68 (0.4%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/8] signal: Drop signals received after a fatal signal has been processed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In 403bad72b67d ("coredump: only SIGKILL should interrupt the
coredumping task") Oleg modified the kernel to drop all signals that
come in during a coredump except SIGKILL, and suggested that it might
be a good idea to generalize that to other cases after the process has
received a fatal signal.

Semantically it does not make sense to perform any signal delivery
after the process has already been killed.

When a signal is sent while a process is dying today the signal is
placed in the signal queue by __send_signal and a single task of the
process is woken up with signal_wake_up, if there are any tasks that
have not set PF_EXITING.

Take things one step farther and have prepare_signal report that all
signals that come after a process has been killed should be ignored.
While retaining the historical exception of allowing SIGKILL to
interrupt coredumps.

Remove the SIGNAL_GROUP_EXIT test from complete_signal, as it is no
longer possible for signal processing to reach complete_signal when
SIGNAL_GROUP_EXIT is true.

Update the comment in fs/coredump.c to make it clear coredumps are
special in being able to receive SIGKILL.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c   | 2 +-
 kernel/signal.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7b91fb32dbb8..a9c25f20118f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -352,7 +352,7 @@ static int zap_process(struct task_struct *start, int exit_code, int flags)
 	struct task_struct *t;
 	int nr = 0;
 
-	/* ignore all signals except SIGKILL, see prepare_signal() */
+	/* Allow SIGKILL, see prepare_signal() */
 	start->signal->flags = SIGNAL_GROUP_COREDUMP | flags;
 	start->signal->group_exit_code = exit_code;
 	start->signal->group_stop_count = 0;
diff --git a/kernel/signal.c b/kernel/signal.c
index 7e305a8ec7c2..cdccbacac685 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -914,11 +914,11 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 				sigaddset(&dumper->pending.signal, SIGKILL);
 				signal_wake_up(dumper, 1);
 			}
-			return false;
 		}
 		/*
-		 * The process is in the middle of dying, nothing to do.
+		 * The process is in the middle of dying, drop the signal.
 		 */
+		return false;
 	} else if (sig_kernel_stop(sig)) {
 		/*
 		 * This is a stop signal.  Remove SIGCONT from all queues.
@@ -1039,7 +1039,6 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 	 * then start taking the whole group down immediately.
 	 */
 	if (sig_fatal(p, sig) &&
-	    !(signal->flags & SIGNAL_GROUP_EXIT) &&
 	    !sigismember(&t->real_blocked, sig) &&
 	    (sig == SIGKILL || !p->ptrace)) {
 		/*
-- 
2.29.2

