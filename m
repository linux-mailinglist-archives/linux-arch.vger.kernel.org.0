Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E661D409DD7
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348152AbhIMUGd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:06:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:38697 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347974AbhIMUGH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:06:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336390"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336390"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643935"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:32 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
Date:   Mon, 13 Sep 2021 13:01:30 -0700
Message-Id: <20210913200132.3396598-12-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a new system call to allow applications to block in the kernel and
wait for user interrupts.

<The current implementation doesn't support waking up from other
blocking system calls like sleep(), read(), epoll(), etc.

uintr_wait() is a placeholder syscall while we decide on that
behaviour.>

When the application makes this syscall the notification vector is
switched to a new kernel vector. Any new SENDUIPI will invoke the kernel
interrupt which is then used to wake up the process.

Currently, the task wait list is global one. To make the implementation
scalable there is a need to move to a distributed per-cpu wait list.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/hardirq.h     |  1 +
 arch/x86/include/asm/idtentry.h    |  1 +
 arch/x86/include/asm/irq_vectors.h |  3 +-
 arch/x86/include/asm/uintr.h       | 22 +++++++
 arch/x86/kernel/idt.c              |  1 +
 arch/x86/kernel/irq.c              | 18 ++++++
 arch/x86/kernel/uintr_core.c       | 94 ++++++++++++++++++++++++------
 arch/x86/kernel/uintr_fd.c         | 15 +++++
 8 files changed, 136 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 279afc01f1ac..a4623fdb65a1 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -22,6 +22,7 @@ typedef struct {
 #endif
 #ifdef CONFIG_X86_USER_INTERRUPTS
 	unsigned int uintr_spurious_count;
+	unsigned int uintr_kernel_notifications;
 #endif
 	unsigned int x86_platform_ipis;	/* arch dependent */
 	unsigned int apic_perf_irqs;
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 5929a6f9eeee..0ac7ef592283 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -673,6 +673,7 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
 
 #ifdef CONFIG_X86_USER_INTERRUPTS
 DECLARE_IDTENTRY_SYSVEC(UINTR_NOTIFICATION_VECTOR,	sysvec_uintr_spurious_interrupt);
+DECLARE_IDTENTRY_SYSVEC(UINTR_KERNEL_VECTOR,		sysvec_uintr_kernel_notification);
 #endif
 
 #if IS_ENABLED(CONFIG_HYPERV)
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index d26faa504931..1d289b3ee0da 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -106,8 +106,9 @@
 
 /* Vector for User interrupt notifications */
 #define UINTR_NOTIFICATION_VECTOR       0xec
+#define UINTR_KERNEL_VECTOR		0xeb
 
-#define LOCAL_TIMER_VECTOR		0xeb
+#define LOCAL_TIMER_VECTOR		0xea
 
 #define NR_VECTORS			 256
 
diff --git a/arch/x86/include/asm/uintr.h b/arch/x86/include/asm/uintr.h
index ef3521dd7fb9..64113ef523ca 100644
--- a/arch/x86/include/asm/uintr.h
+++ b/arch/x86/include/asm/uintr.h
@@ -4,11 +4,29 @@
 
 #ifdef CONFIG_X86_USER_INTERRUPTS
 
+/* User Posted Interrupt Descriptor (UPID) */
+struct uintr_upid {
+	struct {
+		u8 status;	/* bit 0: ON, bit 1: SN, bit 2-7: reserved */
+		u8 reserved1;	/* Reserved */
+		u8 nv;		/* Notification vector */
+		u8 reserved2;	/* Reserved */
+		u32 ndst;	/* Notification destination */
+	} nc __packed;		/* Notification control */
+	u64 puir;		/* Posted user interrupt requests */
+} __aligned(64);
+
+/* UPID Notification control status */
+#define UPID_ON		0x0	/* Outstanding notification */
+#define UPID_SN		0x1	/* Suppressed notification */
+
 struct uintr_upid_ctx {
+	struct list_head node;
 	struct task_struct *task;	/* Receiver task */
 	struct uintr_upid *upid;
 	refcount_t refs;
 	bool receiver_active;		/* Flag for UPID being mapped to a receiver */
+	bool waiting;
 };
 
 struct uintr_receiver_info {
@@ -43,11 +61,15 @@ void uintr_free(struct task_struct *task);
 void switch_uintr_prepare(struct task_struct *prev);
 void switch_uintr_return(void);
 
+int uintr_receiver_wait(void);
+void uintr_wake_up_process(void);
+
 #else /* !CONFIG_X86_USER_INTERRUPTS */
 
 static inline void uintr_free(struct task_struct *task) {}
 static inline void switch_uintr_prepare(struct task_struct *prev) {}
 static inline void switch_uintr_return(void) {}
+static inline void uintr_wake_up_process(void) {}
 
 #endif /* CONFIG_X86_USER_INTERRUPTS */
 
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index d8c45e0728f0..8d4fd7509523 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -149,6 +149,7 @@ static const __initconst struct idt_data apic_idts[] = {
 # endif
 #ifdef CONFIG_X86_USER_INTERRUPTS
 	INTG(UINTR_NOTIFICATION_VECTOR,		asm_sysvec_uintr_spurious_interrupt),
+	INTG(UINTR_KERNEL_VECTOR,		asm_sysvec_uintr_kernel_notification),
 #endif
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index e3c35668c7c5..22349f5c301b 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -22,6 +22,7 @@
 #include <asm/desc.h>
 #include <asm/traps.h>
 #include <asm/thermal.h>
+#include <asm/uintr.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
@@ -187,6 +188,11 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", irq_stats(j)->uintr_spurious_count);
 	seq_puts(p, "  User-interrupt spurious event\n");
+
+	seq_printf(p, "%*s: ", prec, "UKN");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", irq_stats(j)->uintr_kernel_notifications);
+	seq_puts(p, "  User-interrupt kernel notification event\n");
 #endif
 	return 0;
 }
@@ -356,6 +362,18 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_uintr_spurious_interrupt)
 	ack_APIC_irq();
 	inc_irq_stat(uintr_spurious_count);
 }
