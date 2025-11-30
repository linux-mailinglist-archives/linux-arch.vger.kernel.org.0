Return-Path: <linux-arch+bounces-15108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5621C9520F
	for <lists+linux-arch@lfdr.de>; Sun, 30 Nov 2025 17:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50D1A4E05CF
	for <lists+linux-arch@lfdr.de>; Sun, 30 Nov 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20262BE625;
	Sun, 30 Nov 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0J5tODP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbzbcQMq"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0580222584
	for <linux-arch@vger.kernel.org>; Sun, 30 Nov 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764518680; cv=none; b=XmjOMdOQAMHXxnO/1wrT5sHyYZPHgdpP/UgY5ZX2gryhGO/qw2PRzrDa4wDlPhG3gQ/uu6N+Jycb0DsZor7Oevi6UPvgKVFiJ2lLc4UmyUliCUJYYe3zp5zK0jvL5ejPioQtKYJO5sxBkQgJDdtFcQ5Hjd6y9KZB/rWLYgxpDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764518680; c=relaxed/simple;
	bh=Z9Q0r6FBK8wWIswlY51eRVzDdJ5v9f73/o1IbA43ZQg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R/pfiSbeEOjW22KXUqpoO8pTBlOj9yUuZjP5GOblyLh0faceXM8tGiHGVC02CojRCRidXutWn6xeJzKyZA0xMUREj7EIdEKdRt5PMak2Bhc+a1IL1b2XROa+/qyLgSlh2yB8VcJO5ugSHSTZaRx7FXF0RfAfzZLTwEl2zLEcHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0J5tODP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbzbcQMq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764518677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbaj1SW1cq/w6o6FMiEkc6DGkSX2iQjzZWSAeeQsjb0=;
	b=P0J5tODP4JAcQZnBJ3vybG/3pdDzt0DnJwoB8NnsgoYvCJNG99ddjpWxWINZl3sFYf3Pm0
	H28UaZ8dY/+WQPw1HHM8vFIL3EX/ahtp/eUutD48p7fS/6j5wTeiqQ4o1Ntr97Mxtg60F8
	zlLbxvoDwnMzshJGJSX4cPo5jpcvfXQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-_0jeyY1OPG6NBFDMlgBJgA-1; Sun, 30 Nov 2025 11:04:35 -0500
X-MC-Unique: _0jeyY1OPG6NBFDMlgBJgA-1
X-Mimecast-MFC-AGG-ID: _0jeyY1OPG6NBFDMlgBJgA_1764518675
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b24a25cff5so614696085a.2
        for <linux-arch@vger.kernel.org>; Sun, 30 Nov 2025 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764518675; x=1765123475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sbaj1SW1cq/w6o6FMiEkc6DGkSX2iQjzZWSAeeQsjb0=;
        b=KbzbcQMqYFcqRAV+ay7UsScmWUe3thMyosUNtmNxG/+acEo1HitNdnrykyChui74r6
         sP0jmbuY47/0oZRGNg0EOsHGDzaHDBLSfFpSracKU3DsO2OQJqB5FlXjY0pumStjMaie
         2ZxrI23G+KjPjx20Khl3r03FFaK9CbNC0u4EvERm+E19dEm6x9f7F05Pu0UdJytsuyTg
         BtDCfDz620jfA4gkTU88lDK1rQ42VnD/lrd2cXVMXPktdgP+j3LUXJ5eWuEv3PcMAYeK
         Jgfs2CXkluDTvMFuE9NJkP7GojO+gtdS/DPeRbRo+n1eF2M0w/SrRhNgo9L/d5F+k2ON
         J2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764518675; x=1765123475;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbaj1SW1cq/w6o6FMiEkc6DGkSX2iQjzZWSAeeQsjb0=;
        b=sPtqn00vdMyuYLOvH3TmvtmctwN38Bap4/p2MgLJjwOvx2iH+LgSIBgrxFjCtsIrKB
         /DIsxe3kWlbBtrhayrRynhht3JYFrB2MwEit/+BCyWFbAwUBEeER7YEbeKTAdNqtKuDj
         fVwbkxda3tF6UT6+Z3uFinzKmk6UqX+bYrw3uMggfHXtwhGRNo071tCcOBQunPCe9mMI
         HqwqsvIfmjF1Q1vtX1psOBK9vi8lp+xARlLAy4j4YleCTMi/B4SrQ4fVneA6Lol7taQK
         sGJUOG9TpmFsLRAzcWhPn+WskcqkAtsT/WE1gKq07pKL+UQN+JmpPG8Eiik5E8d+Eozj
         X5sw==
