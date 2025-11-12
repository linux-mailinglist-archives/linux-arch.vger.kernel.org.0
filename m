Return-Path: <linux-arch+bounces-14677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A9EC542D6
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 20:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFD442183A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC39C34FF6A;
	Wed, 12 Nov 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QT224pSc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEF534DB52
	for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975467; cv=none; b=Gonj9exZtdBIwoFpdFXnUbk3/T3uUl35CaBrp+i+90SWZcdT8Qvu17YL0uSBnhmda1FwHqx5rOYrCX55QbxSBs3I5vOCn8fH3kCbrUcC+OoA4yayzTu8x8XaHrlfFhjO8N6oqEXThBOlAbFoajrhKCkkPct0XMatELl+PFE5Thw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975467; c=relaxed/simple;
	bh=ld2fsmdlt2T8HxwLNOlU6qnNXPyRkodM5rwY68LS6VY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QR8jXFr9pTS66o+A7Ec62owo9cCyIqbKfPcbpBZHpKY7OxsxRwLH/lhbYZJ4MHk1DtK0j+47AgRkY6zemGy4kDPYBmE4V1eDlB5f6HE70T3aJNcST7c7wVfdbhyuFDyiA+XNCjQfW0PS5Biv0tF5yWFMmgdPmYJoMc8ZiPEk01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QT224pSc; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6417a4b67f9so1097a12.3
        for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 11:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975464; x=1763580264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9RboGJiDgx522e/0FZwsBBrKlE2sz8rmng8iRZf/blE=;
        b=QT224pScIFR88bQmg7aQrgi3AlC9h/oTvQdUNyM8rADBrAmBOYnfMlQOleNh4Unzch
         GQTJ0LL6lHjdIcI3NP0BW+zaYDtEfSNOruNTpeoGg4iaffKUNmZUVS5VjAZMAACb77CD
         HvkPbdiLFRdGQfWaHa06WbHIcxeSX3C33j7FRdkp11ETmQgsHAJWfVJM9sb++rD2hE27
         3B2SgAJMXpL6QumY939W9SGtVH+GUcj81fc7s4aqZNmYt5Xhx9Tu9hUWcub1c2GsXI+9
         qJKd26LrLNCo2ZOYcNQgXwYawch0V9TkMiiVsZu/TNAc2e2ECwj4pglFl0yblbrRTtxz
         0AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975464; x=1763580264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RboGJiDgx522e/0FZwsBBrKlE2sz8rmng8iRZf/blE=;
        b=nkTDjBxoidHM2LVPdnUQCR22v1rcGakhlpxAmxFnn5f6geD7ZYlhpertf0axTHV/8L
         ZTx0AL+09Qyx3R/Qs4tgLcdnJ4WRWbmaEJ5O94mavAZMqAyeOZ8zQtMTM/sSAmDk2eO3
         8ECmQsGLBx7suFMsEnlZzPExNai6XkrRMZPX4sm43N7hfeYIs4gyS9dtuZPXuHkvgbuL
         +pBFwMuRkQND1Yi6NVRM53KTbhxNHiUyYqvpUo8bXtKxkJxFrs1isTwVStR3sD2ura7y
         Y5eE3Fim9NBBv5GPx74qTVnNYZ/DtSm4gVK6i0W9JT14Sy1n+SDYaCmoS/f3/kTjcjDq
         d8mw==
X-Forwarded-Encrypted: i=1; AJvYcCX/0A9PrtopSYdFxr4BFAK8X1bCBy1SDnqJInkOxR+qDdcVJFn8jUxIX/BlY79EnXFbiuNZKzuKwCbT@vger.kernel.org
X-Gm-Message-State: AOJu0YzZd0n/oHD9YZiZF6YiNI6SsLRviX/uE90aUnQPDtJzfTLHiiKp
	YRIUoj6qCthO5jCn5j1vhSvBaCEmDMjQ+YZXKruNe+BmiGEWh3VngJuEhnjG64iio1moqj12a9t
	YAa6C6A==
