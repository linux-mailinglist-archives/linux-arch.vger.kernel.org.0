Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A447E119030
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 19:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLJS5b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 13:57:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfLJS5b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Dec 2019 13:57:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBAIniKk167967;
        Tue, 10 Dec 2019 18:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=CDYvFAbYhdMALL5C6dB4EpUmfL9quyVZ5ex55SfUVC4=;
 b=YEgsjsBZ1Nj4aPDOLcW5hMwJUF6DcZmrzvj7CkYH1qQVD8NquI/3KzvcHnxtRmkHB76t
 nIsakZRtifp/nT84pSfQ2GEVZh7+vXBrhD/739EeF/grixNOYE5RxQEgg28Kx1Yz9fo5
 9cqAlDcgrIVn4eCmscyENQd14YcCULBYaZFUbuUSHD+WG4BkC6zGkxpbIxsrFc/DTTQ8
 iEh/VTvmStUGke0Qtx9aCTUFBbNIUalnowRrw08S5Cz5wr1fLhQIPt1QrCSkLegLSivJ
 FIY17iL6qvkpUTtQFFIU6zeBynb2CdiMJj31JAWSnf91HDizVdbxH329xdIccVTI2q9E Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4n50d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 18:56:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBAIuFNR000798;
        Tue, 10 Dec 2019 18:56:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wt6bd6xg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 18:56:32 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBAIuJDt008204;
        Tue, 10 Dec 2019 18:56:19 GMT
MIME-Version: 1.0
Message-ID: <f1164ae9-ebcf-41f0-8395-224cdb0f249d@default>
Date:   Tue, 10 Dec 2019 10:56:18 -0800 (PST)
From:   Alex Kogan <alex.kogan@oracle.com>
To:     <longman@redhat.com>
Cc:     <rahul.x.yadav@oracle.com>, <tglx@linutronix.de>,
        <linux@armlinux.org.uk>, <hpa@zytor.com>, <dave.dice@oracle.com>,
        <mingo@redhat.com>, <will.deacon@arm.com>, <arnd@arndb.de>,
        <jglauber@marvell.com>, <guohanjun@huawei.com>, <x86@kernel.org>,
        <daniel.m.jordan@oracle.com>, <steven.sistare@oracle.com>,
        <bp@alien8.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] locking/qspinlock: Introduce the shuffle reduction
 optimization into CNA
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912100157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912100156
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


----- longman@redhat.com wrote:

