Return-Path: <linux-arch+bounces-12762-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67C0B04A3A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12533AE5B5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FE927FD52;
	Mon, 14 Jul 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D/4xcalO"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFA278E75;
	Mon, 14 Jul 2025 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531353; cv=none; b=DOAiDMnF6B3DKVGST1c2RSEL4+rtZBjL16+vK0/sGrmiSFdl57/NpZ1YiYUlp6UIlQ160FQh9xcoziCvnLIy66hppj9I3W+B5YVxGZfD9KiO8G1p/oK/IInqOpAnzOaQ2uZ54bYgXs7w/8NrAo6NdoaPTdn3WKg5tfyzF+R0VbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531353; c=relaxed/simple;
	bh=PDoW0cTwMd+zaYHHMOCKb9goqInwTZCebB8VI+uMRE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyLcrRd4ebVNeGN6C2n6P/51ErzK0HVh2h11Y45Dv19SoWmNgJGMqO1mQBqTnRTj96HWgrtn1U1/MDMqQGGtp71Tw6iNX8bqXfa9ljZOvx0Zidd3oA4TD7C2M8BmuexRX7He74P0e0e/oj7DhvpyvrpoOjTz9gx2J70nOOLgA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D/4xcalO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D37A52016592;
	Mon, 14 Jul 2025 15:15:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D37A52016592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531349;
	bh=2Uj5+MWRT6Nrb2e5uPnnI56BMuCGOG4Pghr4svS0DvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/4xcalOyAiEZbazwtk4xGsxXLYvYZuuLwvfe/OzzaZpYr0LDrg9/j0DBkx5JZpPk
	 xkrIRZbDUy1z46KfVEcAS8sV3qlJvlP/L52HatvDPz0o1uGiN/eq297peiCS6Q+INy
	 hSRPS8RCx4tGFYbtI1OyI8+t7PRmtTVl3UUmCC10=
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
Subject: [PATCH hyperv-next v4 07/16] Drivers: hv: Post messages through the confidential VMBus if available
Date: Mon, 14 Jul 2025 15:15:36 -0700
Message-ID: <20250714221545.5615-8-romank@linux.microsoft.com>
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

When the confidential VMBus is available, the guest should post
messages to the paravisor.

Update hv_post_message() to post messages to the paravisor rather than
through GHCB or TD calls.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index e9ee0177d765..816f8a14ff63 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -74,7 +74,11 @@ int hv_post_message(union hv_connection_id connection_id,
 	aligned_msg->payload_size = payload_size;
 	memcpy((void *)aligned_msg->payload, payload, payload_size);
 
-	if (ms_hyperv.paravisor_present) {
+	if (ms_hyperv.paravisor_present && !vmbus_is_confidential()) {
+		/*
+		 * If the VMBus isn't confidential, use the CoCo-specific
+		 * mechanism to communicate with the hypervisor.
+		 */
 		if (hv_isolation_type_tdx())
 			status = hv_tdx_hypercall(HVCALL_POST_MESSAGE,
 						  virt_to_phys(aligned_msg), 0);
@@ -85,6 +89,11 @@ int hv_post_message(union hv_connection_id connection_id,
 		else
 			status = HV_STATUS_INVALID_PARAMETER;
 	} else {
+		/*
+		 * If there is no paravisor, this will go to the hypervisor.
+		 * In the Confidential VMBus case, there is the paravisor
+		 * to which this will trap.
+		 */
 		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
 					 aligned_msg, NULL);
 	}
-- 
2.43.0


