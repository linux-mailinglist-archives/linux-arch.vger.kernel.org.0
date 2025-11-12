Return-Path: <linux-arch+bounces-14682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D9C5422E
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 20:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52167347E6A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 19:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE794352932;
	Wed, 12 Nov 2025 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0t8G89EN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D4352924
	for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975476; cv=none; b=sSBk/pWw/xeM8IqY3CKQOl239AqADbCNlO/I6bordv/ikPbGiWoeIdOZu84/DLnfAgKUfI95+114nuqtzTTtFlbnLmVD3rXIwG2orysRb/b2YCEaCeyhBva+Qv2GvQMlAzJFNGHo0jyX4aIKjOibqMagVibt03oKTmluSiD/yE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975476; c=relaxed/simple;
	bh=toNGEDGM2fDo8bSkeyRBZN131/gcqcXF1zPXs1SMotM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S1NhYGwGOrh/eNYtHtXv1vtwc4wGe0gp9kkFDAp3bbGOTT8X1L4kjAphpNWBfoh3X3J739wdfBHCFiuA20JzL7A9qN+bx8hmLI4Swpy3t/xk8b6xAjxci3qf5YzUe6dimIMvsJfrqgjCSetu/FmKOEGfOdMYjQCe6IyRhgx/JsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0t8G89EN; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-640bae7d83aso2687a12.2
        for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 11:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975473; x=1763580273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc56Im0L/wPheTuphZBEmtz1ndMMkc1rQdJZlfQeq+U=;
        b=0t8G89ENKBnhFiDLYda3FT79chNWlGLJUShyVKb1Nhmsq2Mu0eIFNwUM/fvuuFwkOU
         aCvpv8+1CJciltNNyewOfxg3b4D7BhSZFuJNxyC8MFGDWH9hU8cN+g9JvnjIzlCBc5AB
         8C6pA0T6DCH/ScTfaFAUsV1KkLDLZUUJ5QbrB8G2dzXYVlkH00Om184Kl850423xpIBH
         Smu4x/N82AM+mKjar2hs7BW3Zae8VKtPAmZ7gRyg1mb13PDDRwjDc+/HV5/Pf4acvsXE
         fOHntq32xpOLPC6ef2rl9CA0r4YTcF6dBQtd3X1BCuuGNmcYzEXOLHwP4SnLR+hzIg0j
         ku8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975473; x=1763580273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc56Im0L/wPheTuphZBEmtz1ndMMkc1rQdJZlfQeq+U=;
        b=mjyThRyhdMB9N2Xxp4peQjPta6Rjt+0ZoB98W0Gd/K0/oq1Aiu3haO3+TTz53mqYTy
         cC8MvaV2z4b3Z0VYDWI/X9uKQK3DrQgf/sxeDSP5hHAww1OBc1hpK8OTVBIekNTj8dEg
         MNWUTZI9JQhFRo1TDmw6PpSG5YmV/Jf249VjPIg8/fk1oIkkrLYUMDqOzbhBLCVtbtxN
         Sf2W+eOJqyQhSlDo6BZ2khmpeHE9GIaaANQwnGCD3HIJlnJUNThY3X/oE5jQtOh2a7AH
         44S13LY4R8wRzm2+0GVIBK4PeQqrygglHWC1F+Y9Uka5rjmw70Ln8oCjZdRtBusozQCk
         5vnA==
X-Forwarded-Encrypted: i=1; AJvYcCXuYbzpOs4nSVMthKt3ZT1QkRMe8kDhb0NmeOy2bsweeeiMJQgrQSRnzbcktZ7vpQ7kJVx1ju7q87N3@vger.kernel.org
X-Gm-Message-State: AOJu0YwRI7HL7tGwSdaYRzlMpnbwNmaO7FFr+Iorzv/iFocHXEPomkT5
	ev+uqH9znIGwDYndhRkcPhUDE5Yx/02vu+dTOF/QYlvLAp65chcjgYqAbkqb23YeGsI5K/EUVm8
	6d2luKg==
X-Google-Smtp-Source: AGHT+IHy1JZdLmmhLtppnkVtk92yU/GzqkzRArhgbpy6IgXzyGv+2/u+PlsYwaDikLZmzfb52j6h4XAZ/GY=
X-Received: from edhr5.prod.google.com ([2002:a50:8d85:0:b0:641:92ae:b599])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1449:b0:640:b8a0:1aad
 with SMTP id 4fb4d7f45d1cf-6431a39287emr4098002a12.6.1762975473032; Wed, 12
 Nov 2025 11:24:33 -0800 (PST)
