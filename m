Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015AB488469
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiAHQLZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:11:25 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:41062 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiAHQLY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:11:24 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:38896)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6EJP-006Z0x-Dw; Sat, 08 Jan 2022 09:11:23 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:56388 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6EJN-005O1Q-9H; Sat, 08 Jan 2022 09:11:23 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <20220103213312.9144-1-ebiederm@xmission.com>
        <Yde4AcAxTziaVies@zeniv-ca.linux.org.uk>
Date:   Sat, 08 Jan 2022 10:10:47 -0600
In-Reply-To: <Yde4AcAxTziaVies@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Fri, 7 Jan 2022 03:48:17 +0000")
Message-ID: <87fspyw6m0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n6EJN-005O1Q-9H;;;mid=<87fspyw6m0.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX182nURwXFuPeTjj8mAvBySwd2YvfiPV/Q4=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1575 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (0.8%), b_tie_ro: 11 (0.7%), parse: 1.74
        (0.1%), extract_message_metadata: 24 (1.5%), get_uri_detail_list: 3.8
        (0.2%), tests_pri_-1000: 23 (1.4%), tests_pri_-950: 1.62 (0.1%),
        tests_pri_-900: 1.26 (0.1%), tests_pri_-90: 152 (9.7%), check_bayes:
        150 (9.5%), b_tokenize: 16 (1.0%), b_tok_get_all: 9 (0.6%),
        b_comp_prob: 4.1 (0.3%), b_tok_touch_all: 44 (2.8%), b_finish: 1.20
        (0.1%), tests_pri_0: 1338 (85.0%), check_dkim_signature: 0.86 (0.1%),
        check_dkim_adsp: 5 (0.3%), poll_dns_idle: 0.50 (0.0%), tests_pri_10:
        4.0 (0.3%), tests_pri_500: 11 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 01/17] exit: Remove profile_task_exit & profile_munmap
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jan 03, 2022 at 03:32:56PM -0600, Eric W. Biederman wrote:
>> When I say remove I mean remove.  All profile_task_exit and
>> profile_munmap do is call a blocking notifier chain.  The helpers
>> profile_task_register and profile_task_unregister are not called
>> anywhere in the tree.  Which means this is all dead code.
>> 
>> So remove the dead code and make it easier to read do_exit.
>
> How about doing the same to profile_handoff_task() and
> task_handoff_register()/task_handoff_unregister(),
> while we are at it?  Combined diff would be this:

A very good idea.  I have added this incremental patch to my queue.

Eric

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sat, 8 Jan 2022 10:03:24 -0600
Subject: [PATCH] exit: Remove profile_handoff_task

All profile_handoff_task does is notify the task_free_notifier chain.
The helpers task_handoff_register and task_handoff_unregister are used
to add and delete entries from that chain and are never called.

So remove the dead code and make it much easier to read and reason
about __put_task_struct.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/profile.h | 19 -------------------
 kernel/fork.c           |  4 +---
 kernel/profile.c        | 23 -----------------------
 3 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/include/linux/profile.h b/include/linux/profile.h
index f7eb2b57d890..11db1ec516e2 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -61,14 +61,6 @@ static inline void profile_hit(int type, void *ip)
 struct task_struct;
 struct mm_struct;
 
-/* task is dead, free task struct ? Returns 1 if
- * the task was taken, 0 if the task should be freed.
- */
-int profile_handoff_task(struct task_struct * task);
-
-int task_handoff_register(struct notifier_block * n);
-int task_handoff_unregister(struct notifier_block * n);
-
 #else
 
 #define prof_on 0
@@ -93,17 +85,6 @@ static inline void profile_hit(int type, void *ip)
 	return;
 }
 
-static inline int task_handoff_register(struct notifier_block * n)
-{
-	return -ENOSYS;
-}
-
-static inline int task_handoff_unregister(struct notifier_block * n)
-{
-	return -ENOSYS;
-}
-
-#define profile_handoff_task(a) (0)
 
 #endif /* CONFIG_PROFILING */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 6f0293cb29c9..494539ecb6d3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -754,9 +754,7 @@ void __put_task_struct(struct task_struct *tsk)
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
 	sched_core_free(tsk);
-
-	if (!profile_handoff_task(tsk))
-		free_task(tsk);
+	free_task(tsk);
 }
 EXPORT_SYMBOL_GPL(__put_task_struct);
 
diff --git a/kernel/profile.c b/kernel/profile.c
index 9355cc934a96..37640a0bd8a3 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -133,29 +133,6 @@ int __ref profile_init(void)
 	return -ENOMEM;
 }
 
-/* Profile event notifications */
-
-static ATOMIC_NOTIFIER_HEAD(task_free_notifier);
-
-int profile_handoff_task(struct task_struct *task)
-{
-	int ret;
-	ret = atomic_notifier_call_chain(&task_free_notifier, 0, task);
-	return (ret == NOTIFY_OK) ? 1 : 0;
-}
-
-int task_handoff_register(struct notifier_block *n)
-{
-	return atomic_notifier_chain_register(&task_free_notifier, n);
-}
-EXPORT_SYMBOL_GPL(task_handoff_register);
-
-int task_handoff_unregister(struct notifier_block *n)
-{
-	return atomic_notifier_chain_unregister(&task_free_notifier, n);
-}
-EXPORT_SYMBOL_GPL(task_handoff_unregister);
-
 #if defined(CONFIG_SMP) && defined(CONFIG_PROC_FS)
 /*
  * Each cpu has a pair of open-addressed hashtables for pending
-- 
2.29.2


