Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F056F473814
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbhLMWyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:54:52 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38062 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbhLMWyv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:54:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:41912)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDa-00DAeK-RX; Mon, 13 Dec 2021 15:54:50 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60446 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDZ-007pqT-PB; Mon, 13 Dec 2021 15:54:50 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 13 Dec 2021 16:53:48 -0600
Message-Id: <20211213225350.27481-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mwuDZ-007pqT-PB;;;mid=<20211213225350.27481-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18QrWns4LNTXESQlhnolOyBIKXd1fvvRhM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5096]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 432 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.8%), b_tie_ro: 10 (2.4%), parse: 1.25
        (0.3%), extract_message_metadata: 15 (3.5%), get_uri_detail_list: 1.35
        (0.3%), tests_pri_-1000: 18 (4.3%), tests_pri_-950: 1.54 (0.4%),
        tests_pri_-900: 1.19 (0.3%), tests_pri_-90: 155 (36.0%), check_bayes:
        153 (35.5%), b_tokenize: 7 (1.5%), b_tok_get_all: 6 (1.3%),
        b_comp_prob: 1.95 (0.5%), b_tok_touch_all: 136 (31.4%), b_finish: 1.07
        (0.2%), tests_pri_0: 207 (48.0%), check_dkim_signature: 0.70 (0.2%),
        check_dkim_adsp: 3.4 (0.8%), poll_dns_idle: 0.97 (0.2%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 13 (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 6/8] coredump: Stop setting signal->group_exit_task
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently the coredump code sets group_exit_task so that
signal_group_exit() will return true during a coredump.  Now that the
coredump code always sets SIGNAL_GROUP_EXIT there is no longer a need
to set signal->group_exit_task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 2c9d16d4b57a..ef56595a0d87 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -377,7 +377,6 @@ static int zap_threads(struct task_struct *tsk,
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!signal_group_exit(tsk->signal)) {
 		tsk->signal->core_state = core_state;
-		tsk->signal->group_exit_task = tsk;
 		nr = zap_process(tsk, exit_code);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 		tsk->flags |= PF_DUMPCORE;
@@ -426,7 +425,6 @@ static void coredump_finish(bool core_dumped)
 	spin_lock_irq(&current->sighand->siglock);
 	if (core_dumped && !__fatal_signal_pending(current))
 		current->signal->group_exit_code |= 0x80;
-	current->signal->group_exit_task = NULL;
 	next = current->signal->core_state->dumper.next;
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
-- 
2.29.2

