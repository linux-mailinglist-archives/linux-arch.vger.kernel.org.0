Return-Path: <linux-arch+bounces-4591-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073D8D37F2
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 15:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FEB287982
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5317C98;
	Wed, 29 May 2024 13:39:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9811BC43;
	Wed, 29 May 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989969; cv=none; b=q/qZyhcUpWtaHRFUuiD+r6vy/LLFLDBhgWIbRTX9erdFqzzR7ymQzapDPP9mFrHlQ8ttHFmZMqQoWHsASS6dqARCfAa0rRKfWsnxOhZz7Ds0UZLBoYpsylxmxiA/hV9Fy+/w2wx2MsXH32d9f2csmPAs//BVBRnga4A47u+3lns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989969; c=relaxed/simple;
	bh=3q61VG1Ik4rX8YqbN6++r4IfLmipSRRTHufrzeAz2Uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sh4tU4wADScDdl/lrP/k8Xylpesx8PAv+0teUlZH4UX+U/09f4QPdUYVI3otedV5kXCvq6gWdQTM9CAZAZRqlsmpd8Ww57/gHvk2dmZLQ4SHLrFKBcq6nzx0kdVx3F7ahb0hor3kCwr2enLuVP1hREvI5vKjHh4AIDT5uwWeSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq9Nv6hqCz6J6nh;
	Wed, 29 May 2024 21:35:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B4BCE140B55;
	Wed, 29 May 2024 21:39:25 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 14:39:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, <loongarch@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin
 Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v10 09/19] ACPI: scan: switch to flags for acpi_scan_check_and_detach()
Date: Wed, 29 May 2024 14:34:36 +0100
Message-ID: <20240529133446.28446-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Precursor patch adds the ability to pass a uintptr_t of flags into
acpi_scan_check_and detach() so that additional flags can be
added to indicate whether to defer portions of the eject flow.
The new flag follows in the next patch.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/scan.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 503773707e01..4d649ce5876f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -243,13 +243,16 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_scan_check_and_detach(struct acpi_device *adev, void *check)
+#define ACPI_SCAN_CHECK_FLAG_STATUS	BIT(0)
+
+static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
 {
 	struct acpi_scan_handler *handler = adev->handler;
+	uintptr_t flags = (uintptr_t)p;
 
-	acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach, check);
+	acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach, p);
 
-	if (check) {
+	if (flags & ACPI_SCAN_CHECK_FLAG_STATUS) {
 		acpi_bus_get_status(adev);
 		/*
 		 * Skip devices that are still there and take the enabled
@@ -287,7 +290,9 @@ static int acpi_scan_check_and_detach(struct acpi_device *adev, void *check)
 
 static void acpi_scan_check_subtree(struct acpi_device *adev)
 {
-	acpi_scan_check_and_detach(adev, (void *)true);
+	uintptr_t flags = ACPI_SCAN_CHECK_FLAG_STATUS;
+
+	acpi_scan_check_and_detach(adev, (void *)flags);
 }
 
 static int acpi_scan_hot_remove(struct acpi_device *device)
@@ -2596,7 +2601,9 @@ EXPORT_SYMBOL(acpi_bus_scan);
  */
 void acpi_bus_trim(struct acpi_device *adev)
 {
-	acpi_scan_check_and_detach(adev, NULL);
+	uintptr_t flags = 0;
+
+	acpi_scan_check_and_detach(adev, (void *)flags);
 }
 EXPORT_SYMBOL_GPL(acpi_bus_trim);
 
-- 
2.39.2


