Return-Path: <linux-arch+bounces-13316-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B4B390B9
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0AC465181
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB224A043;
	Thu, 28 Aug 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lcZf3WIm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC524169F;
	Thu, 28 Aug 2025 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343186; cv=none; b=U4kpLgON4o8Oj+fAyoRCufIIG0qXb0dph/aWC/F/jy7or3pd+zNV7b0rCMyzLuEJgZZL9rOYj5SXoGd/DESZ0baNZVQ3jvhRvIspMB9eYhYj4nhqw9HGse1JZ0EgGGYOG5M0gjZblBUNKVQy3mQTUPbIVlVf6hJ/PhNToZRLJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343186; c=relaxed/simple;
	bh=jcVoEUC6G7ouyS96Awrxkpjvwjhit2JLovbajJzwPjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pATlIovhJvb2ka0sqBqwSn5eKkkoI0A2XbhL5/hykWkdB8GrSekSnyHuPfygYswX8I2Rxq8ZdH0xFNYf5lMJQNytQYT/NtQLEocoqNFeZw3mLaOFmvgSvU/w9dObz9OKkv+DxwYaD88pzVULALIxV1L/CI1ZN4hZWgGmqZIDr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lcZf3WIm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF74F2110804;
	Wed, 27 Aug 2025 18:06:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF74F2110804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343184;
	bh=vPPdHR5rGHXCKHfUfHe9L+EhGHapJo5+nFVjJFtXaHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcZf3WImSOokezTmgg8zhC7wREm+B1frNLLYpmqn5G5JRfPX7bNNr7Hgsnhb9u7Jd
	 Xu6OYUtKHHIZiWyjN3TLMQRF8jg3OYINi/o0CNS+57VliFMK/vdfGE9zMZh8j57+7t
	 tXEFZTIO6/RFP6MaWnPJrNDRnOPD9m0k9wTYSCNA=
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
Subject: [PATCH hyperv-next v5 13/16] Drivers: hv: Free msginfo when the buffer fails to decrypt
Date: Wed, 27 Aug 2025 18:05:54 -0700
Message-ID: <20250828010557.123869-14-romank@linux.microsoft.com>
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

The early failure path in __vmbus_establish_gpadl() doesn't deallocate
msginfo if the buffer fails to decrypt.

Fix the leak by breaking out the cleanup code into a separate function
and calling it where required.

Fixes: d4dccf353db80 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in Isolation VM")
Reported-by: Michael Kelley <mkhlinux@outlook.com>
Closes: https://lore.kernel.org/linux-hyperv/SN6PR02MB41573796F9787F67E0E97049D472A@SN6PR02MB4157.namprd02.prod.outlook.com
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/channel.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 1621b95263a5..70270202209b 100644
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


