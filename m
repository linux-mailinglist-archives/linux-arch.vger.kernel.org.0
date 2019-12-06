Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1141811596E
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 23:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFW5W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 17:57:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42418 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFW5V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Dec 2019 17:57:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6JYpNl084199;
        Fri, 6 Dec 2019 19:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=rJO1uhk/Y/8aZqrAgWAB9bitCcc+AuiUYab3I75DnTY=;
 b=eWQkFdW25BCtdkloqpdv0a7JD4UCtv/HP9+2sEG11MC7yYUE2Lis6F4y40s6c9piG8Lg
 PBd9TVOETB2J39ZNY+yh5mOchwMc8GzLL+ktyrEcJk7ayNn3zNUW6obPSDdmioqt/9qu
 OZUkJ4vx47GhXHjXyiXaKIV5XVyCE4mabRJrwlok1JhwnCjbXbHclvGxRF47p9hGri9o
 VQRCa3pyLBk4oB9j4q9ED+8uINdkoU6RTFDn73KzzzQDXnTW8as8kkLEjH/w3OW8MAZN
 pv9iqp2UIsI8y8K1vlluYFhsCBjwhvwTx3lR9L1iG+FyfCCDKjb6lhQW5iZYXQvhy4CU mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wkh2rx0cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 19:50:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6JdHtp172837;
        Fri, 6 Dec 2019 19:50:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wqcbcqxa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 19:50:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB6JohFI031919;
        Fri, 6 Dec 2019 19:50:43 GMT
Received: from [10.39.224.161] (/10.39.224.161)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Dec 2019 11:50:43 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <ec048549-c522-27af-d638-789c8465a224@redhat.com>
Date:   Fri, 6 Dec 2019 14:50:39 -0500
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <436D6D76-21C0-451B-B74E-5516864925FF@oracle.com>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <ec048549-c522-27af-d638-789c8465a224@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9463 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912060158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9463 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912060158
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks for the feedback. I will take care of that and resubmit.

Regards,
=E2=80=94 Alex

