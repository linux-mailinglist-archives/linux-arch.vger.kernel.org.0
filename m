Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82269E5A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 23:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfGOVaG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 17:30:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfGOVaG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jul 2019 17:30:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F60E4E93D;
        Mon, 15 Jul 2019 21:30:05 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4242319C59;
        Mon, 15 Jul 2019 21:30:02 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
Date:   Mon, 15 Jul 2019 17:30:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715192536.104548-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 15 Jul 2019 21:30:05 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/15/19 3:25 PM, Alex Kogan wrote:
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
> (NUMA_AWARE_SPINLOCKS). The CNA variant is patched in
> at the boot time only if we run a multi-node machine, and the new
> config is enabled. For the time being, the patching requires
> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well.
> However, this should be resolved once static_call() is available.
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  arch/x86/Kconfig                 |  18 +++++
>  arch/x86/include/asm/qspinlock.h |   4 +
>  arch/x86/kernel/alternative.c    |  12 +++
>  kernel/locking/mcs_spinlock.h    |   2 +-
>  kernel/locking/qspinlock.c       |  41 +++++++---
>  kernel/locking/qspinlock_cna.h   | 164 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 229 insertions(+), 12 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2bbbd4d1ba31..1d8f80c47687 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1548,6 +1548,24 @@ config NUMA
>  
>  	  Otherwise, you should say N.
>  
> +config NUMA_AWARE_SPINLOCKS
> +	bool "Numa-aware spinlocks"
> +	depends on NUMA
> +	# For now, we depend on PARAVIRT_SPINLOCKS to make the patching work.
> +	# This is awkward, but hopefully would be resolved once static_call()
> +	# is available.
> +	depends on PARAVIRT_SPINLOCKS
> +	default y
> +	help
> +	  Introduce NUMA (Non Uniform Memory Access) awareness into
> +	  the slow path of spinlocks.
> +
> +	  The kernel will try to keep the lock on the same node,
> +	  thus reducing the number of remote cache misses, while
> +	  trading some of the short term fairness for better performance.
> +
> +	  Say N if you want absolute first come first serve fairness.

You should also add a dependency on QUEUED_SPINLOCKS to highlight the
fact that it is a variant of qspinlock. You should also mention that in
the help text.


