Return-Path: <linux-arch+bounces-15804-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0091D258FD
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 17:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C054430628EC
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C13B8D4E;
	Thu, 15 Jan 2026 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOCdnuYC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340B3B8D5E
	for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492796; cv=none; b=NPpbUMd2bi/bIN0qVBu3O3Jly36N4qw9LZk3e4wYvwDu9CL7gQPFj3hPeqP3FaUQLpFAfA8RF7/dct5qr/PV0evndLhGrVO9nMuxxukY/xsV/EbOGFHeiRM7nuU3QJVfKdeD1T5ZRYXizNk8BbdPa9VtRDcLShZLdnPBAUwQvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492796; c=relaxed/simple;
	bh=MozyN4Od44ey5ijYJKmZAE86ZiHT8gweV7LiHMIhqWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+ft74tNZkkSDwNIISTJZwO5GoH2KS+fhiAWAUoueDkc1HHoga0thoKD5ab1StOTB+Uf4iksRNVK25szdseN4Yp1ZA6KCXDXsmgF3ppRtXOwPnjxuTxLN/IOgT8rPNQe5X781Rd9+zugxpanvI/f5KjXfO4wZA5rVkAso0MnyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qOCdnuYC; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64d251b8c5dso1313100a12.1
        for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 07:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768492793; x=1769097593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9dsOBdhdCmqfguZBKCZmKQkeZ4alYg4SeLbag/zBfw=;
        b=qOCdnuYCXxXllBQXAEZ8mQ+ksBqNORGw7qQKdf/D1y89YVqP6XwHb3bilpO9k4SU4C
         K/BKVCmqBCKh4kqM81W0qYK4U9543m+NNtTOHGPmguK1qnJ+G8QYdL90OXGEuL4MxeCy
         UiW8L22VG5xKSbyAVb6amg0OOgh/aDKp2BpzTscdSWAe5tHBVzRhdHqV6Yokn3sSx4pE
         sJ+u/5Q0+hTPGwp82SouDF1853bpsKpkslD/22TJ2VMJWJvDFWa0ezrjKlR9R0fLtz52
         15L0ne55SjhKpIcbQhNRV8aWwDQSk0SWAtcfOPjXvzGSNxuj/0BfVwWN5n+SdT/9aIhe
         cO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768492793; x=1769097593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9dsOBdhdCmqfguZBKCZmKQkeZ4alYg4SeLbag/zBfw=;
        b=FT4lDMa5aV7Oi6FcsVLbXElRlarfHS5EPaKCG6pC3BsX1Wf2RW7BQyeeBa4d9RQFGL
         hvy5j3eQ1AJ8JUC6hUQMAu3+Ktxze1J9zDT+TqWmMkbLe7YXHj+RlKcEOAgCN9Z57Mma
         nbp2tAHFVQ8CqR0G4jYm09qtpErXZCxCb7CBq3L/xo+JMQhoDlkyCm3IEabVLKMFPci9
         6QnJqwyTn5C9hucdSdpiBseVmm/2w5IRmyFZ+Lg2hQM8Rxl4zZx7NsYWDhDWI4FVCppG
         8f0Oyn/GmM4BIlGEtA3cyCoB/ZDIt388oabHLCojIyk+ewRUusr6AYmlBZ6ONS6T0cHu
         DOxw==
X-Forwarded-Encrypted: i=1; AJvYcCXqoWki+UApS2RoK4vHEfJZhFp08Bf4kn92wdi//HTUn+8qz6ZWsqb9U3hRQJanYl+h39LxCnvXBbYz@vger.kernel.org
X-Gm-Message-State: AOJu0YypKUKjgmdWzpDiFEFpt45JfgyQYJiDteqw3mHJToYd5XKCp/BQ
	47sbWjMI9zK6SdCVoTNFf1rPGvASs3S4SovIXNcyYiqMCag695i5emp7xhmCi1JEqOFeeuGD/Hr
	9CXdJww==
