Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5250143961
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 10:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAUJV5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 04:21:57 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55252 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUJV4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jan 2020 04:21:56 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L9E2Nd002346;
        Tue, 21 Jan 2020 01:21:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=CkVkqiibTrCJEmMbwH90ExMxx4sj8KMak8v1xJVbOKo=;
 b=gvJoiS7YQSOCYZI2g8kMgNskqdZKGdX6j6KK60ckTr35oZBzRs8QhayWxTpfuDFVATnj
 iKdbfzJlL58jTNtHIM+XpOoZB/LS3m0LYZvFyD2pmZApC6TSJVIuX2l8paTDRvELzrYw
 moOQSHBc1yZKp8YZm1fr/HKP4ur2lPeUk69/o8RBpCpbZy5Wa6Vc+7j4l6BrMXp301BT
 EXKYHJPsxftU5QKvFGJvwXM/dXw+P3OJ8QWK/g6npseMtIlC8ufejvUbWUZqdZ8sXQ61
 4CJ4qgWJ6DrLMF1Z6AEJ/fYah9x/kXRF5qfG2xEdOeVB+Xjf6h+gDtSuNhD+25x1z9qC DQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2xm2dt19nb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 01:21:04 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jan
 2020 01:21:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 21 Jan 2020 01:21:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqMLNkvJzVsfXh1QdFiJBeUzPRbp+FvR2zd5FbGfYl/gwtNaD2iU4lNSyJw95szDlZK/LRG0HVdzcVT5vEidFh0TMuH/MVV7vTZh96j7Xb4YzRRaoAyGgFyiiRvRt2+9XugnUyO1/HgCDc8keCDjVN0GG9LBQqLC9L9LQ+nSRTnzosb4XCLuTfG493LTzMHb4ewNyU2+rQGrq4tVg+vncw+LPlF3HfY8unhj1VUaBzLHvMVTt9i0ahOnfUXxeD1YE/KM364FNjWPiG5TuTi+jau6Eq/1REWcl0i0ST6SF12isBhWkCOCgg+rsDUy9EGGi9zjvY8iaHNmGHI+AY2Rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkVkqiibTrCJEmMbwH90ExMxx4sj8KMak8v1xJVbOKo=;
 b=e7eC/gs2ZkaA/8iJk6mdRXoTtcoVHErNlWm2eijS94Q5dQn+x/FS76HASxryrY+mh+0iLMhpEaCvqR3ar/MZwEC5qUWUH1uleDi6MPJOspQb7up2t1Lay93PougaYAqZ6gLCs8jnKOj2k0naJhlJptaweJgrMhwRk0LhQnn0luamsvNmvYHPKuRATjKHLUlfbCQc7pAhRfNgm6+aYBio0RvYlUoelk87LVW1vrezjaQ3OJJCpE4rNkEeNpIy7GAnBtz3qIlg+jibejYKIXxa0mSDnu38Yco9EpYF7d91KgZG0gfogC8rZiZ3kO6TwQsWX+/kc8BiKWE0uIFKNQhNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkVkqiibTrCJEmMbwH90ExMxx4sj8KMak8v1xJVbOKo=;
 b=V268Isgg4S10sztiyt9Q1PaOCGjFE00oLnB/sGmHAaW7Ir0DuvPxjJkr3pmc8sEP9I/mwP05KVEr6er4FatA6XbOhWC7VSsoJ3IfzIQi+dS+fK+g3MhFvYKrDtASvpLkehiwiur6pOg6d8VcpID2r80XvlCNoqFRzHovdQkahGc=
