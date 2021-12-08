Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBA46DCF4
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhLHU36 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:29:58 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39984 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbhLHU35 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:29:57 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46716)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WC-00GaO3-B9; Wed, 08 Dec 2021 13:26:24 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WA-00CjR6-Qr; Wed, 08 Dec 2021 13:26:23 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  8 Dec 2021 14:25:26 -0600
Message-Id: <20211208202532.16409-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WA-00CjR6-Qr;;;mid=<20211208202532.16409-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19k2KsadM27boh2TGtU3PkWIqUfnIUyAbw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5038]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 907 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (1.5%), b_tie_ro: 11 (1.3%), parse: 1.41
        (0.2%), extract_message_metadata: 17 (1.9%), get_uri_detail_list: 1.40
        (0.2%), tests_pri_-1000: 20 (2.3%), tests_pri_-950: 1.64 (0.2%),
        tests_pri_-900: 1.35 (0.1%), tests_pri_-90: 177 (19.6%), check_bayes:
        175 (19.3%), b_tokenize: 8 (0.8%), b_tok_get_all: 6 (0.7%),
        b_comp_prob: 2.5 (0.3%), b_tok_touch_all: 155 (17.1%), b_finish: 1.27
        (0.1%), tests_pri_0: 646 (71.2%), check_dkim_signature: 1.16 (0.1%),
        check_dkim_adsp: 4.6 (0.5%), poll_dns_idle: 0.98 (0.1%), tests_pri_10:
        4.3 (0.5%), tests_pri_500: 20 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 04/10] exit: Stop poorly open coding do_task_dead in make_task_dead
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When the kernel detects it is oops or otherwise force killing a task
while it exits the code poorly attempts to permanently stop the task
from scheduling.

I say poorly because it is possible for a task in TASK_UINTERRUPTIBLE
to be woken up.

As it makes no sense for the task to continue call do_task_dead
instead which actually does the work and permanently removes the task
from the scheduler.  Guaranteeing the task will never be woken
up again.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index d0ec6f6b41cb..f975cd8a2ed8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -886,8 +886,7 @@ void __noreturn make_task_dead(int signr)
 	if (unlikely(tsk->flags & PF_EXITING)) {
 		pr_alert("Fixing recursive fault but reboot is needed!\n");
 		futex_exit_recursive(tsk);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule();
+		do_task_dead();
 	}
 
 	do_exit(signr);
-- 
2.29.2