X-Received: from edqo10.prod.google.com ([2002:aa7:c50a:0:b0:64b:7653:fb7d])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:42ca:b0:650:8563:fdc6
 with SMTP id 4fb4d7f45d1cf-653ec459e78mr4887620a12.24.1768492792595; Thu, 15
 Jan 2026 07:59:52 -0800 (PST)
Date: Thu, 15 Jan 2026 15:59:41 +0000
In-Reply-To: <20260115155942.482137-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115155942.482137-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115155942.482137-3-lrizzo@google.com>
Subject: [PATCH v4 2/3] genirq: Fixed-delay Global Software Interrupt
 Moderation (GSIM)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Some platforms show reduced I/O performance when the total device
interrupt rate across the entire platform becomes too high.

Interrupt moderation can be used to rate-limit individual interrupts,
and as a consequence also the total rate. Not all devices implement
moderation in hardware, or they may have impractically coarse granularity
(e.g. NVME specifies 100us).

GSIM implements interrupt moderation in software, allowing control of
interrupt rates even without hardware support. It als provides a building
block for more sophisticated, adaptive mechanisms.

Moderation is enabled/disabled per interrupt source with

  echo 1 > /proc/irq/NN/soft_moderation # use 0 to disable

For interrupts with moderation enabled, the delay is fixed, and equal
for all.  It is configured via procfs (range 0-500, 0 means disabled):

  echo delay_us=XX > /proc/irq/soft_moderation

Per CPU statistics on how often moderation is used are available via

  cat /proc/irq/soft_moderation/stats

GSIM is limited to edge interrupts using handle_edge_irq() or
handle_fasteoi_irq(). It has been tested on Intel (including with
intremap=posted_msi), AMD, ARM cpus with NIC, NVME and VFIO devices.

PERFORMANCE BENEFITS:
Below are some experimental results under high load (the first number is
without GSIM; the second is with delay_us=100)

- 100Gbps NIC, 32 queues: rx goes from 50 Gbps to 92.8 Gbps (line rate).
- 200Gbps NIC, 10 VMs (total 160 queues): rx goes from 30 Gbps to 190 Gbps (line rate).
- 8 SSD, 64 queues: 4K random read goes from 6M to 13.4M IOPS (device max).
- 12 SSD, 96 queues: 4K random read goes from 6M to 20.5M IOPS (device max).

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/irqdesc.h     |  12 +
 kernel/irq/Kconfig          |  11 +
 kernel/irq/Makefile         |   1 +
 kernel/irq/chip.c           |  15 ++
 kernel/irq/internals.h      |  10 +
 kernel/irq/irq_moderation.c | 444 ++++++++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation.h | 111 +++++++++
 kernel/irq/irqdesc.c        |   1 +
 kernel/irq/proc.c           |   2 +
 9 files changed, 607 insertions(+)
 create mode 100644 kernel/irq/irq_moderation.c
 create mode 100644 kernel/irq/irq_moderation.h

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 17902861de76d..8b2edce25a4d8 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -17,6 +17,16 @@ struct irq_desc;
 struct irq_domain;
 struct pt_regs;
 
