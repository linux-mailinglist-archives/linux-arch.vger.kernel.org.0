Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252B1197EC7
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgC3OrN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:47:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32825 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgC3OrN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:47:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id g18so6826882plq.0
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GIQcIQ+25C2PbtdQpPQLdEstHve27+lEeoM4U2juW8w=;
        b=FftiiuEBgA3DDQuUsCCf3NJeUWTFpoRPneMiQVikSulDp0nTSbH40jrTJ2bxaryQHN
         ClzHcVhQuX2QEm0HcIQxCN+eZMprJEFkhAitSv1bbUhcvPH/dujYP1v7npuYlAWPumcP
         uapnVqMc79n0KIHhZ8Ljz/QU+rGCSjAxNRIddPGdLNvRrxJN5TggbUPnAEpiFIm+uHBF
         yd3ZxEHSG27Aw/8sdHQ5KxoKouzTsitJAdQpy25CdSAlm1U+y8upWaEDnwWnBpelJeYg
         lmDZWVkp8nAAXZYkUfbbS9MrbQJCE7psUkqiRs2NC4mn7nLSJEzth8LmES/k15H6X0OA
         WPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GIQcIQ+25C2PbtdQpPQLdEstHve27+lEeoM4U2juW8w=;
        b=guGPPY/VAY68UESpV3U4xY6C2zHKp+P6lHWQbI8DMCeA35J/nMLPpTp0CxAuIuca6p
         JhX+f75gkz4RQAgHu1jLrZV3qzDyR5b2drj8BhyxYSRgeLRDKp290NvqArjZHPval2Ph
         fmusef6ANzRf2wTUNueRx04MJDTVAm6taoM9/+kOicO6QtasJN7UPl7KKON7StiAIdED
         w/kq7jxtVZXrr7CHcvClx03oXPNalfGTjMYCSuzASYW5xV40Qh+J/A1v694od1mF8aPJ
         GyobMbjZlQ3vrScpzG51LOZjLoggWT1YUATME1EDEHBlg9DPBXXyWTOToUPcRM190SUx
         I0SQ==
X-Gm-Message-State: ANhLgQ1gG9VX2OAM0fAWfqRu2D5py93PsEz0YO/m4uvdo1kQbQIl6L4C
        QP5Mfm9TuStQ7R+A214O+QA=
X-Google-Smtp-Source: ADFU+vsDY3SsExL75nhCaOpAhCfsPdvYwz+MhPoWKeA+Z8ldE4387z5/nDCZEILYyyfpcY/IEa4W4w==
X-Received: by 2002:a17:902:347:: with SMTP id 65mr12919646pld.21.1585579630853;
        Mon, 30 Mar 2020 07:47:10 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id q185sm10293812pfb.154.2020.03.30.07.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:47:10 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 7A55A202804CBE; Mon, 30 Mar 2020 23:47:07 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Yuan Liu <liuyuan@google.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 05/25] um lkl: kernel threads support
Date:   Mon, 30 Mar 2020 23:45:37 +0900
Message-Id: <bc1bc204aa5182b587cd1fb7bc0258a6613ed763.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

LKL does not support user processes but it must support kernel threads
as part as the normal kernel work-flow. It uses host operations to
create and terminate host threads that are going to run the kernel
threads. It also uses semaphores to synchronize those threads and to
allow the Linux kernel scheduler to control how the kernel threads
run.

Each kernel thread runs in a host threads and has a host semaphore
associated with it - the thread's scheduling semaphore. The semaphore
counter is initialized to 0. The first thing a kernel thread does
after getting spawned, before running any kernel code, is to perform a
down operation to block the thread.

The kernel controls host threads scheduling by performing up and down
operations on the scheduling semaphore. In __switch_context an up
operation on the next thread is performed to wake up a blocked thread,
and a down operation is performed on the prev thread to block it.

