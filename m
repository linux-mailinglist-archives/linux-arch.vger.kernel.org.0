Return-Path: <linux-arch+bounces-4661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4167E8FA994
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94D01F24529
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099413FD6A;
	Tue,  4 Jun 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaHnNqYa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47F13E05B;
	Tue,  4 Jun 2024 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477842; cv=none; b=e0ldZiF/PTOsxaz/oiwlDz3fdml5x3YNdzpWlnN4VgO/UEyEVbRekclONmJenAS79ZKJ2zUIm9D0mtXTcwD3spKbwujIwXn0/uiAz8IDn4tsQ0KwRAetCzGYZn2ctOdIm9o2vqGk/n9YPcpl9mOLMG4SRf0TphUJXvXtdRM5T4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477842; c=relaxed/simple;
	bh=zSe+eD0qV+e71QCOWMNlBwLmbidtc2MRHQzXAFw6Uj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tG1B+NU8M0rftQfv03G2JtiCImCDAKZi2dBfa7EZPoozF+bWMDiZAHDHfulcey+b5tTHowR1EOmVMdxsjTYMDMql6qcTpoN3A6lGNnA3HoULNyCYRAoOSTTBW5l3RP1uMcDbrfQDO1+9P0E6ft68QGj23/uFp4Qr0zmJdyodtHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaHnNqYa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70276322ad8so649008b3a.1;
        Mon, 03 Jun 2024 22:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477840; x=1718082640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tyt2LCARZb9G8yUFB+4R0wf0B3JqyvqSEeHJTztg/6g=;
        b=KaHnNqYa6zww4Gs0ITsJICh+2jdTpNEqbSaT8vj8aXA1FzDPxx0wyvfFOoJz6vsnAI
         bIP9NtGE/rhQimPSFyeV+X6eyltXiKTxcZyt7oI7Z2q2Euagsrchtkv6UQV9kV6UWk5w
         Sslp39Zbar4B23I3PX9j0Ax1uQVFlq/CaB4+LW/xuWWDP9Pzysi3lLi7/CozHikUjXma
         BgLo6CbQsBvKCzizKJbVb02DZKSn0zd/7Bx4mKKK/SVStHC+9g553hAfvMZAOZ91v1J2
         xQsg1cwLXVdwErhza6mEcDJEsk4Iu8J4idlDi3jrOmlmWSTmnKSJWzlvRKeO71PXA6P8
         wVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477840; x=1718082640;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tyt2LCARZb9G8yUFB+4R0wf0B3JqyvqSEeHJTztg/6g=;
        b=OOBUnWtI2Vz7+DH5fajOqm/oxadjVX3BLRtvDhSLz57jsSj5DdY+isssM6f+EkhuFg
         M0Jp5nek+oM+Ikn1RhXZFkENyrZzmTLUDeAAEjVgkutqUXGafQ/Iocj3m6JISwTCCVcR
         SCX83i2L0hhJ/QCrHDJ5Rl15/ams+FgdjqylLErDS58ns61H3PPJQWtg0NflQJxEMlh1
         WkwfmdFTRJxJoP3M7ysKjqoSRugVU1uloH5ccw8npeqKjzYJ5y1dBpm8get/6EvUOpBV
         1OdIf0u3K3VPcDZR07g82K8V5lWhXWgV+pdXZOd2vJhwID0JEG03xEY+mBHAGUJVVqf+
         4yzA==
X-Forwarded-Encrypted: i=1; AJvYcCV+6Yn5P8tDv/GNAGGh/DhpOewAWjfQmXyWr/2XiFJym8rkXiw7pdPg5f/OtVID5+B4oTl++hKpiAsGBVA/NUpEsPjd7A9MKdEOE3wtYuxgWS1HY2pwiE3OUTPJlVvbWffjW1Zc9LYAeN8MbrImzFXpoYzJ8lgWT8n+JQXszbazVgqsFOd42elSZnbe/+iRyewxL9rVZzew8BwE3zdjJaYmzGIT691VC33L6v+OAfPUZUXfLhL3Hkc5ic30aRs=
X-Gm-Message-State: AOJu0YyJpdOyGVO6dMe3B1x8mgDO+K88apQyuBA+g7TsfY3ZFw3G6jip
	FosOxmFpgacuDJkIQTUu+A7kDXuTp6AFLrXGfws1PoSUasKjAsfj
X-Google-Smtp-Source: AGHT+IFhTA5PSRFrRUUXGMk5zEUWP+kSdnmr7igsWz9177BNVWX0y0FgoWXqzbK+Nj7MFqlG3jitow==
X-Received: by 2002:a05:6a00:230a:b0:6f3:f970:9f2a with SMTP id d2e1a72fcca58-702477e69femr12966122b3a.10.1717477839971;
        Mon, 03 Jun 2024 22:10:39 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:39 -0700 (PDT)
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
Subject: [RFC 03/12] Drivers: hv: vmbus: Add an IRQ name to VMBus channels
Date: Mon,  3 Jun 2024 22:09:31 -0700
Message-Id: <20240604050940.859909-4-mhklinux@outlook.com>
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

In preparation for assigning Linux IRQs to VMBus channels, assign a
string name to each channel. The name is used when the IRQ is
requested, and it will appear in the output of /proc/interrupts to
make it easier to identify the device the IRQ is associated with.

Many VMBus devices are single-instance, with a single channel. For
such devices, a default string name can be determined based on the
GUID identifying the device. So add default names to the vmbus_devs
table that lists recognized devices. When a channel is created, set
the channel name to that default so a reasonable name is displayed
without requiring VMBus driver modifications.