Date: Wed, 12 Nov 2025 19:24:08 +0000
In-Reply-To: <20251112192408.3646835-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112192408.3646835-7-lrizzo@google.com>
Subject: [PATCH 6/6] genirq: soft_moderation: implement per-driver defaults
 (nvme and vfio)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce helpers to implement per-driver module parameters to enable
moderation at boot/probe time.

As an example, use the helpers in nvme and vfio drivers.

To test, boot a kernel with

${driver}.soft_moderation=1 # enables moderation.

and verify with "cat /proc/irq/soft_moderation" that
the counters increase.

Change-Id: Iaad4110977deb96df845501895e0043bd93fc350
---
 drivers/nvme/host/pci.c           |  3 +++
 drivers/vfio/pci/vfio_pci_intrs.c |  3 +++
 include/linux/interrupt.h         | 13 +++++++++++++
 kernel/irq/irq_moderation.c       | 11 +++++++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72fb675a696f4..b9d7bce30061f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -72,6 +72,8 @@
 static_assert(MAX_PRP_RANGE / NVME_CTRL_PAGE_SIZE <=
 	(1 /* prp1 */ + NVME_MAX_NR_DESCRIPTORS * PRPS_PER_PAGE));
 
+DEFINE_IRQ_MODERATION_MODE_PARAMETER;
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
@@ -1989,6 +1991,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 		result = queue_request_irq(nvmeq);
 		if (result < 0)
 			goto release_sq;
+		IRQ_MODERATION_SET_DEFAULT_MODE(pci_irq_vector(to_pci_dev(dev->dev), vector));
 	}
 
 	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 30d3e921cb0de..e54d88cfe601d 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -22,6 +22,8 @@
 
 #include "vfio_pci_priv.h"
 
+DEFINE_IRQ_MODERATION_MODE_PARAMETER;
+
 struct vfio_pci_irq_ctx {
 	struct vfio_pci_core_device	*vdev;
 	struct eventfd_ctx		*trigger;
@@ -317,6 +319,7 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 		vfio_irq_ctx_free(vdev, ctx, 0);
 		return ret;
 	}
+	IRQ_MODERATION_SET_DEFAULT_MODE(pdev->irq);
 
 	return 0;
 }
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 007201c8db6dd..c7d68d8ec49d7 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -879,12 +879,25 @@ void irq_moderation_init_fields(struct irq_desc *desc);
 /* add/remove /proc/irq/NN/soft_moderation */
 void irq_moderation_procfs_entry(struct irq_desc *desc, umode_t umode);
 
+/* helpers for per-driver moderation mode settings */
+#define DEFINE_IRQ_MODERATION_MODE_PARAMETER		\
+	static bool soft_moderation;			\
+	module_param(soft_moderation, bool, 0644);	\
+	MODULE_PARM_DESC(soft_moderation, "0: off, 1: disable_irq")
+
+void irq_moderation_set_mode(int irq, bool mode);
+#define IRQ_MODERATION_SET_DEFAULT_MODE(_irq)		\
+	irq_moderation_set_mode(_irq, READ_ONCE(soft_moderation))
+
 #else   /* empty stubs to avoid conditional compilation */
 
 static inline void irq_moderation_percpu_init(void) {}
 static inline void irq_moderation_init_fields(struct irq_desc *desc) {}
 static inline void irq_moderation_procfs_entry(struct irq_desc *desc, umode_t umode) {};
 
+#define DEFINE_IRQ_MODERATION_MODE_PARAMETER
+#define IRQ_MODERATION_SET_DEFAULT_MODE(_irq)
+
 #endif
 
 /*
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 672e161ecf29e..3b3962dae33d1 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -83,6 +83,10 @@ static bool enable_posted_msi;
  *
  *    echo "on" > /proc/irq/NN/soft_moderation # use "off" to disable
  *
+ * For selected drivers, the default can also be supplied via module parameters
+ *
+ *	${DRIVER}.soft_moderation=1
+ *
  * === MONITORING ===
  *
  * cat /proc/irq/soft_moderation shows per-CPU and global statistics.
@@ -302,6 +306,13 @@ static void set_moderation_mode(struct irq_desc *desc, bool mode)
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
-- 
2.51.2.1041.gc1ab5b90ca-goog