> On 11/25/19 4:07 PM, Alex Kogan wrote:
> > @@ -234,12 +263,13 @@ __always_inline u32 cna_pre_scan(struct
> qspinlock *lock,
> >  =09struct cna_node *cn =3D (struct cna_node *)node;
> > =20
> >  =09/*
> > -=09 * setting @pre_scan_result to 1 indicates that no post-scan
> > +=09 * setting @pre_scan_result to 1 or 2 indicates that no post-scan
> >  =09 * should be made in cna_pass_lock()
> >  =09 */
> >  =09cn->pre_scan_result =3D
> > -=09=09cn->intra_count =3D=3D intra_node_handoff_threshold ?
> > -=09=09=091 : cna_scan_main_queue(node, node);
> > +=09=09(node->locked <=3D 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
> > +=09=09=091 : cn->intra_count =3D=3D intra_node_handoff_threshold ?
> > +=09=09=092 : cna_scan_main_queue(node, node);
> > =20
> >  =09return 0;
> >  }
> > @@ -253,12 +283,15 @@ static inline void cna_pass_lock(struct
> mcs_spinlock *node,
> > =20
> >  =09u32 scan =3D cn->pre_scan_result;
> > =20
> > +=09if (scan =3D=3D 1)
> > +=09=09goto pass_lock;
> > +
> >  =09/*
> >  =09 * check if a successor from the same numa node has not been found
> in
> >  =09 * pre-scan, and if so, try to find it in post-scan starting from
> the
> >  =09 * node where pre-scan stopped (stored in @pre_scan_result)
> >  =09 */
> > -=09if (scan > 1)
> > +=09if (scan > 2)
> >  =09=09scan =3D cna_scan_main_queue(node, decode_tail(scan));
> > =20
> >  =09if (!scan) { /* if found a successor from the same numa node */
> > @@ -281,5 +314,6 @@ static inline void cna_pass_lock(struct
> mcs_spinlock *node,
> >  =09=09tail_2nd->next =3D next;
> >  =09}
> > =20
> > +pass_lock:
> >  =09arch_mcs_pass_lock(&next_holder->locked, val);
> >  }
>=20
> I think you might have mishandled the proper accounting of
> intra_count.
> How about something like:
>=20
> diff --git a/kernel/locking/qspinlock_cna.h
> b/kernel/locking/qspinlock_cna.h
> index f1eef6bece7b..03f8fdec2b80 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -268,7 +268,7 @@ __always_inline u32 cna_pre_scan(struct qspinlock
> *lock,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->pre_scan_result =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (node->locked <=3D 1 &&
> probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 : cn->intra_=
count =3D=3D
> intra_node_handoff_threshold ?
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 : cn->intra_=
count >=3D
> intra_node_handoff_threshold ?

We reset =E2=80=98intra_count' in cna_init_node(), which is called before w=
e enter=20
the slow path, and set it at most once when we pass the internal (CNA) lock
by taking the owner=E2=80=99s value + 1. Only after we get the internal loc=
k, we
call this cna_pre_scan() function, where we check the threshold.=20
IOW, having 'intra_count > intra_node_handoff_threshold' would mean a bug,=
=20
and having =E2=80=9C>=3D=E2=80=9C would mask it.=20
Perhaps I can add WARN_ON(cn->intra_count > intra_node_handoff_threshold)
here instead, although I'm not sure if that is a good idea performance-wise=
.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 : cna_=
scan_main_queue(node, node);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> @@ -283,9 +283,6 @@ static inline void cna_pass_lock(struct
> mcs_spinlock
> *node,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 scan =3D cn->pre_scan_resu=
lt;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan =3D=3D 1)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto pass_lock;
> -
The thing is that we want to avoid as much of the shuffling-related overhea=
d
as we can when the spinlock is only lightly contended. That's why we have t=
his
early exit here that avoids the rest of the logic of triaging through possi=
ble
'scan' values.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * check if a successor f=
rom the same numa node has not been
> found in
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pre-scan, and if so, t=
ry to find it in post-scan starting
> from the
> @@ -294,7 +291,13 @@ static inline void cna_pass_lock(struct
> mcs_spinlock *node,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan > 2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 scan =3D cna_scan_main_queue(node, decode_tail(scan));
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!scan) { /* if found a successo=
r from the same numa node
> */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan <=3D 1) { /* if found a su=
ccessor from the same numa
> node */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* inc @intra_count if the secondary queue is not
> empty */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ((struct cna_node *)next_holder)->intra_count =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->intra_coun=
t + (node->locked > 1);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if ((scan =3D=3D 1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto pass_lock=
;
> +
Hmm, I am not sure this makes the code any better/more readable,
while this does add the overhead of going through 3 branches before
jumping to 'pass_lock'.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 next_holder =3D node->next;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * we unlock successor by passing a non-zero value,
> @@ -302,9 +305,6 @@ static inline void cna_pass_lock(struct
> mcs_spinlock
> *node,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * if we acquired the MCS lock when its queue was
> empty
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 val =3D node->locked ? node->locked : 1;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* inc @intra_count if the secondary queue is not
> empty */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ((struct cna_node *)next_holder)->intra_count =3D
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->intra_coun=
t + (node->locked > 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (node->locked > 1) {=
=C2=A0=C2=A0=C2=A0 /* if secondary queue is
> not
> empty */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* next holder will be the first node in the
> secondary
> queue */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tail_2nd =3D decode_tail(node->locked);
>=20
> The meaning of scan value:
>=20
> 0 - pass to next cna node, which is in the same numa node. Additional
> cna node may or may not be added to the secondary queue
>=20
> 1 - pass to next cna node, which may not be in the same numa node. No
> change to secondary queue
>=20
> 2 - exceed intra node handoff threshold, unconditionally merge back
> the
> secondary queue cna nodes, if available
>=20
> >2 no cna node of the same numa node found, unconditionally merge
> back
> the secondary queue cna nodes, if available
'scan' passes information from pre_scan to pass_lock.
The way I see its values is similar, but slightly different:

1 - pass to next cna node, which may not be in the same numa node. No
change to secondary queue.

2 - exceed intra node handoff threshold, unconditionally merge back
the secondary queue cna nodes, if available.

0 - pass to next cna node, which is in the same numa node. pre_scan found=
=20
that node, and no further changes to the secondary queue are necessary.

>2 pre_scan could not find cna node in the same numa node. Scan the main
queue from the point where pre_scan stopped, and pass the lock according
to the result of this scan.

>=20
> The code will be easier to read if symbolic names instead of just
> numbers.
I agree with that. I guess the challenge would be to find short enough symb=
ols
that would convey the meaning of various values. I will think about that.

Best regards,
-- Alex
