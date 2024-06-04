Return-Path: <linux-arch+bounces-4668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C18FA9B6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE94F1C22B9A
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1738142E6A;
	Tue,  4 Jun 2024 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvo2xr0W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12B1428EE;
	Tue,  4 Jun 2024 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477851; cv=none; b=Qhn2dV5LPKaCOCvH4P/KlCLA1mzCVVT5AKzWlCLxwO0CoxMkAGY41nOQnfw1RrmpWKOAALr4nz3tRp76ONG30K3QmCEUg/+fKznhJQKehLn99KGRI+8H7L9ygJJOkkvZNVckRroI6Ao5nb1miQX0LI4bNc1L03tWwoEZDRD16aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477851; c=relaxed/simple;
	bh=XhjKDttjU9NrAh+Qpdc7TFdMquWNr+zfZHtc1ueQnWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3i7/u3TgHEfBH1FMPqv3IfhYYWMbBI7/2FXj5SSRIRQDlpA/r6uN/FPhfNKGsnmblYpvYrW6X9mfK+c1qw869qdYxUliHWrUF2qNZLdRtbJnp3KPHOjwmKHCzYAcT5DG7P+Jjp6QZgTWxIJ/KZj1zOp9CH+soX/nBoli/dQkmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dvo2xr0W; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7024791a950so2443584b3a.0;
        Mon, 03 Jun 2024 22:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477849; x=1718082649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EwYlTiV6Rt4HKzKI2WcesBOG37oKFHVkVyKg4Lxmmlw=;
        b=Dvo2xr0WiYXxz25sKGb4Zj1hYJQDudlvVceFETSzX99/OMZhQGYh9aOAkg+sUFrNIi
         rlOOeyBfkD07cXdMvqNFE1Ucno2Hv5Mu8KSrqSkyK+T5HkTLbMHyTImoTjKun6QpdcNn
         +nHQwj75dmSNQIq16MOParA6BtLfDVeatvoR6J7efa7zvmvLvVJ97lpY8ap7GAwKXF6K
         dT7cemYfXc6U9S/ICQOUgOPbkCNF7A44FpHCBFLWKW7JWWtfzM8sYIU21V9cCpaGUqx6
         bZ1XZ30r33ucXDUrwmuEaczZ1JmgRowQocYVNAtQEUCIixWC6xempw8ITFppy6Ex+cru
         Ympw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477849; x=1718082649;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwYlTiV6Rt4HKzKI2WcesBOG37oKFHVkVyKg4Lxmmlw=;
        b=oA5KHMP6DtG6nvMOWHoybHDcrRUUMxHbMoD9k1mS6uDFNUhloaqpdGGrvnaBtV257o
         t9vlBVV0/B/FrZRFhrMb0oie+DQzEPZ1MwanuP2LL0SxjEdkHFD6+NVjDi76zBv5ru0k
         T8IbfiI2R+a68EffGnOrMe4U6Kn+v27D6HLGG5mFoAmlr8iLbHcoVhlmIahyWLA7956l
         TeerAZhVpAmQwhsVyrHr7oPV/ufCatW3z+M0GUAxGn8s9Zk63+mAzvkCGrHTj44xcepl
         eG6mhWk6O5l1XQuYbi0FqgOUdGpCbXzOLmyW0vDI0AedNi1qMH6poHNhvSdljVyizgMD
         E6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXvMa2F+VB2HS3ErxGaudLXAKTLoPJ+lmlzRNa0BQ4yY/XSbR0389/4RZ+FBtmuFSPAitmKM4kZaplrs8SIHYfJp73ckzmJCrHJG4pUIL9hz6fkVJ0eed9uvIQW39Nm59gw2+/Bw04U76h/HebSat3F1BjZjizGF6I9lofLsJlB4WGTbxDAPbbpLFKvPmkuvJN++2wP00gvicAtT6mwkl0hkg4SVjaxaFtTOTH49IQZtLRvO3M2+75owWTQ62o=
X-Gm-Message-State: AOJu0YwWBrYE4cwphF1JamjRgSGHIa8n4W/D5lII/+fb3HNKYijGz9Dk
	PYfxl7Weye8eO0XM3OB/l3hF+T6UoJdvx9Of/IqqakCjl6WCWDbN
