Return-Path: <linux-arch+bounces-4670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BC88FA9BE
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACB61C233C6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE33143754;
	Tue,  4 Jun 2024 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgWKX8v6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859513DBAA;
	Tue,  4 Jun 2024 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477854; cv=none; b=NKYiN2BvM9dYR9OxO+vrZx/p9gpXhRFMXP7tUJk10fmpiSyYJvyf1TC8pOITXj8oJDmFyb0Jxi7gCr4ETRp3a94EsjXnpXLmoMa2QkCvnnpliJujloWHR8XSEFPR92vUGI9kI3ifHnNZkypScBrMfuN9CGjFAHcg8A4zzPfraAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477854; c=relaxed/simple;
	bh=yD6QlTva6OVI3xK1DDtiQ1txjxXIzA1gAMGkk74myI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZJWxbiEBDOEPOHZXPrrDAm/SRE2jhBrm390K7YGaNkAAa7bdqoS+au6LLmhxhHCkh2qyN223IJJdpgb7X0ttYD44nbDd2+/GmzlJG1qC+bjXu32wFBFVXUR5tUJOFTjtRJLYEAkWZemyTwFrHGOeKw7dkRFR8FndIycjB8Zobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgWKX8v6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7025ca8bebcso1997746b3a.3;
        Mon, 03 Jun 2024 22:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477852; x=1718082652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UqE8PqDSTScf2ssH6F4PbWUoO9g+WHgsI4Glih1KQPg=;
        b=NgWKX8v61be7LwLmyuKYqzvXSqjJnLUVlS0uiVB0qYhd5KQnTRShItJOXGREtEZh4L
         kqMMezuE9b1uyVntAnmfONuWXxpZiiAcNyIHGS9gsgOgPvYPVuAY7s8md8bTsCGpBcY2
         gtCf+9Ey7ccFqN7XLBFHNhpbD9clOBVH4dOB2cVlAe2e5fUAVh57PkJXXANdqrySF6nh
         gC1FLafi1NYNxMe7lBK2ggghZ6jrxi/b7Sff1cHnyNwYXZ9x37/2RmQKsFSfUmADAy6x
         TTGSQCQJ7WnHGJpftDEIep30EhrlmtaFdwuRLPyMjN6C+eNamVV+C+MSBlyEwV5r0urj
         kNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477852; x=1718082652;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqE8PqDSTScf2ssH6F4PbWUoO9g+WHgsI4Glih1KQPg=;
        b=wLfKc4tRGd1dbBQl7ZpncSVBeTW17sZ2GKvvbzjRX9C2DhOFBkpI8vBItmqtHTYhXS
         BskRt4MaGauTfo9HMolZ97nZbmZj8Z8OJuCTM9g3sffv6qdbocs9v2t8C/dlQdQRhvPN
         vaaaKK3JISkTNlytkAZH2qfbLyJxnCVucPeJEdIoR+WZcfrm/eJpgfk7M2wkp4zNyjBJ
         qMXPLJi7FsHwgl/sXI78P1ySc9qztZ6J9IGNHvbIXkU3dhUgxYTLi1gYz0b6MewBjM3M
         YUHhVsMHD9GznMWASY3zUxMnVDUhlQ0ToW60qIgqvi9CaaHmuawcFWQbMl0Pl4u2th8S
         aznA==
X-Forwarded-Encrypted: i=1; AJvYcCUndx/mfGrforncp5/nJzVvf6kW1bgxbszSrvd7vxDiye6X7s8sJbcw48G9Pv5YrGFuKbaEdfTNrn6adQKyhjl/uxTlbjlE0Dg7jBoDprv6zj3D+sNROXf8WrCB6+i103YjKMJF9LMpfZ1dD1plipiGySVWqBmvZWrcz3e7rQLDStML025fGynR3GwMcyYTpSbiB/REvgcPp2Ic/TM9TDURey2hyuwvJ00ox8d2wiNHNx45TABbNX/mBf3D2Aw=
X-Gm-Message-State: AOJu0YzkbCR6PFflAlnxIh3oLdP/3OoNjoN8qtxokRtd/4Ji6JLHCKfL
	Q2Vt7UkwAYvS90R3LjGPmV+2w6q19TzyHpuVxcvE8D2Z/TRLJ3xu
