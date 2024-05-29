Return-Path: <linux-arch+bounces-4595-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86708D3806
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5826283A37
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8FB17C73;
	Wed, 29 May 2024 13:41:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6C17BB4;
	Wed, 29 May 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990093; cv=none; b=LNHrV9lOsDS171QzcWqFEftfmxNDbnaTazP+g13up6RthMT2t0y9z1Jgd1JikSUTcQ1XSragIsT71eEePhJHyH1rEzAmERhozvb1GWydmEl3M+8CUXEhL2PS1U/utV6iwgR3a1T9Z/UkYzgTW2W+eKjoQcysPck6KnqpEhmFE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990093; c=relaxed/simple;
	bh=XC2AfV3+IRVuErlXfReS96M7ywl4RO+B/FCDerWOMg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEIIc3OK7VVfERGd7uBod0IF/goxt7YsCDE8OSKRioaTY9oWdnfrXXEBh0L1dz7zenF+8Qxo6TMLFBDqLBkaIhQK9Xwsp69itZqIlyTC+YWIKpaHz8O58TOzFHqfXYqv4Bm28FCD1XprFpvP5fYicZsKFrk3fXNh6uQzeJJ77WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq9RZ1H1Bz6JBHQ;
	Wed, 29 May 2024 21:37:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BEA3C140B2A;
	Wed, 29 May 2024 21:41:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 14:41:29 +0100
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
Subject: [PATCH v10 13/19] irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
Date: Wed, 29 May 2024 14:34:40 +0100
Message-ID: <20240529133446.28446-14-Jonathan.Cameron@huawei.com>
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

gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
It should only count the number of enabled redistributors, but it
also tries to sanity check the GICC entry, currently returning an
error if the Enabled bit is set, but the gicr_base_address is zero.

Adding support for the online-capable bit to the sanity check will
complicate it, for no benefit. The existing check implicitly depends on
gic_acpi_count_gicr_regions() previous failing to find any GICR regions
(as it is valid to have gicr_base_address of zero if the redistributors
are described via a GICR entry).

Instead of complicating the check, remove it. Failures that happen at
this point cause the irqchip not to register, meaning no irqs can be
requested. The kernel grinds to a panic() pretty quickly.

Without the check, MADT tables that exhibit this problem are still
caught by gic_populate_rdist(), which helpfully also prints what went
wrong:
| CPU4: mpidr 100 has no re-distributor!

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc..10af15f93d4d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2415,19 +2415,10 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	 * If GICC is enabled and has valid gicr base address, then it means
 	 * GICR base is presented via GICC
 	 */
-	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
+	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address)
 		acpi_data.enabled_rdists++;
-		return 0;
-	}
 
-	/*
-	 * It's perfectly valid firmware can pass disabled GICC entry, driver
-	 * should not treat as errors, skip the entry instead of probe fail.
-	 */
-	if (!acpi_gicc_is_usable(gicc))
-		return 0;
-
-	return -ENODEV;
+	return 0;
 }
 
 static int __init gic_acpi_count_gicr_regions(void)
-- 
2.39.2


