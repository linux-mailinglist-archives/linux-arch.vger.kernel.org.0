Return-Path: <linux-arch+bounces-12197-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF39EACD0DC
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA013A759E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04FB13B58C;
	Wed,  4 Jun 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O7fBzkqF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D871E519;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997829; cv=none; b=Ppd8witQf0dPZTUTuFNDdDIf4IkzqILN0WJt/Nf41EzzKoOpzDG6O4fhOdTMWK6YhDd8rk0qadQuonNcDP3rtYTcEBZo6kR/h+wRdm6uXaZO8e2nsyi85zWH3WApz/MfI5h5toWH9JcZtXBdM5ug8VqD9JSyk0uTXaaTFppy6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997829; c=relaxed/simple;
	bh=Z2a9TzfIsBx6WMfuQqjTzSaUgD3Resw90i86KAVIP6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTML19VUOEjSkeitv45Yv7ivzrb76Cr9Wnst0eiBCddJbSCZrN8ap8k6BY0edSHMPEIZV0/V/6v5SYdZ4OZxmLvd7VJMgnvjvZvvli38HCymdjBwxbppwTV+Osl7C1y+F568hUhPCuuTBuNZY8qobgslgVLT40MVlbzcdxDlNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O7fBzkqF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 30C2E2117441;
	Tue,  3 Jun 2025 17:43:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30C2E2117441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997826;
	bh=njYzXPLBXWszHfRNWp7EuYdZXKPASUgohOyGSK4pdFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O7fBzkqF6w2hGSpwMWVGZPljeDJ5BKyANglSzBkU2Nyd6MU/YG/51DnwPoI8vx72P
	 dWqWRqMUXwYRyKpwIP93KKCgqcHzBuVi2Yrkq0y+FZUEO7+0rrBTQF/1CVsSXBeZjE
	 Whn0O+aI0aOm76mtNNH1BgZ9NtQ3H/6n3B/pkvyQ=
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
Subject: [PATCH hyperv-next v3 07/15] Drivers: hv: Post messages via the confidential VMBus if available
Date: Tue,  3 Jun 2025 17:43:33 -0700
Message-ID: <20250604004341.7194-8-romank@linux.microsoft.com>
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

When the confidential VMBus is available, the guest should post
messages via the paravisor.

Update hv_post_message() to request posting messages from the paravisor
rather than through GHCB or TD calls.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index e25c91eb6af5..1f7cf1244509 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -74,7 +74,7 @@ int hv_post_message(union hv_connection_id connection_id,
 	aligned_msg->payload_size = payload_size;
 	memcpy((void *)aligned_msg->payload, payload, payload_size);
 
-	if (ms_hyperv.paravisor_present) {
+	if (ms_hyperv.paravisor_present && !vmbus_is_confidential()) {
 		if (hv_isolation_type_tdx())
 			status = hv_tdx_hypercall(HVCALL_POST_MESSAGE,
 						  virt_to_phys(aligned_msg), 0);
-- 
2.43.0


