Return-Path: <linux-arch+bounces-12771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E811AB04A59
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DEE7AF035
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED81F287519;
	Mon, 14 Jul 2025 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p1J/Gi1I"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712E279DB3;
	Mon, 14 Jul 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531355; cv=none; b=ZW4UiQUp5deKHXZY7foRRhOhkUPZZj2FO6OuXOpwOpYA3rnxiPqLCnyemJGD39CiGFI1D92gZKn4r05VwsvTGMa2F7apyDUMgB/4cIw01uuv53lTWJ9TWiXPq90s9A8g5zC/rJgneO/C3mfCbR6vI2dEPuQEgHkSaqmvZrAMCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531355; c=relaxed/simple;
	bh=L0cEdguqIHIbUbQ6E6fS4wlEd7bciMBnSjOWK4P7KKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBem2szFVMOJfGu/aW8b5U4uzD7wWQU/nH7ka9X2FssWe40eAnFrEZRg2ZbRDt6evgUGGt98BwG6dnG3/02Y2wz0ovxtzoRzpMAehLkXA2SqHrbO4Kw3bIvaabY50ExKQ+jHay4jgL2LeCYt77mcEzdZAD8gct5e5IIaA5iC58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p1J/Gi1I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A502201B1CD;
	Mon, 14 Jul 2025 15:15:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A502201B1CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531351;
	bh=W8J2zGpFifnp+H2iTJGi0AjmiMmoEjxacsnTVf87d8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1J/Gi1IiywwemzamVJgSiFSarmYRsnA0lhfkUz2tcQ6qCnBETzKplaL9gRtwB5Z1
	 V6m+bU89LbA6d7fnsGpvzi9u6tJiwvg6gs9ecnIyZ2AR39dxCtB6qJU0nqo/7AT5+F
	 Q9M/9MGY7HovikLqcYri45wal+BMfOfvgmJZgAwQ=
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
	mhklinux@outlook.com,
	mingo@redhat.com,
	rdunlap@infradead.org,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 15/16] Drivers: hv: Support establishing the confidential VMBus connection
Date: Mon, 14 Jul 2025 15:15:44 -0700
Message-ID: <20250714221545.5615-16-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714221545.5615-1-romank@linux.microsoft.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
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
 drivers/hv/vmbus_drv.c | 189 ++++++++++++++++++++++++++++-------------
 1 file changed, 130 insertions(+), 59 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 13aca5abc7d8..53be3157e22c 100644
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
@@ -1401,41 +1474,42 @@ static int vmbus_bus_init(void)
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
+	 *
+	 * All scenarios here are:
+	 *	1. No paravisor,
+	 *  2. Paravisor without VMBus relay, no hardware isolation,
+	 *  3. Paravisor without VMBus relay, with hardware isolation,
+	 *  4. Paravisor with VMBus relay, no hardware isolation,
+	 *  5. Paravisor with VMBus relay, with hardware isolation.
+	 *
+	 * In the cloud, scenarios 1, 4, 5 are most common, and outside the cloud,
+	 * scenario 1 should be the most common at the moment. Detecting of the Confidential
+	 * VMBus support below takes that into account running `vmbus_alloc_synic_and_connect()`
+	 * only once (barring any faults not related to VMBus) in these cases. That is true
+	 * for the scenario 2, too, albeit it might be not as feature-rich as 1, 4, 5.
+	 *
+	 * However, the code will be doing much more work in scenario 3 where it will have to
+	 * first initialize lots of structures for every CPU only to likely tear them down later
+	 * and start again, now without attempting to use Confidential VMBus, thus taking a
+	 * performance hit. Such systems are rather uncomoon today, don't support more than
+	 * ~300 CPUs, and are rarely used with many dozens of CPUs. As the time goes on, that
+	 * will be even less common. Hence, the preference is to not specialize the code for
+	 * that scenario.
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
 
@@ -1451,9 +1525,6 @@ static int vmbus_bus_init(void)
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


