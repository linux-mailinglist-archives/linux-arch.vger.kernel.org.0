Return-Path: <linux-arch+bounces-15104-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD2C900DA
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 20:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2F334EBB95
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9B30C379;
	Thu, 27 Nov 2025 19:44:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EE306B1B;
	Thu, 27 Nov 2025 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764272665; cv=none; b=g+K8/xxkSIQFx0vGLRFv1SYoM1GtbiR7Jl3u5o59dURCTCtPUNti9VLSzTGf4/YaNckyHsvogbKUqjZXzGtfjtlAKEMT9JeL6HDHktAUcNJMuNlwx+Yc2R7MATBvNKQC3rdmmDEp/8NN0L3oINNeiXs3J96aLVaWeKXEX3YZsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764272665; c=relaxed/simple;
	bh=ih8mhx9ZUYqxUJxdKJrNoi4Uv2tzaS11zzBWElSIY+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RnZNEu/dlV+9AoA8JR0W3np6Njtb5AXT3/ZwCnhmWS8TQA7B7+OrHM5hMsBYCa3IZPaWlonr7Hb4W4PJXyuD1ao2P4gsVBsiDiUddiW7z03OJVNkPsTF35altakhD/bhn4KQgoUBzswvs5tRbWbAHEAzGqORpweKuih9S39wkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHRgF0BHbzJ467k;
	Fri, 28 Nov 2025 03:43:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D4AF14010D;
	Fri, 28 Nov 2025 03:44:18 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:44:17 +0300
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
Subject: [RFC PATCH 0/1] Introduce Hierarchical Queued NUMA-aware spinlock
Date: Fri, 28 Nov 2025 11:26:17 +0800
Message-ID: <20251128032618.811617-1-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

[Introduction & Motivation]

In a high contention case, existing Linux kernel spinlock implementations can become
inefficient on modern NUMA-systems due to frequent and expensive
cross-NUMA cache-line transfers.

This might happen due to following reasons:
 - on "contender enqueue" each lock contender updates a shared lock structure
 - on "MCS handoff" cross-NUMA cache-line transfer occurs when
two contenders are from different NUMA nodes.

We introduce Hierarchical Queued Spinlock (HQ spinlock), aiming to
reduce cross-NUMA cache line traffic and thus improving lock/unlock throughput
for high-contention cases.

This idea might be considered as a combination of cohort-locking
by Dave Dice and Linux kernel queued spinlock.

[Design and workflow]

The contenders are organized into 2-level scheme where each NUMA-node
has it's own FIFO contender queue.

NUMA-queues are linked into single-linked list alike structure, while
maintaining FIFO order between them.
When there're no contenders left in a NUMA-queue, the queue is removed from
the list.

Contenders try to enqueue to local NUMA-queue first and if there's
no such queue - link it to the list.
As for "qspinlock" only the first contender is spinning globally,
all others - MCS-spinning.

"Handoff" operation becomes two-staged:
- local handoff: between contenders in a single NUMA-queue
- remote handoff: between different NUMA-queues.

If "remote handoff" reaches the end of the NUMA-queue linked list it goes to
the list head.

To avoid potential starvation issues, we use handoff thresholds.

Key challenge here was keeping the same "qspinlock" structure size
and "bind" a given lock to related NUMA-queues.

We came up with dynamic lock metadata concept, where we can
dynamically "bind" a given lock to it's NUMA-related metadata, and
then "unbind" when the lock is released.

This approach allows to avoid metadata reservation for every lock in advance,
thus giving the upperbound of metadata instance number to ~ (NR_CPUS x nr_contexts / 2).
Which corresponds to maximum amount of different locks falling into the slowpath.

[Dynamic mode switching]

HQ-lock supports switching between "default qspinlock" mode to "NUMA-aware lock" mode and backwards.
Here we introduce simple scheme: when the contention is high enough a lock switches to NUMA-aware mode
until it is completely released.

If for some reason "NUMA-aware" mode cannot be enabled we fallback to default qspinlock mode.

[Usage]

If someone wants to try the HQ-lock in some subsystem, just
change lock initialization code from "spin_lock_init()" to "spin_lock_init_hq()".
The dedicated bit in the lock structure is used to distiguish between the two lock types.

[Performance measurements]

Performance measurements were done on x86 (AMD EPYC) and arm64 (Kunpeng 920)
platforms with the following scenarious:
- Locktorture benchmark
- Memcached + memtier benchmark
- Ngnix + Wrk benchmark

[Locktorture]

NPS stands for "Nodes per socket"
+------------------------------+-----------------------+-------+-------+--------+
| AMD EPYC 9654									|
+------------------------------+-----------------------+-------+-------+--------+
| 192 cores (x2 hyper-threads) |                       |       |       |        |
| 2 sockets                    |                       |       |       |        |
| Locktorture 60 sec.          | NUMA nodes per-socket |       |       |        |
| Average gain (single lock)   | 1 NPS                 | 2 NPS | 4 NPS | 12 NPS |
| Total contender threads      |                       |       |       |        |
| 8                            | 19%                   | 21%   | 12%   | 12%    |
| 16                           | 13%                   | 18%   | 34%   | 75%    |
| 32                           | 8%                    | 14%   | 25%   | 112%   |
| 64                           | 11%                   | 12%   | 30%   | 152%   |
| 128                          | 9%                    | 17%   | 37%   | 163%   |
| 256                          | 2%                    | 16%   | 40%   | 168%   |
| 384                          | -1%                   | 14%   | 44%   | 186%   |
+------------------------------+-----------------------+-------+-------+--------+

