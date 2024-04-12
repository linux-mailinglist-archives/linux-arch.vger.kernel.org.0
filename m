Return-Path: <linux-arch+bounces-3628-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70C8A30ED
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E436E1F23F23
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860661420C4;
	Fri, 12 Apr 2024 14:40:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAD13CF8A;
	Fri, 12 Apr 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932825; cv=none; b=tAWE4TlTWUDFkP1aW3QAJ6Q0si4jHMD5DFrW10wnwobbFXb3YZqYKdWNrvFhvaGddr8R9bC2x6hcWZWvkZfbr9LIhSNE+/SZiVu+EvUGsBqSmakoLfn5fCNATFJRBfGuUl3qJMMxdOcVMcfqJTAXrZA4Kf3eMs3cFsYF4ym6pJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932825; c=relaxed/simple;
	bh=z2WhAVTrf637bDu11h6vBJFFF/4AH5cUHWm5PG3cdck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzbIqahyA0UUxZVEMJNXv0JmyshuSeupKvlhj1bk6jBxXOmlJ1kNOoLyh2XMOjRS1HfHYDTdVQl6kZkxmNuHc7XgETmaNgj5RfEod6M/uFPC0ZtfTFwknyh0Y3rWmMDMSxgclu+f0VlAeHz4L3E7gdxPfyIOAocOAM4AlT8P//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGK1l59lbz6J9bP;
	Fri, 12 Apr 2024 22:38:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 70E54140B55;
	Fri, 12 Apr 2024 22:40:21 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:40:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel
 Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v5 06/18] ACPI: scan: Add parameter to allow defering some actions in acpi_scan_check_and_detach.
Date: Fri, 12 Apr 2024 15:37:07 +0100
Message-ID: <20240412143719.11398-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Precursor patch adds the ability to pass a flag (not yet used) into
acpi_scan_check_and detach().  Done in a separate patch with no
functional changes to reduce complexity of the actual deferal which
follows.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: New patch resulting from rebase.
    - Internal review suggested we could also do this with flags
      so I'm looking for feedback on which option people find
      more readable.
---
 drivers/acpi/scan.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7c157bf92695..79b1f4d2b6bd 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -244,13 +244,19 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_scan_check_and_detach(struct acpi_device *adev, void *check)
+struct acpi_scan_c_and_d_param {
+	bool check_status;
+	bool eject;
+};
+
+static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
 {
 	struct acpi_scan_handler *handler = adev->handler;
+	struct acpi_scan_c_and_d_param *param = p;
 
-	acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach, check);
+	acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach, p);
 
-	if (check) {
+	if (param->check_status) {
 		acpi_bus_get_status(adev);
 		/*
 		 * Skip devices that are still there and take the enabled
@@ -288,7 +294,11 @@ static int acpi_scan_check_and_detach(struct acpi_device *adev, void *check)
 
 static void acpi_scan_check_subtree(struct acpi_device *adev)
 {
-	acpi_scan_check_and_detach(adev, (void *)true);
+	struct acpi_scan_c_and_d_param p = {
+		.check_status = true, /* Not update until after ej0 */
+		.eject = false,
+	};
+	acpi_scan_check_and_detach(adev, &p);
 }
 
 static int acpi_scan_hot_remove(struct acpi_device *device)
@@ -2600,7 +2610,12 @@ EXPORT_SYMBOL(acpi_bus_scan);
  */
 void acpi_bus_trim(struct acpi_device *adev)
 {
-	acpi_scan_check_and_detach(adev, NULL);
+	struct acpi_scan_c_and_d_param p = {
+		.check_status = false,
+		.eject = false,
+	};
+
+	acpi_scan_check_and_detach(adev, &p);
 }
 EXPORT_SYMBOL_GPL(acpi_bus_trim);
 
-- 
2.39.2


