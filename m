Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E1014901B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 22:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgAXV2f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 16:28:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50892 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAXV2f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 16:28:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OLDUX8030736;
        Fri, 24 Jan 2020 21:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=p5t6LkqqtkLbFaU0MqEIWNiNkEIpgv1igSF09fB8KrA=;
 b=VHKFEVeNqeHq17YMHhlyAcOE2zv81FJr4giioXRcXUw+UhejgDR8KPlrH5TXonuDgb1s
 14Baht/IkQtPfsr7o6zX4MyX42qVIGA3/1G333aHdYGrkbyohbhXuHEueUWLNjgX5Wqi
 WCPb8iyNq0fbsuYZVOF32EfOn7V/0w2f7lrImFDHhtnQlj/sgr5Yva+KD2+Q07OhA+Jl
 V6IDDUZz9kh43M89O5eriW01AWMTtg0L5ZKgr97edCkZCjpLA0lk+gb3b6AIHLiAasy4
 k2FKyd7ykREklycu6ZglxkRxn/AOINsWvMPuuCEHv5dTi5Fse2f8bMmDvYiq5cEB0EDX zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xksev3nbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 21:27:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OLE1Ca127966;
        Fri, 24 Jan 2020 21:27:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xr2yhvtpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 21:27:50 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00OLRaav016958;
        Fri, 24 Jan 2020 21:27:41 GMT
Received: from [192.168.0.159] (/173.76.205.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 13:27:35 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <edc53126-bfe4-5102-d2eb-2332bf3a68e5@redhat.com>
Date:   Fri, 24 Jan 2020 16:27:32 -0500
Cc:     Peter Zijlstra <peterz@infradead.org>, linux@armlinux.org.uk,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D39064BF-6EF3-4C13-B2D1-34C282A20F5E@oracle.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <45660873-731a-a810-8c57-1a5a19d266b4@redhat.com>
 <693E6287-E37C-4C5D-BE33-B3D813BE505D@oracle.com>
 <edc53126-bfe4-5102-d2eb-2332bf3a68e5@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240175
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 24, 2020, at 4:12 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 1/24/20 3:09 PM, Alex Kogan wrote:
>>>> We also probably do not want those =E2=80=9Cprioritized=E2=80=9D =
threads to disrupt
>>>> normal
>>>> CNA operation. E.g., if the main queue looks like T1_1, P2_1, T1_2,
>>>> =E2=80=A6, where
>>>> T1_x is a thread running on node 1 and P2_1 is a prioritized thread
>>>> running
>>>> on node 2, we want to pass the lock from T1_1 to P2_1 and then to =
T1_2
>>>> (rather than have P2_1 to scan for another thread on node 2).
>>>>=20
>>>> There is a way to achieve that =E2=80=94 when we pass the lock to =
P2_1,
>>>> we can set its numa node field to 1. This means that we need to
>>>> reset the numa
>>>> node field in cna_init_node(), but AFAICT this is relatively cheap.
>>>> The rest
>>>> of the CNA logic should not change.
>>>=20
>>> I won't recommend doing that. If the lock cacheline has been moved
>>> from node 1 to 2, I will say it is better to stick with node 2 =
rather
>>> than switching back to node 1. That will mean that the secondary
>>> queue may contain lock waiters from the same nodes, but they will
>>> eventually be flushed back to the primary queue.
>>>=20
>> That=E2=80=99s right, assuming we do not reset intra_node count when
>> transferring the
>> lock to a prioritized thread from another node. Otherwise, we may =
starve
>> waiters in the secondary queue.=20
>>=20
>> Still, that can make the lock even less fair to non-prioritized
>> threads. When
>> you flush the secondary queue, the preference may remain with the =
same
>> node. This will not happen in the current form of CNA, as we never =
get=20
>> threads from the preferred node in the secondary queue.
>=20
> That is true.
>=20
> However, it is no different from the current scheme that a waiter from
> another node may have to wait for 64k other waiters to go first before
> it has a chance to get it. Now that waiter can be from the same node =
as
> well.

The difference is that in the current form of CNA, the preferred node =
_will
change after 64k lock transitions. In the change you propose, this is no
longer the case. It may take another ~64k transitions for that to =
happen.
More generally, I think this makes the analysis of the lock behavior =
more
convoluted.

I think we should treat those prioritized threads as =E2=80=9Cwild=E2=80=9D=
 cards, passing the=20
lock through them, but keeping the preferred node intact. This will =
potentially
cost one extra lock migration, but will make reasoning about the lock
behavior easier.

Regards,
=E2=80=94 Alex=