X-Google-Smtp-Source: AGHT+IG1SKOI3GKLgrjPgVXOjy4ln+GVaRLJ1ECeOnc4FwvAXPRn2TxDI3BCwzytmIsWQ8IixfxCReuXBz0=
X-Received: from edo21.prod.google.com ([2002:a05:6402:52d5:b0:641:4eeb:43cd])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:27c8:b0:63c:690d:6a46
 with SMTP id 4fb4d7f45d1cf-6431a4b65d3mr4184716a12.13.1762975463640; Wed, 12
 Nov 2025 11:24:23 -0800 (PST)
Date: Wed, 12 Nov 2025 19:24:03 +0000
In-Reply-To: <20251112192408.3646835-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112192408.3646835-2-lrizzo@google.com>
Subject: [PATCH 1/6] genirq: platform wide interrupt moderation:
 Documentation, Kconfig, irq_desc
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Platform wide software interrupt moderation ("soft_moderation" in this
patch series) specifically addresses a limitation of platforms from many
vendors whose I/O performance drops significantly when the total rate of
MSI-X interrupts is too high (e.g 1-3M intr/s depending on the platform).

Conventional interrupt moderation operates separately on each source,
hence the configuration should target the worst case. On large servers
with hundreds of interrupt sources, keeping the total rate bounded would
require delays of 100-200us; and adaptive moderation would have to reach
those delays with as little as 10K intr/s per source. These values are
unacceptable for RPC or transactional workloads.

To address this problem, this code measures efficiently the total and
per-CPU interrupt rates, so that individual moderation delays can be
adjusted based on actual global and local load. This way, the system
controls both global interrupt rates and individual CPU load, and
tunes delays so they are normally 0 or very small except during actual
local/global overload.

Configuration is easy and robust. System administrators specify the
maximum targets (moderation delay; interrupt rate; and fraction of time
spent in hardirq), and per-CPU control loops adjust actual delays to try
and keep metrics within the bounds.

There is no need for exact targets, because the system is adaptive; the
defaults delay_us=100, target_irq_rate=1000000, hardirq_frac=70 intr/s,
are good almost everywhere.

The system does not rely on any special hardware feature except from
MSI-X Pending Bit Array (PBA), a mandatory component of MSI-X

Boot defaults are set via module parameters (/sys/module/irq_moderation
and /sys/module/${DRIVER}) or at runtime via /proc/irq/moderation, which
is also used to export statistics.  Moderation on individual irq can be
turned on/off via /proc/irq/NN/moderation .

The system does not rely on any special hardware feature except from
MSI-X Pending Bit Array (PBA), a mandatory component of MSI-X

This initial patch adds Documentation, Kconfig option, two fields in
struct irq_desc, and prototypes in include/linux/interrupt.h

No functional impact.

Enabling the option will just extend struct irq_desc with two fields.

CONFIG_SOFT_IRQ_MODERATION=y
---
 Documentation/core-api/irq/index.rst          |   1 +
 Documentation/core-api/irq/irq-moderation.rst | 215 ++++++++++++++++++
 include/linux/interrupt.h                     |  15 ++
 include/linux/irqdesc.h                       |   5 +
 kernel/irq/Kconfig                            |  11 +
 5 files changed, 247 insertions(+)
 create mode 100644 Documentation/core-api/irq/irq-moderation.rst

diff --git a/Documentation/core-api/irq/index.rst b/Documentation/core-api/irq/index.rst
index 0d65d11e54200..b5a6e2ade69bb 100644
--- a/Documentation/core-api/irq/index.rst
+++ b/Documentation/core-api/irq/index.rst
@@ -9,3 +9,4 @@ IRQs
    irq-affinity
    irq-domain
    irqflags-tracing
