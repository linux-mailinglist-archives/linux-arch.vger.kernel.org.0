Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85346115652
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLFRVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 12:21:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32513 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbfLFRVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Dec 2019 12:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575652875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngzQkuCxfzW+KuASLQ3K3cpSgR7pHALvOMZfXSQgRYg=;
        b=gqmKlAQfcp07YPUVYoOXVn4su3RXAlx0dey3YI2iY0wEU/bbfhyiXHeMIYaNoMudzZZKAi
        UejssN81BG21DRKxs/wxciyJ9TMnWKIvnbY+XIaeGJAX7OVfKx4qbE+8QZBs5EVVmUPm+9
        2/WrMkHVqQoJF2HEvwjF9Q+BcqB72e0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-AVosUFhhP_ul14nnJm9Z9w-1; Fri, 06 Dec 2019 12:21:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 619E3DB62;
        Fri,  6 Dec 2019 17:21:09 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-189.rdu2.redhat.com [10.10.122.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15AD85D6BB;
        Fri,  6 Dec 2019 17:21:05 +0000 (UTC)
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ec048549-c522-27af-d638-789c8465a224@redhat.com>
Date:   Fri, 6 Dec 2019 12:21:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191125210709.10293-4-alex.kogan@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: AVosUFhhP_ul14nnJm9Z9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/25/19 4:07 PM, Alex Kogan wrote:
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
> boot time only if we run on a multi-node machine in native environment an=
d
> the new config is enabled. (For the time being, the patching requires
> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well. However, this should be
> resolved once static_call() is available.) This default behavior can be
> overridden with the new kernel boot command-line option
> "numa_spinlock=3Don/off" (default is "auto").
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  10 +
>  arch/x86/Kconfig                              |  20 ++
>  arch/x86/include/asm/qspinlock.h              |   4 +
>  arch/x86/kernel/alternative.c                 |  43 +++
>  kernel/locking/mcs_spinlock.h                 |   2 +-
>  kernel/locking/qspinlock.c                    |  34 ++-
>  kernel/locking/qspinlock_cna.h                | 264 ++++++++++++++++++
>  7 files changed, 372 insertions(+), 5 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
>
=C2=A0 :
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
> index 9d3a971ea364..6a4ccbf4e09c 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -698,6 +698,33 @@ static void __init int3_selftest(void)
>  =09unregister_die_notifier(&int3_exception_nb);
>  }
> =20
> +#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
> +/*
> + * Constant (boot-param configurable) flag selecting the NUMA-aware vari=
ant
> + * of spinlock.  Possible values: -1 (off) / 0 (auto, default) / 1 (on).
> + */
> +static int numa_spinlock_flag;
> +
> +static int __init numa_spinlock_setup(char *str)
> +{
> +=09if (!strcmp(str, "auto")) {
> +=09=09numa_spinlock_flag =3D 0;
> +=09=09return 1;
> +=09} else if (!strcmp(str, "on")) {
> +=09=09numa_spinlock_flag =3D 1;
> +=09=09return 1;
> +=09} else if (!strcmp(str, "off")) {
> +=09=09numa_spinlock_flag =3D -1;
> +=09=09return 1;
> +=09}
> +
> +=09return 0;
> +}
> +
> +__setup("numa_spinlock=3D", numa_spinlock_setup);
> +
> +#endif
> +

This __init function should be in qspinlock_cna.h. We generally like to
put as much related code into as few places as possible instead of
spreading them around in different places.

>  void __init alternative_instructions(void)
>  {
>  =09int3_selftest();
> @@ -738,6 +765,22 @@ void __init alternative_instructions(void)
>  =09}
>  #endif
> =20
> +#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
> +=09/*
> +=09 * By default, switch to the NUMA-friendly slow path for
> +=09 * spinlocks when we have multiple NUMA nodes in native environment.
> +=09 */
> +=09if ((numa_spinlock_flag =3D=3D 1) ||
> +=09    (numa_spinlock_flag =3D=3D 0 && nr_node_ids > 1 &&
> +=09=09    pv_ops.lock.queued_spin_lock_slowpath =3D=3D
> +=09=09=09native_queued_spin_lock_slowpath)) {
> +=09=09pv_ops.lock.queued_spin_lock_slowpath =3D
> +=09=09    __cna_queued_spin_lock_slowpath;
> +
> +=09=09pr_info("Enabling CNA spinlock\n");
> +=09}
> +#endif
> +
>  =09apply_paravirt(__parainstructions, __parainstructions_end);

Encapsulate the logic into another __init function in qspinlock_cna.h
and just make a function call here. You can declare the function in
arch/x86/include/asm/qspinlock.h.


