Return-Path: <linux-arch+bounces-13315-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 282A2B390B3
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7481C247F6
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B32246BB3;
	Thu, 28 Aug 2025 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q3ODG9ME"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008BD23E354;
	Thu, 28 Aug 2025 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343185; cv=none; b=LRfbPpo6WQF34DeOsCyrd7TuTyk27LbQXsvMsVLD/LRhLnI7EM1uK2MNBEp7jBubqNLhU81pXfOQAYnGCt+jDiku6YcqX4juoVntUc5q8+7U0NDUI3UqTzyxjcXQpT56CdLCkyPLWqwSj2DQpbzEiafJhK9RF5tDqwNZ25xQfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343185; c=relaxed/simple;
	bh=448SBkoBiwzNYFe1Prui80wVvjKBGxpGYFNFKqUs8TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwMG0tYcmzKk7bJLBOa9y9GbN6xZt23QJS+60j6Q+FAEQmorQKSYG9VUhzTi6f2v0BV7eGP3J3dUCOS5z0ZcbARa/BP+X1JDyeJtRff0Pta1NUIEWcyQHGkImbAjs/MfAx+21KpJ8dbFYipfI2Rwbe1XkH4OqIMTBIgtinD8HzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q3ODG9ME; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 316B4210B169;
	Wed, 27 Aug 2025 18:06:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 316B4210B169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343183;
	bh=fdZ5QdVm2w3ghFgzjQesxRAwjBlyGQ2xB47AuLuWzpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3ODG9MEuLHr6mYJHcgfCqPajrQGY+A/O7Ec2sym3AXPfSIPCETK5KszpkrqYBngR
	 xbCNJr/kl0LFf/aK2j5Q4CtixD3ucwG9n6J8dNsNbLij1yC7UGpcAug+bQYxZsclik
	 GgsKQJww0u6C5+ziOUcT678sI/iYpO1/O+ATC/5I=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
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
	sunilmut@microsoft.com,
	romank@linux.microsoft.com
Subject: [PATCH hyperv-next v5 12/16] Drivers: hv: Allocate encrypted buffers when requested
Date: Wed, 27 Aug 2025 18:05:53 -0700
Message-ID: <20250828010557.123869-13-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828010557.123869-1-romank@linux.microsoft.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
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
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c      | 49 +++++++++++++++++++++++----------------
 drivers/hv/hyperv_vmbus.h |  3 ++-
 drivers/hv/ring_buffer.c  |  5 ++--
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 7c7c66e0dc3f..1621b95263a5 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -444,20 +444,23 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
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
@@ -545,8 +548,10 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
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
@@ -677,12 +682,13 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
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
 
@@ -863,8 +869,11 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
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
index 545aedf2d03c..b67492b260a8 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -202,7 +202,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
 
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 pagecnt, u32 max_pkt_size);
+		       struct page *pages, u32 pagecnt, u32 max_pkt_size,
+			   bool confidential);
 
 void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 23ce1fb70de1..3c421a7f78c0 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -184,7 +184,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
 
 /* Initialize the ring buffer. */
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
-		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
+		       struct page *pages, u32 page_cnt, u32 max_pkt_size,
+			   bool confidential)
 {
 	struct page **pages_wraparound;
 	int i;
@@ -208,7 +209,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	ring_info->ring_buffer = (struct hv_ring_buffer *)
 		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
-			pgprot_decrypted(PAGE_KERNEL));
+			confidential ? PAGE_KERNEL : pgprot_decrypted(PAGE_KERNEL));
 
 	kfree(pages_wraparound);
 	if (!ring_info->ring_buffer)
-- 
2.43.0


