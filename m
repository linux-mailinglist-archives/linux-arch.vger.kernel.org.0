Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3826AD92
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGPRUt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 13:20:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfGPRUt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 13:20:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GHIks5065487;
        Tue, 16 Jul 2019 17:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=sCf21UOaOAUhlxqHIiC1lJ6uDmpf3G/KNigZLTzyEQY=;
 b=Y+wovuD8ba5GmLeCjQ76Ub931WhVRNEyB0QWQ8dfFFQ5vjNjJKN32LrjhL+fLpd7XHF3
 Ks6bHzq5JtNXUSgJ324OyzvbngcDDjatj3xymMsZgCFbPwUcg4QeGe9ICgilVlXLVR3D
 a180gWa0kd8xyHILI8eumul9YGHIiTi7d+d3jxoWB4sEUIisy+/fOILEh7RzQg/lBx8l
 85RFkyFjd0gqo6M6HdQZ5nS2g8LPXYDsVe9LPtOiHY/jIaBUI8oDrec+ruaMYi/sikK4
 EjedNAKNT1+UQozA/4Nn0qNK46jxLRgfD+a+dpA6ceyMW5IG5kqaXNBkoRhaUkH+nd7H 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qtnyxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 17:19:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GHHhnC184904;
        Tue, 16 Jul 2019 17:19:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tq6mn0us3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 17:19:37 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GHJJ0u030134;
        Tue, 16 Jul 2019 17:19:20 GMT
Received: from [10.39.235.122] (/10.39.235.122)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 17:19:19 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190716155022.GR3419@hirez.programming.kicks-ass.net>
Date:   Tue, 16 Jul 2019 13:19:16 -0400
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=860
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160213
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=914 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160213
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter.

Thanks for the review and all the suggestions!

A couple of comments are inlined below.

> On Jul 16, 2019, at 11:50 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Jul 15, 2019 at 03:25:34PM -0400, Alex Kogan wrote:
>> +static struct cna_node *find_successor(struct mcs_spinlock *me)
>> +{
>> +	struct cna_node *me_cna =3D CNA_NODE(me);
>> +	struct cna_node *head_other, *tail_other, *cur;
>> +	struct cna_node *next =3D CNA_NODE(READ_ONCE(me->next));
>> +	int my_node;
>> +
>> +	/* @next should be set, else we would not be calling this =
function. */
>> +	WARN_ON_ONCE(next =3D=3D NULL);
>> +
>> +	my_node =3D me_cna->numa_node;
>> +
>> +	/*
>> +	 * Fast path - check whether the immediate successor runs on
>> +	 * the same node.
>> +	 */
>> +	if (next->numa_node =3D=3D my_node)
>> +		return next;
>> +
>> +	head_other =3D next;
>> +	tail_other =3D next;
>> +
>> +	/*
>> +	 * Traverse the main waiting queue starting from the successor =
of my
>> +	 * successor, and look for a thread running on the same node.
>> +	 */
>> +	cur =3D CNA_NODE(READ_ONCE(next->mcs.next));
>> +	while (cur) {
>> +		if (cur->numa_node =3D=3D my_node) {
>> +			/*
>> +			 * Found a thread on the same node. Move threads
>> +			 * between me and that node into the secondary =
queue.
>> +			 */
>> +			if (me->locked > 1)
>> +				CNA_NODE(me->locked)->tail->mcs.next =3D
>> +					(struct mcs_spinlock =
*)head_other;
>> +			else
>> +				me->locked =3D (uintptr_t)head_other;
>> +			tail_other->mcs.next =3D NULL;
>> +			CNA_NODE(me->locked)->tail =3D tail_other;
>> +			return cur;
>> +		}
>> +		tail_other =3D cur;
>> +		cur =3D CNA_NODE(READ_ONCE(cur->mcs.next));
>> +	}
>> +	return NULL;
>> +}
>=20
> static void cna_move(struct cna_node *cn, struct cna_node *cni)
> {
> 	struct cna_node *head, *tail;
>=20
> 	/* remove @cni */
> 	WRITE_ONCE(cn->mcs.next, cni->mcs.next);
>=20
> 	/* stick @cni on the 'other' list tail */
> 	cni->mcs.next =3D NULL;
>=20
> 	if (cn->mcs.locked <=3D 1) {
> 		/* head =3D tail =3D cni */
> 		head =3D cni;
> 		head->tail =3D cni;
> 		cn->mcs.locked =3D head->encoded_tail;
> 	} else {
> 		/* add to tail */
> 		head =3D (struct cna_node *)decode_tail(cn->mcs.locked);
> 		tail =3D tail->tail;
> 		tail->next =3D cni;
> 	}
> }
>=20
> static struct cna_node *cna_find_next(struct mcs_spinlock *node)
> {
> 	struct cna_node *cni, *cn =3D (struct cna_node *)node;
>=20
> 	while ((cni =3D (struct cna_node *)READ_ONCE(cn->mcs.next))) {
> 		if (likely(cni->node =3D=3D cn->node))
> 			break;
>=20
> 		cna_move(cn, cni);
> 	}
>=20
> 	return cni;
> }
But then you move nodes from the main list to the =E2=80=98other=E2=80=99 =
list one-by-one.
I=E2=80=99m afraid this would be unnecessary expensive.
Plus, all this extra work is wasted if you do not find a thread on the =
same=20
NUMA node (you move everyone to the =E2=80=98other=E2=80=99 list only to =
move them back in=20
cna_mcs_pass_lock()).

