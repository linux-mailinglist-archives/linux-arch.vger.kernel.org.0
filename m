Return-Path: <linux-arch+bounces-3627-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E78A30EB
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FC6B252F7
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F991142E8D;
	Fri, 12 Apr 2024 14:39:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735781420BC;
	Fri, 12 Apr 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932794; cv=none; b=jz3HQFAR6HIdRZOx3vy9Gc3ldwp5vtbkH27wsqcV4kFa2pvRkxcV/rmS0LKUuuMi7HEvjMpcTojkdJw8gOJB3IK5DLF+PmqXkaQhIQFsTfHEq+A1lg29UmxAie0dygERFfYVAJBdGmJUiXP4rj9tv6SgfNisUWqWNEO8I8pGQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932794; c=relaxed/simple;
	bh=G1mzVNFMFyOtaShtcH55y0Nz0XzTkDiTC1NulscfBlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeGMJ3iqdVoh8s5t2EDVmZL7GFah5p8C+kWX8KVLhSR691d5CqoGjQXonFBxPZ6xXIxvyUXfK6fVKXisEJQW/9JFpd2WNzxYcVgfP6IPNIKg1gfUkWfmyHpkj/vG+0aJOwMJy9kTDkW6QhMUV9bjfOw1Lcz+/I33Tg3oma+up3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGK185tN4z67GVD;
	Fri, 12 Apr 2024 22:38:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9073F1408FE;
	Fri, 12 Apr 2024 22:39:50 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:39:50 +0100
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
Subject: [PATCH v5 05/18] ACPI: utils: Add an acpi_sta_enabled() helper and use it in acpi_processor_make_present()
Date: Fri, 12 Apr 2024 15:37:06 +0100
Message-ID: <20240412143719.11398-6-Jonathan.Cameron@huawei.com>
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

A device is enabled only if both the present and enabled bits
are set in the result of calling the _STA method, or the
_STA method is not present (in which case the device is always
present and enabled).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: New patch
---
 drivers/acpi/acpi_processor.c |  8 +++-----
 drivers/acpi/utils.c          | 21 +++++++++++++++++++++
 include/acpi/acpi_bus.h       |  1 +
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 05264722c207..3aa43dee4391 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -185,8 +185,6 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 /* Initialization */
 static int acpi_processor_make_present(struct acpi_processor *pr)
 {
-	unsigned long long sta;
-	acpi_status status;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
@@ -195,9 +193,9 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
 	if (invalid_phys_cpuid(pr->phys_id))
 		return -ENODEV;
 
-	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
-	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
-		return -ENODEV;
+	ret = acpi_sta_enabled(pr->handle);
+	if (ret)
+		return ret;
 
 	cpu_maps_update_begin();
 	cpus_write_lock();
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 202234ba54bd..3004426b218c 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -744,6 +744,27 @@ acpi_status acpi_evaluate_reg(acpi_handle handle, u8 space_id, u32 function)
 }
 EXPORT_SYMBOL(acpi_evaluate_reg);
 
+int acpi_sta_enabled(acpi_handle handle)
+{
+	unsigned long long sta;
+	bool present, enabled;
+	acpi_status status;
+
+	if (acpi_has_method(handle, "_STA")) {
+		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		present = sta & ACPI_STA_DEVICE_PRESENT;
+		enabled = sta & ACPI_STA_DEVICE_ENABLED;
+		if (!present || !enabled) {
+			return -EPROBE_DEFER;
+		}
+		return 0;
+	}
+	return 0; /* No _STA means always on! */
+}
+
 /**
  * acpi_evaluate_dsm - evaluate device's _DSM method
  * @handle: ACPI device handle
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5de954e2b18a..e193507fd743 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -51,6 +51,7 @@ bool acpi_ata_match(acpi_handle handle);
 bool acpi_bay_match(acpi_handle handle);
 bool acpi_dock_match(acpi_handle handle);
 
+int acpi_sta_enabled(acpi_handle handle);
 bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
-- 
2.39.2


