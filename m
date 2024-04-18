Return-Path: <linux-arch+bounces-3799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA88A9BFE
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CABBB2540D
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2610165FAE;
	Thu, 18 Apr 2024 13:59:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AD165FA5;
	Thu, 18 Apr 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448765; cv=none; b=J80+yiGeyCCUiWp0ewwUVnvn2k2EK6Uqtz0+cIw0FzpRndl77RnRn9X7Dm+px5MYnlU/ost76aPDUhKwZ1/nXq8BXVRH1UaYwcj6PCzEaUOPPwoYmyIOtv6BjxWC2WA6e/CLiAUkzPu0e5w4WhRdl24DIvAgAGD6lvRf26yLJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448765; c=relaxed/simple;
	bh=Zx4LtaK/cORjchbA6pFt7wlqKzyx1DGqbsJf0x8mQb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBviXqv/QtV2T48ti2YesGQyDS45zuQ+MIJOg2HHopXDVbMMD/OhS/3TgbZQ0ULKMIqRgSsVtwGm3/UIpRU0PBsPcmyiJ1/l2ROjUXXGA8uPGXD7L19G8W7mBPVvTA7IbworeeYbEZmYjbbGgubpXLkd7t1mIHTyL/WLyzXLy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKzqL42Xqz6K5r4;
	Thu, 18 Apr 2024 21:57:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D7AEE1406AC;
	Thu, 18 Apr 2024 21:59:21 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:59:21 +0100
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
Subject: [PATCH v7 10/16] irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
Date: Thu, 18 Apr 2024 14:54:06 +0100
Message-ID: <20240418135412.14730-11-Jonathan.Cameron@huawei.com>
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
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v7: No change
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


