Return-Path: <linux-arch+bounces-14805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DFC61AA5
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67ADF4E3906
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486C310636;
	Sun, 16 Nov 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9KYMWlu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156D30FF27
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317747; cv=none; b=W0KkxhM/aav+df3Yr8VWw2mH/IUKyFpPxQdiof+LtNN52X7+p65TSpXQjMjpgpRMJp5d84OrDnzoitEjrt00PaeI5xN0VcV4KNDdR3rq2sMwMniTbq6B9S0gAScMIOJx2NK6RHg7H2HBaLDnYT+eY+Y5xIg8Zyc94JV0Fa7UCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317747; c=relaxed/simple;
	bh=i2736iKp7h+PPdFM12cdP+3/YcBrTsf4ynOBdtpsy58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uw0r+9tw+As4qzHHzpJMMEwDILDKDV8kS9F1JtB4Mn2vdjvUQ3B6JnaoyZj8cdJKwYhfZBqw08aZKoHBhoHP3wvuf0bbVgU32siCZyrDEg7fDrAFP/8QCGL2ZhqmDITk6Zh7rNQlXbiJvejOEaZfg+smIe4xgwsfY48+DRYGYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9KYMWlu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477a027877eso5702525e9.2
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317743; x=1763922543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RR/NDNEDPm+9CFs5KbwjfzNvsCGF1IaHdbLrz2LpHYU=;
        b=O9KYMWlud0zTiUoauy/xnRvw7SV3pUfBXfK+/mlXMsnSiN/HJQpZ+B+ZksxfQMLS7v
         SGh+jeFlPRIOoC2Z2yAL+8470pV4cgmS3XuFbuU6kPToL8kA285YxRys79PdAJ2jSln1
         PTxxrQJyuAHSlgnt657cOy4bHICFsRuyOvGsIn6sGNiIfJLxZn0iHXVJChJHoZoMhMWm
         3XHuT3VQxx/E+r8g6EJu6q4oxBQDTuKPfEZRA32f5ns8WAC9yVKXVtxj7xvfwXjp+G10
         hUSfLAW55g3W/LeORoKu+2O6f6omjqWmLh+BX63keUH5RErIebWtIE8Dil0SifqOHK0r
         wUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317743; x=1763922543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RR/NDNEDPm+9CFs5KbwjfzNvsCGF1IaHdbLrz2LpHYU=;
        b=D+ruQ0Rje93dNMtetBRzbHZlslQVV049PZUnU2jXmWZbiAHtUXJN93xQHGVTxavm6a
         g4INHPFVx4h/EnFIFB91B8TxV79CljGSfAK3MdjnPKQgHBF5INPovuGbBYsR4R/FFjQB
         NKCXoX8rMOzXO8H9tn9BxuCAtUn9aKMX3F5Vcn+lYXk0XyVRBnNkjQtYrtTIrC490DKI
         UnwAqQOiBXm+7K7foezB/wUUwfzv1XoTIw5f1/5AO89Nefzu9hb+/hI2sPdEptrSqy9d
         NcvvRGZU207CdpmsSglvyLRSUPDDqNFcJDxrAHn9DWabnPdMf5x8xf6sEpZ2fIDvtb19
         +Wpw==
X-Forwarded-Encrypted: i=1; AJvYcCX5mNohaRGxGuCqUL/9UC1CRjZ4ZtDlvHCZbohNei4/UaSZbF6KGGolPS54u7Gf8OBsQDpanfkODQIo@vger.kernel.org
X-Gm-Message-State: AOJu0YwBow3dIHvTq6kxRU6nauzgHCGr6ntBtY3OaI22xMXymS0QBzxm
	D+Jv/CeFJXuXYeDCSheU24FcjBTnyw59rW53VAD2iatzBV4pvI2hT44u2qoyniRsrlrnWv0H6BG
	fOTrkbg==
X-Google-Smtp-Source: AGHT+IELtsHeFVviwLGVtVs79Fb+Irtxpz+z0fE6KcncX53DlyNJr6no4EwgXdKhNcbA8uQrN2+4/jx6lqc=
X-Received: from wmbbd8.prod.google.com ([2002:a05:600c:1f08:b0:470:fd92:351d])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b19:b0:471:989:9d7b
 with SMTP id 5b1f17b1804b1-4778fe95fe2mr94613165e9.21.1763317743006; Sun, 16
 Nov 2025 10:29:03 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:33 +0000