A thread is terminated by marking it in free_thread_info and
performing an up operation on the scheduling semaphore at which point
the marked thread will terminate itself.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Patrick Collins <pscollins@google.com>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/asm/thread_info.h   |  70 ++++++++
 arch/um/lkl/include/uapi/asm/host_ops.h |  55 ++++++
 arch/um/lkl/kernel/cpu.c                | 223 +++++++++++++++++++++++
 arch/um/lkl/kernel/threads.c            | 227 ++++++++++++++++++++++++
 4 files changed, 575 insertions(+)
 create mode 100644 arch/um/lkl/include/asm/thread_info.h
 create mode 100644 arch/um/lkl/kernel/cpu.c
 create mode 100644 arch/um/lkl/kernel/threads.c

diff --git a/arch/um/lkl/include/asm/thread_info.h b/arch/um/lkl/include/asm/thread_info.h
new file mode 100644
index 000000000000..da4e75fc7b10
--- /dev/null
+++ b/arch/um/lkl/include/asm/thread_info.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_THREAD_INFO_H
+#define _ASM_LKL_THREAD_INFO_H
+
+#define THREAD_SIZE	       (4096)
+
+#ifndef __ASSEMBLY__
+#include <asm/types.h>
+#include <asm/processor.h>
+#include <asm/host_ops.h>
+
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+struct thread_info {
+	struct task_struct *task;
+	unsigned long flags;
+	int preempt_count;
+	mm_segment_t addr_limit;
+	struct lkl_sem *sched_sem;
+	struct lkl_jmp_buf sched_jb;
+	bool dead;
+	lkl_thread_t tid;
+	struct task_struct *prev_sched;
+	unsigned long stackend;
+};
+
+#define INIT_THREAD_INFO(tsk)				\
+{							\
+	.task		= &tsk,				\
+	.preempt_count	= INIT_PREEMPT_COUNT,		\
+	.flags		= 0,				\
+	.addr_limit	= KERNEL_DS,			\
+}
+
+/* how to get the thread information struct from C */
+extern struct thread_info *_current_thread_info;
+static inline struct thread_info *current_thread_info(void)
+{
+	return _current_thread_info;
+}
+
+/* thread information allocation */
+unsigned long *alloc_thread_stack_node(struct task_struct *, int node);
+void free_thread_stack(struct task_struct *tsk);
+
+void threads_init(void);
+void threads_cleanup(void);
+
+#define TIF_SYSCALL_TRACE		0
+#define TIF_NOTIFY_RESUME		1
+#define TIF_SIGPENDING			2
+#define TIF_NEED_RESCHED		3
+#define TIF_RESTORE_SIGMASK		4
+#define TIF_MEMDIE			5
+#define TIF_NOHZ			6
+#define TIF_SCHED_JB			7
+#define TIF_HOST_THREAD			8
+
+#define __HAVE_THREAD_FUNCTIONS
+
+#define task_thread_info(task)	((struct thread_info *)(task)->stack)
+#define task_stack_page(task)	((task)->stack)
+void setup_thread_stack(struct task_struct *p, struct task_struct *org);
+#define end_of_stack(p) (&task_thread_info(p)->stackend)
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index 6bbc94c120be..19924fc7c718 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -17,15 +17,70 @@ struct lkl_jmp_buf {
  * These operations must be provided by a host library or by the application
  * itself.
  *
+ * @sem_alloc - allocate a host semaphore an initialize it to count
+ * @sem_free - free a host semaphore
+ * @sem_up - perform an up operation on the semaphore
+ * @sem_down - perform a down operation on the semaphore
+ *
+ * @mutex_alloc - allocate and initialize a host mutex; the recursive parameter
+ * determines if the mutex is recursive or not
+ * @mutex_free - free a host mutex
+ * @mutex_lock - acquire the mutex
+ * @mutex_unlock - release the mutex
+ *
+ * @thread_create - create a new thread and run f(arg) in its context; returns a
+ * thread handle or 0 if the thread could not be created
+ * @thread_detach - on POSIX systems, free up resources held by
+ * pthreads. Noop on Win32.
+ * @thread_exit - terminates the current thread
+ * @thread_join - wait for the given thread to terminate. Returns 0
+ * for success, -1 otherwise
+ *
  * @mem_alloc - allocate memory
  * @mem_free - free memory
  *
+ * @gettid - returns the host thread id of the caller, which need not
+ * be the same as the handle returned by thread_create
+ *
+ * @jmp_buf_set - runs the give function and setups a jump back point by saving
+ * the context in the jump buffer; jmp_buf_longjmp can be called from the give
+ * function or any callee in that function to return back to the jump back
+ * point
+ *
+ * NOTE: we can't return from jmp_buf_set before calling jmp_buf_longjmp or
+ * otherwise the saved context (stack) is not going to be valid, so we must pass
+ * the function that will eventually call longjmp here
+ *
+ * @jmp_buf_longjmp - perform a jump back to the saved jump buffer
  */
 struct lkl_host_operations {
+	struct lkl_sem *(*sem_alloc)(int count);
+	void (*sem_free)(struct lkl_sem *sem);
+	void (*sem_up)(struct lkl_sem *sem);
+	void (*sem_down)(struct lkl_sem *sem);
+
+	struct lkl_mutex *(*mutex_alloc)(int recursive);
+	void (*mutex_free)(struct lkl_mutex *mutex);
+	void (*mutex_lock)(struct lkl_mutex *mutex);
+	void (*mutex_unlock)(struct lkl_mutex *mutex);
+
+	lkl_thread_t (*thread_create)(void (*f)(void *), void *arg);
+	void (*thread_detach)(void);
+	void (*thread_exit)(void);
+	int (*thread_join)(lkl_thread_t tid);
+	lkl_thread_t (*thread_self)(void);
+	int (*thread_equal)(lkl_thread_t a, lkl_thread_t b);
+
 	void *(*mem_alloc)(unsigned long mem);
 	void (*mem_free)(void *mem);
+
+	long (*gettid)(void);
+
+	void (*jmp_buf_set)(struct lkl_jmp_buf *jmpb, void (*f)(void));
+	void (*jmp_buf_longjmp)(struct lkl_jmp_buf *jmpb, int val);
 };
 
+int lkl_printf(const char *fmt, ...);
 void lkl_bug(const char *fmt, ...);
 
 #endif
diff --git a/arch/um/lkl/kernel/cpu.c b/arch/um/lkl/kernel/cpu.c
new file mode 100644
index 000000000000..125af3b2d5dd
--- /dev/null
+++ b/arch/um/lkl/kernel/cpu.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/sched/stat.h>
+#include <asm/host_ops.h>
+#include <asm/cpu.h>
+#include <asm/thread_info.h>
+#include <asm/unistd.h>
+#include <asm/sched.h>
+#include <asm/syscalls.h>
+
+/*
+ * This structure is used to get access to the "LKL CPU" that allows us to run
+ * Linux code. Because we have to deal with various synchronization requirements
+ * between idle thread, system calls, interrupts, "reentrancy", CPU shutdown,
+ * imbalance wake up (i.e. acquire the CPU from one thread and release it from
+ * another), we can't use a simple synchronization mechanism such as (recursive)
+ * mutex or semaphore. Instead, we use a mutex and a bunch of status data plus a
+ * semaphore.
+ */
+static struct lkl_cpu {
+	/* lock that protects the CPU status data */
+	struct lkl_mutex *lock;
+	/*
+	 * Since we must free the cpu lock during shutdown we need a
+	 * synchronization algorithm between lkl_cpu_shutdown() and the CPU
+	 * access functions since lkl_cpu_get() gets called from thread
+	 * destructor callback functions which may be scheduled after
+	 * lkl_cpu_shutdown() has freed the cpu lock.
+	 *
+	 * An atomic counter is used to keep track of the number of running
+	 * CPU access functions and allow the shutdown function to wait for
+	 * them.
+	 *
+	 * The shutdown functions adds MAX_THREADS to this counter which allows
+	 * the CPU access functions to check if the shutdown process has
+	 * started.
+	 *
+	 * This algorithm assumes that we never have more the MAX_THREADS
+	 * requesting CPU access.
+	 */
+	#define MAX_THREADS 1000000
+	unsigned int shutdown_gate;
+	bool irqs_pending;
+	/* no of threads waiting the CPU */
+	unsigned int sleepers;
+	/* no of times the current thread got the CPU */
+	unsigned int count;
+	/* current thread that owns the CPU */
+	lkl_thread_t owner;
+	/* semaphore for threads waiting the CPU */
+	struct lkl_sem *sem;
+	/* semaphore used for shutdown */
+	struct lkl_sem *shutdown_sem;
+} cpu;
+
+static int __cpu_try_get_lock(int n)
+{
+	lkl_thread_t self;
+
+	if (__sync_fetch_and_add(&cpu.shutdown_gate, n) >= MAX_THREADS)
+		return -2;
+
+	lkl_ops->mutex_lock(cpu.lock);
+
+	if (cpu.shutdown_gate >= MAX_THREADS)
+		return -1;
+
+	self = lkl_ops->thread_self();
+
+	if (cpu.owner && !lkl_ops->thread_equal(cpu.owner, self))
+		return 0;
+
+	cpu.owner = self;
+	cpu.count++;
+
+	return 1;
+}
+
+static void __cpu_try_get_unlock(int lock_ret, int n)
+{
+	if (lock_ret >= -1)
+		lkl_ops->mutex_unlock(cpu.lock);
+	__sync_fetch_and_sub(&cpu.shutdown_gate, n);
+}
+
+void lkl_cpu_change_owner(lkl_thread_t owner)
+{
+	lkl_ops->mutex_lock(cpu.lock);
+	if (cpu.count > 1)
+		lkl_bug("bad count while changing owner\n");
+	cpu.owner = owner;
+	lkl_ops->mutex_unlock(cpu.lock);
+}
+
+int lkl_cpu_get(void)
+{
+	int ret;
+
+	ret = __cpu_try_get_lock(1);
+
+	while (ret == 0) {
+		cpu.sleepers++;
+		__cpu_try_get_unlock(ret, 0);
+		lkl_ops->sem_down(cpu.sem);
+		ret = __cpu_try_get_lock(0);
+	}
+
+	__cpu_try_get_unlock(ret, 1);
+
+	return ret;
+}
+
+void lkl_cpu_put(void)
+{
+	lkl_ops->mutex_lock(cpu.lock);
+
+	if (!cpu.count || !cpu.owner ||
+	    !lkl_ops->thread_equal(cpu.owner, lkl_ops->thread_self()))
+		lkl_bug("%s: unbalanced put\n", __func__);
+
+	while (cpu.irqs_pending && !irqs_disabled()) {
+		cpu.irqs_pending = false;
+		lkl_ops->mutex_unlock(cpu.lock);
+		run_irqs();
+		lkl_ops->mutex_lock(cpu.lock);
+	}
+
+	if (test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD) &&
+	    !single_task_running() && cpu.count == 1) {
+		if (in_interrupt())
+			lkl_bug("%s: in interrupt\n", __func__);
+		lkl_ops->mutex_unlock(cpu.lock);
+		thread_sched_jb();
+		return;
+	}
+
+	if (--cpu.count > 0) {
+		lkl_ops->mutex_unlock(cpu.lock);
+		return;
+	}
+
+	if (cpu.sleepers) {
+		cpu.sleepers--;
+		lkl_ops->sem_up(cpu.sem);
+	}
+
+	cpu.owner = 0;
+
+	lkl_ops->mutex_unlock(cpu.lock);
+}
+
+int lkl_cpu_try_run_irq(int irq)
+{
+	int ret;
+
+	ret = __cpu_try_get_lock(1);
+	if (!ret) {
+		set_irq_pending(irq);
+		cpu.irqs_pending = true;
+	}
+	__cpu_try_get_unlock(ret, 1);
+
+	return ret;
+}
+
+void lkl_cpu_shutdown(void)
+{
+	__sync_fetch_and_add(&cpu.shutdown_gate, MAX_THREADS);
+}
+
+void lkl_cpu_wait_shutdown(void)
+{
+	lkl_ops->sem_down(cpu.shutdown_sem);
+	lkl_ops->sem_free(cpu.shutdown_sem);
+}
+
+static void lkl_cpu_cleanup(bool shutdown)
+{
+	while (__sync_fetch_and_add(&cpu.shutdown_gate, 0) > MAX_THREADS)
+		;
+
+	if (shutdown)
+		lkl_ops->sem_up(cpu.shutdown_sem);
+	else if (cpu.shutdown_sem)
+		lkl_ops->sem_free(cpu.shutdown_sem);
+	if (cpu.sem)
+		lkl_ops->sem_free(cpu.sem);
+	if (cpu.lock)
+		lkl_ops->mutex_free(cpu.lock);
+}
+
+void arch_cpu_idle(void)
+{
+	if (cpu.shutdown_gate >= MAX_THREADS) {
+		lkl_ops->mutex_lock(cpu.lock);
+		while (cpu.sleepers--)
+			lkl_ops->sem_up(cpu.sem);
+		lkl_ops->mutex_unlock(cpu.lock);
+
+		lkl_cpu_cleanup(true);
+
+		lkl_ops->thread_exit();
+	}
+	/* enable irqs now to allow direct irqs to run */
+	local_irq_enable();
+
+	/* switch to idle_host_task */
+	wakeup_idle_host_task();
+}
+
+int lkl_cpu_init(void)
+{
+	cpu.lock = lkl_ops->mutex_alloc(0);
+	cpu.sem = lkl_ops->sem_alloc(0);
+	cpu.shutdown_sem = lkl_ops->sem_alloc(0);
+
+	if (!cpu.lock || !cpu.sem || !cpu.shutdown_sem) {
+		lkl_cpu_cleanup(false);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/arch/um/lkl/kernel/threads.c b/arch/um/lkl/kernel/threads.c
new file mode 100644
index 000000000000..4fe8c56ae5e0
--- /dev/null
+++ b/arch/um/lkl/kernel/threads.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched/task.h>
+#include <linux/sched/signal.h>
+#include <asm/host_ops.h>
+#include <asm/cpu.h>
+#include <asm/sched.h>
+
+static int init_ti(struct thread_info *ti)
+{
+	ti->sched_sem = lkl_ops->sem_alloc(0);
+	if (!ti->sched_sem)
+		return -ENOMEM;
+
+	ti->dead = false;
+	ti->prev_sched = NULL;
+	ti->tid = 0;
+
+	return 0;
+}
+
+unsigned long *alloc_thread_stack_node(struct task_struct *task, int node)
+{
+	struct thread_info *ti;
+
+	ti = kmalloc(sizeof(*ti), GFP_KERNEL);
+	if (!ti)
+		return NULL;
+
+	if (init_ti(ti)) {
+		kfree(ti);
+		return NULL;
+	}
+	ti->task = task;
+
+	return (unsigned long *)ti;
+}
+
+/*
+ * The only new tasks created are kernel threads that have a predefined starting
+ * point thus no stack copy is required.
+ */
+void setup_thread_stack(struct task_struct *p, struct task_struct *org)
+{
+	struct thread_info *ti = task_thread_info(p);
+	struct thread_info *org_ti = task_thread_info(org);
+
+	ti->flags = org_ti->flags;
+	ti->preempt_count = org_ti->preempt_count;
+	ti->addr_limit = org_ti->addr_limit;
+}
+
+static void kill_thread(struct thread_info *ti)
+{
+	if (!test_ti_thread_flag(ti, TIF_HOST_THREAD)) {
+		ti->dead = true;
+		lkl_ops->sem_up(ti->sched_sem);
+		lkl_ops->thread_join(ti->tid);
+	}
+	lkl_ops->sem_free(ti->sched_sem);
+}
+
+void free_thread_stack(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	kill_thread(ti);
+	kfree(ti);
+}
+
+struct thread_info *_current_thread_info = &init_thread_union.thread_info;
+
+/*
+ * schedule() expects the return of this function to be the task that we
+ * switched away from. Returning prev is not going to work because we are
+ * actually going to return the previous taks that was scheduled before the
+ * task we are going to wake up, and not the current task, e.g.:
+ *
+ * swapper -> init: saved prev on swapper stack is swapper
+ * init -> ksoftirqd0: saved prev on init stack is init
+ * ksoftirqd0 -> swapper: returned prev is swapper
+ */
+static struct task_struct *abs_prev = &init_task;
+
+struct task_struct *__switch_to(struct task_struct *prev,
+				struct task_struct *next)
+{
+	struct thread_info *_prev = task_thread_info(prev);
+	struct thread_info *_next = task_thread_info(next);
+	unsigned long _prev_flags = _prev->flags;
+	struct lkl_jmp_buf _prev_jb;
+
+	_current_thread_info = task_thread_info(next);
+	_next->prev_sched = prev;
+	abs_prev = prev;
+
+	BUG_ON(!_next->tid);
+	lkl_cpu_change_owner(_next->tid);
+
+	if (test_bit(TIF_SCHED_JB, &_prev_flags)) {
+		/* Atomic. Must be done before wakeup next */
+		clear_ti_thread_flag(_prev, TIF_SCHED_JB);
+		_prev_jb = _prev->sched_jb;
+	}
+
+	lkl_ops->sem_up(_next->sched_sem);
+	if (test_bit(TIF_SCHED_JB, &_prev_flags))
+		lkl_ops->jmp_buf_longjmp(&_prev_jb, 1);
+	else
+		lkl_ops->sem_down(_prev->sched_sem);
+
+	if (_prev->dead)
+		lkl_ops->thread_exit();
+
+	return abs_prev;
+}
+
+int host_task_stub(void *unused)
+{
+	return 0;
+}
+
+void switch_to_host_task(struct task_struct *task)
+{
+	if (WARN_ON(!test_tsk_thread_flag(task, TIF_HOST_THREAD)))
+		return;
+
+	task_thread_info(task)->tid = lkl_ops->thread_self();
+
+	if (current == task)
+		return;
+
+	wake_up_process(task);
+	thread_sched_jb();
+	lkl_ops->sem_down(task_thread_info(task)->sched_sem);
+	schedule_tail(abs_prev);
+}
+
+struct thread_bootstrap_arg {
+	struct thread_info *ti;
+	int (*f)(void *arg);
+	void *arg;
+};
+
+static void thread_bootstrap(void *_tba)
+{
+	struct thread_bootstrap_arg *tba = (struct thread_bootstrap_arg *)_tba;
+	struct thread_info *ti = tba->ti;
+	int (*f)(void *) = tba->f;
+	void *arg = tba->arg;
+
+	lkl_ops->sem_down(ti->sched_sem);
+	kfree(tba);
+	if (ti->prev_sched)
+		schedule_tail(ti->prev_sched);
+
+	f(arg);
+	do_exit(0);
+}
+
+int copy_thread(unsigned long clone_flags, unsigned long esp,
+		unsigned long unused, struct task_struct *p)
+{
+	struct thread_info *ti = task_thread_info(p);
+	struct thread_bootstrap_arg *tba;
+
+	if ((int (*)(void *))esp == host_task_stub) {
+		set_ti_thread_flag(ti, TIF_HOST_THREAD);
+		return 0;
+	}
+
+	tba = kmalloc(sizeof(*tba), GFP_KERNEL);
+	if (!tba)
+		return -ENOMEM;
+
+	tba->f = (int (*)(void *))esp;
+	tba->arg = (void *)unused;
+	tba->ti = ti;
+
+	ti->tid = lkl_ops->thread_create(thread_bootstrap, tba);
+	if (!ti->tid) {
+		kfree(tba);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+}
+
+/**
+ * This is called before the kernel initializes, so no kernel calls (including
+ * printk) can't be made yet.
+ */
+void threads_init(void)
+{
+	int ret;
+	struct thread_info *ti = &init_thread_union.thread_info;
+
+	ret = init_ti(ti);
+	if (ret < 0)
+		lkl_printf("lkl: failed to allocate init schedule semaphore\n");
+
+	ti->tid = lkl_ops->thread_self();
+}
+
+void threads_cleanup(void)
+{
+	struct task_struct *p, *t;
+
+	for_each_process_thread(p, t) {
+		struct thread_info *ti = task_thread_info(t);
+
+		if (t->pid != 1 && !test_ti_thread_flag(ti, TIF_HOST_THREAD))
+			WARN(!(t->flags & PF_KTHREAD),
+			     "non kernel thread task %s\n", t->comm);
+		WARN(t->state == TASK_RUNNING,
+		     "thread %s still running while halting\n", t->comm);
+
+		kill_thread(ti);
+	}
+
+	lkl_ops->sem_free(init_thread_union.thread_info.sched_sem);
+}
-- 
2.21.0 (Apple Git-122.2)

