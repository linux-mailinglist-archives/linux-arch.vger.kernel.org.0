Return-Path: <linux-arch+bounces-4667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E708FA9AF
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820121F221D2
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC2613D8B5;
	Tue,  4 Jun 2024 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGxsXeiW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B763142629;
	Tue,  4 Jun 2024 05:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477850; cv=none; b=EqXGxC0gXq2SiXvje+nGXKbOdLB7E7eXZUHOFns9qipm55m4hys7vdKWUZC0sJIVSRN27EdklySPWZAtOpnQtuMqD/FdM3E6EaB7zHErmjAUodzejRO34Q6Ux+u2KpJTTpUYFIC+nLlIDKEayTb2THvTRq0ZrdfzkHNNDCmzuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477850; c=relaxed/simple;
	bh=Dtv+8BHewlDtrscRUC9E1bIoWTmplqu0ARBJT2pimYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iD/qWg58Pmzgjy73tgZ5jHGdcStZ21Iud2TyUwt0iH6kEyWlHP0ehzT3BtHtuOOYyXzJDP5wCkvAU1Pm9qD+Fqt2rD/LCmFt9xKWyw1CiQtNYMPodMxM2kWIhNqAZiXwoFaDRQd6WWuaMjfc1XVQS+1sDOaFAGTV+CVN6yvRuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGxsXeiW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7025cb09553so2191891b3a.3;
        Mon, 03 Jun 2024 22:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477848; x=1718082648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X+SPYtiC+eKOOluq0xEXtbfDYX7+i/A8vs71JSRv2/w=;
        b=cGxsXeiWR9IUNANgy10u9SpNbdv7smq9YxQpMQlD2ws4Gs+doIyxU2vCqS5WN1qzEn
         u5v1mzM2Li3Jks+3HC/Uy1pphm9Z5kk6Af0f1a2jxiya8VPPcv1+TL+TwzibdQy0FRiE
         gM3XvNEOoN3aazBEClnbCwvUFSfVLs2wZ82NeS56SwVbWJd13xh9yd9G9xalGe8uxDKj
         8LsZMJ8AIDYU6kKyZOM9PJsF551AhCnQIZdIogsGE4aA6hugr6cM/7U3Lqo93BTEL/K7
         ivSQPTi8AD2+3F53vcj8fYb1FdaG5xJxBvxrvnJIGzHG/59UI+aAVHzFFurZM0AIsDxI
         M1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477848; x=1718082648;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+SPYtiC+eKOOluq0xEXtbfDYX7+i/A8vs71JSRv2/w=;
        b=iLHFT9Z92Qu0EII8dClG4m3siZMVQOXytfboIWpp5lHVTOjgSt0FTlnLs/H/KUfYgR
         XlkdXtL2mMl3dW2RFMc6c3oIfCvUbLIf5Op7MejMed6x3xW7xkgUy64TnhuVMVidmyDD
         IKL9BVVJfGgpXOgdPLfNlmzxoSQ8G5qxsWQsM0J2EHYjwQbJ0ieruH5rlNmTTo8k2kur
         9sTb0v4T4Bj5bepjltU8mEryuPXBeYO2gIN2C7lx+ffvT4JKaEcOi0+KL4GNCCslEU+Y
         SzlYslcVQ1trT/DkENgEH9xHnN13/yQkAarnwQC35FBRnSEoNsIVP5Q6eeW9TrPPFLiw
         kTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKexbd54Am8PgtEQf1mzk21yOU/wjwr3QIJYBHmF7Dic4RL9NqL3ifStGhmHqiLV2nPqQE1P4B/aW/sAebInF0bGsD6BibVlStB+Fl7Qn6nXNLPuawO9PMaSmbcWQg7uRnP1BHswrbYo/QrG9LdtB3ZVVpmnFYLlV8GWv2ou7uWw6CP+/y6iACMEVPWsR0hJo8Ws24o5GSSStGX38wm6kBbi1lHz88D/6vYgeZ6dATYZZuQVprKUBDin3kVH8=
X-Gm-Message-State: AOJu0YxVu9QtuMNGLq7XqhHmTYwZWDom2M3W/xVJuPWC4QAdmhaC/P8+
	oqk/tguDNYaHfTywvsLpSm7zsN9emnCEZzpB/UptfyJ3I02w7JvV
X-Google-Smtp-Source: AGHT+IF/QjqqduNmy9R3nfgGphf2kfowTvEQN0egF5f68NiQrvZUbfJu9Gb0OBfN+Uknx2sDslo5gg==
X-Received: by 2002:a05:6a00:39a6:b0:6f4:4319:4cea with SMTP id d2e1a72fcca58-702478da697mr15516163b3a.33.1717477847750;
        Mon, 03 Jun 2024 22:10:47 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:47 -0700 (PDT)
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
Subject: [RFC 09/12] Drivers: hv: vmbus: Use Linux IRQs to handle VMBus channel interrupts
Date: Mon,  3 Jun 2024 22:09:37 -0700
Message-Id: <20240604050940.859909-10-mhklinux@outlook.com>
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

