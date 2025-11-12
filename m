Return-Path: <linux-arch+bounces-14680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D1C543A3
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 20:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB65422978
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C2351FD3;
	Wed, 12 Nov 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNiGLOrG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680C350A21
	for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975474; cv=none; b=RspmYnRYlSK1r6+qk64nCOKynm24r7eM1i15QTCwoPoFR5U2lwFLmP+byn9zwQ9GkSFXSMCKWAeirpusscewrLrOhuLHaFDXN5y0124O+HdorfctWkiQj0w/fISbVqI22G0XmANli2b1BSHWLGkt7q2vtmywalVgrTmygDddCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975474; c=relaxed/simple;
	bh=97ZKBa3Mxok7Ixq5KQmA3/oV4Kbeh4dCnPI534aVGCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LEy5FI6ZBfT0TX1jRFz8nODRotz1tQbkiaMwM79VB4pPTaAqlVfOUe12gWRKxTsPXbUYi4/cfEAxwmFuOEDSCo3J8iMsns8MYay+mo6g0jYIDgWup2nd0JHmIaqMlp8P4pgMciLOd4jPnmw162o2cqSO8tWZ9GeZTLbbup/4WIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNiGLOrG; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-640b8087663so995a12.3
        for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 11:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975469; x=1763580269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QyPyRpqYf57hBi/oo2GFY86WIPxhm1a6MpX+EQajfk=;
        b=dNiGLOrGPnhTXioWgUTfX1qZwcB/llIBCsA6x0/FZWQx4Zd8rguFW3q3peMHvXZSr6
         f0KqeOlZXjXeMSIysk8lkjB6BFLwZMTjAC/WR/h9hmnxRjyxX4mWGfoFgLvlR3O4hJYE
         D5iSk9HOZO/KzPQ0v3PO3jZF9JgFpXW0xHtInuogIonTtWUtOl9jQSTjvqp76clLYBtz
         1w1Ba3WraeOWGvjeli5HU1+zZcSa7lLrsjSi+Nb0Ww9VbAMWDt7GggZTFqR19n8oBejd
         fs4SWpKyMwZwxHDqqTJYy9fjckHNBTi7rOV0dH2clHtXVmv12FQxqgws2wthmeBK4ENI
         d02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975469; x=1763580269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QyPyRpqYf57hBi/oo2GFY86WIPxhm1a6MpX+EQajfk=;
        b=BS+WrIik5Z3xme8OJEY2coPzQUkJSYdUvt8ZTohUaz/vHzudCO8cf04PamD+ZvHg/J
         eX4FNot7Sd6bpb229Sdp0UPfbu9AnrOdcl0wbez+sIhZ6kfFS1UQcZsVODS3vQgB6J5q
         nVTbAzCnsOXvn45X7YaEQ9wRJjfKBEyr5b/ydKZcBp0E24YYBBu3ZH0GcC6gc80PJTxr
         XTE9m3dtuVN5nbsmiAvporbx0to1Za2lKXs4Kx1Fyug3liPWmpp9dJA77ELCI0EgnEX8
         Avh+h4xWncGObVYakIbyb+dG73oPCzYw8MmFgDljuQm/++k8Yzn0F4kVD4rSPq/ge203
         IG+w==
X-Forwarded-Encrypted: i=1; AJvYcCWCYJQJut52fUA8AyE/B3vzUAYgRmbf/2ca4t/uIVYFitWf440zNAY5dEw6rfrGXOQDq4IZgDc8WOTM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7Ymiuo+qgzgnHqR34h2+BIFR6xlj13vp8nFwAUEqrWgXNoou
	JB5UKuDvo0AZBAfiLgyhsk1cPxarvZJ0wIbFFZ8NopEumzl/VEBASkuJHVJv48KgHJzBYPqiW0Q
	4PyEwmw==
X-Google-Smtp-Source: AGHT+IFy70lDf/WZnWuSVrEkhLrRAG32Pal9GLoXRspx3Ed8ppMs2VQXtd1kFgrTgnPzuZI/FsqN/nSPurw=
X-Received: from edc23.prod.google.com ([2002:a05:6402:4617:b0:640:b66f:1e57])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:26c4:b0:640:b497:bf71
 with SMTP id 4fb4d7f45d1cf-6431a4bf92cmr3903806a12.8.1762975469487; Wed, 12
 Nov 2025 11:24:29 -0800 (PST)