+/**
+ * struct irq_desc_mod - interrupt moderation information
+ * @ms_node:		per-CPU list of moderated irq_desc
+ */
+struct irq_desc_mod {
+#ifdef CONFIG_IRQ_SW_MODERATION
+	struct list_head	ms_node;
+#endif
+};
+
 /**
  * struct irqstat - interrupt statistics
  * @cnt:	real-time interrupt count
@@ -46,6 +56,7 @@ struct irqstat {
  * @threads_handled:	stats field for deferred spurious detection of threaded handlers
  * @threads_handled_last: comparator field for deferred spurious detection of threaded handlers
  * @lock:		locking for SMP
+ * @mod_state:		moderation state
  * @affinity_hint:	hint to user space for preferred irq affinity
  * @affinity_notify:	context for notification of affinity changes
  * @pending_mask:	pending rebalanced interrupts
@@ -81,6 +92,7 @@ struct irq_desc {
 	atomic_t		threads_handled;
 	int			threads_handled_last;
 	raw_spinlock_t		lock;
+	struct irq_desc_mod	mod_state;
 	struct cpumask		*percpu_enabled;
 #ifdef CONFIG_SMP
 	const struct cpumask	*affinity_hint;
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1b4254d19a73e..cb104d1cabd0e 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -155,6 +155,17 @@ config IRQ_KUNIT_TEST
 
 endmenu
 
+config IRQ_SW_MODERATION
+	bool "Enable Global Software Interrupt Moderation"
+	depends on PROC_FS
+	help
+	  Enable Global Software Interrupt Moderation.
+	  Uses a local timer to delay interrupts in configurable ways
+	  and depending on various global system load indicators
+	  and targets.
+
+	  If you don't know what to do here, say N.
+
 config GENERIC_IRQ_MULTI_HANDLER
 	bool
 	help
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 6ab3a40556670..5bd1fb464ace6 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
 obj-$(CONFIG_IRQ_SIM) += irq_sim.o
+obj-$(CONFIG_IRQ_SW_MODERATION) += irq_moderation.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
 obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 678f094d261a7..6ea5bb672b6ca 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -18,6 +18,7 @@
 #include <trace/events/irq.h>
 
 #include "internals.h"
+#include "irq_moderation.h"
 
 static irqreturn_t bad_chained_irq(int irq, void *dev_id)
 {
@@ -486,6 +487,10 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
 	if (!irqd_has_set(irqd, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED))
 		return true;
 
+	/* Moderated ones (also have IRQD_IRQ_INPROGRESS) need early return. */
+	if (irqd_has_set(&desc->irq_data, IRQD_IRQ_MODERATED))
+		return false;
+
 	/*
 	 * If the interrupt is an armed wakeup source, mark it pending
 	 * and suspended, disable it and notify the pm core about the
@@ -745,6 +750,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	 * handling the previous one - it may need to be resent.
 	 */
 	if (!irq_can_handle_pm(desc)) {
+		if (irqd_has_set(&desc->irq_data, IRQD_IRQ_MODERATED)) {
+			desc->istate |= IRQS_PENDING;
+			mask_irq(desc);
+		}
 		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
 			desc->istate |= IRQS_PENDING;
 		cond_eoi_irq(chip, &desc->irq_data);
@@ -765,6 +774,9 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	cond_unmask_eoi_irq(desc, chip);
 
+	if (irq_start_moderation(desc))
+		return;
+
 	/*
 	 * When the race described above happens this will resend the interrupt.
 	 */
@@ -854,6 +866,9 @@ void handle_edge_irq(struct irq_desc *desc)
 
 		handle_irq_event(desc);
 
+		if (irq_start_moderation(desc))
+			break;
+
 	} while ((desc->istate & IRQS_PENDING) && !irqd_irq_disabled(&desc->irq_data));
 }
 EXPORT_SYMBOL(handle_edge_irq);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0164ca48da59e..20ea3e4ee5f2d 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -521,3 +521,13 @@ static inline void irq_debugfs_copy_devname(int irq, struct device *dev)
 {
 }
 #endif /* CONFIG_GENERIC_IRQ_DEBUGFS */
