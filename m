Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7382135FAB1
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 20:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351151AbhDNSUC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 14:20:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353073AbhDNSTi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Apr 2021 14:19:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EI3qhc126356;
        Wed, 14 Apr 2021 18:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=gLGuc0MbwC1hbqSzhPV007H4I1ORU4K5O+TznHWynCk=;
 b=PQVoeIpjkonbJIa8tkqqaN5uVs9M4jOu/Jmuk93yrCMBZQT6K2/OgDsxINiUwIVfonGf
 5O4BI7+J18NE9jnx+gXsDhEvKP4SHoomiTdVqi/WFNnBQ2Ybk+sFHixT17eLhizOcgwp
 o0yh0//sR0+gYNyh0OpW8odEtHo/6+JIsZ2y7698Mm35lwr8HG1LERmlfh+XY1HCSsIF
 1NgM5fGU05YoIqLEGgSsdUhyWr5npwdQ4cHpB9z2WGyNzLF19B4rmx911/NrhRWNyvSl
 fGcQEWgVZ4LosmlqKRAQsXXgk14b+VePDT6/rCC7sBA/3H0CGWKNN7Mqpano5akGM9Yx Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37u3erke32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 18:18:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EI5k3Y125745;
        Wed, 14 Apr 2021 18:18:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 37unx1q3fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 18:18:17 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13EII8L6015694;
        Wed, 14 Apr 2021 18:18:08 GMT
Received: from [10.39.249.3] (/10.39.249.3)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 11:18:07 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] : Re: [PATCH v14 6/6] locking/qspinlock: Introduce the
 shuffle reduction optimization into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <YHad9S5ckj5IR1l6@suselix>
Date:   Wed, 14 Apr 2021 14:18:05 -0400
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <96EB342A-1343-4D71-B687-6EED27159161@oracle.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-7-alex.kogan@oracle.com> <YHad9S5ckj5IR1l6@suselix>
To:     Andreas Herrmann <aherrmann@suse.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140118
X-Proofpoint-ORIG-GUID: 39TCaFnEN6owMAOcL_9f8xo3oSQ__Tm0
X-Proofpoint-GUID: 39TCaFnEN6owMAOcL_9f8xo3oSQ__Tm0
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140118
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Andreas.

Thanks for the great questions.

> On Apr 14, 2021, at 3:47 AM, Andreas Herrmann <aherrmann@suse.com> =
wrote:
>=20
> On Thu, Apr 01, 2021 at 11:31:56AM -0400, Alex Kogan wrote:
>> This performance optimization chooses probabilistically to avoid =
moving
>> threads from the main queue into the secondary one when the secondary =
queue
>> is empty.
>>=20
>> It is helpful when the lock is only lightly contended. In particular, =
it
>> makes CNA less eager to create a secondary queue, but does not =
introduce
>> any extra delays for threads waiting in that queue once it is =
created.
>>=20
>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Waiman Long <longman@redhat.com>
>> ---
>> kernel/locking/qspinlock_cna.h | 39 =
++++++++++++++++++++++++++++++++++
>> 1 file changed, 39 insertions(+)
>>=20
>> diff --git a/kernel/locking/qspinlock_cna.h =
b/kernel/locking/qspinlock_cna.h
>> index 29c3abbd3d94..983c6a47a221 100644
>> --- a/kernel/locking/qspinlock_cna.h
>> +++ b/kernel/locking/qspinlock_cna.h
>> @@ -5,6 +5,7 @@
>>=20
>> #include <linux/topology.h>
>> #include <linux/sched/rt.h>
>> +#include <linux/random.h>
>>=20
>> /*
>>  * Implement a NUMA-aware version of MCS (aka CNA, or compact =
NUMA-aware lock).
>> @@ -86,6 +87,34 @@ static inline bool =
intra_node_threshold_reached(struct cna_node *cn)
>> 	return current_time - threshold > 0;
>> }
>>=20
>> +/*
>> + * Controls the probability for enabling the ordering of the main =
queue
>> + * when the secondary queue is empty. The chosen value reduces the =
amount
>> + * of unnecessary shuffling of threads between the two waiting =
queues
>> + * when the contention is low, while responding fast enough and =
enabling
>> + * the shuffling when the contention is high.
>> + */
>> +#define SHUFFLE_REDUCTION_PROB_ARG  (7)
>=20
> Out of curiosity:
>=20
> Have you used other values and done measurements what's an efficient
> value for SHUFFLE_REDUCTION_PROB_ARG?
Yes, we did try other values. Small variations do not change the results =
much,
but if you bump the value significantly (e.g., 20), you end up with a =
lock that
hardly does any shuffling and thus performs on-par with the (MCS-based)
baseline.

