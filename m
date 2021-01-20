Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA12FC918
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbhATDfa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbhATC32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7CDC0613CF
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:45 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s15so11673411plr.9
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ToO/WYTxIr1LPeucqKH8GBPoC7WHzAa9s65l36SnES4=;
        b=NfCJd3GtI8WkI01UhpkCPCkjOx+iy/+59sUAtGJi5QUqBVOvn8xcw0EHFLmkQPpgNk
         WR7KB4gN3r1TjCb72jKedGaaA5eV2PAwBz+bsNjkK6AhlkrugHf0K4Z/O+xMEUuGHaI2
         mDgbzy60NyLBIjQ7Y6solGCFdiZsP7pBwwzq6dtQJgG4DBrZZbkaOH62OctNXug9OGlz
         eDyp/Ql75Fh5IW+SvVrfldk2LmejrRqWfbt4H51zXz+ZYPexe6RvlpSFZ/S2gKUVCQ8d
         hHdsAmHyFHxiHbytDEjnMnGrqKWIdNNbWOf/sfI1n8ptQDJWTZt6Ai1iQP0Ffxw+wEjV
         g6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ToO/WYTxIr1LPeucqKH8GBPoC7WHzAa9s65l36SnES4=;
        b=pmyU66pA4rSLe5oP2CF9ROOOtSOEGJB1hj3iVFdTEnlo9i+F6FL04BUYR5A+vjimNJ
         RhhR9h3oqVDx3LIOw4uDh2tTSui/Cl/B410hINFawhfQ0XoPiNJdtqFx6pUMq+bUTRX/
         TTJd1CXyoowpNfmhFFZgkOP5BJCEB5sboAbztKqaHTHSF9lUvbbprnvmmaCeQeOnyx2v
         acRmKMG/yr6kSNkV40wzeVTANIHNp0yUJT0I89ZPKK91C0ykMTWAIAwTmHMdBhEaTccX
         PjR0S8ZJGsWKeNfqgWieSsUvv/Q8VVmCvmKc4jXmDxgJDJ0/Ar+HXx/VLRr4He2ifsjJ
         HlEg==
X-Gm-Message-State: AOAM530uNuXKBRyAwqVo1s9X1Elpl0uv21HDqYYxw8zc0hwbRUqs8+0Q
        84/MCz5fZFC5hZYINJW39Io=
X-Google-Smtp-Source: ABdhPJxNraVi0423Ev4XYbhrqbhx7PS0eFJCADqDT1ysnnSBADxtflwaQ1FagFj3USJ3HvE1ZQgs1A==
X-Received: by 2002:a17:902:7242:b029:db:d1ae:46bb with SMTP id c2-20020a1709027242b02900dbd1ae46bbmr7652190pll.77.1611109724402;
        Tue, 19 Jan 2021 18:28:44 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 68sm382550pfe.33.2021.01.19.18.28.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:28:43 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 089BD20442D333; Wed, 20 Jan 2021 11:28:42 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 09/20] um: lkl: kernel thread support
Date:   Wed, 20 Jan 2021 11:27:14 +0900
Message-Id: <3aecd66b9314f2b435fb6df029dc5829bf8c50ff.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

library mode does not support user processes but it must support kernel
threads as part as the normal kernel work-flow. It uses host functions
to create and terminate host threads that are going to run the kernel
threads. It also uses semaphores to synchronize those threads and to
allow the Linux kernel scheduler to control how the kernel threads
run.

Each kernel thread runs in a host thread and has a host semaphore
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

Kernel threads are executed with the synchronization to other context
primitivecs of kernel, such as idle thread, system calls, interrupts,
"reentrancy", CPU shutdown, imbalance wake up, which are not
controllable with a simple synchronization mechanism.  Thus we
introduced a logical CPU entity, struct lkl_cpu, to run Linux code with
multiple threads; CPU get/put functions (lkl_cpu_put/lkl_cpu_get) is
used to serialize access between LKL threads and host threads that
issue direct calls.

