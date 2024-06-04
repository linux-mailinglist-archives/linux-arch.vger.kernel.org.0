Return-Path: <linux-arch+bounces-4666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C11C8FA9AB
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FD428E21C
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BDA142649;
	Tue,  4 Jun 2024 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdyYF/Yv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EAD1422A4;
	Tue,  4 Jun 2024 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477849; cv=none; b=mNLb4SFJxhTwXFfp3q+SoQNd7ANITME+4kqLiR2fJVrHOwzywPOsyjbfCQgTWuIhB9kgtixC+EM/f697+cyJuc8UQ8/msPN+FF4mgAtIhdEypeGeRIiqKsGmpDutB1goy9lg0k7gqLABYVUtc7elWhzJO/usx6m1zUVUc46Cx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477849; c=relaxed/simple;
	bh=E+4d26O9KX6W8V3kSd+4KV+3CKb0TWbekzCJh1k17NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAv6RgETfpKYTjKofV2NiYsqJbMs3T8jqFw2JTQiHNkBc2wE2AQV4vPPXKeMhZdL4n+O8lqsVM/05ijlubn4BfRVH0iY2IjHMbQEdPbuYVHRwR+k5iCdPDYB8do3BTQ/2z+3OQEhi1BmPUbZM2TxH6qT1BZ8Sgeb04CScBIPcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdyYF/Yv; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3cb353c73ccso2791596b6e.0;
        Mon, 03 Jun 2024 22:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477846; x=1718082646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gzkdr7jopxvyXBA+TIdPtuUwB5jzrxlcbv3cbqedfWg=;
        b=UdyYF/YvBpgG4j/fPyBb4GGtY2M6fwGXUhHI2rSbEynifPSdrV09z9jDmRNRezjcwe
         HhOjUSqCSJ4kQyaLpzCrQx+5vUWb6voaNdYq5Ck9NsG+8ZWne2B4SrKKIGcx7BCtbg9a
         33CgVl7EWZfwj93HW3ijQ8STgz7P2am8qpws4gkwzDVB5hVSL+gax/mqvljoWOa7Qkal
         TJyrTPD91q3Hh46yplik0FCWdxIHtBqPuXnNNr0u5UjNuWgywP2EWVCj6j2Bwj658ZZg
         cfZGvSmtHAhx6Hw7bRVXSwR0q6FDSsZEExFEqo2JFrnsKwjm3UcZrjkO0gV32io8yXQg
         /4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477846; x=1718082646;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gzkdr7jopxvyXBA+TIdPtuUwB5jzrxlcbv3cbqedfWg=;
        b=jUlaGX2/wTdx7CJYg1g48B0P53xEP3/truZGj5pIMLN5kJ+dhAorvw1QRKdCNW2kp9
         HJwGYERyLysWkB3s214GxdjA6BFqgGK0Sm+c6DXBiIvjW5OWIhVB4k9MQ1XRR3tdbXl7
         4YTMY7D9ZIRUba665hmONjIMtHybia4hLggeqSYCvvEqfE0WcbnI+HRPAfSEtMwbMbkL
         i8QDDo6yAVYFRL4F3Ts1KkquarisxhoazK2SdGL2bOuyVyNmros5VANyOYfJMevMQW/L
         XSF3M0BW6cqtZMKnjiPkK98YMxhoUyC/+okp5sk0zwyyclhd6h94OGVGbAiPyS4Nzyw1
         u5AA==
X-Forwarded-Encrypted: i=1; AJvYcCXShpcAoHz30GIifiAbxbGPZHEnlj3aHQScS08PHC8AvRcW3RIiW8LoIQ4vfgOFZBjegZyJl7QeEzOh+VgBRLhtdQJv2Jzj7zJRzKmx9bU6RSm4L/Bf7w0zn4NSgl8nYb5U5dPBRARC2dS9/DrV7hvtDUu8LSEcfCunpeEwk1khuX+VQXoDqrPfODJz5JGCyU7hAKL1cTwKbTqzMhhuqPn3ESNk9+ly6jYvRiSaF4tTN+VcKMQjs75BvjnrZbA=
X-Gm-Message-State: AOJu0YxQNMa2Km1K8i++bbGV/MmixZ4y1PevQhfr6bpOc6x0KQGHlYyu
	/b9Jc74T7YEnDFnAdzfc4fBe4Ly6wf1r+Ur19LUAlAmanRpKpVvp
X-Google-Smtp-Source: AGHT+IGHyfvHrRKqIbyeaMIfOflT83+zkAgXQUpgUOT1FSxBpckU8L78mwisaPyDCpXnNI4EaDnmQw==
X-Received: by 2002:a05:6808:1925:b0:3d1:ff8e:a5b6 with SMTP id 5614622812f47-3d1ff8ea68dmr275682b6e.15.1717477846375;
        Mon, 03 Jun 2024 22:10:46 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:46 -0700 (PDT)
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
Subject: [RFC 08/12] Drivers: hv: vmbus: Allocate an IRQ per channel and use for relid mapping
Date: Mon,  3 Jun 2024 22:09:36 -0700
Message-Id: <20240604050940.859909-9-mhklinux@outlook.com>
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