Received: from MN2PR18MB3055.namprd18.prod.outlook.com (20.178.255.209) by
 MN2PR18MB3038.namprd18.prod.outlook.com (20.179.84.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 09:21:01 +0000
Received: from MN2PR18MB3055.namprd18.prod.outlook.com
 ([fe80::945a:2c80:884c:d564]) by MN2PR18MB3055.namprd18.prod.outlook.com
 ([fe80::945a:2c80:884c:d564%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 09:21:01 +0000
Received: from dc5-eodlnx05.marvell.com (199.233.59.128) by BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Tue, 21 Jan 2020 09:20:58 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Alex Kogan <alex.kogan@oracle.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "dave.dice@oracle.com" <dave.dice@oracle.com>
Subject: Re: [PATCH v8 0/5] Add NUMA-awareness to qspinlock
Thread-Topic: [PATCH v8 0/5] Add NUMA-awareness to qspinlock
Thread-Index: AQHVv0rh3+YZnTkYH0GBkMgywBMCw6fgoRCAgBRYbgA=
Date:   Tue, 21 Jan 2020 09:21:00 +0000
Message-ID: <20200121092034.GA18209@dc5-eodlnx05.marvell.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20200108050847.GA12944@dc5-eodlnx05.marvell.com>
In-Reply-To: <20200108050847.GA12944@dc5-eodlnx05.marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To MN2PR18MB3055.namprd18.prod.outlook.com
 (2603:10b6:208:ff::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a2612d9-7ec7-426e-8cd9-08d79e533adf
x-ms-traffictypediagnostic: MN2PR18MB3038:
x-microsoft-antispam-prvs: <MN2PR18MB3038BFE150CB3C447D99552DD90D0@MN2PR18MB3038.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(4326008)(8936002)(7416002)(5660300002)(1076003)(86362001)(16526019)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(966005)(956004)(478600001)(6666004)(71200400001)(81156014)(81166006)(52116002)(7696005)(316002)(110136005)(54906003)(33656002)(26005)(2906002)(186003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3038;H:MN2PR18MB3055.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJki6HftlgbWsq+SV35FaWWGucBFtzg9wMVS27gRNu8KPhF78EmOKXmXJtBYPpGn+amwSn0ZkEA/IxWgPmP1H5VHyc20V7khh/0/5C2u3QmOd57PV+hp/tFjU1B1UYRvJxm0Jim5JlpAab+P+m8PWDkejasVX6NahSULYyU2mn4gsHuQtpiQqIgBtIMKGrOKYQ/mr5dY6P31qoqjD+uAwnxzgxjx6RWsH9QGUx48yVV5l260fQVKgY6Ve7jNblvraHSNC86E0aQFSzNIVqTL058ImBWpaQ/qkz956wyP/fLaQ2On3BVi7lAQfI773l5m5X5XDVFWLlW64GTihba1riEmveXAwUVy6HeaKseGG/x72Ix71KmdUrt9dVbg0e+hk49tq6bxopZBqdXZLZfRbIzCP5xA5P5v0fkaxsNlYbGoE/+rmQKP3xKXH0om9giTTX5Onyz/Ai4nTT8XkDK/wd601zcQ9Y/KDrD/VK/garaEJ9+Low+mso1v+VdQW45CKNzuMdMEH056tymULihKew==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADD514F62B5A6C4680B5DD2D357797CB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2612d9-7ec7-426e-8cd9-08d79e533adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 09:21:00.7945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcmvheELWEHJ+rGIOqoz7swXhIuiQTvl4hlFSNfGi5CaHZ+twzWKOuYsDnIQob4DM+6x14NJMdvxdxdt8B9xbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3038
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-20,2020-01-21 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will/Catalin,

On Wed, Jan 08, 2020 at 05:09:05AM +0000, Shijith Thotton wrote:
> On Mon, Dec 30, 2019 at 02:40:37PM -0500, Alex Kogan wrote:
> > Minor changes from v7 based on feedback from Longman:
> > -----------------------------------------------------
> >=20
> > - Move __init functions from alternative.c to qspinlock_cna.h
> >=20
> > - Introduce enum for return values from cna_pre_scan(), for better
> > readability.
> >=20
> > - Add/revise a few comments to improve readability.
> >=20
> >=20
> > Summary
> > -------
> >=20
> > Lock throughput can be increased by handing a lock to a waiter on the
> > same NUMA node as the lock holder, provided care is taken to avoid
> > starvation of waiters on other NUMA nodes. This patch introduces CNA
> > (compact NUMA-aware lock) as the slow path for qspinlock. It is
> > enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
> >=20
> > CNA is a NUMA-aware version of the MCS lock. Spinning threads are
> > organized in two queues, a main queue for threads running on the same
> > node as the current lock holder, and a secondary queue for threads
> > running on other nodes. Threads store the ID of the node on which
> > they are running in their queue nodes. After acquiring the MCS lock and
> > before acquiring the spinlock, the lock holder scans the main queue
> > looking for a thread running on the same node (pre-scan). If found (cal=
l
> > it thread T), all threads in the main queue between the current lock
> > holder and T are moved to the end of the secondary queue.  If such T
> > is not found, we make another scan of the main queue after acquiring=20
> > the spinlock when unlocking the MCS lock (post-scan), starting at the
> > node where pre-scan stopped. If both scans fail to find such T, the
> > MCS lock is passed to the first thread in the secondary queue. If the
> > secondary queue is empty, the MCS lock is passed to the next thread in =
the
> > main queue. To avoid starvation of threads in the secondary queue, thos=
e
> > threads are moved back to the head of the main queue after a certain
> > number of intra-node lock hand-offs.
> >=20
> > More details are available at https://urldefense.proofpoint.com/v2/url?=
u=3Dhttps-3A__arxiv.org_abs_1810.05600&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtf=
Q&r=3DG9w4KsPaQLACBfGCL35PtiRH996yqJDxAZwrWegU2qQ&m=3DAoOLTQlgNjtdBvY_yWd6V=
iBXrVM6o2wqXOdFA4B_F2A&s=3DyUjG9gfi3BtLKDEjgki86h52GVXMvDQ6ZClMvoIG034&e=3D=
 .
> >=20
> > The series applies on top of v5.5.0-rc2, commit ea200dec51.
> > Performance numbers are available in previous revisions
> > of the series.
> >=20
> > Further comments are welcome and appreciated.
> >=20
> > Alex Kogan (5):
> >   locking/qspinlock: Rename mcs lock/unlock macros and make them more
> >     generic
> >   locking/qspinlock: Refactor the qspinlock slow path
> >   locking/qspinlock: Introduce CNA into the slow path of qspinlock
> >   locking/qspinlock: Introduce starvation avoidance into CNA
> >   locking/qspinlock: Introduce the shuffle reduction optimization into
> >     CNA
> >=20
> >  .../admin-guide/kernel-parameters.txt         |  18 +
> >  arch/arm/include/asm/mcs_spinlock.h           |   6 +-
> >  arch/x86/Kconfig                              |  20 +
> >  arch/x86/include/asm/qspinlock.h              |   4 +
> >  arch/x86/kernel/alternative.c                 |   4 +
> >  include/asm-generic/mcs_spinlock.h            |   4 +-
> >  kernel/locking/mcs_spinlock.h                 |  20 +-
> >  kernel/locking/qspinlock.c                    |  82 +++-
> >  kernel/locking/qspinlock_cna.h                | 400 ++++++++++++++++++
> >  kernel/locking/qspinlock_paravirt.h           |   2 +-
> >  10 files changed, 537 insertions(+), 23 deletions(-)
> >  create mode 100644 kernel/locking/qspinlock_cna.h
> >=20
> > --=20
> > 2.21.0 (Apple Git-122.2)
> >
>=20
> Tried out queued spinlock slowpath improvements on arm64 (ThunderX2) by
> hardwiring CNA APIs to queued_spin_lock_slowpath() and numbers are pretty
> good with the CNA changes.
>=20
> Speed-up on v5.5-rc4 kernel:
>=20
> will-it-scale/open1_threads:
> #thr    speed-up
> 1        1.00
> 2        0.97
> 4        0.98
> 8        1.02
> 16       0.95
> 32       1.63
> 64       1.70
> 128      2.09
> 224      2.16
>=20
> will-it-scale/lock2_threads:
> #thr    speed-up
> 1        0.98
> 2        0.99
> 4        0.90  =20
> 8        0.98
> 16       0.99
> 32       1.52
> 64       2.31
> 128      2.25  =20
> 224      2.04  =20
>=20
> #thr - number of threads
> speed-up - number with CNA patch / number with stock kernel
>=20
> Please share your thoughts on best way to enable this series on arm64.

Please comment if you got a chance to look at this.=20

Thanks,
Shijith
