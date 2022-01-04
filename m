Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC3484305
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 15:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiADOFv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 09:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiADOFv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 09:05:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED17C061761;
        Tue,  4 Jan 2022 06:05:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j21so148809209edt.9;
        Tue, 04 Jan 2022 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNqxr2y8Q97izXF8D4dwuhEdlGlgZqSKnPX242WVsGE=;
        b=QAr9uwfVJEDV6vULYBg3nJSumVwkTvq4DfBiUry+YvdG7krvaKTo/DvDlHpnnJaDCv
         7d+MWl1klRzigJX8Wf59ba08Sglh7f+IqKZ1LfOSH0GR/KSwqwVtPQ8sW1YLK9zUeDD0
         jxXVnsLRS1SBuVgNPAVpsj7AgVzIqX1tjC1WXFhVh6/nkLhY6kJp1pp0uNWDJV+gNyLo
         J77HD+CGF+wCsN2SykCmTDRnTI1NcliEkoZ86/ydKBVcJy82fLEWbD3a1pMYpUQhcruf
         HaKSqRVQHbc8zB5VkMCVjaUjbPLI3cEn/jT537LEml+mkKJRjuu64ygtJQOKb1PM7Dni
         g0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bNqxr2y8Q97izXF8D4dwuhEdlGlgZqSKnPX242WVsGE=;
        b=ZIfqJlPOKH42z8Gh6GdZ7jNGXn98V0p50bk1TNBFWCgymEc3/EB3R2s3PXP/L931Qr
         FpjxR6q9xSLSOYDXEq8H4uuxu7JMdHPqcEqe6aNjT5LiKHZ2yOdfgX/RKqY2ADozMKwV
         ahPNA2sOUhsLccaEuoPjNsRnC8TjWFqx516jR6G004RNMHbgPNld1RH7hDdW2C7ih64e
         76qtPzjmkDgKTBPCJ4Uj/S01GNgvBOfj2nt36vRhAQNnCNoH0JhvWR3ibdQLZwP4VL32
         pAYTX+ER7YpHRpArtSa61cYIvA/QWe7WxfPJjixDsrPSZeNQ639U43YTjSMAJj9E62bN
         EhHA==
X-Gm-Message-State: AOAM530V2XPpSMGbaYYBmLawEncKhKODPBJbU5IfJfkky9DXbC7dv34w
        vvIOM88G1X/n7O2pWiv0rVI=
X-Google-Smtp-Source: ABdhPJwnmyl2O1xI/6rcFlSIkjWN3in2fC76egrgXIyI1SRqgPt+8NvsyNs1AMYxCzJ3s49SWOZMsg==
X-Received: by 2002:a17:906:d0d8:: with SMTP id bq24mr39248100ejb.63.1641305149203;
        Tue, 04 Jan 2022 06:05:49 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id qf14sm10962012ejc.18.2022.01.04.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:05:48 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 4 Jan 2022 15:05:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] per_task: Implement single template to define 'struct
 task_struct_per_task' fields and offsets
Message-ID: <YdRUO4tJWN81WVut@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdLL0kaFhm6rp9NS@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > Techniques used by the fast-headers tree to reduce header size & dependencies:
> > 
> >  - Aggressive decoupling of high level headers from each other, starting
> >    with <linux/sched.h>. Since 'struct task_struct' is a union of many
> >    subsystems, there's a new "per_task" infrastructure modeled after the
> >    per_cpu framework, which creates fields in task_struct without having
> >    to modify sched.h or the 'struct task_struct' type:
> > 
> >             DECLARE_PER_TASK(type, name);
> >             ...
> >             per_task(current, name) = val;
> > 
> >    The per_task() facility then seamlessly creates an offset into the
> >    task_struct->per_task_area[] array, and uses the asm-offsets.h
> >    mechanism to create offsets into it early in the build.
> > 
> >    There's no runtime overhead disadvantage from using per_task() framework,
> >    the generated code is functionally equivalent to types embedded in
> >    task_struct.
> 
> This is "interesting", but how are you going to keep the 
> kernel/sched/per_task_area_struct_defs.h and struct task_struct_per_task 
> definition in sync?  It seems that you manually created this (which is 
> great for testing), but over the long-term, trying to manually determine 
> what needs to be done here to keep everything lined up properly is going 
> to be a major pain.

On a second thought, I found a solution for this problem and implemented it 
- delta patch attached.

