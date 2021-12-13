Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BA1473815
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbhLMWyx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:54:53 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:41836 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbhLMWyt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:54:49 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51148)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDY-0081Wq-Jq; Mon, 13 Dec 2021 15:54:48 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60446 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDX-007pqT-D7; Mon, 13 Dec 2021 15:54:47 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 13 Dec 2021 16:53:47 -0600
Message-Id: <20211213225350.27481-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mwuDX-007pqT-D7;;;mid=<20211213225350.27481-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19D0HVmSWopdKjRTRDZCrYjQyUqNBe5SLc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 416 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.3%), parse: 0.92
        (0.2%), extract_message_metadata: 11 (2.8%), get_uri_detail_list: 1.63
        (0.4%), tests_pri_-1000: 13 (3.1%), tests_pri_-950: 1.19 (0.3%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 76 (18.2%), check_bayes:
        75 (17.9%), b_tokenize: 8 (1.8%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 55 (13.2%), b_finish: 0.80
        (0.2%), tests_pri_0: 290 (69.8%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.7 (0.7%), poll_dns_idle: 0.94 (0.2%), tests_pri_10:
        1.88 (0.5%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 5/8] signal: Remove SIGNAL_GROUP_COREDUMP
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

After the previous cleanups "signal->core_state" is set whenever
SIGNAL_GROUP_COREDUMP is set and "signal->core_state" is tested
whenver the code wants to know if a coredump is in progress.  The
remaining tests of SIGNAL_GROUP_COREDUMP also test to see if
SIGNAL_GROUP_EXIT is set.  Similarly the only place that sets
SIGNAL_GROUP_COREDUMP also sets SIGNAL_GROUP_EXIT.

Which makes SIGNAL_GROUP_COREDUMP unecessary and redundant so
stop setting SIGNAL_GROUP_COREDUMP, stop testing SIGNAL_GROUP_COREDUMP
and remove it's definition makeing the code slightly simpler.

With the setting of SIGNAL_GROUP_COREDUMP gone coredump_finish no
longer needs to clear SIGNAL_GROUP_COREDUMP out of signal->flags
by setting SIGNAL_GROUP_EXIT.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                | 3 +--
 include/linux/sched/signal.h | 3 +--
 kernel/signal.c              | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5e5a90de7be3..2c9d16d4b57a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -353,7 +353,7 @@ static int zap_process(struct task_struct *start, int exit_code)
 	int nr = 0;
 
 	/* Allow SIGKILL, see prepare_signal() */
-	start->signal->flags = SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP;
+	start->signal->flags = SIGNAL_GROUP_EXIT;
 	start->signal->group_exit_code = exit_code;
 	start->signal->group_stop_count = 0;
 
@@ -427,7 +427,6 @@ static void coredump_finish(bool core_dumped)
 	if (core_dumped && !__fatal_signal_pending(current))
 		current->signal->group_exit_code |= 0x80;
 	current->signal->group_exit_task = NULL;
-	current->signal->flags = SIGNAL_GROUP_EXIT;
 	next = current->signal->core_state->dumper.next;
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index fa26d2a58413..ecc10e148799 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -256,7 +256,6 @@ struct signal_struct {
 #define SIGNAL_STOP_STOPPED	0x00000001 /* job control stop in effect */
 #define SIGNAL_STOP_CONTINUED	0x00000002 /* SIGCONT since WCONTINUED reap */
 #define SIGNAL_GROUP_EXIT	0x00000004 /* group exit in progress */
-#define SIGNAL_GROUP_COREDUMP	0x00000008 /* coredump in progress */
 /*
  * Pending notifications to parent.
  */
@@ -272,7 +271,7 @@ struct signal_struct {
 static inline void signal_set_stop_flags(struct signal_struct *sig,
 					 unsigned int flags)
 {
-	WARN_ON(sig->flags & (SIGNAL_GROUP_EXIT|SIGNAL_GROUP_COREDUMP));
+	WARN_ON(sig->flags & SIGNAL_GROUP_EXIT);
 	sig->flags = (sig->flags & ~SIGNAL_STOP_MASK) | flags;
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index cdccbacac685..9eb3e2c1f9f7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -906,7 +906,7 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 	struct task_struct *t;
 	sigset_t flush;
 
-	if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
+	if (signal->flags & SIGNAL_GROUP_EXIT) {
 		struct core_state *core_state = signal->core_state;
 		if (core_state) {
 			if (sig == SIGKILL) {
-- 
2.29.2

