Return-Path: <linux-arch+bounces-3749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B278A844F
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8306D1F24AC3
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D7D13E3EE;
	Wed, 17 Apr 2024 13:22:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0A13DDB4;
	Wed, 17 Apr 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360138; cv=none; b=gfW4vC1Gaevgv2Dwa2v4G/AgvZDqShIVmcTDpn3XYlvO1IjoG+727yvw+sRUXKS/z0CMYnNiy77LPLRM7JhP2opuy4kYpGSTPdXu09seGjizJHW9aNH80inqDFrsr9sssl83GxVHqdV/3RXoZUr48SCCKoS72KIwdffvm/yygqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360138; c=relaxed/simple;
	bh=q9rgmuhSWFWOIBpDyuBLJUfTWRpK6MQ/Ah9Dl96hfnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD6NNW0XJljlKfvmPm7jvblf+WtIGh8BNzotDJJgIzBRQ9FYHejp8TS/B3qoi2DrUQScW/lqTd1RhrUZgnMENxVKhQIP8JHfTsAu/cM0fDl/SYy4+3meaNUaNgprN53ePCwV0gypgJfLJ9wRKG01lcvVdWhJHRlrEWGC18MzbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKM325X8Hz6H7hk;
	Wed, 17 Apr 2024 21:20:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D07C9140B38;
	Wed, 17 Apr 2024 21:22:14 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 14:22:14 +0100
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
Subject: [PATCH v6 06/16] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
Date: Wed, 17 Apr 2024 14:18:59 +0100
Message-ID: <20240417131909.7925-7-Jonathan.Cameron@huawei.com>
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

From: James Morse <james.morse@arm.com>

The arm64 specific arch_register_cpu() call may defer CPU registration
until the ACPI interpreter is available and the _STA method can
be evaluated.

If this occurs, then a second attempt is made in
acpi_processor_get_info(). Note that the arm64 specific call has
not yet been added so for now this will be called for the original
hotplug case.

For architectures that do not defer until the ACPI Processor
driver loads (e.g. x86), for initially present CPUs there will
already be a CPU device. If present do not try to register again.

Systems can still be booted with 'acpi=off', or not include an
ACPI description at all as in these cases arch_register_cpu()
will not have deferred registration when first called.

This moves the CPU register logic back to a subsys_initcall(),
while the memory nodes will have been registered earlier.
Note this is where the call was prior to the cleanup series so
there should be no side effects of moving it back again for this
specific case.

[PATCH 00/21] Initial cleanups for vCPU HP.
https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/

e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
---
v6: Squash the two paths for conventional CPU Hotplug and arm64
    vCPU HP.
v5: Update commit message to make it clear this is moving the
    init back to where it was until very recently.

    No longer change the condition in the earlier registration point
    as that will be handled by the arm64 registration routine
    deferring until called again here.
---
 drivers/acpi/acpi_processor.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7ecb13775d7f..0cac77961020 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -356,8 +356,18 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *
 	 *  NOTE: Even if the processor has a cpuid, it may not be present
 	 *  because cpuid <-> apicid mapping is persistent now.
+	 *
+	 *  Note this allows 3 flows, it is up to the arch_register_cpu()
+	 *  call to reject any that are not supported on a given architecture.
+	 *  A) CPU becomes present.
+	 *  B) Previously invalid logical CPU ID (Same as becoming present)
+	 *  C) CPU already present and now being enabled (and wasn't registered
+	 *     early on an arch that doesn't defer to here)
 	 */
-	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
+	if ((!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
+	     !get_cpu_device(pr->id)) ||
+	    invalid_logical_cpuid(pr->id) ||
+	    !cpu_present(pr->id)) {
 		ret = acpi_processor_hotadd_init(pr, device);
 
 		if (ret)
-- 
2.39.2