The idea is to unify the two files into a single 'template' definition in:

   kernel/sched/per_task_area_struct_template.h

... with the following, slightly non-standard syntax:

 #ifdef CONFIG_THREAD_INFO_IN_TASK
	/*
	 * For reasons of header soup (see current_thread_info()), this
	 * must be the first element of task_struct.
	 */
	DEF(	struct thread_info,		ti						);
 #endif
	DEF(	void *,				stack						);
	DEF(	refcount_t,			usage						);

	/* Per task flags (PF_*), defined further below: */
	DEF(	unsigned int,			flags						);
	DEF(	unsigned int,			ptrace						);

This looks 'almost' like a C structure definition - but is wrapped in the 
DEF() macro.

Once we have that template, we can use it both to generate the 'struct 
task_struct_per_task' definition, and to pick up the field offsets for the 
per_task() asm-offsets.h machinery.

The advantage is that it solves the problems you mentioned above: the 
per-task structure and the offset definitions can never get out of sync - 
the #ifdefs and the field names will always match.

It's also net reduction in code:

    3 files changed, 216 insertions(+), 341 deletions(-)

Does this approach look better to you?

This patch builds and boots fine in the latest -fast-headers tree.

I'm still of two minds about whether to keep the per-task structure tucked 
away in kernel/sched/, hopefully creating a barrier against spurious 
additions to task_struct by putting it next to scary scheduler code - or 
should we move it into a more formal and easier to access/modify location 
in include/sched/?

Another additional (minor) advantage would be that these uglies:

  arch/arm64/kernel/asm-offsets.c:#include "../../../kernel/sched/per_task_area_struct.h"
  arch/arm64/kernel/asm-offsets.c:#include "../../../kernel/sched/per_task_area_struct_defs.h"
  arch/mips/kernel/asm-offsets.c:#include "../../../kernel/sched/per_task_area_struct.h"
  arch/mips/kernel/asm-offsets.c:#include "../../../kernel/sched/per_task_area_struct_defs.h"
  arch/sparc/kernel/asm-offsets.c:#include "../../../kernel/sched/per_task_area_struct.h"
  arch/sparc/kernel/asm-offsets.c:#include "../../../kernel/sched/per_task_area_struct_defs.h"
  arch/x86/kernel/asm-offsets.c:#include "../../../kernel/sched/per_task_area_struct.h"
  arch/x86/kernel/asm-offsets.c:#include "../../../kernel/sched/per_task_area_struct_defs.h"

would turn into standard include lines:

  #include <linux/sched/per_task_defs.h>

Thanks,

	Ingo

======================>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 4 Jan 2022 14:31:12 +0100
Subject: [PATCH] per_task: Implement single template to define 'struct task_struct_per_task' fields and offsets

Greg observed that the 'struct task_struct_per_task definition'
and the offset definitions are structural duplicates of each
other:

   kernel/sched/per_task_area_struct.h
   kernel/sched/per_task_area_struct_defs.h

These require care during maintenance and could get out of sync.

To address this problem, introduce a single definition template:

   kernel/sched/per_task_area_template.h

And use the template and different preprocessor macros to implement
the two pieces of functionality.

The syntax in the template is C-alike struct field definitions,
wrapped in the DEF() and DEF_A() macros:

 #ifdef CONFIG_THREAD_INFO_IN_TASK
	/*
	 * For reasons of header soup (see current_thread_info()), this
	 * must be the first element of task_struct.
	 */
	DEF(	struct thread_info,		ti						);
 #endif
	DEF(	void *,				stack						);
	DEF(	refcount_t,			usage						);

	/* Per task flags (PF_*), defined further below: */
	DEF(	unsigned int,			flags						);
	DEF(	unsigned int,			ptrace						);

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/per_task_area_struct.h          | 196 ++------------------------
 kernel/sched/per_task_area_struct_defs.h     | 163 ++--------------------
 kernel/sched/per_task_area_struct_template.h | 198 +++++++++++++++++++++++++++
 3 files changed, 216 insertions(+), 341 deletions(-)

diff --git a/kernel/sched/per_task_area_struct.h b/kernel/sched/per_task_area_struct.h
index fad3c24df500..4508160e49ec 100644
--- a/kernel/sched/per_task_area_struct.h
+++ b/kernel/sched/per_task_area_struct.h
@@ -40,194 +40,16 @@
 
 #include "sched.h"
 
