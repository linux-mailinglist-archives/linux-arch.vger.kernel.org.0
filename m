Return-Path: <linux-arch+bounces-13971-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE6EBC6E4F
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72DCB4EA7D2
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55942D374A;
	Wed,  8 Oct 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fLXJpDME"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278722D1911;
	Wed,  8 Oct 2025 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966470; cv=none; b=Q748VfjYp0OS5yPdkmi6otmxTvOLKZMTxY/rWDvAkK4ONZTNIPDqcy86gS0O6J333XpHnOio8Dv8cPHxTYuZB48OnJ6lu1vsG3ktFYBFlBkqFcu71ShTzGHW/Sy9LNzE43+X8zKTDe4O9NdKUAeBd5LLnWHoWIBNKvKh28GFedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966470; c=relaxed/simple;
	bh=QrjgDhfUYEiE2JmDWJqZFzILCDgpPrTC9WtUjLJlBAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=es0b7EVW3OSFO7m4G1UA4StVL06aRYmxUA3XQNK4H3vohR3xM0CCidrXz6JRTM/Ri+d+lIRbFCL3yly5q43FEo8+vfhCLyRT8GIwgncOUwfKsRR9LvhAv2qgJAz7JeXJNVeWUrApjDiL0FA3Ii/HAZysnRMq43Eg/Egzl8S5TmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fLXJpDME; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5513C211AF37;
	Wed,  8 Oct 2025 16:34:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5513C211AF37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966468;
	bh=zA4+/A3eGa9jS47gg2tblmQ4Wwt0MSCKxw5bVUpv0k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLXJpDMEFIM0WkAcYCvlbrrUghobJ6xpqMFNomYssdhm6ZIPF+lfqt82+o+JDc/ef
	 Ca+D9kx6rzcL+GD0uBqXmdXv6+4Dl1A0dt7MFnsIWnZ6A0oD47oG6xA/VltPYTBj5g
	 CEW+2kvxRsXKU2/n8kNIZCDoU7fC33W67nHdjcbQ=
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
Subject: [PATCH hyperv-next v7 08/17] Drivers: hv: Post messages through the confidential VMBus if available
Date: Wed,  8 Oct 2025 16:34:10 -0700
Message-ID: <20251008233419.20372-9-romank@linux.microsoft.com>
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
index 90db1e17582d..b1085473778c 100644
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
@@ -88,6 +92,11 @@ int hv_post_message(union hv_connection_id connection_id,
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