Date: Wed, 12 Nov 2025 19:24:06 +0000
In-Reply-To: <20251112192408.3646835-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112192408.3646835-5-lrizzo@google.com>
Subject: [PATCH 4/6] genirq: soft_moderation: implement adaptive moderation
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two control parameters (target_irq_rate and hardirq_percent)
to indicate the desired maximum values for these two metrics.

Every update_ms the hook in handle_irq_event() recomputes the total and
local interrupt rate and the amount of time spent in hardirq, compares
the values with the targets, and adjusts the moderation delay up or down.

The interrupt rate is computed in a scalable way by counting interrupts
per-CPU, and aggregating the value in a global variable only every
update_ms. Only CPUs that actively process interrupts are actually
accessing the shared variable, so the system scales well even on very
large servers.

EXAMPLE TESTING

Need some workload that can exceed the limits, such as heavy
network or disk traffic. For testing, one can use very low thresholds
(e.g. target_irq_rate=50000, hardirq_frac=10) to make it easier to go
above the limit.

  # configure maximum delay (which is also the fixed moderation delay)
  echo "delay_us=400" > /proc/irq/soft_moderation

  # enable on network interrupts (change name as appropriate)
  echo on | tee /proc/irq/*/*eth*/../soft_moderation

  # ping times should reflect the 400us
  ping -n -f -q -c 1000 ${some_nearby_host}
  # show actual per-cpu delays and statistics
  less /proc/irq/soft_moderation

  # configure adaptive bounds. The control loop will adjust values
  # based on actual load
  echo "target_irq_rate=1000000" > /proc/irq/soft_moderation
  echo "hardirq_percent=70" > /proc/irq/soft_moderation

  # ping times now should be much lower
  ping -n -f -q -c 1000 ${some_nearby_host}

  # show actual per-cpu delays and statistics
  less /proc/irq/soft_moderation

By generating high interrupt or hardirq load, one can also test
the effectiveness of the control scheme and the sensitivity to
control parameters.

NEW PARAMETERS

target_irq_rate   0 off, 0-50000000, default 0
  the total maximum acceptable interrupt rate.

hardirq_percent   0 off,  0-100, default 0
  the maximum acceptable percentage of time spent in hardirq.

update_ms         1-100, default 1
  how often the control loop will readjust the delay.

Change-Id: I3cdc72041be1e3c793013d8804f484cdcbb455ab
---
 include/linux/irq_moderation.h |   9 ++-
 kernel/irq/irq_moderation.c    | 143 ++++++++++++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/include/linux/irq_moderation.h b/include/linux/irq_moderation.h
index 4d90d7c4ca26b..45df60230e42e 100644
--- a/include/linux/irq_moderation.h
+++ b/include/linux/irq_moderation.h
@@ -89,6 +89,8 @@ static inline void irq_moderation_start_timer(struct irq_mod_state *ms)
 			       /*range*/2000, HRTIMER_MODE_REL_PINNED_HARD);
 }
 
+void __irq_moderation_adjust_delay(struct irq_mod_state *ms, u64 delta_time, u64 update_ns);
+
 static inline bool irq_moderation_enabled(void)
 {
 	return READ_ONCE(irq_mod_info.delay_us);
@@ -119,8 +121,13 @@ static inline void irq_moderation_adjust_delay(struct irq_mod_state *ms)
 	/* Fetch important state */
 	ms->delay_ns = clamp(irq_mod_info.delay_us, 1u, 500u) * NSEC_PER_USEC;
 
+	/* If config changed, restart from the highest delay */
+	if (ktime_compare(irq_mod_info.procfs_write_ns, ms->last_ns) > 0)
+		ms->mod_ns = ms->delay_ns;
+
 	ms->last_ns = now;
-	ms->mod_ns = ms->delay_ns;
+	/* Do the expensive processing */
+	__irq_moderation_adjust_delay(ms, delta_time, update_ns);
 }
 
 /* Return true if timer is active or delay is large enough to require moderation */
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index a9d2bdcf4d8c7..0229697a6a95a 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -81,22 +81,127 @@ static_assert(offsetof(struct irq_mod_info, procfs_write_ns) == 64);
 struct irq_mod_info irq_mod_info ____cacheline_aligned = {
 	.delay_us = 100,
 	.update_ms = 1,
+	.scale_cpus = 100,
 	.count_timer_calls = true,
+	.decay_factor = 16,
+	.grow_factor = 8,
 };
 
 module_param_named(delay_us, irq_mod_info.delay_us, uint, 0444);
 MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 10..500.");
 