-struct task_struct_per_task {
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	/*
-	 * For reasons of header soup (see current_thread_info()), this
-	 * must be the first element of task_struct.
-	 */
-	struct thread_info		ti;
-#endif
-	void				*stack;
-	refcount_t			usage;
-	/* Per task flags (PF_*), defined further below: */
-	unsigned int			flags;
-	unsigned int			ptrace;
-
-#ifdef CONFIG_SMP
-	int				on_cpu;
-	struct __call_single_node	wake_entry;
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	/* Current CPU: */
-	unsigned int			cpu;
-#endif
-	unsigned int			wakee_flips;
-	unsigned long			wakee_flip_decay_ts;
-	struct task_struct		*last_wakee;
-	int				recent_used_cpu;
-	int				wake_cpu;
-#endif
-	int				on_rq;
-	struct sched_class		*sched_class;
-	struct sched_entity		se;
-	struct sched_rt_entity		rt;
-	struct sched_dl_entity		dl;
-
-#ifdef CONFIG_SCHED_CORE
-	struct rb_node			core_node;
-	unsigned long			core_cookie;
-	unsigned int			core_occupation;
-#endif
-
-#ifdef CONFIG_CGROUP_SCHED
-	struct task_group		*sched_task_group;
-#endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	/*
-	 * Clamp values requested for a scheduling entity.
-	 * Must be updated with task_rq_lock() held.
-	 */
-	struct uclamp_se		uclamp_req[UCLAMP_CNT];
-	/*
-	 * Effective clamp values used for a scheduling entity.
-	 * Must be updated with task_rq_lock() held.
-	 */
-	struct uclamp_se		uclamp[UCLAMP_CNT];
-#endif
-
-#ifdef CONFIG_PREEMPT_NOTIFIERS
-	/* List of struct preempt_notifier: */
-	struct hlist_head		preempt_notifiers;
-#endif
-
-#ifdef CONFIG_BLK_DEV_IO_TRACE
-	unsigned int			btrace_seq;
-#endif
-
-	const cpumask_t			*cpus_ptr;
-	cpumask_t			*user_cpus_ptr;
-	cpumask_t			cpus_mask;
-#ifdef CONFIG_TASKS_RCU
-	unsigned long			rcu_tasks_nvcsw;
-	u8				rcu_tasks_holdout;
-	u8				rcu_tasks_idx;
-	int				rcu_tasks_idle_cpu;
-	struct list_head		rcu_tasks_holdout_list;
-#endif /* #ifdef CONFIG_TASKS_RCU */
-	struct sched_info		sched_info;
-
-#ifdef CONFIG_SMP
-	struct plist_node		pushable_tasks;
-	struct rb_node			pushable_dl_tasks;
-#endif
-	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
-
-#ifdef SPLIT_RSS_COUNTING
-	struct task_rss_stat		rss_stat;
-#endif
-	struct restart_block		restart_block;
-	struct prev_cputime		prev_cputime;
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-	struct vtime			vtime;
-#endif
-#ifdef CONFIG_NO_HZ_FULL
-	atomic_t			tick_dep_mask;
-#endif
-	/* Empty if CONFIG_POSIX_CPUTIMERS=n */
-	struct posix_cputimers		posix_cputimers;
-
-#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
-	struct posix_cputimers_work	posix_cputimers_work;
-#endif
+/* Simple struct members: */
+#define DEF(type, name)			type name
 
-#ifdef CONFIG_SYSVIPC
-	struct sysv_sem			sysvsem;
-	struct sysv_shm			sysvshm;
-#endif
-	sigset_t			blocked;
-	sigset_t			real_blocked;
-	/* Restored if set_restore_sigmask() was used: */
-	sigset_t			saved_sigmask;
-	struct sigpending		pending;
-	kuid_t				loginuid;
-	struct seccomp			seccomp;
-	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_allowed, mempolicy: */
-	spinlock_t			alloc_lock;
+/* Array members: */
+#define DEF_A(type, name, size)		type name size
 
-	/* Protection of the PI data structures: */
-	raw_spinlock_t			pi_lock;
-
-#ifdef CONFIG_RT_MUTEXES
-	/* PI waiters blocked on a rt_mutex held by this task: */
-	struct rb_root_cached		pi_waiters;
-#endif
-
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
-	kernel_siginfo_t		*last_siginfo;
-#ifdef CONFIG_CPUSETS
-	/* Protected by ->alloc_lock: */
-	nodemask_t			mems_allowed;
-	/* Sequence number to catch updates: */
-	seqcount_spinlock_t		mems_allowed_seq;
-	int				cpuset_mem_spread_rotor;
-	int				cpuset_slab_spread_rotor;
-#endif
-	struct mutex			futex_exit_mutex;
-#ifdef CONFIG_PERF_EVENTS
-	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
-	struct mutex			perf_event_mutex;
-	struct list_head		perf_event_list;
-#endif
-#ifdef CONFIG_RSEQ
-	struct rseq __user *rseq;
-#endif
-	struct tlbflush_unmap_batch	tlb_ubc;
-
-	refcount_t			rcu_users;
-	struct rcu_head			rcu;
-
-	struct page_frag		task_frag;
-
-#ifdef CONFIG_KCSAN
-	struct kcsan_ctx		kcsan_ctx;
-#ifdef CONFIG_TRACE_IRQFLAGS
-	struct irqtrace_events		kcsan_save_irqtrace;
-#endif
-#endif
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-
-	/*
-	 * Number of functions that haven't been traced
-	 * because of depth overrun:
-	 */
-	atomic_t			trace_overrun;
-
-	/* Pause tracing: */
-	atomic_t			tracing_graph_pause;
-#endif
-#ifdef CONFIG_KMAP_LOCAL
-	struct kmap_ctrl		kmap_ctrl;
-#endif
-	int				pagefault_disabled;
-#ifdef CONFIG_VMAP_STACK
-	struct vm_struct		*stack_vm_area;
-#endif
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	/* A live task holds one reference: */
-	refcount_t			stack_refcount;
-#endif
-#ifdef CONFIG_KRETPROBES
-	struct llist_head               kretprobe_instances;
-#endif
+struct task_struct_per_task {
+#include "per_task_area_struct_template.h"
+};
 
-	/* CPU-specific state of this task: */
-	struct thread_struct		thread;
+#undef DEF_A
+#undef DEF
 
-	char				_end;
-};
diff --git a/kernel/sched/per_task_area_struct_defs.h b/kernel/sched/per_task_area_struct_defs.h
index 71f2a2884958..1d9b2e039880 100644
--- a/kernel/sched/per_task_area_struct_defs.h
+++ b/kernel/sched/per_task_area_struct_defs.h
@@ -4,162 +4,17 @@
 
 #include <linux/kbuild.h>
 
