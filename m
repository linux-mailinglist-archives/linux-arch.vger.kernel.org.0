Return-Path: <linux-arch+bounces-3622-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D569B8A30CF
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9301F221FD
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B711419B0;
	Fri, 12 Apr 2024 14:37:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C313E890;
	Fri, 12 Apr 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932672; cv=none; b=JqHGgVnjzMH8Hw/diNi6DaUbVntjaZYEi/DujlnzOaOnk/dUHidL3ZRVVDkGagRj2gV8HD70m6HF8spsi27//O9OkN7WUJ5y1BzPmHF+2mwSjd6X6dwfhAGRNHm6lELBVAPkhox9oPbC9jn7tT80a3e22JxERjxxbQc45KcLunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932672; c=relaxed/simple;
	bh=5VUBVigD7N0bkRxonGZ3EDpQP4ueFOMirLrwBwMA3cQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpBVd7vAoRYFY0YmPun2SahYRx1EGcjS/O5Qqi6CFkVO+9Pu2LYa1LV1UB+rGvchkrjspvdqgHSnmbnLyOoQVd+XtDfoDvczQ7WLhVEI0Ih5jrfXDrcojhu7lsfmDEhnKK/WTsNEWi6Y2BR6BJtZbYfsuH3urG+HPf5WjUsGGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGJyq6LRpz6K5nG;
	Fri, 12 Apr 2024 22:36:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B16B1400D4;
	Fri, 12 Apr 2024 22:37:48 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:37:47 +0100
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
Subject: [PATCH v5 01/18] cpu: Do not warn on arch_register_cpu() returning -EPROBE_DEFER
Date: Fri, 12 Apr 2024 15:37:02 +0100
Message-ID: <20240412143719.11398-2-Jonathan.Cameron@huawei.com>
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

For arm64 the CPU registration cannot complete until the ACPI intepretter
us up and running so in those cases the arch specific
arch_register_cpu() will return -EPROBE_DEFER at this stage and the
registration will be attempted later.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: New patch.
    Note that for now no arch_register_cpu() calls return -EPROBE_DEFER
    so it has no impact until the arm64 one is added later in this series.
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 56fba44ba391..b9d0d14e5960 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -558,7 +558,7 @@ static void __init cpu_dev_register_generic(void)
 
 	for_each_present_cpu(i) {
 		ret = arch_register_cpu(i);
-		if (ret)
+		if (ret != -EPROBE_DEFER)
 			pr_warn("register_cpu %d failed (%d)\n", i, ret);
 	}
 }
-- 
2.39.2