However, individual VMBus device drivers may be optionally modified
to override the default name to provide additional information. In
cases where a driver supports multiple instances of a device, or a
device has multiple channels, the additional information may be
helpful to display in /proc/interrupts.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel_mgmt.c | 45 +++++++++++++++++++++++++++++++--------
 include/linux/hyperv.h    |  5 +++++
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index a216a0aede73..adbe184e5197 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/hyperv.h>
+#include <linux/string.h>
 #include <asm/mshyperv.h>
 #include <linux/sched/isolation.h>
 
@@ -33,6 +34,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_IDE_GUID,
 	  .perf_device = true,
 	  .allowed_in_isolated = false,
+	  .irq_name = "storvsc",
 	},
 
 	/* SCSI */
@@ -40,6 +42,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_SCSI_GUID,
 	  .perf_device = true,
 	  .allowed_in_isolated = true,
+	  .irq_name = "storvsc",
 	},
 
 	/* Fibre Channel */
@@ -47,6 +50,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_SYNTHFC_GUID,
 	  .perf_device = true,
 	  .allowed_in_isolated = false,
+	  .irq_name = "storvsc",
 	},
 
 	/* Synthetic NIC */
@@ -54,6 +58,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_NIC_GUID,
 	  .perf_device = true,
 	  .allowed_in_isolated = true,
+	  .irq_name = "netvsc",
 	},
 
 	/* Network Direct */
@@ -61,6 +66,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_ND_GUID,
 	  .perf_device = true,
 	  .allowed_in_isolated = false,
+	  .irq_name = "netdirect",
 	},
 
 	/* PCIE */
@@ -68,6 +74,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_PCIE_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = true,
+	  .irq_name = "vpci",
 	},
 
 	/* Synthetic Frame Buffer */
@@ -75,6 +82,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_SYNTHVID_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
+	  .irq_name = "framebuffer",
 	},
 
 	/* Synthetic Keyboard */
@@ -82,6 +90,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_KBD_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
+	  .irq_name = "keyboard",
 	},
 
 	/* Synthetic MOUSE */
@@ -89,6 +98,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_MOUSE_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
+	  .irq_name = "mouse",
 	},
 
 	/* KVP */
@@ -96,6 +106,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_KVP_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
+	  .irq_name = "kvp",
 	},
 
 	/* Time Synch */
@@ -103,6 +114,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_TS_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = true,
+	  .irq_name = "timesync",
 	},
 
 	/* Heartbeat */
@@ -110,6 +122,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_HEART_BEAT_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = true,
+	  .irq_name = "heartbeat",
 	},
 
 	/* Shutdown */
@@ -117,6 +130,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_SHUTDOWN_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = true,
+	  .irq_name = "shutdown",
 	},
 
 	/* File copy */
@@ -126,6 +140,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_FCOPY_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
+	  .irq_name = "fcopy",
 	},
 
 	/* Backup */
@@ -133,6 +148,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_VSS_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
+	  .irq_name = "vss",
 	},
 
 	/* Dynamic Memory */
@@ -140,6 +156,7 @@ const struct vmbus_device vmbus_devs[] = {
 	  HV_DM_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
+	  .irq_name = "balloon",
 	},
 
 	/*
@@ -198,20 +215,30 @@ static bool is_unsupported_vmbus_devs(const guid_t *guid)
 	return false;
 }
 
-static u16 hv_get_dev_type(const struct vmbus_channel *channel)
+static void hv_set_dev_type_and_irq_name(struct vmbus_channel *channel)
 {
 	const guid_t *guid = &channel->offermsg.offer.if_type;
+	char *name = NULL;
 	u16 i;
 
-	if (is_hvsock_channel(channel))
-		return HV_UNKNOWN;
-
-	for (i = HV_IDE; i < HV_UNKNOWN; i++) {
-		if (guid_equal(guid, &vmbus_devs[i].guid))
-			return i;
+	if (is_hvsock_channel(channel)) {
+		i = HV_UNKNOWN;
+		name = "hv_sock";
+		goto found;
 	}
+
+	for (i = HV_IDE; i < HV_UNKNOWN; i++)
+		if (guid_equal(guid, &vmbus_devs[i].guid)) {
+			name = vmbus_devs[i].irq_name;
+			goto found;
+		}
+
 	pr_info("Unknown GUID: %pUl\n", guid);
-	return i;
+
+found:
+	channel->device_id =  i;
+	if (name)
+		strscpy(channel->irq_name, name, VMBUS_CHAN_IRQ_NAME_MAX);
 }
 
 /**
@@ -970,7 +997,7 @@ static void vmbus_setup_channel_state(struct vmbus_channel *channel,
 	       sizeof(struct vmbus_channel_offer_channel));
 	channel->monitor_grp = (u8)offer->monitorid / 32;
 	channel->monitor_bit = (u8)offer->monitorid % 32;
-	channel->device_id = hv_get_dev_type(channel);
+	hv_set_dev_type_and_irq_name(channel);
 }
 
 /*
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d52c916cc492..897d96fa19d4 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -826,6 +826,7 @@ struct vmbus_device {
 	guid_t guid;
 	bool perf_device;
 	bool allowed_in_isolated;
+	char *irq_name;
 };
 
 #define VMBUS_DEFAULT_MAX_PKT_SIZE 4096
@@ -837,6 +838,8 @@ struct vmbus_gpadl {
 	bool decrypted;
 };
 
+#define VMBUS_CHAN_IRQ_NAME_MAX 32
+
 struct vmbus_channel {
 	struct list_head listentry;
 
@@ -1068,6 +1071,8 @@ struct vmbus_channel {
 
 	/* The max size of a packet on this channel */
 	u32 max_pkt_size;
+
+	char irq_name[VMBUS_CHAN_IRQ_NAME_MAX];
 };
 
 #define lock_requestor(channel, flags)					\
-- 
2.25.1


