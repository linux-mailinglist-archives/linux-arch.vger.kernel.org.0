Return-Path: <linux-arch+bounces-12201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338ACACD0F0
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55551898D51
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDB15B0EF;
	Wed,  4 Jun 2025 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pHgo33vJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934D4D599;
	Wed,  4 Jun 2025 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997830; cv=none; b=TWQs+ZKbIWi7YXyfsJpsu8u7aJslymIeZDgxBmHpMiXyDTVHvfsAC4SNshSkwApRUx0hPx7moDkWQNkhRiJJqNO+b9lkYeFQ4xd+CGnbG/TWmKu5Jk1Xavlptg7XYWU/Py03RB6rwHqbwnatCkyFHfuMiug2+6LjNUsO228ABf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997830; c=relaxed/simple;
	bh=ZnAPNrGK35dWIknC1WFEbFSVhJEYFVuM7Dw2GuY9DWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxdSpi264/ADBXEa6pbAsvcwnKilwHXslVUYTtgsyR+Rspup24/qbNbuZs3x6kXVgKndDsq3v1OaXDQkOddp7i0DwgtzHd7eglElEimzCAEf3xrVibCz07c/6UkCkDOXQJBvUz5OmaaurJO/xME+C/v0S2ngxcMB7AtAHHBVDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pHgo33vJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD74D211744F;
	Tue,  3 Jun 2025 17:43:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD74D211744F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997828;
	bh=G4bFX/AkEXixqQTmxNm11dgAqyCUyPe6SpQCUFK0Rb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHgo33vJjcgxZVVIYCl47eqX8NQTORBvhhZ1iokSfkx9r6yttX3BEdR7CFWkYIjOI
	 yf/wUJoWyFvYtl93bslUGYJM6belX0eU4OYwq8QagVDme0Ujrb/PPTP80pbNd0eLZN
	 ElTPFw+WTPEto9YEvpJUthaK7WM7nB88R/AdHXno=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 14/15] Drivers: hv: Support establishing the confidential VMBus connection
Date: Tue,  3 Jun 2025 17:43:40 -0700
Message-ID: <20250604004341.7194-15-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604004341.7194-1-romank@linux.microsoft.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To establish the confidential VMBus connection the CoCo VM guest
first attempts to connect to the VMBus server run by the paravisor.
If that fails, the guest falls back to the non-confidential VMBus.

Implement that in the VMBus driver initialization.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 169 +++++++++++++++++++++++++++--------------
 1 file changed, 110 insertions(+), 59 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index f7e82a4fe133..88701c3ad999 100644
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
+static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu, void *event_page_addr)
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
@@ -1318,26 +1325,40 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
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
+	/*
+	 * Suggested-by: Michael Kelley <mhklinux@outlook.com>
+	 * One possible optimization would be to keep track of the largest relID that's in use,
+	 * and only scan up to that relID.
+	 */
+	vmbus_chan_sched(hv_cpu, hv_cpu->hyp_synic_event_page);
+	vmbus_chan_sched(hv_cpu, hv_cpu->para_synic_event_page);
+
+	vmbus_message_sched(hv_cpu, hv_cpu->hyp_synic_message_page);
+	vmbus_message_sched(hv_cpu, hv_cpu->para_synic_message_page);
 
 	add_interrupt_randomness(vmbus_interrupt);
 }
@@ -1355,6 +1376,60 @@ static void vmbus_percpu_work(struct work_struct *work)
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
@@ -1365,8 +1440,7 @@ static void vmbus_percpu_work(struct work_struct *work)
  */
 static int vmbus_bus_init(void)
 {
-	int ret, cpu;
-	struct work_struct __percpu *works;
+	int ret;
 
 	ret = hv_init();
 	if (ret != 0) {
@@ -1401,41 +1475,21 @@ static int vmbus_bus_init(void)
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
+	 * Attempt to establish the confidential VMBus connection first if this VM is
+	 * a hardware confidential VM, and the paravisor is present.
 	 */
-	cpus_read_lock();
-	for_each_online_cpu(cpu) {
-		struct work_struct *work = per_cpu_ptr(works, cpu);
+	ret = -ENODEV;
+	if (ms_hyperv.paravisor_present && (hv_isolation_type_tdx() || hv_isolation_type_snp())) {
+		is_confidential = true;
+		ret = vmbus_alloc_synic_and_connect();
+		is_confidential = !ret;
 
-		INIT_WORK(work, vmbus_percpu_work);
-		schedule_work_on(cpu, work);
+		pr_info("VMBus is confidential: %d\n", is_confidential);
 	}
 
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
+	if (!is_confidential)
+		ret = vmbus_alloc_synic_and_connect();
 	if (ret)
 		goto err_connect;
 
@@ -1451,9 +1505,6 @@ static int vmbus_bus_init(void)
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


