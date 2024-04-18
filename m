Return-Path: <linux-arch+bounces-3795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216238A9BD8
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDC91F2158C
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE761635D6;
	Thu, 18 Apr 2024 13:57:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A29161912;
	Thu, 18 Apr 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448642; cv=none; b=PasjirGXbhlUNFdA/Q112z14HIFMYYExQTqQsjwz4teFhtvFPn0429KQ0j4YYVj5SOndN6votJep8kkZ5l+ADuSXiT18EYDXbSKLTFKM5c+731CAVwdj5wdDwpmWw/wmVC6rx+C4o2VA/0z7rlq6Hm8EUjvo5t+VWRFOm5YNLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448642; c=relaxed/simple;
	bh=Q6ssnwcTXLz7vydOFWMRL9zC7krNWctKO0oi2m7nVi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KY5bzLML0ErYTQ6hKoWEby/SqBjbIQxZTQv4Wud+RDh4rq3/jr8muCZNmWvPk3TlXaXAzmaFQEZwSmuMTReZguUn8NloL1tQMaYeCFJPXFn5t00mj0yQuP1jhQS8q4MjMKFXYN0QPdxe1EdRs+xKXpIWLw7sKJQqV66XNU9I02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKzmz3f55z6D94Q;
	Thu, 18 Apr 2024 21:55:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C173140C98;
	Thu, 18 Apr 2024 21:57:18 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:57:17 +0100
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
Subject: [PATCH v7 06/16] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
Date: Thu, 18 Apr 2024 14:54:02 +0100
Message-ID: <20240418135412.14730-7-Jonathan.Cameron@huawei.com>
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
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
---
v7: Simplify the logic on whether to hotadd the CPU.
    This path can only be reached either for coldplug in which
    case all we care about is has register_cpu() already been
    called (identifying deferred), or hotplug in which case
    whether register_cpu() has been called is also sufficient.
    Checks on _STA related elements or the validity of the ID
    are no longer necessary here due to similar checks having
    moved elsewhere in the path.
v6: Squash the two paths for conventional CPU Hotplug and arm64
    vCPU HP.
---
 drivers/acpi/acpi_processor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 127ae8dcb787..4e65011e706c 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -350,14 +350,14 @@ static int acpi_processor_get_info(struct acpi_device *device)
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
-	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
+	if (!get_cpu_device(pr->id)) {
 		ret = acpi_processor_hotadd_init(pr, device);
 
 		if (ret)
-- 
2.39.2


