Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893443B0F09
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 22:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFVUz3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 16:55:29 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43818 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFVUz2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 16:55:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvnOL-00D4q2-L1; Tue, 22 Jun 2021 14:53:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvnOJ-00DMLx-V2; Tue, 22 Jun 2021 14:53:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
Date:   Tue, 22 Jun 2021 15:52:18 -0500
In-Reply-To: <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 21 Jun 2021 16:15:37 -0700")
Message-ID: <87tulpbp19.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lvnOJ-00DMLx-V2;;;mid=<87tulpbp19.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19fLng1GY7RONMhi3f6+aWUrqvBtMdB3bg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMBrknScrpt_02,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 XMBrknScrpt_02 Possible Broken Spam Script
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1092 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.0%), b_tie_ro: 9 (0.8%), parse: 1.42 (0.1%),
         extract_message_metadata: 18 (1.7%), get_uri_detail_list: 4.7 (0.4%),
        tests_pri_-1000: 16 (1.5%), tests_pri_-950: 1.22 (0.1%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 387 (35.5%), check_bayes:
        376 (34.4%), b_tokenize: 19 (1.7%), b_tok_get_all: 14 (1.3%),
        b_comp_prob: 3.6 (0.3%), b_tok_touch_all: 335 (30.7%), b_finish: 0.93
        (0.1%), tests_pri_0: 642 (58.8%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 3.1 (0.3%), poll_dns_idle: 0.96 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 7 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jun 21, 2021 at 1:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> For other ptrace_event calls I am playing with seeing if I can split
>> them in two.  Like sending a signal.  So that we can have perform all
>> of the work in get_signal.
>
> That sounds like the right model, but I don't think it works.
> Particularly not for exit(). The second phase will never happen.

Playing with it some more I think I have everything working working
except for PTRACE_EVENT_SECCOMP (which can stay ptrace_event) and
group_exit(2).

Basically in exit sending yourself a signal and then calling do_exit
from the signal handler is not unreasonable, as exit is an ordinary
system call.

I haven't seen anything that ``knows'' that exit(2) or exit_group(2)
will never return and adds a special case in the system call table for
that case.

The complications of exit_group(2) are roughly those of moving
ptrace_event out of do_exit.   They look doable and I am going to look
at that next.

This is not to say that this is the most maintainable way or that we
necessarily want to implement things this way, but I need to look and
see what it looks like.

For purposes of discussion this is my current draft implementation.

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c881384517..891812d32b90 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1087,6 +1087,7 @@ struct task_struct {
 	struct capture_control		*capture_control;
 #endif
 	/* Ptrace state: */
+	int				stop_code;
 	unsigned long			ptrace_message;
 	kernel_siginfo_t		*last_siginfo;
 
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index b5ebf6c01292..33c50119b193 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -164,18 +164,29 @@ static inline void ptrace_event(int event, unsigned long message)
 	}
 }
 
+static inline bool ptrace_post_event(int event, unsigned long message)
+{
+	bool posted = false;
+	if (unlikely(ptrace_event_enabled(current, event))) {
+		current->ptrace_message = message;
+		current->stop_code = (event << 8) | SIGTRAP;
+		set_tsk_thread_flag(current, TIF_SIGPENDING);
+		posted = true;
+	} else if (event == PTRACE_EVENT_EXEC) {
+		/* legacy EXEC report via SIGTRAP */
+		if ((current->ptrace & (PT_PTRACED|PT_SEIZED)) == PT_PTRACED)
+			send_sig(SIGTRAP, current, 0);
+	}
+	return posted;
+}
+
 /**
- * ptrace_event_pid - possibly stop for a ptrace event notification
- * @event:	%PTRACE_EVENT_* value to report
- * @pid:	process identifier for %PTRACE_GETEVENTMSG to return
- *
- * Check whether @event is enabled and, if so, report @event and @pid
- * to the ptrace parent.  @pid is reported as the pid_t seen from the
- * ptrace parent's pid namespace.
+ * pid_parent_nr - Return the number the parent knows this pid as
+ * @pid:	The struct pid whose numerical value we want
  *
  * Called without locks.
  */
-static inline void ptrace_event_pid(int event, struct pid *pid)
+static inline pid_t pid_parent_nr(struct pid *pid)
 {
 	/*
 	 * FIXME: There's a potential race if a ptracer in a different pid
@@ -183,16 +194,15 @@ static inline void ptrace_event_pid(int event, struct pid *pid)
 	 * when we acquire tasklist_lock in ptrace_stop().  If this happens,
 	 * the ptracer will get a bogus pid from PTRACE_GETEVENTMSG.
 	 */
-	unsigned long message = 0;
+	pid_t nr = 0;
 	struct pid_namespace *ns;
 
 	rcu_read_lock();
 	ns = task_active_pid_ns(rcu_dereference(current->parent));
 	if (ns)
-		message = pid_nr_ns(pid, ns);
+		nr = pid_nr_ns(pid, ns);
 	rcu_read_unlock();
-
-	ptrace_event(event, message);
+	return nr;
 }
 
 /**
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e24b1fe348e3..a2eac3831369 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -97,6 +97,8 @@ extern void exit_mm_release(struct task_struct *, struct mm_struct *);
 /* Remove the current tasks stale references to the old mm_struct on exec() */
 extern void exec_mm_release(struct task_struct *, struct mm_struct *);
 
+extern int wait_for_vfork_done(struct task_struct *child, struct completion *vfork);
+
 #ifdef CONFIG_MEMCG
 extern void mm_update_next_owner(struct mm_struct *mm);
 #else
diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..bb4751d84e2d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1781,7 +1781,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 
 	audit_bprm(bprm);
 	trace_sched_process_exec(current, old_pid, bprm);
-	ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
+	ptrace_post_event(PTRACE_EVENT_EXEC, old_vpid);
 	proc_exec_connector(current);
 	return 0;
 }
diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..aeb22a8e4d24 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -889,7 +889,9 @@ EXPORT_SYMBOL(complete_and_exit);
 
 SYSCALL_DEFINE1(exit, int, error_code)
 {
-	do_exit((error_code&0xff)<<8);
+	long code = (error_code&0xff)<<8;
+	if (!ptrace_post_event(PTRACE_EVENT_EXIT, code))
+		do_exit((error_code&0xff)<<8);
 }
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index dc06afd725cb..8533e056a3d6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1266,8 +1266,7 @@ static void complete_vfork_done(struct task_struct *tsk)
 	task_unlock(tsk);
 }
 
-static int wait_for_vfork_done(struct task_struct *child,
-				struct completion *vfork)
+int wait_for_vfork_done(struct task_struct *child, struct completion *vfork)
 {
 	int killed;
 
@@ -2278,7 +2277,8 @@ static __latent_entropy struct task_struct *copy_process(
 
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
-		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
+		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) ||
+				 (trace && ptrace_event_enabled(current, trace)));
 
 		init_task_pid(p, PIDTYPE_PID, pid);
 		if (thread_group_leader(p)) {
@@ -2462,7 +2462,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 pid_t kernel_clone(struct kernel_clone_args *args)
 {
 	u64 clone_flags = args->flags;
-	struct completion vfork;
+	unsigned long message;
 	struct pid *pid;
 	struct task_struct *p;
 	int trace = 0;
@@ -2495,9 +2495,6 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 			trace = PTRACE_EVENT_CLONE;
 		else
 			trace = PTRACE_EVENT_FORK;
-
-		if (likely(!ptrace_event_enabled(current, trace)))
-			trace = 0;
 	}
 
 	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
@@ -2512,30 +2509,27 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 	 */
 	trace_sched_process_fork(current, p);
 
-	pid = get_task_pid(p, PIDTYPE_PID);
+	pid = task_pid(p);
 	nr = pid_vnr(pid);
+	message = pid_parent_nr(pid);
 
 	if (clone_flags & CLONE_PARENT_SETTID)
 		put_user(nr, args->parent_tid);
 
-	if (clone_flags & CLONE_VFORK) {
-		p->vfork_done = &vfork;
+	if (!(clone_flags & CLONE_VFORK)) {
+		wake_up_new_task(p);
+		ptrace_post_event(trace, message);
+	}
+	else if (!ptrace_post_event(PTRACE_EVENT_VFORK, (unsigned long)p)) {
+		struct completion vfork;
 		init_completion(&vfork);
+		p->vfork_done = &vfork;
 		get_task_struct(p);
+		wake_up_new_task(p);
+		if (wait_for_vfork_done(p, &vfork))
+			ptrace_post_event(PTRACE_EVENT_VFORK_DONE, message);
 	}
 
-	wake_up_new_task(p);
-
-	/* forking complete and child started to run, tell ptracer */
-	if (unlikely(trace))
-		ptrace_event_pid(trace, pid);
-
-	if (clone_flags & CLONE_VFORK) {
-		if (!wait_for_vfork_done(p, &vfork))
-			ptrace_event_pid(PTRACE_EVENT_VFORK_DONE, pid);
-	}
-
-	put_pid(pid);
 	return nr;
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffcbd044..8ac8c4a31d88 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -155,7 +155,8 @@ static bool recalc_sigpending_tsk(struct task_struct *t)
 	if ((t->jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE)) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked) ||
-	    cgroup_task_frozen(t)) {
+	    cgroup_task_frozen(t) ||
+	    t->stop_code) {
 		set_tsk_thread_flag(t, TIF_SIGPENDING);
 		return true;
 	}
@@ -2607,6 +2608,39 @@ bool get_signal(struct ksignal *ksig)
 	if (unlikely(current->task_works))
 		task_work_run();
 
+ptrace_event:
+	/* Handle a posted ptrace event */
+	if (unlikely(current->stop_code)) {
+		int stop_code = current->stop_code;
+		unsigned long message = current->ptrace_message;
+		struct completion vfork;
+		struct task_struct *p;
+
+		current->stop_code = 0;
+
+		if (stop_code == PTRACE_EVENT_VFORK) {
+			p = (struct task_struct *)message;
+			get_task_struct(p);
+			current->ptrace_message = pid_parent_nr(task_pid(p));
+			init_completion(&vfork);
+			p->vfork_done = &vfork;
+			wake_up_new_task(p);
+		}
+
+		spin_lock_irq(&sighand->siglock);
+		ptrace_do_notify(SIGTRAP, stop_code, CLD_TRAPPED);
+		spin_unlock_irq(&sighand->siglock);
+
+		if ((stop_code == PTRACE_EVENT_VFORK) &&
+		    wait_for_vfork_done(p, &vfork) &&
+		    ptrace_post_event(PTRACE_EVENT_VFORK_DONE, message))
+			goto ptrace_event;
+
+		if (stop_code == PTRACE_EVENT_EXIT) {
+			do_exit(message);
+		}
+	}
+
 	/*
 	 * For non-generic architectures, check for TIF_NOTIFY_SIGNAL so
 	 * that the arch handlers don't all have to do it. If we get here

Eric
