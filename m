Return-Path: <linux-arch+bounces-13310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37757B390A1
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D54462EC3
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436381D9A5D;
	Thu, 28 Aug 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ln2tlmgm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB03B2236F3;
	Thu, 28 Aug 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343179; cv=none; b=BUNAkPpvk+uTFI3CZi7ga04V3e2RbDcLXEzx0ys2TVnvRjh3s+YMHnFNYy9fEOaY008ULZ7Z3AyAO3kNjOLEW1t+Nz0fsN0TNPaHEfhVLRBga4oX9IcFH46aifQcIEAtZfUrEY9X24z3ryIUbcGN3Gs84h7zYztRxZ4et9JVDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343179; c=relaxed/simple;
	bh=+8RHaJdYcVc7kZKuDE/CFEeCPKBh4NFu+4aQ7NZRkXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHgiWbRV7kv0/6Y9xKdor6d1zM6q8AjC6Y4XeqZRtVuP90nhFDzWJknbrVsbU5fh7Dp44+Cj3vln6fEfjDJ+MFJskgQxiGxfnrA3jPRGaeU9R3N3iLLiHAp5UxduQr7DUyF493wPnzlbKZO5bAMceybEoNH3uwHW2+mcGrDq+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ln2tlmgm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id D9EBE211080D;
	Wed, 27 Aug 2025 18:06:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9EBE211080D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343173;
	bh=paqcN2NAldvGBvePCmiQQJen5x3ZiIEH2IdsQY0qLHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ln2tlmgmZ/PsB4NKl58vEhAcuworQxid+SwNlInD9kqYHfhU47haID8rpt2bhHrTR
	 e56p+jvUkb5FzRZh1eJwr2hksA9YtzTMEhnJKJ2osnjL/y86wOQ0W08fs4tivQp/vK
	 N9dqadSdbTw7UkZf+chfcESGywuTqp7KqnsPtIK8=
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
Subject: [PATCH hyperv-next v5 07/16] Drivers: hv: Post messages through the confidential VMBus if available
Date: Wed, 27 Aug 2025 18:05:48 -0700
Message-ID: <20250828010557.123869-8-romank@linux.microsoft.com>
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

When the confidential VMBus is available, the guest should post
messages to the paravisor.

Update hv_post_message() to post messages to the paravisor rather than
through GHCB or TD calls.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fe97591bc44d..951330ca4ba9 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -76,7 +76,11 @@ int hv_post_message(union hv_connection_id connection_id,
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
@@ -90,6 +94,11 @@ int hv_post_message(union hv_connection_id connection_id,
 		u64 control = HVCALL_POST_MESSAGE;
 
 		control |= hv_nested ? HV_HYPERCALL_NESTED : 0;
+		/*
+		 * If there is no paravisor, this will go to the hypervisor.
+		 * In the Confidential VMBus case, there is the paravisor
+		 * to which this will trap.
+		 */
 		status = hv_do_hypercall(control, aligned_msg, NULL);
 	}
 
-- 
2.43.0