Do the following:

1) Create an interrupt handler for VMBus channel interrupts by pulling
   out portions of vmbus_chan_sched() into vmbus_chan_handler(). The
   outer part of vmbus_chan_sched() that loops through the synic event
   page bitmap remains unchanged. But when a pending VMBus channel
   interrupt is found, call generic_handle_irq_desc() to invoke
   handle_simple_irq() and then vmbus_chan_handler() for the channel's
   IRQ. handle_simple_irq() does the IRQ stats for that channel's IRQ,
   so that per-channel interrupt counts appear in /proc/interrupts. The
   overall processing of VMBus channel interrupts is unchanged except
   for the intervening handle_simple_irq() that does the stats. No acks
   or EOIs are required for VMBus channel IRQs.

2) Update __vmbus_open() to call request_irq(), specifying the previously
   setup channel IRQ name and vmbus_chan_handler() as the interrupt
   handler. Set the IRQ affinity to the target_cpu assigned when the
   channel was created.

3) Update vmbus_isr() to return "false" if it only handles VMBus
   interrupts, which were passed to the channel IRQ handler. If
   vmbus_isr() handles one or more control message interrupts, then
   return "true". Update the related definitions to specify a boolean
   return value.

4) The callers of vmbus_isr() increment IRQ stats for the top-level
   IRQ only if "true" is returned. On x86, the caller is
   sysvec_hyperv_callback(), which manages the stats directly. On
   arm64, the caller is vmbus_percpu_isr(), which maps the boolean
   return value to IRQ_NONE ("false") or IRQ_HANDLED ("true").
   Then handle_percpu_demux_irq() conditionally updates the
   stats based on the return value from vmbus_percpu_isr().

With these changes, interrupts from VMBus channels are now
processed as Linux IRQs that are demultiplexed from the main
VMBus interrupt.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c |  9 ++--
 drivers/hv/channel.c           | 25 +++++++++-
 drivers/hv/hv_common.c         |  2 +-
 drivers/hv/vmbus_drv.c         | 84 +++++++++++++++++++---------------
 include/asm-generic/mshyperv.h |  3 +-
 5 files changed, 79 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..18bc282a99db 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -110,7 +110,7 @@ void hv_set_msr(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_msr);
 
-static void (*vmbus_handler)(void);
+static bool (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
@@ -119,9 +119,8 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	inc_irq_stat(irq_hv_callback_count);
-	if (vmbus_handler)
-		vmbus_handler();
+	if (vmbus_handler && vmbus_handler())
+		inc_irq_stat(irq_hv_callback_count);
 
 	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
 		apic_eoi();
@@ -129,7 +128,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	set_irq_regs(old_regs);
 }
 
-void hv_setup_vmbus_handler(void (*handler)(void))
+void hv_setup_vmbus_handler(bool (*handler)(void))
 {
 	vmbus_handler = handler;
 }
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fb8cd8469328..1aa020b538f1 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -638,6 +638,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	struct vmbus_channel_open_channel *open_msg;
 	struct vmbus_channel_msginfo *open_info = NULL;
 	struct page *page = newchannel->ringbuffer_page;
+	u32 relid = newchannel->offermsg.child_relid;
 	u32 send_pages, recv_pages;
 	unsigned long flags;
 	int err;
@@ -685,13 +686,31 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	if (err)
 		goto error_free_gpadl;
 
+	/* Request the IRQ and assign to target_cpu */
+	err = request_irq(newchannel->irq, vmbus_chan_handler, 0,
+			  newchannel->irq_name, newchannel);
+	if (err) {
+		pr_err("request_irq failed with %d for relid %d irq %d\n",
+				err, relid, newchannel->irq);
+		goto error_free_gpadl;
+	}
+	err = irq_set_affinity_and_hint(newchannel->irq,
+				  cpumask_of(newchannel->target_cpu));
+	if (err) {
+		pr_err("irq_set_affinity_and_hint failed with %d for relid %d irq %d\n",
+				err, relid, newchannel->irq);
+		free_irq(newchannel->irq, newchannel);
+		goto error_free_gpadl;
+	}
+	newchannel->irq_requested = true;
+
 	/* Create and init the channel open message */
 	open_info = kzalloc(sizeof(*open_info) +
 			   sizeof(struct vmbus_channel_open_channel),
 			   GFP_KERNEL);
 	if (!open_info) {
 		err = -ENOMEM;
-		goto error_free_gpadl;
+		goto error_free_irq;
 	}
 
 	init_completion(&open_info->waitevent);
@@ -759,6 +778,10 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 error_free_info:
 	kfree(open_info);
