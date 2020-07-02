Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1EB2125A6
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgGBOJM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgGBOJL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:09:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F252C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:09:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 72so784628ple.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8TP+2it8qYSzdLs7U3k6S1PfY7sBYWcPr69Hfa0XJtk=;
        b=hCb1FgxZilTE9fBhETHlvUc0mwZ/10mK4/83l9FuCchEGUevZWr6lq+CWlaz/lvEmQ
         7AWEbiBMO5gOzOHUgO8T+wQ/j63EsT1vUFnh9LJrp10gbcVWoGgJgrDw1uZni1mNEaKL
         l/KmplzKX2xDU7zh8psZOPpvRP+lF4NFSn/m2RrZOK7EzfP0WB4SS1rY6SH9O6qp3Zpz
         CKkKlsmlTc1s6tfHfWvGo5ibF10Xjzp6GNXFQfJT1GzvZPV7wslKxgHMXCjBxIFxUQZB
         Yhu7MryMtWwdK7uRabYiFDtX1/zhVn7AQ0sg1OGlu/7+EOrO+oKb2tCMq3eXJYO5Sy4x
         5heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8TP+2it8qYSzdLs7U3k6S1PfY7sBYWcPr69Hfa0XJtk=;
        b=oIt957S9XKf4vc1EcweX7NAWLhuR8HAph6NcN2S6ovBMiho+x8zLj5mbYBiL4tbt3B
         3C00q5+LY6dGl2YWOkttdkRMZKxcFAxvWNtGeIyVCQfI10HA3jK7G0SrDYydFH71O8Bo
         4XttnoCGIqZh9PNCb4lON5zHuBZI3dTO87qnHXsoDgKw8lcaLx6eJU5Ze17GaCbivVx4
         m27gnzHLkCB8tJ81I+J8Aizyaj1YNIhELF44UTpT5I8/D88y2cepLL2bTqbtgHNDjFNS
         32uzSgcE3N82b0O04fyy1PnGtXKCzAlEIbrms9ZPxQHRoNOu7wgQDLGUsdXeA+q1lzx4
         hWFA==
X-Gm-Message-State: AOAM533uOFkAhTahcM40WR7Y3vkJ6GPAT7ZM3l62AdpwTuhWDHOHVEGf
        Kx8eufgjyAB1aANjYLMTcfg=
X-Google-Smtp-Source: ABdhPJz9a2IEOMB5c8mqQE7pnLRHj5GK6wJRgh6UCippprQJ5Pth7Qh4T6Wlmz1tRnreKAyGmmHkwA==
X-Received: by 2002:a17:90b:2348:: with SMTP id ms8mr31497268pjb.5.1593698950524;
        Thu, 02 Jul 2020 07:09:10 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id j16sm8984694pgb.33.2020.07.02.07.09.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:09:09 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 111F6202D31D2E; Thu,  2 Jul 2020 23:09:07 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 11/21] um: nommu: kernel thread support
Date:   Thu,  2 Jul 2020 23:07:05 +0900
Message-Id: <7e7a8b77a972042234a3e08bfa20da4964c55c9f.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

nommu mode does not support user processes but it must support kernel
threads as part as the normal kernel work-flow. It uses host operations
to create and terminate host threads that are going to run the kernel
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

UML common part (process.c) is extended to call idle functions of
SUBARCH as well as kernel thread detection with a flag information of
TIF_HOST_THREAD.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/include/asm/thread_info.h         |  24 ++
 arch/um/kernel/process.c                  |   8 +-
 arch/um/nommu/include/uapi/asm/host_ops.h |  54 +++++
 arch/um/nommu/um/cpu.c                    | 236 ++++++++++++++++++++
 arch/um/nommu/um/threads.c                | 258 ++++++++++++++++++++++
 5 files changed, 579 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/nommu/um/cpu.c
 create mode 100644 arch/um/nommu/um/threads.c

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 4c19ce4c49f1..433584f6b9d0 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -40,6 +40,7 @@ struct thread_info {
 	.real_thread = NULL,			\
 }
 
+#ifdef CONFIG_MMU
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
@@ -52,6 +53,27 @@ static inline struct thread_info *current_thread_info(void)
 	return ti;
 }
 
+#else
+
+#define __HAVE_THREAD_FUNCTIONS
+#define task_thread_info(task)	((struct thread_info *)(task)->stack)
+#define task_stack_page(task)	((task)->stack)
+#define end_of_stack(p) (&task_thread_info(p)->aux_fp_regs[FP_SIZE-1])
+
+void threads_init(void);
+void threads_cleanup(void);
+
+unsigned long *alloc_thread_stack_node(struct task_struct *p, int node);
+void setup_thread_stack(struct task_struct *p, struct task_struct *org);
+void free_thread_stack(struct task_struct *tsk);
+
+extern struct thread_info *_current_thread_info;
+static inline struct thread_info *current_thread_info(void)
+{
+	return _current_thread_info;
+}
+#endif /* CONFIG_MMU */
+
 #endif
 
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
@@ -63,6 +85,8 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	7
 #define TIF_NOTIFY_RESUME	8
 #define TIF_SECCOMP		9	/* secure computing */
