Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C210A483864
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiACVdi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:33:38 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55632 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiACVdh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:37 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:53662)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxU-008w9q-F0; Mon, 03 Jan 2022 14:33:36 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxS-006zvm-W0; Mon, 03 Jan 2022 14:33:36 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:32:58 -0600
Message-Id: <20220103213312.9144-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4UxS-006zvm-W0;;;mid=<20220103213312.9144-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX196ABXzRphm6Epu6ILDYOaOLYsB0yzq64Y=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5054]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 860 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.2%), b_tie_ro: 8 (1.0%), parse: 1.55 (0.2%),
         extract_message_metadata: 19 (2.2%), get_uri_detail_list: 2.3 (0.3%),
        tests_pri_-1000: 14 (1.6%), tests_pri_-950: 1.20 (0.1%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 118 (13.7%), check_bayes:
        116 (13.5%), b_tokenize: 6 (0.7%), b_tok_get_all: 4.7 (0.6%),
        b_comp_prob: 2.2 (0.3%), b_tok_touch_all: 100 (11.7%), b_finish: 0.84
        (0.1%), tests_pri_0: 682 (79.3%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.8 (0.3%), poll_dns_idle: 0.97 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 7 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 03/17] exit: Fix the exit_code for wait_task_zombie
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The function wait_task_zombie is defined to always returns the process not
thread exit status.  Unfortunately when process group exit support
was added to wait_task_zombie the WNOWAIT case was overlooked.

Usually tsk->exit_code and tsk->signal->group_exit_code will be in sync
so fixing this is bug probably has no effect in practice.  But fix
it anyway so that people aren't scratching their heads about why
the two code paths are different.

History-Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Fixes: 2c66151cbc2c ("[PATCH] sys_exit() threading improvements, BK-curr")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 34c43037450f..7121db37c411 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1011,7 +1011,8 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		return 0;
 
 	if (unlikely(wo->wo_flags & WNOWAIT)) {
-		status = p->exit_code;
+		status = (p->signal->flags & SIGNAL_GROUP_EXIT)
+			? p->signal->group_exit_code : p->exit_code;
 		get_task_struct(p);
 		read_unlock(&tasklist_lock);
 		sched_annotate_sleep();
-- 
2.29.2

