Return-Path: <linux-arch+bounces-12198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130AACD0E0
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166E03A7278
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB361146A72;
	Wed,  4 Jun 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hfJuS4OM"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40E03595E;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997829; cv=none; b=EssO8pNxZnylOZJAWqAmYgBiGjY3zYzkChZSueJvUmvBicsb6ZlueQv17BFwOaGhfr/DFWaJZEcq2eq5xMGGCDCzszpN/MVPYT0/McDtbOTZ5NaOhZu86/BE+L7/mxE8JllgZrVn1BjIymmeGSN6ZYqNSgncccOpJj3PEarVMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997829; c=relaxed/simple;
	bh=icRtk77BzzKKOoll5KWJ9DqBS6Nr3J49vHfAt0yO4hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+0auvEFtBIp5pS3+5TZ1JbIcfxh2YJecTex7YXlLGngD16HCOJ/hQahxMy1LdyqrQAseWDM0PDy88Jdj8fyyYr2WPyQoWSUh/e/UrCi0+yv/QXeS1MUG75SREaKCgTVBAfGxv54wVSzr3A/b4kE/4Pk3NF3G85g2107z9IKZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hfJuS4OM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 653B42117448;
	Tue,  3 Jun 2025 17:43:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 653B42117448
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997827;
	bh=LAms2U6ddYyXTCzFfIbLw3Ykqrp3qhPKBffWKvGeuMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfJuS4OMPYK8UsTI1JH3rCYLxlsPredTImbcfqjD3o+D08CPrmRq8p89nRJ5QcJk5
	 l9eYP3gRSWXrd+2/Wl7CIckJCpaBOEFpFI9SHsMle0cqRCTZVtROalnWhbs3gGFFzv
	 ytuL39SY3+5+DavPxCg4+bfPVGrO6kJczygFsgnQ=
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
	mingo@redhat.com,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 12/15] Drivers: hv: Allocate encrypted buffers when requested
Date: Tue,  3 Jun 2025 17:43:38 -0700
Message-ID: <20250604004341.7194-13-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604004341.7194-1-romank@linux.microsoft.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
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
 drivers/hv/channel.c      | 43 +++++++++++++++++++++++----------------
 drivers/hv/hyperv_vmbus.h |  3 ++-
 drivers/hv/ring_buffer.c  |  5 +++--
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fb8cd8469328..3e2891c4b800 100644
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
+		 * Set the "decrypted" flag to true for the set_memory_decrypted()
+		 * success case. In the failure case, the encryption state of the
+		 * memory is unknown. Leave "decrypted" as true to ensure the
+		 * memory will be leaked instead of going back on the free list.
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
@@ -676,12 +679,13 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
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
 
@@ -862,8 +866,11 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
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
index c1df611d1eb2..0f02e163b0a0 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -199,7 +199,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
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