+#define TIF_SCHED_JB		10
+#define TIF_HOST_THREAD		11
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index e5238a42ea17..0dafded5947e 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -157,7 +157,8 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct * p, unsigned long tls)
 {
 	void (*handler)(void);
-	int kthread = current->flags & PF_KTHREAD;
+	int kthread = current->flags & PF_KTHREAD ||
+		test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
@@ -214,10 +215,15 @@ static void um_idle_sleep(void)
 	}
 }
 
+void __weak subarch_cpu_idle(void)
+{
+}
+
 void arch_cpu_idle(void)
 {
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	um_idle_sleep();
+	subarch_cpu_idle();
 	local_irq_enable();
 }
 
diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
index 5253c3f8de0e..720385fccbdf 100644
--- a/arch/um/nommu/include/uapi/asm/host_ops.h
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -16,11 +16,65 @@ struct lkl_jmp_buf {
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
+ *
  * @mem_alloc - allocate memory
  * @mem_free - free memory
  *
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
+	lkl_thread_t (*thread_create)(void *(*f)(void *), void *arg);
+	void (*thread_detach)(void);
+	void (*thread_exit)(void);
+	int (*thread_join)(lkl_thread_t tid);
+	lkl_thread_t (*thread_self)(void);
+	int (*thread_equal)(lkl_thread_t a, lkl_thread_t b);
+	long (*gettid)(void);
+
+	void (*jmp_buf_set)(struct lkl_jmp_buf *jmpb, void (*f)(void));
+	void (*jmp_buf_longjmp)(struct lkl_jmp_buf *jmpb, int val);
+
 	void *(*mem_alloc)(unsigned long mem);
 	void (*mem_free)(void *mem);
 };