+error_free_irq:
+	irq_update_affinity_hint(newchannel->irq, NULL);
+	free_irq(newchannel->irq, newchannel);
+	newchannel->irq_requested = false;
 error_free_gpadl:
 	vmbus_teardown_gpadl(newchannel, &newchannel->ringbuffer_gpadlhandle);
 error_clean_ring:
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9c452bfbd571..38a23add721c 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -610,7 +610,7 @@ bool __weak hv_isolation_type_tdx(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
 
-void __weak hv_setup_vmbus_handler(void (*handler)(void))
+void __weak hv_setup_vmbus_handler(bool (*handler)(void))
 {
 }
 EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8fd03d41e71a..b73be7c02d37 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1193,6 +1193,45 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+irqreturn_t vmbus_chan_handler(int irq, void *dev_id)
+{
+	void (*callback_fn)(void *context);
+	struct vmbus_channel *channel = dev_id;
+
+	/*
+	 * Make sure that the ring buffer data structure doesn't get
+	 * freed while we dereference the ring buffer pointer.  Test
+	 * for the channel's onchannel_callback being NULL within a
+	 * sched_lock critical section.  See also the inline comments
+	 * in vmbus_reset_channel_cb().
+	 */
+	spin_lock(&channel->sched_lock);
+
+	callback_fn = channel->onchannel_callback;
+	if (unlikely(callback_fn == NULL))
+		goto spin_unlock;
+
+	trace_vmbus_chan_sched(channel);
+
+	++channel->interrupts;
+
+	switch (channel->callback_mode) {
+	case HV_CALL_ISR:
+		(*callback_fn)(channel->channel_callback_context);
+		break;
+
+	case HV_CALL_BATCHED:
+		hv_begin_read(&channel->inbound);
+		fallthrough;
+	case HV_CALL_DIRECT:
+		tasklet_schedule(&channel->callback_event);
+	}
+
+spin_unlock:
+	spin_unlock(&channel->sched_lock);
+	return IRQ_HANDLED;
+}
+
 /*
  * Schedule all channels with events pending
  */
@@ -1217,7 +1256,6 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		return;
 
 	for_each_set_bit(relid, recv_int_page, maxbits) {
-		void (*callback_fn)(void *context);
 		struct vmbus_channel *channel;
 		struct irq_desc *desc;
 
@@ -1244,43 +1282,14 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		if (channel->rescind)
 			goto sched_unlock_rcu;
 
-		/*
-		 * Make sure that the ring buffer data structure doesn't get
-		 * freed while we dereference the ring buffer pointer.  Test
-		 * for the channel's onchannel_callback being NULL within a
-		 * sched_lock critical section.  See also the inline comments
-		 * in vmbus_reset_channel_cb().
-		 */
-		spin_lock(&channel->sched_lock);
-
-		callback_fn = channel->onchannel_callback;
-		if (unlikely(callback_fn == NULL))
-			goto sched_unlock;
-
-		trace_vmbus_chan_sched(channel);
-
-		++channel->interrupts;
-
-		switch (channel->callback_mode) {
-		case HV_CALL_ISR:
-			(*callback_fn)(channel->channel_callback_context);
-			break;
-
-		case HV_CALL_BATCHED:
-			hv_begin_read(&channel->inbound);
-			fallthrough;
-		case HV_CALL_DIRECT:
-			tasklet_schedule(&channel->callback_event);
-		}
+		generic_handle_irq_desc(desc);
 
-sched_unlock:
-		spin_unlock(&channel->sched_lock);
 sched_unlock_rcu:
 		rcu_read_unlock();
 	}
 }
 
-static void vmbus_isr(void)
+static bool vmbus_isr(void)
 {
 	struct hv_per_cpu_context *hv_cpu
 		= this_cpu_ptr(hv_context.cpu_context);
@@ -1299,15 +1308,18 @@ static void vmbus_isr(void)
 			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
 		} else
 			tasklet_schedule(&hv_cpu->msg_dpc);
-	}
 
-	add_interrupt_randomness(vmbus_interrupt);
+		add_interrupt_randomness(vmbus_interrupt);
+		return true;
+	}
+	return false;
 }
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 {
-	vmbus_isr();
-	return IRQ_HANDLED;
+	if (vmbus_isr())
+		return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 int vmbus_irq_set_affinity(struct irq_data *data,
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 0488ff8b511f..0a5559b9d5f7 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -178,7 +178,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
 
-void hv_setup_vmbus_handler(void (*handler)(void));
+void hv_setup_vmbus_handler(bool (*handler)(void));
 void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
 void hv_remove_stimer0_handler(void);
@@ -188,6 +188,7 @@ void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
 
+extern irqreturn_t vmbus_chan_handler(int irq, void *dev_id);
 extern void vmbus_irq_mask(struct irq_data *data);
 extern void vmbus_irq_unmask(struct irq_data *data);
 extern int vmbus_irq_set_affinity(struct irq_data *data,
-- 
2.25.1


