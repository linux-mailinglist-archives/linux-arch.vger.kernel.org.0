Return-Path: <linux-arch+bounces-11888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E8AB2C3A
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 01:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE518998C3
	for <lists+linux-arch@lfdr.de>; Sun, 11 May 2025 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B50265613;
	Sun, 11 May 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CUW6H938"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2F262FD8;
	Sun, 11 May 2025 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747004889; cv=none; b=BSeZB5jhO1P1+H2tENL0E/pqPT8Zpa18Ibxp/B9XzqwyLlSQhom8XGSfG8brtj36cn0WSJTGnvHiMxQirj5uE+YbWKsU9YZfavWCfDpLkLhqx7HNKCJ1a+MShwuWQ0B7AFQ3oHw/l0a8f8OGxYdeGqXCNkIpcoeQoZHty/8R/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747004889; c=relaxed/simple;
	bh=2cngbgMQB8qxt9NruLXbB0p5b7AKuiws7Z5rbLbD2ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WikXSSf5+S5hV6aXWqW63zFewdhvcEQPyeb6Hj45RXst4+UD/7uPlV11F+QG4j1uyvhNFkLIpQjQ9eMShPIn1Av9MqTSWcqJRwpFazASIbLx/m/2A0ZNqFVqy0AnBNvtvf6lB+02dYqfX0bhgnPJzhXHfbqe4Ih9qY+oZMNQnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CUW6H938; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED9CC211D8B7;
	Sun, 11 May 2025 16:08:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED9CC211D8B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747004881;
	bh=u8i6pVteba9ToPDRLJ8N42QkCJDpkRw/5GbWjTa9ozY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUW6H938MVLyB75SHOEgbY+FZezgNQV1D3nT+JXhka5Qcj0AJilbd7hNrU0Mx+W2G
	 whnRmbimzuNymD9oZwW06mgUR8pSIYZoLEMyViVOfUXTnd7pSmbj9fLYd2AKviIjFa
	 1+CmD2eG3NUzA8CgvU1Rn4mU9L4l2wVFtA5tFc0E=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 2/4] drivers: hyperv: VMBus protocol version 6.0
Date: Sun, 11 May 2025 16:07:56 -0700
Message-ID: <20250511230758.160674-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511230758.160674-1-romank@linux.microsoft.com>
References: <20250511230758.160674-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The confidential VMBus is supported starting from the protocol
version 6.0 onwards.

Update the relevant definitions, provide a function that returns
whether VMBus is condifential or not.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c         | 12 ++++++
 include/asm-generic/mshyperv.h |  1 +
 include/linux/hyperv.h         | 71 +++++++++++++++++++++++++---------
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1d5c9dcf712e..e431978fa408 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -56,6 +56,18 @@ static long __percpu *vmbus_evt;
 int vmbus_irq;
 int vmbus_interrupt;
 
+/*
+ * If the Confidential VMBus is used, the data on the "wire" is not
+ * visible to either the host or the hypervisor.
+ */
+static bool is_confidential;
+
+bool vmbus_is_confidential(void)
+{
+	return is_confidential;
+}
+EXPORT_SYMBOL_GPL(vmbus_is_confidential);
+
 /*
  * The panic notifier below is responsible solely for unloading the
  * vmbus connection, which is necessary in a panic event.
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 6c51a25ed7b5..96e0723d0720 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -377,6 +377,7 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
 	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_MSHV_ROOT */