+   irq-moderation
diff --git a/Documentation/core-api/irq/irq-moderation.rst b/Documentation/core-api/irq/irq-moderation.rst
new file mode 100644
index 0000000000000..ff12dbabc701b
--- /dev/null
+++ b/Documentation/core-api/irq/irq-moderation.rst
@@ -0,0 +1,215 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+===========================================
+Platform wide software interrupt moderation
+===========================================
+
+:Author: Luigi Rizzo <lrizzo@google.com>
+
+.. contents:: :depth: 2
+
+Introduction
+------------
+
+Platform Wide software interrupt moderation is a variant of moderation
+that adjusts the delay based on platform-wide metrics, instead of
+considering each source separately.  It then uses hrtimers to implement
+adaptive, per-CPU moderation in software, without requiring any specific
+hardware support other than Pending Bit Array, a standard feature
+of MSI-X.
+
+To understand the motivation for this feature, we start with some
+background on interrupt moderation.
+
+* **Interrupt** is a mechanism to **notify** the CPU of **events**
+  that should be handled by software, for example, **completions**
+  of I/O requests (network tx/rx, disk read/writes...).
+
+* Each event typically issues one interrupt, which is then processed by
+  software before the next interrupt can be issued.  If more events fire
+  in the meantime, the next interrupt notifies all of them. This is called
+  **coalescing**, and it can happen unintentionally, as in the example.
+
+* Coalescing amortizes the fixed costs of processing one interrupt over
+  multiple events, so it improves efficiency. This suggested the idea
+  that we could intentionally make coalescing more likely. This is called
+  interrupt **moderation**.
+
+* The most common and robust implementation of moderation enforces
+  some minimum **delay** between subsequent interrupts, using a timer
+  in the device or in software. Most NICs support programmable hardware
+  moderation, with timer granularity down to 1us or so.  NVME also
+  specifies hardware moderation timers, with 100us granularity.
+
+* One downside of moderation, especially with **fixed** delay, is that
+  even with moderate load, the notification latency can increase by as
+  much as the moderation delay. This is undesirable for transactional
+  workloads. At high load the extra delay is less problematic, because
+  the queueing delays that occur can be one or more orders of magnitude
+  bigger.
+
+* To address this problem, software can dynamically adjust the delay, making
+  it proportional to the I/O rate. This is called **adaptive** moderation,
+  and it is commonly implemented in network device drivers.
+
+In summary, interrupt moderation, as normally implemented, is a very
+effective way to reduce interrupt processing costs on a per-source
+basis. The modest compromise on the extra latency can be removed with
+adaptive moderation.
+
+MOTIVATION
+~~~~~~~~~~
+
+There is one aspect that per-source moderation does not address.
+
+Several Systems-on-Chip (SoC) from all vendors (Intel, AMD, ARM), show
+huge reduction in I/O throughput (up to 3-4x times slower for high speed
+NICs or SSDs) in presence of high MSI-X interrupt rates across the entire
+platform (1-3M intr/s total, depending on the SoC). Note that unaffected
+SoCs can sustain 20-30M intr/s from MSI-X without performance degradation.
+
+The above performance degradation is not caused by overload of individual
+CPUs. What matters is the total MSI-X interrupt rate, across either
+individual PCIe root port, or the entire SoC. The specific root cause
+depends on the SoC, but generally some internal block (in the PCIe root
+port, or in the IOMMU block) applies excessive serialization around
+MSI-X writes. This in turn causes huge delays in other PCIe transactions,
+leading to the observed performance drop.
+
+EXISTING MITIGATIONS AND WHY THEY ARE INSUFFICIENT:
+===================================================
+
+* As mentioned, traditional interrupt moderation operates on individual sources.
+  Large server platforms can have hundreds of sources (NIC or NVME
+  queues). To stay within the total platform limit (e.g. 1-3M intrs/s)
+  one would need very large delays (100-200us), which are undesirable
+  for transactional workloads (RPC, database).
+
+* Per-source adaptive moderation has the same problem. The adaptive control
+  cannot tell whether other sources are active, so in order to be effective
+  it must assume the worst case and jump to large delays with as little
+  as 10K intrs/s, even if no other sources are active.
+
+* Back in 2020 we addressed this very problem for network devices with
+  the ``napi_defer_hard_irq`` mechanism: after the first interrupt,
+  NAPI does not rearm the queue interrupt, and instead runs the next
+  softirq handler from an hrtimer. It keeps using the timer as interrupt
+  source until one or a few handler calls generate no activity, at which
+  point interrupts are re-enabled.
+
+  That way, under load, device interrupts (which are problematic for
+  the platform) are highly reduced, and replaced with less problematic
+  timer interrupts.  There are a few down sides though:
+
+  * the feature is only available for NAPI devices
+
+  * the timer delay is not adaptive, and must still be tuned based on the number
+    of active sources
+
+  * the system generates extra calls to the NAPI handler
+
+  * it has non-intuitive interaction with devices that share tx/rx interrupts
+    or implement optimizations that expect interrupts to be enabled.
+
+PLATFORM WIDE ADAPTIVE MODERATION
+---------------------------------
+
+Platform-Wide adaptive interrupt moderation is designed to overcome the
+above limitations. The system operates as follows:
+
+* on each interrupt, increments a per-CPU counter for number of interrupts
+
+* opportunistically, every ms or so, each CPU scalably accumulates
+  the values across the entire system, so it can compute the total and
+  per-CPU interrupt rate, and the number of CPUs actively processing
+  interrupts.
+
+* with the above information and a system-wide, configurable
+  ``target_irq_rate``, each CPU computes whether it is processing more
+  or less than its fair share of interrupts. A simple control loop then
+  adjusts up/down its per-CPU moderation delay. The value varies from 0 (disabled)
+  to a configurable upper bound ``delay_us``.
+
+* when the per-CPU moderation delay goes above a threshold (e.g. 10us), the first
+  interrupt served by that CPU will start an hrtimer to fire after the
+  adaptive delay.  All interrupts sources served by that CPU will be
+  disabled as they come.
+
+* when the timer fires, all disabled sources are re-enabled. The Pending
+  Bit Array feature of MSI will avoid that interrupt generated while
+  disabled are lost.
+
+This scheme is effective in keeping the total interrupt rate under
+control as long as the configuration parameters are sensible
+(``delay_us < #CPUs / target_irq_rate``).
+
+It also lends itself to some extensions, specifically:
+
+* **protect against hardirq overload**. It is possible for one CPU
+  handling interrupts to be overwhelmed by hardirq processing. The
+  control loop can be extended to declare an overload situation when the
+  percentage of time spent in hardirq is above a configurable threshold
+  ``hardirq_percent``. Moderation can thus kick in to keep the load within bounds.
+
+* **reduce latency using timer-based polling**. Similar to ``napi_defer_hard_irq``
+  described earlier, once interrupts are disabled and we have an hrtimer active,
+  we keep the timer active for a few rounds and run the handler from a timer callback
+  instead of waiting for an interrupt. The ``timer_rounds`` parameter controls this behavior,
+
+  Say the control loop settles on 120us delay to stay within the global MSI-X rate limit.
+  By setting ``timer_rounds=2``, each time we have a hardware interrupt, the handler
+  will be called two more times by the timer. As a consequence, in the same conditions,
+  the same global MSI-X rate will be reached with just 120/3 = 40us delay, thus improving
+  latency significantly (note that those handlers call do cause extra CPU work, so we
+  may lose some of the efficiency gains coming from large delays).
+
+CONFIGURATION 
+-------------
+
+Configuration of this system is done via module parameters
+``irq_moderation.${name}=${value}`` (for boot-time defaults)
+or writing ``echo "${name}=${value}" > /proc/irq/soft_moderation``
+for run-time configuration.
+
+Here are the existing module parameters
+
+* ``delay_us`` (0: off, range 0-500)
+
+   The maximum moderation delay. 0 means moderation is globally disabled.
+
+* ``target_irq_rate`` (0 off, range 0-50000000)
+
+  The maximum irq rate across the entire platform. The adaptive algorithm will adjust
+  delays to stay within the target. Use 0 to disable this control.
+
+* ``hardirq_percent`` (0 off, range 0-100)
+
+  The maximum percentage of CPU time spent in hardirq. The adaptive algorithm will adjust
+  delays to stay within the target. Use 0 to disable this control.
+
+* ``timer_rounds`` (0 0ff, range 0-20)
+
+  Once the moderation timer is activated, how many extra timer rounds to do before
+  re-enabling interrupts.
+
+* ``update_ms`` (default 1, range 1-100)
+
+  How often the adaptive control should adjust delays. The default value (1ms) should be good
+  in most circumstances.
+
+Interrupt moderation can be enabled/disabled on individual IRQs as follows:
+
+* module parameter ``${driver}.soft_moderation=1`` (default 0) selects
+  whether to use moderation at device probe time.
+
+* ``echo 1 > /proc/irq/*/${irq_name}/../soft_moderation`` (default 0, disabled) toggles
+  moderation on/off for specific IRQs once they are attached.
+
+**INTEL SPECIFIC**
+
+Recent intel CPUs support a kernel feature, enabled via boot parameter ``intremap=posted_msi``,
+that routes all interrupts targeting one CPU via a special interrupt, called **posted_msi**,
+whose handler in turn calls the individual interrupt handlers.
+
+The ``posted_msi`` kernel feature always uses moderation if enabled (``delay_us > 0``) and
+individual IRQs do not need to be enabled individually.
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484c04934..007201c8db6dd 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -872,6 +872,21 @@ extern int early_irq_init(void);
 extern int arch_probe_nr_irqs(void);
 extern int arch_early_irq_init(void);
 
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+
+void irq_moderation_percpu_init(void);
+void irq_moderation_init_fields(struct irq_desc *desc);
+/* add/remove /proc/irq/NN/soft_moderation */
+void irq_moderation_procfs_entry(struct irq_desc *desc, umode_t umode);
+
+#else   /* empty stubs to avoid conditional compilation */
+
+static inline void irq_moderation_percpu_init(void) {}
+static inline void irq_moderation_init_fields(struct irq_desc *desc) {}
+static inline void irq_moderation_procfs_entry(struct irq_desc *desc, umode_t umode) {};
+
+#endif
+
 /*
  * We want to know which function is an entrypoint of a hardirq or a softirq.
  */
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fd091c35d5721..4eb05bc456abe 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -112,6 +112,11 @@ struct irq_desc {
 #endif
 	struct mutex		request_mutex;
 	int			parent_irq;
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+	/* mode: 0: off, 1: disable_irq_nosync() */
+	u8			moderation_mode; /* written in procfs, read on irq */
+	struct list_head	ms_node;	/* per-CPU list of moderated irq_desc */
+#endif
 	struct module		*owner;
 	const char		*name;
 #ifdef CONFIG_HARDIRQS_SW_RESEND
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1b4254d19a73e..fb9c78b1deea8 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -155,6 +155,17 @@ config IRQ_KUNIT_TEST
 
 endmenu
 
+# Support platform wide software interrupt moderation
+config IRQ_SOFT_MODERATION
+	bool "Enable platform wide software interrupt moderation"
+	help
+	  Enable platform wide software interrupt moderation.
+	  Uses a local timer to delay interrupts in configurable ways
+	  and depending on various global system load indicators
+	  and targets.
+
+	  If you don't know what to do here, say N.
+
 config GENERIC_IRQ_MULTI_HANDLER
 	bool
 	help
-- 
2.51.2.1041.gc1ab5b90ca-goog