UML common part (process.c) is extended to call idle functions of
SUBARCH as well as kernel thread detection with a flag information of
TIF_HOST_THREAD.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/include/asm/thread_info.h       |  24 +++
 arch/um/kernel/process.c                |   8 +-
 arch/um/lkl/include/asm/cpu.h           |  11 +
 arch/um/lkl/include/asm/sched.h         |  23 +++
 arch/um/lkl/include/uapi/asm/host_ops.h | 164 +++++++++++++++
 arch/um/lkl/um/cpu.c                    | 223 ++++++++++++++++++++
 arch/um/lkl/um/threads.c                | 258 ++++++++++++++++++++++++
 7 files changed, 710 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/lkl/include/asm/cpu.h
 create mode 100644 arch/um/lkl/include/asm/sched.h
 create mode 100644 arch/um/lkl/um/cpu.c
 create mode 100644 arch/um/lkl/um/threads.c

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 3b1cb8b3b186..528e0347a9d8 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -40,6 +40,7 @@ struct thread_info {
 	.real_thread = NULL,			\
 }
 
+#ifndef CONFIG_UMMODE_LIB
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
@@ -52,6 +53,27 @@ static inline struct thread_info *current_thread_info(void)
 	return ti;
 }
 
+#else /* CONFIG_UMMODE_LIB */
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
+#endif /* CONFIG_UMMODE_LIB */
+
 #endif
 
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
@@ -64,6 +86,8 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	7
 #define TIF_NOTIFY_RESUME	8
 #define TIF_SECCOMP		9	/* secure computing */
+#define TIF_SCHED_JB		10	/* thread is configured with jump buffer */
+#define TIF_HOST_THREAD	11	/* thread is a host task */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 9b0a36f64339..535ba738f2f5 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -160,7 +160,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct * p, unsigned long tls)
 {
 	void (*handler)(void);
-	int kthread = current->flags & PF_KTHREAD;
+	int kthread = current->flags & PF_KTHREAD ||
+		test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
@@ -214,10 +215,15 @@ void um_idle_sleep(void)
 		os_idle_sleep();
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
 	raw_local_irq_enable();
 }
 
diff --git a/arch/um/lkl/include/asm/cpu.h b/arch/um/lkl/include/asm/cpu.h
new file mode 100644
index 000000000000..c1164187151e
--- /dev/null
+++ b/arch/um/lkl/include/asm/cpu.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_CPU_H
+#define __UM_LIBMODE_CPU_H
+
+int lkl_cpu_get(void);
+void lkl_cpu_put(void);
+int lkl_cpu_init(void);
+void lkl_cpu_wait_shutdown(void);
+void lkl_cpu_change_owner(lkl_thread_t owner);
+
+#endif
diff --git a/arch/um/lkl/include/asm/sched.h b/arch/um/lkl/include/asm/sched.h
new file mode 100644
index 000000000000..1ac063ed987c
--- /dev/null
+++ b/arch/um/lkl/include/asm/sched.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_SCHED_H
+#define __UM_LIBMODE_SCHED_H
+
+#include <linux/sched.h>
+#include <uapi/asm/host_ops.h>
+
+static inline void thread_sched_jb(void)
+{
+	if (test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD)) {
+		set_ti_thread_flag(current_thread_info(), TIF_SCHED_JB);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		lkl_jmp_buf_set(&current_thread_info()->task->thread.arch.sched_jb,
+				     schedule);
+	} else {
+		lkl_bug("%s can be used only for host task", __func__);
+	}
+}
+
+void switch_to_host_task(struct task_struct *);
+int host_task_stub(void *unused);
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index 17219802fa1d..039a17972d7d 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -2,6 +2,13 @@
 #ifndef __UM_LIBMODE_UAPI_HOST_OPS_H
 #define __UM_LIBMODE_UAPI_HOST_OPS_H
 
