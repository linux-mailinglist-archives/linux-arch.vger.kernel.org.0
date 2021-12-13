Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6417A47380E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbhLMWyp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:54:45 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:45256 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbhLMWyo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:54:44 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:33766)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDT-007ahr-Au; Mon, 13 Dec 2021 15:54:43 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60446 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDS-007pqT-22; Mon, 13 Dec 2021 15:54:42 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 13 Dec 2021 16:53:45 -0600
Message-Id: <20211213225350.27481-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mwuDS-007pqT-22;;;mid=<20211213225350.27481-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xM39wxDvFlMwusjbjJBC/CFr2m7Om/1M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5348]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 311 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (3.8%), b_tie_ro: 10 (3.2%), parse: 1.00
        (0.3%), extract_message_metadata: 12 (3.8%), get_uri_detail_list: 0.86
        (0.3%), tests_pri_-1000: 14 (4.6%), tests_pri_-950: 1.34 (0.4%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 76 (24.5%), check_bayes:
        75 (24.0%), b_tokenize: 5 (1.8%), b_tok_get_all: 5.0 (1.6%),
        b_comp_prob: 1.90 (0.6%), b_tok_touch_all: 59 (18.8%), b_finish: 1.00
        (0.3%), tests_pri_0: 175 (56.2%), check_dkim_signature: 0.61 (0.2%),
        check_dkim_adsp: 3.0 (1.0%), poll_dns_idle: 1.14 (0.4%), tests_pri_10:
        3.0 (1.0%), tests_pri_500: 12 (4.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/8] signal: Have the oom killer detect coredumps using signal->core_state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for removing the flag SIGNAL_GROUP_COREDUMP change
__task_will_free_mem to test signal->core_state instead of the flag
SIGNAL_GROUP_COREDUMP.

Both fields are protected by siglock and both live in signal_struct so
there are no real tradeoffs here, just a change to which field is
being tested.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..5c92aad8ca1a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -793,7 +793,7 @@ static inline bool __task_will_free_mem(struct task_struct *task)
 	 * coredump_task_exit(), so the oom killer cannot assume that
 	 * the process will promptly exit and release memory.
 	 */
-	if (sig->flags & SIGNAL_GROUP_COREDUMP)
+	if (sig->core_state)
 		return false;
 
 	if (sig->flags & SIGNAL_GROUP_EXIT)
-- 
2.29.2

