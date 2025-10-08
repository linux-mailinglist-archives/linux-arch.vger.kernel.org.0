Return-Path: <linux-arch+bounces-13980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 958C3BC6EC5
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39CFB4EE4C9
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B72E03FD;
	Wed,  8 Oct 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ow/Hqhvk"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9362DF122;
	Wed,  8 Oct 2025 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966481; cv=none; b=h7o3fUxjd5XEyeQO/y2E1PLTgqhJmBB/NEuSAxtf2ErEt1PBRK1yyaK4tf8tyDEV5gqdeb2O9LjaY5SQqmiku2PNNn4LYQ4pD4gFgDDaqmJSd3nFPMERE8QTWoyu1kV9AKqZz8HIUkm0kfwTYGWhTfpvIxGu3hTT/M96AnUWTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966481; c=relaxed/simple;
	bh=vi21MmW6hNpvJW+ahdrYgZwj9la5FUVN0ykIg2JgtSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvVDx8go+yNkJH7ETDMKOCzBQj7nl2O3W9vbpdWI3pXeapOJ6ta11II+CLLJacPOaPpKdmnC43Mrrc6JsOFy1TEPmqVTA2Rv38XJ/feWGMkMaNAAoHiy92RQBNayAsNtD4FwSs1Z3h9xeXJdeDdTpnDZHBFk6fac7Zcz3wCvg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ow/Hqhvk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C36542038B7D;
	Wed,  8 Oct 2025 16:34:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C36542038B7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966478;
	bh=sMrXYp/LXKrQSONphfvQVUtB/mFfprwjOJ4nPGwda+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ow/HqhvksHQjgko5K5FA9sPjLUB7SqWztICnGEWjfjz3ajzEiWLL/Jg/D7pBZ7b3K
	 qs52QwuEX/FXRd0ilewiq6CH1gqNc4muwOsInw3jnW0tre51dxWKpseqmNagFpd981
	 458xpwO0EcFWf59tu9GttWvDnuZwAYnlAKv0KbAg=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	bagasdotme@gmail.com,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mikelley@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v7 17/17] Drivers: hv: Support establishing the confidential VMBus connection
Date: Wed,  8 Oct 2025 16:34:19 -0700
Message-ID: <20251008233419.20372-18-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008233419.20372-1-romank@linux.microsoft.com>
References: <20251008233419.20372-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To establish the confidential VMBus connection the CoCo VM, the guest
first checks on the confidential VMBus availability, and then proceeds
to initializing the communication stack.

Implement that in the VMBus driver initialization.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 168 ++++++++++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 62 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2b5bf672c467..0dc4692b411a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1057,12 +1057,9 @@ static void vmbus_onmessage_work(struct work_struct *work)
 	kfree(ctx);
 }
 
-void vmbus_on_msg_dpc(unsigned long data)
+static void __vmbus_on_msg_dpc(void *message_page_addr)
 {
-	struct hv_per_cpu_context *hv_cpu = (void *)data;
-	void *page_addr = hv_cpu->hyp_synic_message_page;
-	struct hv_message msg_copy, *msg = (struct hv_message *)page_addr +
-				  VMBUS_MESSAGE_SINT;
+	struct hv_message msg_copy, *msg;
 	struct vmbus_channel_message_header *hdr;
 	enum vmbus_channel_message_type msgtype;
 	const struct vmbus_channel_message_table_entry *entry;
@@ -1070,6 +1067,10 @@ void vmbus_on_msg_dpc(unsigned long data)
 	__u8 payload_size;
 	u32 message_type;
 
+	if (!message_page_addr)
+		return;
+	msg = (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
+
 	/*
 	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
 	 * it is being used in 'struct vmbus_channel_message_header' definition
@@ -1195,6 +1196,14 @@ void vmbus_on_msg_dpc(unsigned long data)
 	vmbus_signal_eom(msg, message_type);
 }
 
+void vmbus_on_msg_dpc(unsigned long data)
+{
+	struct hv_per_cpu_context *hv_cpu = (void *)data;
+
+	__vmbus_on_msg_dpc(hv_cpu->hyp_synic_message_page);
+	__vmbus_on_msg_dpc(hv_cpu->para_synic_message_page);
+}
+
 #ifdef CONFIG_PM_SLEEP
 /*
  * Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force for
@@ -1233,21 +1242,19 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 #endif /* CONFIG_PM_SLEEP */
 
 /*
- * Schedule all channels with events pending
+ * Schedule all channels with events pending.
+ * The event page can be directly checked to get the id of
+ * the channel that has the interrupt pending.
  */
-static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
+static void vmbus_chan_sched(void *event_page_addr)
 {
 	unsigned long *recv_int_page;
 	u32 maxbits, relid;
+	union hv_synic_event_flags *event;
 
-	/*
-	 * The event page can be directly checked to get the id of
-	 * the channel that has the interrupt pending.
-	 */
-	void *page_addr = hv_cpu->hyp_synic_event_page;
-	union hv_synic_event_flags *event
-		= (union hv_synic_event_flags *)page_addr +
-					 VMBUS_MESSAGE_SINT;
+	if (!event_page_addr)
+		return;
+	event = (union hv_synic_event_flags *)event_page_addr + VMBUS_MESSAGE_SINT;
 
 	maxbits = HV_EVENT_FLAGS_COUNT;
 	recv_int_page = event->flags;
@@ -1255,6 +1262,11 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	if (unlikely(!recv_int_page))
 		return;
 
+	/*
+	 * Suggested-by: Michael Kelley <mhklinux@outlook.com>
+	 * One possible optimization would be to keep track of the largest relID that's in use,
+	 * and only scan up to that relID.
+	 */
 	for_each_set_bit(relid, recv_int_page, maxbits) {
 		void (*callback_fn)(void *context);
 		struct vmbus_channel *channel;
@@ -1318,26 +1330,35 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	}
 }
 
-static void vmbus_isr(void)
+static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void *message_page_addr)
 {
-	struct hv_per_cpu_context *hv_cpu
-		= this_cpu_ptr(hv_context.cpu_context);
-	void *page_addr;
 	struct hv_message *msg;
 
-	vmbus_chan_sched(hv_cpu);
-
-	page_addr = hv_cpu->hyp_synic_message_page;
-	msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
+	if (!message_page_addr)
+		return;
+	msg = (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
 
 	/* Check if there are actual msgs to be processed */
 	if (msg->header.message_type != HVMSG_NONE) {
 		if (msg->header.message_type == HVMSG_TIMER_EXPIRED) {
 			hv_stimer0_isr();
 			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
-		} else
+		} else {
 			tasklet_schedule(&hv_cpu->msg_dpc);
+		}
 	}
+}
+
+static void vmbus_isr(void)
+{
+	struct hv_per_cpu_context *hv_cpu
+		= this_cpu_ptr(hv_context.cpu_context);
+
+	vmbus_chan_sched(hv_cpu->hyp_synic_event_page);
+	vmbus_chan_sched(hv_cpu->para_synic_event_page);
+
+	vmbus_message_sched(hv_cpu, hv_cpu->hyp_synic_message_page);
+	vmbus_message_sched(hv_cpu, hv_cpu->para_synic_message_page);
 
 	add_interrupt_randomness(vmbus_interrupt);
 }
@@ -1355,6 +1376,59 @@ static void vmbus_percpu_work(struct work_struct *work)
 	hv_synic_init(cpu);
 }
 