X-Google-Smtp-Source: AGHT+IEfT2hnwHPbvFJIeRLoZD+/0+fscvURnMxyUITt/1Y3MBXO14CtptRiEclz06LVJZSxOY5bzQ==
X-Received: by 2002:a05:6a20:2452:b0:1a8:2cd1:e493 with SMTP id adf61e73a8af0-1b2a345db4emr2209302637.29.1717477849084;
        Mon, 03 Jun 2024 22:10:49 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:48 -0700 (PDT)
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
Subject: [RFC 10/12] Drivers: hv: vmbus: Implement vmbus_irq_set_affinity
Date: Mon,  3 Jun 2024 22:09:38 -0700
Message-Id: <20240604050940.859909-11-mhklinux@outlook.com>
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

Pull out core code from target_cpu_store() to implement
vmbus_irq_set_affinity() so the affinity of VMBus channel interrupts
can be updated from user space via /proc/irq.

Since vmbus_irq_set_affinity() runs with interrupts disabled,
vmbus_send_modifychannel() can't wait for an ACK from Hyper-V. As
such, remove the "wait for ack" version of vmbus_send_modifychannel().
Not waiting isn't a problem unless the old CPU is quickly taken offline
before Hyper-V makes the change, which is dealt with in a subsequent
patch.

Also change target_cpu_store() to call irq_set_affinity() so that
changes made via /sys/bus/vmbus/devices/<guid>/channels/<nn>/cpu
are in sync with the /proc/irq interface. The cpus_read_lock() is
no longer needed in target_cpu_store() because irq_set_affinity()
ensures that the interrupt affinity is not set to an offline
CPU.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c   |  97 ++++++-------------------
 drivers/hv/vmbus_drv.c | 161 +++++++++++++++++++++++++----------------
 2 files changed, 121 insertions(+), 137 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 1aa020b538f1..b7920072e243 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -212,79 +212,6 @@ int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
 }
 EXPORT_SYMBOL_GPL(vmbus_send_tl_connect_request);
 
-static int send_modifychannel_without_ack(struct vmbus_channel *channel, u32 target_vp)
-{
-	struct vmbus_channel_modifychannel msg;
-	int ret;
-
-	memset(&msg, 0, sizeof(msg));
-	msg.header.msgtype = CHANNELMSG_MODIFYCHANNEL;
-	msg.child_relid = channel->offermsg.child_relid;
-	msg.target_vp = target_vp;
-
-	ret = vmbus_post_msg(&msg, sizeof(msg), true);
-	trace_vmbus_send_modifychannel(&msg, ret);
-
-	return ret;
-}
-
-static int send_modifychannel_with_ack(struct vmbus_channel *channel, u32 target_vp)
-{
-	struct vmbus_channel_modifychannel *msg;
-	struct vmbus_channel_msginfo *info;
-	unsigned long flags;
-	int ret;
-
-	info = kzalloc(sizeof(struct vmbus_channel_msginfo) +
-				sizeof(struct vmbus_channel_modifychannel),
-		       GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	init_completion(&info->waitevent);
-	info->waiting_channel = channel;
-
-	msg = (struct vmbus_channel_modifychannel *)info->msg;
-	msg->header.msgtype = CHANNELMSG_MODIFYCHANNEL;
-	msg->child_relid = channel->offermsg.child_relid;
-	msg->target_vp = target_vp;
-
-	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
-	list_add_tail(&info->msglistentry, &vmbus_connection.chn_msg_list);
-	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
-
-	ret = vmbus_post_msg(msg, sizeof(*msg), true);
-	trace_vmbus_send_modifychannel(msg, ret);
-	if (ret != 0) {
-		spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
-		list_del(&info->msglistentry);
-		spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
-		goto free_info;
-	}
-
-	/*
-	 * Release channel_mutex; otherwise, vmbus_onoffer_rescind() could block on
-	 * the mutex and be unable to signal the completion.
-	 *
-	 * See the caller target_cpu_store() for information about the usage of the
-	 * mutex.
-	 */
-	mutex_unlock(&vmbus_connection.channel_mutex);
-	wait_for_completion(&info->waitevent);
-	mutex_lock(&vmbus_connection.channel_mutex);
-
-	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
-	list_del(&info->msglistentry);
-	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
-
-	if (info->response.modify_response.status)
-		ret = -EAGAIN;
-
-free_info:
-	kfree(info);
-	return ret;
-}
-
 /*
  * Set/change the vCPU (@target_vp) the channel (@child_relid) will interrupt.
  *
@@ -294,14 +221,32 @@ static int send_modifychannel_with_ack(struct vmbus_channel *channel, u32 target
  * out an ACK, we can not know when the host will stop interrupting the "old"
  * vCPU and start interrupting the "new" vCPU for the given channel.
  *
+ * But even if Hyper-V provides the ACK, we don't wait for it because the
+ * caller, vmbus_irq_set_affinity(), is running with a spin lock held. The
+ * unknown delay in when the host will start interrupting the new vCPU is not
+ * a problem unless the old vCPU is taken offline, and that situation is dealt
+ * with separately in the CPU offlining path.
+ *
  * The CHANNELMSG_MODIFYCHANNEL message type is supported since VMBus version
  * VERSION_WIN10_V4_1.
  */
 int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_vp)
 {
-	if (vmbus_proto_version >= VERSION_WIN10_V5_3)
-		return send_modifychannel_with_ack(channel, target_vp);
-	return send_modifychannel_without_ack(channel, target_vp);
+	struct vmbus_channel_modifychannel msg;
+	int ret;
+
+	if (vmbus_proto_version < VERSION_WIN10_V4_1)
+		return -EINVAL;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.header.msgtype = CHANNELMSG_MODIFYCHANNEL;
+	msg.child_relid = channel->offermsg.child_relid;
+	msg.target_vp = target_vp;
+
+	ret = vmbus_post_msg(&msg, sizeof(msg), false);
+	trace_vmbus_send_modifychannel(&msg, ret);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vmbus_send_modifychannel);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b73be7c02d37..87f2f3436136 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -22,7 +22,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/of_address.h>
 #include <linux/clockchips.h>