Current code uses the "channels" array in the VMBus connection to map from
relid to VMBus channel. Functions exist to establish and remove mappings,
and to map from a relid to its channel.

To implement assigning Linux IRQs to VMBus channels, repurpose the existing
relid functions. Change the "map" function to create an IRQ mapping in the
VMBus IRQ domain, and set the handler data for the IRQ to be the VMBus
channel. Change the "unmap" function to remove the IRQ mapping after
freeing the IRQ if it has been requested. Change the relid2channel()
function to look up the mapping and return both the channel and the
corresponding irqdesc.

While Linux IRQs are allocated for each channel, they are used only for
relid mapping. A subsequent patch changes the interrupt handling path
to use the Linux IRQ.

With these changes, the "channels" array in the VMBus connection is no
longer used. Remove it. Also fixup comments that refer to the channels
array and make them refer to the IRQ mapping instead.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel_mgmt.c | 52 ++++++++++++++++++++++++++++-----------
 drivers/hv/connection.c   | 23 ++++++-----------
 drivers/hv/hyperv_vmbus.h |  5 +---
 drivers/hv/vmbus_drv.c    |  8 +++---
 include/linux/hyperv.h    |  3 +++
 5 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index adbe184e5197..da42aaae994e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -10,6 +10,9 @@
 
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
@@ -410,7 +413,10 @@ static void free_channel(struct vmbus_channel *channel)
 
 void vmbus_channel_map_relid(struct vmbus_channel *channel)
 {
-	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
+	int res;
+	u32 relid = channel->offermsg.child_relid;
+
+	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
 		return;
 	/*
 	 * The mapping of the channel's relid is visible from the CPUs that
@@ -437,18 +443,33 @@ void vmbus_channel_map_relid(struct vmbus_channel *channel)
 	 *      of the VMBus driver and vmbus_chan_sched() can not run before
 	 *      vmbus_bus_resume() has completed execution (cf. resume_noirq).
 	 */
-	virt_store_mb(
-		vmbus_connection.channels[channel->offermsg.child_relid],
-		channel);
+
+	channel->irq = irq_create_mapping(vmbus_connection.vmbus_irq_domain, relid);
+	if (!channel->irq) {
+		pr_err("irq_create_mapping failed for relid %d\n", relid);
+		return;
+	}
+
+	res = irq_set_handler_data(channel->irq, channel);
+	if (res) {
+		irq_dispose_mapping(channel->irq);
+		channel->irq = 0;
+		pr_err("irq_set_handler_data failed with %d for relid %d\n",
+				res, relid);
+		return;
+	}
+
+	irq_set_status_flags(channel->irq, IRQ_MOVE_PCNTXT);
 }
 
 void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
 {
-	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
-		return;
-	WRITE_ONCE(
-		vmbus_connection.channels[channel->offermsg.child_relid],
-		NULL);
+	if (channel->irq_requested) {
+		irq_update_affinity_hint(channel->irq, NULL);
+		free_irq(channel->irq, channel);
+	}
+	channel->irq_requested = false;
+	irq_dispose_mapping(channel->irq);
 }
 
 static void vmbus_release_relid(u32 relid)
@@ -478,10 +499,10 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 		!is_hvsock_channel(channel));
 
 	/*
-	 * Upon suspend, an in-use hv_sock channel is removed from the array of
-	 * channels and the relid is invalidated.  After hibernation, when the
+	 * Upon suspend, an in-use hv_sock channel is removed from the IRQ
+	 * map and the relid is invalidated. After hibernation, when the
 	 * user-space application destroys the channel, it's unnecessary and
-	 * unsafe to remove the channel from the array of channels.  See also
+	 * unsafe to remove the channel from the IRQ map. See also
 	 * the inline comments before the call of vmbus_release_relid() below.
 	 */
 	if (channel->offermsg.child_relid != INVALID_RELID)
@@ -533,6 +554,9 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	struct vmbus_channel *primary_channel = newchannel->primary_channel;
 	int ret;
 
+	if (!newchannel->irq)
+		goto err_deq_chan;
+
 	/*
 	 * This state is used to indicate a successful open
 	 * so that when we do close the channel normally, we
@@ -1144,7 +1168,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 			vmbus_setup_channel_state(oldchannel, offer);
 		}
 
-		/* Add the channel back to the array of channels. */
+		/* Re-establish the channel's IRQ mapping using the new relid */
 		vmbus_channel_map_relid(oldchannel);
 		check_ready_for_resume_event();
 
