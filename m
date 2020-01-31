Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFA014F23A
	for <lists+linux-arch@lfdr.de>; Fri, 31 Jan 2020 19:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgAaSer (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jan 2020 13:34:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39670 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaSer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jan 2020 13:34:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VIXnLU048194;
        Fri, 31 Jan 2020 18:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=P2nZoqcfNGldK9P/dZq23Tu+F7jBb92VgkLDVWfhseI=;
 b=RkOB+zXPcOMe/TzVMBmZWBg0/fmy2xQDHQnkEnZZrVssmKa2LjtgNSfZw4BdUyRj27I3
 NxtdZHOzA0YwS+qsPKRs2ZdxDZ3IdPlSNndj+WXQ9Wm8p1iVrQu5316A54UXgAM9tQDk
 tPteAvxngkK1cDm5h9O6ir6usq8kfCyFyG4eCrg7fbSHPps0kySCBcDMUErr9j8tTPXH
 KXNhmKbQkDdGN2MT1wB3cWnc/Ob9BtjAWbLSDOF5TDZGT/dqtYaBaE1LuZuUDwGWKg/e
 w3lz2uZJKGR0/KqrbmgubqVpPIMaDtrd1MAaXuJikdVETsMJfsG4wgvIAa8GPy/CVIDH 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xrdmr491d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 18:33:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VIE1mh039787;
        Fri, 31 Jan 2020 18:33:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xv8nrhqtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 18:33:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00VIXC5D029013;
        Fri, 31 Jan 2020 18:33:12 GMT
Received: from [10.39.253.182] (/10.39.253.182)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jan 2020 10:33:12 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20200131133543.GD14914@hirez.programming.kicks-ass.net>
Date:   Fri, 31 Jan 2020 13:33:09 -0500
Cc:     linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E32F90E2-F00B-423B-A851-336004EF6593@oracle.com>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
 <20200122095127.GC14946@hirez.programming.kicks-ass.net>
 <20200122170456.GY14879@hirez.programming.kicks-ass.net>
 <D6ED40A0-E96D-41F6-AA74-0901C2C37476@oracle.com>
 <20200131133543.GD14914@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310152
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


>>> + *
>>> + * Returns 0 if a matching node is found; otherwise return the =
encoded pointer
>>> + * to the last element inspected (such that a subsequent scan can =
continue there).
>>> + *
>>> + * The worst case complexity of the scan is O(n), where n is the =
number
>>> + * of current waiters. However, the amortized complexity is close =
to O(1),
>>> + * as the immediate successor is likely to be running on the same =
node once
>>> + * threads from other nodes are moved to the secondary queue.
>>> + *
>>> + * XXX does not compute; given equal contention it should average =
to O(nr_nodes).
>> Let me try to convince you. Under contention, the immediate waiter =
would be
>> a local one. So the scan would typically take O(1) steps. We need to =
consider
>> the extra work/steps we take to move nodes to the secondary queue. =
The
>> number of such nodes is O(n) (to be more precise, it is O(n-m), where =
m
>> is nr_cpus_per_node), and we spend a constant amount of work, per =
node,=20
>> to scan those nodes and move them to the secondary queue. So in =
2^thresholds
>> lock handovers, we scan 2^thresholds x 1 + n-m nodes. Assuming=20
>> 2^thresholds > n, the amortized complexity of this function then is =
O(1).
>=20
> There is no threshold in this patch.
This does not change the analysis, though.

> That's the next patch, and
> I've been procrastinating on that one, mostly also because of the
> 'reasonable' claim without data.
>=20
> But Ah!, I think I see, after nr_cpus tries, all remote waiters are on
> the secondary queue and only local waiters will remain. That will =
indeed
> depress the average a lot.
Ok, cool.

< snip >

>=20
>>> +{
>>> +	struct mcs_spinlock *head_2nd, *tail_2nd;
>>> +
>>> +	tail_2nd =3D decode_tail(node->locked);
>>> +	head_2nd =3D tail_2nd->next;
>> I understand that you are trying to avoid repeating those two lines
>> in both places this function is called from, but you do it at the =
cost
>> of adding the following unnecessary if-statement, and in general this =
function
>> looks clunky.
>=20
> Let me show you the current form:
>=20
> /*
> * cna_splice_head -- splice the entire secondary queue onto the head =
of the
> * primary queue.
> *
> * Returns the new primary head node or NULL on failure.
Maybe explain here why failure can happen? Eg., =E2=80=9CThe latter can =
happen
due to a race with a waiter joining an empty primary queue."

> */
> static struct mcs_spinlock *
> cna_splice_head(struct qspinlock *lock, u32 val,
> 		struct mcs_spinlock *node, struct mcs_spinlock *next)
> {
> 	struct mcs_spinlock *head_2nd, *tail_2nd;
> 	u32 new;
>=20
> 	tail_2nd =3D decode_tail(node->locked);
> 	head_2nd =3D tail_2nd->next;
>=20
> 	if (!next) {
> 		/*
> 		 * When the primary queue is empty; our tail becomes the =
primary tail.
> 		 */
>=20
> 		/*
> 		 * Speculatively break the secondary queue's circular =
link; such that when
> 		 * the secondary tail becomes the primary tail it all =
works out.
> 		 */
> 		tail_2nd->next =3D NULL;
>=20
> 		/*
> 		 * tail_2nd->next =3D NULL		xchg_tail(lock, =
tail)
> 		 *
> 		 * cmpxchg_release(&lock, val, new)	=
WRITE_ONCE(prev->next, node);
> 		 *
> 		 * Such that if the cmpxchg() succeeds, our stores won't =
collide.
> 		 */
> 		new =3D ((struct cna_node *)tail_2nd)->encoded_tail | =
_Q_LOCKED_VAL;
> 		if (!atomic_try_cmpxchg_release(&lock->val, &val, new)) =
{
> 			/*
> 			 * Note; when this cmpxchg fails due to =
concurrent
> 			 * queueing of a new waiter, then we'll try =
again in
> 			 * cna_pass_lock() if required.
> 			 *
> 			 * Restore the secondary queue's circular link.
> 			 */
> 			tail_2nd->next =3D head_2nd;
> 			return NULL;
> 		}
>=20
> 	} else {
> 		/*
> 		 * If the primary queue is not empty; the primary tail =
doesn't need
> 		 * to change and we can simply link our tail to the old =
head.
> 		 */
> 		tail_2nd->next =3D next;
> 	}
>=20
> 	/* That which was the secondary queue head, is now the primary =
queue head */
Rephrase the comment?

> 	return head_2nd;
> }
>=20
> The function as a whole is self-contained and consistent, it deals =
with
> the splice 2nd to 1st queue, for all possible cases. You only have to
> think about the list splice in one place, here, instead of two places.
>=20
> I don't think it will actually result in more branches emitted; the
> compiler should be able to use value propagation to eliminate stuff.
Ok, I can see your point.

>=20
>>> +static inline bool cna_try_clear_tail(struct qspinlock *lock, u32 =
val,
>>> +				      struct mcs_spinlock *node)
>>> +{
>>> +	struct mcs_spinlock *next;
>>> +
>>> +	/*
>>> +	 * We're here because the primary queue is empty; check the =
secondary
>>> +	 * queue for remote waiters.
>>> +	 */
>>> +	if (node->locked > 1) {
>>> +		/*
>>> +		 * When there are waiters on the secondary queue move =
them back
>>> +		 * onto the primary queue and let them rip.
>>> +		 */
>>> +		next =3D cna_splice_head(lock, val, node, NULL);
>>> +		if (next) {
>> And, again, this if-statement is here only because you moved the rest =
of the code
>> into cna_splice_head(). Perhaps, with cna_extract_2dary_head_tail() =
you can
>> bring that code back?
>=20
> I don't see the objection, you already had a branch there, from the
> cmpxchg(), this is the same branch, the compiler should fold the lot.
Now you have the branch from cmpxchg(), and another one from "if =
(next)=E2=80=9D.
But you are right that the compiler is likely to optimize out the =
latter.

> We can add an __always_inline if you're worried.
Let=E2=80=99s do that.

< snip >

>>> +static inline void cna_pass_lock(struct mcs_spinlock *node,
>>> +				 struct mcs_spinlock *next)
>>> +{
>>> +	struct cna_node *cn =3D (struct cna_node *)node;
>>> +	u32 partial_order =3D cn->partial_order;
>>> +	u32 val =3D _Q_LOCKED_VAL;
>>> +
>>> +	/* cna_wait_head_or_lock() left work for us. */
>>> +	if (partial_order) {
>>> +		partial_order =3D cna_order_queue(node, =
decode_tail(partial_order));
>>> +
>>> +	if (!partial_order) {
>>> +		/*
>>> +		 * We found a local waiter; reload @next in case we =
called
>>> +		 * cna_order_queue() above.
>>> +		 */
>>> +		next =3D node->next;
>>> +		val |=3D node->locked;	/* preseve secondary queue */
>> This is wrong. node->locked can be 0, 1 or an encoded tail at this =
point, and
>> the latter case will be handled incorrectly.
>>=20
>> Should be=20
>> 		  if (node->locked) val =3D node->locked;
>> instead.
>=20
> I'm confused, who cares about the locked bit when it has an encoded =
tail on?
>=20
> The generic code only cares about it being !0, and the cna code always
> checks if it has a tail (>1 , <=3D1) first.
Ah, that may actually work, but not sure if this was your intention.

The code above sets val to 1 or encoded tail + 1 (rather than encoded =
tail),
decode_tail(tail) does not care about LSB, and will do its calculation =
correctly.
IOW, decode_tail( tail ) is the same as decode_tail( tail + 1 ).

I think this is a bit fragile and depends on the implementation of=20
decode_tail(), but if you are fine with that, no objections here.

Regards,
=E2=80=94 Alex

