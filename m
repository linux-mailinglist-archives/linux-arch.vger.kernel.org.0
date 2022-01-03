Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D84483860
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiACVdd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:33:33 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53420 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiACVdc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:32 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:58430)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxP-008tl7-M4; Mon, 03 Jan 2022 14:33:32 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UxO-006zvm-DS; Mon, 03 Jan 2022 14:33:31 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:32:56 -0600
Message-Id: <20220103213312.9144-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4UxO-006zvm-DS;;;mid=<20220103213312.9144-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX181zeBt+KXrILoUBQNgwCvexzDgCTLCLYo=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 470 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (0.9%), b_tie_ro: 2.8 (0.6%), parse: 0.88
        (0.2%), extract_message_metadata: 9 (1.9%), get_uri_detail_list: 1.93
        (0.4%), tests_pri_-1000: 10 (2.2%), tests_pri_-950: 1.10 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 70 (15.0%), check_bayes:
        69 (14.7%), b_tokenize: 8 (1.7%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 1.56 (0.3%), b_tok_touch_all: 50 (10.6%), b_finish: 0.74
        (0.2%), tests_pri_0: 363 (77.2%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.78 (0.2%), tests_pri_10:
        1.70 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 01/17] exit: Remove profile_task_exit & profile_munmap
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When I say remove I mean remove.  All profile_task_exit and
profile_munmap do is call a blocking notifier chain.  The helpers
profile_task_register and profile_task_unregister are not called
anywhere in the tree.  Which means this is all dead code.

So remove the dead code and make it easier to read do_exit.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/profile.h | 26 ---------------------
 kernel/exit.c           |  1 -
 kernel/profile.c        | 50 -----------------------------------------
 mm/mmap.c               |  1 -
 4 files changed, 78 deletions(-)

diff --git a/include/linux/profile.h b/include/linux/profile.h
index fd18ca96f557..f7eb2b57d890 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -31,11 +31,6 @@ static inline int create_proc_profile(void)
 }
 #endif
 
-enum profile_type {
-	PROFILE_TASK_EXIT,
-	PROFILE_MUNMAP
-};
-
 #ifdef CONFIG_PROFILING
 
 extern int prof_on __read_mostly;
@@ -66,23 +61,14 @@ static inline void profile_hit(int type, void *ip)
 struct task_struct;
 struct mm_struct;
 
-/* task is in do_exit() */
-void profile_task_exit(struct task_struct * task);
-
 /* task is dead, free task struct ? Returns 1 if
  * the task was taken, 0 if the task should be freed.
  */
 int profile_handoff_task(struct task_struct * task);
 
-/* sys_munmap */
-void profile_munmap(unsigned long addr);
-
 int task_handoff_register(struct notifier_block * n);
 int task_handoff_unregister(struct notifier_block * n);
 
-int profile_event_register(enum profile_type, struct notifier_block * n);
-int profile_event_unregister(enum profile_type, struct notifier_block * n);
-
 #else
 
 #define prof_on 0
@@ -117,19 +103,7 @@ static inline int task_handoff_unregister(struct notifier_block * n)
 	return -ENOSYS;
 }
 
-static inline int profile_event_register(enum profile_type t, struct notifier_block * n)
-{
-	return -ENOSYS;
-}
-
-static inline int profile_event_unregister(enum profile_type t, struct notifier_block * n)
-{
-	return -ENOSYS;
-}
-
-#define profile_task_exit(a) do { } while (0)
 #define profile_handoff_task(a) (0)
-#define profile_munmap(a) do { } while (0)
 
 #endif /* CONFIG_PROFILING */
 
diff --git a/kernel/exit.c b/kernel/exit.c
index e7104f803be0..b5c35b520fda 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -737,7 +737,6 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(blk_needs_flush_plug(tsk));
 
-	profile_task_exit(tsk);
 	kcov_task_exit(tsk);
 
 	coredump_task_exit(tsk);
diff --git a/kernel/profile.c b/kernel/profile.c
index eb9c7f0f5ac5..9355cc934a96 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -135,14 +135,7 @@ int __ref profile_init(void)
 
 /* Profile event notifications */
 
-static BLOCKING_NOTIFIER_HEAD(task_exit_notifier);
 static ATOMIC_NOTIFIER_HEAD(task_free_notifier);
-static BLOCKING_NOTIFIER_HEAD(munmap_notifier);
-
-void profile_task_exit(struct task_struct *task)
-{
-	blocking_notifier_call_chain(&task_exit_notifier, 0, task);
-}
 
 int profile_handoff_task(struct task_struct *task)
 {
@@ -151,11 +144,6 @@ int profile_handoff_task(struct task_struct *task)
 	return (ret == NOTIFY_OK) ? 1 : 0;
 }
 
-void profile_munmap(unsigned long addr)
-{
-	blocking_notifier_call_chain(&munmap_notifier, 0, (void *)addr);
-}
-
 int task_handoff_register(struct notifier_block *n)
 {
 	return atomic_notifier_chain_register(&task_free_notifier, n);
@@ -168,44 +156,6 @@ int task_handoff_unregister(struct notifier_block *n)
 }
 EXPORT_SYMBOL_GPL(task_handoff_unregister);
 
-int profile_event_register(enum profile_type type, struct notifier_block *n)
-{
-	int err = -EINVAL;
-
-	switch (type) {
-	case PROFILE_TASK_EXIT:
-		err = blocking_notifier_chain_register(
-				&task_exit_notifier, n);
-		break;
-	case PROFILE_MUNMAP:
-		err = blocking_notifier_chain_register(
-				&munmap_notifier, n);
-		break;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(profile_event_register);
-
-int profile_event_unregister(enum profile_type type, struct notifier_block *n)
-{
-	int err = -EINVAL;
-
-	switch (type) {
-	case PROFILE_TASK_EXIT:
-		err = blocking_notifier_chain_unregister(
-				&task_exit_notifier, n);
-		break;
-	case PROFILE_MUNMAP:
-		err = blocking_notifier_chain_unregister(
-				&munmap_notifier, n);
-		break;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(profile_event_unregister);
-
 #if defined(CONFIG_SMP) && defined(CONFIG_PROC_FS)
 /*
  * Each cpu has a pair of open-addressed hashtables for pending
diff --git a/mm/mmap.c b/mm/mmap.c
index bfb0ea164a90..70318c2a47c3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2928,7 +2928,6 @@ EXPORT_SYMBOL(vm_munmap);
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
 	addr = untagged_addr(addr);
-	profile_munmap(addr);
 	return __vm_munmap(addr, len, true);
 }
 
-- 
2.29.2

