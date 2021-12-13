Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB232473810
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244003AbhLMWyt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:54:49 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38032 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244011AbhLMWyr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:54:47 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:41784)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDW-00DAdl-5e; Mon, 13 Dec 2021 15:54:46 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60446 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDU-007pqT-JZ; Mon, 13 Dec 2021 15:54:45 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 13 Dec 2021 16:53:46 -0600
Message-Id: <20211213225350.27481-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mwuDU-007pqT-JZ;;;mid=<20211213225350.27481-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/gG/C6H7+2ECMw1uH4op8AfaQeb/Psxp0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5114]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 314 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (3.5%), b_tie_ro: 10 (3.1%), parse: 0.94
        (0.3%), extract_message_metadata: 12 (3.7%), get_uri_detail_list: 1.18
        (0.4%), tests_pri_-1000: 14 (4.5%), tests_pri_-950: 1.20 (0.4%),
        tests_pri_-900: 1.00 (0.3%), tests_pri_-90: 49 (15.5%), check_bayes:
        47 (15.1%), b_tokenize: 6 (1.9%), b_tok_get_all: 5 (1.7%),
        b_comp_prob: 1.87 (0.6%), b_tok_touch_all: 31 (9.8%), b_finish: 0.83
        (0.3%), tests_pri_0: 210 (66.8%), check_dkim_signature: 0.51 (0.2%),
        check_dkim_adsp: 2.9 (0.9%), poll_dns_idle: 1.08 (0.3%), tests_pri_10:
        3.5 (1.1%), tests_pri_500: 9 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/8] signal: During coredumps set SIGNAL_GROUP_EXIT in zap_process
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are only a few places that test SIGNAL_GROUP_EXIT and
are not also already testing SIGNAL_GROUP_COREDUMP.

This will not affect the callers of signal_group_exit as zap_process
also sets group_exit_task so signal_group_exit will continue to return
true at the same times.

This does not affect wait_task_zombie as the none of the threads
wind up in EXIT_ZOMBIE state during a coredump.

This does not affect oom_kill.c:__task_will_free_mem as
sig->core_state is tested and handled before SIGNAL_GROUP_EXIT is
tested for.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a9c25f20118f..5e5a90de7be3 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -347,13 +347,13 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	return ispipe;
 }
 
-static int zap_process(struct task_struct *start, int exit_code, int flags)
+static int zap_process(struct task_struct *start, int exit_code)
 {
 	struct task_struct *t;
 	int nr = 0;
 
 	/* Allow SIGKILL, see prepare_signal() */
-	start->signal->flags = SIGNAL_GROUP_COREDUMP | flags;
+	start->signal->flags = SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP;
 	start->signal->group_exit_code = exit_code;
 	start->signal->group_stop_count = 0;
 
@@ -378,7 +378,7 @@ static int zap_threads(struct task_struct *tsk,
 	if (!signal_group_exit(tsk->signal)) {
 		tsk->signal->core_state = core_state;
 		tsk->signal->group_exit_task = tsk;
-		nr = zap_process(tsk, exit_code, 0);
+		nr = zap_process(tsk, exit_code);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 		tsk->flags |= PF_DUMPCORE;
 		atomic_set(&core_state->nr_threads, nr);
-- 
2.29.2

