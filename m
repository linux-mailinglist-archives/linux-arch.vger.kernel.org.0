Return-Path: <linux-arch+bounces-13312-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7351B390AA
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05024650FC
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889D2367D9;
	Thu, 28 Aug 2025 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dvyq0juu"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82CA22D7B0;
	Thu, 28 Aug 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343182; cv=none; b=T2VNuxwUUeuByiT3Z4LSyIBZub3PWI0u72M3WjEvMs/uKoKhBWj7rHKSdXgf0VlfES/wEZTm8jrNlrkHhk21p1qSy0AZAkNglrEJT9E9VcrSOwGBWE14S/xPwnM+6F3y9VsxfBg8R9N01XcC4cK2kLb1rtxU2wMLehNZLwWnrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343182; c=relaxed/simple;
	bh=gO/nDfnEEVrt5WNawBFN69RYLj/20kMhsF70Nab3hZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO6YnBT+4U5Zsk7i5ibYtVy7dX9gl74+6a2KhOgYQoyOS+K0XThKn1BQITV+wDWZI+GgcBB7XJgOH8BpZWkRFSXDJyrqGrw6nQ0iAiBFlsJu8vS9mrMUcWBSHXOmysI7wcNvXC1hrPgHKN0HR7HeUVneQSl5rxEZ046fFw2Eun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dvyq0juu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 498B32110812;
	Wed, 27 Aug 2025 18:06:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 498B32110812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343178;
	bh=uLWjGU1BrMNuCP32lJHAdujV4slTm2VGDaDmbe5sy70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dvyq0juu7E8BfzvAS2kYzyfBkL2ZBU9MskuJVkprfxz+GnR1Q3UaIYrfvH6LDzPz2
	 mkHpg8UHMKwNS62yfLYKup6/P1mRPdKhg8qXV+flGdB6e1fqwUFtJosUIwyE0MCLdu
	 UvrUgw5TRmAiDrREW+yQzaXs9krGzvupxNsjL4Ws=
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
Subject: [PATCH hyperv-next v5 09/16] Drivers: hv: Check message and event pages for non-NULL before iounmap()
Date: Wed, 27 Aug 2025 18:05:50 -0700
Message-ID: <20250828010557.123869-10-romank@linux.microsoft.com>
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

It might happen that some hyp SynIC pages aren't allocated.

Check for that and only then call iounmap().

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 1e7fd7c19c58..7c5f35806e77 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -372,8 +372,10 @@ void hv_synic_disable_regs(unsigned int cpu)
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
@@ -384,8 +386,10 @@ void hv_synic_disable_regs(unsigned int cpu)
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


