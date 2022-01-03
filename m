Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D740B483869
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiACVdk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:33:40 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55652 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiACVdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:39 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:53720)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxW-008wAP-Eq; Mon, 03 Jan 2022 14:33:38 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxV-006zvm-HX; Mon, 03 Jan 2022 14:33:38 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:32:59 -0600
Message-Id: <20220103213312.9144-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4UxV-006zvm-HX;;;mid=<20220103213312.9144-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19GwdHKdiijovtG0K+pecNRJriBL3YbcO0=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5007]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 349 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 8 (2.4%), b_tie_ro: 7 (2.0%), parse: 0.82 (0.2%),
        extract_message_metadata: 11 (3.2%), get_uri_detail_list: 1.27 (0.4%),
        tests_pri_-1000: 14 (3.9%), tests_pri_-950: 1.18 (0.3%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 84 (24.1%), check_bayes:
        83 (23.8%), b_tokenize: 6 (1.7%), b_tok_get_all: 4.8 (1.4%),
        b_comp_prob: 2.0 (0.6%), b_tok_touch_all: 67 (19.3%), b_finish: 0.76
        (0.2%), tests_pri_0: 214 (61.4%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.7 (0.8%), poll_dns_idle: 0.86 (0.2%), tests_pri_10:
        2.7 (0.8%), tests_pri_500: 9 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 04/17] exit: Use the correct exit_code in /proc/<pid>/stat
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since do_proc_statt was modified to return process wide values instead
of per task values the exit_code calculation has never been updated.
Update it now to return the process wide exit_code when it is requested
and available.

History-Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Fixes: bf719d26a5c1 ("[PATCH] distinct tgid/tid CPU usage")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/array.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index ff869a66b34e..43a7abde9e42 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -468,6 +468,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	u64 cgtime, gtime;
 	unsigned long rsslim = 0;
 	unsigned long flags;
+	int exit_code = task->exit_code;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -531,6 +532,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 			maj_flt += sig->maj_flt;
 			thread_group_cputime_adjusted(task, &utime, &stime);
 			gtime += sig->gtime;
+
+			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
+				exit_code = sig->group_exit_code;
 		}
 
 		sid = task_session_nr_ns(task, ns);
@@ -630,7 +634,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_puts(m, " 0 0 0 0 0 0 0");
 
 	if (permitted)
-		seq_put_decimal_ll(m, " ", task->exit_code);
+		seq_put_decimal_ll(m, " ", exit_code);
 	else
 		seq_puts(m, " 0");
 
-- 
2.29.2

