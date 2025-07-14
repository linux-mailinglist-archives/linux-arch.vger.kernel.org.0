Return-Path: <linux-arch+bounces-12766-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E48D2B04A49
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE29D1AA0EFE
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906B28507C;
	Mon, 14 Jul 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qc//hMsk"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B30E279904;
	Mon, 14 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531354; cv=none; b=HBtilVLdXU04om/85cxWugFnMHhthK8PKR3j8CmKz2Dr+vSknmM83arFUvNfnAy0OVCoATZ7KLjral0nhT3l3xW9QRxicl+pRXoK9GjGmwn987eMSEq/BuZcvMmBr23UwrT5GyeDRx5BG7CdiYeXPZSPDyxzCPWP4U45YsGWYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531354; c=relaxed/simple;
	bh=dumwlVQAuaRbcn1p/IF4QNNVcpVnsy76a7SVLjV8Q3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkVDGH4qSwo313a1SgI+NZB9ETBsChtZh7ZvfFoLUtsDmodHiiV5CXz/G2j5yZ7FIWxMPZdKb0bQodO6bjc2KU0w47ue9hqCuwrqKv48uBSuSWlQP3nummFW7Ctg1ueSCp0IOytgzDtwXefaFi4g7wLMR578FObSxoeTmp54ZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qc//hMsk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3727B201A4CD;
	Mon, 14 Jul 2025 15:15:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3727B201A4CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531350;
	bh=42IHhrO4islY3PvMR+vhbbQVAyXFdhkMLiuZuOP40Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qc//hMskvHvj8KLR89RpfUaEbmkkZGUIf8gaOC7XYOXh5/9hyBBP3jbi8m285N1jz
	 mwzXPdYcyzVN65THd0VRgoxt8y0bCyVUoIBb9wqzM8JrZx8dQubWVO1IKu+4/a33UQ
	 raUdHqkePqBkkxL5NvpfH9N0W3IN45QbFr8P3e1s=
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
Subject: [PATCH hyperv-next v4 12/16] Drivers: hv: Allocate encrypted buffers when requested
Date: Mon, 14 Jul 2025 15:15:41 -0700
Message-ID: <20250714221545.5615-13-romank@linux.microsoft.com>
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

Confidential VMBus is built around using buffers not shared with
the host.

Support allocating encrypted buffers when requested.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/channel.c      | 49 +++++++++++++++++++++++----------------
 drivers/hv/hyperv_vmbus.h |  3 ++-
 drivers/hv/ring_buffer.c  |  5 ++--
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 35f26fa1ffe7..051eeba800f2 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -443,20 +443,23 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 		return ret;
 	}
 
-	/*
-	 * Set the "decrypted" flag to true for the set_memory_decrypted()
-	 * success case. In the failure case, the encryption state of the
-	 * memory is unknown. Leave "decrypted" as true to ensure the
-	 * memory will be leaked instead of going back on the free list.
-	 */
-	gpadl->decrypted = true;
-	ret = set_memory_decrypted((unsigned long)kbuffer,
-				   PFN_UP(size));
-	if (ret) {
-		dev_warn(&channel->device_obj->device,
-			 "Failed to set host visibility for new GPADL %d.\n",
-			 ret);
-		return ret;
+	gpadl->decrypted = !((channel->co_external_memory && type == HV_GPADL_BUFFER) ||
+		(channel->co_ring_buffer && type == HV_GPADL_RING));
+	if (gpadl->decrypted) {
+		/*
+		 * The "decrypted" flag being true assumes that set_memory_decrypted() succeeds.
+		 * But if it fails, the encryption state of the memory is unknown. In that case,
+		 * leave "decrypted" as true to ensure the memory is leaked instead of going back
+		 * on the free list.
+		 */
+		ret = set_memory_decrypted((unsigned long)kbuffer,
+					PFN_UP(size));
+		if (ret) {
+			dev_warn(&channel->device_obj->device,
+				"Failed to set host visibility for new GPADL %d.\n",
+				ret);
+			return ret;
+		}
 	}
 
 	init_completion(&msginfo->waitevent);
@@ -544,8 +547,10 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 		 * left as true so the memory is leaked instead of being
 		 * put back on the free list.
 		 */
-		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
-			gpadl->decrypted = false;
+		if (gpadl->decrypted) {
+			if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
+				gpadl->decrypted = false;
+		}
 	}
 
 	return ret;
@@ -676,12 +681,13 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 		goto error_clean_ring;
 
 	err = hv_ringbuffer_init(&newchannel->outbound,
-				 page, send_pages, 0);
+				 page, send_pages, 0, newchannel->co_ring_buffer);
 	if (err)
 		goto error_free_gpadl;
 
 	err = hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
-				 recv_pages, newchannel->max_pkt_size);
+				 recv_pages, newchannel->max_pkt_size,
+				 newchannel->co_ring_buffer);
 	if (err)
 		goto error_free_gpadl;
 
@@ -862,8 +868,11 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
 	kfree(info);
 
-	ret = set_memory_encrypted((unsigned long)gpadl->buffer,
-				   PFN_UP(gpadl->size));
+	if (gpadl->decrypted)
+		ret = set_memory_encrypted((unsigned long)gpadl->buffer,
+					PFN_UP(gpadl->size));
+	else
+		ret = 0;
 	if (ret)
 		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 2873703d08a9..beae68a70939 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -200,7 +200,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
 
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 pagecnt, u32 max_pkt_size);
+		       struct page *pages, u32 pagecnt, u32 max_pkt_size,
+			   bool confidential);
 
 void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 3c9b02471760..05c2cd42fc75 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -183,7 +183,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
 
 /* Initialize the ring buffer. */
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
+		       struct page *pages, u32 page_cnt, u32 max_pkt_size,
+			   bool confidential)
 {
 	struct page **pages_wraparound;
 	int i;
@@ -207,7 +208,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	ring_info->ring_buffer = (struct hv_ring_buffer *)
 		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
-			pgprot_decrypted(PAGE_KERNEL));
+			confidential ? PAGE_KERNEL : pgprot_decrypted(PAGE_KERNEL));
 
 	kfree(pages_wraparound);
 	if (!ring_info->ring_buffer)
-- 
2.43.0