> =20
>  =09restart_nmi();
> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.=
h
> index 52d06ec6f525..e40b9538b79f 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -17,7 +17,7 @@
> =20
>  struct mcs_spinlock {
>  =09struct mcs_spinlock *next;
> -=09int locked; /* 1 if lock acquired */
> +=09unsigned int locked; /* 1 if lock acquired */
>  =09int count;  /* nesting count, see qspinlock.c */
>  };
> =20
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index c06d1e8075d9..6d8c4a52e44e 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -11,7 +11,7 @@
>   *          Peter Zijlstra <peterz@infradead.org>
>   */
> =20
> -#ifndef _GEN_PV_LOCK_SLOWPATH
> +#if !defined(_GEN_PV_LOCK_SLOWPATH) && !defined(_GEN_CNA_LOCK_SLOWPATH)
> =20
>  #include <linux/smp.h>
>  #include <linux/bug.h>
> @@ -70,7 +70,8 @@
>  /*
>   * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes =
in
>   * size and four of them will fit nicely in one 64-byte cacheline. For
> - * pvqspinlock, however, we need more space for extra data. To accommoda=
te
> + * pvqspinlock, however, we need more space for extra data. The same als=
o
> + * applies for the NUMA-aware variant of spinlocks (CNA). To accommodate
>   * that, we insert two more long words to pad it up to 32 bytes. IOW, on=
ly
>   * two of them can fit in a cacheline in this case. That is OK as it is =
rare
>   * to have more than 2 levels of slowpath nesting in actual use. We don'=
t
> @@ -79,7 +80,7 @@
>   */
>  struct qnode {
>  =09struct mcs_spinlock mcs;
> -#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +#if defined(CONFIG_PARAVIRT_SPINLOCKS) || defined(CONFIG_NUMA_AWARE_SPIN=
LOCKS)
>  =09long reserved[2];
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
> =20
> @@ -316,7 +319,7 @@ static __always_inline void __mcs_pass_lock(struct mc=
s_spinlock *node,
>  #define try_clear_tail=09__try_clear_tail
>  #define mcs_pass_lock=09=09__mcs_pass_lock
> =20
> -#endif /* _GEN_PV_LOCK_SLOWPATH */
> +#endif /* _GEN_PV_LOCK_SLOWPATH && _GEN_CNA_LOCK_SLOWPATH */
> =20
>  /**
>   * queued_spin_lock_slowpath - acquire the queued spinlock
> @@ -588,6 +591,29 @@ void queued_spin_lock_slowpath(struct qspinlock *loc=
k, u32 val)
>  }
>  EXPORT_SYMBOL(queued_spin_lock_slowpath);
> =20
> +/*
> + * Generate the code for NUMA-aware spinlocks
> + */
> +#if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLO=
CKS)
> +#define _GEN_CNA_LOCK_SLOWPATH
> +
> +#undef pv_wait_head_or_lock
> +#define pv_wait_head_or_lock=09=09cna_pre_scan
> +
> +#undef try_clear_tail
> +#define try_clear_tail=09=09=09cna_try_change_tail
> +
> +#undef mcs_pass_lock
> +#define mcs_pass_lock=09=09=09cna_pass_lock
> +
> +#undef  queued_spin_lock_slowpath
> +#define queued_spin_lock_slowpath=09__cna_queued_spin_lock_slowpath
> +
> +#include "qspinlock_cna.h"
> +#include "qspinlock.c"
> +
> +#endif
> +
>  /*
>   * Generate the paravirt code for queued_spin_unlock_slowpath().
>   */
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cn=
a.h
> new file mode 100644
> index 000000000000..a638336f9560
> --- /dev/null
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -0,0 +1,264 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _GEN_CNA_LOCK_SLOWPATH
> +#error "do not include this file"
> +#endif
> +
> +#include <linux/topology.h>
> +
> +/*
> + * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware=
 lock).
> + *
> + * In CNA, spinning threads are organized in two queues, a main queue fo=
r
> + * threads running on the same NUMA node as the current lock holder, and=
 a
> + * secondary queue for threads running on other nodes. Schematically, it
> + * looks like this:
> + *
> + *    cna_node
> + *   +----------+    +--------+        +--------+
> + *   |mcs:next  | -> |mcs:next| -> ... |mcs:next| -> NULL      [Main que=
ue]
> + *   |mcs:locked| -+ +--------+        +--------+
> + *   +----------+  |
> + *                 +----------------------+
> + *                                        \/
> + *                 +--------+         +--------+
> + *                 |mcs:next| -> ...  |mcs:next|          [Secondary que=
ue]
> + *                 +--------+         +--------+
> + *                     ^                    |
> + *                     +--------------------+
> + *
> + * N.B. locked =3D 1 if secondary queue is absent. Othewrise, it contain=
s the
> + * encoded pointer to the tail of the secondary queue, which is organize=
d as a
> + * circular list.
> + *
> + * After acquiring the MCS lock and before acquiring the spinlock, the l=
ock
> + * holder scans the main queue looking for a thread running on the same =
node
> + * (pre-scan). If found (call it thread T), all threads in the main queu=
e
> + * between the current lock holder and T are moved to the end of the sec=
ondary
> + * queue.  If such T is not found, we make another scan of the main queu=
e when
> + * unlocking the MCS lock (post-scan), starting at the node where pre-sc=
an
> + * stopped. If both scans fail to find such T, the MCS lock is passed to=
 the
> + * first thread in the secondary queue. If the secondary queue is empty,=
 the
> + * lock is passed to the next thread in the main queue.
> + *
> + * For more details, see https://arxiv.org/abs/1810.05600.
> + *
> + * Authors: Alex Kogan <alex.kogan@oracle.com>
> + *          Dave Dice <dave.dice@oracle.com>
> + */
> +
> +struct cna_node {
> +=09struct mcs_spinlock=09mcs;
> +=09int=09=09=09numa_node;
> +=09u32=09=09=09encoded_tail;
> +=09u32=09=09=09pre_scan_result; /* 0 or encoded tail */
> +};
> +
> +static void __init cna_init_nodes_per_cpu(unsigned int cpu)
> +{
> +=09struct mcs_spinlock *base =3D per_cpu_ptr(&qnodes[0].mcs, cpu);
> +=09int numa_node =3D cpu_to_node(cpu);
> +=09int i;
> +
> +=09for (i =3D 0; i < MAX_NODES; i++) {
> +=09=09struct cna_node *cn =3D (struct cna_node *)grab_mcs_node(base, i);
> +
> +=09=09cn->numa_node =3D numa_node;
> +=09=09cn->encoded_tail =3D encode_tail(cpu, i);
> +=09=09/*
> +=09=09 * @encoded_tail has to be larger than 1, so we do not confuse
> +=09=09 * it with other valid values for @locked or @pre_scan_result
> +=09=09 * (0 or 1)
> +=09=09 */
> +=09=09WARN_ON(cn->encoded_tail <=3D 1);
> +=09}
> +}
> +
> +static int __init cna_init_nodes(void)
> +{
> +=09unsigned int cpu;
> +
> +=09/*
> +=09 * this will break on 32bit architectures, so we restrict
> +=09 * the use of CNA to 64bit only (see arch/x86/Kconfig)
> +=09 */
> +=09BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> +=09/* we store an ecoded tail word in the node's @locked field */
> +=09BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
> +
> +=09for_each_possible_cpu(cpu)
> +=09=09cna_init_nodes_per_cpu(cpu);
> +
> +=09return 0;
> +}
> +early_initcall(cna_init_nodes);
> +