-#include <linux/cpu.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/task_stack.h>
 
@@ -1322,10 +1321,107 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+/*
+ * This function is invoked by user space affinity changes initiated
+ * from /proc/irq/<nn> or from the legacy VMBus-specific interface at
+ * /sys/bus/vmbus/devices/<guid>/channels/<nn>/cpu.
+ *
+ * In the former case, the /proc implementation ensures that unmapping
+ * (i.e., deleting) the IRQ will pend while this function is in progress.
+ * Since deleting the channel unmaps the IRQ first, the channel can't go
+ * away either.
+ *
+ * In the latter case, the VMBus connection channel_mutex is held, which
+ * prevents channel deltion, and therefore IRQ unampping as well.
+ *
+ * So in both cases, accessing the channel and IRQ data structures is safe.
+ */
 int vmbus_irq_set_affinity(struct irq_data *data,
 				  const struct cpumask *dest, bool force)
 {
-	return 0;
+	static int next_cpu;
+	static cpumask_t tempmask;
+	int origin_cpu, target_cpu;
+	struct vmbus_channel *channel = irq_data_get_irq_handler_data(data);
+	int ret;
+
+	if (!channel) {
+		pr_err("Bad channel in vmbus_irq_set_affinity for relid %ld\n",
+				data->hwirq);
+		return -EINVAL;
+	}
+
+	/* Don't consider CPUs that are isolated */
+	if (housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
+		cpumask_and(&tempmask, dest,
+				housekeeping_cpumask(HK_TYPE_MANAGED_IRQ));
+	else
+		cpumask_copy(&tempmask, dest);
+
+	/*
+	 * If Hyper-V is already targeting a CPU in the new affinity mask,
+	 * keep that targeting and Hyper-V doesn't need to be updated. But
+	 * still set effective affinity as it may be unset when the IRQ is
+	 * first created.
+	 */
+	origin_cpu = channel->target_cpu;
+	if (cpumask_test_cpu(origin_cpu, &tempmask)) {
+		target_cpu = origin_cpu;
+		goto update_effective;
+	}
+
+	/*
+	 * Pick a CPU from the new affinity mask. As a simple heuristic to
+	 * spread out the selection when the mask contains multiple CPUs,
+	 * start with whatever CPU was last selected.
+	 */
+	target_cpu = cpumask_next_wrap(next_cpu, &tempmask, nr_cpu_ids, false);
+	if (target_cpu >= nr_cpu_ids)
+		return -EINVAL;
+	next_cpu = target_cpu;
+
+	/*
+	 * Hyper-V will ignore MODIFYCHANNEL messages for "non-open" channels;
+	 * avoid sending the message and fail here for such channels.
+	 */
+	if (channel->state != CHANNEL_OPENED_STATE)
+		return -EIO;
+
+	ret = vmbus_send_modifychannel(channel,
+				     hv_cpu_number_to_vp_number(target_cpu));
+	if (ret)
+		return ret;
+
+	/*
+	 * Warning.  At this point, there is *no* guarantee that the host will
+	 * have successfully processed the vmbus_send_modifychannel() request.
+	 * See the header comment of vmbus_send_modifychannel() for more info.
+	 *
+	 * Lags in the processing of the above vmbus_send_modifychannel() can
+	 * result in missed interrupts if the "old" target CPU is taken offline
+	 * before Hyper-V starts sending interrupts to the "new" target CPU.
+	 * hv_synic_cleanup() will ensure no interrupts are missed.
+	 *
+	 * But apart from this offlining scenario, the code tolerates such
+	 * lags.  It will function correctly even if a channel interrupt comes
+	 * in on a CPU that is different from the channel target_cpu value.
+	 */
+
+	channel->target_cpu = target_cpu;
+
+	/* See init_vp_index(). */
+	if (hv_is_perf_channel(channel))
+		hv_update_allocated_cpus(origin_cpu, target_cpu);
+
+	/* Currently set only for storvsc channels. */
+	if (channel->change_target_cpu_callback) {
+		(*channel->change_target_cpu_callback)(channel,
+				origin_cpu, target_cpu);
+	}
+
+update_effective:
+	irq_data_update_effective_affinity(data, cpumask_of(target_cpu));
+	return IRQ_SET_MASK_OK;
 }
 
 /*
@@ -1655,7 +1751,7 @@ static ssize_t target_cpu_show(struct vmbus_channel *channel, char *buf)
 static ssize_t target_cpu_store(struct vmbus_channel *channel,
 				const char *buf, size_t count)
 {
-	u32 target_cpu, origin_cpu;
+	u32 target_cpu;
 	ssize_t ret = count;
 
 	if (vmbus_proto_version < VERSION_WIN10_V4_1)
@@ -1668,17 +1764,6 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	if (target_cpu >= nr_cpumask_bits)
 		return -EINVAL;
 
-	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
-		return -EINVAL;
-
-	/* No CPUs should come up or down during this. */
-	cpus_read_lock();
-
-	if (!cpu_online(target_cpu)) {
-		cpus_read_unlock();
-		return -EINVAL;
-	}
-
 	/*
 	 * Synchronizes target_cpu_store() and channel closure:
 	 *
@@ -1703,55 +1788,9 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 */
 	mutex_lock(&vmbus_connection.channel_mutex);
 
-	/*
-	 * Hyper-V will ignore MODIFYCHANNEL messages for "non-open" channels;
-	 * avoid sending the message and fail here for such channels.
-	 */
-	if (channel->state != CHANNEL_OPENED_STATE) {
-		ret = -EIO;
-		goto cpu_store_unlock;
-	}
-
-	origin_cpu = channel->target_cpu;
-	if (target_cpu == origin_cpu)
-		goto cpu_store_unlock;
-
-	if (vmbus_send_modifychannel(channel,
-				     hv_cpu_number_to_vp_number(target_cpu))) {
-		ret = -EIO;
-		goto cpu_store_unlock;
-	}
-
-	/*
-	 * For version before VERSION_WIN10_V5_3, the following warning holds:
-	 *
-	 * Warning.  At this point, there is *no* guarantee that the host will
-	 * have successfully processed the vmbus_send_modifychannel() request.
-	 * See the header comment of vmbus_send_modifychannel() for more info.
-	 *
-	 * Lags in the processing of the above vmbus_send_modifychannel() can
-	 * result in missed interrupts if the "old" target CPU is taken offline
-	 * before Hyper-V starts sending interrupts to the "new" target CPU.
-	 * But apart from this offlining scenario, the code tolerates such
-	 * lags.  It will function correctly even if a channel interrupt comes
-	 * in on a CPU that is different from the channel target_cpu value.
-	 */
-
-	channel->target_cpu = target_cpu;
-
-	/* See init_vp_index(). */
-	if (hv_is_perf_channel(channel))
-		hv_update_allocated_cpus(origin_cpu, target_cpu);
-
-	/* Currently set only for storvsc channels. */
-	if (channel->change_target_cpu_callback) {
-		(*channel->change_target_cpu_callback)(channel,
-				origin_cpu, target_cpu);
-	}
+	ret = irq_set_affinity(channel->irq, cpumask_of(target_cpu));
 
-cpu_store_unlock:
 	mutex_unlock(&vmbus_connection.channel_mutex);
-	cpus_read_unlock();
 	return ret;
 }
 static VMBUS_CHAN_ATTR(cpu, 0644, target_cpu_show, target_cpu_store);
-- 
2.25.1


