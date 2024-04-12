Return-Path: <linux-arch+bounces-3626-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37F48A30E4
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B1B2828B5
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C41420BC;
	Fri, 12 Apr 2024 14:39:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97814198A;
	Fri, 12 Apr 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932763; cv=none; b=ZjP9LdHZf53ruPioIyVFDxbltK5Af9TCjLodU5CKEu1DhqSsVdDKI7GVeJWbfe0feqFj7/fWIXYM8g4ixQv2K2nopcTG7Od7IvrCBBa1J5dlE6r8PcY/FcoC2NzjdgJreJYFdyOmjyYBT7+XrbJJjPcay5kLbM923g50tF0a46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932763; c=relaxed/simple;
	bh=qNAnme1XTmbODe/wLeql1C5zQsG0b4J6FCsam44PeQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jn9i3CHCD83AeKHa1T6yJS8IMQ7CA5y84Nv6lmDeKpJR0QNG+8PkarVni72Fh/2jfSA1ySkzo/HYnEG7w54C3/UU2FqccUlsQEMLyBvZW5hoe26DNSejMTYdifpkRJn5CbBLT0TNiHh+XD6Sklu7v4eNt1RGbm4AC3hA/nCAdEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGK0b51Knz6K5pm;
	Fri, 12 Apr 2024 22:37:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0911B140C98;
	Fri, 12 Apr 2024 22:39:20 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:39:19 +0100
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
Subject: [PATCH v5 04/18] ACPI: Rename acpi_processor_hotadd_init and  remove pre-processor guards
Date: Fri, 12 Apr 2024 15:37:05 +0100
Message-ID: <20240412143719.11398-5-Jonathan.Cameron@huawei.com>
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

From: James Morse <james.morse@arm.com>

acpi_processor_hotadd_init() will make a CPU present by mapping it
based on its hardware id.

'hotadd_init' is ambiguous once there are two different behaviours
for cpu hotplug. This is for toggling the _STA present bit. Subsequent
patches will add support for toggling the _STA enabled bit, named
acpi_processor_make_enabled().

Rename it acpi_processor_make_present() to make it clear this is
for CPUs that were not previously present.

Expose the function prototypes it uses to allow the preprocessor
guards to be removed. The IS_ENABLED() check will let the compiler
dead-code elimination pass remove this if it isn't going to be
used.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: Rebase.
---
 drivers/acpi/acpi_processor.c | 14 +++++---------
 include/linux/acpi.h          |  2 --
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index c78398cdd060..05264722c207 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -183,13 +183,15 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
 /* Initialization */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
-static int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static int acpi_processor_make_present(struct acpi_processor *pr)
 {
 	unsigned long long sta;
 	acpi_status status;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
+		return -ENODEV;
+
 	if (invalid_phys_cpuid(pr->phys_id))
 		return -ENODEV;
 
@@ -223,12 +225,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	cpu_maps_update_done();
 	return ret;
 }
-#else
-static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
@@ -338,7 +334,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  because cpuid <-> apicid mapping is persistent now.
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
-		int ret = acpi_processor_hotadd_init(pr);
+		int ret = acpi_processor_make_present(pr);
 
 		if (ret)
 			return ret;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c517a..2629c459738a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -302,12 +302,10 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 }
 #endif
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
 		 int *pcpu);
 int acpi_unmap_cpu(int cpu);
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
-- 
2.39.2


