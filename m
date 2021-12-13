Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95293473807
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbhLMWyj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:54:39 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:41766 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbhLMWyj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:54:39 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:50848)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDO-0081VN-Fo; Mon, 13 Dec 2021 15:54:38 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60446 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDM-007pqT-O1; Mon, 13 Dec 2021 15:54:37 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 13 Dec 2021 16:53:43 -0600
Message-Id: <20211213225350.27481-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mwuDM-007pqT-O1;;;mid=<20211213225350.27481-1-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18pUOSfvGBp64spbGP02g+7gJN2dUHx05o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5041]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 503 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 14 (2.8%), b_tie_ro: 13 (2.5%), parse: 1.29
        (0.3%), extract_message_metadata: 15 (2.9%), get_uri_detail_list: 3.1
        (0.6%), tests_pri_-1000: 14 (2.7%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.05 (0.2%), tests_pri_-90: 91 (18.1%), check_bayes:
        89 (17.8%), b_tokenize: 9 (1.8%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 66 (13.0%), b_finish: 0.93
        (0.2%), tests_pri_0: 353 (70.1%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 3.9 (0.8%), poll_dns_idle: 2.1 (0.4%), tests_pri_10:
        2.7 (0.5%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Simplify the code that allows SIGKILL during coredumps to terminate
the coredump.  As far as I can tell I have avoided breaking it
by dumb luck.

Historically with all of the other threads stopping in exit_mm the
wants_signal loop in complete_signal would find the dumper task and
then complete_signal would wake the dumper task with signal_wake_up.

After moving the coredump_task_exit above the setting of PF_EXITING in
commit 92307383082d ("coredump: Don't perform any cleanups before
dumping core") wants_signal will consider all of the threads in a
multi-threaded process for waking up, not just the core dumping task.

Luckily complete_signal short circuits SIGKILL during a coredump marks
every thread with SIGKILL and signal_wake_up.  This code is arguably
buggy however as it tries to skip creating a group exit when is already
present, and it fails that a coredump is in progress.

Ever since commit 06af8679449d ("coredump: Limit what can interrupt
coredumps") was added dump_interrupted needs not just TIF_SIGPENDING
set on the dumper task but also SIGKILL set in it's pending bitmap.
This means that if the code is ever fixed not to short-circuit and
kill a process after it has already been killed the special case
for SIGKILL during a coredump will be broken.

Sort all of this out by making the coredump special case more special,
and perform all of the work in prepare_signal and leave the rest of
the signal delivery path out of it.

In prepare_signal when the process coredumping is sent SIGKILL find
the task performing the coredump and use sigaddset and signal_wake_up
to ensure that task reports fatal_signal_pending.

Return false from prepare_signal to tell the rest of the signal
delivery path to ignore the signal.

Update wait_for_dump_helpers to perform a wait_event_killable wait
so that if signal_pending gets set spuriously the wait will not
be interrupted unless fatal_signal_pending is true.

I have tested this and verified I did not break SIGKILL during
coredumps by accident (before or after this change).  I actually
thought I had and I had to figure out what I had misread that kept
SIGKILL during coredumps working.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c   |  4 ++--
 kernel/signal.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a6b3c196cdef..7b91fb32dbb8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -448,7 +448,7 @@ static void coredump_finish(bool core_dumped)
 static bool dump_interrupted(void)
 {
 	/*
-	 * SIGKILL or freezing() interrupt the coredumping. Perhaps we
+	 * SIGKILL or freezing() interrupted the coredumping. Perhaps we
 	 * can do try_to_freeze() and check __fatal_signal_pending(),
 	 * but then we need to teach dump_write() to restart and clear
 	 * TIF_SIGPENDING.
@@ -471,7 +471,7 @@ static void wait_for_dump_helpers(struct file *file)
 	 * We actually want wait_event_freezable() but then we need
 	 * to clear TIF_SIGPENDING and improve dump_interrupted().
 	 */
-	wait_event_interruptible(pipe->rd_wait, pipe->readers == 1);
+	wait_event_killable(pipe->rd_wait, pipe->readers == 1);
 
 	pipe_lock(pipe);
 	pipe->readers--;
diff --git a/kernel/signal.c b/kernel/signal.c
index 8272cac5f429..7e305a8ec7c2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -907,8 +907,15 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 	sigset_t flush;
 
 	if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
-		if (!(signal->flags & SIGNAL_GROUP_EXIT))
-			return sig == SIGKILL;
+		struct core_state *core_state = signal->core_state;
+		if (core_state) {
+			if (sig == SIGKILL) {
+				struct task_struct *dumper = core_state->dumper.task;
+				sigaddset(&dumper->pending.signal, SIGKILL);
+				signal_wake_up(dumper, 1);
+			}
+			return false;
+		}
 		/*
 		 * The process is in the middle of dying, nothing to do.
 		 */
-- 
2.29.2