+static int vmbus_alloc_synic_and_connect(void)
+{
+	int ret, cpu;
+	struct work_struct __percpu *works;
+	int hyperv_cpuhp_online;
+
+	ret = hv_synic_alloc();
+	if (ret < 0)
+		goto err_alloc;
+
+	works = alloc_percpu(struct work_struct);
+	if (!works) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	/*
+	 * Initialize the per-cpu interrupt state and stimer state.
+	 * Then connect to the host.
+	 */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, vmbus_percpu_work);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_online_cpu(cpu)
+		flush_work(per_cpu_ptr(works, cpu));
+
+	/* Register the callbacks for possible CPU online/offline'ing */
+	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
+						   hv_synic_init, hv_synic_cleanup);
+	cpus_read_unlock();
+	free_percpu(works);
+	if (ret < 0)
+		goto err_alloc;
+	hyperv_cpuhp_online = ret;
+
+	ret = vmbus_connect();
+	if (ret)
+		goto err_connect;
+	return 0;
+
+err_connect:
+	cpuhp_remove_state(hyperv_cpuhp_online);
+	return -ENODEV;
+err_alloc:
+	hv_synic_free();
+	return -ENOMEM;
+}
+
 /*
  * vmbus_bus_init -Main vmbus driver initialization routine.
  *
@@ -1365,8 +1439,7 @@ static void vmbus_percpu_work(struct work_struct *work)
  */
 static int vmbus_bus_init(void)
 {
-	int ret, cpu;
-	struct work_struct __percpu *works;
+	int ret;
 
 	ret = hv_init();
 	if (ret != 0) {
@@ -1401,41 +1474,15 @@ static int vmbus_bus_init(void)
 		}
 	}
 
-	ret = hv_synic_alloc();
-	if (ret)
-		goto err_alloc;
-
-	works = alloc_percpu(struct work_struct);
-	if (!works) {
-		ret = -ENOMEM;
-		goto err_alloc;
-	}
-
 	/*
-	 * Initialize the per-cpu interrupt state and stimer state.
-	 * Then connect to the host.
+	 * Cache the value as getting it involves a VM exit on x86(_64), and
+	 * doing that on each VP while initializing SynIC's wastes time.
 	 */
-	cpus_read_lock();
-	for_each_online_cpu(cpu) {
-		struct work_struct *work = per_cpu_ptr(works, cpu);
-
-		INIT_WORK(work, vmbus_percpu_work);
-		schedule_work_on(cpu, work);
-	}
-
-	for_each_online_cpu(cpu)
-		flush_work(per_cpu_ptr(works, cpu));
-
-	/* Register the callbacks for possible CPU online/offline'ing */
-	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
-						   hv_synic_init, hv_synic_cleanup);
-	cpus_read_unlock();
-	free_percpu(works);
-	if (ret < 0)
-		goto err_alloc;
-	hyperv_cpuhp_online = ret;
-
-	ret = vmbus_connect();
+	is_confidential = ms_hyperv.confidential_vmbus_available;
+	if (is_confidential)
+		pr_info("Establishing connection to the confidential VMBus\n");
+	hv_para_set_sint_proxy(!is_confidential);
+	ret = vmbus_alloc_synic_and_connect();
 	if (ret)
 		goto err_connect;
 
@@ -1451,9 +1498,6 @@ static int vmbus_bus_init(void)
 	return 0;
 
 err_connect:
-	cpuhp_remove_state(hyperv_cpuhp_online);
-err_alloc:
-	hv_synic_free();
 	if (vmbus_irq == -1) {
 		hv_remove_vmbus_handler();
 	} else {
-- 
2.43.0


