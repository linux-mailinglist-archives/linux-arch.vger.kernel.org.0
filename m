Return-Path: <linux-arch+bounces-12195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4735ACD0D8
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0974D7A9753
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011686250;
	Wed,  4 Jun 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QiqoC+yL"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83523286A1;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997829; cv=none; b=iz2rLq/imBH12zvqwWi0vwD2UXaYY9aHkfTNyWcBcDqTJZ3pfgGQoGbdrP/sHL643HTMU7zN1kBaJzXcuMpJPJh9gKCf5Kw/sZyI0niupSv93nyslibSzHUgXwvOg50mVwrrik8DWd72eFN9iprLxKUXmSWIZNwbGhcb9/5lwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997829; c=relaxed/simple;
	bh=HBQr7m9q3N3TQWANmfZROgY/3eYF1L7aiZwfZ2AV4Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHmVY9Izn4DnXidXxty+OnLBu/KbIsKgnojCoxISDfqY76k8jGo8slfdKOAxW1s5qUe6ekkBg5w9yQ5N0XjlpiopPG1nkajNHWIV6GGZC1dAm0mvH9kvp8YaO58H8yHMsyUfg2URkxlVMVkpX7BWYmT5/qFOZvttWEdOHau6P0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QiqoC+yL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A79C72117447;
	Tue,  3 Jun 2025 17:43:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A79C72117447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997826;
	bh=ftxOWRCisP0EsHUqwVLwCROgXQzvFotG1fMQh4+Adsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiqoC+yLZZklcLTqWGKPbc+HQfrSPMO6MJLDmCJ+rA9rGVd0yRfD2wuE8EWTAjVxP
	 3dsh4vkv8nqroPXThXm59Ly7J2RihhGRtuGm4eYgrljlss6p18y1VcOX9Q322VCc/k
	 mc/S1w7tyBEOMFlTo87sKUY6SNUWMWs03D9TnpzE=
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
Subject: [PATCH hyperv-next v3 09/15] Drivers: hv: Use memunmap() to check if the address is in IO map
Date: Tue,  3 Jun 2025 17:43:35 -0700
Message-ID: <20250604004341.7194-10-romank@linux.microsoft.com>
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

It might happen that some hyp SynIC pages aren't IO mapped.

Use memunmap() that checks for that and only then calls iounmap()

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 6a4857def82d..9a66656d89e0 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -358,7 +358,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 */
 	simp.simp_enabled = 0;
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->hyp_synic_message_page);
+		memunmap(hv_cpu->hyp_synic_message_page);
 		hv_cpu->hyp_synic_message_page = NULL;
 	} else {
 		simp.base_simp_gpa = 0;
@@ -370,7 +370,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.siefp_enabled = 0;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->hyp_synic_event_page);
+		memunmap(hv_cpu->hyp_synic_event_page);
 		hv_cpu->hyp_synic_event_page = NULL;
 	} else {
 		siefp.base_siefp_gpa = 0;
-- 
2.43.0