>=20
>> +static inline bool cna_set_locked_empty_mcs(struct qspinlock *lock, =
u32 val,
>> +					struct mcs_spinlock *node)
>> +{
>> +	/* Check whether the secondary queue is empty. */
>> +	if (node->locked <=3D 1) {
>> +		if (atomic_try_cmpxchg_relaxed(&lock->val, &val,
>> +				_Q_LOCKED_VAL))
>> +			return true; /* No contention */
>> +	} else {
>> +		/*
>> +		 * Pass the lock to the first thread in the secondary
>> +		 * queue, but first try to update the queue's tail to
>> +		 * point to the last node in the secondary queue.
>=20
>=20
> That comment doesn't make sense; there's at least one conditional
> missing.
In CNA, we cannot just clear the tail when the MCS chain is empty, as=20
there might be nodes in the =E2=80=98other=E2=80=99 chain. In that case =
(this is the =E2=80=9Celse=E2=80=9D part),
we want to pass the lock to the first node in the =E2=80=98other=E2=80=99 =
chain, but=20
first we need to put the last node from that chain into the tail. =
Perhaps the
comment should read =E2=80=9C=E2=80=A6  but first try to update the =
*primary* queue's tail =E2=80=A6=E2=80=9D,=20
if that makes more sense.

>=20
>> +		 */
>> +		struct cna_node *succ =3D CNA_NODE(node->locked);
>> +		u32 new =3D succ->tail->encoded_tail + _Q_LOCKED_VAL;
>> +
>> +		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
>> +			=
arch_mcs_spin_unlock_contended(&succ->mcs.locked, 1);
>> +			return true;
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>=20
> static cna_try_clear_tail(struct qspinlock *lock, u32 val, struct =
mcs_spinlock *node)
> {
> 	if (node->locked <=3D 1)
> 		return __try_clear_tail(lock, val, node);
>=20
> 	/* the other case */
> }
Good point, thanks.

>=20
>> +static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
>> +				     struct mcs_spinlock *next)
>> +{
>> +	struct cna_node *succ =3D NULL;
>> +	u64 *var =3D &next->locked;
>> +	u64 val =3D 1;
>> +
>> +	succ =3D find_successor(node);
>=20
> This makes unlock O(n), which is 'funneh' and undocumented.
I will add a comment above the call to find_successor() / =
cna_find_next().

>=20
>> +
>> +	if (succ) {
>> +		var =3D &succ->mcs.locked;
>> +		/*
>> +		 * We unlock a successor by passing a non-zero value,
>> +		 * so set @val to 1 iff @locked is 0, which will happen
>> +		 * if we acquired the MCS lock when its queue was empty
>> +		 */
>> +		val =3D node->locked + (node->locked =3D=3D 0);
>> +	} else if (node->locked > 1) { /* if the secondary queue is not =
empty */
>> +		/* pass the lock to the first node in that queue */
>> +		succ =3D CNA_NODE(node->locked);
>> +		succ->tail->mcs.next =3D next;
>> +		var =3D &succ->mcs.locked;
>=20
>> +	}	/*
>> +		 * Otherwise, pass the lock to the immediate successor
>> +		 * in the main queue.
>> +		 */
>=20
> I don't think this mis-indented comment can happen. The call-site
> guarantees @next is non-null.
>=20
> Therefore, cna_find_next() will either return it, or place it on the
> secondary list. If it (cna_find_next) returns NULL, we must have a
> non-empty secondary list.
>=20
> In no case do I see this tertiary condition being possible.
find_successor() will return NULL if it does not find a thread running =
on the=20
same NUMA node. And the secondary queue might be empty at that time.

>=20
>> +
>> +	arch_mcs_spin_unlock_contended(var, val);
>> +}
>=20
> This also renders this @next argument superfluous.
>=20
> static cna_mcs_pass_lock(struct mcs_spinlock *node, struct =
mcs_spinlock *next)
> {
> 	next =3D cna_find_next(node);
> 	if (!next) {
> 		BUG_ON(node->locked <=3D 1);
> 		next =3D (struct cna_node *)decode_tail(node->locked);
> 		node->locked =3D 1;
> 	}
>=20
> 	arch_mcs_pass_lock(&next->mcs.locked, node->locked);
> }

@next is passed to save the load from @node.
This is probably most important for the native code (__pass_mcs_lock()).
That function should be inlined, however, and that load should not =
matter.
Bottom line, I agree that we can remove the @next argument.

Best regards,
=E2=80=94 Alex


