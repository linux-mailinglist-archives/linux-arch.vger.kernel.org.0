Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2A4860DF
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 08:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiAFHIU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 02:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiAFHIU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 02:08:20 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4641C061245;
        Wed,  5 Jan 2022 23:08:19 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5Msj-00048K-Er; Thu, 06 Jan 2022 07:08:17 +0000
Date:   Thu, 6 Jan 2022 07:08:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into
 make_task_dead
Message-ID: <YdaVYeHWIjAR7mhp@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-3-ebiederm@xmission.com>
 <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 05, 2022 at 05:48:08AM +0000, Al Viro wrote:
> On Wed, Dec 08, 2021 at 02:25:25PM -0600, Eric W. Biederman wrote:
> > The beginning of do_exit has become cluttered and difficult to read as
> > it is filled with checks to handle things that can only happen when
> > the kernel is operating improperly.
> > 
> > Now that we have a dedicated function for cleaning up a task when the
> > kernel is operating improperly move the checks there.
> 
> Umm...  I would probably take profile_task_exit() crap out before that
> point.
> 	1) the damn thing is dead - nothing registers notifiers there
> 	2) blocking_notifier_call_chain() is not a nice thing to do on oops...
> 
> I'll post a patch ripping the dead parts of kernel/profile.c out tomorrow
> morning (there's also profile_handoff_task(), equally useless these days
> and complicating things for __put_task_struct()).

Ugh...  Forgot to post, sorry.

[PATCH] get rid of dead machinery in kernel/profile.c

Nothing is placed on the call chains in there, now that oprofile is
gone.  Remove them, along with the hooks for calling them.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/include/linux/profile.h b/include/linux/profile.h
index fd18ca96f5574..88dfb0543ea63 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -63,26 +63,6 @@ static inline void profile_hit(int type, void *ip)
 		profile_hits(type, ip, 1);
 }
 
-struct task_struct;
-struct mm_struct;
-
-/* task is in do_exit() */
-void profile_task_exit(struct task_struct * task);
-
-/* task is dead, free task struct ? Returns 1 if
- * the task was taken, 0 if the task should be freed.
- */
-int profile_handoff_task(struct task_struct * task);
-
-/* sys_munmap */
-void profile_munmap(unsigned long addr);
-
-int task_handoff_register(struct notifier_block * n);
-int task_handoff_unregister(struct notifier_block * n);
-
-int profile_event_register(enum profile_type, struct notifier_block * n);
-int profile_event_unregister(enum profile_type, struct notifier_block * n);
-
 #else
 
 #define prof_on 0
@@ -107,30 +87,6 @@ static inline void profile_hit(int type, void *ip)
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
-#define profile_handoff_task(a) (0)
-#define profile_munmap(a) do { } while (0)
-
 #endif /* CONFIG_PROFILING */
 
 #endif /* _LINUX_PROFILE_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index f702a6a63686e..5086a5e9d02de 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -765,7 +765,6 @@ void __noreturn do_exit(long code)
 		preempt_count_set(PREEMPT_ENABLED);
 	}
 
-	profile_task_exit(tsk);
 	kcov_task_exit(tsk);
 
 	coredump_task_exit(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697d..496c0b6c8cb83 100644
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
index eb9c7f0f5ac52..37640a0bd8a3c 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -133,79 +133,6 @@ int __ref profile_init(void)
 	return -ENOMEM;
 }
 
-/* Profile event notifications */
-
-static BLOCKING_NOTIFIER_HEAD(task_exit_notifier);
-static ATOMIC_NOTIFIER_HEAD(task_free_notifier);
-static BLOCKING_NOTIFIER_HEAD(munmap_notifier);
-
-void profile_task_exit(struct task_struct *task)
-{
-	blocking_notifier_call_chain(&task_exit_notifier, 0, task);
-}
-
-int profile_handoff_task(struct task_struct *task)
-{
-	int ret;
-	ret = atomic_notifier_call_chain(&task_free_notifier, 0, task);
-	return (ret == NOTIFY_OK) ? 1 : 0;
-}
-
-void profile_munmap(unsigned long addr)
-{
-	blocking_notifier_call_chain(&munmap_notifier, 0, (void *)addr);
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
index bfb0ea164a90a..70318c2a47c39 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2928,7 +2928,6 @@ EXPORT_SYMBOL(vm_munmap);
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
 	addr = untagged_addr(addr);
-	profile_munmap(addr);
 	return __vm_munmap(addr, len, true);
 }
 
