Return-Path: <linux-arch+bounces-4590-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD338D37E6
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6E91C21582
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367417591;
	Wed, 29 May 2024 13:38:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52AB168DE;
	Wed, 29 May 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989938; cv=none; b=oCj5SXWsHdrxmcYFotca45WSuTvKUYW1sJT8TIMzJJb3OF9td8a0iTnLVix6bdtPwjzrfp7t1cSYp5WKIxKPjH9hEZFmoLt2DaikdAx97A6AVqg7exCs4yi9THZ3OFbUtx07iAmcTVcoQraD2rqh/EP2aeGPbs/SHidywrr03jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989938; c=relaxed/simple;
	bh=VavUhBJGZGr1m0RMJ97kdrplaGcGU64BM6yu26ivLok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciEC6iw9FEco6jFi/K4JGF3FSImv5BHMP4Q5rJG4r5mc4eHmuwZIWaUZxvJpszxV+hgjJAkbjxJoBNb2MFrV/t2G86j7GHYVtvZI20D3stMijMN7/D/xu6nCxgKJM/YHolLWHsNQ6dEB5cF4YxoUPY48RRrJu1xlW0xn/s+ah3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq9Nb4tBtz6JBF1;
	Wed, 29 May 2024 21:34:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CBA60140B3C;
	Wed, 29 May 2024 21:38:54 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 14:38:54 +0100
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
Subject: [PATCH v10 08/19] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
Date: Wed, 29 May 2024 14:34:35 +0100
Message-ID: <20240529133446.28446-9-Jonathan.Cameron@huawei.com>
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
commit 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v10: Rebased on earlier changes.
     Sign off chain on this one is complex as it James patch
     handled by Russell then substantially modified by me, hopefully
     the tag block reflects that and the various reviews / tests
     etc appropriately.
---
 drivers/acpi/acpi_processor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 56592462d2fb..f0b7a789f0a1 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -359,14 +359,14 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	}
 
 	/*
-	 *  Extra Processor objects may be enumerated on MP systems with
-	 *  less than the max # of CPUs. They should be ignored _iff
-	 *  they are physically not present.
-	 *
-	 *  NOTE: Even if the processor has a cpuid, it may not be present
-	 *  because cpuid <-> apicid mapping is persistent now.
+	 *  This code is not called unless we know the CPU is present and
+	 *  enabled. The two paths are:
+	 *  a) Initially present CPUs on architectures that do not defer
+	 *     their arch_register_cpu() calls until this point.
+	 *  b) Hotplugged CPUs (enabled bit in _STA has transitioned from not
+	 *     enabled to enabled)
 	 */
-	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id))
+	if (!get_cpu_device(pr->id))
 		ret = acpi_processor_hotadd_init(pr, device);
 	else
 		ret = acpi_processor_set_per_cpu(pr, device);
-- 
2.39.2