X-Google-Smtp-Source: AGHT+IHQeTJUGPqk9fJQ3bYqVezOkQwad17MvaE3G/i0Wg6Qa5p2Z3v+Yzuh/jC062uvo4bGBB7jUw==
X-Received: by 2002:a05:6a00:847:b0:6e9:38d0:5019 with SMTP id d2e1a72fcca58-70247664028mr13199794b3a.0.1717477851685;
        Mon, 03 Jun 2024 22:10:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:51 -0700 (PDT)
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
Subject: [RFC 12/12] Drivers: hv: vmbus: Ensure IRQ affinity isn't set to a CPU going offline
Date: Mon,  3 Jun 2024 22:09:40 -0700
Message-Id: <20240604050940.859909-13-mhklinux@outlook.com>
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

hv_synic_cleanup() currently prevents a CPU from going offline if any
VMBus channel IRQs are targeted at that CPU. However, current code has a
race in that an IRQ could be affinitized to the CPU after the check in
hv_synic_cleanup() and before the CPU is removed from cpu_online_mask.
Any channel interrupts could be lost and the channel would hang.

Fix this by adding a flag for each CPU indicating if the synic is online.
Filter the new affinity with these flags so that vmbus_irq_set_affinity()
doesn't pick a CPU where the synic is already offline.

Also add a spin lock so that vmbus_irq_set_affinity() changing the
channel target_cpu and sending the MODIFYCHANNEL message to Hyper-V
are atomic with respect to the checks made in hv_synic_cleanup().
hv_synic_cleanup() needs these operations to be atomic so that it
can correctly count the MODIFYCHANNEL messages that need to be
ack'ed by Hyper-V.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/connection.c   |  1 +
 drivers/hv/hv.c           | 22 ++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h |  2 ++
 drivers/hv/vmbus_drv.c    | 34 ++++++++++++++++++++++++++++------
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index a105eecdeec2..b44ce3d39135 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -213,6 +213,7 @@ int vmbus_connect(void)
 
 	INIT_LIST_HEAD(&vmbus_connection.chn_list);
 	mutex_init(&vmbus_connection.channel_mutex);
+	spin_lock_init(&vmbus_connection.set_affinity_lock);
 
 	/*
 	 * Setup the vmbus event connection for channel interrupt
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 76658dfc5008..89e491219129 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -338,6 +338,8 @@ int hv_synic_init(unsigned int cpu)
 {
 	hv_synic_enable_regs(cpu);
 
+	cpumask_set_cpu(cpu, &vmbus_connection.synic_online);
+
 	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
 
 	return 0;
@@ -513,6 +515,17 @@ int hv_synic_cleanup(unsigned int cpu)
 	 * TODO: Re-bind the channels to different CPUs.
 	 */
 	mutex_lock(&vmbus_connection.channel_mutex);
+	spin_lock(&vmbus_connection.set_affinity_lock);
+
+	/*
+	 * Once the check for channels assigned to this CPU is complete, we
+	 * must not allow a channel to be assigned to this CPU. So mark
+	 * the synic as no longer online. This cpumask is checked in
+	 * vmbus_irq_set_affinity() to prevent setting the affinity of
+	 * an IRQ to such a CPU.
+	 */
+	cpumask_clear_cpu(cpu, &vmbus_connection.synic_online);
+
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
 		if (channel->target_cpu == cpu) {
 			channel_found = true;
@@ -527,10 +540,11 @@ int hv_synic_cleanup(unsigned int cpu)
 		if (channel_found)
 			break;
 	}
