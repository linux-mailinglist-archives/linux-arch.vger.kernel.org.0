Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8734DD9C18
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 22:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437328AbfJPU6E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 16:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437326AbfJPU6E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 16:58:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 700B38A1C92;
        Wed, 16 Oct 2019 20:58:03 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CBF65C1D6;
        Wed, 16 Oct 2019 20:57:59 +0000 (UTC)
Subject: Re: [PATCH v5 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20191016042903.61081-1-alex.kogan@oracle.com>
 <20191016042903.61081-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6f346e41-c787-b84b-8433-f73f31a7d7ff@redhat.com>
Date:   Wed, 16 Oct 2019 16:57:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191016042903.61081-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Wed, 16 Oct 2019 20:58:03 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/16/19 12:29 AM, Alex Kogan wrote:
> In CNA, spinning threads are organized in two queues, a main queue for
> threads running on the same node as the current lock holder, and a
> secondary queue for threads running on other nodes. After acquiring the
> MCS lock and before acquiring the spinlock, the lock holder scans the
> main queue looking for a thread running on the same node (pre-scan). If
> found (call it thread T), all threads in the main queue between the
> current lock holder and T are moved to the end of the secondary queue.
> If such T is not found, we make another scan of the main queue when
> unlocking the MCS lock (post-scan), starting at the position where
> pre-scan stopped. If both scans fail to find such T, the MCS lock is
> passed to the first thread in the secondary queue. If the secondary queue
> is empty, the lock is passed to the next thread in the main queue.
> For more details, see https://arxiv.org/abs/1810.05600.
>
> Note that this variant of CNA may introduce starvation by continuously
> passing the lock to threads running on the same node. This issue
> will be addressed later in the series.
>
> Enabling CNA is controlled via a new configuration option
> (NUMA_AWARE_SPINLOCKS). By default, the CNA variant is patched in at the
> boot time only if we run on a multi-node machine in native environment and
> the new config is enabled. (For the time being, the patching requires
> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well. However, this should be
> resolved once static_call() is available.) This default behavior can be
> overridden with the new kernel boot command-line option
> "numa_spinlock=on/off" (default is "auto").
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  arch/x86/Kconfig                 |  19 +++
>  arch/x86/include/asm/qspinlock.h |   4 +
>  arch/x86/kernel/alternative.c    |  41 +++++++
>  kernel/locking/mcs_spinlock.h    |   2 +-
>  kernel/locking/qspinlock.c       |  34 +++++-
>  kernel/locking/qspinlock_cna.h   | 258 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 353 insertions(+), 5 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d6e1faa28c58..1d480f190def 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1573,6 +1573,25 @@ config NUMA
>  
>  	  Otherwise, you should say N.
>  
> +config NUMA_AWARE_SPINLOCKS
> +	bool "Numa-aware spinlocks"
> +	depends on NUMA
> +	depends on QUEUED_SPINLOCKS
> +	# For now, we depend on PARAVIRT_SPINLOCKS to make the patching work.
> +	# This is awkward, but hopefully would be resolved once static_call()
> +	# is available.
> +	depends on PARAVIRT_SPINLOCKS
> +	default y
> +	help
> +	  Introduce NUMA (Non Uniform Memory Access) awareness into
> +	  the slow path of spinlocks.
> +
> +	  In this variant of qspinlock, the kernel will try to keep the lock
> +	  on the same node, thus reducing the number of remote cache misses,
> +	  while trading some of the short term fairness for better performance.
> +
> +	  Say N if you want absolute first come first serve fairness.
> +
>  config AMD_NUMA
>  	def_bool y
>  	prompt "Old style AMD Opteron NUMA detection"

I forgot to mention that you should also document the new boot command
line option at Documentation/admin-guide/kernel-parameters.txt.


> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index 444d6fd9a6d8..6fa8fcc5c7af 100644
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
> index 9d3a971ea364..e0e66bd8b251 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -698,6 +698,33 @@ static void __init int3_selftest(void)
>  	unregister_die_notifier(&int3_exception_nb);
>  }
>  
> +#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
> +/*
> + * Constant (boot-param configurable) flag selecting the NUMA-aware variant
> + * of spinlock.  Possible values: -1 (off) / 0 (auto, default) / 1 (on).
> + */
> +static int numa_spinlock_flag;
> +
> +static int __init numa_spinlock_setup(char *str)
> +{
> +	if (!strcmp(str, "auto")) {
> +		numa_spinlock_flag = 0;
> +		return 1;
> +	} else if (!strcmp(str, "on")) {
> +		numa_spinlock_flag = 1;
> +		return 1;
> +	} else if (!strcmp(str, "off")) {
> +		numa_spinlock_flag = -1;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +__setup("numa_spinlock=", numa_spinlock_setup);
> +
> +#endif
> +
>  void __init alternative_instructions(void)
>  {
>  	int3_selftest();
> @@ -738,6 +765,20 @@ void __init alternative_instructions(void)
>  	}
>  #endif
>  
> +#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
> +	/*
> +	 * By default, switch to the NUMA-friendly slow path for
> +	 * spinlocks when we have multiple NUMA nodes in native environment.
> +	 */
> +	if ((numa_spinlock_flag == 1) ||
> +	    (numa_spinlock_flag == 0 && nr_node_ids > 1 &&
> +		    pv_ops.lock.queued_spin_lock_slowpath ==
> +			native_queued_spin_lock_slowpath)) {
> +		pv_ops.lock.queued_spin_lock_slowpath =
> +		    __cna_queued_spin_lock_slowpath;
> +	}
> +#endif
> +
>  	apply_paravirt(__parainstructions, __parainstructions_end);
>  
>  	restart_nmi();
> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index 52d06ec6f525..e40b9538b79f 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -17,7 +17,7 @@
>  
>  struct mcs_spinlock {
>  	struct mcs_spinlock *next;
> -	int locked; /* 1 if lock acquired */
> +	unsigned int locked; /* 1 if lock acquired */
>  	int count;  /* nesting count, see qspinlock.c */
>  };
>  
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index c06d1e8075d9..6d8c4a52e44e 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -11,7 +11,7 @@
>   *          Peter Zijlstra <peterz@infradead.org>
>   */
>  
> -#ifndef _GEN_PV_LOCK_SLOWPATH
> +#if !defined(_GEN_PV_LOCK_SLOWPATH) && !defined(_GEN_CNA_LOCK_SLOWPATH)
>  
>  #include <linux/smp.h>
>  #include <linux/bug.h>
> @@ -70,7 +70,8 @@
>  /*
>   * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
>   * size and four of them will fit nicely in one 64-byte cacheline. For
> - * pvqspinlock, however, we need more space for extra data. To accommodate
> + * pvqspinlock, however, we need more space for extra data. The same also
> + * applies for the NUMA-aware variant of spinlocks (CNA). To accommodate
>   * that, we insert two more long words to pad it up to 32 bytes. IOW, only
>   * two of them can fit in a cacheline in this case. That is OK as it is rare
>   * to have more than 2 levels of slowpath nesting in actual use. We don't
> @@ -79,7 +80,7 @@
>   */
>  struct qnode {
>  	struct mcs_spinlock mcs;
> -#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +#if defined(CONFIG_PARAVIRT_SPINLOCKS) || defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>  	long reserved[2];
>  #endif
>  };
> @@ -103,6 +104,8 @@ struct qnode {
>   * Exactly fits one 64-byte cacheline on a 64-bit architecture.
>   *
>   * PV doubles the storage and uses the second cacheline for PV state.
> + * CNA also doubles the storage and uses the second cacheline for
> + * CNA-specific state.
>   */
>  static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
>  
> @@ -316,7 +319,7 @@ static __always_inline void __mcs_pass_lock(struct mcs_spinlock *node,
>  #define try_clear_tail	__try_clear_tail
>  #define mcs_pass_lock		__mcs_pass_lock
>  
> -#endif /* _GEN_PV_LOCK_SLOWPATH */
> +#endif /* _GEN_PV_LOCK_SLOWPATH && _GEN_CNA_LOCK_SLOWPATH */
>  
>  /**
>   * queued_spin_lock_slowpath - acquire the queued spinlock
> @@ -589,6 +592,29 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  EXPORT_SYMBOL(queued_spin_lock_slowpath);
>  
>  /*
> + * Generate the code for NUMA-aware spinlocks
> + */
> +#if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
> +#define _GEN_CNA_LOCK_SLOWPATH
> +
> +#undef pv_wait_head_or_lock
> +#define pv_wait_head_or_lock		cna_pre_scan
> +
> +#undef try_clear_tail
> +#define try_clear_tail			cna_try_change_tail
> +
> +#undef mcs_pass_lock
> +#define mcs_pass_lock			cna_pass_lock
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
> index 000000000000..4d095f742d31
> --- /dev/null
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -0,0 +1,258 @@
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
> + * threads running on the same NUMA node as the current lock holder, and a
> + * secondary queue for threads running on other nodes. Schematically, it
> + * looks like this:
> + *
> + *    cna_node
> + *   +----------+    +--------+        +--------+
> + *   |mcs:next  | -> |mcs:next| -> ... |mcs:next| -> NULL      [Main queue]
> + *   |mcs:locked| -+ +--------+        +--------+
> + *   +----------+  |
> + *                 +----------------------+
> + *                                        \/
> + *                 +--------+         +--------+
> + *                 |mcs:next| -> ...  |mcs:next|          [Secondary queue]
> + *                 +--------+         +--------+
> + *                     ^                    |
> + *                     +--------------------+
> + *
> + * N.B. locked = 1 if secondary queue is absent. Othewrise, it contains the
> + * encoded pointer to the tail of the secondary queue, which is organized as a
> + * circular list.
> + *
> + * After acquiring the MCS lock and before acquiring the spinlock, the lock
> + * holder scans the main queue looking for a thread running on the same node
> + * (pre-scan). If found (call it thread T), all threads in the main queue
> + * between the current lock holder and T are moved to the end of the secondary
> + * queue.  If such T is not found, we make another scan of the main queue when
> + * unlocking the MCS lock (post-scan), starting at the node where pre-scan
> + * stopped. If both scans fail to find such T, the MCS lock is passed to the
> + * first thread in the secondary queue. If the secondary queue is empty, the
> + * lock is passed to the next thread in the main queue.
> + *
> + * For more details, see https://arxiv.org/abs/1810.05600.
> + *
> + * Authors: Alex Kogan <alex.kogan@oracle.com>
> + *          Dave Dice <dave.dice@oracle.com>
> + */
> +
> +struct cna_node {
> +	struct mcs_spinlock	mcs;
> +	int			numa_node;
> +	u32			encoded_tail;
> +	u32			pre_scan_result; /* 0 or an encoded tail */
> +};
> +
> +static void __init cna_init_nodes_per_cpu(unsigned int cpu)
> +{
> +	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
> +	int numa_node = cpu_to_node(cpu);
> +	int i;
> +
> +	for (i = 0; i < MAX_NODES; i++) {
> +		struct cna_node *cn = (struct cna_node *)grab_mcs_node(base, i);
> +
> +		cn->numa_node = numa_node;
> +		cn->encoded_tail = encode_tail(cpu, i);
> +		/*
> +		 * @encoded_tail has to be larger than 1, so we do not confuse
> +		 * it with other valid values for @locked or @pre_scan_result
> +		 * (0 or 1)
> +		 */
> +		WARN_ON(cn->encoded_tail <= 1);
> +	}
> +}
> +
> +static void __init cna_init_nodes(void)
> +{
> +	unsigned int cpu;
> +
> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> +	/* we store an ecoded tail word in the node's @locked field */
> +	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
> +
> +	for_each_possible_cpu(cpu)
> +		cna_init_nodes_per_cpu(cpu);
> +}
> +early_initcall(cna_init_nodes);
typedef int (*initcall_t)(void);

So cna_init_nodes() should return an integer value. You can just return
0 in this case.

> +
> +static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
> +				       struct mcs_spinlock *node)
> +{
> +	struct mcs_spinlock *head_2nd, *tail_2nd;
> +	u32 new;
> +
> +	/* If the secondary queue is empty, do what MCS does. */
> +	if (node->locked <= 1)
> +		return __try_clear_tail(lock, val, node);
> +
> +	/*
> +	 * Try to update the tail value to the last node in the secondary queue.
> +	 * If successful, pass the lock to the first thread in the secondary
> +	 * queue. Doing those two actions effectively moves all nodes from the
> +	 * secondary queue into the main one.
> +	 */
> +	tail_2nd = decode_tail(node->locked);
> +	head_2nd = tail_2nd->next;
> +	new = ((struct cna_node *)tail_2nd)->encoded_tail + _Q_LOCKED_VAL;
> +
> +	if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
> +		/*
> +		 * Try to reset @next in tail_2nd to NULL, but no need to check
> +		 * the result - if failed, a new successor has updated it.
> +		 */
> +		cmpxchg64_relaxed(&tail_2nd->next, head_2nd, NULL);

Why do you use cmpxchg64*()? That can be problematic when compiling on
32-bit architecture. I think you should just use cmpxhg_relaxed() for
automatic sizing.


> +		arch_mcs_pass_lock(&head_2nd->locked, 1);
> +		return true;
> +	}
> +
> +	return false;
> +}

Cheers,
Longman