+module_param_named(hardirq_percent, irq_mod_info.hardirq_percent, uint, 0444);
+MODULE_PARM_DESC(hardirq_percent, "Target max hardirq percentage, 0 off.");
+
+module_param_named(target_irq_rate, irq_mod_info.target_irq_rate, uint, 0444);
+MODULE_PARM_DESC(target_irq_rate, "Target max interrupt rate, 0 off.");
+
 module_param_named(timer_rounds, irq_mod_info.timer_rounds, uint, 0444);
 MODULE_PARM_DESC(timer_rounds, "How many extra timer polls once moderation triggered.");
 
+module_param_named(update_ms, irq_mod_info.update_ms, uint, 0444);
+MODULE_PARM_DESC(update_ms, "Update interval in milliseconds, range 1-100");
+
 DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
+static inline uint get_grow_factor(void) { return clamp(irq_mod_info.grow_factor, 8u, 64u); }
+static inline uint get_decay_factor(void) { return clamp(irq_mod_info.decay_factor, 8u, 64u); }
+static inline uint get_scale_cpus(void) { return clamp(irq_mod_info.scale_cpus, 50u, 1000u); }
+
 static void smooth_avg(u32 *dst, u32 val, u32 steps)
 {
 	*dst = ((64 - steps) * *dst + steps * val) / 64;
 }
 
+/* Adjust the moderation delay, called at most every update_ns */
+void __irq_moderation_adjust_delay(struct irq_mod_state *ms, u64 delta_time, u64 update_ns)
+{
+	/* Fetch configuration */
+	u32 target_rate = clamp(irq_mod_info.target_irq_rate, 0u, 50000000u);
+	u32 hardirq_percent = clamp(irq_mod_info.hardirq_percent, 0u, 100u);
+	bool below_target = true;
+	/* Compute decay steps based on elapsed time */
+	u32 steps = delta_time > 10 * update_ns ? 10 : 1 + (delta_time / update_ns);
+
+	if (target_rate == 0 && hardirq_percent == 0) {	/* use fixed delay */
+		ms->mod_ns = ms->delay_ns;
+		ms->irq_rate = 0;
+		ms->my_irq_rate = 0;
+		ms->cpu_count = 0;
+		return;
+	}
+
+	if (target_rate > 0) {	/* control total and individual CPU rate */
+		u64 irq_rate, my_irq_rate, tmp, delta_irqs, num_cpus;
+		bool my_rate_ok, global_rate_ok;
+
+		/* Update global number of interrupts */
+		if (ms->irq_count < 1)	/* make sure it is always > 0 */
+			ms->irq_count = 1;
+		tmp = atomic_long_add_return(ms->irq_count, &irq_mod_info.total_intrs);
+		delta_irqs = tmp - ms->last_total_irqs;
+
+		/* Compute global rate, check if we are ok */
+		irq_rate = (delta_irqs * NSEC_PER_SEC) / delta_time;
+		global_rate_ok = irq_rate < target_rate;
+
+		ms->last_total_irqs = tmp;
+
+		/*
+		 * num_cpus is the number of CPUs actively handling interrupts
+		 * in the last interval. CPUs handling less than the fair share
+		 * target_rate / num_cpus do not need to be throttled.
+		 */
+		tmp = atomic_long_add_return(1, &irq_mod_info.total_cpus);
+		num_cpus = tmp - ms->last_total_cpus;
+		/* scale proportionally to time, reduce errors if we are idle for too long */
+		num_cpus = 1 + (num_cpus * update_ns + delta_time / 2) / delta_time;
+
+		/* Short intervals may underestimate sources. Apply a scale factor */
+		num_cpus = num_cpus * get_scale_cpus() / 100;
+
+		/* Compute our rate, check if we are ok */
+		my_irq_rate = (ms->irq_count * NSEC_PER_SEC) / delta_time;
+		my_rate_ok = my_irq_rate * num_cpus < target_rate;
+
+		ms->irq_count = 1;	/* reset for next cycle */
+		ms->last_total_cpus = tmp;
+
+		/* Use instantaneous rates to react. */
+		below_target = global_rate_ok || my_rate_ok;
+
+		/* Statistics (rates are smoothed averages) */
+		smooth_avg(&ms->irq_rate, irq_rate, steps);
+		smooth_avg(&ms->my_irq_rate, my_irq_rate, steps);
+		smooth_avg(&ms->cpu_count, num_cpus * 256, steps); /* scaled */
+		ms->my_irq_high += !my_rate_ok;
+		ms->irq_high += !global_rate_ok;
+	}
+
+	if (hardirq_percent > 0) {		/* control time spent in hardirq */
+		u64 cur = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];
+		u64 irqtime = cur - ms->last_irqtime;
+		bool hardirq_ok = irqtime * 100 < delta_time * hardirq_percent;
+
+		below_target &= hardirq_ok;
+		ms->last_irqtime = cur;
+		ms->hardirq_high += !hardirq_ok;	/* statistics */
+	}
+
+	/* Controller: move mod_ns up/down if we are above/below target */
+	if (below_target) {
+		ms->mod_ns -= ms->mod_ns * steps / (steps + get_decay_factor());
+		if (ms->mod_ns < 100)
+			ms->mod_ns = 0;
+	} else if (ms->mod_ns < 500) {
+		ms->mod_ns = 500;
+	} else {
+		ms->mod_ns += ms->mod_ns * steps / (steps + get_grow_factor());
+		if (ms->mod_ns > ms->delay_ns)
+			ms->mod_ns = ms->delay_ns;	/* cap to delay_ns */
+	}
+}
+
 /* moderation timer handler, called in hardintr context */
 static enum hrtimer_restart moderation_timer_cb(struct hrtimer *timer)
 {
@@ -172,6 +277,13 @@ static void set_moderation_mode(struct irq_desc *desc, bool mode)
 	}
 }
 
