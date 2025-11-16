Return-Path: <linux-arch+bounces-14806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148EAC61AA8
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A153A49B8
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746E310777;
	Sun, 16 Nov 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAjuBZ8X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD143101DF
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317748; cv=none; b=Qa/1yVP8BPXI0T8MBk3YYpl4HNQ38dmIljnW3ExR4tOb2qcV9+INT9Z4ZZiJoh5lgK6HcjWlUdxwss9MoaulhF7XfI7hnmFy5J5VLvY7GlEjdAt1xg9IaX7B/kKLtDzeyINsovO5Moa6d6nYU2nmmyklfDFympXzGdBfXM7LYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317748; c=relaxed/simple;
	bh=PGlVb3/BR+w330owp9L6uZzcuQN62qbEQA1RnRXuHv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kLgzivF+K/KnksZJNf9uXozJlUAyBf9yODQZ6K9cmlTzCPVTDvSISfStMnZsloqqCfRPYVAth+uH9mjYLiMW7SuU0dzvLDwuB91o+aqK+VjW1jnHIYpXRLc84SIEWV7cl18+rFYaFhBNGul7+4NpDYpjShBieeaTzT0knkmxzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aAjuBZ8X; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b71043a0e4fso15479766b.2
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317745; x=1763922545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6sU9KeuFQh6LMrdnRT3ZXnJ1XbCSA0po2mzBh7D/EU=;
        b=aAjuBZ8Xj8QZwXhK7tZtoT4RxTwnxuyfP/9vyqDehnXp2LwcoGGRkcmUAtA4V9GjZB
         2MtyvGbTkbm/PgLnSc2JMPnzeBmO8m5A00lM4SIbJ8Mvk+zJ1vf40Zmv09kf25AXIFoO
         H1/o8GOXupi1cCYSVlKHzHzQ00AwPwlBDW+d+tvAM/reOAZyHk9GEFt/J0lclj4DOWA1
         jPRf24TgAMTRyxvAosMou5GHyM1DUW+PoLBFcsD5Aqmz3FsZVWgRDLSuEIzxVC5w5oUp
         GI0OkPcVNvF/4N0n++GQWElomTEMJfeRN5u7AvCvsD47c1giOIz2WUMWZkkj+zPXVSS8
         i41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317745; x=1763922545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6sU9KeuFQh6LMrdnRT3ZXnJ1XbCSA0po2mzBh7D/EU=;
        b=ljKgREJzqOABFnkrWoPMSVU/Pl4VyOSPWp/GPGP0fW78xwFcydmzB5v6OH3pAX+i1y
         cEWNHzCH6bkkIhZj95Sa4Mkk/b0r1rOtOg+aW1ivhfMGy8bWx/wlrU47n6pBBRcDPDIX
         6r8hxTdexDn7Nx5trgIBRVVYU/k7O/YVmMSrFoQEOWc4KhbN0DDHUIFIywvYvx9SAvzT
         sKlni0CZrcjbLyE5ZnQnkHbF8iNFu9yerUWJLYx4Bm8SchiQeY3nd6nz0Nu5krHy6JIH
         0APO19jo8STKu0DPj1OXoo1ZhltcGBPvHRTdLVjjyNOhtq5afoTm0fNv8Nphlet/nhih
         WUQg==
X-Forwarded-Encrypted: i=1; AJvYcCXiE9Lt5XWVTheaB1GkCyQI9A93fnwV2dHofyqFKucBbF+tuzIRd6NIo8i72VLwH6UX0eW4pmeiLbYj@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjK3JRnaxq3W0lpAnwObluauo3ZW1GCdBtT+71VlzOqe3sw6E
	6Yhdna8/oBI1SZ0QqR8cQjBiFCfNgHRljB5FPQh7eovM5uCOa0gA7DllOlu44C+zzgqiXPNqtLt
	hyaUhtQ==
X-Google-Smtp-Source: AGHT+IG/m7Q2aFX2LOC1aJZXldT76CaZ0dEjD6mFvmn4tCQXC3gPfeIfCn2gfM/3M4zwvTOvBJvklWaamsQ=
X-Received: from ejfx24.prod.google.com ([2002:a17:906:a58:b0:b72:41e4:7560])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3f1c:b0:b73:885b:7551
 with SMTP id a640c23a62f3a-b73885b85bdmr417418566b.6.1763317744742; Sun, 16
 Nov 2025 10:29:04 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:34 +0000
