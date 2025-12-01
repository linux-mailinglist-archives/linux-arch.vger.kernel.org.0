Return-Path: <linux-arch+bounces-15123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0016EC98086
	for <lists+linux-arch@lfdr.de>; Mon, 01 Dec 2025 16:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EDB634256B
	for <lists+linux-arch@lfdr.de>; Mon,  1 Dec 2025 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7532B9BA;
	Mon,  1 Dec 2025 15:23:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62532B9B9;
	Mon,  1 Dec 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602590; cv=none; b=BsGlS9jl97yVlm9BZOt+FQYjT7SEWx+u4RVH2tOYtyu850Tkj2foD8ma3004LyujrQLWVWZfz7FtEIyeatWlCD3w4bq+2egDhYUXfjhClf2D0SW+UMY7FcMpU2jjDEzYabMGpMMpcKMWFlJEILD6SBvJxCUq7zomNlDVaa+TzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602590; c=relaxed/simple;
	bh=65T3+ELmkSO7iyGOUlTIWigWCU0kNSD8HMMI4WsoyoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y6dyHUtjmryOlMGySELaDwiGQ05qO98/CfF7v3caPkjpy3EqkRTKMc3J7VhiXu/Mngm3hIucZruyz7opKVz2HBrunch4lTwAey/hlAQHuCH9hSnrPrQxO24JKnVvQXTpbr7egowXNh54aQQCy8p1ZHDdyh3CmiNAC0XC6cN7h0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dKnhr6XDFzJ46XN;
	Mon,  1 Dec 2025 23:22:52 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CE3940565;
	Mon,  1 Dec 2025 23:22:56 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Dec 2025 18:22:55 +0300
Message-ID: <c2b0c29d-0d65-4ecd-b7dd-dc3690936a07@huawei.com>
Date: Mon, 1 Dec 2025 18:22:55 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Introduce Hierarchical Queued NUMA-aware spinlock
To: Waiman Long <llong@redhat.com>
CC: <peterz@infradead.org>, <boqun.feng@gmail.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<arnd@arndb.de>, <dvhart@infradead.org>, <dave@stgolabs.net>,
	<andrealmeid@igalia.com>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <guohanjun@huawei.com>,
	<wangkefeng.wang@huawei.com>, <weiyongjun1@huawei.com>,
	<yusongping@huawei.com>, <leijitang@huawei.com>, <artem.kuzin@huawei.com>,
	<fedorov.nikita@h-partners.com>, <kang.sun@huawei.com>
References: <20251128032618.811617-1-stepanov.anatoly@huawei.com>
 <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 11/30/2025 7:04 PM, Waiman Long wrote:
