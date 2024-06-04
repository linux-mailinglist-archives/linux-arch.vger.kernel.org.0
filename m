Return-Path: <linux-arch+bounces-4664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAEF8FA9A3
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07BE1C22D1E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E12913FD92;
	Tue,  4 Jun 2024 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps3vhxnn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB791411D3;
	Tue,  4 Jun 2024 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477846; cv=none; b=KVPCJk01vyZ/v+XERGbc/S3nIwSESzfbr1KLfn8D2K30xMultZPXf5ggDR0m6k+N9Ff7vMN79w7bHjdehoTARCSXd6HvL0OlfjXGvY7nRzHpNaW/gVMj4sVV6nPD6yJqMvMm6CwScxTpsDxXGhuy3unk2m4VoME6p7LC8zgUbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477846; c=relaxed/simple;
	bh=8vTFceAsLpgln0QaJDr9UyqQci5nGMvow5UnG1jar74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvzWN10bIqWwEbtQkGeC4RIbngO4SEdmCwfBLAIeHTLOHZHThxgxHb+fWB9V4Oy9zJR/ECI2xiVMAzvKUMhb6+l+vkjNh1/4WbZvDsfThWH9bW6PTEcMWJbrFWFPLSXT9Qg+V6NfI/WMSZLFPqhKM85MU7xAu4cQ5iGNlFYSdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps3vhxnn; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-250928a8580so1789045fac.3;
        Mon, 03 Jun 2024 22:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477844; x=1718082644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4rqdND7i4OjEglrNB2gz2qk2VRnqZQkQh3OgdrDACL0=;
        b=Ps3vhxnnB6Mzkc6z5PlgzSzjc8xrBBm30l8Krf6cM6CMGWUwGQ7KsSAZHSIgjusci8
         II2B5+jWoSmMr/NTEdtBlBmymUMWa0Khg+HEnR3mWzKdUEF5RE01OvnRNoo4LFTvUZvV
         ZrldILl2/IKN4uxmYGACUmTNMQOli4yF9ngsH6wFJyMUlwnFTW6aiEvPfRoolGKFOBmK
         7R+4tI5fwdtXTCrKECOjqgisnaM8sQPGPzcJtTKgEuwEadzhT+mnRx3gjZj9XjNzMLXi
         RBeUz8GD3nlqQT+dvsvtzgjQ5K3ptZHBjveUiG0uwxoKOAHJ7uXQIUIEGaWDTJVOvZbC
         Yytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477844; x=1718082644;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rqdND7i4OjEglrNB2gz2qk2VRnqZQkQh3OgdrDACL0=;
        b=IcJZ10gut1WIAzxC6UgNKi7L8GW6w8yHxJZL6ldqyi1pf0yNn4m+0MG7kc7M7aZPfV
         BpymUMizf+40hsd0BJgdgFlAmblEIo9oblrsxwFCK+wtuNEAbqJqRteCJIFoCEvqAhP1
         +Rli56umprjOFy78ip9ISYCN67ORCwEhkSDNYSx8VqTcUsZZPr1SK3+uMONcR9PDIcNR
         V1odRfk21Xg8ommS2Z27HWkwfanXU7jCQDvy0aN+evs7p0AuzY7lbXL5w54kyY1DPAbb
         MCVaA8fxo7MudthfW3aubxJuUxUjJwMb+QH9Lg07bMwFn9c6ZbrQhq3w5GwDHlPJNTW8
         vWrA==
X-Forwarded-Encrypted: i=1; AJvYcCVd1qWSZC/cuQmFORrMRJ4+olxyRxGjqbl0Rsp1E48sUgxCD6hngVLgnp5z0tuJDGr1W7wf/+++eroYHZC4ZNrdwhWXYAg9XbPvmOPRddjIMmXxWMZn7fAJnYpo0qk6n4+ou3J+9/1NNu0mjk8a0apDqteu1ezwA2K7BOP6NSnWYP0BJ9HEFphdA3Ar+sr49iqNe2+d4wIC188AabQCw8HBjRzsgBajXpoVMD1y6gIgV2jJxRNPKpAZsZHLvUg=
X-Gm-Message-State: AOJu0YwUfB176z1En4w/tCC6/QTeZk37+VJQEvS98viyHtsfqKMwvPOH
	uSuf3nNNxHe1Ouj0eSnOGcq/UTMD/uyEATP4eSsyBlawZuFIU0gh
