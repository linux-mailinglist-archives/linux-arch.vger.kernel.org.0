Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7326248854E
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 19:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiAHSQC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 13:16:02 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:57896 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiAHSQB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 13:16:01 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:45214)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6GG0-0010gX-AF; Sat, 08 Jan 2022 11:16:00 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:33968 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6GFz-000wMo-EX; Sat, 08 Jan 2022 11:15:59 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211213225350.27481-1-ebiederm@xmission.com>
        <9363765f-9883-75ee-70f1-a1a8e9841812@gmail.com>
        <87pmp67y4r.fsf@email.froward.int.ebiederm.org>
        <5bbb54c4-7504-cd28-5dde-4e5965496625@gmail.com>
        <87bl0m14ew.fsf@email.froward.int.ebiederm.org>
Date:   Sat, 08 Jan 2022 12:15:52 -0600
In-Reply-To: <87bl0m14ew.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Sat, 08 Jan 2022 12:13:59 -0600")
Message-ID: <87zgo6ytyf.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n6GFz-000wMo-EX;;;mid=<87zgo6ytyf.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX193qILMax3IbglF3xPQ+2Hp9i5erwfkqmQ=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dmitry Osipenko <digetx@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 302 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 13 (4.1%), b_tie_ro: 11 (3.6%), parse: 1.26
        (0.4%), extract_message_metadata: 13 (4.4%), get_uri_detail_list: 1.00
        (0.3%), tests_pri_-1000: 13 (4.4%), tests_pri_-950: 1.26 (0.4%),
        tests_pri_-900: 1.07 (0.4%), tests_pri_-90: 71 (23.5%), check_bayes:
        69 (22.9%), b_tokenize: 6 (1.8%), b_tok_get_all: 5 (1.8%),
        b_comp_prob: 2.1 (0.7%), b_tok_touch_all: 53 (17.4%), b_finish: 1.00
        (0.3%), tests_pri_0: 174 (57.6%), check_dkim_signature: 0.55 (0.2%),
        check_dkim_adsp: 2.9 (0.9%), poll_dns_idle: 1.01 (0.3%), tests_pri_10:
        3.0 (1.0%), tests_pri_500: 8 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/2] signal: Make coredump handling explicit in complete_signal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Ever since commit 6cd8f0acae34 ("coredump: ensure that SIGKILL always
kills the dumping thread") it has been possible for a SIGKILL received
during a coredump to set SIGNAL_GROUP_EXIT and trigger a process
shutdown (for a second time).

Update the logic to explicitly allow coredumps so that coredumps can
set SIGNAL_GROUP_EXIT and shutdown like an ordinary process.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index f95a4423519d..0706c1345a71 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1032,7 +1032,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 	 * then start taking the whole group down immediately.
 	 */
 	if (sig_fatal(p, sig) &&
-	    !(signal->flags & SIGNAL_GROUP_EXIT) &&
+	    (signal->core_state || !(signal->flags & SIGNAL_GROUP_EXIT)) &&
 	    !sigismember(&t->real_blocked, sig) &&
 	    (sig == SIGKILL || !p->ptrace)) {
 		/*
-- 
2.29.2

