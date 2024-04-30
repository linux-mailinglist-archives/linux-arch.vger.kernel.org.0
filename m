Return-Path: <linux-arch+bounces-4087-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FE68B7A1A
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 16:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E2BB22B6A
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FDA17BB34;
	Tue, 30 Apr 2024 14:32:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421D17BB1B;
	Tue, 30 Apr 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487543; cv=none; b=pox5iW+I+oBGJsRnlSHynjL1LVry1Y6EK/VojSQEz31++wdF0B2L6anOZL8avwvFcQMOUG5p6IUImP99CmMkhj3IztNdjVQag2jq/Weriif+BqkOMOM1Dk+a5tZH7YyS6XnJcDVXTpGxdbwJtz4j/ZWx4GinuSE7nJLvIISlDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487543; c=relaxed/simple;
	bh=teOAOmQ0B25z1AJ7N2klLSFQcY5M5Bxf+SWSAMwp8aA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAcdsatOXu+gFhpfw2vIwGwsRO0BeaN6wW4z8b7OUEQKrJExDNItgcMMvJqyPL9A+TTYsSJSoF4p18qLiDSGfzsInGqFYTI5cQMTGqfJlOOmUGxOGMDQSEKCd5sYPqLjwQd9ivAvStV1slOGTp3XaZsewRbDar/DrRiF2O0CRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTMz91T1Sz6GD7H;
	Tue, 30 Apr 2024 22:29:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 74FD5140CB9;
	Tue, 30 Apr 2024 22:32:18 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 15:32:17 +0100
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
Subject: [PATCH v9 15/19] arm64: psci: Ignore DENIED CPUs
Date: Tue, 30 Apr 2024 15:24:30 +0100
Message-ID: <20240430142434.10471-16-Jonathan.Cameron@huawei.com>
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a CPU is marked as disabled, but online capable in the MADT, PSCI
applies some firmware policy to control when it can be brought online.
PSCI returns DENIED to a CPU_ON request if this is not currently
permitted. The OS can learn the current policy from the _STA enabled bit.

Handle the PSCI DENIED return code gracefully instead of printing an
error.

Note the alternatives to the PSCI cpu_boot() callback do not
return -EPERM so the change in smp.c has no affect.

See https://developer.arm.com/documentation/den0022/f/?lang=en page 58.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[ morse: Rewrote commit message ]
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v9: Tags picked up
---
 arch/arm64/kernel/psci.c | 2 +-
 arch/arm64/kernel/smp.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 29a8e444db83..fabd732d0a2d 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
 {
 	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
 	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
-	if (err)
+	if (err && err != -EPERM)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
 
 	return err;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index afe835c1cbe2..b4b3f832520c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -132,7 +132,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	/* Now bring the CPU into our world */
 	ret = boot_secondary(cpu, idle);
 	if (ret) {
-		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+		if (ret != -EPERM)
+			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 		return ret;
 	}
 
-- 
2.39.2