+
+#ifdef CONFIG_IRQ_SW_MODERATION
+void irq_moderation_init_fields(struct irq_desc_mod *mod);
+void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode);
+void irq_moderation_procfs_remove(struct irq_desc *desc);
+#else
+static inline void irq_moderation_init_fields(struct irq_desc_mod *mod) {}
+static inline void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode) {}
+static inline void irq_moderation_procfs_remove(struct irq_desc *desc) {}
+#endif
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
new file mode 100644
index 0000000000000..07d1e740addcd
--- /dev/null
+++ b/kernel/irq/irq_moderation.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+
+#include <linux/cpuhotplug.h>
+#include <linux/glob.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kallsyms.h>
+#include <linux/notifier.h>
+#include <linux/proc_fs.h>
+#include <linux/suspend.h>
+#include <linux/seq_file.h>
+
+#include "internals.h"
+#include "irq_moderation.h"
+
+/*
+ * Global Software Interrupt Moderation (GSIM)
+ *
+ * Some platforms show reduced I/O performance when the total device interrupt
+ * rate across the entire platform becomes too high. To address the problem,
+ * GSIM uses a hook after running the handler to implement software interrupt
+ * moderation with programmable delay.
+ *
+ * Configuration is done at runtime via procfs
+ *   echo ${VALUE} > /proc/irq/soft_moderation/${NAME}
+ *
+ * Supported parameters:
+ *
+ *   delay_us (default 0, suggested 100, 0 off, range 0-500)
+ *       Maximum moderation delay. A reasonable range is 20-100. Higher values
+ *       can be useful if the hardirq handler has long runtimes.
+ *
+ * Moderation can be enabled/disabled dynamically for individual interrupts with
+ *   echo 1 > /proc/irq/NN/soft_moderation # use 0 to disable
+ *
+ * Monitoring of per-cpu and global statistics is available via procfs
+ *   cat /proc/irq/soft_moderation/stats
+ *
+ * === ARCHITECTURE ===
+ *
+ * INTERRUPT HANDLING:
+ * - irq_moderation_hook() runs under desc->lock right after the interrupt handler.
+ *   If the interrupt must be moderated, it sets IRQD_IRQ_INPROGRESS, calls
+ *   __disable_irq() adds the irq_desc to a per-CPU list of moderated interrupts,
+ *   and starts a moderation timer if not yet active.
+ * - desc->handler is modified so that when called on a moderated irq_desc it
+ *   calls mask_irq(), sets IRQS_PENDING and returns immediately.
+ * - the timer callback drains the moderation list: on each irq_desc it acquires
+ *   desc->lock, and if desc->action != NULL calls __enable_irq(), possibly calling
+ *   the handler if IRQS_PENDING is set.
+ *
+ * INTERRUPT TEARDOWN
+ * is protected by IRQD_IRQ_INPROGRESS and checking desc->action != NULL.
+ * This works because free_irq() runs in two steps:
+ * - first clear desc->action (under lock),
+ * - then call synchronize_irq(), which blocks on IRQD_IRQ_INPROGRESS
+ *   before freeing resources.
+ * When the moderation timer races with free_irq() we can have two cases:
+ * 1. timer runs before clearing desc->action. In this case __enable_irq()
+ *    is valid and the subsequent free_irq() will complete as intended
+ * 2. desc->action is cleared before the timer runs. In this case synchronize_irq()
+ *    will block until the timer expires (remember moderation delays are very short,
+ *    comparable to C-state exit times), __enable_irq() will not be run,
+ *    and free_irq() will complete successfully.
+ *
+ * INTERRUPT MIGRATION
+ * is protected by IRQD_IRQ_INPROGRESS that prevents running the handler on the
+ * new CPU while an interrupt is moderated.
+ *
+ * HOTPLUG
+ * During CPU shutdown, the kernel moves timers and reassigns interrupt affinity
+ * to a new CPU. The easiest way and most robust way to guarantee that pending
+ * events are handled correctly is to use a per-CPU "moderation_allowed" flag
+ * and hotplug callbacks on CPUHP_AP_ONLINE_DYN:
+ * - on setup, set the flag. That will allow interrupts to be moderated.
+ * - on shutdown, with interrupts disabled, 1. clear the flag thus preventing
+ *   more interrupts to be moderated on that CPU, 2. flush the list of moderated
+ *   interrupts (as if the timer had fired), and 3. cancel the timer.
+ * This avoids depending with the internals of the up/down sequence.
+ *
+ * SUSPEND
+ * Register a PM notifier to handle PM_SUSPEND_PREPARE and PM_POST_RESTORE as
+ * hotplug shutdown and setup events. The hotplug callbacks are also invoked
+ * during suspend to/resume from disk.
+ *
+ * BOOT PROCESSOR
+ * Hotplug callbacks are not invoked for the boot processor.
+ * However the boot processor is the last one to go, and since there is
+ * no other place to run the timer callbacks, they will be run where they
+ * are supposed to.
+ */
+
+/* Recommended values. */
+struct irq_mod_info irq_mod_info ____cacheline_aligned = {
+	.update_ms		= 5,
+};
+
+DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
+
+static void update_enable_key(void)
+{
+	if (irq_mod_info.delay_us != 0)
+		static_branch_enable(&irq_moderation_enabled_key);
+	else
+		static_branch_disable(&irq_moderation_enabled_key);
+}
+
+/* Actually start moderation. */
+bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (!hrtimer_is_queued(&m->timer)) {
+		const u32 min_delay_ns = 10000;
+		const u64 slack_ns = 2000;
+
+		/* Accumulate sleep time, no moderation if too small. */
+		m->sleep_ns += m->mod_ns;
+		if (m->sleep_ns < min_delay_ns)
+			return false;
+		/* We need moderation, start the timer. */
+		m->timer_set++;
+		hrtimer_start_range_ns(&m->timer, ns_to_ktime(m->sleep_ns),
+				       slack_ns, HRTIMER_MODE_REL_PINNED_HARD);
+	}
+
+	/*
+	 * Add to the timer list and __disable_irq() to prevent serving subsequent
+	 * interrupts.
+	 */
+	if (!list_empty(&desc->mod_state.ms_node)) {
+		/* Very unlikely, stray interrupt while moderated. */
+		m->stray_irq++;
+	} else {
+		m->enqueue++;
+		list_add(&desc->mod_state.ms_node, &m->descs);
+		__disable_irq(desc);
+	}
+	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_IRQ_MODERATED);
+	return true;
+}
+
+/* Initialize moderation state, used in desc_set_defaults() */
+void irq_moderation_init_fields(struct irq_desc_mod *mod_state)
+{
+	INIT_LIST_HEAD(&mod_state->ms_node);
+}
+
+static int set_mode(struct irq_desc *desc, bool enable)
+{
+	struct irq_data *irqd = &desc->irq_data;
+	struct irq_chip *chip = irqd->chip;
+
+	lockdep_assert_held(&desc->lock);
+
+	if (!enable) {
+		irq_settings_clr_and_set(desc, _IRQ_SW_MODERATION, 0);
+		return 0;
+	}
+
+	/* Moderation is only supported in specific cases. */
+	enable &= !irqd_is_level_type(irqd);
+	enable &= irqd_is_single_target(irqd);
+	enable &= !chip->irq_bus_lock && !chip->irq_bus_sync_unlock;
+	enable &= chip->irq_mask && chip->irq_unmask;
+	enable &= desc->handle_irq == handle_edge_irq || desc->handle_irq == handle_fasteoi_irq;
+	if (!enable)
+		return -EOPNOTSUPP;
+
+	irq_settings_clr_and_set(desc, 0, _IRQ_SW_MODERATION);
+	return 0;
+}
+
+/* Helpers to set and clamp values from procfs or at init. */
+struct swmod_param {
+	const char	*name;
+	int		(*wr)(struct swmod_param *n, const char __user *s, size_t count);
+	void		(*rd)(struct seq_file *p);
+	void		*val;
+	u32		min;
+	u32		max;
+};
+
+static int swmod_wr_u32(struct swmod_param *n, const char __user *s, size_t count)
+{
+	u32 res;
+	int ret = kstrtouint_from_user(s, count, 0, &res);
+
+	if (!ret) {
+		WRITE_ONCE(*(u32 *)(n->val), clamp(res, n->min, n->max));
+		ret = count;
+	}
+	return ret;
+}
+
+static void swmod_rd_u32(struct seq_file *p)
+{
+	struct swmod_param *n = p->private;
+
+	seq_printf(p, "%u\n", *(u32 *)(n->val));
+}
+
+static int swmod_wr_delay(struct swmod_param *n, const char __user *s, size_t count)
+{
+	int ret = swmod_wr_u32(n, s, count);
+
+	if (ret >= 0)
+		update_enable_key();
+	return ret;
+}
+
+#define HEAD_FMT "%5s  %8s  %11s  %11s  %9s\n"
+#define BODY_FMT "%5u  %8u  %11u  %11u  %9u\n"
+
+#pragma clang diagnostic error "-Wformat"
+
+/* Print statistics */
+static void rd_stats(struct seq_file *p)
+{
+	uint delay_us = irq_mod_info.delay_us;
+	int cpu;
+
+	seq_printf(p, HEAD_FMT,
+		   "# CPU", "delay_ns", "timer_set", "enqueue", "stray_irq");
+
+	for_each_possible_cpu(cpu) {
+		struct irq_mod_state cur;
+
+		/* Copy statistics, will only use some 32bit values, races ok. */
+		data_race(cur = *per_cpu_ptr(&irq_mod_state, cpu));
+		seq_printf(p, BODY_FMT,
+			   cpu, cur.mod_ns, cur.timer_set, cur.enqueue, cur.stray_irq);
+	}
+
+	seq_printf(p, "\n"
+		   "enabled              %s\n"
+		   "delay_us             %u\n",
+		   str_yes_no(delay_us > 0),
+		   delay_us);
+}
+
+static int moderation_show(struct seq_file *p, void *v)
+{
+	struct swmod_param *n = p->private;
+
+	if (!n || !n->rd)
+		return -EINVAL;
+	n->rd(p);
+	return 0;
+}
+
+static int moderation_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, moderation_show, pde_data(inode));
+}
+
+static struct swmod_param param_names[] = {
+	{ "delay_us", swmod_wr_delay, swmod_rd_u32, &irq_mod_info.delay_us, 0, 500 },
+	{ "stats", NULL, rd_stats},
+};
+
+static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct swmod_param *n = (struct swmod_param *)pde_data(file_inode(f));
+
+	return n && n->wr ? n->wr(n, buf, count) : -EINVAL;
+}
+
+static const struct proc_ops proc_ops = {
+	.proc_open	= moderation_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+	.proc_write	= moderation_write,
+};
+
+/* Handlers for /proc/irq/NN/soft_moderation */
+static int mode_show(struct seq_file *p, void *v)
+{
+	struct irq_desc *desc = p->private;
+
+	seq_puts(p, irq_settings_moderation_allowed(desc) ? "on\n" : "off\n");
+	return 0;
+}
+
+static ssize_t mode_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct irq_desc *desc = (struct irq_desc *)pde_data(file_inode(f));
+	bool enable;
+	int ret = kstrtobool_from_user(buf, count, &enable);
+
+	if (!ret) {
+		guard(raw_spinlock_irqsave)(&desc->lock);
+		ret = set_mode(desc, enable);
+	}
+	return ret ? : count;
+}
+
+static int mode_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mode_show, pde_data(inode));
+}
+
+static const struct proc_ops mode_ops = {
+	.proc_open	= mode_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+	.proc_write	= mode_write,
+};
+
+void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode)
+{
+	proc_create_data("soft_moderation", umode, desc->dir, &mode_ops, desc);
+}
+
+void irq_moderation_procfs_remove(struct irq_desc *desc)
+{
+	remove_proc_entry("soft_moderation", desc->dir);
+}
+
+/* Used on timer expiration or CPU shutdown. */
+static void drain_desc_list(struct irq_mod_state *m)
+{
+	struct irq_desc *desc, *next;
+
+	/* Remove from list and enable interrupts back. */
+	list_for_each_entry_safe(desc, next, &m->descs, mod_state.ms_node) {
+		guard(raw_spinlock)(&desc->lock);
+		list_del_init(&desc->mod_state.ms_node);
+		irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_IRQ_MODERATED);
+		/* Protect against competing free_irq(). */
+		if (desc->action)
+			__enable_irq(desc);
+	}
+}
+
+static enum hrtimer_restart timer_callback(struct hrtimer *timer)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	lockdep_assert_irqs_disabled();
+
+	drain_desc_list(m);
+	/* Prepare to accumulate next moderation delay. */
+	m->sleep_ns = 0;
+	return HRTIMER_NORESTART;
+}
+
+/* Hotplug callback for setup. */
+static int cpu_setup_cb(uint cpu)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	hrtimer_setup(&m->timer, timer_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+	INIT_LIST_HEAD(&m->descs);
+	m->moderation_allowed = true;
+	return 0;
+}
+
+/*
+ * Hotplug callback for shutdown.
+ * Mark the CPU as offline for moderation, and drain the list of masked
+ * interrupts. Any subsequent interrupt on this CPU will not be
+ * moderated, but they will be on the new target.
+ */
+static int cpu_remove_cb(uint cpu)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	guard(irqsave)();
+	m->moderation_allowed = false;
+	drain_desc_list(m);
+	hrtimer_cancel(&m->timer);
+	return 0;
+}
+
+static void(mod_pm_prepare_cb)(void *arg)
+{
+	cpu_remove_cb(smp_processor_id());
+}
+
+static void(mod_pm_resume_cb)(void *arg)
+{
+	cpu_setup_cb(smp_processor_id());
+}
+
+static int mod_pm_notifier_cb(struct notifier_block *nb, unsigned long event, void *unused)
+{
+	switch (event) {
+	case PM_SUSPEND_PREPARE:
+		on_each_cpu(mod_pm_prepare_cb, NULL, 1);
+		break;
+	case PM_POST_SUSPEND:
+		on_each_cpu(mod_pm_resume_cb, NULL, 1);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+struct notifier_block mod_nb = {
+	.notifier_call	= mod_pm_notifier_cb,
+	.priority	= 100,
+};
+
+static void __init clamp_parameter(u32 *dst, u32 val)
+{
+	struct swmod_param *n = param_names;
+
+	for (int i = 0; i < ARRAY_SIZE(param_names); i++, n++) {
+		if (dst == n->val) {
+			WRITE_ONCE(*dst, clamp(val, n->min, n->max));
+			return;
+		}
+	}
+}
+
+static int __init init_irq_moderation(void)
+{
+	struct proc_dir_entry *dir;
+	struct swmod_param *n;
+	int i;
+
+	/* Clamp all initial values to the allowed range. */
+	for (uint *cur = &irq_mod_info.delay_us; cur < irq_mod_info.params_end; cur++)
+		clamp_parameter(cur, *cur);
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irq_moderation", cpu_setup_cb, cpu_remove_cb);
+	register_pm_notifier(&mod_nb);
+
+	update_enable_key();
+
+	dir = proc_mkdir("irq/soft_moderation", NULL);
+	if (!dir)
+		return 0;
+	for (i = 0, n = param_names; i < ARRAY_SIZE(param_names); i++, n++)
+		proc_create_data(n->name, n->wr ? 0644 : 0444, dir, &proc_ops, n);
+	return 0;
+}
+
+device_initcall(init_irq_moderation);
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
new file mode 100644
index 0000000000000..0d634f8e9225d
--- /dev/null
+++ b/kernel/irq/irq_moderation.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _LINUX_IRQ_MODERATION_H
+#define _LINUX_IRQ_MODERATION_H
+
+#ifdef CONFIG_IRQ_SW_MODERATION
+/* Common data structures for Global Software Interrupt Moderation, GSIM */
+
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kernel.h>
+
+/**
+ * struct irq_mod_info - global configuration parameters and state
+ * @delay_us:		maximum delay
+ * @update_ms:		how often to update delay (epoch duration)
+ */
+struct irq_mod_info {
+	u32		delay_us;
+	u32		update_ms;
+	u32		params_end[];
+};
+
+extern struct irq_mod_info irq_mod_info;
+
+/**
+ * struct irq_mod_state - per-CPU moderation state
+ *
+ * Used on every interrupt:
+ * @timer:		moderation timer
+ * @moderation_allowed:	per-CPU flag, toggled during hotplug/suspend events
+ * @intr_count:		interrupts in the last epoch
+ * @sleep_ns:		accumulated time for actual delay
+ * @mod_ns:		nominal moderation delay, recomputed every epoch
+ *
+ * Used less frequently, every few interrupts:
+ * @epoch_start_ns:	start of current epoch
+ * @update_ns:		update_ms from irq_mod_info, converted to ns
+ * @stray_irq:		how many stray interrupts (almost never used)
+ *
+ * Used once per epoch per interrupt source:
+ * @descs:		list of	moderated irq_desc on this CPU
+ * @enqueue:		how many enqueue on the list
+ *
+ * Statistics
+ * @timer_set:		how many timer_set calls
+ */
+struct irq_mod_state {
+	struct hrtimer		timer;
+	bool			moderation_allowed;
+	u32			intr_count;
+	u32			sleep_ns;
+	u32			mod_ns;
+	atomic64_t		epoch_start_ns;
+	u32			update_ns;
+	u32			stray_irq;
+	struct list_head	descs;
+	u32			enqueue;
+	u32			timer_set;
+};
+
+DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+extern struct static_key_false irq_moderation_enabled_key;
+
+bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m);
+
+static inline void check_epoch(struct irq_mod_state *m)
+{
+	const u64 now = ktime_get_ns(), epoch_ns = now - atomic64_read(&m->epoch_start_ns);
+	const u32 slack_ns = 5000;
+
+	/* Run approximately every update_ns, a little bit early is ok. */
+	if (epoch_ns < m->update_ns - slack_ns)
+		return;
+	/* Fetch updated parameters. */
+	m->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
+	m->mod_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
+}
+
+/*
+ * Use after running the handler, with lock held. If this source should be
+ * moderated, disable it, add to the timer list for this CPU and return true.
+ * The caller must also exit handle_*_irq() without processing IRQS_PENDING,
+ * as that will happen when the moderation timer fires and calls __enable_irq().
+ */
+static inline bool irq_start_moderation(struct irq_desc *desc)
+{
+	struct irq_mod_state *m = this_cpu_ptr(&irq_mod_state);
+
+	if (!static_branch_unlikely(&irq_moderation_enabled_key))
+		return false;
+	if (!irq_settings_moderation_allowed(desc))
+		return false;
+	if (!m->moderation_allowed)
+		return false;
+
+	m->intr_count++;
+
+	/* Is this a new epoch? ktime_get_ns() is expensive, don't check too often. */
+	if ((m->intr_count & 0xf) == 0)
+		check_epoch(m);
+
+	return irq_moderation_do_start(desc, m);
+}
+#else /* CONFIG_IRQ_SW_MODERATION */
+static inline bool irq_start_moderation(struct irq_desc *desc) { return false; }
+#endif /* !CONFIG_IRQ_SW_MODERATION */
+
+#endif /* _LINUX_IRQ_MODERATION_H */
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f8e4e13dbe339..5b6a69ee82b8f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -134,6 +134,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
+	irq_moderation_init_fields(&desc->mod_state);
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 77258eafbf632..5ce64654da097 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -376,6 +376,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 	proc_create_single_data("effective_affinity_list", 0444, desc->dir,
 				irq_effective_aff_list_proc_show, irqp);
 # endif
+	irq_moderation_procfs_add(desc, 0644);
 #endif
 	proc_create_single_data("spurious", 0444, desc->dir,
 				irq_spurious_proc_show, (void *)(long)irq);
@@ -397,6 +398,7 @@ void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 	remove_proc_entry("effective_affinity", desc->dir);
 	remove_proc_entry("effective_affinity_list", desc->dir);
 # endif
+	irq_moderation_procfs_remove(desc);
 #endif
 	remove_proc_entry("spurious", desc->dir);
 
-- 
2.52.0.457.g6b5491de43-goog


