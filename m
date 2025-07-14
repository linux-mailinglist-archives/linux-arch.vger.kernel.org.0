Return-Path: <linux-arch+bounces-12769-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3793B04A5A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41603BA43A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB02868B2;
	Mon, 14 Jul 2025 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jNBpM4Dr"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBD0279910;
	Mon, 14 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531355; cv=none; b=cMQ93vwodensz2lvDH7p95UUuLG3mzvuBKXkkGO0vzBFD7B/rWrZlb262afiOR+AjPvYnKdC/9Yn4q7uQ4CSydKBTMHpfR4fYhwgCQy/mehxnDN24wUxON/XXn6+DUu6wPO8Rd452UdFQFUSXVZYQIwSNxR6H9cpeOrKHf0MiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531355; c=relaxed/simple;
	bh=nY7Uk25eXZ9CPEhq+dyPOCFpcECMFILdyIxZJrORP78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmxhw7d81fs/PLqBOk/iZwK80UD8xmDiSigi+0P5OTDwBgRZxrxHt2yQCxFbartMW7EE3YOysuLlISpba4mxry62UTLpx8keEENrvOOIO01tmEzgtm3yVY5HGzqBVrUCGQmzG3oCjrmEa/mJYCVcyC+N+7uAkWBHXWVKce+2tF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jNBpM4Dr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 793BB201A4B1;
	Mon, 14 Jul 2025 15:15:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 793BB201A4B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531350;
	bh=pT4iPwLX5Hd9PCSn3JAM0vAmXvwVMyakn8rD4WQrInY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNBpM4DrcoEA9sgu9QlkBKL7tQixnDlRM+9ZWYVLN8uj2NB8NP02cFs9sBREnZSq1
	 k33hzO/oAfNtIZjkgbC+aeiEzS9A2C+RbPIJkl2SAzSyO6SSwMIRvNp+T0QJNx4Pa0
	 gzw+EFOsOoxR8s9xD/uLg7iGI340LV6VdL2sTsEI=
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
Subject: [PATCH hyperv-next v4 13/16] Drivers: hv: Free msginfo when the buffer fails to decrypt
Date: Mon, 14 Jul 2025 15:15:42 -0700
Message-ID: <20250714221545.5615-14-romank@linux.microsoft.com>
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

The early failure path in __vmbus_establish_gpadl() doesn't deallocate
msginfo if the buffer fails to decrypt.

Fix the leak by breaking out the cleanup code into a separate function
and calling it where required.

Fixes: d4dccf353db80 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in Isolation VM")
Reported-by: Michael Kelly <mkhlinux@outlook.com>
Closes: https://lore.kernel.org/linux-hyperv/SN6PR02MB41573796F9787F67E0E97049D472A@SN6PR02MB4157.namprd02.prod.outlook.com
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/channel.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 051eeba800f2..0eb300b940db 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -409,6 +409,25 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 	return 0;
 }
 
+static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msginfo)
+{
+	unsigned long flags;
+	struct vmbus_channel_msginfo *submsginfo, *tmp;
+
+	if (!msginfo)
+		return;
+
+	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
+	list_del(&msginfo->msglistentry);
+	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
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
@@ -428,7 +447,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	struct vmbus_channel_gpadl_header *gpadlmsg;
 	struct vmbus_channel_gpadl_body *gpadl_body;
 	struct vmbus_channel_msginfo *msginfo = NULL;
-	struct vmbus_channel_msginfo *submsginfo, *tmp;
+	struct vmbus_channel_msginfo *submsginfo;
 	struct list_head *curr;
 	u32 next_gpadl_handle;
 	unsigned long flags;
@@ -458,6 +477,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 			dev_warn(&channel->device_obj->device,
 				"Failed to set host visibility for new GPADL %d.\n",
 				ret);
+			vmbus_free_channel_msginfo(msginfo);
 			return ret;
 		}
 	}
@@ -531,15 +551,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
 
 cleanup:
-	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
-	list_del(&msginfo->msglistentry);
-	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
-	list_for_each_entry_safe(submsginfo, tmp, &msginfo->submsglist,
-				 msglistentry) {
-		kfree(submsginfo);
-	}
-
-	kfree(msginfo);
+	vmbus_free_channel_msginfo(msginfo);
 
 	if (ret) {
 		/*
-- 
2.43.0


