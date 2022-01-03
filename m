Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A42483862
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiACVdf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:33:35 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53438 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiACVde (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:58468)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxR-008tlQ-S4; Mon, 03 Jan 2022 14:33:33 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxQ-006zvm-PT; Mon, 03 Jan 2022 14:33:33 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:32:57 -0600
Message-Id: <20220103213312.9144-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4UxQ-006zvm-PT;;;mid=<20220103213312.9144-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ByO9TYSZ0MQyaKTM4mgHM9rHBx1s2UCg=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5015]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 470 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.9%), b_tie_ro: 3.1 (0.7%), parse: 0.63
        (0.1%), extract_message_metadata: 8 (1.7%), get_uri_detail_list: 0.89
        (0.2%), tests_pri_-1000: 10 (2.2%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 246 (52.5%), check_bayes:
        245 (52.2%), b_tokenize: 4.3 (0.9%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 1.42 (0.3%), b_tok_touch_all: 231 (49.3%), b_finish: 0.61
        (0.1%), tests_pri_0: 189 (40.2%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.89 (0.2%), tests_pri_10:
        1.74 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 02/17] exit: Coredumps reach do_group_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The comment about coredumps not reaching do_group_exit and the
corresponding BUG_ON are bogus.

What happens and has happened for years is that get_signal calls
do_coredump (which sets SIGNAL_GROUP_EXIT and group_exit_code) and
then do_group_exit passing the signal number.  Then do_group_exit
ignores the exit_code it is passed and uses signal->group_exit_code
from the coredump.

The comment and BUG_ON were correct when they were added during the
2.5 development cycle, but became obsolete and incorrect when
get_signal was changed to fall through to do_group_exit after
do_coredump in 2.6.10-rc2.

So remove the stale comment and BUG_ON

Fixes: 63bd6144f191 ("[PATCH] Invalid BUG_ONs in signal.c")
History-Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index b5c35b520fda..34c43037450f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -904,8 +904,6 @@ do_group_exit(int exit_code)
 {
 	struct signal_struct *sig = current->signal;
 
-	BUG_ON(exit_code & 0x80); /* core dumps don't get here */
-
 	if (sig->flags & SIGNAL_GROUP_EXIT)
 		exit_code = sig->group_exit_code;
 	else if (sig->group_exec_task)
-- 
2.29.2

