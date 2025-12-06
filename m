Return-Path: <linux-arch+bounces-15291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184ACA98F1
	for <lists+linux-arch@lfdr.de>; Sat, 06 Dec 2025 00:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5474130EBB6F
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 22:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED62D5944;
	Fri,  5 Dec 2025 22:58:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488532F069D;
	Fri,  5 Dec 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975502; cv=none; b=ternPQq1E3xqfrkmW0tURdA8qYAPVS5NzO7baJh+SYwdXBm5omc4XXNuZS0Vw2Ta3YtQmu0jVDcdLHSgoJGQaZlroCrKH7A9+B1mm+1dUKTC48Gqy4j1X0aVNpaAUQLKRKf3gGBN8sqri+M5d3FdlTqE6TJFe5Le36ZaqVSFoDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975502; c=relaxed/simple;
	bh=YtujnNaI4qdEQnCWht2sddTydCGelUqClJ7dV8ifLmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cd7j6Sb/RZERZVWd3ZOwxmdi4A17lS09fbvxsLacnyyvRc3LeJ9aVoagIcfqKTkj/aeQ0ZEZeJFkUHNUYKSZYv4u1kydnGr27G/5ZyOnWmFwFWbQo4c088BH9N5KrvTkE6dXnojIAqvmenZdqoZGfKnWSU34KSCwLHOC09xODQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dNRBZ2xQGzHnGcx;
	Sat,  6 Dec 2025 06:39:18 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id C89B040539;
	Sat,  6 Dec 2025 06:39:20 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Dec 2025 01:39:20 +0300
From: Anatoly Stepanov <stepanov.anatoly@huawei.com>
To: <peterz@infradead.org>, <boqun.feng@gmail.com>, <longman@redhat.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <arnd@arndb.de>, <dvhart@infradead.org>,
	<dave@stgolabs.net>, <andrealmeid@igalia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
	<weiyongjun1@huawei.com>, <yusongping@huawei.com>, <leijitang@huawei.com>,
	<artem.kuzin@huawei.com>, <fedorov.nikita@h-partners.com>,
	<kang.sun@huawei.com>, Anatoly Stepanov <stepanov.anatoly@huawei.com>
Subject: [RFC PATCH v2 0/5] Introduce Hierarchical Queued NUMA-aware spinlock
Date: Sat, 6 Dec 2025 14:21:01 +0800
Message-ID: <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
References: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

[Introduction & Motivation]

In a high contention case, existing Linux kernel spinlock implementations can become
inefficient on modern NUMA-systems due to frequent and expensive
cross-NUMA cache-line transfers.

This might happen due to following reasons:
 - on "contender enqueue" each lock contender updates a shared lock structure
 - on "MCS handoff" cross-NUMA cache-line transfer occurs when
two contenders are from different NUMA nodes.

We introduce new NUMA-aware spinlock in the kernel - Hierarchical Queued
spinlock (HQ-spinlock).

Previous work regarding NUMA-aware spinlock in Linux kernel is CNA-lock:
https://lore.kernel.org/lkml/20210514200743.3026725-1-alex.kogan@oracle.com/

Despite being better than default qspinlock (handoff-wise), CNA still has
shared-lock variable modification on every new contender arrival.

HQ-lock has completely different design concept: kind of cohort-lock and
queued-spinlock hybrid.

Which is of course bulkier, but at the same time outperforms CNA in high-contention cases.

Locktorture on "Kunpeng 920" for example:
+-------------------------+--------------+
| HQ-lock vs CNA-lock     |              |
+-------------------------+--------------+
| Kunpeng 920 (arm64)     |              |
| 96 cores (no MT)        |              |
| 2 sockets, 4 NUMA nodes |              |
|                         |              |
| Locktorture             |              |
| Threads                 | HQ-lock gain |
| 32                      | 26%          |
| 64                      | 32%          |
| 80                      | 35%          |
| 96                      | 31%          |
+-------------------------+--------------+

 All other design and implementation details can be found in following
patches.

Anatoly Stepanov, Nikita Fedorov (5):
  kernel: introduce Hierarchical Queued spinlock
  hq-spinlock: proc tunables and debug stats
  kernel: introduce general hq-lock support
  lockref: use hq-spinlock
  kernel: futex: use HQ-spinlock for hash-buckets

 arch/arm64/include/asm/qspinlock.h    |  37 ++
 arch/x86/include/asm/qspinlock.h      |  38 +-
 include/asm-generic/qspinlock.h       |  23 +-
 include/asm-generic/qspinlock_types.h |  54 +-
 include/linux/lockref.h               |   2 +-
 include/linux/spinlock.h              |  26 +
 include/linux/spinlock_types.h        |  26 +
 include/linux/spinlock_types_raw.h    |  20 +
 init/main.c                           |   4 +
 kernel/Kconfig.locks                  |  29 +
 kernel/futex/core.c                   |   2 +-
 kernel/locking/hqlock_core.h          | 812 ++++++++++++++++++++++++++
 kernel/locking/hqlock_meta.h          | 477 +++++++++++++++
 kernel/locking/hqlock_proc.h          |  88 +++
 kernel/locking/hqlock_types.h         | 118 ++++
 kernel/locking/qspinlock.c            |  65 ++-
 kernel/locking/qspinlock.h            |   4 +-
 kernel/locking/spinlock_debug.c       |  20 +
 18 files changed, 1816 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm64/include/asm/qspinlock.h
 create mode 100644 kernel/locking/hqlock_core.h
 create mode 100644 kernel/locking/hqlock_meta.h
 create mode 100644 kernel/locking/hqlock_proc.h
 create mode 100644 kernel/locking/hqlock_types.h

-- 
2.34.1