> Maybe I miscalculated it, but if I understand it correctly this value
> implies that the propability is 0.9921875 that below function returns
> true.
Your analysis is correct. Intuitively, we tried to keep the probability =
around 1-2%,
so if we do decide to shuffle when we don=E2=80=99t really want to =
(i.e., when the
contention is low), the overall overhead of such wrong decisions would =
be small.

>=20
> My question is probably answered by following statement from
> referenced paper:
>=20
> "In our experiments with the shuffle reduction optimization enabled,
> we set THRESHOLD2 to 0xff." (page with figure 5)
Yeah, just to avoid any confusion =E2=80=94 we used a different =
mechanism to draw
pseudo-random numbers in the paper, so that 0xff number is not directly=20=

comparable to the range of possible values for =
SHUFFLE_REDUCTION_PROB_ARG,
but the idea was exactly the same.

>=20
>> +
>> +/* Per-CPU pseudo-random number seed */
>> +static DEFINE_PER_CPU(u32, seed);
>> +
>> +/*
>> + * Return false with probability 1 / 2^@num_bits.
>> + * Intuitively, the larger @num_bits the less likely false is to be =
returned.
>> + * @num_bits must be a number between 0 and 31.
>> + */
>> +static bool probably(unsigned int num_bits)
>> +{
>> +	u32 s;
>> +
>> +	s =3D this_cpu_read(seed);
>> +	s =3D next_pseudo_random32(s);
>> +	this_cpu_write(seed, s);
>> +
>> +	return s & ((1 << num_bits) - 1);
>> +}
>> +
>> static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>> {
>> 	struct mcs_spinlock *base =3D per_cpu_ptr(&qnodes[0].mcs, cpu);
>> @@ -293,6 +322,16 @@ static __always_inline u32 =
cna_wait_head_or_lock(struct qspinlock *lock,
>> {
>> 	struct cna_node *cn =3D (struct cna_node *)node;
>>=20
>> +	if (node->locked <=3D 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) =
{
>=20
> Again if I understand it correctly with SHUFFLE_REDUCTION_PROB_ARG=3D=3D=
7
> it's roughly 1 out of 100 cases where probably() returns false.
>=20
> Why/when is this beneficial?
>=20
> I assume it has to do with following statement in the referenced
> paper:
>=20
> "The superior performance over MCS at 4 threads is the result of the
> shuffling that does take place once in a while, organizing threads=E2=80=
=99
> arrivals to the lock in a way that reduces the inter-socket lock
> migration without the need to continuously modify the main queue. ..."
> (page with figure 9; the paper has no page numbers)
This is correct. This performance optimization deals with a small =
regression
that might occur at the low-medium range of contention. And just to =
reiterate
what the patch comment says, this optimization has nothing to do with =
correctness
and does not introduce any extra delays for threads already waiting in =
the
secondary queue.

>=20
> But OTHO why this pseudo randomness?
>=20
> How about deterministically treating every 100th execution differently
> (it also matches "once in a while") and thus entirely removing the
> pseudo randomness?
Pseudo-randomness helps to avoid pathological cases where we would do =
the
same decision, despite having this optimization in place, for every lock =
acquisition.

Consider an application in which each thread cycles through X locks, =
e.g., X=3D10.
If we count deterministically, then for the first 9 locks we will =
_always avoid doing
any shuffling, missing on any opportunity for the benefit derived by the =
CNA=20
approach. At the same time, for lock #10 we will always attempt to =
shuffle, and so
the optimization would not have any effect.=20

>=20
> Have you tried this? If so why was it worse than pseudo randomness?
>=20
> (Or maybe I missed something and pseudo randomness is required for
> other reasons there.)

Hope this helps =E2=80=94 let me know if you have any further questions!

Best,
=E2=80=94 Alex=
