Return-Path: <linux-arch+bounces-11344-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED528A819B1
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 02:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282D44A647C
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277F250EC;
	Wed,  9 Apr 2025 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TjHciaQQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89AE3C30;
	Wed,  9 Apr 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157327; cv=none; b=rZcsVW0D8hLtoMQfX6W7NoH4o3Pm4vuuEPXGFzCeaijXGnWKOPGJrjUrcekswVdbKJtqcxFHg/WZbpcyyjT4b+RYBI32Uxm7eDHSlnZ10M9hBarXm0IZ0LrarA6DueZ52yNCXmHyKhJ+Hv+maWL3ymNwzN8Dkh3ijXxd2VefNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157327; c=relaxed/simple;
	bh=XS8Jii9KcXAY6yCzvyMTM6JyTsWsfi45Pz+ikKb5NGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3W6cN6afIvQapxmp4R8rn47u8nqiwvrp8OTn8b+8XsU9jq2cdbP95bYmgdm0VxICRsQc3M7lzunOMkXC4YHgGElekWqcnd99vmHb/uPwGNVszPqijud2aWGU4SmRVC4e6BcNlP6sb+Umtm9IxRcBRhaMPH6GZGt/qNWJeUh6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TjHciaQQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 801DD2113E99;
	Tue,  8 Apr 2025 17:08:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 801DD2113E99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744157318;
	bh=KbV/vKXAiJOBIg+7IN7P0v6n1Jf6WS2233iGKx+AqoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjHciaQQgFnL7ivTEJKVa5ioWc/2NYa6k8KseApdUdFiruJHfVoaR9jxdQ7E4MiYF
	 IZ7YXCoETe3TAQmnUqpzuZqXLUajwo7FDuZ7bbr7jGbuCnPDf9fdHmbIE/9o1a+v7G
	 tMzUn9l1huWibgOirhb4LYNGntlzZ2ukSc+KBPek=
From: Roman Kisel <romank@linux.microsoft.com>
To: aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	hch@lst.de,
	hpa@zytor.com,
	James.Bottomley@HansenPartnership.com,
	Jonathan.Cameron@huawei.com,
	kys@microsoft.com,
	leon@kernel.org,
	lukas@wunner.de,
	luto@kernel.org,
	m.szyprowski@samsung.com,
	martin.petersen@oracle.com,
	mingo@redhat.com,
	peterz@infradead.org,
	quic_zijuhu@quicinc.com,
	robin.murphy@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next 2/6] drivers: hyperv: VMBus protocol version 6.0
Date: Tue,  8 Apr 2025 17:08:31 -0700
Message-ID: <20250409000835.285105-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409000835.285105-1-romank@linux.microsoft.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
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
index 22afebfc28ff..fa3ad6fe0bec 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -55,6 +55,18 @@ static long __percpu *vmbus_evt;
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
index ccccb1cbf7df..23f707b5aeeb 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -377,5 +377,6 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
 	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_MSHV_ROOT */
+bool vmbus_is_confidential(void);
 
 #endif
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 675959fb97ba..e66fd980789a 100644
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


