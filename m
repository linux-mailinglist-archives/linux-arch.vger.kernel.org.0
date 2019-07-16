Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96236AA94
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGPO23 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 10:28:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53238 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPO23 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 10:28:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GENixN109513;
        Tue, 16 Jul 2019 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=5VbzalODeEFGThUIr8fco7HzeuBP4OeNfdiuU3AJT8c=;
 b=JNhqHddt/tYJI7/99hkfrMPzGeumfY799+ObnVDjBPwaFZivgmAadNZfyuiXDYl1qD3C
 RS48RCJofimcUldsGQzRE0TTM0yoEXL5xsAN00M0pcBBlElAR3SEUL30OqUVaut0omuG
 ve9UaM380TKBRTS24f2nxuUBIfmaYhzUA32Mo4eA6/FQdqnI3I92mI6C6x9AuynzYTvz
 he+nNFmW3/d0Vbo/R0i6Y0QPUAWtqRXxYp2KB4deEqfBUKdt959IvUZY6tf+EF+FMi32
 BDjtV40SZ6PNNgV2NoBgXDUwwR90mmb20NSsIgqt9RMiL5yLPJwonDf8k5EXysG3Oucp xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xqvtjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:27:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GENAwa141716;
        Tue, 16 Jul 2019 14:27:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tq6mmx1c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:27:11 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GEQxbH000468;
        Tue, 16 Jul 2019 14:26:59 GMT
Received: from [10.39.235.122] (/10.39.235.122)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 14:26:58 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
Date:   Tue, 16 Jul 2019 10:26:56 -0400
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <32DD898E-0F5E-4A63-9795-F78411B77A98@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160177
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Jul 15, 2019, at 5:30 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 7/15/19 3:25 PM, Alex Kogan wrote:
>> In CNA, spinning threads are organized in two queues, a main queue =
for
>> threads running on the same node as the current lock holder, and a
>> secondary queue for threads running on other nodes. At the unlock =
time,
>> the lock holder scans the main queue looking for a thread running on
>> the same node. If found (call it thread T), all threads in the main =
queue
>> between the current lock holder and T are moved to the end of the
>> secondary queue, and the lock is passed to T. If such T is not found, =
the
>> lock is passed to the first node in the secondary queue. Finally, if =
the
>> secondary queue is empty, the lock is passed to the next thread in =
the
>> main queue. For more details, see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwICaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DNH4Xld7c5GQcD5N1oCMpapcK4gtC1Lg=
6WNc__6B-qlo&s=3DDBj9a52iqQ8TW5raX7fVjytlskLrPc9gseyBQCM0GS0&e=3D .
>>=20
>> Note that this variant of CNA may introduce starvation by =
continuously
>> passing the lock to threads running on the same node. This issue
>> will be addressed later in the series.
>>=20
>> Enabling CNA is controlled via a new configuration option
>> (NUMA_AWARE_SPINLOCKS). The CNA variant is patched in
>> at the boot time only if we run a multi-node machine, and the new
>> config is enabled. For the time being, the patching requires
>> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well.
>> However, this should be resolved once static_call() is available.
>>=20
>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> arch/x86/Kconfig                 |  18 +++++
>> arch/x86/include/asm/qspinlock.h |   4 +
>> arch/x86/kernel/alternative.c    |  12 +++
>> kernel/locking/mcs_spinlock.h    |   2 +-
>> kernel/locking/qspinlock.c       |  41 +++++++---
>> kernel/locking/qspinlock_cna.h   | 164 =
+++++++++++++++++++++++++++++++++++++++
>> 6 files changed, 229 insertions(+), 12 deletions(-)
>> create mode 100644 kernel/locking/qspinlock_cna.h
>>=20
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 2bbbd4d1ba31..1d8f80c47687 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1548,6 +1548,24 @@ config NUMA
>>=20
>> 	  Otherwise, you should say N.
>>=20
>> +config NUMA_AWARE_SPINLOCKS
>> +	bool "Numa-aware spinlocks"
>> +	depends on NUMA
>> +	# For now, we depend on PARAVIRT_SPINLOCKS to make the patching =
work.
>> +	# This is awkward, but hopefully would be resolved once =
static_call()
>> +	# is available.
>> +	depends on PARAVIRT_SPINLOCKS
>> +	default y
>> +	help
>> +	  Introduce NUMA (Non Uniform Memory Access) awareness into
>> +	  the slow path of spinlocks.
>> +
>> +	  The kernel will try to keep the lock on the same node,
>> +	  thus reducing the number of remote cache misses, while
>> +	  trading some of the short term fairness for better =
performance.
>> +
>> +	  Say N if you want absolute first come first serve fairness.
>=20
> You should also add a dependency on QUEUED_SPINLOCKS to highlight the
> fact that it is a variant of qspinlock. You should also mention that =
in
> the help text.
Will do.