+
+/*
+ * Handler for UINTR_KERNEL_VECTOR.
+ */
+DEFINE_IDTENTRY_SYSVEC(sysvec_uintr_kernel_notification)
+{
+	/* TODO: Add entry-exit tracepoints */
+	ack_APIC_irq();
+	inc_irq_stat(uintr_kernel_notifications);
+
+	uintr_wake_up_process();
+}
 #endif
 
 
diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
index 8f331c5fe0cf..4e5545e6d903 100644
--- a/arch/x86/kernel/uintr_core.c
+++ b/arch/x86/kernel/uintr_core.c
@@ -28,22 +28,6 @@
 #define UINTR_MAX_UITT_NR 256
 #define UINTR_MAX_UVEC_NR 64
 
-/* User Posted Interrupt Descriptor (UPID) */
-struct uintr_upid {
-	struct {
-		u8 status;	/* bit 0: ON, bit 1: SN, bit 2-7: reserved */
-		u8 reserved1;	/* Reserved */
-		u8 nv;		/* Notification vector */
-		u8 reserved2;	/* Reserved */
-		u32 ndst;	/* Notification destination */
-	} nc __packed;		/* Notification control */
-	u64 puir;		/* Posted user interrupt requests */
-} __aligned(64);
-
-/* UPID Notification control status */
-#define UPID_ON		0x0	/* Outstanding notification */
-#define UPID_SN		0x1	/* Suppressed notification */
-
 struct uintr_receiver {
 	struct uintr_upid_ctx *upid_ctx;
 	u64 uvec_mask;	/* track active vector per bit */
@@ -70,6 +54,10 @@ struct uintr_sender {
 	u64 uitt_mask[BITS_TO_U64(UINTR_MAX_UITT_NR)];
 };
 
+/* TODO: To remove the global lock, move to a per-cpu wait list. */
+static DEFINE_SPINLOCK(uintr_wait_lock);
+static struct list_head uintr_wait_list = LIST_HEAD_INIT(uintr_wait_list);
+
 inline bool uintr_arch_enabled(void)
 {
 	return static_cpu_has(X86_FEATURE_UINTR);
@@ -80,6 +68,12 @@ static inline bool is_uintr_receiver(struct task_struct *t)
 	return !!t->thread.ui_recv;
 }
 
+/* Always make sure task is_uintr_receiver() before calling */
+static inline bool is_uintr_waiting(struct task_struct *t)
+{
+	return t->thread.ui_recv->upid_ctx->waiting;
+}
+
 static inline bool is_uintr_sender(struct task_struct *t)
 {
 	return !!t->thread.ui_send;
@@ -151,6 +145,7 @@ static struct uintr_upid_ctx *alloc_upid(void)
 	refcount_set(&upid_ctx->refs, 1);
 	upid_ctx->task = get_task_struct(current);
 	upid_ctx->receiver_active = true;
+	upid_ctx->waiting = false;
 
 	return upid_ctx;
 }
@@ -494,6 +489,68 @@ int do_uintr_register_sender(struct uintr_receiver_info *r_info,
 	return 0;
 }
 
+int uintr_receiver_wait(void)
+{
+	struct uintr_upid_ctx *upid_ctx;
+	unsigned long flags;
+
+	if (!is_uintr_receiver(current))
+		return -EOPNOTSUPP;
+
+	upid_ctx = current->thread.ui_recv->upid_ctx;
+	upid_ctx->upid->nc.nv = UINTR_KERNEL_VECTOR;
+	upid_ctx->waiting = true;
+	spin_lock_irqsave(&uintr_wait_lock, flags);
+	list_add(&upid_ctx->node, &uintr_wait_list);
+	spin_unlock_irqrestore(&uintr_wait_lock, flags);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule();
+
+	return -EINTR;
+}
+
+/*
+ * Runs in interrupt context.
+ * Scan through all UPIDs to check if any interrupt is on going.
+ */
+void uintr_wake_up_process(void)
+{
+	struct uintr_upid_ctx *upid_ctx, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&uintr_wait_lock, flags);
+	list_for_each_entry_safe(upid_ctx, tmp, &uintr_wait_list, node) {
+		if (test_bit(UPID_ON, (unsigned long *)&upid_ctx->upid->nc.status)) {
+			set_bit(UPID_SN, (unsigned long *)&upid_ctx->upid->nc.status);
+			upid_ctx->upid->nc.nv = UINTR_NOTIFICATION_VECTOR;
+			upid_ctx->waiting = false;
+			wake_up_process(upid_ctx->task);
+			list_del(&upid_ctx->node);
+		}
+	}
+	spin_unlock_irqrestore(&uintr_wait_lock, flags);
+}
+
+/* Called when task is unregistering/exiting */
+static void uintr_remove_task_wait(struct task_struct *task)
+{
+	struct uintr_upid_ctx *upid_ctx, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&uintr_wait_lock, flags);
+	list_for_each_entry_safe(upid_ctx, tmp, &uintr_wait_list, node) {
+		if (upid_ctx->task == task) {
+			pr_debug("wait: Removing task %d from wait\n",
+				 upid_ctx->task->pid);
+			upid_ctx->upid->nc.nv = UINTR_NOTIFICATION_VECTOR;
+			upid_ctx->waiting = false;
+			list_del(&upid_ctx->node);
+		}
+	}
+	spin_unlock_irqrestore(&uintr_wait_lock, flags);
+}
+
 int do_uintr_unregister_handler(void)
 {
 	struct task_struct *t = current;
@@ -548,7 +605,7 @@ int do_uintr_unregister_handler(void)
 	 * based on this UPID.
 	 */
 	set_bit(UPID_SN, (unsigned long *)&ui_recv->upid_ctx->upid->nc.status);
-
+	uintr_remove_task_wait(t);
 	put_upid_ref(ui_recv->upid_ctx);
 	kfree(ui_recv);
 	t->thread.ui_recv = NULL;
@@ -684,7 +741,7 @@ void switch_uintr_prepare(struct task_struct *prev)
 {
 	struct uintr_upid *upid;
 
-	if (is_uintr_receiver(prev)) {
+	if (is_uintr_receiver(prev) && !is_uintr_waiting(prev)) {
 		upid = prev->thread.ui_recv->upid_ctx->upid;
 		set_bit(UPID_SN, (unsigned long *)&upid->nc.status);
 	}
@@ -806,6 +863,7 @@ void uintr_free(struct task_struct *t)
 		 * generated based on this UPID.
 		 */
 		set_bit(UPID_SN, (unsigned long *)&ui_recv->upid_ctx->upid->nc.status);
+		uintr_remove_task_wait(t);
 		ui_recv->upid_ctx->receiver_active = false;
 		put_upid_ref(ui_recv->upid_ctx);
 		kfree(ui_recv);
diff --git a/arch/x86/kernel/uintr_fd.c b/arch/x86/kernel/uintr_fd.c
index 3c82c032c0b9..a7e55d98c0c7 100644
--- a/arch/x86/kernel/uintr_fd.c
+++ b/arch/x86/kernel/uintr_fd.c
@@ -283,3 +283,18 @@ SYSCALL_DEFINE2(uintr_unregister_sender, int, uintrfd, unsigned int, flags)
 	fdput(f);
 	return ret;
 }
+
+/*
+ * sys_uintr_wait - Wait for a user interrupt
+ */
+SYSCALL_DEFINE1(uintr_wait, unsigned int, flags)
+{
+	if (!uintr_arch_enabled())
+		return -EOPNOTSUPP;
+
+	if (flags)
+		return -EINVAL;
+
+	/* TODO: Add a timeout option */
+	return uintr_receiver_wait();
+}
-- 
2.33.0

