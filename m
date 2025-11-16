Return-Path: <linux-arch+bounces-14804-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2DBC61A9F
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBD2A35A207
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE93101A2;
	Sun, 16 Nov 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y28Dek2k"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820E2FA0DF
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317745; cv=none; b=CuYZP4rMt9z3GytWQ5dJQ80Vt7TaBDivcHOxx98hW1qwXSX/wj6B1tvL7Aad1Jgb4L/1FXjQk/Mjsk1rvJuzvD86A2048WeJ7Fsj8v2tPe1PBUImi+X+fg0iTvIyrz+mI5pfiJgC4WHkffG7RwSR/pKl77E9iZmVN23SSrRQqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317745; c=relaxed/simple;
	bh=kbra++Qm82AC0+qjKtrSle0ssmU6yox3Pn48tD2LAjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBWqLlI0MK5WGLIvAqKIc1hF3RwNLy1ut8X4wzaOlNM2HULOEvhdcZOjcoHghKRylnI6kwbJLRag7sfa8S+o9CEmHszIBLuZhoQdidmm+s+HrtlyTgEizkGF3KrShOJfZDspKx7FtTPKANzsrxjMimVp5iUiaKbC+FN+vhsZZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y28Dek2k; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b7336ad128cso454156866b.1
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317741; x=1763922541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2b1Yul+cMBRFlwv9AGcDI9KWrSUmjwquRNK/h5oxI84=;
        b=Y28Dek2kJjg80yoQWQhLDljDt86Tz1/At7kaytdtkL4lXs178HH615yx7PZnBo30jG
         8zPaJDNQuiy/CkldWMIyNzLe2z+nm96PI7dhlwIfpA6ejjmHz5CqlroLk+OIFeaZGgCV
         MXljN/kZ1JQ9yBTUWLofGbAIu6pHaP8J5HQupisPIuJsKpZeBd5Oh23M44XLAiRd68Er
         MxmfNzhcuofj+FG0QCbpQ6ch/R/KYh6WyhHi6aSHf0/wDovlyo2edQJYprjslkTvj1uA
         zu+gdpwB9atNT3weLUKbDVNEdwjLe4EnYDG2ITNCIsarLPGNR+O7Xv0hcJxBnvjdPKUx
         Q4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317741; x=1763922541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2b1Yul+cMBRFlwv9AGcDI9KWrSUmjwquRNK/h5oxI84=;
        b=H/Fnt1UydmBiuJMWDVFykB4RHqp+/jyFa4pjZj1lPchiQSHV12epbR9E8jixDfuUnb
         VdpuGPrMwhCswKNDvNqkCq5ZOJcjF9b1+ndoIGFE0D5YqzFLFhOJjf7ZSlSr8Og0Jc14
         Qo8fw+L+XzBp7T+IFeF8raXGpggWIhG/arJihZXyen4+rvU71JHGAid7XwADJCe+iRk3
         HXscgRDFfJxnwgb12eXxDxaxPgQ0J6NJF0Xjh8GCMpGpfGCCzDxnQNTPsE+CyYQUhZPb
         AwYE7Yk5tr+NBfppDzNyXXIGRpnkx7fDZxOfLhrBuL9uWhSLNZ+i8ojgmIeOTQpXfAMM
         fWUA==
X-Forwarded-Encrypted: i=1; AJvYcCXsMnwk91fiXub2PYH1kmEzpBLkHJYKlveKYiLirZkQPlEIStT+rTxvaWykiyRV+wbEblgIwq6eSUND@vger.kernel.org
X-Gm-Message-State: AOJu0YyDR+Fl9Ru2G5CgW6YTfkEsftHT5vZuLm4itgLxWP5UhhJXkoo5
	5K7oul0b+LEzzZYYaeOiJLMKkO/slS0bZd80ng3DRNgx+L/wQzgj10G1cpzv1qn2ovXnmlXdfha
	I8+JJoA==
X-Google-Smtp-Source: AGHT+IGsaAzHRYbH4nKIeUgo57u1Tk3fp/FT4roLcCoCmiGAS/Za3nQcxBglvx1k0PQBC7gDNriFHOtD5m8=
X-Received: from ejcwb10.prod.google.com ([2002:a17:907:d50a:b0:b72:41e4:7535])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:d1d9:b0:b73:6998:7bce
 with SMTP id a640c23a62f3a-b7369987d75mr816322766b.33.1763317741179; Sun, 16
 Nov 2025 10:29:01 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:32 +0000
In-Reply-To: <20251116182839.939139-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-2-lrizzo@google.com>
Subject: [PATCH v2 1/8] genirq: platform wide interrupt moderation:
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

Platform wide software interrupt moderation ("soft_moderation")
specifically addresses a limitation of platforms from many vendors
whose I/O performance drops significantly when the total rate of MSI-X
interrupts is too high (e.g 1-3M intr/s depending on the platform).

Conventional interrupt moderation operates separately on each source,
hence the configuration should target the worst case. On large servers
with hundreds of interrupt sources, keeping the total rate bounded would
require delays of 100-200us, and adaptive moderation would have to reach
those delays with as little as 10K intr/s per source. These values are
unacceptable for RPC or transactional workloads.

