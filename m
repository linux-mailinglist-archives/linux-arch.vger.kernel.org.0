Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B67A48386D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiACVds (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:33:48 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:45860 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiACVdm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:42 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:56344)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxY-00ET0Q-W5; Mon, 03 Jan 2022 14:33:41 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxX-006zvm-MV; Mon, 03 Jan 2022 14:33:40 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Balbir Singh <bsingharora@gmail.com>
Date:   Mon,  3 Jan 2022 15:33:00 -0600
Message-Id: <20220103213312.9144-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4UxX-006zvm-MV;;;mid=<20220103213312.9144-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+CRWzVLNnenVGaaRiHLlq9SOWL8zsSG+U=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5042]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 565 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 9 (1.7%), parse: 0.89 (0.2%),
         extract_message_metadata: 14 (2.5%), get_uri_detail_list: 1.92 (0.3%),
         tests_pri_-1000: 13 (2.4%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 253 (44.9%), check_bayes:
        252 (44.6%), b_tokenize: 7 (1.2%), b_tok_get_all: 6 (1.1%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 233 (41.2%), b_finish: 0.96
        (0.2%), tests_pri_0: 256 (45.4%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 1.21 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 05/17] taskstats: Cleanup the use of task->exit_code
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the function bacct_add_task the code reading task->exit_code was
introduced in commit f3cef7a99469 ("[PATCH] csa: basic accounting over
taskstats"), and it is not entirely clear what the taskstats interface
is trying to return as only returning the exit_code of the first task
in a process doesn't make a lot of sense.

As best as I can figure the intent is to return task->exit_code after
a task exits.  The field is returned with per task fields, so the
exit_code of the entire process is not wanted.  Only the value of the
first task is returned so this is not a useful way to get the per task
ptrace stop code.  The ordinary case of returning this value is
returning after a task exits, which also precludes use for getting
a ptrace value.

It is common to for the first task of a process to also be the last
task of a process so this field may have done something reasonable by
accident in testing.

Make ac_exitcode a reliable per task value by always returning it for
every exited task.

Setting ac_exitcode in a sensible mannter makes it possible to continue
to provide this value going forward.

Cc: Balbir Singh <bsingharora@gmail.com>
Fixes: f3cef7a99469 ("[PATCH] csa: basic accounting over taskstats")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/tsacct.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index f00de83d0246..1d261fbe367b 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -38,11 +38,10 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
 	stats->ac_btime64 = btime;
 
-	if (thread_group_leader(tsk)) {
+	if (tsk->flags & PF_EXITING)
 		stats->ac_exitcode = tsk->exit_code;
-		if (tsk->flags & PF_FORKNOEXEC)
-			stats->ac_flag |= AFORK;
-	}
+	if (thread_group_leader(tsk) && (tsk->flags & PF_FORKNOEXEC))
+		stats->ac_flag |= AFORK;
 	if (tsk->flags & PF_SUPERPRIV)
 		stats->ac_flag |= ASU;
 	if (tsk->flags & PF_DUMPCORE)
-- 
2.29.2

