Return-Path: <linux-arch+bounces-10986-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075DBA6AC3F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 18:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE32462641
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7E52253A4;
	Thu, 20 Mar 2025 17:41:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216F1EDA06;
	Thu, 20 Mar 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492491; cv=none; b=mUNus2WUgmuVRrl3NGV/x/DZbZvAe56TuZLSTrR5as6vM8g5D90Q/2UczoUUcIrp0RKJ3YltWYS6p4zm8T6LuQgDsY0DISJvXm+Qw46iksRF8mBQo33NFPLkueudDbBUAC1IQGnY1SvPfJ9WqszzedfF5P1ErOurFS99OndjLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492491; c=relaxed/simple;
	bh=hxjPa9gLyx/uSoYJ8lGX6yMc386x4cSQCX5Ayf/sbug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gu/kVT2Qd8fjiu0nWU6MRpo/8UZ9Siho+PtwSLc+EpHciEiNCKBuFP+PrJ8YBhqFEXjFotAygVafnBj0oxheYpOl0+q8lAFXaQq++6RBvpeUxL9fEoN/BkB615YaUeijeMHDSWkrswwH5DyR/H4winQLshCY0nGYTiHLxzlFScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJXpw37tQz6M4k2;
	Fri, 21 Mar 2025 01:38:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B399614050A;
	Fri, 21 Mar 2025 01:41:20 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 18:41:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<james.morse@arm.com>, <conor@kernel.org>, Yicong Yang
	<yangyicong@huawei.com>, <linux-acpi@vger.kernel.org>
CC: <linux-arch@vger.kernel.org>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 0/6] Cache coherency management subsystem
Date: Thu, 20 Mar 2025 17:41:12 +0000
Message-ID: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

Note that I've only a vague idea of who will care about this
so please do +CC others as needed.

On x86 there is the much loved WBINVD instruction that causes a write back
and invalidate of all caches in the system. It is expensive but it is
necessary in a few corner cases. These are cases where the contents of
Physical Memory may change without any writes from the host. Whilst there
are a few reasons this might happen, the one I care about here is when
we are adding or removing mappings on CXL. So typically going from
there being actual memory at a host Physical Address to nothing there
(reads as zero, writes dropped) or visa-versa. That involves the
reprogramming of address decoders (HDM Decoders); in the near future
it may also include the device offering dynamic capacity extents. The
thing that makes it very hard to handle with CPU flushes is that the
instructions are normally VA based and not guaranteed to reach beyond
the Point of Coherence or similar. You might be able to (ab)use
various flush operations intended to ensure persistence memory but
in general they don't work either.

So on other architectures such as ARM64 we have no instruction similar to
WBINVD but we may have device interfaces in the system that provide a way
to ensure a PA range undergoes the write back and invalidate action. This
RFC is to find a way to support those cache maintenance device interfaces.
The ones I know about are much more flexible than WBINVD, allowing
invalidation of particular PA ranges, or a much richer set of flush types
(not supported yet as not needed for upstream use cases).

To illustrate how a solution might work, I've taken both a HiSilicon
design (slight quirk as registers overlap with existing PMU driver)
and more controversially a firmware interface proposal from ARM
(wrapped up in made up ACPI) that was dropped from the released spec
but for which the alpha spec is still available.

Why drivers/cache?
- Mainly because it exists and smells like a reasonable place.
- Conor, you are maintainer for this currently do you mind us putting this
  stuff in there?

Why not just register a singleton function pointer?
- Systems may include multiple cache control devices, responsible
  for different parts of the PA address range (interleaving etc make
  this complex).  They may not all share a common hardware interface.
- A device class is more convenient than managing multiple homogeneous
  device instances within a driver.
- Disadvantage is that we need this small class

Generalizing to more arch?
- I've started with ARM64, but if useful elsewhere the small amount
  of arch code could be moved to a generic location.

QEMU emulation code at
http://gitlab.com/jic23/qemu cxl-2025-03-20 

Why an RFC?
- I'm really just looking for feedback on whether the class approach
  is the way to go at this stage.  I'm not strongly attached to it but
  it feels like the right balance of complexity and flexibility to me.
- I made up the ACPI spec - it's not documented, non official and
  honestly needs work. I would however like to get feedback on whether
  it is something we want to try and get through the ACPI Working group
  as a much improved code first proposal?  The potential justification
  being to avoid the need for lots trivial drivers where maybe a bit
  of DSDT interpreted code does the job better.

Jonathan Cameron (3):
  cache: coherency device class
  acpi: PoC of Cache control via ACPI0019 and _DSM
  Hack: Pretend we have PSCI 1.2

Yicong Yang (3):
  memregion: Support fine grained invalidate by
    cpu_cache_invalidate_memregion()
  arm64: Support ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
  cache: Support cache maintenance for HiSilicon SoC Hydra Home Agent

 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/cacheflush.h |  14 ++
 arch/arm64/mm/flush.c               |  42 ++++++
 arch/x86/mm/pat/set_memory.c        |   2 +-
 drivers/acpi/Makefile               |   1 +
 drivers/cache/Kconfig               |  26 ++++
 drivers/cache/Makefile              |   4 +
 drivers/cache/acpi_cache_control.c  | 157 ++++++++++++++++++++++
 drivers/cache/coherency_core.c      | 130 +++++++++++++++++++
 drivers/cache/hisi_soc_hha.c        | 193 ++++++++++++++++++++++++++++
 drivers/cxl/core/region.c           |   6 +-
 drivers/firmware/psci/psci.c        |   2 +
 drivers/nvdimm/region.c             |   3 +-
 drivers/nvdimm/region_devs.c        |   3 +-
 include/linux/cache_coherency.h     |  60 +++++++++
 include/linux/memregion.h           |   8 +-
 16 files changed, 646 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cache/acpi_cache_control.c
 create mode 100644 drivers/cache/coherency_core.c
 create mode 100644 drivers/cache/hisi_soc_hha.c
 create mode 100644 include/linux/cache_coherency.h

-- 
2.43.0