> +
>  config AMD_NUMA
>  	def_bool y
>  	prompt "Old style AMD Opteron NUMA detection"
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index bd5ac6cc37db..d9b6c34d5eb4 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -27,6 +27,10 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
>  	return val;
>  }
>  
> +#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
> +extern void __cna_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +#endif
> +
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>  extern void __pv_init_lock_hash(void);
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 0d57015114e7..1c25f0505ec0 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -649,6 +649,18 @@ void __init alternative_instructions(void)
>  				(unsigned long)__smp_locks_end);
>  #endif
>  
> +#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
> +	/*
> +	 * If we have multiple NUMA nodes, switch from native
> +	 * to the NUMA-friendly slow path for spin locks.
> +	 */
> +	if (nr_node_ids > 1 && pv_ops.lock.queued_spin_lock_slowpath ==
> +			native_queued_spin_lock_slowpath) {
> +		pv_ops.lock.queued_spin_lock_slowpath =
> +			__cna_queued_spin_lock_slowpath;
> +	}
> +#endif
> +
>  	apply_paravirt(__parainstructions, __parainstructions_end);
>  
>  	restart_nmi();
> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index bc6d3244e1af..36b802babc88 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -17,7 +17,7 @@
>  
>  struct mcs_spinlock {
>  	struct mcs_spinlock *next;
> -	int locked; /* 1 if lock acquired */
> +	u64 locked; /* 1 if lock acquired */
>  	int count;  /* nesting count, see qspinlock.c */
>  };
>  
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 5668466b3006..1ba38f85d0ae 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -20,7 +20,7 @@
>   *          Peter Zijlstra <peterz@infradead.org>
>   */
>  
> -#ifndef _GEN_PV_LOCK_SLOWPATH
> +#if !defined(_GEN_PV_LOCK_SLOWPATH) && !defined(_GEN_CNA_LOCK_SLOWPATH)
>  
>  #include <linux/smp.h>
>  #include <linux/bug.h>
> @@ -77,18 +77,14 @@
>  #define MAX_NODES	4
>  
>  /*
> - * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
> - * size and four of them will fit nicely in one 64-byte cacheline. For
> - * pvqspinlock, however, we need more space for extra data. To accommodate
> - * that, we insert two more long words to pad it up to 32 bytes. IOW, only
> - * two of them can fit in a cacheline in this case. That is OK as it is rare
> - * to have more than 2 levels of slowpath nesting in actual use. We don't
> - * want to penalize pvqspinlocks to optimize for a rare case in native
> - * qspinlocks.
> + * On 64-bit architectures, the mcs_spinlock structure will be 20 bytes in
> + * size. For pvqspinlock or the NUMA-aware variant, however, we need more
> + * space for extra data. To accommodate that, we insert two more long words
> + * to pad it up to 36 bytes.
>   */
The 20 bytes figure is wrong. It is actually 24 bytes for 64-bit as the
mcs_spinlock structure is 8-byte aligned. For better cacheline
alignment, I will like to keep mcs_spinlock to 16 bytes as before.
Instead, you can use encode_tail() to store the CNA node pointer in
"locked". For instance, use (encode_tail() << 1) in locked to
distinguish it from the regular locked=1 value.
>  struct qnode {
>  	struct mcs_spinlock mcs;
> -#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +#if defined(CONFIG_PARAVIRT_SPINLOCKS) || defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>  	long reserved[2];
>  #endif
>  };
> @@ -327,7 +323,7 @@ static __always_inline void __pass_mcs_lock(struct mcs_spinlock *node,
>  #define set_locked_empty_mcs	__set_locked_empty_mcs
>  #define pass_mcs_lock		__pass_mcs_lock
>  
> -#endif /* _GEN_PV_LOCK_SLOWPATH */
> +#endif /* _GEN_PV_LOCK_SLOWPATH && _GEN_CNA_LOCK_SLOWPATH */
>  
>  /**
>   * queued_spin_lock_slowpath - acquire the queued spinlock
> @@ -600,6 +596,29 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  EXPORT_SYMBOL(queued_spin_lock_slowpath);
>  
>  /*
> + * Generate the code for NUMA-aware spin locks
> + */
> +#if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
> +#define _GEN_CNA_LOCK_SLOWPATH
> +
> +#undef pv_init_node
> +#define pv_init_node cna_init_node
> +
> +#undef set_locked_empty_mcs
> +#define set_locked_empty_mcs		cna_set_locked_empty_mcs
> +
> +#undef pass_mcs_lock
> +#define pass_mcs_lock			cna_pass_mcs_lock
> +
> +#undef  queued_spin_lock_slowpath
> +#define queued_spin_lock_slowpath	__cna_queued_spin_lock_slowpath
> +
> +#include "qspinlock_cna.h"
> +#include "qspinlock.c"
> +
> +#endif
> +
> +/*
>   * Generate the paravirt code for queued_spin_unlock_slowpath().
>   */
>  #if !defined(_GEN_PV_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
> new file mode 100644
> index 000000000000..efb9b12b2f9b
> --- /dev/null
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -0,0 +1,164 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _GEN_CNA_LOCK_SLOWPATH
> +#error "do not include this file"
> +#endif
> +
> +#include <linux/topology.h>
> +
> +/*
> + * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
> + *
> + * In CNA, spinning threads are organized in two queues, a main queue for
> + * threads running on the same node as the current lock holder, and a
> + * secondary queue for threads running on other nodes. At the unlock time,
> + * the lock holder scans the main queue looking for a thread running on
> + * the same node. If found (call it thread T), all threads in the main queue
> + * between the current lock holder and T are moved to the end of the
> + * secondary queue, and the lock is passed to T. If such T is not found, the
> + * lock is passed to the first node in the secondary queue. Finally, if the
> + * secondary queue is empty, the lock is passed to the next thread in the
> + * main queue. To avoid starvation of threads in the secondary queue,
> + * those threads are moved back to the head of the main queue
> + * after a certain expected number of intra-node lock hand-offs.
> + *
> + * For more details, see https://arxiv.org/abs/1810.05600.
> + *
> + * Authors: Alex Kogan <alex.kogan@oracle.com>
> + *          Dave Dice <dave.dice@oracle.com>
> + */
> +
> +struct cna_node {
> +	struct	mcs_spinlock mcs;
> +	u32	numa_node;
> +	u32	encoded_tail;
> +	struct	cna_node *tail;    /* points to the secondary queue tail */
> +};
> +
> +#define CNA_NODE(ptr) ((struct cna_node *)(ptr))
> +
> +static void cna_init_node(struct mcs_spinlock *node)
> +{
> +	struct cna_node *cn = CNA_NODE(node);
> +	struct mcs_spinlock *base_node;
> +	int cpuid;
> +
> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> +	/* we store a pointer in the node's @locked field */
> +	BUILD_BUG_ON(sizeof(uintptr_t) > sizeof_field(struct mcs_spinlock, locked));
> +
> +	cpuid = smp_processor_id();
> +	cn->numa_node = cpu_to_node(cpuid);
> +
> +	base_node = this_cpu_ptr(&qnodes[0].mcs);
> +	cn->encoded_tail = encode_tail(cpuid, base_node->count - 1);
> +}


I think you can use an early_init call to initialize the numa_node and
encoded_tail values for all the per-cpu CNA nodes instead of doing it
every time a node is used. If it turns out that pv_qspinlock is used,
the pv_node_init() will properly re-initialize it. The only thing left
to do here is perhaps setting tail to NULL.

-Longman

