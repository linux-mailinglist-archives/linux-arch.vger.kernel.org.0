Return-Path: <linux-arch+bounces-14254-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD439BFBA98
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE6C48853D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184E33DEE5;
	Wed, 22 Oct 2025 11:36:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C69299924;
	Wed, 22 Oct 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132963; cv=none; b=hf0wfKmTtvk/hRZb2gvdvpc7V4e74BMqO28pUJOMtxehz9JMW2dAJKmMSRlW5dQcxZ66p1/v9cepKLfAyqqtl0Mgih1oICb1REnx/yELg/09wp2Eu2ivRN1DWaLl54cGZiJ11+pPNum25E3Jl54KeOGEFMG4lDKYX7BITOS0u3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132963; c=relaxed/simple;
	bh=ZEgj6f//WdHQAv7xeAXK42fpm5RMJSgygoGQlOHCQmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3flFGebek9XrUosBTD9nffGVlPkwafLuYWgLriopp8bJ81RMZYe+d3Ujm5SEXHkryFxdo2SEAyZgFxeuYgWkOgXgK3LrCurLol0iM5gw/g0D2H0j7905zKIGPLFGS2HquuHV5dn3d+k29BC5G8gx1BWj6cwTFj7/i12qiSOvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cs6Ws33H3z6K6p7;
	Wed, 22 Oct 2025 19:34:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F1CA1400C8;
	Wed, 22 Oct 2025 19:35:57 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 12:35:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 4/6] arm64: Select GENERIC_CPU_CACHE_MAINTENANCE
Date: Wed, 22 Oct 2025 12:33:47 +0100
Message-ID: <20251022113349.1711388-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

The generic CPU cache maintenance framework provides a way to register
drivers for devices implementing the underlying support for
cpu_cache_has_invalidate_memregion(). Enable it for arm64 by selecting
GENERIC_CPU_CACHE_MAINTENANCE which provides the implementation for,
and in turn selects, ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
v4: Drop select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION as that
    is now selected by GENERIC_CPU_CACHE_MAINTENANCE (Catalin Marinas)
    Picked up tag from Catalin. (thanks!)
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6663ffd23f25..893e0af0bc51 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -149,6 +149,7 @@ config ARM64
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_CACHE_MAINTENANCE
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
-- 
2.48.1


