Return-Path: <linux-arch+bounces-13978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80235BC6EA9
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2264EDAB8
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED17C2DF13F;
	Wed,  8 Oct 2025 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V3XKaRR9"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CCC2DEA72;
	Wed,  8 Oct 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966479; cv=none; b=HONsjerrQ+eg18aNBeRa4OKBYoaX0L+QD/iSFblR6vCwkQ1+Thauvm2NcHk/D4UUxIdwKat38uQ7d49U7oAzCJHeyhmlpm/M6Ljl8DnwGbzVSkw7l2mQWhU5c39j3ZMcSFWOD5JIqFcXXLZBYqfqNbD3Cadcj6S2YLS4zsYsEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966479; c=relaxed/simple;
	bh=WBPIfgVxPGV/LSFNZSZg5i9TojfsH9u2tXp3iGnaa74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEfrpQ8V1W98sn47qXOw9Un41pAxvBLOZDOjEbhXmaGusJuKR/6M/pSdh5iU7ZQLYYWDNutPvRjBZVdT0OEW6glhlsrK2HHzFQU4AsH4dcgPOU+wulhX3pqHr1m72NYFK24lpzgeSxTglPXJGewPOPo42XMOi8qxYm1EiP8RWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V3XKaRR9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4766F211CE11;
	Wed,  8 Oct 2025 16:34:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4766F211CE11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966476;
	bh=4R3Q4+AFI3c1tV24p2R3HQuzaQyvhOVsFSX+WtZ8g/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3XKaRR9JCWWPYph/YXfTzUYXiTLjGd5GrKcdvoa1pO/j34FswckoDjnZswLEv2i5
	 JWWBykIUIrUwVAt3kJaK4UH8QuopcQZylznRewdjBx7nWbycYmQtwCHZgCtGLNPuOX
	 DXQ2sjlT9x50K7S25cqG5gMLXRuid5kE5O2cugZY=
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
Subject: [PATCH hyperv-next v7 15/17] Drivers: hv: Support confidential VMBus channels
Date: Wed,  8 Oct 2025 16:34:17 -0700
Message-ID: <20251008233419.20372-16-romank@linux.microsoft.com>
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

To make use of Confidential VMBus channels, initialize the
co_ring_buffers and co_external_memory fields of the channel
structure.

Advertise support upon negotiating the version and compute
values for those fields and initialize them.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel_mgmt.c | 19 +++++++++++++++++++
 drivers/hv/connection.c   |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 6d66cbc9030b..74fed2c073d4 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1022,6 +1022,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 	struct vmbus_channel_offer_channel *offer;
 	struct vmbus_channel *oldchannel, *newchannel;
 	size_t offer_sz;
+	bool co_ring_buffer, co_external_memory;
 
 	offer = (struct vmbus_channel_offer_channel *)hdr;
 
@@ -1034,6 +1035,22 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
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
@@ -1112,6 +1129,8 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		pr_err("Unable to allocate channel object\n");
 		return;
 	}
+	newchannel->co_ring_buffer = co_ring_buffer;
+	newchannel->co_external_memory = co_external_memory;
 
 	vmbus_setup_channel_state(newchannel, offer);
 
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 1fe3573ae52a..5ac9232396f7 100644
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


