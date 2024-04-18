Return-Path: <linux-arch+bounces-3796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CB38A9BDD
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 15:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B3F2817EB
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580C1635D1;
	Thu, 18 Apr 2024 13:57:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCE160796;
	Thu, 18 Apr 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448672; cv=none; b=rsfTsC5FUcskQhOiqUPdXt1YraFxyfm7i/vqCsAyIjzpVIRSjsDJ10ZW+JRQfieK83HPtFiLZ+39m3sbw8G49k0k5IV3Zb5C+11J1PfQPb5z4ZBDqSUtT7hZ9xelQIUNosktqNDK96qsbpWoaip1tOKOgR+UYK2wo5A23vJegvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448672; c=relaxed/simple;
	bh=Fg1Uw/EE5fB2oyPrQhHIjgnrktVY0yIzZa7BULUrzRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZL9nhYHlswaIJUVI5zMqZ3vbCnkL4pG5Hp9Yr0DuCitZ16eR/MzTHfAfzemKYK7ZiHHiDqFMt5CeT6EqztMAjci2ApVuQ/aXaD9Tv2gZHimmf2PzTX9cS79VoQx54HCcHTCv/ryZJ2oT/X9KeAADH+OEmFH2c8U6UNUHIkyWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKznZ1rkyz6D955;
	Thu, 18 Apr 2024 21:55:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 147261406AC;
	Thu, 18 Apr 2024 21:57:49 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:57:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v7 07/16] ACPI: scan: switch to flags for acpi_scan_check_and_detach()
Date: Thu, 18 Apr 2024 14:54:03 +0100
Message-ID: <20240418135412.14730-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Precursor patch adds the ability to pass a uintptr_t of flags into
acpi_scan_check_and detach() so that additional flags can be
added to indicate whether to defer portions of the eject flow.
The new flag follows in the next patch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v7: No change
v6: Based on internal feedback switch to less invasive change
    to using flags rather than a struct.
---
 drivers/acpi/scan.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d1464324de95..1ec9677e6c2d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -244,13 +244,16 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
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
@@ -288,7 +291,9 @@ static int acpi_scan_check_and_detach(struct acpi_device *adev, void *check)
 
 static void acpi_scan_check_subtree(struct acpi_device *adev)
 {
-	acpi_scan_check_and_detach(adev, (void *)true);
+	uintptr_t flags = ACPI_SCAN_CHECK_FLAG_STATUS;
+
+	acpi_scan_check_and_detach(adev, (void *)flags);
 }
 
 static int acpi_scan_hot_remove(struct acpi_device *device)
@@ -2601,7 +2606,9 @@ EXPORT_SYMBOL(acpi_bus_scan);
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


