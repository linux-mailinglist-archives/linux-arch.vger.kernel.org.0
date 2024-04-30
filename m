Return-Path: <linux-arch+bounces-4084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1958B79E6
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 16:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA7B2899FD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB9181332;
	Tue, 30 Apr 2024 14:30:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BB181323;
	Tue, 30 Apr 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487449; cv=none; b=lXtgVuF9Rb20A210xEJHgzwYlWmO4h/x2lxuNFiMtv113AooVr5rOcw2bCS0K+WlXzEfQJbr/vE6xJLrgiGJveiQB4YwAAuOBb+A11yisFjJmAiByGfnG9yPZXZT+uXKX8v0XzVuNK+5Zmj1m2cFS+xuMPLr+rsdWjWWUpPc92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487449; c=relaxed/simple;
	bh=yY98P/N6n2yJ+hh0iMOlAtnctYZ4RYhJchDwGQX4eZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7aO8J2/80Az8D6D6IrxkxxxNYipCI+dXqrXqX9aabgIkOF1DytwyNAwpGwpz4YoAULflLvKUcHJ+e4VzERQrifiDLjVl+PJ+hYqLLLfQnyL3ySrp4JIhSb87UhvHYysxBH9saX0HQs3YIhK+CiOLn/femZjfkRE0dz4dGIvWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTMxJ6WjMz6J77T;
	Tue, 30 Apr 2024 22:28:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B57E8140CB9;
	Tue, 30 Apr 2024 22:30:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 15:30:44 +0100
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
Subject: [PATCH v9 12/19] arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry
Date: Tue, 30 Apr 2024 15:24:27 +0100
Message-ID: <20240430142434.10471-13-Jonathan.Cameron@huawei.com>
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

In a review discussion of the changes to support vCPU hotplug where
a check was added on the GICC being enabled if was was online, it was
noted that there is need to map back to the cpu and use that to index
into a cpumask. As such, a valid ID is needed.

If an MPIDR check fails in acpi_map_gic_cpu_interface() it is possible
for the entry in cpu_madt_gicc[cpu] == NULL.  This function would
then cause a NULL pointer dereference.   Whilst a path to trigger
this has not been established, harden this caller against the
possibility.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v9: New patch in response to a question from Marc Zyngier.
    Taking the easy way out - harden against a possible condition rather
    than establishing it never happens!
---
 arch/arm64/include/asm/acpi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bc9a6656fc0c..a407f9cd549e 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -124,7 +124,8 @@ static inline int get_cpu_for_acpi_id(u32 uid)
 	int cpu;
 
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
-		if (uid == get_acpi_id_for_cpu(cpu))
+		if (acpi_cpu_get_madt_gicc(cpu) &&
+		    uid == get_acpi_id_for_cpu(cpu))
 			return cpu;
 
 	return -EINVAL;
-- 
2.39.2