+struct lkl_mutex;
+struct lkl_sem;
+typedef unsigned long lkl_thread_t;
+struct lkl_jmp_buf {
+	unsigned long buf[128];
+};
+
 /**
  * struct lkl_host_operations - host operations used by the Linux kernel
  *
@@ -36,4 +43,161 @@ void *lkl_mem_alloc(unsigned long mem);
  */
 void lkl_mem_free(void *mem);
 
+/**
+ * lkl_sem_alloc - allocate a host semaphore an initialize it to count
+ *
+ * @count: initial counter value
+ *
+ * Return: the pointer of allocated semaphore
+ *
+ */
+struct lkl_sem *lkl_sem_alloc(int count);
+
+/**
+ * lkl_sem_free - free a host semaphore
+ *
+ * @sem: the address of semaphore to be freed
+ *
+ */
+void lkl_sem_free(struct lkl_sem *sem);
+
+/**
+ * lkl_sem_up - perform an up operation on the semaphore
+ *
+ * @sem: semaphore pointer address
+ *
+ */
+void lkl_sem_up(struct lkl_sem *sem);
+
+/**
+ * lkl_sem_down - perform a down operation on the semaphore
+ *
+ * @sem: semaphore pointer address
+ *
+ */
+void lkl_sem_down(struct lkl_sem *sem);
+
+/**
+ * lkl_mutex_alloc - allocate and initialize a host mutex
+ *
+ * @recursive: boolean flag if the mutex is recursive or not
+ *
+ * Return: the pointer of allocated mutex
+ *
+ */
+struct lkl_mutex *lkl_mutex_alloc(int recursive);
+
+/**
+ * lkl_mutex_free - free a host mutex
+ *
+ * @mutex: the mutex pointer to be freed
+ *
+ */
+void lkl_mutex_lock(struct lkl_mutex *mutex);
+
+/**
+ * lkl_mutex_lock - acquire the mutex
+ *
+ * @_mutex: the mutex pointer to be locked
+ *
+ */
+void lkl_mutex_unlock(struct lkl_mutex *_mutex);
+
+/**
+ * lkl_mutex_unlock - release the mutex
+ *
+ * @_mutex: the mutex pointer to be released
+ *
+ */
+void lkl_mutex_free(struct lkl_mutex *_mutex);
+
+/**
+ * lkl_thread_create - create a new thread and run f(arg) in its context
+ *
+ * @fn: a start routine when creating a thread
+ * @arg: an argument for the function @fn
+ *
+ * Return: a thread handle or 0 if the thread could not be created
+ *
+ */
+lkl_thread_t lkl_thread_create(void* (*fn)(void *), void *arg);
+
+/**
+ * lkl_thread_detach - on POSIX systems, free up resources held by
+ * pthreads.
+ *
+ */
+void lkl_thread_detach(void);
+
+/**
+ * lkl_thread_exit - terminates the current thread
+ *
+ */
+void lkl_thread_exit(void);
+
+/**
+ * lkl_thread_join - wait for the given thread to terminate.
+ *
+ * @tid: thread id to wait
+ *
+ * Return: 0 for success, -1 otherwise
+ *
+ */
+int lkl_thread_join(lkl_thread_t tid);
+
+/**
+ * lkl_thread_self - returns the identifier of the current thread
+ *
+ * Return: the identifier of the current thread
+ *
+ */
+lkl_thread_t lkl_thread_self(void);
+
+/**
+ * lkl_thread_equal - compare if thread a and b are identical or not
+ *
+ * @a: a thread to be compared
+ * @b: another thread to be compared with @a
+ *
+ * Return: 1 if @a and @b are same; otherwise 0
+ *
+ */
+int lkl_thread_equal(lkl_thread_t a, lkl_thread_t b);
+
+/**
+ * lkl_gettid - obtain the thread identifier of the current thread
+ *
+ * Return: the host thread id of the caller, which need not be the same
+ * as the handle returned by thread_create
+ *
+ */
+long lkl_gettid(void);
+
+/**
+ * lkl_jmp_buf_set - set the jump buffer with a setup function
+ *
+ * @jmpb: jump buffer to be saved
+ * @f: a function to be called
+ *
+ * This runs the given function and setups a jump back point by saving
+ * the context in the jump buffer; jmp_buf_longjmp can be called from the give
+ * function or any callee in that function to return back to the jump back
+ * point.
+ *
+ * NOTE: we can't return from lkl_jmp_buf_set before calling lkl_jmp_buf_longjmp
+ * or otherwise the saved context (stack) is not going to be valid, so we must
+ * pass the function that will eventually call longjmp here.
+ *
+ */
+void lkl_jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void));
+
+/**
+ * lkl_jmp_buf_longjmp - perform a jump back to the saved jump buffer
+ *
+ * @jmpb: jump buffer to be restored
+ * @val: returned value of longjmp
+ *
+ */
+void lkl_jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val);
+
 #endif
