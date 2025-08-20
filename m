Return-Path: <linux-arch+bounces-13227-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9EB2DA00
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E354C685A4E
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2B2E0B48;
	Wed, 20 Aug 2025 10:29:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD3264624;
	Wed, 20 Aug 2025 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685796; cv=none; b=nANr/sY/k76aYKPYwTIp03ioDYWmlCswzt8PJQe8dALzYHA2Ge9KadCwUbEvhuLXneCSHDfTbmMXd89/VKYeQ3EcUestv+o+HMqh+8pI7WS8qz/6Tle43xgvkKRmEUh5cjRjAtBtONa6mDNYd0dFZRM84odGvObHeMiSuKTXS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685796; c=relaxed/simple;
	bh=qH4IBUz0cBSRbL6T2wLAPPu5nrICSVB34pQP+fsrzUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=noDwYr2NDM2DWiVQEMxjHgYxXdySo6D5eEERwGWNZlHyKOhdwkC98ZA4LwYyukftHROiqNBEMp2ZpdScd2+5BEUdHrxWI5YyImR8TwLK6xIGXqp6u85R4dt9EqhnkSaXQp1agvuIJWojBBE1UW7DoQ7UmYAF5AnjMi2z1v3knQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c6N0n0mSFz6L5l4;
	Wed, 20 Aug 2025 18:26:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 05FE5140119;
	Wed, 20 Aug 2025 18:29:52 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Aug 2025 12:29:51 +0200
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
Subject: [PATCH v3 0/8] Cache coherency management subsystem
Date: Wed, 20 Aug 2025 11:29:42 +0100
Message-ID: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
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

Support system level interfaces for cache maintenance as found on some
ARM64 systems. This is needed for correct functionality during various
forms of memory hotplug (e.g. CXL). Typical hardware has MMIO interface
found via ACPI DSDT.

Includes parameter changes to cpu_cache_invalidate_memregion() but no
functional changes for architectures that already support this call.

v3:
  - Squash the layers by moving all the management code into
    lib/cache_maint.c that architectures can opt into via
    GENERIC_CPU_CACHE_MAINTENANCE (Dan).  I added entries to Conor's
    drivers/cache MAINTAINERS entry to include this lib/ code but if
    preferred I can add a separate entry for it.
  - Add a new patch 1 that drops the old IODESC_RES_ parameter as it never
    did anything other than document intent.  With the addition of a
    flushing range, we would have to check the range and resource type
    matched. Simpler to just drop the parameter. (Dan)
  - Minor fixes and renames as per reviews.
  - Even if all else looks good, I fully expect some discussion of the
    naming as I'm not particularly happy with it.
  - Open question on whether is acceptable for the answer to whether
    cpu_cache_invalidate_memregion() is supported to change as drivers
    register (potentially after initial boot).  Could design a firmware
    table solution to this, but will take a while - not sure if it is
    necessary.
  - Switch to a fwctl style allocation function that makes the container
    nature of the allocation explicit.

On current ARM64 systems (and likely other architectures) the
implementation of cache flushing need for actions such as CXL memory
hotplug e.g. cpu_cache_invalidate_memregion(), is performed by system
components outside of the CPU, controlled via either firmware or MMIO
interfaces.

These control units run the necessary coherency protocol operations to
cause the write backs and cache flushes to occur asynchronously. The allow
filtering by PA range to reduce disruption to the system. Systems
supporting this interface must be designed to ensure that, when complete,
all cache lines in the range are in invalid state or clean state
(prefetches may have raced with the invalidation). This must include
memory-side caches and other non architectural caches beyond the Point
of Coherence (ARM terminology) such that writes will reach memory even
after OS programmable address decoders are modified (for CXL this is
any HDM decoders that aren't locked). Software will guarantee that no
writes to these memory ranges race with this operation. Whilst this is
subtly different from write backs must reach the physical memory that
difference probably doesn't matter to those reading this series.

The possible distributed nature of the relevant coherency management
units (e.g. due to interleaving) requires the appropriate commands to be
issued to multiple (potentially heterogeneous) units. To enable this a
registration framework is provided to which drivers may register a set
of callbacks. Upon a request for a cache maintenance operation the
framework iterates over all registered callback sets, calling first a
command to write back and invalidate, and then optionally a command to wait
for completion. Filtering on relevance is left to the individual drivers.

Two drivers are included. This HiSilicon Hydra Home Agent driver which
controls hardware found on some of our relevant server SoCs and,
mostly to show that the approach is general, a driver based on a firmware
interface that was in a public PSCI specification alpha version
(now dropped - don't merge that!)

QEMU emulation code at
http://gitlab.com/jic23/qemu cxl-2025-03-20 

Remaining opens:
- Naming.  All suggestions welcome!
- I don't particularly like defining 'generic' infrastructure with so few
  implementations. If anyone can point me at docs for another one or two,
  or confirm that they think this is fine that would be great!
- I made up the ACPI spec - it's not documented, non official and honestly
  needs work. I would however like to get feedback on whether it is
  something we want to try and get through the ACPI Working group as a much
  improved code first proposal?  The potential justification being to avoid
  the need for lots trivial drivers where maybe a bit of DSDT interpreted
  code does the job better. (Currently I'm not hearing much demand for this
  so will probably drop in a future version).

Thanks to all who engaged in the discussion so far.

Jonathan

Jonathan Cameron (5):
  memregion: Drop unused IORES_DESC_* parameter from
    cpu_cache_invalidate_memregion()
  MAINTAINERS: Add Jonathan Cameron to drivers/cache
  arm64: Select GENERIC_CPU_CACHE_MAINTENANCE and
    ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
  acpi: PoC of Cache control via ACPI0019 and _DSM
  Hack: Pretend we have PSCI 1.2

Yicong Yang (2):
  memregion: Support fine grained invalidate by
    cpu_cache_invalidate_memregion()
  lib: Support ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION

Yushan Wang (1):
  cache: Support cache maintenance for HiSilicon SoC Hydra Home Agent

 MAINTAINERS                        |   3 +
 arch/arm64/Kconfig                 |   2 +
 arch/x86/mm/pat/set_memory.c       |   2 +-
 drivers/cache/Kconfig              |  22 ++++
 drivers/cache/Makefile             |   3 +
 drivers/cache/acpi_cache_control.c | 153 +++++++++++++++++++++++
 drivers/cache/hisi_soc_hha.c       | 187 +++++++++++++++++++++++++++++
 drivers/cxl/core/region.c          |   5 +-
 drivers/firmware/psci/psci.c       |   2 +
 drivers/nvdimm/region.c            |   2 +-
 drivers/nvdimm/region_devs.c       |   2 +-
 include/linux/cache_coherency.h    |  57 +++++++++
 include/linux/memregion.h          |  10 +-
 lib/Kconfig                        |   3 +
 lib/Makefile                       |   2 +
 lib/cache_maint.c                  | 128 ++++++++++++++++++++
 16 files changed, 575 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cache/acpi_cache_control.c
 create mode 100644 drivers/cache/hisi_soc_hha.c
 create mode 100644 include/linux/cache_coherency.h
 create mode 100644 lib/cache_maint.c

-- 
2.48.1


