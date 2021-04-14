Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E622E35EAE0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 04:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhDNCa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 22:30:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45184 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhDNCa0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 22:30:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E2PNLc024819;
        Wed, 14 Apr 2021 02:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=KkLLCrZWDiKYSnLJLqsQyCX146lmHXS5CDO9gPAfauE=;
 b=BLki9NRwAEb5LBoAFKfS/alCw09RheMbN87a9Jh3xQr1+9/yhGOSrUVTdviYP7SP9Gto
 2yOc6OVJzooeJcDKdR4t2QvJ1m5ZJca8FcmIiG6FY+c3wgtOppHzmy978xnIISOrQTWh
 OjyFqw+fvfHodR/9evFhUAiEQQJKMHTH+g+TAhfSG6KZco6CTQAyIbzpvsBZgF2aofdw
 y34We7IENQ+XDRFJhyEcmSJ1Y/UyF+8n65PpgS1SEt8BGSmlLbPkMjmmtjYnGv63rvnR
 CF/Q7lbOO7NxQF4kmNueriZsjy3YXkAIq7iPcBhQRI0rCnJXkPrK5S25qrN4Du71wnot RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37u3ymguxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 02:29:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E2PWM9055502;
        Wed, 14 Apr 2021 02:29:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 37unst8n1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 02:29:28 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E2T9N1027598;
        Wed, 14 Apr 2021 02:29:09 GMT
Received: from [10.39.235.234] (/10.39.235.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 02:29:08 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] : Re: [PATCH v14 3/6] locking/qspinlock: Introduce CNA
 into the slow path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <YHWAvjymlE5svU71@hirez.programming.kicks-ass.net>
Date:   Tue, 13 Apr 2021 22:29:07 -0400
Cc:     linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB82B452-C879-445D-BBFE-DF4FD7597798@oracle.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-4-alex.kogan@oracle.com>
 <YHWAvjymlE5svU71@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140016
X-Proofpoint-GUID: ABqW3SS4571hF5OwUz4Z393S9cZYSXFB
X-Proofpoint-ORIG-GUID: ABqW3SS4571hF5OwUz4Z393S9cZYSXFB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140016
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Peter, thanks for all the comments and suggestions!

> On Apr 13, 2021, at 7:30 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Apr 01, 2021 at 11:31:53AM -0400, Alex Kogan wrote:
>=20
>> +/*
>> + * cna_splice_tail -- splice the next node from the primary queue =
onto
>> + * the secondary queue.
>> + */
>> +static void cna_splice_next(struct mcs_spinlock *node,
>> +			    struct mcs_spinlock *next,
>> +			    struct mcs_spinlock *nnext)
>=20
> You forgot to update the comment when you changed the name on this
> thing.
Good catch, thanks.

>=20
>> +/*
>> + * cna_order_queue - check whether the next waiter in the main queue =
is on
>> + * the same NUMA node as the lock holder; if not, and it has a =
waiter behind
>> + * it in the main queue, move the former onto the secondary queue.
>> + */
>> +static void cna_order_queue(struct mcs_spinlock *node)
>> +{
>> +	struct mcs_spinlock *next =3D READ_ONCE(node->next);
>> +	struct cna_node *cn =3D (struct cna_node *)node;
>> +	int numa_node, next_numa_node;
>> +
>> +	if (!next) {
>> +		cn->partial_order =3D LOCAL_WAITER_NOT_FOUND;
>> +		return;
>> +	}
>> +
>> +	numa_node =3D cn->numa_node;
>> +	next_numa_node =3D ((struct cna_node *)next)->numa_node;
>> +
>> +	if (next_numa_node !=3D numa_node) {
>> +		struct mcs_spinlock *nnext =3D READ_ONCE(next->next);
>> +
>> +		if (nnext) {
>> +			cna_splice_next(node, next, nnext);
>> +			next =3D nnext;
>> +		}
>> +		/*
>> +		 * Inherit NUMA node id of primary queue, to maintain =
the
>> +		 * preference even if the next waiter is on a different =
node.
>> +		 */
>> +		((struct cna_node *)next)->numa_node =3D numa_node;
>> +	}
>> +}
>=20
> So the obvious change since last time I looked a this is that it now
> only looks 1 entry ahead. Which makes sense I suppose.
This is in response to the critique that the worst-case time complexity =
of
cna_order_queue() was O(n). With this change, the complexity is =
constant.

>=20
> I'm not really a fan of the 'partial_order' name combined with that
> silly enum { LOCAL_WAITER_FOUND, LOCAL_WAITER_NOT_FOUND }. That's just
> really bad naming all around. The enum is about having a waiter while
> the variable is about partial order, that doesn't match at all.
Fair enough.