In-Reply-To: <20251116182839.939139-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-3-lrizzo@google.com>
Subject: [PATCH v2 2/8] genirq: soft_moderation: add base files, procfs
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the core files that implement procfs and module parameters
for soft_moderation. This gives access to the module parameters
/sys/module/irq_moderation/parameters and read/write the procfs entries
/proc/irq/soft_moderation and /proc/irq/NN/soft_moderation.

Examples:
  cat /proc/irq/soft_moderation
  echo "delay_us=345" > /proc/irq/soft_moderation
  echo 1 | tee /proc/irq/*/nvme*/../soft_moderation

No functional change.

Change-Id: I83fc9568e70885cc02e7fcd4dbe141d9ee329c82
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/Makefile         |   1 +
 kernel/irq/irq_moderation.c | 305 ++++++++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation.h | 149 ++++++++++++++++++
 kernel/irq/irqdesc.c        |   1 +
 kernel/irq/proc.c           |   3 +
 5 files changed, 459 insertions(+)
 create mode 100644 kernel/irq/irq_moderation.c
 create mode 100644 kernel/irq/irq_moderation.h

diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 6ab3a40556670..c06da43d644f2 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
 obj-$(CONFIG_IRQ_SIM) += irq_sim.o
+obj-$(CONFIG_IRQ_SOFT_MODERATION) += irq_moderation.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
 obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