diff --git a/arch/um/lkl/um/cpu.c b/arch/um/lkl/um/cpu.c
new file mode 100644
index 000000000000..75452b28d741
--- /dev/null
+++ b/arch/um/lkl/um/cpu.c
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
+#include <init.h>
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
+/*
+ * internal routine to acquire LKL CPU's lock
+ */
+static int __cpu_try_get_lock(int n)
+{
+	lkl_thread_t self;
+
+	if (__sync_fetch_and_add(&cpu.shutdown_gate, n) >= MAX_THREADS)
+		return -2;
+
+	lkl_mutex_lock(cpu.lock);
+
+	if (cpu.shutdown_gate >= MAX_THREADS)
+		return -1;
+
+	self = lkl_thread_self();
+
+	/* if someone else is using the cpu, indicate as return 0 */
+	if (cpu.owner && !lkl_thread_equal(cpu.owner, self))
+		return 0;
+
+	/* set the owner of cpu */
+	cpu.owner = self;
+	cpu.count++;
+
+	return 1;
+}
+
+/*
+ * internal routine to release LKL CPU's lock
+ */
+static void __cpu_try_get_unlock(int lock_ret, int n)
+{
+	/* release lock only if __cpu_try_get_lock() holds cpu.lock
+	 * (returns >= -1)
+	 */
+	if (lock_ret >= -1)
+		lkl_mutex_unlock(cpu.lock);
+	__sync_fetch_and_sub(&cpu.shutdown_gate, n);
+}
+
+void lkl_cpu_change_owner(lkl_thread_t owner)
+{
+	lkl_mutex_lock(cpu.lock);
+	if (cpu.count > 1)
+		lkl_bug("bad count while changing owner\n");
+	cpu.owner = owner;
+	lkl_mutex_unlock(cpu.lock);
+}
+
+int lkl_cpu_get(void)
+{
+	int ret;
+
+	ret = __cpu_try_get_lock(1);
+
+	/* when somebody holds a lock, sleep until released,
+	 * with obtaining a semaphore (cpu.sem)
+	 */
+	while (ret == 0) {
+		cpu.sleepers++;
+		__cpu_try_get_unlock(ret, 0);
+		lkl_sem_down(cpu.sem);
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
+	lkl_mutex_lock(cpu.lock);
+
+	if (!cpu.count || !cpu.owner ||
+	    !lkl_thread_equal(cpu.owner, lkl_thread_self()))
+		lkl_bug("%s: unbalanced put\n", __func__);
+
+	/* switch to userspace code if current is host task (TIF_HOST_THREAD),
+	 * AND, there are other running tasks.
+	 */
+	if (test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD) &&
+	    !single_task_running() && cpu.count == 1) {
+		if (in_interrupt())
+			lkl_bug("%s: in interrupt\n", __func__);
+		lkl_mutex_unlock(cpu.lock);
+		thread_sched_jb();
+		return;
+	}
+
+	/* if there are any other tasks holding cpu lock, return after
+	 * decreasing cpu.count
+	 */
+	if (--cpu.count > 0) {
+		lkl_mutex_unlock(cpu.lock);
+		return;
+	}
+
+	/* release semaphore if slept */
+	if (cpu.sleepers) {
+		cpu.sleepers--;
+		lkl_sem_up(cpu.sem);
+	}
+
+	cpu.owner = 0;
+
+	lkl_mutex_unlock(cpu.lock);
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
+	lkl_sem_down(cpu.shutdown_sem);
+	lkl_sem_free(cpu.shutdown_sem);
+}
+
+static void lkl_cpu_cleanup(bool shutdown)
+{
+	while (__sync_fetch_and_add(&cpu.shutdown_gate, 0) > MAX_THREADS)
+		;
+
+	/* if caller indicates shutdown, notify the semaphore to release
+	 * the block (lkl_cpu_wait_shutdown()).
+	 */
+	if (shutdown)
+		lkl_sem_up(cpu.shutdown_sem);
+	/* if lkl_cpu_wait_shutdown() is not called, free shutdown_sem here */
+	else if (cpu.shutdown_sem)
+		lkl_sem_free(cpu.shutdown_sem);
+
+	if (cpu.sem)
+		lkl_sem_free(cpu.sem);
+	if (cpu.lock)
+		lkl_mutex_free(cpu.lock);
+}
+
+void subarch_cpu_idle(void)
+{
+	if (cpu.shutdown_gate >= MAX_THREADS) {
+		lkl_mutex_lock(cpu.lock);
+		while (cpu.sleepers--)
+			lkl_sem_up(cpu.sem);
+		lkl_mutex_unlock(cpu.lock);
+
+		lkl_cpu_cleanup(true);
+		lkl_thread_exit();
+	}
+}
+
+int lkl_cpu_init(void)
+{
+	cpu.lock = lkl_mutex_alloc(0);
+	cpu.sem = lkl_sem_alloc(0);
+	cpu.shutdown_sem = lkl_sem_alloc(0);
+
+	if (!cpu.lock || !cpu.sem || !cpu.shutdown_sem) {
+		lkl_cpu_cleanup(false);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/arch/um/lkl/um/threads.c b/arch/um/lkl/um/threads.c
new file mode 100644
index 000000000000..7ef9b9f2a6b7
--- /dev/null
+++ b/arch/um/lkl/um/threads.c
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
+	thread->sched_sem = lkl_sem_alloc(0);
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
+		lkl_sem_up(ti->task->thread.arch.sched_sem);
+		lkl_thread_join(ti->task->thread.arch.tid);
+	}
+	lkl_sem_free(ti->task->thread.arch.sched_sem);
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
+EXPORT_SYMBOL(_current_thread_info);
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
+	lkl_sem_up(_next->sched_sem);
+	if (test_bit(TIF_SCHED_JB, &_prev_flags))
+		lkl_jmp_buf_longjmp(_prev_jb, 1);
+	else
+		lkl_sem_down(_prev->sched_sem);
+
+	if (_prev->dead)
+		lkl_thread_exit();
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
+	task->thread.arch.tid = lkl_thread_self();
+
+	if (current == task)
+		return;
+
+	wake_up_process(task);
+	thread_sched_jb();
+	lkl_sem_down(task->thread.arch.sched_sem);
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
+	lkl_sem_down(ti->task->thread.arch.sched_sem);
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
+	p->thread.arch.tid = lkl_thread_create(thread_bootstrap, tba);
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
+	lkl_print(str, strlen(str));
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
+	ti->task->thread.arch.tid = lkl_thread_self();
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
+	lkl_sem_free(
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

