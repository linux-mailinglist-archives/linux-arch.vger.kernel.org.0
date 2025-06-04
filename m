Return-Path: <linux-arch+bounces-12200-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901FACD0E6
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AEB1756A9
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F40154423;
	Wed,  4 Jun 2025 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YCvebn2+"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5610B4AEE0;
	Wed,  4 Jun 2025 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997830; cv=none; b=AzuMVBu7r0doRSntLXw/rAk+9YaOZXltT2chwuSh+gFN37uwJFY0KNOX4KoTzZ69fn6fZgsNeXJcUPxi/Lu580uVHdB6qijHL4SFAyPaORf/Ypae9lughzMuXFkjDtGqNS9VeiWvRGN79nAisisl1lX4+DAxZGwdaOVHaSK0LOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997830; c=relaxed/simple;
	bh=afyzY3pm5CQTRuBJaTL/7fnXbhgafdMaXJITAblpCbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOff4A/QBwccINZfmnBeFjTOVCQH7oTR3FdEAgVGOtWLCy2GihGDevK1H3XyLUkXZHu75VCD7e7tr502gSmk6mIxW4s2TzrbdZIFxLKEAU05+y6Wi0A+L+nV3WDf2oYZCDVSyB0Tecd7QErEI0cnhxiCl1ZFujlvf13Vr+XtmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YCvebn2+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A31802117449;
	Tue,  3 Jun 2025 17:43:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A31802117449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997827;
	bh=tG251cKgdNqMSYQOyf9na8PTYaITUoZaTg9nS4Q7t4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCvebn2+o2bF1eUZEODy7ZVCLjjj4zIw+FwIVwNP2JRyhKOwLAGGuufjDfWJ/VTGi
	 fXyhSrNnEDFPu1yAWkswaJcD3hImJMK8mGh5f2/gIprNQkkDwzLil67hEzaIsqtI4b
	 mxdIDmBTOnqgdm3r0BcW7JrTrgNYxgI3khpF6oBI=
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
Subject: [PATCH hyperv-next v3 13/15] Drivers: hv: Support confidential VMBus channels
Date: Tue,  3 Jun 2025 17:43:39 -0700
Message-ID: <20250604004341.7194-14-romank@linux.microsoft.com>
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

To run a confidential VMBus channels, one has to initialize the
co_ring_buffers and co_external_memory fields of the channel
structure.

Advertise support upon negoatiating the version and compute
values for those fields and initialize them.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c | 19 +++++++++++++++++++
 drivers/hv/connection.c   |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index ca2fe10c110a..33bc29e826bd 100644
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
+	if (co_ring_buffer) {
+		if (vmbus_proto_version < VERSION_WIN10_V6_0 || !vmbus_is_confidential()) {
+			atomic_dec(&vmbus_connection.offer_in_progress);
+			return;
+		}
+	}
+
+	co_external_memory = is_co_external_memory(offer);
+	if (is_co_external_memory(offer)) {
+		if (vmbus_proto_version < VERSION_WIN10_V6_0 || !vmbus_is_confidential()) {
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


