Return-Path: <linux-arch+bounces-13977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C93FBC6E9D
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D65534E8E1
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C242DD5E2;
	Wed,  8 Oct 2025 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OyB0sLbd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FA2DC78F;
	Wed,  8 Oct 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966477; cv=none; b=biZiKYC5RAK5qJJK0PYsjDyRnqWOCFMaDxo/N+732hdxs44owaZhbzB3im5W+QczgtOryNePasZSt0JkPmTVDCXCeymCAeAdh1tWtJNiCM5jPI3DbJy57JwIfhEF7/LtR5xK+K8qAViuz1BpAoZf105S98zUnzDpEB0tEfTLbGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966477; c=relaxed/simple;
	bh=Fkn/javTiww3cFoTkMbsTMJizV3BWu9Hp9OMgATsTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBlccH5YbiRVj9MQcG+ee+o9nx5HkHxUv9TO6nsLbjSZMwYo6aZsqvQ40dj3T5lgUnEbS/fm1Leum0XXtexhW4icFlnF/8/FhSXFSNkpdSf/XbfobRJXqia9zU/9xPDdH2Q6zLktL+Re/4xhcfyQm5qr+zdbHaocvy22/jRbvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OyB0sLbd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 74DE6211CE10;
	Wed,  8 Oct 2025 16:34:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74DE6211CE10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966474;
	bh=KOeZVTeTzRHNYVd4hRy4Pl2r3BRcW7MVMnUEOSxzTv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyB0sLbdYB+fUFBbIvRWe8IsmOQ/r9PRKzYSXY+9iOm94+4V8wiwjcnoV+uccJG7q
	 P530EqkNTfpQedue+WfOaeCsrRKlkh5dFai4TlEncAeIq3kOEtxOtyX7d0kV7R5AV3
	 dVIpU2fVZARaLrdQ4tZFS3J2zK7O2nK56rYBVqSA=
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
Subject: [PATCH hyperv-next v7 14/17] Drivers: hv: Free msginfo when the buffer fails to decrypt
Date: Wed,  8 Oct 2025 16:34:16 -0700
Message-ID: <20251008233419.20372-15-romank@linux.microsoft.com>
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

The early failure path in __vmbus_establish_gpadl() doesn't deallocate
msginfo if the buffer fails to decrypt.

Fix the leak by breaking out the cleanup code into a separate function
and calling it where required.

Fixes: d4dccf353db80 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in Isolation VM")
Reported-by: Michael Kelley <mkhlinux@outlook.com>
Closes: https://lore.kernel.org/linux-hyperv/SN6PR02MB41573796F9787F67E0E97049D472A@SN6PR02MB4157.namprd02.prod.outlook.com
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index d69713201bef..88485d255a42 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -410,6 +410,21 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 	return 0;
 }
 
+static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msginfo)
+{
+	struct vmbus_channel_msginfo *submsginfo, *tmp;
+
+	if (!msginfo)
+		return;
+
+	list_for_each_entry_safe(submsginfo, tmp, &msginfo->submsglist,
+				 msglistentry) {
+		kfree(submsginfo);
+	}
+
+	kfree(msginfo);
+}
+
 /*
  * __vmbus_establish_gpadl - Establish a GPADL for a buffer or ringbuffer
  *
@@ -429,7 +444,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	struct vmbus_channel_gpadl_header *gpadlmsg;
 	struct vmbus_channel_gpadl_body *gpadl_body;
 	struct vmbus_channel_msginfo *msginfo = NULL;
-	struct vmbus_channel_msginfo *submsginfo, *tmp;
+	struct vmbus_channel_msginfo *submsginfo;
 	struct list_head *curr;
 	u32 next_gpadl_handle;
 	unsigned long flags;
@@ -459,6 +474,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 			dev_warn(&channel->device_obj->device,
 				"Failed to set host visibility for new GPADL %d.\n",
 				ret);
+			vmbus_free_channel_msginfo(msginfo);
 			return ret;
 		}
 	}
@@ -535,12 +551,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
 	list_del(&msginfo->msglistentry);
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
-	list_for_each_entry_safe(submsginfo, tmp, &msginfo->submsglist,
-				 msglistentry) {
-		kfree(submsginfo);
-	}
 
-	kfree(msginfo);
+	vmbus_free_channel_msginfo(msginfo);
 
 	if (ret) {
 		/*
-- 
2.43.0


