Return-Path: <linux-arch+bounces-4075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C561A8B7999
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 16:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5BF285EC7
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD417966C;
	Tue, 30 Apr 2024 14:26:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687CB1527A2;
	Tue, 30 Apr 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487171; cv=none; b=HChPwYitJi80zuakRGoZQtXjfQam0jQuwRgqa6A/Cm+lUhqFvgyPMSzt7R1K8wfihjflpg8V421NjjKJqac7B5zONV/uzq8cavTOJjmp0xmojtlNqwL8LpnSt8/j+Pg+ddI2l9UwLKz48jHzEDv5h80i8HtMDG/jHeWcFG/IWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487171; c=relaxed/simple;
	bh=V+CNc1FAdW4nKsZzbBKux8NdY7HWNHaXzUQO2l60D1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mu5mw2YPjZHD5Tx2kR4UZ6vvrGytJYLhx6GBxxl8p7JtLOPRnC0QBYTqbDaV7CQr1swercT3lIkMyf/6iF+QXSRKLAoUd7E2RGEUZxaqyxefCUD78hbm12at15IVDkj9JP8dO9a73muCWE5wDzqwtjHKplGbF6LaFzuSokLj8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTMtk2zNHz6DB6r;
	Tue, 30 Apr 2024 22:25:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 76AEF1400DC;
	Tue, 30 Apr 2024 22:26:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 15:26:07 +0100
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
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin Shan
	<gshan@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v9 03/19] ACPI: processor: Drop duplicated check on _STA (enabled + present)
Date: Tue, 30 Apr 2024 15:24:18 +0100
Message-ID: <20240430142434.10471-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

The ACPI bus scan will only result in acpi_processor_add() being called
if _STA has already been checked and the result is that the
processor is enabled and present.  Hence drop this additional check.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
V9: No change
---
 drivers/acpi/acpi_processor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index b2f0b6c19482..161c95c9d60a 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -186,17 +186,11 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
-	unsigned long long sta;
-	acpi_status status;
 	int ret;
 
 	if (invalid_phys_cpuid(pr->phys_id))
 		return -ENODEV;
 
-	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
-	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
-		return -ENODEV;
-
 	cpu_maps_update_begin();
 	cpus_write_lock();
 
-- 
2.39.2


