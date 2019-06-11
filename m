Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477B23C20B
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2019 06:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfFKEW3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jun 2019 00:22:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfFKEW3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 00:22:29 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 2B09EFC6017021BD9648;
        Tue, 11 Jun 2019 12:22:26 +0800 (CST)
Received: from dggeme754-chm.china.huawei.com (10.3.19.100) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Jun 2019 12:22:25 +0800
Received: from [127.0.0.1] (10.184.212.80) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Jun 2019 12:22:24 +0800
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, <linux@armlinux.org.uk>,
        <peterz@infradead.org>, <mingo@redhat.com>, <will.deacon@arm.com>,
        <arnd@arndb.de>, <longman@redhat.com>,
        <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>
CC:     <dave.dice@oracle.com>, <rahul.x.yadav@oracle.com>,
        <steven.sistare@oracle.com>, <daniel.m.jordan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <cc3eee8c-5212-7af5-c932-897ab8f3f8bf@huawei.com>
Date:   Tue, 11 Jun 2019 12:22:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.212.80]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alex,

On 2019/3/29 23:20, Alex Kogan wrote:
> In CNA, spinning threads are organized in two queues, a main queue for
> threads running on the same node as the current lock holder, and a
> secondary queue for threads running on other nodes. At the unlock time,
> the lock holder scans the main queue looking for a thread running on
> the same node. If found (call it thread T), all threads in the main queue
> between the current lock holder and T are moved to the end of the
> secondary queue, and the lock is passed to T. If such T is not found, the
> lock is passed to the first node in the secondary queue. Finally, if the
> secondary queue is empty, the lock is passed to the next thread in the
> main queue. For more details, see https://arxiv.org/abs/1810.05600.
> 
> Note that this variant of CNA may introduce starvation by continuously
> passing the lock to threads running on the same node. This issue
> will be addressed later in the series.
> 
> Enabling CNA is controlled via a new configuration option
> (NUMA_AWARE_SPINLOCKS), which is enabled by default if NUMA is enabled.
> 
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  arch/x86/Kconfig                      |  14 +++
>  include/asm-generic/qspinlock_types.h |  13 +++
>  kernel/locking/mcs_spinlock.h         |  10 ++
>  kernel/locking/qspinlock.c            |  29 +++++-
>  kernel/locking/qspinlock_cna.h        | 173 ++++++++++++++++++++++++++++++++++
>  5 files changed, 236 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
> 
(SNIP)
> +
> +static __always_inline int get_node_index(struct mcs_spinlock *node)
> +{
> +	return decode_count(node->node_and_count++);
When nesting level is > 4, it won't return a index >= 4 here and the numa node number
is changed by mistake. It will go into a wrong way instead of the following branch.


	/*
	 * 4 nodes are allocated based on the assumption that there will
	 * not be nested NMIs taking spinlocks. That may not be true in
	 * some architectures even though the chance of needing more than
	 * 4 nodes will still be extremely unlikely. When that happens,
	 * we fall back to spinning on the lock directly without using
	 * any MCS node. This is not the most elegant solution, but is
	 * simple enough.
	 */
	if (unlikely(idx >= MAX_NODES)) {
		while (!queued_spin_trylock(lock))
			cpu_relax();
		goto release;
	}

> +}
> +
> +static __always_inline void release_mcs_node(struct mcs_spinlock *node)
> +{
> +	__this_cpu_dec(node->node_and_count);
> +}
> +
> +static __always_inline void cna_init_node(struct mcs_spinlock *node, int cpuid,
> +					  u32 tail)
> +{

Thanks,
Wei