To address this problem, soft_moderaton measures efficiently the total
and per-CPU interrupt rates, so that individual moderation delays
can be adjusted based on actual global and local load. This way, the
system controls both global interrupt rates and individual CPU load,
and tunes delays so they are normally 0 or very small except during
actual local or global overload.

soft_moderation does not rely on any special hardware feature except
requiring the device to record which sources have pending interrupts.

Configuration is easy and robust. System administrators specify the
maximum targets (moderation delay; interrupt rate; and fraction of time
spent in hardirq), and per-CPU control loops adjust actual delays to try
and keep metrics within the targets.

There is no need for exact targets, because the system is adaptive;
values like delay_us=100, target_irq_rate=1000000, hardirq_percent=70 are
good almost everywhere.

Boot defaults are set via module parameters (/sys/module/irq_moderation
and /sys/module/${DRIVER}) or at runtime via /proc/irq/soft_moderation, which
is also used to export statistics. Moderation on individual irqs can
be turned on/off via /proc/irq/NN/soft_moderation .

No functional impact in. Enabling the option will just extend struct
irq_desc.

CONFIG_IRQ_SOFT_MODERATION=y

Change-Id: I33ad84525a0956a1164033e690104bf9fb40ecac
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 Documentation/core-api/irq/index.rst          |   1 +
 Documentation/core-api/irq/irq-moderation.rst | 154 ++++++++++++++++++
 include/linux/irqdesc.h                       |  18 ++
 kernel/irq/Kconfig                            |  12 ++
 4 files changed, 185 insertions(+)
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
index 0000000000000..71cad4fd5c3f4
--- /dev/null
+++ b/Documentation/core-api/irq/irq-moderation.rst
@@ -0,0 +1,154 @@
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
+The most common and robust implementation of moderation enforces
+some minimum **delay** between subsequent interrupts, using a timer
+in the device or in software. Most NICs support programmable hardware
+moderation, with timer granularity down to 1us or so.  NVME also
+specifies hardware moderation timers, with 100us granularity.
+
+One downside of moderation, especially with **fixed** delay, is that
+even with moderate load, the notification latency can increase by as
+much as the moderation delay. This is undesirable for transactional
+workloads. At high load the extra delay is less problematic, because
+the queueing delays that occur can be one or more orders of magnitude
+bigger.
+
+To address this problem, software can dynamically adjust the delay, making
+it proportional to the I/O rate. This is called **adaptive** moderation,
+and it is commonly implemented in network device drivers.
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
+PLATFORM WIDE ADAPTIVE MODERATION
+---------------------------------
+
+Platform-Wide adaptive interrupt moderation addresses the problem
+operateing as follows (all parameters are configurable via module parameters
+irq_moderation.${name}=${value} or /proc/irq/soft_moderation):
+
+* On each interrupt, increments a per-CPU interrupt counter.
+
+* Opportunistically, every ``update_msi`` or so, each CPU scalably
+  accumulates the values across the entire system, computes the global
+  and per-CPU interrupt rate, and the number of CPUs actively processing
+  interrupts, ``active_cpus``.
+
+* Based on a configurable ``target_irq_rate``, each CPU the per-CPU
+  fair share (``target_irq_rate / active_cpus``) and whether the global
+  and total rate are abovethe targets. A simple control loop then adjusts
+  up/down its per-CPU moderation delay, ``mod_ns``, between 0 (disabled)
+  and a configurable maximum ``delay_us``.
+
+* When ``mod_ns`` is above a threshold (e.g. 10us), the first interrupt
+  served by that CPU starts an hrtimer to fire ``mod_ns`` nanoseconds.
+  All interrupts sources served by that CPU will be disabled as they come.
+
+* When the timer fires, all disabled sources are re-enabled, allowing pending
+  interrupts to be processed again.
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
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fd091c35d5721..25df3c51772fa 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -29,6 +29,23 @@ struct irqstat {
 #endif
 };
 
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+/**
+ * struct irq_desc_mod - interrupt moderation information
+ * @ms_node:		per-CPU list of moderated irq_desc
+ * @enable:		enable moderation on this descriptor
+ */
+struct irq_desc_mod {
+	struct list_head	ms_node;
+	bool			enable;
+};
+
+void irq_moderation_init_fields(struct irq_desc_mod *mod);
+#else
+struct irq_desc_mod {};
+static inline void irq_moderation_init_fields(struct irq_desc_mod *mod) {}
+#endif
+
 /**
  * struct irq_desc - interrupt descriptor
  * @irq_common_data:	per irq and chip data passed down to chip functions
@@ -112,6 +129,7 @@ struct irq_desc {
 #endif
 	struct mutex		request_mutex;
 	int			parent_irq;
+	struct irq_desc_mod	mod;
 	struct module		*owner;
 	const char		*name;
 #ifdef CONFIG_HARDIRQS_SW_RESEND
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1b4254d19a73e..c258973b63459 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -155,6 +155,18 @@ config IRQ_KUNIT_TEST
 
 endmenu
 
+# Support platform wide software interrupt moderation
+config IRQ_SOFT_MODERATION
+	bool "Enable platform wide software interrupt moderation"
+	depends on PROC_FS=y
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
2.52.0.rc1.455.g30608eb744-goog