> On 11/27/25 10:26 PM, Anatoly Stepanov wrote:
>> [Introduction & Motivation]
>>
>> In a high contention case, existing Linux kernel spinlock implementations can become
>> inefficient on modern NUMA-systems due to frequent and expensive
>> cross-NUMA cache-line transfers.
>>
>> This might happen due to following reasons:
>>   - on "contender enqueue" each lock contender updates a shared lock structure
>>   - on "MCS handoff" cross-NUMA cache-line transfer occurs when
>> two contenders are from different NUMA nodes.
>>
>> We introduce Hierarchical Queued Spinlock (HQ spinlock), aiming to
>> reduce cross-NUMA cache line traffic and thus improving lock/unlock throughput
>> for high-contention cases.
>>
>> This idea might be considered as a combination of cohort-locking
>> by Dave Dice and Linux kernel queued spinlock.
>>
>> [Design and workflow]
>>
>> The contenders are organized into 2-level scheme where each NUMA-node
>> has it's own FIFO contender queue.
>>
>> NUMA-queues are linked into single-linked list alike structure, while
>> maintaining FIFO order between them.
>> When there're no contenders left in a NUMA-queue, the queue is removed from
>> the list.
>>
>> Contenders try to enqueue to local NUMA-queue first and if there's
>> no such queue - link it to the list.
>> As for "qspinlock" only the first contender is spinning globally,
>> all others - MCS-spinning.
>>
>> "Handoff" operation becomes two-staged:
>> - local handoff: between contenders in a single NUMA-queue
>> - remote handoff: between different NUMA-queues.
>>
>> If "remote handoff" reaches the end of the NUMA-queue linked list it goes to
>> the list head.
>>
>> To avoid potential starvation issues, we use handoff thresholds.
>>
>> Key challenge here was keeping the same "qspinlock" structure size
>> and "bind" a given lock to related NUMA-queues.
>>
>> We came up with dynamic lock metadata concept, where we can
>> dynamically "bind" a given lock to it's NUMA-related metadata, and
>> then "unbind" when the lock is released.
>>
>> This approach allows to avoid metadata reservation for every lock in advance,
>> thus giving the upperbound of metadata instance number to ~ (NR_CPUS x nr_contexts / 2).
>> Which corresponds to maximum amount of different locks falling into the slowpath.
>>
>> [Dynamic mode switching]
>>
>> HQ-lock supports switching between "default qspinlock" mode to "NUMA-aware lock" mode and backwards.
>> Here we introduce simple scheme: when the contention is high enough a lock switches to NUMA-aware mode
>> until it is completely released.
>>
>> If for some reason "NUMA-aware" mode cannot be enabled we fallback to default qspinlock mode.
>>
>> [Usage]
>>
>> If someone wants to try the HQ-lock in some subsystem, just
>> change lock initialization code from "spin_lock_init()" to "spin_lock_init_hq()".
>> The dedicated bit in the lock structure is used to distiguish between the two lock types.
>>
>> [Performance measurements]
>>
>> Performance measurements were done on x86 (AMD EPYC) and arm64 (Kunpeng 920)
>> platforms with the following scenarious:
>> - Locktorture benchmark
>> - Memcached + memtier benchmark
>> - Ngnix + Wrk benchmark
>>
>> [Locktorture]
>>
>> NPS stands for "Nodes per socket"
>> +------------------------------+-----------------------+-------+-------+--------+
>> | AMD EPYC 9654                                    |
>> +------------------------------+-----------------------+-------+-------+--------+
>> | 192 cores (x2 hyper-threads) |                       |       |       |        |
>> | 2 sockets                    |                       |       |       |        |
>> | Locktorture 60 sec.          | NUMA nodes per-socket |       |       |        |
>> | Average gain (single lock)   | 1 NPS                 | 2 NPS | 4 NPS | 12 NPS |
>> | Total contender threads      |                       |       |       |        |
>> | 8                            | 19%                   | 21%   | 12%   | 12%    |
>> | 16                           | 13%                   | 18%   | 34%   | 75%    |
>> | 32                           | 8%                    | 14%   | 25%   | 112%   |
>> | 64                           | 11%                   | 12%   | 30%   | 152%   |
>> | 128                          | 9%                    | 17%   | 37%   | 163%   |
>> | 256                          | 2%                    | 16%   | 40%   | 168%   |
>> | 384                          | -1%                   | 14%   | 44%   | 186%   |
>> +------------------------------+-----------------------+-------+-------+--------+
>>
>> +-----------------+-------+-------+-------+--------+
>> | Fairness factor | 1 NPS | 2 NPS | 4 NPS | 12 NPS |
>> +-----------------+-------+-------+-------+--------+
>> | 8               | 0.54  | 0.57  | 0.57  | 0.55   |
>> | 16              | 0.52  | 0.53  | 0.60  | 0.58   |
>> | 32              | 0.53  | 0.53  | 0.53  | 0.61   |
>> | 64              | 0.52  | 0.56  | 0.54  | 0.56   |
>> | 128             | 0.51  | 0.54  | 0.54  | 0.53   |
>> | 256             | 0.52  | 0.52  | 0.52  | 0.52   |
>> | 384             | 0.51  | 0.51  | 0.51  | 0.51   |
>> +-----------------+-------+-------+-------+--------+
>>
>> +-------------------------+--------------+
>> | Kunpeng 920 (arm64)     |              |
>> +-------------------------+--------------+
>> | 96 cores (no MT)        |              |
>> | 2 sockets, 4 NUMA nodes |              |
>> | Locktorture 60 sec.     |              |
>> |                         |              |
>> | Total contender threads | Average gain |
>> | 8                       | 93%          |
>> | 16                      | 142%         |
>> | 32                      | 129%         |
>> | 64                      | 152%         |
>> | 96                      | 158%         |
>> +-------------------------+--------------+
>>
>> [Memcached]
>>
>> +---------------------------------+-----------------+-------------------+
>> | AMD EPYC 9654                   |                 |                   |
>> +---------------------------------+-----------------+-------------------+
>> | 192 cores (x2 hyper-threads)    |                 |                   |
>> | 2 sockets, NPS=4                |                 |                   |
>> |                                 |                 |                   |
>> | Memtier+memcached 1:1 R/W ratio |                 |                   |
>> | Workers                         | Throughput gain | Latency reduction |
>> | 32                              | 1%              | -1%               |
>> | 64                              | 1%              | -1%               |
>> | 128                             | 3%              | -4%               |
>> | 256                             | 7%              | -6%               |
>> | 384                             | 10%             | -8%               |
>> +---------------------------------+-----------------+-------------------+
>>
>> +---------------------------------+-----------------+-------------------+
>> | Kunpeng 920 (arm64)             |                 |                   |
>> +---------------------------------+-----------------+-------------------+
>> | 96 cores (no MT)                |                 |                   |
>> | 2 sockets, 4 NUMA nodes         |                 |                   |
>> |                                 |                 |                   |
>> | Memtier+memcached 1:1 R/W ratio |                 |                   |
>> | Workers                         | Throughput gain | Latency reduction |
>> | 32                              | 4%              | -3%               |
>> | 64                              | 6%              | -6%               |
>> | 80                              | 8%              | -7%               |
>> | 96                              | 8%              | -8%               |
>> +---------------------------------+-----------------+-------------------+
>>
>> [Nginx]
>>
>> +-----------------------------------------------------------------------+-----------------+
>> | Kunpeng 920 (arm64)                                                   |                 |
>> +-----------------------------------------------------------------------+-----------------+
>> | 96 cores (no MT)                                                      |                 |
>> | 2 sockets, 4 NUMA nodes                                               |                 |
>> |                                                                       |                 |
>> | Nginx + WRK benchmark, single file (lockref spinlock contention case) |                 |
>> | Workers                                                               | Throughput gain |
>> | 32                                                                    | 1%              |
>> | 64                                                                    | 68%             |
>> | 80                                                                    | 72%             |
>> | 96                                                                    | 78%             |
>> +-----------------------------------------------------------------------+-----------------+
>> Despite, the test is a single-file test, it can be related to real-life cases, when some
>> html-pages are accessed much more frequently than others (index.html, etc.)
>>
>> [Low contention remarks]
>>
>> With the simple contention detection scheme presented in the patch we observe
>> some degradation, compared to "qspinlock" in low-contention scenraios (< 8 contenders).
>>
>> We're working on more sophisticated and effective contention-detection method, that
>> addresses the issue.
>>
>> Anatoly Stepanov, Nikita Fedorov (1):
>>    HQspinlock - (NUMA-aware) Hierarchical Queued spinlock
>>
>>   arch/arm64/Kconfig                    |  28 +
>>   arch/arm64/include/asm/qspinlock.h    |  37 ++
>>   arch/x86/Kconfig                      |  28 +
>>   arch/x86/include/asm/qspinlock.h      |  38 +-
>>   include/asm-generic/qspinlock.h       |  23 +-
>>   include/asm-generic/qspinlock_types.h |  52 +-
>>   include/linux/lockref.h               |   2 +-
>>   include/linux/spinlock.h              |  26 +
>>   include/linux/spinlock_types.h        |  26 +
>>   include/linux/spinlock_types_raw.h    |  20 +
>>   init/main.c                           |   4 +
>>   kernel/futex/core.c                   |   2 +-
>>   kernel/locking/hqlock_core.h          | 832 ++++++++++++++++++++++++++
>>   kernel/locking/hqlock_meta.h          | 477 +++++++++++++++
>>   kernel/locking/hqlock_proc.h          |  88 +++
>>   kernel/locking/hqlock_types.h         | 118 ++++
>>   kernel/locking/qspinlock.c            |  67 ++-
>>   kernel/locking/qspinlock.h            |   4 +-
>>   kernel/locking/spinlock_debug.c       |  20 +
>>   19 files changed, 1862 insertions(+), 30 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/qspinlock.h
>>   create mode 100644 kernel/locking/hqlock_core.h
>>   create mode 100644 kernel/locking/hqlock_meta.h
>>   create mode 100644 kernel/locking/hqlock_proc.h
>>   create mode 100644 kernel/locking/hqlock_types.h
> 
> There was a past attempt to make qspinlock NUMA-aware.
> 
> https://lore.kernel.org/lkml/20210514200743.3026725-1-alex.kogan@oracle.com/
> 
> I am not sure if you had seen that as you didn't mention about this patch.
>

