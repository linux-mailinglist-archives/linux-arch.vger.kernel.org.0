Return-Path: <linux-arch+bounces-3750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A95E8A8454
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02A2B230CA
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1413E8A5;
	Wed, 17 Apr 2024 13:22:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6513C689;
	Wed, 17 Apr 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360169; cv=none; b=Dw4JDbDJcb6cWr2dq/6lDWt13hESClf+Ar0KCxuSgewlDZhIDXjlJJPVCnydHz02aywj8BYwQPe3b3nWJvBMet3J/2R4o3jJ/7bHxjMITnuZXO8POlsB6lUV+o6jUlg8N5HRTXKC41CYlsMQz/fQ9+4wKUNSncvP8G6oMNjVz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360169; c=relaxed/simple;
	bh=+y77+7QZby+LVdmrVnp+NoTqJPrXhj6o2AOLhNYOMfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGf5FqhAwddrzDPQJD5Av7z8lm1wKfOYBV/QeJ8EfjzFKGwkYgDwIDRAHiijierjjO9V0T9cOjR27Nmk7eYaSrMs7pCUKBDx+Wepw2xSy6ISeMHGXpMVLrWeTu7XOo7Kf9lp80dZExDrNLqFoLKtkvKkSBQRrBL8Amb2mR9/i+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKM0C6Nc2z6K7GV;
	Wed, 17 Apr 2024 21:17:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8333E140C9C;
	Wed, 17 Apr 2024 21:22:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 14:22:44 +0100
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
Subject: [PATCH v6 07/16] ACPI: scan: switch to flags for acpi_scan_check_and_detach();
Date: Wed, 17 Apr 2024 14:19:00 +0100
Message-ID: <20240417131909.7925-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Precursor patch adds the ability to pass a uintptr_t of flags into
acpi_scan_check_and detach() so that additional flags can be
added to indicate whether to defer portions of the eject flow.
The new flag follows in the next patch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v6: Based on internal feedback switch to less invasive change
    to using flags rather than a struct.
v5: New patch resulting from rebase.
    - Internal review suggested we could also do this with flags
      so I'm looking for feedback on which option people find
      more readable.
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


