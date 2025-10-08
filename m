Return-Path: <linux-arch+bounces-13973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3474ABC6E70
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24F9A4EB727
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AA02D63E5;
	Wed,  8 Oct 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IZ0fPwUH"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB52D320E;
	Wed,  8 Oct 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966472; cv=none; b=SimwYa5HyJs/IWIRdhpInJiJQEX5RHI1472VBgNsWkt7OH3rENaA7sT3JlCJBw/h6AYPnz/2vaquh18LaQhC+/jbeqospDxAynucNjakSfSQum88DMZpx3E+AccAysTkYRLp6vA/TYYQbuteFwTVrLVf8qyMJAv4mvVzCJkcib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966472; c=relaxed/simple;
	bh=cRVDFC2LLTaEruKHWjtQLz4rlG6E8UCZaFj6Usr1wa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is6R3Y6A93rIp53C5nRd5a2HUhMpQz8dKg6eVRNLMyZi3hfeuO1tAazw/4HKKESYv2HpYOBWeXaoOK6a8OBWLg5XmmJhNLvpuj7NU/J5U8lAK7diFqxjIffcJxc1QytzAGr/BK0kRifw1ghEWXWzgqb8AhypjHpd0iGeW1pizy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IZ0fPwUH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 508EC211B7D1;
	Wed,  8 Oct 2025 16:34:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 508EC211B7D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966469;
	bh=lLTSGrBaTN5y6gKG/MiXOcpE4ecS29uI64cqxHJrGcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZ0fPwUHLjvbPSTOzlUUhB8RtOecTbkmkRe8ZJBuWy3/HxHbgxdX7zLwC+phBMbTy
	 PeWeLPKbrwWGBJmh0tyU4hn57lGtl+vCM0iPq9Qljjwq0TpBBKO2IicMbSzDGSzNUA
	 dsvnR7nvZCTx06ptSepIkpnSdcmmSF24DLI2ofp4=
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
Subject: [PATCH hyperv-next v7 10/17] Drivers: hv: Check message and event pages for non-NULL before iounmap()
Date: Wed,  8 Oct 2025 16:34:12 -0700
Message-ID: <20251008233419.20372-11-romank@linux.microsoft.com>
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

It might happen that some hyp SynIC pages aren't allocated.

Check for that and only then call iounmap().

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 95631c08a71f..8e102bcc0be8 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -369,8 +369,10 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 */
 	simp.simp_enabled = 0;
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->hyp_synic_message_page);
-		hv_cpu->hyp_synic_message_page = NULL;
+		if (hv_cpu->hyp_synic_message_page) {
+			iounmap(hv_cpu->hyp_synic_message_page);
+			hv_cpu->hyp_synic_message_page = NULL;
+		}
 	} else {
 		simp.base_simp_gpa = 0;
 	}
@@ -381,8 +383,10 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.siefp_enabled = 0;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->hyp_synic_event_page);
-		hv_cpu->hyp_synic_event_page = NULL;
+		if (hv_cpu->hyp_synic_event_page) {
+			iounmap(hv_cpu->hyp_synic_event_page);
+			hv_cpu->hyp_synic_event_page = NULL;
+		}
 	} else {
 		siefp.base_siefp_gpa = 0;
 	}
-- 
2.43.0


