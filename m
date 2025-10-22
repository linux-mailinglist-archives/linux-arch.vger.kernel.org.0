Return-Path: <linux-arch+bounces-14250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF74BFBA5F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B0F4800D8
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 11:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C506285CA3;
	Wed, 22 Oct 2025 11:33:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1DCA6B;
	Wed, 22 Oct 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132837; cv=none; b=myyuNYbzS3SRBd1ixx2HJe5Oux5C3jhmcraMQxlThroVuDw1cDFfaSnq95G7dLsEX3uvN/gVfUJjYvh/KNrCNoEqmcw9JatAq7HVA9lrhF+/UjJsB3IjQ3zZSyYZ5GQVd8XvTaWzCZaDx2zkK50Wfz21dGQVRd0b63IUzY+yi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132837; c=relaxed/simple;
	bh=yUPVLciN6zsj6UESXutXjdkrnNr1pBeFSqAjpU16DLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oNismmK1TbYUyBXqGVNCMfe1uxOFni7sVSr2SqyiqZSwihrpf6Gt7PCc61/GQ9mCklZSVgxKyi+ZThIK4I78yrkZgurpI2j0YtrqPcnhEKVjqdoxI3/3B5DmsfBzwZviG/rF/Au87E5jzAUKvahvpDnAyhz56ubAMJfF04QvI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cs6RM1Yb4z6GDLk;
	Wed, 22 Oct 2025 19:30:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id ABDEB1400C8;
	Wed, 22 Oct 2025 19:33:51 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 12:33:50 +0100
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
Subject: [PATCH v4 0/6] Cache coherency management subsystem
Date: Wed, 22 Oct 2025 12:33:43 +0100
Message-ID: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
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

Support system level interfaces for cache maintenance as found on some
ARM64 systems. This is needed for correct functionality during various
forms of memory hotplug (e.g. CXL). Typical hardware has MMIO interface
found via ACPI DSDT.

Includes parameter changes to cpu_cache_invalidate_memregion() but no
functional changes for architectures that already support this call.

How to merge?  When this is ready to proceed (so subject to review
feedback on this version), I'm not sure what the best route into the
kernel is. Conor could take the lot via his tree for drivers/cache but
the generic changes perhaps suggest it might be better if Andrew
handles this?  Any merge conflicts in drivers/cache will be trivial
build file stuff. Or maybe even take it throug one of the affected
trees such as CXL.

v4: (Small changes called out in each patch)
- Drop the ACPI driver. It has done it's job as a second implementation
  to help with generality testing. I have heard zero interest in actually
  doing the specification work needed to make that official. Easy to bring
  back if needed in future. I have it locally still as a second test
  case.
- Add a cpu_cache_invalidate_all() helper for the 0,-1 case that is used
  to indicate everything should be flushed as no fine grained range info
  available.
- Simplify the necessary symbols to be selected by architectures by
  making CONFIG_GENERIC_CPU_CACHE_MAINTENANCE select
  ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
- Avoid naming mentioning devices as there is no struct device.
- Use a kref so as to have something on which a _put() operation makes
  sense avoiding rather confusing freeing of an internal structure pointer
  that was seen in v3.
- Gather tags given.
- Various minor things like typos, header tweaks etc.
Thanks to all who reviewed v3.

On current ARM64 systems (and likely other architectures) the
implementation of cache flushing need for actions such as CXL memory
hotplug e.g. cpu_cache_invalidate_memregion(), is performed by system
components outside of the CPU, controlled via either firmware or MMIO
interfaces.

These control units run the necessary coherency protocol operations to
cause the write backs and cache flushes to occur asynchronously. They allow
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

The often distributed nature of the relevant coherency management units
(e.g. due to interleaving) requires the appropriate commands to be issued
to multiple (potentially heterogeneous) units. To enable this a
registration framework is provided to which drivers may register a set
of callbacks. Upon a request for a cache maintenance operation the
framework iterates over all registered callback sets, calling first a
command to write back and invalidate, and then optionally a command to wait
for completion. Filtering on relevance if a give request is left to the
individual drivers.

In this version only one driver is included. This is the HiSilicon Hydra
Home Agent driver which controls hardware found on some of our relevant
server SoCs. Also available (I can post if anyone is interested)
is an ACPI driver based on a firmware interface that was in a public
PSCI specification alpha version

QEMU emulation code at
http://gitlab.com/jic23/qemu cxl-2025-03-20 

Notes:
- I don't particularly like defining 'generic' infrastructure with so few
  implementations. If anyone can point me at docs for another one or two,
  or confirm that they think this is fine that would be great!
  The converse to this is I don't want to wait longer for those to surface
  given the necessity to support this one platform that I do know about!


Jonathan Cameron (3):
  memregion: Drop unused IORES_DESC_* parameter from
    cpu_cache_invalidate_memregion()
  arm64: Select GENERIC_CPU_CACHE_MAINTENANCE
  MAINTAINERS: Add Jonathan Cameron to drivers/cache and add
    lib/cache_maint.c + header

Yicong Yang (2):
  memregion: Support fine grained invalidate by
    cpu_cache_invalidate_memregion()
  lib: Support ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION

Yushan Wang (1):
  cache: Support cache maintenance for HiSilicon SoC Hydra Home Agent

 MAINTAINERS                     |   3 +
 arch/arm64/Kconfig              |   1 +
 arch/x86/mm/pat/set_memory.c    |   2 +-
 drivers/cache/Kconfig           |  15 +++
 drivers/cache/Makefile          |   2 +
 drivers/cache/hisi_soc_hha.c    | 191 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c       |   5 +-
 drivers/nvdimm/region.c         |   2 +-
 drivers/nvdimm/region_devs.c    |   2 +-
 include/linux/cache_coherency.h |  61 ++++++++++
 include/linux/memregion.h       |  16 ++-
 lib/Kconfig                     |   4 +
 lib/Makefile                    |   2 +
 lib/cache_maint.c               | 138 +++++++++++++++++++++++
 14 files changed, 436 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cache/hisi_soc_hha.c
 create mode 100644 include/linux/cache_coherency.h
 create mode 100644 lib/cache_maint.c

-- 
2.48.1


