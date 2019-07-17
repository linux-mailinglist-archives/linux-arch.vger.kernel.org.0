Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0F6BE91
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfGQOxQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 10:53:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44966 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQOxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 10:53:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEmdQ3110195;
        Wed, 17 Jul 2019 14:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=oYmVwQZsFGYE+fNPNwS0IyHacSBrbfGDnnN6IW7+sSk=;
 b=TCNdZJ8spckOV4ug0H4HDz36K7JhhHdTjU8WS0DnoVxYtq4O3ygJW3vwC7IrFK5ymtx4
 wnjcx7Jrs/lkEljefng81SgJmi+Jcc68W59iINHmfsKICKo5Q7vCfZqWE1MayuxM7oKQ
 xdl3WSaQ3X7egm5jm/1DwClGsZq/GVBl9vxxf037FToUyVKVJKji1M6hn8xOq22cTCSc
 pW/xXj2uY1INJdf7LLrlU46lo7E93dWkUAcgqxCq7op3T9bcUAWOnrzR3cqthsPn7fwM
 coq58UrQXOipTqtxJyVAFGs5alZei1qMpTqYNKZ0DejVwFzZUZ03zfiS1XfAi8+IlWzT 1w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xr3a2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:52:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEmS58133702;
        Wed, 17 Jul 2019 14:52:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tsmccf86f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:52:13 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6HEqAML025928;
        Wed, 17 Jul 2019 14:52:10 GMT
Received: from [192.168.0.21] (/209.6.165.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 14:52:09 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190717085900.GS3463@hirez.programming.kicks-ass.net>
Date:   Wed, 17 Jul 2019 10:52:05 -0400
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <57614CAF-AF4C-4814-A628-2D30B399C117@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
 <20190716184724.GH3402@hirez.programming.kicks-ass.net>
 <20190717083944.GR3463@hirez.programming.kicks-ass.net>
 <20190717085900.GS3463@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=784
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=836 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170174
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Jul 17, 2019, at 4:59 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Jul 17, 2019 at 10:39:44AM +0200, Peter Zijlstra wrote:
>> On Tue, Jul 16, 2019 at 08:47:24PM +0200, Peter Zijlstra wrote:
>=20
>>> My primary concern was readability; I find the above suggestion much
>>> more readable. Maybe it can be written differently; you'll have to =
play
>>> around a bit.
>>=20
>> static void cna_splice_tail(struct cna_node *cn, struct cna_node =
*head, struct cna_node *tail)
>> {
>> 	struct cna_node *list;
>>=20
>> 	/* remove [head,tail] */
>> 	WRITE_ONCE(cn->mcs.next, tail->mcs.next);
>> 	tail->mcs.next =3D NULL;
>>=20
>> 	/* stick [head,tail] on the secondary list tail */
>> 	if (cn->mcs.locked <=3D 1) {
>> 		/* create secondary list */
>> 		head->tail =3D tail;
>> 		cn->mcs.locked =3D head->encoded_tail;
>> 	} else {
>> 		/* add to tail */
>> 		list =3D (struct cna_node *)decode_tail(cn->mcs.locked);
>> 		list->tail->next =3D head;
>> 		list->tail =3D tail;
>> 	}
>> }
>>=20
>> static struct cna_node *cna_find_next(struct mcs_spinlock *node)
>> {
>> 	struct cna_node *cni, *cn =3D (struct cna_node *)node;
>> 	struct cna_node *head, *tail =3D NULL;
>>=20
>> 	/* find any next lock from 'our' node */
>> 	for (head =3D cni =3D (struct cna_node =
*)READ_ONCE(cn->mcs.next);
>> 	     cni && cni->node !=3D cn->node;
>> 	     tail =3D cni, cni =3D (struct cna_node =
*)READ_ONCE(cni->mcs.next))
>> 		;
>=20
> I think we can do away with those READ_ONCE()s, at this point those
> pointers should be stable. But please double check.

I think we can get rid of WRITE_ONCE above and the first READ_ONCE, as =
the=20
=E2=80=9Cfirst=E2=80=9D next pointer (in the node of the current lock =
holder) is stable at this
point, and is not read / written concurrently. We do need the second =
READ_ONCE
as we traverse the list and can come across a next pointer being =
changed.

=E2=80=94 Alex

>=20
>> 	/* when found, splice any skipped locks onto the secondary list =
*/
>> 	if (cni && tail)
>> 		cna_splice_tail(cn, head, tail);
>>=20
>> 	return cni;
>> }
>>=20
>> How's that?