+bool vmbus_is_confidential(void);
 
 #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
 u8 __init get_vtl(void);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 1f310fbbc4f9..3cf48f29e6b4 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -265,16 +265,19 @@ static inline u32 hv_get_avail_to_write_percent(
  * Linux kernel.
  */
 
-#define VERSION_WS2008  ((0 << 16) | (13))
-#define VERSION_WIN7    ((1 << 16) | (1))
-#define VERSION_WIN8    ((2 << 16) | (4))
-#define VERSION_WIN8_1    ((3 << 16) | (0))
-#define VERSION_WIN10 ((4 << 16) | (0))
-#define VERSION_WIN10_V4_1 ((4 << 16) | (1))
-#define VERSION_WIN10_V5 ((5 << 16) | (0))
-#define VERSION_WIN10_V5_1 ((5 << 16) | (1))
-#define VERSION_WIN10_V5_2 ((5 << 16) | (2))
-#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
+#define VMBUS_MAKE_VERSION(MAJ, MIN)	((((u32)MAJ) << 16) | (MIN))
+#define VERSION_WS2008					VMBUS_MAKE_VERSION(0, 13)
+#define VERSION_WIN7					VMBUS_MAKE_VERSION(1, 1)
+#define VERSION_WIN8					VMBUS_MAKE_VERSION(2, 4)
+#define VERSION_WIN8_1					VMBUS_MAKE_VERSION(3, 0)
+#define VERSION_WIN10					VMBUS_MAKE_VERSION(4, 0)
+#define VERSION_WIN10_V4_1				VMBUS_MAKE_VERSION(4, 1)
+#define VERSION_WIN10_V5				VMBUS_MAKE_VERSION(5, 0)
+#define VERSION_WIN10_V5_1				VMBUS_MAKE_VERSION(5, 1)
+#define VERSION_WIN10_V5_2				VMBUS_MAKE_VERSION(5, 2)
+#define VERSION_WIN10_V5_3				VMBUS_MAKE_VERSION(5, 3)
+#define VERSION_WIN_IRON				VERSION_WIN10_V5_3
+#define VERSION_WIN_COPPER				VMBUS_MAKE_VERSION(6, 0)
 
 /* Make maximum size of pipe payload of 16K */
 #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
@@ -335,14 +338,22 @@ struct vmbus_channel_offer {
 } __packed;
 
 /* Server Flags */
-#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE	1
-#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES	2
-#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS		4
-#define VMBUS_CHANNEL_NAMED_PIPE_MODE			0x10
-#define VMBUS_CHANNEL_LOOPBACK_OFFER			0x100
-#define VMBUS_CHANNEL_PARENT_OFFER			0x200
-#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x400
-#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER		0x2000
+#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE		0x0001
+/*
+ * This flag indicates that the channel is offered by the paravisor, and must
+ * use encrypted memory for the channel ring buffer.
+ */
+#define VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER			0x0002
+/*
+ * This flag indicates that the channel is offered by the paravisor, and must
+ * use encrypted memory for GPA direct packets and additional GPADLs.
+ */
+#define VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMORY		0x0004
+#define VMBUS_CHANNEL_NAMED_PIPE_MODE					0x0010
+#define VMBUS_CHANNEL_LOOPBACK_OFFER					0x0100
+#define VMBUS_CHANNEL_PARENT_OFFER						0x0200
+#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x0400
+#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER				0x2000
 
 struct vmpacket_descriptor {
 	u16 type;
@@ -621,6 +632,12 @@ struct vmbus_channel_relid_released {
 	u32 child_relid;
 } __packed;
 
+/*
+ * Used by the paravisor only, means that the encrypted ring buffers and
+ * the encrypted external memory are supported
+ */
+#define VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS	0x10
+
 struct vmbus_channel_initiate_contact {
 	struct vmbus_channel_message_header header;
 	u32 vmbus_version_requested;
@@ -630,7 +647,8 @@ struct vmbus_channel_initiate_contact {
 		struct {
 			u8	msg_sint;
 			u8	msg_vtl;
-			u8	reserved[6];
+			u8	reserved[2];
+			u32 feature_flags; /* VMBus version 6.0 */
 		};
 	};
 	u64 monitor_page1;
@@ -1002,6 +1020,11 @@ struct vmbus_channel {
 
 	/* The max size of a packet on this channel */
 	u32 max_pkt_size;
+
+	/* The ring buffer is encrypted */
+	bool confidential_ring_buffer;
+	/* The external memory is encrypted */
+	bool confidential_external_memory;
 };
 
 #define lock_requestor(channel, flags)					\
@@ -1026,6 +1049,16 @@ u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
 			     u64 rqst_addr);
 u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id);
 
+static inline bool is_confidential_ring_buffer(const struct vmbus_channel_offer_channel *o)
+{
+	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER);
+}
+
+static inline bool is_confidential_external_memory(const struct vmbus_channel_offer_channel *o)
+{
+	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMORY);
+}
+
 static inline bool is_hvsock_offer(const struct vmbus_channel_offer_channel *o)
 {
 	return !!(o->offer.chn_flags & VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
-- 
2.43.0