Hi, thanks for your feedback and comments!

Regarding CNA-lock
(https://lore.kernel.org/lkml/20210514200743.3026725-1-alex.kogan@oracle.com/),
of course we know and compared CNA vs HQ-lock.

Agree, it should have been mentioned right away.

For AMD EPYC9654, locktorture+CNA showed same results as default qspinlock.
This part is interesting, as we did many attempts to make sure everything is correct
in the testing procedure.

So exact same results as for "HQ-lock" vs "qspinlock".
 
For "Kunpeng 920", CNA-lock shows performance improvement, compared to qspinlock, 
but anyway HQ-lock outperforms CNA-lock, here the "locktorture" results:

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

 
> That previous patch differs from yours in the following ways:
> 
> 1) It can coexist with pvspinlock and is activated only if running on bare metal and on systems with 2 or more NUMA nodes. Your patch is mutually exhaustive with pvqspinlock.
We can support such limitation too.

> 
> 2) Once the NUMA-aware lock is activated, all the spinlocks will use it instead of using a separate init call to enable its use.
> 
> 3) Your patch can dynamically switch between the qspinlock and HQ lock mode which the previous one doesn't.
> 
> There are pros and cons in both cases.
> 
> I also have some general comments about this patch.
> 
> Your patch is too large to review as a single patch. I would suggest breaking it up in multiple smaller patches to make it easier to review. Also the cover letter won't be included if the patch is merged, but the patch description in that single patch is not informative at all. I would suggest putting the design and the performance information shown in this cover letter to the individual patches and with a relatively brief cover letter.
> 
> I have more comments about the actual content of your patch 1 in another email.

We'll going to address all the issues you mentioned and re-send RFC-v2 this week.

> Cheers,
> Longman
> 
> 

-- 
Anatoly Stepanov, Huawei