>=20
>=20
>> +
>> config AMD_NUMA
>> 	def_bool y
>> 	prompt "Old style AMD Opteron NUMA detection"
>> diff --git a/arch/x86/include/asm/qspinlock.h =
b/arch/x86/include/asm/qspinlock.h
>> index bd5ac6cc37db..d9b6c34d5eb4 100644
>> --- a/arch/x86/include/asm/qspinlock.h
>> +++ b/arch/x86/include/asm/qspinlock.h
>> @@ -27,6 +27,10 @@ static __always_inline u32 =
queued_fetch_set_pending_acquire(struct qspinlock *lo
>> 	return val;
>> }
>>=20
>> +#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
>> +extern void __cna_queued_spin_lock_slowpath(struct qspinlock *lock, =
u32 val);
>> +#endif
>> +
>> #ifdef CONFIG_PARAVIRT_SPINLOCKS
>> extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, =
u32 val);
>> extern void __pv_init_lock_hash(void);
>> diff --git a/arch/x86/kernel/alternative.c =
b/arch/x86/kernel/alternative.c
>> index 0d57015114e7..1c25f0505ec0 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -649,6 +649,18 @@ void __init alternative_instructions(void)
>> 				(unsigned long)__smp_locks_end);
>> #endif
>>=20
>> +#if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>> +	/*
>> +	 * If we have multiple NUMA nodes, switch from native
>> +	 * to the NUMA-friendly slow path for spin locks.
>> +	 */
>> +	if (nr_node_ids > 1 && pv_ops.lock.queued_spin_lock_slowpath =3D=3D=

>> +			native_queued_spin_lock_slowpath) {
>> +		pv_ops.lock.queued_spin_lock_slowpath =3D
>> +			__cna_queued_spin_lock_slowpath;
>> +	}
>> +#endif
>> +
>> 	apply_paravirt(__parainstructions, __parainstructions_end);
>>=20
>> 	restart_nmi();
>> diff --git a/kernel/locking/mcs_spinlock.h =
b/kernel/locking/mcs_spinlock.h
>> index bc6d3244e1af..36b802babc88 100644
>> --- a/kernel/locking/mcs_spinlock.h
>> +++ b/kernel/locking/mcs_spinlock.h
>> @@ -17,7 +17,7 @@
>>=20
>> struct mcs_spinlock {
>> 	struct mcs_spinlock *next;
>> -	int locked; /* 1 if lock acquired */
>> +	u64 locked; /* 1 if lock acquired */
>> 	int count;  /* nesting count, see qspinlock.c */
>> };
>>=20
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index 5668466b3006..1ba38f85d0ae 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -20,7 +20,7 @@
>>  *          Peter Zijlstra <peterz@infradead.org>
>>  */
>>=20
>> -#ifndef _GEN_PV_LOCK_SLOWPATH
>> +#if !defined(_GEN_PV_LOCK_SLOWPATH) && =
!defined(_GEN_CNA_LOCK_SLOWPATH)
>>=20
>> #include <linux/smp.h>
>> #include <linux/bug.h>
>> @@ -77,18 +77,14 @@
>> #define MAX_NODES	4
>>=20
>> /*
>> - * On 64-bit architectures, the mcs_spinlock structure will be 16 =
bytes in
>> - * size and four of them will fit nicely in one 64-byte cacheline. =
For
>> - * pvqspinlock, however, we need more space for extra data. To =
accommodate
>> - * that, we insert two more long words to pad it up to 32 bytes. =
IOW, only
>> - * two of them can fit in a cacheline in this case. That is OK as it =
is rare
>> - * to have more than 2 levels of slowpath nesting in actual use. We =
don't
>> - * want to penalize pvqspinlocks to optimize for a rare case in =
native
>> - * qspinlocks.
>> + * On 64-bit architectures, the mcs_spinlock structure will be 20 =
bytes in
>> + * size. For pvqspinlock or the NUMA-aware variant, however, we need =
more
>> + * space for extra data. To accommodate that, we insert two more =
long words
>> + * to pad it up to 36 bytes.
>>  */
> The 20 bytes figure is wrong. It is actually 24 bytes for 64-bit as =
the
> mcs_spinlock structure is 8-byte aligned. For better cacheline
> alignment, I will like to keep mcs_spinlock to 16 bytes as before.
> Instead, you can use encode_tail() to store the CNA node pointer in
> "locked". For instance, use (encode_tail() << 1) in locked to
> distinguish it from the regular locked=3D1 value.
I think this can work.
decode_tail() will get the actual node pointer from the encoded value.
And that would keep the size of mcs_spinlock intact.
Good idea, thanks!

BTW, maybe better change those function names to encode_node() / =
decode_node() then?