+/* irq_to_desc is not exported. Wrap it in this function for a specific use. */
+void irq_moderation_set_mode(int irq, bool mode)
+{
+	set_moderation_mode(irq_to_desc(irq), mode);
+}
+EXPORT_SYMBOL(irq_moderation_set_mode);
+
 #pragma clang diagnostic error "-Wformat"
 /* Print statistics */
 static int moderation_show(struct seq_file *p, void *v)
@@ -215,12 +327,32 @@ static int moderation_show(struct seq_file *p, void *v)
 	seq_printf(p, "\n"
 		   "enabled              %s\n"
 		   "delay_us             %u\n"
+		   "target_irq_rate      %u\n"
+		   "hardirq_percent      %u\n"
 		   "timer_rounds         %u\n"
-		   "count_timer_calls    %s\n",
+		   "update_ms            %u\n"
+		   "scale_cpus           %u\n"
+		   "count_timer_calls    %s\n"
+		   "decay_factor         %u\n"
+		   "grow_factor          %u\n",
 		   str_yes_no(delay_us),
-		   delay_us,
-		   irq_mod_info.timer_rounds,
-		   str_yes_no(irq_mod_info.count_timer_calls));
+		   delay_us, irq_mod_info.target_irq_rate, irq_mod_info.hardirq_percent,
+		   irq_mod_info.timer_rounds, irq_mod_info.update_ms,
+		   irq_mod_info.scale_cpus,
+		   str_yes_no(irq_mod_info.count_timer_calls),
+		   get_decay_factor(), get_grow_factor());
+
+	seq_printf(p,
+		   "irq_rate             %lu\n"
+		   "irq_high             %lu\n"
+		   "my_irq_high          %lu\n"
+		   "hardirq_percent_high %lu\n"
+		   "total_interrupts     %lu\n"
+		   "total_cpus           %lu\n",
+		   active_cpus ? irq_rate / active_cpus : 0,
+		   irq_high, my_irq_high, hardirq_high,
+		   READ_ONCE(*((ulong *)&irq_mod_info.total_intrs)),
+		   READ_ONCE(*((ulong *)&irq_mod_info.total_cpus)));
 
 	return 0;
 }
@@ -238,7 +370,10 @@ struct var_names {
 	int max;
 } var_names[] = {
 	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
+	{ "target_irq_rate", &irq_mod_info.target_irq_rate, 0, 50000000 },
+	{ "hardirq_percent", &irq_mod_info.hardirq_percent, 0, 100 },
 	{ "timer_rounds", &irq_mod_info.timer_rounds, 0, 50 },
+	{ "update_ms", &irq_mod_info.update_ms, 1, 100 },
 	{ "count_timer_calls", &irq_mod_info.count_timer_calls, 0, 1 },
 	{}
 };
-- 
2.51.2.1041.gc1ab5b90ca-goog