diff --git a/arch/um/nommu/um/cpu.c b/arch/um/nommu/um/cpu.c
new file mode 100644
index 000000000000..9986a3f8c5dd
--- /dev/null
+++ b/arch/um/nommu/um/cpu.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/sched/stat.h>
+#include <asm/host_ops.h>
+#include <asm/cpu.h>
+#include <asm/thread_info.h>
+#include <asm/unistd.h>
+#include <asm/sched.h>
+#include <asm/syscalls.h>
+#include <init.h>
+
+void run_irqs(void)
+{
+	panic("unimplemented %s", __func__);
+}
+
+int set_irq_pending(int irq)
+{
+	panic("unimplemented %s", __func__);
+}
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
+static void lkl_cpu_shutdown(void)
+{
+	__sync_fetch_and_add(&cpu.shutdown_gate, MAX_THREADS);
+}
+__uml_exitcall(lkl_cpu_shutdown);
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
+void subarch_cpu_idle(void)
+{
+	if (cpu.shutdown_gate >= MAX_THREADS) {
+
+		lkl_ops->mutex_lock(cpu.lock);
+		while (cpu.sleepers--)
+			lkl_ops->sem_up(cpu.sem);
+		lkl_ops->mutex_unlock(cpu.lock);
+
+		lkl_cpu_cleanup(true);
+
+		lkl_ops->thread_exit();
+	}
+
+#ifdef doesntwork
+	/* switch to idle_host_task */
+	wakeup_idle_host_task();
+#endif
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
diff --git a/arch/um/nommu/um/threads.c b/arch/um/nommu/um/threads.c
new file mode 100644
index 000000000000..3e70eccc191a
--- /dev/null
+++ b/arch/um/nommu/um/threads.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/slab.h>
+#include <linux/sched/task.h>
+#include <linux/sched/signal.h>
+#include <asm/host_ops.h>
+#include <asm/cpu.h>
+#include <asm/sched.h>
+
+#include <os.h>
+
+static int init_arch_thread(struct arch_thread *thread)
+{
+	thread->sched_sem = lkl_ops->sem_alloc(0);
+	if (!thread->sched_sem)
+		return -ENOMEM;
+
+	thread->dead = false;
+	thread->tid = 0;
+
+	return 0;
+}
+
+unsigned long *alloc_thread_stack_node(struct task_struct *task, int node)
+{
+	struct thread_info *ti;
+
+	ti = kmalloc(sizeof(*ti), GFP_KERNEL | __GFP_ZERO);
+	if (!ti)
+		return NULL;
+
+	ti->task = task;
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
+		ti->task->thread.arch.dead = true;
+		lkl_ops->sem_up(ti->task->thread.arch.sched_sem);
+		lkl_ops->thread_join(ti->task->thread.arch.tid);
+	}
+	lkl_ops->sem_free(ti->task->thread.arch.sched_sem);
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
+void switch_threads(jmp_buf *me, jmp_buf *you)
+{
+	/* NOP */
+}
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
+void arch_switch_to(struct task_struct *prev,
+		    struct task_struct *next)
+{
+	struct arch_thread *_prev = &prev->thread.arch;
+	struct arch_thread *_next = &next->thread.arch;
+	unsigned long _prev_flags = task_thread_info(prev)->flags;
+	struct lkl_jmp_buf *_prev_jb;
+
+	_current_thread_info = task_thread_info(next);
+	next->thread.prev_sched = prev;
+	abs_prev = prev;
+
+	WARN_ON(!_next->tid);
+	lkl_cpu_change_owner(_next->tid);
+
+	if (test_bit(TIF_SCHED_JB, &_prev_flags)) {
+		/* Atomic. Must be done before wakeup next */
+		clear_ti_thread_flag(task_thread_info(prev), TIF_SCHED_JB);
+		_prev_jb = &_prev->sched_jb;
+	}
+
+	lkl_ops->sem_up(_next->sched_sem);
+	if (test_bit(TIF_SCHED_JB, &_prev_flags))
+		lkl_ops->jmp_buf_longjmp(_prev_jb, 1);
+	else
+		lkl_ops->sem_down(_prev->sched_sem);
+
+	if (_prev->dead)
+		lkl_ops->thread_exit();
+
+	/* __switch_to (arch/um) returns this value */
+	current->thread.prev_sched = abs_prev;
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
+	task->thread.arch.tid = lkl_ops->thread_self();
+
+	if (current == task)
+		return;
+
+	wake_up_process(task);
+	thread_sched_jb();
+	lkl_ops->sem_down(task->thread.arch.sched_sem);
+	schedule_tail(abs_prev);
+}
+
+struct thread_bootstrap_arg {
+	struct thread_info *ti;
+	int (*f)(void *a);
+	void *arg;
+};
+
+static void *thread_bootstrap(void *_tba)
+{
+	struct thread_bootstrap_arg *tba = (struct thread_bootstrap_arg *)_tba;
+	struct thread_info *ti = tba->ti;
+	int (*f)(void *) = tba->f;
+	void *arg = tba->arg;
+
+	lkl_ops->sem_down(ti->task->thread.arch.sched_sem);
+	kfree(tba);
+	if (ti->task->thread.prev_sched)
+		schedule_tail(ti->task->thread.prev_sched);
+
+	f(arg);
+	do_exit(0);
+
+	return NULL;
+}
+
+void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
+{
+	struct thread_info *ti = (struct thread_info *)stack;
+	struct task_struct *p = ti->task;
+	struct thread_bootstrap_arg *tba;
+	int ret;
+
+	unsigned long esp = (unsigned long)p->thread.request.u.thread.proc;
+	unsigned long unused = (unsigned long)p->thread.request.u.thread.arg;
+
+	ret = init_arch_thread(&p->thread.arch);
+	if (ret < 0)
+		panic("%s: init_arch_thread", __func__);
+
+	if ((int (*)(void *))esp == host_task_stub) {
+		set_ti_thread_flag(ti, TIF_HOST_THREAD);
+		return;
+	}
+
+	tba = kmalloc(sizeof(*tba), GFP_KERNEL);
+	if (!tba)
+		return;
+
+	tba->f = (int (*)(void *))esp;
+	tba->arg = (void *)unused;
+	tba->ti = ti;
+
+	p->thread.arch.tid = lkl_ops->thread_create(thread_bootstrap, tba);
+	if (!p->thread.arch.tid) {
+		kfree(tba);
+		return;
+	}
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+}
+
+static inline void pr_early(const char *str)
+{
+	if (lkl_ops->print)
+		lkl_ops->print(str, strlen(str));
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
+	ti->task->thread = (struct thread_struct) INIT_THREAD;
+	ret = init_arch_thread(&ti->task->thread.arch);
+	if (ret < 0)
+		pr_early("lkl: failed to allocate init schedule semaphore\n");
+
+	ti->task->thread.arch.tid = lkl_ops->thread_self();
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
+	lkl_ops->sem_free(
+		init_thread_union.thread_info.task->thread.arch.sched_sem);
+}
+
+void initial_thread_cb_skas(void (*proc)(void *), void *arg)
+{
+	pr_warn("unimplemented %s", __func__);
+}
+
+int arch_set_tls(struct task_struct *new, unsigned long tls)
+{
+	panic("unimplemented %s", __func__);
+}
+void clear_flushed_tls(struct task_struct *task)
+{
+	panic("unimplemented %s", __func__);
+}
-- 
2.21.0 (Apple Git-122.2)

