Return-Path: <linux-arch+bounces-13232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846C7B2DA18
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 12:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963F11C46229
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3D2DF3EA;
	Wed, 20 Aug 2025 10:32:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1523D7EA;
	Wed, 20 Aug 2025 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685952; cv=none; b=F+G4nZXYtoFlDuqqhzmHcdUsEIWz/UVEtXn4gf5svJP99H7hqNvO8d3zyEx1ChEfzuBN7itbU3WX7mDqOga7PamFIasL2Opnnq7u+UncnuTiTbMZbWeiShhkXKU/QBbnEHbyhy7qeVgj7S/BgJeWN+s4YGTPf7c9r9D6cRDKJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685952; c=relaxed/simple;
	bh=08WVJLYBfoTNc+r3vBYKkHNJFJo8BE1IxGFPyn4ycfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEsLGjV9iH4Czat8lAQWiPkg0YrwpbSV8puasec5MCFTBpnFAJrMnlkPi6mQOdLIGe/TcJepQVYNeuNT/S0Rhwydo6hvx3ImdjlZTuzVFhxScvwbonwBpB1/Q4GoJDQGAFhJw3ftt3LNBWSE6mdfs4xw2Sm1Oekux+wvrCM95RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c6N3p27HCz6L5wF;
	Wed, 20 Aug 2025 18:29:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 36A9A1402DA;
	Wed, 20 Aug 2025 18:32:29 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Aug 2025 12:32:28 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Will Deacon <will@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
CC: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>
Subject: [PATCH v3 5/8] arm64: Select GENERIC_CPU_CACHE_MAINTENANCE and ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Date: Wed, 20 Aug 2025 11:29:47 +0100
Message-ID: <20250820102950.175065-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

Ensure the hooks that the generic cache maintenance framework uses are
available on ARM64 by selecting ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION.

The generic CPU cache maintenance framework provides a way to register
drivers for devices implementing the underlying support for
cpu_cache_has_invalidate_memregion().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a6..15bf429b3f59 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -21,6 +21,7 @@ config ARM64
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CC_PLATFORM
+	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
@@ -146,6 +147,7 @@ config ARM64
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_CACHE_MAINTENANCE
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
-- 
2.48.1