X-Forwarded-Encrypted: i=1; AJvYcCVbojOzLEe8yHH6L00dU29q0vE9n5b2qxHCS+VLMfj3E+/Y8L744Wkv8aJRi2xqtpTJ4bIJ7nPSzbn0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VWwJnQjpkUL6BWRF5FZI4W5WvOmp9p+xMl89pfjziOZmF7TD
	E2tGg3FUQCNtXEEo53TrzwcKtieDY7eM89r+gFrG7agYsN45Or+J8bB5fl3N3K+QcP8HqrgxnAj
	XhqUbOTyBrS2ZAuVk2BfU4vPxFQH6zlyxaE6BhS83aNrcp7ed6ATaWcIE5RW49cc=
X-Gm-Gg: ASbGnctFcAdtH7oCp3Y5ZScQNlOA5VBpXGYCFNO9Es8G3qQfb9VGoIhA+DqRquEEMMm
	KExM7PnDHzLB8/XW4nzODD73XZHNkfc3cZu4CBjvoQh6byFWHePcuh2Y70ID8ZVfjDAFyRa6Fv1
	m+88wvDb5Ay+9TbkGpIeoOdwWiO9mUa+08X+jhRdxRCmZd5r1wMxwyzi7K0QnBHHP9aAcukHbzQ
	NaAMquCQ3KL7wurKQbSzVv6TSfqa8JsowAgvlwSwGD8PCSTS9oncBbXHIGmaaKg/Zk5UstK+rzh
	U4AbYN9gxsyPsNhBMB4M8t1QNmxp5TJbgykIvSqy+2LUl59+49ZMB8GAcAscgXYSrc1iQ3b91Kp
	vj+8aeDavG3dw4yPU7WRlUc9baBjk1RVf0juyzT3TONbXN3rKIzAXNp7F
X-Received: by 2002:a05:620a:4606:b0:8b2:f191:2b3b with SMTP id af79cd13be357-8b33d5e2e3fmr4594835985a.67.1764518674804;
        Sun, 30 Nov 2025 08:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKrm2mrJSgcSkE4WJjL+Sl2cRQBedBtTs79GZH8y+VDoS62awm8CiuSCOy77A1HbFE1Pol4g==
X-Received: by 2002:a05:620a:4606:b0:8b2:f191:2b3b with SMTP id af79cd13be357-8b33d5e2e3fmr4594826985a.67.1764518674207;
        Sun, 30 Nov 2025 08:04:34 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1dd353sm692916585a.49.2025.11.30.08.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 08:04:33 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
Date: Sun, 30 Nov 2025 11:04:31 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Introduce Hierarchical Queued NUMA-aware spinlock
To: Anatoly Stepanov <stepanov.anatoly@huawei.com>, peterz@infradead.org,
 boqun.feng@gmail.com, catalin.marinas@arm.com, will@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, dvhart@infradead.org, dave@stgolabs.net,
 andrealmeid@igalia.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 guohanjun@huawei.com, wangkefeng.wang@huawei.com, weiyongjun1@huawei.com,
 yusongping@huawei.com, leijitang@huawei.com, artem.kuzin@huawei.com,
 fedorov.nikita@h-partners.com, kang.sun@huawei.com