Include a comment here saying that the cna_try_change_tail() function is
only called when the primary queue is empty. That will make the code
easier to read.


> +static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
> +=09=09=09=09       struct mcs_spinlock *node)
> +{
> +=09struct mcs_spinlock *head_2nd, *tail_2nd;
> +=09u32 new;
> +
> +=09/* If the secondary queue is empty, do what MCS does. */
> +=09if (node->locked <=3D 1)
> +=09=09return __try_clear_tail(lock, val, node);
> +
> +=09/*
> +=09 * Try to update the tail value to the last node in the secondary que=
ue.
> +=09 * If successful, pass the lock to the first thread in the secondary
> +=09 * queue. Doing those two actions effectively moves all nodes from th=
e
> +=09 * secondary queue into the main one.
> +=09 */
> +=09tail_2nd =3D decode_tail(node->locked);
> +=09head_2nd =3D tail_2nd->next;
> +=09new =3D ((struct cna_node *)tail_2nd)->encoded_tail + _Q_LOCKED_VAL;
> +
> +=09if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
> +=09=09/*
> +=09=09 * Try to reset @next in tail_2nd to NULL, but no need to check
> +=09=09 * the result - if failed, a new successor has updated it.
> +=09=09 */
> +=09=09cmpxchg_relaxed(&tail_2nd->next, head_2nd, NULL);
> +=09=09arch_mcs_pass_lock(&head_2nd->locked, 1);
> +=09=09return true;
> +=09}
> +
> +=09return false;
> +}
Cheers,
Longman