X-Google-Smtp-Source: AGHT+IEyK5gUfY9/lSLdd30TiSbxTGT5bgkCQfCQCTSfZcQeNghhepHgsH5TsmMYS1KZXrNP4YZsNQ==
X-Received: by 2002:a05:6870:1702:b0:24f:e3a3:4431 with SMTP id 586e51a60fabf-2508b9efb87mr10561586fac.13.1717477843743;
        Mon, 03 Jun 2024 22:10:43 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:43 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	arnd@arndb.de,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: maz@kernel.org,
	den@valinux.co.jp,
	jgowans@amazon.com,
	dawei.li@shingroup.cn
Subject: [RFC 06/12] genirq: Add per-cpu flow handler with conditional IRQ stats
Date: Mon,  3 Jun 2024 22:09:34 -0700
Message-Id: <20240604050940.859909-7-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604050940.859909-1-mhklinux@outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Hyper-V VMBus devices generate interrupts that are multiplexed
onto a single per-CPU architectural interrupt. The top-level VMBus
driver ISR demultiplexes these interrupts and invokes per-device
handlers. Currently, these per-device handlers are not modeled as
Linux IRQs, so /proc/interrupts shows all VMBus interrupts as accounted
to the top level architectural interrupt. Visibility into per-device
interrupt stats requires accessing VMBus-specific entries in sysfs.
The top-level VMBus driver ISR also handles management-related
interrupts that are not attributable to a particular VMBus device.

As part of changing VMBus to model VMBus per-device handlers as
normal Linux IRQs, the top-level VMBus driver needs to conditionally
account for interrupts. If it passes the interrupt off to a
device-specific IRQ, the interrupt stats are done by that IRQ
handler, and accounting for the interrupt at the top level
is duplicative. But if it handles a management-related interrupt
itself, then it should account for the interrupt itself.

Introduce a new flow handler that provides this functionality.
The new handler parallels handle_percpu_irq(), but does stats
only if the ISR returns other than IRQ_NONE. The existing
handle_untracked_irq() can't be used because it doesn't work for
per-cpu IRQs, and it doesn't provide conditional stats.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a217e1029c1d..8825b95cefe5 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -656,6 +656,7 @@ extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
 extern void handle_untracked_irq(struct irq_desc *desc);
 extern void handle_percpu_irq(struct irq_desc *desc);
+extern void handle_percpu_demux_irq(struct irq_desc *desc);
 extern void handle_percpu_devid_irq(struct irq_desc *desc);
 extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..1f37a9db4a4d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -910,6 +910,35 @@ void handle_percpu_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
+/**
+ *	handle_percpu_demux_irq - Per CPU local irq handler for IRQs
+ *	that may demultiplex to other IRQs
+ *	@desc:	the interrupt description structure for this irq
+ *
+ *	For per CPU interrupts on SMP machines without locking requirements.
+ *	Used for IRQs that may demultiplex to other IRQs that will do the
+ *     stats tracking and randomness. If the handler result indicates no
+ *	demultiplexing is done, account for the interrupt on this IRQ.
+ */
+void handle_percpu_demux_irq(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
+	if (__handle_irq_event_percpu(desc))
+		/*
+		 * PER CPU interrupts are not serialized.  Do not touch
+		 * desc->tot_count.
+		 */
+		__kstat_incr_irqs_this_cpu(desc);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+EXPORT_SYMBOL_GPL(handle_percpu_demux_irq);
+
 /**
  * handle_percpu_devid_irq - Per CPU local irq handler with per cpu dev ids
  * @desc:	the interrupt description structure for this irq
-- 
2.25.1