@@ -1225,7 +1249,7 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
 	}
 
 	mutex_lock(&vmbus_connection.channel_mutex);
-	channel = relid2channel(rescind->child_relid);
+	channel = relid2channel(rescind->child_relid, NULL);
 	if (channel != NULL) {
 		/*
 		 * Guarantee that no other instance of vmbus_onoffer_rescind()
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index cb01784e5c3b..a105eecdeec2 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -308,14 +308,6 @@ int vmbus_connect(void)
 	pr_info("Vmbus version:%d.%d\n",
 		version >> 16, version & 0xFFFF);
 
-	vmbus_connection.channels = kcalloc(MAX_CHANNEL_RELIDS,
-					    sizeof(struct vmbus_channel *),
-					    GFP_KERNEL);
-	if (vmbus_connection.channels == NULL) {
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-
 	kfree(msginfo);
 	return 0;
 
@@ -373,15 +365,16 @@ void vmbus_disconnect(void)
  * relid2channel - Get the channel object given its
  * child relative id (ie channel id)
  */
-struct vmbus_channel *relid2channel(u32 relid)
+struct vmbus_channel *relid2channel(u32 relid, struct irq_desc **desc_ptr)
 {
-	if (vmbus_connection.channels == NULL) {
-		pr_warn_once("relid2channel: relid=%d: No channels mapped!\n", relid);
-		return NULL;
-	}
-	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
+	struct irq_desc *desc;
+
+	desc = irq_resolve_mapping(vmbus_connection.vmbus_irq_domain, relid);
+	if (!desc)
 		return NULL;
-	return READ_ONCE(vmbus_connection.channels[relid]);
+	if (desc_ptr)
+		*desc_ptr = desc;
+	return irq_desc_get_handler_data(desc);
 }
 
 /*
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 95d4d47d34f7..bf35bb40c55e 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -259,9 +259,6 @@ struct vmbus_connection {
 	struct list_head chn_list;
 	struct mutex channel_mutex;
 
-	/* Array of channels */
-	struct vmbus_channel **channels;
-
 	/* IRQ domain data */
 	struct fwnode_handle *vmbus_fwnode;
 	struct irq_domain *vmbus_irq_domain;
@@ -364,7 +361,7 @@ void vmbus_remove_channel_attr_group(struct vmbus_channel *channel);
 void vmbus_channel_map_relid(struct vmbus_channel *channel);
 void vmbus_channel_unmap_relid(struct vmbus_channel *channel);
 
-struct vmbus_channel *relid2channel(u32 relid);
+struct vmbus_channel *relid2channel(u32 relid, struct irq_desc **desc);
 
 void vmbus_free_channels(void);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index cbccdfad49a2..8fd03d41e71a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1219,6 +1219,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	for_each_set_bit(relid, recv_int_page, maxbits) {
 		void (*callback_fn)(void *context);
 		struct vmbus_channel *channel;
+		struct irq_desc *desc;
 
 		if (!sync_test_and_clear_bit(relid, recv_int_page))
 			continue;
@@ -1236,7 +1237,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		rcu_read_lock();
 
 		/* Find channel based on relid */
-		channel = relid2channel(relid);
+		channel = relid2channel(relid, &desc);
 		if (channel == NULL)
 			goto sched_unlock_rcu;
 
@@ -2466,10 +2467,10 @@ static int vmbus_bus_suspend(struct device *dev)
 
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
 		/*
-		 * Remove the channel from the array of channels and invalidate
+		 * Remove the channel from the IRQ map and invalidate
 		 * the channel's relid.  Upon resume, vmbus_onoffer() will fix
 		 * up the relid (and other fields, if necessary) and add the
-		 * channel back to the array.
+		 * channel back to the IRQ map.
 		 */
 		vmbus_channel_unmap_relid(channel);
 		channel->offermsg.child_relid = INVALID_RELID;
@@ -2748,7 +2749,6 @@ static void __exit vmbus_exit(void)
 	vmbus_free_channels();
 	irq_domain_remove(vmbus_connection.vmbus_irq_domain);
 	irq_domain_free_fwnode(vmbus_connection.vmbus_fwnode);
-	kfree(vmbus_connection.channels);
 
 	/*
 	 * The vmbus panic notifier is always registered, hence we should
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 897d96fa19d4..d545b1b635e5 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1072,6 +1072,9 @@ struct vmbus_channel {
 	/* The max size of a packet on this channel */
 	u32 max_pkt_size;
 
+	/* The Linux IRQ for the channel in the "hv-vmbus" IRQ domain */
+	u32 irq;
+	bool irq_requested;
 	char irq_name[VMBUS_CHAN_IRQ_NAME_MAX];
 };
 
-- 
2.25.1