>> struct qnode {
>> 	struct mcs_spinlock mcs;
>> -#ifdef CONFIG_PARAVIRT_SPINLOCKS
>> +#if defined(CONFIG_PARAVIRT_SPINLOCKS) || =
defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>> 	long reserved[2];
>> #endif
>> };
>> @@ -327,7 +323,7 @@ static __always_inline void =
__pass_mcs_lock(struct mcs_spinlock *node,
>> #define set_locked_empty_mcs	__set_locked_empty_mcs
>> #define pass_mcs_lock		__pass_mcs_lock
>>=20
>> -#endif /* _GEN_PV_LOCK_SLOWPATH */
>> +#endif /* _GEN_PV_LOCK_SLOWPATH && _GEN_CNA_LOCK_SLOWPATH */
>>=20
>> /**
>>  * queued_spin_lock_slowpath - acquire the queued spinlock
>> @@ -600,6 +596,29 @@ void queued_spin_lock_slowpath(struct qspinlock =
*lock, u32 val)
>> EXPORT_SYMBOL(queued_spin_lock_slowpath);
>>=20
>> /*
>> + * Generate the code for NUMA-aware spin locks
>> + */
>> +#if !defined(_GEN_CNA_LOCK_SLOWPATH) && =
defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>> +#define _GEN_CNA_LOCK_SLOWPATH
>> +
>> +#undef pv_init_node
>> +#define pv_init_node cna_init_node
>> +
>> +#undef set_locked_empty_mcs
>> +#define set_locked_empty_mcs		cna_set_locked_empty_mcs
>> +
>> +#undef pass_mcs_lock
>> +#define pass_mcs_lock			cna_pass_mcs_lock
>> +
>> +#undef  queued_spin_lock_slowpath
>> +#define queued_spin_lock_slowpath	__cna_queued_spin_lock_slowpath
>> +
>> +#include "qspinlock_cna.h"
>> +#include "qspinlock.c"
>> +
>> +#endif
>> +
>> +/*
>>  * Generate the paravirt code for queued_spin_unlock_slowpath().
>>  */
>> #if !defined(_GEN_PV_LOCK_SLOWPATH) && =
defined(CONFIG_PARAVIRT_SPINLOCKS)
>> diff --git a/kernel/locking/qspinlock_cna.h =
b/kernel/locking/qspinlock_cna.h
>> new file mode 100644
>> index 000000000000..efb9b12b2f9b
>> --- /dev/null
>> +++ b/kernel/locking/qspinlock_cna.h
>> @@ -0,0 +1,164 @@
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
>> + * threads running on the same node as the current lock holder, and =
a
>> + * secondary queue for threads running on other nodes. At the unlock =
time,
>> + * the lock holder scans the main queue looking for a thread running =
on
>> + * the same node. If found (call it thread T), all threads in the =
main queue
>> + * between the current lock holder and T are moved to the end of the
>> + * secondary queue, and the lock is passed to T. If such T is not =
found, the
>> + * lock is passed to the first node in the secondary queue. Finally, =
if the
>> + * secondary queue is empty, the lock is passed to the next thread =
in the
>> + * main queue. To avoid starvation of threads in the secondary =
queue,
>> + * those threads are moved back to the head of the main queue
>> + * after a certain expected number of intra-node lock hand-offs.
>> + *
>> + * For more details, see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwICaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DNH4Xld7c5GQcD5N1oCMpapcK4gtC1Lg=
6WNc__6B-qlo&s=3DDBj9a52iqQ8TW5raX7fVjytlskLrPc9gseyBQCM0GS0&e=3D .
>> + *
>> + * Authors: Alex Kogan <alex.kogan@oracle.com>
>> + *          Dave Dice <dave.dice@oracle.com>
>> + */
>> +
>> +struct cna_node {
>> +	struct	mcs_spinlock mcs;
>> +	u32	numa_node;
>> +	u32	encoded_tail;
>> +	struct	cna_node *tail;    /* points to the secondary queue tail =
*/
>> +};
>> +
>> +#define CNA_NODE(ptr) ((struct cna_node *)(ptr))
>> +
>> +static void cna_init_node(struct mcs_spinlock *node)
>> +{
>> +	struct cna_node *cn =3D CNA_NODE(node);
>> +	struct mcs_spinlock *base_node;
>> +	int cpuid;
>> +
>> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
>> +	/* we store a pointer in the node's @locked field */
>> +	BUILD_BUG_ON(sizeof(uintptr_t) > sizeof_field(struct =
mcs_spinlock, locked));
>> +
>> +	cpuid =3D smp_processor_id();
>> +	cn->numa_node =3D cpu_to_node(cpuid);
>> +
>> +	base_node =3D this_cpu_ptr(&qnodes[0].mcs);
>> +	cn->encoded_tail =3D encode_tail(cpuid, base_node->count - 1);
>> +}
>=20
>=20
> I think you can use an early_init call to initialize the numa_node and
> encoded_tail values for all the per-cpu CNA nodes instead of doing it
> every time a node is used. If it turns out that pv_qspinlock is used,
> the pv_node_init() will properly re-initialize it.
Yes, this should work. Thanks.

BTW, should not we initialize `cpu` in pv_init_node() that same way?

> The only thing left
> to do here is perhaps setting tail to NULL.
There is no need to initialize cna_node.tail =E2=80=94 we never access =
it unless
the node is at the head of the secondary queue, and in that case we=20
initialize it before placing the node at the head of that queue=20
(see find_successor()).

Best regards,
=E2=80=94 Alex

>=20
> -Longman
>=20