References: <20251128032618.811617-1-stepanov.anatoly@huawei.com>
Content-Language: en-US
In-Reply-To: <20251128032618.811617-1-stepanov.anatoly@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/25 10:26 PM, Anatoly Stepanov wrote:
> [Introduction & Motivation]
>
> In a high contention case, existing Linux kernel spinlock implementations can become
> inefficient on modern NUMA-systems due to frequent and expensive
> cross-NUMA cache-line transfers.
>
> This might happen due to following reasons:
>   - on "contender enqueue" each lock contender updates a shared lock structure
>   - on "MCS handoff" cross-NUMA cache-line transfer occurs when
> two contenders are from different NUMA nodes.
>
> We introduce Hierarchical Queued Spinlock (HQ spinlock), aiming to
> reduce cross-NUMA cache line traffic and thus improving lock/unlock throughput
> for high-contention cases.
>
> This idea might be considered as a combination of cohort-locking
> by Dave Dice and Linux kernel queued spinlock.
>
> [Design and workflow]
>
> The contenders are organized into 2-level scheme where each NUMA-node
> has it's own FIFO contender queue.
>
> NUMA-queues are linked into single-linked list alike structure, while
> maintaining FIFO order between them.
> When there're no contenders left in a NUMA-queue, the queue is removed from
> the list.
>
> Contenders try to enqueue to local NUMA-queue first and if there's
> no such queue - link it to the list.
> As for "qspinlock" only the first contender is spinning globally,
> all others - MCS-spinning.
>
> "Handoff" operation becomes two-staged:
> - local handoff: between contenders in a single NUMA-queue
> - remote handoff: between different NUMA-queues.
>
> If "remote handoff" reaches the end of the NUMA-queue linked list it goes to
> the list head.
>
> To avoid potential starvation issues, we use handoff thresholds.
>
> Key challenge here was keeping the same "qspinlock" structure size
> and "bind" a given lock to related NUMA-queues.
>
> We came up with dynamic lock metadata concept, where we can
> dynamically "bind" a given lock to it's NUMA-related metadata, and
> then "unbind" when the lock is released.
>
> This approach allows to avoid metadata reservation for every lock in advance,
> thus giving the upperbound of metadata instance number to ~ (NR_CPUS x nr_contexts / 2).
> Which corresponds to maximum amount of different locks falling into the slowpath.
>
> [Dynamic mode switching]
>
> HQ-lock supports switching between "default qspinlock" mode to "NUMA-aware lock" mode and backwards.
> Here we introduce simple scheme: when the contention is high enough a lock switches to NUMA-aware mode
> until it is completely released.
>
> If for some reason "NUMA-aware" mode cannot be enabled we fallback to default qspinlock mode.
>
> [Usage]
>
> If someone wants to try the HQ-lock in some subsystem, just
> change lock initialization code from "spin_lock_init()" to "spin_lock_init_hq()".
> The dedicated bit in the lock structure is used to distiguish between the two lock types.
>
> [Performance measurements]
>
> Performance measurements were done on x86 (AMD EPYC) and arm64 (Kunpeng 920)
> platforms with the following scenarious:
> - Locktorture benchmark
> - Memcached + memtier benchmark
> - Ngnix + Wrk benchmark
>
> [Locktorture]
>
> NPS stands for "Nodes per socket"
> +------------------------------+-----------------------+-------+-------+--------+
> | AMD EPYC 9654									|
> +------------------------------+-----------------------+-------+-------+--------+
> | 192 cores (x2 hyper-threads) |                       |       |       |        |
> | 2 sockets                    |                       |       |       |        |
> | Locktorture 60 sec.          | NUMA nodes per-socket |       |       |        |
> | Average gain (single lock)   | 1 NPS                 | 2 NPS | 4 NPS | 12 NPS |
> | Total contender threads      |                       |       |       |        |
> | 8                            | 19%                   | 21%   | 12%   | 12%    |
> | 16                           | 13%                   | 18%   | 34%   | 75%    |
> | 32                           | 8%                    | 14%   | 25%   | 112%   |
> | 64                           | 11%                   | 12%   | 30%   | 152%   |
> | 128                          | 9%                    | 17%   | 37%   | 163%   |
> | 256                          | 2%                    | 16%   | 40%   | 168%   |
> | 384                          | -1%                   | 14%   | 44%   | 186%   |
> +------------------------------+-----------------------+-------+-------+--------+
>
> +-----------------+-------+-------+-------+--------+
> | Fairness factor | 1 NPS | 2 NPS | 4 NPS | 12 NPS |
> +-----------------+-------+-------+-------+--------+
> | 8               | 0.54  | 0.57  | 0.57  | 0.55   |
> | 16              | 0.52  | 0.53  | 0.60  | 0.58   |
> | 32              | 0.53  | 0.53  | 0.53  | 0.61   |
> | 64              | 0.52  | 0.56  | 0.54  | 0.56   |
> | 128             | 0.51  | 0.54  | 0.54  | 0.53   |
> | 256             | 0.52  | 0.52  | 0.52  | 0.52   |
> | 384             | 0.51  | 0.51  | 0.51  | 0.51   |
> +-----------------+-------+-------+-------+--------+
>
> +-------------------------+--------------+
> | Kunpeng 920 (arm64)     |              |
> +-------------------------+--------------+
> | 96 cores (no MT)        |              |
> | 2 sockets, 4 NUMA nodes |              |
> | Locktorture 60 sec.     |              |
> |                         |              |
> | Total contender threads | Average gain |
> | 8                       | 93%          |
> | 16                      | 142%         |
> | 32                      | 129%         |
> | 64                      | 152%         |
> | 96                      | 158%         |
> +-------------------------+--------------+
>
> [Memcached]
>
> +---------------------------------+-----------------+-------------------+
> | AMD EPYC 9654                   |                 |                   |
> +---------------------------------+-----------------+-------------------+
> | 192 cores (x2 hyper-threads)    |                 |                   |
> | 2 sockets, NPS=4                |                 |                   |
> |                                 |                 |                   |
> | Memtier+memcached 1:1 R/W ratio |                 |                   |
> | Workers                         | Throughput gain | Latency reduction |
> | 32                              | 1%              | -1%               |
> | 64                              | 1%              | -1%               |
> | 128                             | 3%              | -4%               |
> | 256                             | 7%              | -6%               |
> | 384                             | 10%             | -8%               |
> +---------------------------------+-----------------+-------------------+
>
> +---------------------------------+-----------------+-------------------+
> | Kunpeng 920 (arm64)             |                 |                   |
> +---------------------------------+-----------------+-------------------+
> | 96 cores (no MT)                |                 |                   |
> | 2 sockets, 4 NUMA nodes         |                 |                   |
> |                                 |                 |                   |
> | Memtier+memcached 1:1 R/W ratio |                 |                   |
> | Workers                         | Throughput gain | Latency reduction |
> | 32                              | 4%              | -3%               |
> | 64                              | 6%              | -6%               |
> | 80                              | 8%              | -7%               |
> | 96                              | 8%              | -8%               |
> +---------------------------------+-----------------+-------------------+
>
> [Nginx]
>
> +-----------------------------------------------------------------------+-----------------+
> | Kunpeng 920 (arm64)                                                   |                 |
> +-----------------------------------------------------------------------+-----------------+
> | 96 cores (no MT)                                                      |                 |
> | 2 sockets, 4 NUMA nodes                                               |                 |
> |                                                                       |                 |
> | Nginx + WRK benchmark, single file (lockref spinlock contention case) |                 |
> | Workers                                                               | Throughput gain |
> | 32                                                                    | 1%              |
> | 64                                                                    | 68%             |
> | 80                                                                    | 72%             |
> | 96                                                                    | 78%             |
> +-----------------------------------------------------------------------+-----------------+
> Despite, the test is a single-file test, it can be related to real-life cases, when some
> html-pages are accessed much more frequently than others (index.html, etc.)
>
> [Low contention remarks]
>
> With the simple contention detection scheme presented in the patch we observe
> some degradation, compared to "qspinlock" in low-contention scenraios (< 8 contenders).
>
> We're working on more sophisticated and effective contention-detection method, that
> addresses the issue.
>
> Anatoly Stepanov, Nikita Fedorov (1):
>    HQspinlock - (NUMA-aware) Hierarchical Queued spinlock
>
>   arch/arm64/Kconfig                    |  28 +
>   arch/arm64/include/asm/qspinlock.h    |  37 ++
>   arch/x86/Kconfig                      |  28 +
>   arch/x86/include/asm/qspinlock.h      |  38 +-
>   include/asm-generic/qspinlock.h       |  23 +-
>   include/asm-generic/qspinlock_types.h |  52 +-
>   include/linux/lockref.h               |   2 +-
>   include/linux/spinlock.h              |  26 +
>   include/linux/spinlock_types.h        |  26 +
>   include/linux/spinlock_types_raw.h    |  20 +
>   init/main.c                           |   4 +
>   kernel/futex/core.c                   |   2 +-
>   kernel/locking/hqlock_core.h          | 832 ++++++++++++++++++++++++++
>   kernel/locking/hqlock_meta.h          | 477 +++++++++++++++
>   kernel/locking/hqlock_proc.h          |  88 +++
>   kernel/locking/hqlock_types.h         | 118 ++++
>   kernel/locking/qspinlock.c            |  67 ++-
>   kernel/locking/qspinlock.h            |   4 +-
>   kernel/locking/spinlock_debug.c       |  20 +
>   19 files changed, 1862 insertions(+), 30 deletions(-)
>   create mode 100644 arch/arm64/include/asm/qspinlock.h
>   create mode 100644 kernel/locking/hqlock_core.h
>   create mode 100644 kernel/locking/hqlock_meta.h
>   create mode 100644 kernel/locking/hqlock_proc.h
>   create mode 100644 kernel/locking/hqlock_types.h

There was a past attempt to make qspinlock NUMA-aware.

https://lore.kernel.org/lkml/20210514200743.3026725-1-alex.kogan@oracle.com/

I am not sure if you had seen that as you didn't mention about this patch.

That previous patch differs from yours in the following ways:

1) It can coexist with pvspinlock and is activated only if running on 
bare metal and on systems with 2 or more NUMA nodes. Your patch is 
mutually exhaustive with pvqspinlock.

2) Once the NUMA-aware lock is activated, all the spinlocks will use it 
instead of using a separate init call to enable its use.

3) Your patch can dynamically switch between the qspinlock and HQ lock 
mode which the previous one doesn't.

There are pros and cons in both cases.

I also have some general comments about this patch.

Your patch is too large to review as a single patch. I would suggest 
breaking it up in multiple smaller patches to make it easier to review. 
Also the cover letter won't be included if the patch is merged, but the 
patch description in that single patch is not informative at all. I 
would suggest putting the design and the performance information shown 
in this cover letter to the individual patches and with a relatively 
brief cover letter.

I have more comments about the actual content of your patch 1 in another 
email.

Cheers,
Longman