new file mode 100644
index 0000000000000..3a907b8f65698
--- /dev/null
+++ b/kernel/irq/irq_moderation.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+
+#include <linux/cpuhotplug.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kernel_stat.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+
+#include "internals.h"
+#include "irq_moderation.h"
+
+/*
+ * Platform-wide software interrupt moderation.
+ *
+ * see Documentation/core-api/irq/irq-moderation.rst
+ *
+ * === MOTIVATION AND OPERATION ===
+ *
+ * Some platforms show reduced I/O performance when the total device interrupt
+ * rate across the entire platform becomes too high. This code implements
+ * per-CPU adaptive moderation based on the total interrupt rate, as opposed
+ * to conventional moderation that operates separately on each source.
+ *
+ * It computes the total interrupt rate and number of sources, and uses the
+ * information to adaptively disable individual interrupts for small amounts
+ * of time using per-CPU hrtimers. Specifically:
+ *
+ * - a hook in handle_irq_event(), which applies only on sources configured
+ *   to use moderation, updates statistics and check whether we need
+ *   moderation on that CPU/irq. If so, calls disable_irq_nosync() and starts
+ *   an hrtimer with appropriate delay.
+ *
+ * - the timer callback calls enable_irq() for all disabled interrupts on that
+ *   CPU. That in turn will generate interrupts if there are pending events.
+ *
+ * === CONFIGURATION ===
+ *
+ * The following can be controlled at boot time via module parameters
+ *
+ *     irq_moderation.${NAME}=${VALUE}
+ *
+ * or at runtime by writing
+ *
+ *     echo "${NAME}=${VALUE}" > /proc/irq/soft_moderation
+ *
+ *   delay_us (default 0, suggested 100, range 0-500, 0 DISABLES MODERATION)
+ *     Fixed or maximum moderation delay.  A reasonable range is 20..100, higher
+ *     values can be useful if the hardirq handler is performing a significant
+ *     amount of work.
+ *
+ *   timer_rounds (default 0, max 20)
+ *     Once moderation triggers, periodically run handler zero or more
+ *     times using a timer rather than interrupts. This is similar to
+ *     napi_defer_hard_irqs on NICs.
+ *     A small value may help control load in interrupt-challenged platforms.
+ *
+ * Moderation can be enabled/disabled for individual interrupts with
+ *
+ *    echo "on" > /proc/irq/NN/soft_moderation # use "off" to disable
+ *
+ * === MONITORING ===
+ *
+ * cat /proc/irq/soft_moderation shows per-CPU and global statistics.
+ *
+ */
+
+struct irq_mod_info irq_mod_info ____cacheline_aligned;
+
+/* Boot time value, copled to irq_mod_info.delay_us after init. */
+static uint mod_delay_us;
+module_param_named(delay_us, mod_delay_us, uint, 0444);
+MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 0-500.");
+
+module_param_named(timer_rounds, irq_mod_info.timer_rounds, uint, 0444);
+MODULE_PARM_DESC(timer_rounds, "How many timer polls once moderation triggers, range 0-20.");
+
+DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+/* Initialize moderation state, used in desc_set_defaults() */
+void irq_moderation_init_fields(struct irq_desc_mod *mod)
+{
+	INIT_LIST_HEAD(&mod->ms_node);
+	mod->enable = false;
+}
+
+static inline int set_moderation_mode(struct irq_desc *desc, bool enable)
+{
+	struct irq_data *irqd = &desc->irq_data;
+	struct irq_chip *chip = desc->irq_data.chip;
+
+	/* Moderation is supported only in specific cases. */
+	if (enable) {
+		if (irqd_is_level_type(irqd) || !irqd_is_single_target(irqd) ||
+		    chip->irq_bus_lock || chip->irq_bus_sync_unlock)
+			return -EOPNOTSUPP;
+	}
+	desc->mod.enable = enable;
+	return 0;
+}
+
+#pragma clang diagnostic error "-Wformat"
+/* Print statistics */
+static int moderation_show(struct seq_file *p, void *v)
+{
+	uint delay_us = irq_mod_info.delay_us;
+	int j;
+
+#define HEAD_FMT "%5s  %8s  %8s  %4s  %4s  %8s  %11s  %11s  %11s  %11s  %11s  %11s  %11s  %9s\n"
+#define BODY_FMT "%5u  %8u  %8u  %4u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %11u  %11u  %9u\n"
+
+	seq_printf(p, HEAD_FMT,
+		   "# CPU", "irq/s", "my_irq/s", "cpus", "srcs", "delay_ns",
+		   "irq_hi", "my_irq_hi", "hardirq_hi", "timer_set",
+		   "disable_irq", "from_msi", "timer_calls", "stray_irq");
+
+	for_each_possible_cpu(j) {
+		struct irq_mod_state *ms = per_cpu_ptr(&irq_mod_state, j);
+
+		seq_printf(p, BODY_FMT,
+			   j, ms->irq_rate, ms->my_irq_rate,
+			   (ms->scaled_cpu_count + 128) / 256,
+			   (ms->scaled_src_count + 128) / 256,
+			   ms->mod_ns, ms->irq_high, ms->my_irq_high,
+			   ms->hardirq_high, ms->timer_set, ms->disable_irq,
+			   ms->from_posted_msi, ms->timer_calls, ms->stray_irq);
+	}
+
+	seq_printf(p, "\n"
+		   "enabled              %s\n"
+		   "delay_us             %u\n"
+		   "timer_rounds         %u\n",
+		   str_yes_no(delay_us > 0),
+		   delay_us, irq_mod_info.timer_rounds);
+
+	return 0;
+}
+
+static int moderation_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, moderation_show, pde_data(inode));
+}
+
+/* Helpers to set and clamp values from procfs or at init. */
+struct param_names {
+	const char *name;
+	uint *val;
+	uint min;
+	uint max;
+};
+
+static struct param_names param_names[] = {
+	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
+	{ "timer_rounds", &irq_mod_info.timer_rounds, 0, 20 },
+	/* Empty entry indicates the following are not settable from procfs. */
+	{},
+	{ "update_ms", &irq_mod_info.update_ms, 1, 100 },
+};
+
+static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct param_names *n = param_names;
+	char cmd[40];
+	uint i, l, val;
+
+	if (count == 0 || count + 1 > sizeof(cmd))
+		return -EINVAL;
+	if (copy_from_user(cmd, buf, count))
+		return -EFAULT;
+	cmd[count] = '\0';
+	for (i = 0;  i < ARRAY_SIZE(param_names) && n->name; i++, n++) {
+		l = strlen(n->name);
+		if (count < l + 2 || strncmp(cmd, n->name, l) || cmd[l] != '=')
+			continue;
+		if (kstrtouint(cmd + l + 1, 0, &val))
+			return -EINVAL;
+		WRITE_ONCE(*(n->val), clamp(val, n->min, n->max));
+		/* Record last parameter change, for use in the control loop. */
+		irq_mod_info.procfs_write_ns = ktime_get_ns();
+		return count;
+	}
+	return -EINVAL;
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
+	if (!desc)
+		return -ENOENT;
+
+	seq_printf(p, "%s irq %u trigger 0x%x %s %smanaged %slazy handle_irq %pB\n",
+		   desc->mod.enable ? "on" : "off", desc->irq_data.irq,
+		   irqd_get_trigger_type(&desc->irq_data),
+		   irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge",
+		   irqd_affinity_is_managed(&desc->irq_data) ? "" : "un",
+		   irq_settings_disable_unlazy(desc) ? "un" : "", desc->handle_irq
+		   );
+	return 0;
+}
+
+static ssize_t mode_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct irq_desc *desc = (struct irq_desc *)pde_data(file_inode(f));
+	char cmd[40];
+	bool enable;
+	int ret;
+
+	if (!desc)
+		return -ENOENT;
+	if (count == 0 || count + 1 > sizeof(cmd))
+		return -EINVAL;
+	if (copy_from_user(cmd, buf, count))
+		return -EFAULT;
+	cmd[count] = '\0';
+
+	ret = kstrtobool(cmd, &enable);
+	if (!ret)
+		ret = set_moderation_mode(desc, enable);
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
+/* Per-CPU state initialization */
+static void irq_moderation_percpu_init(void *data)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	INIT_LIST_HEAD(&ms->descs);
+}
+
+static int cpuhp_setup_cb(uint cpu)
+{
+	irq_moderation_percpu_init(NULL);
+	return 0;
+}
+
+static void clamp_parameter(uint *dst, uint val)
+{
+	struct param_names *n = param_names;
+	uint i;
+
+	for (i = 0; i < ARRAY_SIZE(param_names); i++, n++) {
+		if (dst == n->val) {
+			*dst = clamp(val, n->min, n->max);
+			return;
+		}
+	}
+}
+
+static int __init init_irq_moderation(void)
+{
+	uint *cur;
+
+	on_each_cpu(irq_moderation_percpu_init, NULL, 1);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "moderation:online", cpuhp_setup_cb, NULL);
+
+	/* Clamp all initial values to the allowed range. */
+	for (cur = &irq_mod_info.target_irq_rate; cur < irq_mod_info.pad; cur++)
+		clamp_parameter(cur, *cur);
+
+	/* Finally, set delay_us to enable moderation if needed. */
+	clamp_parameter(&irq_mod_info.delay_us, mod_delay_us);
+
+	proc_create_data("irq/soft_moderation", 0644, NULL, &proc_ops, NULL);
+	return 0;
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("1.0");
+MODULE_AUTHOR("Luigi Rizzo <lrizzo@google.com>");
+MODULE_DESCRIPTION("Platform wide software interrupt moderation");
+module_init(init_irq_moderation);
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
new file mode 100644
index 0000000000000..ccb8193482b51
--- /dev/null
+++ b/kernel/irq/irq_moderation.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _LINUX_IRQ_MODERATION_H
+#define _LINUX_IRQ_MODERATION_H
+
+/*
+ * Platform wide software interrupt moderation, see
+ * Documentation/core-api/irq/irq-moderation.rst
+ */
+
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kernel.h>
+
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+
+/**
+ * struct irq_mod_info - global configuration parameters and state
+ * @total_intrs:	running count updated every update_ms
+ * @total_cpus:		as above, active CPUs in this interval
+ * @procfs_write_ns:	last write to /proc/irq/soft_moderation
+ * @delay_us:		fixed delay, or maximum for adaptive
+ * @target_irq_rate:	target maximum interrupt rate
+ * @hardirq_percent:	target maximum hardirq percentage
+ * @timer_rounds:	how many timer polls once moderation fires
+ * @update_ms:		how often to update delay/rate/fraction
+ * @scale_cpus:		(percent) scale factor to estimate active CPUs
+ * @count_timer_calls:	count timer calls for irq limits
+ * @count_msi_calls:	count calls from posted_msi for irq limits
+ * @decay_factor:	smoothing factor for the control loop, keep at 16
+ * @grow_factor:	smoothing factor for the control loop, keep it at 8
+ */
+struct irq_mod_info {
+	/* These fields are written to by all CPUs */
+	____cacheline_aligned
+	atomic_long_t total_intrs;
+	atomic_long_t total_cpus;
+
+	/* These are mostly read (frequently), so use a different cacheline */
+	____cacheline_aligned
+	u64 procfs_write_ns;
+	uint delay_us;
+	uint target_irq_rate;
+	uint hardirq_percent;
+	uint timer_rounds;
+	uint update_ms;
+	uint scale_cpus;
+	uint count_timer_calls;
+	uint count_msi_calls;
+	uint decay_factor;
+	uint grow_factor;
+	uint pad[];
+};
+
+extern struct irq_mod_info irq_mod_info;
+
+/**
+ * struct irq_mod_state - per-CPU moderation state
+ *
+ * @timer:		moderation timer
+ * @descs:		list of	moderated irq_desc on this CPU
+ *
+ * Counters on last time we updated moderation delay
+ * @last_ns:		time of last update
+ * @last_irqtime:	from cpustat[CPUTIME_IRQ]
+ * @last_total_irqs:	from irq_mod_info
+ * @last_total_cpus:	from irq_mod_info
+ *
+ * Local info to control hooks and timer callbacks
+ * @dont_count:		do not count this interrupt
+ * @in_posted_msi:	don't suppress handle_irq, set in posted_msi handler
+ * @kick_posted_msi:	kick posted_msi from the timer callback
+ * @rounds_left:	how many rounds left for timer callbacks
+ *
+ * @irq_count:		irqs in the last cycle, signed as we also decrement
+ * @update_ns:		fetched from irq_mod_info
+ * @delay_ns:		fetched from irq_mod_info
+ * @mod_ns:		current moderation delay, recomputed every update_ms
+ * @sleep_ns:		accumulated time for actual delay
+ *
+ * Statistics
+ * @irq_rate:		smoothed global irq rate
+ * @my_irq_rate:	smoothed irq rate for this CPU
+ * @scaled_cpu_count:	smoothed CPU count (scaled)
+ * @scaled_src_count:	smoothed count of irq sources (scaled)
+ * @irq_high:		how many times global irq above threshold
+ * @my_irq_high:	how many times local irq above threshold
+ * @hardirq_high:	how many times local hardirq_percent above threshold
+ * @timer_set:		how many timer_set calls
+ * @timer_fire:		how many timer_fire, must match timer_set in timer callback
+ * @disable_irq:	how many disable_irq calls
+ * @enable_irq:		how many enable_irq, must match disable_irq in timer callback
+ * @timer_calls:	how many handler calls from timer interrupt
+ * @from_posted_msi:	how many calls from posted_msi handler
+ * @stray_irq:		how many stray interrupts
+ */
+struct irq_mod_state {
+	struct hrtimer timer;
+	struct list_head descs;
+
+	/* Counters on last time we updated moderation delay */
+	u64 last_ns;
+	u64 last_irqtime;
+	u64 last_total_irqs;
+	u64 last_total_cpus;
+
+	bool dont_count;
+	bool in_posted_msi;
+	bool kick_posted_msi;
+	u8 rounds_left;
+
+	u32 irq_count;
+	u32 update_ns;
+	u32 delay_ns;
+	u32 mod_ns;
+	u32 sleep_ns;
+
+	/* Statistics */
+	u32 irq_rate;
+	u32 my_irq_rate;
+	u32 scaled_cpu_count;
+	u32 scaled_src_count;
+	u32 irq_high;
+	u32 my_irq_high;
+	u32 hardirq_high;
+	u32 timer_set;
+	u32 timer_fire;
+	u32 disable_irq;
+	u32 enable_irq;
+	u32 timer_calls;
+	u32 from_posted_msi;
+	u32 stray_irq;
+	int pad[] ____cacheline_aligned;
+};
+
+DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode);
+void irq_moderation_procfs_remove(struct irq_desc *desc);
+
+#else /* CONFIG_IRQ_SOFT_MODERATION */
+
+static inline void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode) {}
+static inline void irq_moderation_procfs_remove(struct irq_desc *desc) {}
+
+#endif /* !CONFIG_IRQ_SOFT_MODERATION */
+
+#endif /* _LINUX_IRQ_MODERATION_H */
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5f..e5cdade3dbbce 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -134,6 +134,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
+	irq_moderation_init_fields(&desc->mod);
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 29c2404e743be..5dcbc36b7de1b 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 
 #include "internals.h"
+#include "irq_moderation.h"
 
 /*
  * Access rules:
@@ -374,6 +375,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 	proc_create_single_data("effective_affinity_list", 0444, desc->dir,
 				irq_effective_aff_list_proc_show, irqp);
 # endif
+	irq_moderation_procfs_add(desc, 0644);
 #endif
 	proc_create_single_data("spurious", 0444, desc->dir,
 				irq_spurious_proc_show, (void *)(long)irq);
@@ -395,6 +397,7 @@ void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 	remove_proc_entry("effective_affinity", desc->dir);
 	remove_proc_entry("effective_affinity_list", desc->dir);
 # endif
+	irq_moderation_procfs_remove(desc);
 #endif
 	remove_proc_entry("spurious", desc->dir);
 
-- 
2.52.0.rc1.455.g30608eb744-goog