> On Dec 6, 2019, at 12:21 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 11/25/19 4:07 PM, Alex Kogan wrote:
>> In CNA, spinning threads are organized in two queues, a main queue =
for
>> threads running on the same node as the current lock holder, and a
>> secondary queue for threads running on other nodes. After acquiring =
the
>> MCS lock and before acquiring the spinlock, the lock holder scans the
>> main queue looking for a thread running on the same node (pre-scan). =
If
>> found (call it thread T), all threads in the main queue between the
>> current lock holder and T are moved to the end of the secondary =
queue.
>> If such T is not found, we make another scan of the main queue when
>> unlocking the MCS lock (post-scan), starting at the position where
>> pre-scan stopped. If both scans fail to find such T, the MCS lock is
>> passed to the first thread in the secondary queue. If the secondary =
queue
>> is empty, the lock is passed to the next thread in the main queue.
>> For more details, see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DFcJA-hpAHs8MxL3rksMfq_GYsA7RIci=
HEF3AE4ZATOI&s=3DSR-p0LtEzUCrpwWY2ShRIF9lXod5Wc_NkN9zIOVvfxM&e=3D .
>>=20
>> Note that this variant of CNA may introduce starvation by =
continuously
>> passing the lock to threads running on the same node. This issue
>> will be addressed later in the series.
>>=20
>> Enabling CNA is controlled via a new configuration option
>> (NUMA_AWARE_SPINLOCKS). By default, the CNA variant is patched in at =
the
>> boot time only if we run on a multi-node machine in native =
environment and
>> the new config is enabled. (For the time being, the patching requires
>> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well. However, this should =
be
>> resolved once static_call() is available.) This default behavior can =
be
>> overridden with the new kernel boot command-line option
>> "numa_spinlock=3Don/off" (default is "auto").
>>=20
>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> .../admin-guide/kernel-parameters.txt         |  10 +
>> arch/x86/Kconfig                              |  20 ++
>> arch/x86/include/asm/qspinlock.h              |   4 +
>> arch/x86/kernel/alternative.c                 |  43 +++
>> kernel/locking/mcs_spinlock.h                 |   2 +-
>> kernel/locking/qspinlock.c                    |  34 ++-
>> kernel/locking/qspinlock_cna.h                | 264 =
++++++++++++++++++
>> 7 files changed, 372 insertions(+), 5 deletions(-)
>> create mode 100644 kernel/locking/qspinlock_cna.h
>>=20
>   :
>> diff --git a/arch/x86/kernel/alternative.c =
b/arch/x86/kernel/alternative.c
>> index 9d3a971ea364..6a4ccbf4e09c 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -698,6 +698,33 @@ static void __init int3_selftest(void)
>> 	unregister_die_notifier(&int3_exception_nb);
>> }
>>=20
>> +#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>> +/*
>> + * Constant (boot-param configurable) flag selecting the NUMA-aware =
variant
>> + * of spinlock.  Possible values: -1 (off) / 0 (auto, default) / 1 =
(on).
>> + */
>> +static int numa_spinlock_flag;
>> +
>> +static int __init numa_spinlock_setup(char *str)
>> +{
>> +	if (!strcmp(str, "auto")) {
>> +		numa_spinlock_flag =3D 0;
>> +		return 1;
>> +	} else if (!strcmp(str, "on")) {
>> +		numa_spinlock_flag =3D 1;
>> +		return 1;
>> +	} else if (!strcmp(str, "off")) {
>> +		numa_spinlock_flag =3D -1;
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +__setup("numa_spinlock=3D", numa_spinlock_setup);
>> +
>> +#endif
>> +
>=20
> This __init function should be in qspinlock_cna.h. We generally like =
to
> put as much related code into as few places as possible instead of
> spreading them around in different places.
>=20
>> void __init alternative_instructions(void)
>> {
>> 	int3_selftest();
>> @@ -738,6 +765,22 @@ void __init alternative_instructions(void)
>> 	}
>> #endif
>>=20
>> +#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>> +	/*
>> +	 * By default, switch to the NUMA-friendly slow path for
>> +	 * spinlocks when we have multiple NUMA nodes in native =
environment.
>> +	 */
>> +	if ((numa_spinlock_flag =3D=3D 1) ||
>> +	    (numa_spinlock_flag =3D=3D 0 && nr_node_ids > 1 &&
>> +		    pv_ops.lock.queued_spin_lock_slowpath =3D=3D
>> +			native_queued_spin_lock_slowpath)) {
>> +		pv_ops.lock.queued_spin_lock_slowpath =3D
>> +		    __cna_queued_spin_lock_slowpath;
>> +
>> +		pr_info("Enabling CNA spinlock\n");
>> +	}
>> +#endif
>> +
>> 	apply_paravirt(__parainstructions, __parainstructions_end);
>=20
> Encapsulate the logic into another __init function in qspinlock_cna.h
> and just make a function call here. You can declare the function in
> arch/x86/include/asm/qspinlock.h.
>=20
>=20
>>=20
>> 	restart_nmi();
>> diff --git a/kernel/locking/mcs_spinlock.h =
b/kernel/locking/mcs_spinlock.h
>> index 52d06ec6f525..e40b9538b79f 100644
>> --- a/kernel/locking/mcs_spinlock.h
>> +++ b/kernel/locking/mcs_spinlock.h
>> @@ -17,7 +17,7 @@
>>=20
>> struct mcs_spinlock {
>> 	struct mcs_spinlock *next;
>> -	int locked; /* 1 if lock acquired */
>> +	unsigned int locked; /* 1 if lock acquired */
>> 	int count;  /* nesting count, see qspinlock.c */
>> };
>>=20
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index c06d1e8075d9..6d8c4a52e44e 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -11,7 +11,7 @@
>>  *          Peter Zijlstra <peterz@infradead.org>
>>  */
>>=20
>> -#ifndef _GEN_PV_LOCK_SLOWPATH
>> +#if !defined(_GEN_PV_LOCK_SLOWPATH) && =
!defined(_GEN_CNA_LOCK_SLOWPATH)
>>=20
>> #include <linux/smp.h>
>> #include <linux/bug.h>
>> @@ -70,7 +70,8 @@
>> /*
>>  * On 64-bit architectures, the mcs_spinlock structure will be 16 =
bytes in
>>  * size and four of them will fit nicely in one 64-byte cacheline. =
For
>> - * pvqspinlock, however, we need more space for extra data. To =
accommodate
>> + * pvqspinlock, however, we need more space for extra data. The same =
also
>> + * applies for the NUMA-aware variant of spinlocks (CNA). To =
accommodate
>>  * that, we insert two more long words to pad it up to 32 bytes. IOW, =
only
>>  * two of them can fit in a cacheline in this case. That is OK as it =
is rare
>>  * to have more than 2 levels of slowpath nesting in actual use. We =
don't
>> @@ -79,7 +80,7 @@
>>  */
>> struct qnode {
>> 	struct mcs_spinlock mcs;
>> -#ifdef CONFIG_PARAVIRT_SPINLOCKS
>> +#if defined(CONFIG_PARAVIRT_SPINLOCKS) || =
defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>> 	long reserved[2];
>> #endif
>> };
>> @@ -103,6 +104,8 @@ struct qnode {
>>  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
>>  *
>>  * PV doubles the storage and uses the second cacheline for PV state.
>> + * CNA also doubles the storage and uses the second cacheline for
>> + * CNA-specific state.
>>  */
>> static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
>>=20
>> @@ -316,7 +319,7 @@ static __always_inline void =
__mcs_pass_lock(struct mcs_spinlock *node,
>> #define try_clear_tail	__try_clear_tail
>> #define mcs_pass_lock		__mcs_pass_lock
>>=20
>> -#endif /* _GEN_PV_LOCK_SLOWPATH */
>> +#endif /* _GEN_PV_LOCK_SLOWPATH && _GEN_CNA_LOCK_SLOWPATH */
>>=20
>> /**
>>  * queued_spin_lock_slowpath - acquire the queued spinlock
>> @@ -588,6 +591,29 @@ void queued_spin_lock_slowpath(struct qspinlock =
*lock, u32 val)
>> }
>> EXPORT_SYMBOL(queued_spin_lock_slowpath);
>>=20
>> +/*
>> + * Generate the code for NUMA-aware spinlocks
>> + */
>> +#if !defined(_GEN_CNA_LOCK_SLOWPATH) && =
defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>> +#define _GEN_CNA_LOCK_SLOWPATH
>> +
>> +#undef pv_wait_head_or_lock
>> +#define pv_wait_head_or_lock		cna_pre_scan
>> +
>> +#undef try_clear_tail
>> +#define try_clear_tail			cna_try_change_tail
>> +
>> +#undef mcs_pass_lock
>> +#define mcs_pass_lock			cna_pass_lock
>> +
>> +#undef  queued_spin_lock_slowpath
>> +#define queued_spin_lock_slowpath	__cna_queued_spin_lock_slowpath
>> +
>> +#include "qspinlock_cna.h"
>> +#include "qspinlock.c"
>> +
>> +#endif
>> +
>> /*
>>  * Generate the paravirt code for queued_spin_unlock_slowpath().
>>  */
>> diff --git a/kernel/locking/qspinlock_cna.h =
b/kernel/locking/qspinlock_cna.h
>> new file mode 100644
>> index 000000000000..a638336f9560
>> --- /dev/null
>> +++ b/kernel/locking/qspinlock_cna.h
>> @@ -0,0 +1,264 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _GEN_CNA_LOCK_SLOWPATH
>> +#error "do not include this file"
>> +#endif
>> +
>> +#include <linux/topology.h>
>> +
>> +/*
>> + * Implement a NUMA-aware version of MCS (aka CNA, or compact =
NUMA-aware lock).
>> + *
>> + * In CNA, spinning threads are organized in two queues, a main =
queue for
>> + * threads running on the same NUMA node as the current lock holder, =
and a
>> + * secondary queue for threads running on other nodes. =
Schematically, it
>> + * looks like this:
>> + *
>> + *    cna_node
>> + *   +----------+    +--------+        +--------+
>> + *   |mcs:next  | -> |mcs:next| -> ... |mcs:next| -> NULL      [Main =
queue]
>> + *   |mcs:locked| -+ +--------+        +--------+
>> + *   +----------+  |
>> + *                 +----------------------+
>> + *                                        \/
>> + *                 +--------+         +--------+
>> + *                 |mcs:next| -> ...  |mcs:next|          [Secondary =
queue]
>> + *                 +--------+         +--------+
>> + *                     ^                    |
>> + *                     +--------------------+
>> + *
>> + * N.B. locked =3D 1 if secondary queue is absent. Othewrise, it =
contains the
>> + * encoded pointer to the tail of the secondary queue, which is =
organized as a
>> + * circular list.
>> + *
>> + * After acquiring the MCS lock and before acquiring the spinlock, =
the lock
>> + * holder scans the main queue looking for a thread running on the =
same node
>> + * (pre-scan). If found (call it thread T), all threads in the main =
queue
>> + * between the current lock holder and T are moved to the end of the =
secondary
>> + * queue.  If such T is not found, we make another scan of the main =
queue when
>> + * unlocking the MCS lock (post-scan), starting at the node where =
pre-scan
>> + * stopped. If both scans fail to find such T, the MCS lock is =
passed to the
>> + * first thread in the secondary queue. If the secondary queue is =
empty, the
>> + * lock is passed to the next thread in the main queue.
>> + *
>> + * For more details, see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DFcJA-hpAHs8MxL3rksMfq_GYsA7RIci=
HEF3AE4ZATOI&s=3DSR-p0LtEzUCrpwWY2ShRIF9lXod5Wc_NkN9zIOVvfxM&e=3D .
>> + *
>> + * Authors: Alex Kogan <alex.kogan@oracle.com>
>> + *          Dave Dice <dave.dice@oracle.com>
>> + */
>> +
>> +struct cna_node {
>> +	struct mcs_spinlock	mcs;
>> +	int			numa_node;
>> +	u32			encoded_tail;
>> +	u32			pre_scan_result; /* 0 or encoded tail */
>> +};
>> +
>> +static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>> +{
>> +	struct mcs_spinlock *base =3D per_cpu_ptr(&qnodes[0].mcs, cpu);
>> +	int numa_node =3D cpu_to_node(cpu);
>> +	int i;
>> +
>> +	for (i =3D 0; i < MAX_NODES; i++) {
>> +		struct cna_node *cn =3D (struct cna_node =
*)grab_mcs_node(base, i);
>> +
>> +		cn->numa_node =3D numa_node;
>> +		cn->encoded_tail =3D encode_tail(cpu, i);
>> +		/*
>> +		 * @encoded_tail has to be larger than 1, so we do not =
confuse
>> +		 * it with other valid values for @locked or =
@pre_scan_result
>> +		 * (0 or 1)
>> +		 */
>> +		WARN_ON(cn->encoded_tail <=3D 1);
>> +	}
>> +}
>> +
>> +static int __init cna_init_nodes(void)
>> +{
>> +	unsigned int cpu;
>> +
>> +	/*
>> +	 * this will break on 32bit architectures, so we restrict
>> +	 * the use of CNA to 64bit only (see arch/x86/Kconfig)
>> +	 */
>> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
>> +	/* we store an ecoded tail word in the node's @locked field */
>> +	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
>> +
>> +	for_each_possible_cpu(cpu)
>> +		cna_init_nodes_per_cpu(cpu);
>> +
>> +	return 0;
>> +}
>> +early_initcall(cna_init_nodes);
>> +
>=20
> Include a comment here saying that the cna_try_change_tail() function =
is
> only called when the primary queue is empty. That will make the code
> easier to read.
>=20
>=20
>> +static inline bool cna_try_change_tail(struct qspinlock *lock, u32 =
val,
>> +				       struct mcs_spinlock *node)
>> +{
>> +	struct mcs_spinlock *head_2nd, *tail_2nd;
>> +	u32 new;
>> +
>> +	/* If the secondary queue is empty, do what MCS does. */
>> +	if (node->locked <=3D 1)
>> +		return __try_clear_tail(lock, val, node);
>> +
>> +	/*
>> +	 * Try to update the tail value to the last node in the =
secondary queue.
>> +	 * If successful, pass the lock to the first thread in the =
secondary
>> +	 * queue. Doing those two actions effectively moves all nodes =
from the
>> +	 * secondary queue into the main one.
>> +	 */
>> +	tail_2nd =3D decode_tail(node->locked);
>> +	head_2nd =3D tail_2nd->next;
>> +	new =3D ((struct cna_node *)tail_2nd)->encoded_tail + =
_Q_LOCKED_VAL;
>> +
>> +	if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
>> +		/*
>> +		 * Try to reset @next in tail_2nd to NULL, but no need =
to check
>> +		 * the result - if failed, a new successor has updated =
it.
>> +		 */
>> +		cmpxchg_relaxed(&tail_2nd->next, head_2nd, NULL);
>> +		arch_mcs_pass_lock(&head_2nd->locked, 1);
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
> Cheers,
> Longman
>=20