> If you rename the variable to 'has_waiter' and simply use 0,1 values,
> things would be ever so more readable. But I don't think that makes
> sense, see below.
>=20
> I'm also not sure about that whole numa_node thing, why would you
> over-write the numa node, why at this point ?
With this move-one-by-one approach, I want to keep the NUMA-node=20
preference of the lock holder even if the next-next waiter is on a =
different
NUMA-node. Otherwise, we will end up switching preference often and
the entire scheme would not perform well. In particular, we might easily
end up with threads from the preferred node waiting in the secondary =
queue.

>=20
>> +
>> +/* Abuse the pv_wait_head_or_lock() hook to get some work done */
>> +static __always_inline u32 cna_wait_head_or_lock(struct qspinlock =
*lock,
>> +						 struct mcs_spinlock =
*node)
>> +{
>> +	/*
>> +	 * Try and put the time otherwise spent spin waiting on
>> +	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
>> +	 */
>> +	cna_order_queue(node);
>> +
>> +	return 0; /* we lied; we didn't wait, go do so now */
>=20
> So here we inspect one entry ahead and then quit. I can't rmember, but
> did we try something like:
>=20
> 	/*
> 	 * Try and put the time otherwise spent spin waiting on
> 	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
> 	 * Move one entry at a go until either the list is fully
> 	 * sorted or we ran out of spin condition.
> 	 */
> 	while (READ_ONCE(lock->val) & _Q_LOCKED_PENDING_MASK &&
> 	       node->partial_order)
> 		cna_order_queue(node);
>=20
> 	return 0;
>=20
> This will keep moving @next to the remote list until such a time that
> we're forced to continue or @next is local.
We have not tried that. This is actually an interesting idea, with its =
pros and cons.
That is, we are likely to filter out =E2=80=9Cnon-preferred=E2=80=9D =
waiters into the secondary queue
faster, but also we are more likely to run into a situation where the =
lock becomes
available at the time we are running the cna_order_queue() logic, thus =
prolonging
the handover time.

With this change, however, there is no need to call cna_order_queue() =
again=20
in cna_lock_handoff(), which is another advantage I guess.

All in all, I am fine switching to this alternative if you like it more.

BTW, we can return node->partial_order instead of 0, to skip the call to
atomic_cond_read_acquire() in the general code.

>=20
>> +}
>> +
>> +static inline void cna_lock_handoff(struct mcs_spinlock *node,
>> +				 struct mcs_spinlock *next)
>> +{
>> +	struct cna_node *cn =3D (struct cna_node *)node;
>> +	u32 val =3D 1;
>> +
>> +	u32 partial_order =3D cn->partial_order;
>> +
>> +	if (partial_order =3D=3D LOCAL_WAITER_NOT_FOUND)
>> +		cna_order_queue(node);
>> +
>=20
> AFAICT this is where playing silly games with ->numa_node belong; but
> right along with that goes a comment that describes why any of that
> makes sense.
>=20
> I mean, if you leave your node, for any reason, why bother coming back
> to it, why not accept it is a sign of the gods you're overdue for a
> node-change?
I think there is some misunderstanding here =E2=80=94 let me try to =
clarify.
In the current logic, we first call cna_order_queue() from =
cna_wait_head_or_lock().
If we find an appropriate =E2=80=9Clocal=E2=80=9D waiter (either real or =
fake), we set it as
next and make sure the numa_node of that node is the same as ours.
If not (i.e., when we do not have any next waiter), we set partial_order =
to
LOCAL_WAITER_NOT_FOUND (pardon the names) and go spin on the lock =
(calling
atomic_cond_read_acquire() in the generic code).
During this spin time, new waiters can join the queue.
Hence, we recheck the state of the queue by calling cna_order_queue() =
again
from cna_lock_handoff().

As just mentioned, if we change the logic as you suggest, there is
really no reason to call cna_order_queue() again.

>=20
> Was the efficacy of this scheme tested?
>=20
>> +	/*
>> +	 * We have a local waiter, either real or fake one;
>> +	 * reload @next in case it was changed by cna_order_queue().
>> +	 */
>> +	next =3D node->next;
>> +	if (node->locked > 1)
>> +		val =3D node->locked;	/* preseve secondary queue */
>=20
> IIRC we used to do:
>=20
> 	val |=3D node->locked;
>=20
> Which is simpler for not having branches. Why change a good thing?
With |=3D we might set val to encoded tail+1 (rather than encoded tail).
This still would work, as decode_tail(val) does not care about LSB, but =
seems fragile to me.
We talked about that before:=20
=
https://lore.kernel.org/linux-arm-kernel/E32F90E2-F00B-423B-A851-336004EF6=
593@oracle.com

If you think this is a non-issue, I will be happy to adopt your =
suggestion.

Regards,
=E2=80=94 Alex