In-Reply-To: <20251116182839.939139-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-4-lrizzo@google.com>
Subject: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add hooks into handle_irq_event() to implement fixed moderation.
Moderation needs to be explicitly enabled on individual IRQs.

When an IRQ with moderation enabled fires, start an hrtimer for
irq_moderation.delay_us. While the timer is active, all IRQs with
moderation enabled will be disabled after running the handler. When the
timer fires, re-enable all disabled IRQs.

Example (kernel built with CONFIG_IRQ_SOFT_MODERATION=y)

  # enable fixed moderation
  echo "delay_us=400" > /proc/irq/soft_moderation

  # enable on network interrupts (change name as appropriate)
  echo on | tee /proc/irq/*/*eth*/../soft_moderation

  # show it works by looking at counters in /proc/irq/soft_moderation
  cat /proc/irq/soft_moderation

  # Show runtime impact on ping times changing delay_us
  ping -n -f -q -c 1000 ${some_nearby_host}
  echo "delay_us=100" > /proc/irq/soft_moderation
  ping -n -f -q -c 1000 ${some_nearby_host}

Configure via module parameters (irq_moderation.${name}=${value}) or
procfs (echo "${name}=${value}" > /proc/irq/soft_moderation):

delay_us   0=off, range 1-500, default 0
    How long an interrupt is disabled after it fires. Small values are
    accumulated until they are large enough, e.g. 10us. As an example,
    delay_us=2 means that the timer is set only every 5 interrupts.

timer_rounds  0-20, default 0
    How many extra timer runs before re-enabling interrupts. This
    reduces interrupts to one every (timer_rounds * delay_us). Similar
    to the "napi_defer_hard_irqs" option in NAPI, but with some subtle
    differences (e.g. here the number of rounds is deterministic, and
    interrupts are disabled at MSI level).

Change-Id: Ic52e95f4128da5e2964afdae0ba3cf9c5c3d732e
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/handle.c         |   3 ++
 kernel/irq/irq_moderation.c |  86 +++++++++++++++++++++++++++++-
 kernel/irq/irq_moderation.h | 102 ++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index e103451243a0b..2f8d828ed143e 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -19,6 +19,7 @@
 #include <trace/events/irq.h>
 
 #include "internals.h"
+#include "irq_moderation.h"
 
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
@@ -254,9 +255,11 @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
 	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	raw_spin_unlock(&desc->lock);
 
+	irq_moderation_hook(desc);
 	ret = handle_irq_event_percpu(desc);
 
 	raw_spin_lock(&desc->lock);
+	irq_moderation_epilogue(desc);
 	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	return ret;
 }
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 3a907b8f65698..688c8e8c49392 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -56,6 +56,10 @@
  *     napi_defer_hard_irqs on NICs.
  *     A small value may help control load in interrupt-challenged platforms.
  *
+ *
+ *   update_ms (default 5, range 1...100)
+ *     How often moderation delay is updated.
+ *
  * Moderation can be enabled/disabled for individual interrupts with
  *
  *    echo "on" > /proc/irq/NN/soft_moderation # use "off" to disable
@@ -66,7 +70,10 @@
  *
  */
 
-struct irq_mod_info irq_mod_info ____cacheline_aligned;
+/* Recommended values for the control loop. */
+struct irq_mod_info irq_mod_info ____cacheline_aligned = {
+	.update_ms		= 5,
+};
 
 /* Boot time value, copled to irq_mod_info.delay_us after init. */
 static uint mod_delay_us;
@@ -76,8 +83,66 @@ MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 0
 module_param_named(timer_rounds, irq_mod_info.timer_rounds, uint, 0444);
 MODULE_PARM_DESC(timer_rounds, "How many timer polls once moderation triggers, range 0-20.");
 
+module_param_named(update_ms, irq_mod_info.update_ms, uint, 0444);
+MODULE_PARM_DESC(update_ms, "Update interval in milliseconds, range 1-100");
+
 DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
+DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
+EXPORT_SYMBOL(irq_moderation_enabled_key);
+
+static inline void smooth_avg(u32 *dst, u32 val, u32 steps)
+{
+	*dst = ((64 - steps) * *dst + steps * val) / 64;
+}
+
+/* Moderation timer handler. */
+static enum hrtimer_restart timer_cb(struct hrtimer *timer)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+	struct irq_desc *desc, *next;
+	uint srcs = 0;
+
+	ms->timer_fire++;
+	WARN_ONCE(ms->timer_set != ms->timer_fire,
+		  "CPU %d timer set %d fire %d (lost events?)\n",
+		  smp_processor_id(), ms->timer_set, ms->timer_fire);
+
+	ms->rounds_left--;
+
+	if (ms->rounds_left > 0) {
+		/* Timer still alive, just call the handlers. */
+		list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
+			ms->irq_count += irq_mod_info.count_timer_calls;
+			ms->timer_calls++;
+			handle_irq_event_percpu(desc);
+		}
+		ms->timer_set++;
+		hrtimer_forward_now(&ms->timer, ms->sleep_ns);
+		return HRTIMER_RESTART;
+	}
+
+	/* Last round, remove from list and enable_irq(). */
+	list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
+		list_del(&desc->mod.ms_node);
+		INIT_LIST_HEAD(&desc->mod.ms_node);
+		srcs++;
+		ms->enable_irq++;
+		enable_irq(desc->irq_data.irq);
+	}
+	smooth_avg(&ms->scaled_src_count, srcs * 256, 1);
+
+	/* Prepare to accumulate next moderation delay. */
+	ms->sleep_ns = 0;
+
+	WARN_ONCE(ms->disable_irq != ms->enable_irq,
+		  "CPU %d irq disable %d enable %d (%s)\n",
+		  smp_processor_id(), ms->disable_irq, ms->enable_irq,
+		  "bookkeeping error, some irq will be stuck");
+
+	return HRTIMER_NORESTART;
+}
+
 /* Initialize moderation state, used in desc_set_defaults() */
 void irq_moderation_init_fields(struct irq_desc_mod *mod)
 {
@@ -153,11 +218,24 @@ struct param_names {
 static struct param_names param_names[] = {
 	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
 	{ "timer_rounds", &irq_mod_info.timer_rounds, 0, 20 },
+	{ "update_ms", &irq_mod_info.update_ms, 1, 100 },
 	/* Empty entry indicates the following are not settable from procfs. */
 	{},
-	{ "update_ms", &irq_mod_info.update_ms, 1, 100 },
+	{ "count_timer_calls", &irq_mod_info.count_timer_calls, 0, 1 },
 };
 
+static void update_enable_key(void)
+{
+	bool newval = irq_mod_info.delay_us != 0;
+
+	if (newval != static_key_enabled(&irq_moderation_enabled_key)) {
+		if (newval)
+			static_branch_enable(&irq_moderation_enabled_key);
+		else
+			static_branch_disable(&irq_moderation_enabled_key);
+	}
+}
+
 static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct param_names *n = param_names;
@@ -176,6 +254,8 @@ static ssize_t moderation_write(struct file *f, const char __user *buf, size_t c
 		if (kstrtouint(cmd + l + 1, 0, &val))
 			return -EINVAL;
 		WRITE_ONCE(*(n->val), clamp(val, n->min, n->max));
+		if (n->val == &irq_mod_info.delay_us)
+			update_enable_key();
 		/* Record last parameter change, for use in the control loop. */
 		irq_mod_info.procfs_write_ns = ktime_get_ns();
 		return count;
@@ -258,6 +338,7 @@ static void irq_moderation_percpu_init(void *data)
 {
 	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
 
+	hrtimer_setup(&ms->timer, timer_cb, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
 	INIT_LIST_HEAD(&ms->descs);
 }
 
@@ -293,6 +374,7 @@ static int __init init_irq_moderation(void)
 
 	/* Finally, set delay_us to enable moderation if needed. */
 	clamp_parameter(&irq_mod_info.delay_us, mod_delay_us);
+	update_enable_key();
 
 	proc_create_data("irq/soft_moderation", 0644, NULL, &proc_ops, NULL);
 	return 0;
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
index ccb8193482b51..d9bc672ffd6f1 100644
--- a/kernel/irq/irq_moderation.h
+++ b/kernel/irq/irq_moderation.h
@@ -136,11 +136,113 @@ struct irq_mod_state {
 
 DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
+extern struct static_key_false irq_moderation_enabled_key;
+
+/* Called on each interrupt for adaptive moderation delay adjustment. */
+static inline void irq_moderation_adjust_delay(struct irq_mod_state *ms)
+{
+	u64 now, delta_time;
+
+	ms->irq_count++;
+	/* ktime_get_ns() is expensive, don't do too often */
+	if (ms->irq_count & 0xf)
+		return;
+	now = ktime_get_ns();
+	delta_time = now - ms->last_ns;
+
+	/* Run approximately every update_ns, a little bit early is ok. */
+	if (delta_time < ms->update_ns - 5000)
+		return;
+
+	ms->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
+	ms->delay_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
+
+	ms->mod_ns = ms->delay_ns;
+}
+
+/* Return true if timer is active or delay is large enough to require moderation */
+static inline bool irq_moderation_needed(struct irq_mod_state *ms)
+{
+	const u32 min_delay_ns = 10000;
+
+	if (!hrtimer_is_queued(&ms->timer)) {
+		/* accumulate sleep time, no moderation if too small */
+		ms->sleep_ns += ms->mod_ns;
+		if (ms->sleep_ns < min_delay_ns)
+			return false;
+	}
+	return true;
+}
+
+void disable_irq_nosync(unsigned int irq);
+
+/*
+ * Use in handle_irq_event() before calling the handler. Decide whether this
+ * desc should be moderated, and in case disable the irq and add the desc to
+ * the list for this CPU.
+ */
+static inline void irq_moderation_hook(struct irq_desc *desc)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (!static_branch_unlikely(&irq_moderation_enabled_key))
+		return;
+
+	if (!READ_ONCE(desc->mod.enable))
+		return;
+
+	irq_moderation_adjust_delay(ms);
+
+	if (!list_empty(&desc->mod.ms_node)) {
+		/*
+		 * Very unlikely, stray interrupt while the desc is moderated.
+		 * We cannot ignore it or we may miss events, but do count it.
+		 */
+		ms->stray_irq++;
+		return;
+	}
+
+	if (!irq_moderation_needed(ms))
+		return;
+
+	/* Add to list of moderated desc on this CPU */
+	list_add(&desc->mod.ms_node, &ms->descs);
+	/*
+	 * Disable the irq. This will also cause irq_can_handle() return false
+	 * (through irq_can_handle_actions()), and that will prevent a handler
+	 * instance to be run again while the descriptor is being moderated.
+	 *
+	 * irq_moderation_epilogue() will then start the timer if needed.
+	 */
+	ms->disable_irq++;
+	disable_irq_nosync(desc->irq_data.irq);
+}
+
+static inline void irq_moderation_start_timer(struct irq_mod_state *ms)
+{
+	ms->timer_set++;
+	ms->rounds_left = READ_ONCE(irq_mod_info.timer_rounds) + 1;
+	hrtimer_start_range_ns(&ms->timer, ns_to_ktime(ms->sleep_ns),
+			       /*range*/2000, HRTIMER_MODE_REL_PINNED_HARD);
+}
+
+/* After the handler, if desc is moderated, make sure the timer is active. */
+static inline void irq_moderation_epilogue(const struct irq_desc *desc)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (!list_empty(&desc->mod.ms_node) && !hrtimer_is_queued(&ms->timer))
+		irq_moderation_start_timer(ms);
+}
+
 void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode);
 void irq_moderation_procfs_remove(struct irq_desc *desc);
 
 #else /* CONFIG_IRQ_SOFT_MODERATION */
 
+static inline void irq_moderation_hook(struct irq_desc *desc) {}
+static inline void irq_moderation_epilogue(const struct irq_desc *desc) {}
+
 static inline void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode) {}
 static inline void irq_moderation_procfs_remove(struct irq_desc *desc) {}
 
-- 
2.52.0.rc1.455.g30608eb744-goog