-#define DEF_PER_TASK(name) DEFINE(PER_TASK_OFFSET__##name, offsetof(struct task_struct_per_task, name))
+#define DEF_PER_TASK(name)		DEFINE(PER_TASK_OFFSET__##name, offsetof(struct task_struct_per_task, name))
 
-void __used per_task_common(void)
-{
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	DEF_PER_TASK(ti);
-#endif
-	DEF_PER_TASK(stack);
-	DEF_PER_TASK(usage);
-	DEF_PER_TASK(flags);
-	DEF_PER_TASK(ptrace);
-
-#ifdef CONFIG_SMP
-	DEF_PER_TASK(on_cpu);
-	DEF_PER_TASK(wake_entry);
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	DEF_PER_TASK(cpu);
-#endif
-	DEF_PER_TASK(wakee_flips);
-	DEF_PER_TASK(wakee_flip_decay_ts);
-	DEF_PER_TASK(last_wakee);
-	DEF_PER_TASK(recent_used_cpu);
-	DEF_PER_TASK(wake_cpu);
-#endif
-	DEF_PER_TASK(on_rq);
-	DEF_PER_TASK(sched_class);
-	DEF_PER_TASK(se);
-	DEF_PER_TASK(rt);
-	DEF_PER_TASK(dl);
-
-#ifdef CONFIG_SCHED_CORE
-	DEF_PER_TASK(core_node);
-	DEF_PER_TASK(core_cookie);
-	DEF_PER_TASK(core_occupation);
-#endif
-
-#ifdef CONFIG_CGROUP_SCHED
-	DEF_PER_TASK(sched_task_group);
-#endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	DEF_PER_TASK(uclamp_req);
-	DEF_PER_TASK(uclamp);
-#endif
-
-#ifdef CONFIG_PREEMPT_NOTIFIERS
-	DEF_PER_TASK(preempt_notifiers);
-#endif
-
-#ifdef CONFIG_BLK_DEV_IO_TRACE
-	DEF_PER_TASK(btrace_seq);
-#endif
-
-	DEF_PER_TASK(cpus_ptr);
-	DEF_PER_TASK(user_cpus_ptr);
-	DEF_PER_TASK(cpus_mask);
-#ifdef CONFIG_TASKS_RCU
-	DEF_PER_TASK(rcu_tasks_nvcsw);
-	DEF_PER_TASK(rcu_tasks_holdout);
-	DEF_PER_TASK(rcu_tasks_idx);
-	DEF_PER_TASK(rcu_tasks_idle_cpu);
-	DEF_PER_TASK(rcu_tasks_holdout_list);
-#endif
-	DEF_PER_TASK(sched_info);
-
-#ifdef CONFIG_SMP
-	DEF_PER_TASK(pushable_tasks);
-	DEF_PER_TASK(pushable_dl_tasks);
-#endif
-	DEF_PER_TASK(vmacache);
+#define DEF(type, name)			DEF_PER_TASK(name)
+#define DEF_A(type, name, size)		DEF_PER_TASK(name)
 
-#ifdef SPLIT_RSS_COUNTING
-	DEF_PER_TASK(rss_stat);
-#endif
-	DEF_PER_TASK(restart_block);
-	DEF_PER_TASK(prev_cputime);
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-	DEF_PER_TASK(vtime);
-#endif
-#ifdef CONFIG_NO_HZ_FULL
-	DEF_PER_TASK(tick_dep_mask);
-#endif
-	DEF_PER_TASK(posix_cputimers);
 
-#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
-	DEF_PER_TASK(posix_cputimers_work);
-#endif
-
-#ifdef CONFIG_SYSVIPC
-	DEF_PER_TASK(sysvsem);
-	DEF_PER_TASK(sysvshm);
-#endif
-	DEF_PER_TASK(blocked);
-	DEF_PER_TASK(real_blocked);
-	DEF_PER_TASK(saved_sigmask);
-	DEF_PER_TASK(pending);
-	DEF_PER_TASK(loginuid);
-	DEF_PER_TASK(seccomp);
-	DEF_PER_TASK(alloc_lock);
-
-	DEF_PER_TASK(pi_lock);
-
-#ifdef CONFIG_RT_MUTEXES
-	DEF_PER_TASK(pi_waiters);
-#endif
-
-#ifdef CONFIG_DEBUG_MUTEXES
-	DEF_PER_TASK(blocked_on);
-#endif
-	DEF_PER_TASK(last_siginfo);
-#ifdef CONFIG_CPUSETS
-	DEF_PER_TASK(mems_allowed);
-	DEF_PER_TASK(mems_allowed_seq);
-	DEF_PER_TASK(cpuset_mem_spread_rotor);
-	DEF_PER_TASK(cpuset_slab_spread_rotor);
-#endif
-	DEF_PER_TASK(futex_exit_mutex);
-#ifdef CONFIG_PERF_EVENTS
-	DEF_PER_TASK(perf_event_ctxp);
-	DEF_PER_TASK(perf_event_mutex);
-	DEF_PER_TASK(perf_event_list);
-#endif
-#ifdef CONFIG_RSEQ
-	DEF_PER_TASK(rseq);
-#endif
-	DEF_PER_TASK(tlb_ubc);
-
-	DEF_PER_TASK(rcu_users);
-	DEF_PER_TASK(rcu);
-
-	DEF_PER_TASK(task_frag);
+void __used per_task_common(void)
+{
+#include "per_task_area_struct_template.h"
+}
 
-#ifdef CONFIG_KCSAN
-	DEF_PER_TASK(kcsan_ctx);
-#ifdef CONFIG_TRACE_IRQFLAGS
-	DEF_PER_TASK(kcsan_save_irqtrace);
-#endif
-#endif
+#undef DEF_A
+#undef DEF
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	DEF_PER_TASK(trace_overrun);
-	DEF_PER_TASK(tracing_graph_pause);
-#endif
-#ifdef CONFIG_KMAP_LOCAL
-	DEF_PER_TASK(kmap_ctrl);
-#endif
-	DEF_PER_TASK(pagefault_disabled);
-#ifdef CONFIG_VMAP_STACK
-	DEF_PER_TASK(stack_vm_area);
-#endif
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	DEF_PER_TASK(stack_refcount);
-#endif
-#ifdef CONFIG_KRETPROBES
-	DEF_PER_TASK(kretprobe_instances);
-#endif
-	DEF_PER_TASK(thread);
-	DEF_PER_TASK(_end);
-}
diff --git a/kernel/sched/per_task_area_struct_template.h b/kernel/sched/per_task_area_struct_template.h
new file mode 100644
index 000000000000..ed2ccd80c83c
--- /dev/null
+++ b/kernel/sched/per_task_area_struct_template.h
@@ -0,0 +1,198 @@
+
+/*
+ * This is the primary definition of per_task() fields,
+ * which gets turned into the 'struct task_struct_per_task'
+ * structure definition, and into offset definitions,
+ * in per_task_area_struct.h and per_task_area_struct_defs.h:
+ */
+
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	/*
+	 * For reasons of header soup (see current_thread_info()), this
+	 * must be the first element of task_struct.
+	 */
+	DEF(	struct thread_info,		ti						);
+#endif
+	DEF(	void *,				stack						);
+	DEF(	refcount_t,			usage						);
+
+	/* Per task flags (PF_*), defined further below: */
+	DEF(	unsigned int,			flags						);
+	DEF(	unsigned int,			ptrace						);
+
+#ifdef CONFIG_SMP
+	DEF(	int,				on_cpu						);
+	DEF(	struct __call_single_node,	wake_entry					);
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	/* Current CPU: */
+	DEF(	unsigned int,			cpu						);
+#endif
+	DEF(	unsigned int,			wakee_flips					);
+	DEF(	unsigned long,			wakee_flip_decay_ts				);
+	DEF(	struct task_struct *,		last_wakee					);
+	DEF(	int,				recent_used_cpu					);
+	DEF(	int,				wake_cpu					);
+#endif
+	DEF(	int,				on_rq						);
+	DEF(	struct sched_class *,		sched_class					);
+	DEF(	struct sched_entity,		se						);
+	DEF(	struct sched_rt_entity,		rt						);
+	DEF(	struct sched_dl_entity,		dl						);
+
+#ifdef CONFIG_SCHED_CORE
+	DEF(	struct rb_node,			core_node					);
+	DEF(	unsigned long,			core_cookie					);
+	DEF(	unsigned int,			core_occupation					);
+#endif
+
+#ifdef CONFIG_CGROUP_SCHED
+	DEF(	struct task_group *,		sched_task_group				);
+#endif
+
+#ifdef CONFIG_UCLAMP_TASK
+	/*
+	 * Clamp values requested for a scheduling entity.
+	 * Must be updated with task_rq_lock() held.
+	 */
+	DEF_A(	struct uclamp_se,		uclamp_req, [UCLAMP_CNT]			);
+	/*
+	 * Effective clamp values used for a scheduling entity.
+	 * Must be updated with task_rq_lock() held.
+	 */
+	DEF_A(	struct uclamp_se,		uclamp, [UCLAMP_CNT]				);
+#endif
+
+#ifdef CONFIG_PREEMPT_NOTIFIERS
+	/* List of struct preempt_notifier: */
+	DEF(	struct hlist_head,		preempt_notifiers				);
+#endif
+
+#ifdef CONFIG_BLK_DEV_IO_TRACE
+	DEF(	unsigned int,			btrace_seq					);
+#endif
+
+	DEF(	const cpumask_t *,		cpus_ptr					);
+	DEF(	cpumask_t *,			user_cpus_ptr					);
+	DEF(	cpumask_t,			cpus_mask					);
+#ifdef CONFIG_TASKS_RCU
+	DEF(	unsigned long,			rcu_tasks_nvcsw					);
+	DEF(	u8,				rcu_tasks_holdout				);
+	DEF(	u8,				rcu_tasks_idx					);
+	DEF(	int,				rcu_tasks_idle_cpu				);
+	DEF(	struct list_head,		rcu_tasks_holdout_list				);
+#endif /* #ifdef CONFIG_TASKS_RCU */
+	DEF(	struct sched_info,		sched_info					);
+
+#ifdef CONFIG_SMP
+	DEF(	struct plist_node,		pushable_tasks					);
+	DEF(	struct rb_node,			pushable_dl_tasks				);
+#endif
+	/* Per-thread vma caching: */
+	DEF(	struct vmacache,		vmacache					);
+
+#ifdef SPLIT_RSS_COUNTING
+	DEF(	struct task_rss_stat,		rss_stat					);
+#endif
+	DEF(	struct restart_block,		restart_block					);
+	DEF(	struct prev_cputime,		prev_cputime					);
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
+	DEF(	struct vtime,			vtime						);
+#endif
+#ifdef CONFIG_NO_HZ_FULL
+	DEF(	atomic_t,			tick_dep_mask					);
+#endif
+	/* Empty if CONFIG_POSIX_CPUTIMERS=n */
+	DEF(	struct posix_cputimers,		posix_cputimers					);
+
+#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+	DEF(	struct posix_cputimers_work,	posix_cputimers_work				);
+#endif
+
+#ifdef CONFIG_SYSVIPC
+	DEF(	struct sysv_sem,		sysvsem						);
+	DEF(	struct sysv_shm,		sysvshm						);
+#endif
+	DEF(	sigset_t,			blocked						);
+	DEF(	sigset_t,			real_blocked					);
+	/* Restored if set_restore_sigmask() was used: */
+	DEF(	sigset_t,			saved_sigmask					);
+	DEF(	struct sigpending,		pending						);
+	DEF(	kuid_t,				loginuid					);
+	DEF(	struct seccomp,			seccomp						);
+	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_allowed, mempolicy: */
+	DEF(	spinlock_t,			alloc_lock					);
+
+	/* Protection of the PI data structures: */
+	DEF(	raw_spinlock_t,			pi_lock						);
+
+#ifdef CONFIG_RT_MUTEXES
+	/* PI waiters blocked on a rt_mutex held by this task: */
+	DEF(	struct rb_root_cached,		pi_waiters					);
+#endif
+
+#ifdef CONFIG_DEBUG_MUTEXES
+	/* Mutex deadlock detection: */
+	DEF(	struct mutex_waiter *,		blocked_on					);
+#endif
+	DEF(	kernel_siginfo_t *,		last_siginfo					);
+#ifdef CONFIG_CPUSETS
+	/* Protected by ->alloc_lock: */
+	DEF(	nodemask_t,			mems_allowed					);
+	/* Sequence number to catch updates: */
+	DEF(	seqcount_spinlock_t,		mems_allowed_seq				);
+	DEF(	int,				cpuset_mem_spread_rotor				);
+	DEF(	int,				cpuset_slab_spread_rotor			);
+#endif
+	DEF(	struct mutex,			futex_exit_mutex				);
+#ifdef CONFIG_PERF_EVENTS
+	DEF_A(	struct perf_event_context *,	perf_event_ctxp, [perf_nr_task_contexts]	);
+	DEF(	struct mutex,			perf_event_mutex				);
+	DEF(	struct list_head,		perf_event_list					);
+#endif
+#ifdef CONFIG_RSEQ
+	DEF(	struct rseq __user *,		rseq						);
+#endif
+	DEF(	struct tlbflush_unmap_batch,	tlb_ubc						);
+
+	DEF(	refcount_t,			rcu_users					);
+	DEF(	struct rcu_head,		rcu						);
+
+	DEF(	struct page_frag,		task_frag					);
+
+#ifdef CONFIG_KCSAN
+	DEF(	struct kcsan_ctx,		kcsan_ctx					);
+#ifdef CONFIG_TRACE_IRQFLAGS
+	DEF(	struct irqtrace_events,		kcsan_save_irqtrace				);
+#endif
+#endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+	/*
+	 * Number of functions that haven't been traced
+	 * because of depth overrun:
+	 */
+	DEF(	atomic_t,			trace_overrun					);
+
+	/* Pause tracing: */
+	DEF(	atomic_t,			tracing_graph_pause				);
+#endif
+#ifdef CONFIG_KMAP_LOCAL
+	DEF(	struct kmap_ctrl,		kmap_ctrl					);
+#endif
+	DEF(	int,				pagefault_disabled				);
+#ifdef CONFIG_VMAP_STACK
+	DEF(	struct vm_struct *,		stack_vm_area					);
+#endif
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	/* A live task holds one reference: */
+	DEF(	refcount_t,			stack_refcount					);
+#endif
+#ifdef CONFIG_KRETPROBES
+	DEF(	struct llist_head,		kretprobe_instances				);
+#endif
+
+	/* CPU-specific state of this task: */
+	DEF(	struct thread_struct,		thread						);
+
+	DEF(	char,				_end						);
