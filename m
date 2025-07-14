Return-Path: <linux-arch+bounces-12768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0739B04A4A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5228B4A19E3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4627A44D;
	Mon, 14 Jul 2025 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TwaYS/qJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AEC27A130;
	Mon, 14 Jul 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531355; cv=none; b=LlPHjKh08TcJ9zXsifsfkPMMS26eTNmHR6odyn89MddM7hWH0J0vHqL8nEu7w2s1jALevIngsZAYTb1MZy/7NrGnVoWNq8ofub/XoopSI/QStyrFlIM00VeMiDO2WWzgJxFDjhYM9S5hOhOXnsF+oHPajUgKzlr+c3F0yW3xJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531355; c=relaxed/simple;
	bh=KGEfFIT/ZT1Y8Q45i70mOCPYMVR5EaPhFKqVImq0+nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4JRVMqb6ajQUVpPwLWKCy594fE3F0Pv/BOlnYkl2YkYa9pgXeBCV23ai9eSMyncVYHMj90GDcs2yD7cvENcZdKt8lvQe7Ed5BMBw1SPFwAyWnSBPFUf65n0ZYoXOHT2LZbAZNVyrn28CrtJfcAgM+w2j8F7e6yFQWhbnJJZHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TwaYS/qJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id BBB2E201A4DE;
	Mon, 14 Jul 2025 15:15:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBB2E201A4DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531350;
	bh=G4pTvTDF4giNUjjIl5YiEHQWjO7GRzLcFy/iGyAB/qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwaYS/qJ3A6+zBQJlUkshr+Mph+Ede9M52tuVRyyoNBAuLVSwaMirdx+5DA3UfQ4/
	 JRaKczOXB/6+uqrIJILOisHsOlQJVGA8uWu6cZva1Hg9jpMM76iYRulMbIROK3mn5U
	 ly4m1zzhnLvV2tAoE851ZLr7fkcQhQIQ8J9yAJOA=
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
Subject: [PATCH hyperv-next v4 14/16] Drivers: hv: Support confidential VMBus channels
Date: Mon, 14 Jul 2025 15:15:43 -0700
Message-ID: <20250714221545.5615-15-romank@linux.microsoft.com>
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

To make use of Confidential VMBus channels, initialize the
co_ring_buffers and co_external_memory fields of the channel
structure.

Advertise support upon negotiating the version and compute
values for those fields and initialize them.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c | 19 +++++++++++++++++++
 drivers/hv/connection.c   |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index ca2fe10c110a..6ae44eab1626 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1021,6 +1021,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 	struct vmbus_channel_offer_channel *offer;
 	struct vmbus_channel *oldchannel, *newchannel;
 	size_t offer_sz;
+	bool co_ring_buffer, co_external_memory;
 
 	offer = (struct vmbus_channel_offer_channel *)hdr;
 
@@ -1033,6 +1034,22 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		return;
 	}
 
+	co_ring_buffer = is_co_ring_buffer(offer);
+	co_external_memory = is_co_external_memory(offer);
+	if (!co_ring_buffer && co_external_memory) {
+		pr_err("Invalid offer relid=%d: the ring buffer isn't encrypted\n",
+			offer->child_relid);
+		return;
+	}
+	if (co_ring_buffer || co_external_memory) {
+		if (vmbus_proto_version < VERSION_WIN10_V6_0 || !vmbus_is_confidential()) {
+			pr_err("Invalid offer relid=%d: no support for confidential VMBus\n",
+				offer->child_relid);
+			atomic_dec(&vmbus_connection.offer_in_progress);
+			return;
+		}
+	}
+
 	oldchannel = find_primary_channel_by_offer(offer);
 
 	if (oldchannel != NULL) {
@@ -1111,6 +1128,8 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		pr_err("Unable to allocate channel object\n");
 		return;
 	}
+	newchannel->co_ring_buffer = co_ring_buffer;
+	newchannel->co_external_memory = co_external_memory;
 
 	vmbus_setup_channel_state(newchannel, offer);
 
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index be490c598785..eeb472019d69 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -105,6 +105,9 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
 	}
 
+	if (vmbus_is_confidential() && version >= VERSION_WIN10_V6_0)
+		msg->feature_flags = VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS;
+
 	/*
 	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
 	 * bitwise OR it
-- 
2.43.0