+-----------------+-------+-------+-------+--------+
| Fairness factor | 1 NPS | 2 NPS | 4 NPS | 12 NPS |
+-----------------+-------+-------+-------+--------+
| 8               | 0.54  | 0.57  | 0.57  | 0.55   |
| 16              | 0.52  | 0.53  | 0.60  | 0.58   |
| 32              | 0.53  | 0.53  | 0.53  | 0.61   |
| 64              | 0.52  | 0.56  | 0.54  | 0.56   |
| 128             | 0.51  | 0.54  | 0.54  | 0.53   |
| 256             | 0.52  | 0.52  | 0.52  | 0.52   |
| 384             | 0.51  | 0.51  | 0.51  | 0.51   |
+-----------------+-------+-------+-------+--------+

+-------------------------+--------------+
| Kunpeng 920 (arm64)     |              |
+-------------------------+--------------+
| 96 cores (no MT)        |              |
| 2 sockets, 4 NUMA nodes |              |
| Locktorture 60 sec.     |              |
|                         |              |
| Total contender threads | Average gain |
| 8                       | 93%          |
| 16                      | 142%         |
| 32                      | 129%         |
| 64                      | 152%         |
| 96                      | 158%         |
+-------------------------+--------------+

[Memcached]

+---------------------------------+-----------------+-------------------+
| AMD EPYC 9654                   |                 |                   |
+---------------------------------+-----------------+-------------------+
| 192 cores (x2 hyper-threads)    |                 |                   |
| 2 sockets, NPS=4                |                 |                   |
|                                 |                 |                   |
| Memtier+memcached 1:1 R/W ratio |                 |                   |
| Workers                         | Throughput gain | Latency reduction |
| 32                              | 1%              | -1%               |
| 64                              | 1%              | -1%               |
| 128                             | 3%              | -4%               |
| 256                             | 7%              | -6%               |
| 384                             | 10%             | -8%               |
+---------------------------------+-----------------+-------------------+

+---------------------------------+-----------------+-------------------+
| Kunpeng 920 (arm64)             |                 |                   |
+---------------------------------+-----------------+-------------------+
| 96 cores (no MT)                |                 |                   |
| 2 sockets, 4 NUMA nodes         |                 |                   |
|                                 |                 |                   |
| Memtier+memcached 1:1 R/W ratio |                 |                   |
| Workers                         | Throughput gain | Latency reduction |
| 32                              | 4%              | -3%               |
| 64                              | 6%              | -6%               |
| 80                              | 8%              | -7%               |
| 96                              | 8%              | -8%               |
+---------------------------------+-----------------+-------------------+

[Nginx]

+-----------------------------------------------------------------------+-----------------+
| Kunpeng 920 (arm64)                                                   |                 |
+-----------------------------------------------------------------------+-----------------+
| 96 cores (no MT)                                                      |                 |
| 2 sockets, 4 NUMA nodes                                               |                 |
|                                                                       |                 |
| Nginx + WRK benchmark, single file (lockref spinlock contention case) |                 |
| Workers                                                               | Throughput gain |
| 32                                                                    | 1%              |
| 64                                                                    | 68%             |
| 80                                                                    | 72%             |
| 96                                                                    | 78%             |
+-----------------------------------------------------------------------+-----------------+
Despite, the test is a single-file test, it can be related to real-life cases, when some
html-pages are accessed much more frequently than others (index.html, etc.)

[Low contention remarks]

With the simple contention detection scheme presented in the patch we observe
some degradation, compared to "qspinlock" in low-contention scenraios (< 8 contenders).

We're working on more sophisticated and effective contention-detection method, that
addresses the issue.

Anatoly Stepanov, Nikita Fedorov (1):
  HQspinlock - (NUMA-aware) Hierarchical Queued spinlock

 arch/arm64/Kconfig                    |  28 +
 arch/arm64/include/asm/qspinlock.h    |  37 ++
 arch/x86/Kconfig                      |  28 +
 arch/x86/include/asm/qspinlock.h      |  38 +-
 include/asm-generic/qspinlock.h       |  23 +-
 include/asm-generic/qspinlock_types.h |  52 +-
 include/linux/lockref.h               |   2 +-
 include/linux/spinlock.h              |  26 +
 include/linux/spinlock_types.h        |  26 +
 include/linux/spinlock_types_raw.h    |  20 +
 init/main.c                           |   4 +
 kernel/futex/core.c                   |   2 +-
 kernel/locking/hqlock_core.h          | 832 ++++++++++++++++++++++++++
 kernel/locking/hqlock_meta.h          | 477 +++++++++++++++
 kernel/locking/hqlock_proc.h          |  88 +++
 kernel/locking/hqlock_types.h         | 118 ++++
 kernel/locking/qspinlock.c            |  67 ++-
 kernel/locking/qspinlock.h            |   4 +-
 kernel/locking/spinlock_debug.c       |  20 +
 19 files changed, 1862 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/include/asm/qspinlock.h
 create mode 100644 kernel/locking/hqlock_core.h
 create mode 100644 kernel/locking/hqlock_meta.h
 create mode 100644 kernel/locking/hqlock_proc.h
 create mode 100644 kernel/locking/hqlock_types.h

-- 
2.34.1