+	spin_unlock(&vmbus_connection.set_affinity_lock);
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	if (channel_found)
-		return -EBUSY;
+		goto set_online;
 
 	/*
 	 * channel_found == false means that any channels that were previously
@@ -547,7 +561,7 @@ int hv_synic_cleanup(unsigned int cpu)
 		if (hv_synic_event_pending()) {
 			pr_err("Events pending when trying to offline CPU %d\n",
 					cpu);
-			return -EBUSY;
+			goto set_online;
 		}
 	}
 
@@ -557,4 +571,8 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_synic_disable_regs(cpu);
 
 	return 0;
+
+set_online:
+	cpumask_set_cpu(cpu, &vmbus_connection.synic_online);
+	return -EBUSY;
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 571b2955b38e..92ae5af10778 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -263,6 +263,8 @@ struct vmbus_connection {
 	struct fwnode_handle *vmbus_fwnode;
 	struct irq_domain *vmbus_irq_domain;
 	struct irq_chip	vmbus_irq_chip;
+	cpumask_t synic_online;
+	spinlock_t set_affinity_lock;
 
 	/*
 	 * VM-wide counts of MODIFYCHANNEL messages sent and completed.
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 87f2f3436136..3430ad42d7ba 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1351,6 +1351,14 @@ int vmbus_irq_set_affinity(struct irq_data *data,
 		return -EINVAL;
 	}
 
+	/*
+	 * The spin lock must be held so that checking synic_online, sending
+	 * the MODIFYCHANNEL message, and setting channel->target_cpu are
+	 * atomic with respect to hv_synic_cleanup() clearing the CPU in
+	 * synic_online and doing the search.
+	 */
+	spin_lock(&vmbus_connection.set_affinity_lock);
+
 	/* Don't consider CPUs that are isolated */
 	if (housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
 		cpumask_and(&tempmask, dest,
@@ -1367,30 +1375,39 @@ int vmbus_irq_set_affinity(struct irq_data *data,
 	origin_cpu = channel->target_cpu;
 	if (cpumask_test_cpu(origin_cpu, &tempmask)) {
 		target_cpu = origin_cpu;
+		spin_unlock(&vmbus_connection.set_affinity_lock);
 		goto update_effective;
 	}
 
 	/*
 	 * Pick a CPU from the new affinity mask. As a simple heuristic to
 	 * spread out the selection when the mask contains multiple CPUs,
-	 * start with whatever CPU was last selected.
+	 * start with whatever CPU was last selected. Also filter out any
+	 * CPUs where synic_online isn't set -- these CPUs are in the process
+	 * of going offline and must not have channel interrupts assigned
+	 * to them.
 	 */
+	cpumask_and(&tempmask, &tempmask, &vmbus_connection.synic_online);
 	target_cpu = cpumask_next_wrap(next_cpu, &tempmask, nr_cpu_ids, false);
-	if (target_cpu >= nr_cpu_ids)
-		return -EINVAL;
+	if (target_cpu >= nr_cpu_ids) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 	next_cpu = target_cpu;
 
 	/*
 	 * Hyper-V will ignore MODIFYCHANNEL messages for "non-open" channels;
 	 * avoid sending the message and fail here for such channels.
 	 */
-	if (channel->state != CHANNEL_OPENED_STATE)
-		return -EIO;
+	if (channel->state != CHANNEL_OPENED_STATE) {
+		ret = -EIO;
+		goto unlock;
+	}
 
 	ret = vmbus_send_modifychannel(channel,
 				     hv_cpu_number_to_vp_number(target_cpu));
 	if (ret)
-		return ret;
+		goto unlock;
 
 	/*
 	 * Warning.  At this point, there is *no* guarantee that the host will
@@ -1408,6 +1425,7 @@ int vmbus_irq_set_affinity(struct irq_data *data,
 	 */
 
 	channel->target_cpu = target_cpu;
+	spin_unlock(&vmbus_connection.set_affinity_lock);
 
 	/* See init_vp_index(). */
 	if (hv_is_perf_channel(channel))
@@ -1422,6 +1440,10 @@ int vmbus_irq_set_affinity(struct irq_data *data,
 update_effective:
 	irq_data_update_effective_affinity(data, cpumask_of(target_cpu));
 	return IRQ_SET_MASK_OK;
+
+unlock:
+	spin_unlock(&vmbus_connection.set_affinity_lock);
+	return ret;
 }
 
 /*
-- 
2.25.1


