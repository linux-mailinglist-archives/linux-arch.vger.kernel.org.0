Return-Path: <linux-arch+bounces-14679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD6C54222
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92FDD342D98
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C5350A1A;
	Wed, 12 Nov 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8cG4LGT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8353502B5
	for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975471; cv=none; b=WS91+pqs9WkjEqTOwMTOlLUBtRYpAarkOmzslwJVeA/VSfNiB4dbYI1WHTS/DLuKuDSGi4ccljPz/svYhGz5HztjOziSyHamkVyh/5K/MPwfxCjJc6by47/bAetTRDaSLPos6+ybmNmtpbszW/sDkKn7FuWPfGYH8iIIELSYuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975471; c=relaxed/simple;
	bh=U1wRohHj26D11My7hyn5Fjdv4sejotMbBGmzGh0UhXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5DKlo/WzhnR5X5zXl930cyDrpyahToO72/rFKa77E46jl22hU/GzRb0E7YM2PSg80f3K8ZByU0uHxRwP6uYA7jqidndmqlQpqjo4DsuDKNG2s9M7eW9uiCGZgJhpHqw77t+zT4MxtRHZa7swrrnhXhEqOemeh6E2+ZvY4hTPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8cG4LGT; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-641632b8825so37178a12.0
        for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 11:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975467; x=1763580267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIoXEE+S06QHrqc9zlnHrp1tKevTOCIMWDXUdlSULxc=;
        b=i8cG4LGTFBIlpmu5dMCuJZ7Q48y2UjORI1YkwIz3f8jUKd92CDbSpPTIB7HuuF7enN
         vVJaQAZeDWTepgMuxGM8hnZlRfQ1dZMFvOkLbOkyhur91IZYVEdiP0+4iUtaFH3wJFb+
         I2faD2Bccfo5cQqS+Tq8lQ21c20lu4Xez4BS7f2fcYfC3Prx59MlMkZBGUrHLfUxooKO
         Qjw+wDMUPF7QTyeiVamr5Mx8UveqPGz7gtHpa2Ie8Cy4e1Iv0Js3JQ2EjYlkeCNbwChi
         RjI3V95c492yczXz9Plm/5l+mLRhwpu3X1imTd09RzmP00I1EeN1Frc2CpHBuh64447M
         Ut4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975467; x=1763580267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIoXEE+S06QHrqc9zlnHrp1tKevTOCIMWDXUdlSULxc=;
        b=syoAotv8Bg8yM33D/g9aQkkGS9XZr8MxRAjoswPkdWPbqWATe11QnBaai0UH15vP1/
         Qm65GO7+ULgycSzpPeacQdSNB7GgN3Kce1OJI8G+0scxH3ArW73G7Gced0aFZfe0xDrq
         ptIkuDmtxoEbwGwbCFvF3pfxfGDZsaCf+L0OE7Js01Uph4++7yGjA+wwfdjfPZGy8fDN
         UsWsVzRkDnxY6MblqMdNHLs9xOdvM+3lSzc8iyG2UpZrBirBma3VUAzA4fWkGycpsx/I
         +kMu0gOANIiHWk5F7irhTIjnRidZm7fzEcDGRTzM3yBVHiIQHhuNYLiJkL4N5A8aq0NU
         ruww==
X-Forwarded-Encrypted: i=1; AJvYcCUHzf4xGlMODs2Cm764PJ+1JB5maJjUmwi2F1/DuejB1KFf2OnXzWaygM8MBUwX77UFgiCtHyzp+4F+@vger.kernel.org
X-Gm-Message-State: AOJu0YygibwzDYobQD6bS1CBMw9a72nvNaMP6kEb6JyHag/Ot/5nL3QW
	K9RL0DeOq8d1gmCNFFBZgFnkStwKetAqTV7+7+jhrmCeeA3MjNFXhdmQytYyBTFWCD0CWCgsHiN
	4MHz/KA==
X-Google-Smtp-Source: AGHT+IFKilkduTNedmFbVR6dbNG+KpfIItVMFlp40IXZ01vb1nyeI/Op4xDBXuM1bNYEeMsk9RIyypHkw1k=
X-Received: from edok5.prod.google.com ([2002:aa7:c045:0:b0:640:9a27:321e])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:909:b0:63c:1170:656a
 with SMTP id 4fb4d7f45d1cf-6431a586af8mr3787278a12.37.1762975467428; Wed, 12
 Nov 2025 11:24:27 -0800 (PST)
Date: Wed, 12 Nov 2025 19:24:05 +0000
In-Reply-To: <20251112192408.3646835-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112192408.3646835-4-lrizzo@google.com>
Subject: [PATCH 3/6] genirq: soft_moderation: activate hooks in handle_irq_event()
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Activate soft_moderation via the hooks in handle_irq_event()
and per-CPU and irq_desc initialization.

This change only implements fixed moderation. It needs to be
explicitly enabled at runtime on individual interrupts.

Example (kernel built with CONFIG_SOFT_IRQ_MODERATION=y)

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

Configuration via module parameters (irq_moderation.${name}=${value}) or
echo "${name}=${value}" > /proc/irq/soft_moderation)

delay_us   0=off, range 1-500, default 100
  how long an interrupt is disabled after it fires. Small values are
  accumulated until they are large enough, e.g. 10us. As an example, a 2us value
  means that the timer is set only every 5 interrupts.

timer_rounds  0-20, default 0
  How many extra timer runs before re-enabling interrupts. This allows
  reducing the number of MSI interrupts while keeping delay_us small.
  This is similar to the "napi_defer_hard_irqs" option in NAPI, but with
  some subtle differences (e.g. here the number of rounds is
  deterministic, and interrupts are disabled at MSI level).

Change-Id: I47c5059ad537fcb9561f924620cf68e1d648aae6
---
 arch/x86/kernel/cpu/common.c | 1 +
 drivers/irqchip/irq-gic-v3.c | 2 ++
 kernel/irq/handle.c          | 3 +++
 kernel/irq/irqdesc.c         | 1 +
 4 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 02d97834a1d4d..1953419fde6ff 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2440,6 +2440,7 @@ void cpu_init(void)
 
 		intel_posted_msi_init();
 	}
+	irq_moderation_percpu_init();
 
 	mmgrab(&init_mm);
 	cur->active_mm = &init_mm;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3de351e66ee84..902bcbf9d85d8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1226,6 +1226,8 @@ static void gic_cpu_sys_reg_init(void)
 		WARN_ON(gic_dist_security_disabled() != cpus_have_security_disabled);
 	}
 
+	irq_moderation_percpu_init();
+
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
 	 * its reset value (and with a value large enough to prevent
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index e103451243a0b..2cacceaaea9d0 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -12,6 +12,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/irq_moderation.h>
 #include <linux/kernel_stat.h>
 
 #include <asm/irq_regs.h>
@@ -254,9 +255,11 @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
 	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	raw_spin_unlock(&desc->lock);
 
+	irq_moderation_hook(desc); /* may disable irq so must run unlocked */
 	ret = handle_irq_event_percpu(desc);
 
 	raw_spin_lock(&desc->lock);
+	irq_moderation_epilogue(desc); /* start moderation timer if needed */
 	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	return ret;
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5f..e3efbecf5b937 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -134,6 +134,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
+	irq_moderation_init_fields(desc);
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
-- 
2.51.2.1041.gc1ab5b90ca-goog


