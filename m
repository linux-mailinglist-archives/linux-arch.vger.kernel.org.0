Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A634CFD7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhC2MNf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 08:13:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37813 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhC2MNZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 08:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617020007; x=1648556007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YfHppGwxd+sx+33t45Wv6nH8o+9utQkwaMy6Im8wpvA=;
  b=r5iatSLZpmDG9LdpMHopEgWZPSZkdqwt6+kLiWXpN8n2ctOZcnA+b8cW
   J0JR8kZgh3KzFiQL1/NEUgRaAkGa6X6MYy1XilSwXcrr7dt18MOgtYWCG
   U2qevJBOYYEzPqeZuvjWyVcS73tFYeW1D4AFFCyIsNKV3J9pGoBZtdnzP
   kNA/Y7XEd5sXO99N8nZsug9v2pCLWxpr952Cokqmlhp344WKgDuvF3op1
   +W3BfJ86/5mAMZrm+kiK5RhyDsYUnfjNBf4oorYie8gymYYQ6ojAeht+5
   L+EJ6X+0X1SvVB3JCLRFP9ppH6J/efcBtFk3CylZYPGcsutp1ACLSRuRx
   g==;
IronPort-SDR: qWOUaitVt9R+WqD7QJqRHHfkaX2aOKIaJ+8TeGJAWYXTlEdkA67lO3MBAVqn+3xzrLkkU/rumz
 In8bIH67ZQBZPQokk959lT+Ttqv7a3+zQ4rU4Dh+OJhu+M3vZY93tkP57xBbaZzOMPKS7az12V
 B7m6krJY5kfaD9nLNbS6HG3cRWY/0/5Rry3rQAVcfeVmnSZW01qV8ddVozMTHH0on082rakCU/
 wldnszTNUPgsjcDBpuBGzE6BtZ4gdqBkrMR2tzwbVLzsDFXXcGmBZftECoflzhWHC/nMC2j8aw
 kHE=
X-IronPort-AV: E=Sophos;i="5.81,287,1610380800"; 
   d="scan'208";a="267681682"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2021 20:13:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4j28LLtWzlbxaQj7dz//dTH6kik0VRdrl/7bjqcKQhbAFZf9CRjjg2FEqy4i+sEZKu6yZl3Ac7jxn89vuBBap9Ee/0Jol04xOx9JYexB1la8jQcrWYNMKK+eB8DhzoBNyemngR3uhx1sVxyC3qqqwTZr/KbE9o2Bey0vxMWZn6/2OQxed2ARTY3GHyBLL4LrtGZOF7HoxbmI/aZmNAtsIcDVvvHOGEzhx/nrrf43MFOBkWEtznpsvOUuvZBYOylz+SYwzQSVlJcoGy9ZrXf1zLHMbF7S/kxfBQEcnqVdktWFHASIvoyZEHxoBvVT9Ldet+kNWD951tWmN5I8trVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMP/f7lmgrYAEtc00a5ctgUUyhn88HpZwo86EVPeIBw=;
 b=ZNNpj37TiN0Hujv2DIi66eOIrQL+UyFRv0qmSmgtiA0oibozRdfzMQXKa2Ke4IQI6OOtoxuhzIPUP2oPkxdNPd4PCQC7YqM4d1Cg5WddSs9HpR8xaVYaC/1kqe46WM/IHSITt+euQXPxr2T3UPqpA9HOL/5jrocqVNqDk8ZDwRTyat4/syHk4n+b8fr0kzwPXP5R+VO1YxRigHMD6MtHAYEDptS1j48BZRskdTZ2z4Sms5IDS/arwVXCjCsfQ0xAq/zbjrO3HdmjgbQzaysKBlvXlweSSO38JjOQ18YC/XnZ/nfa0pECurcwTtFUrV6WNHF4UYGlI1CaHw7VbWuWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMP/f7lmgrYAEtc00a5ctgUUyhn88HpZwo86EVPeIBw=;
 b=d3YqLPC9dKOx/RJMclOPL2aoa/146rLjWuUi0+O2b5WO5JUBv9q/8suOSGn5pe9mAW6yGmix6wsOWDEyzclQ7TcFaKV169CqBjcbhbvc8LJKr6BYkYXJ1zXlcMmAZl/swJVkCTHgia1hDEoPSplagDaZxoMuK/TdEqRgCbfnJ0E=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB1147.namprd04.prod.outlook.com (2603:10b6:3:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Mon, 29 Mar
 2021 12:13:10 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 12:13:10 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>
CC:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: RE: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Thread-Topic: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Thread-Index: AQHXIzQ13Qj+G1dtVUSTIu+6TgYVfKqamdaAgAA6hoCAAAIFgIAACjeQ
Date:   Mon, 29 Mar 2021 12:13:10 +0000
Message-ID: <DM6PR04MB6201B2774866802C268F7B628D7E9@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
In-Reply-To: <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [122.179.33.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f4e7b6d-ee6b-4611-a54e-08d8f2ac04f5
x-ms-traffictypediagnostic: DM5PR04MB1147:
x-microsoft-antispam-prvs: <DM5PR04MB1147254F7ACFA1EAE68406DA8D7E9@DM5PR04MB1147.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ss3BP39uaTzAR+OlwNcR62mHf1/ExGiFJtsNrVzFHRyCGBzdQs/rZVlJC3r02x747qHTQyV8lq7JB7kdqImaX0U+VSRmjK+JsDQX/jX7c9Ci6AJg+0rgtJXZcRxyJ+FoT7kX6VsDs04rTywsMPTiJijZKa+cqgFlnAdyvGy32mOuOpJXllA+DNTCTAqIDPm03glErJSXoo13+RYUIuTshzCdpj/qIc0Bc8bZb/9Jqhqt3Hib8E6H0lDSfzcgp7gzUXhAdGK9M+LBXPrEagxVU7ClUAtzQ0yLkErirsUSOupdhzxZZXtHzkjCYK6czRMkUI1iqdmxnxD+SPpgNHLLPrSX0m7ElPHQ9fTo3uYNQwe1H5srR3gE+rRrzNeyzLrSMzIUbDbbO177rzgdasRkfF8u2+YwC23+/nkpTSR16ZXpnE3cm0LHxEb546qK4loHiASeMuK8ralC99zgqK5xmGJsnP4WSBmRh4ooNzwQMBA3CgxJPhvLHghbdtYNgfDuKYP7mRtdlmu9FCNxZJonD7ttByi+XPz1AmslLGPH4U72o5ea4WtYacS3nUjcoM9BU7qmmctQTCMlg+WI7xdpBlgxCkfGuxgWmTh+nBsUbvc8zecrMDThbLJifqkQhfANeYgD98BRSrQJ2IhwUQP9xzHBV/+zs6Uzae0ZXzHi8Bk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(38100700001)(76116006)(54906003)(186003)(478600001)(110136005)(66476007)(9686003)(66946007)(2906002)(7416002)(4326008)(7696005)(55016002)(26005)(64756008)(66446008)(316002)(86362001)(8676002)(71200400001)(6506007)(53546011)(83380400001)(5660300002)(8936002)(52536014)(66556008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m7UBt+CPijG40GnoAviile1JqTbxlgAFcChorxin1NeENWzuWvlGDSzdWTAH?=
 =?us-ascii?Q?LF5NTNlM0WmnQ4sBEHGhfLr89U/wrh1OGVlkp3oekhV070KVQVgElSUgeBan?=
 =?us-ascii?Q?F1szyK51Dy+7WOjBsTXQExR8RgtcKH/UzrTD7NgowDpPuSGhxltW43LgRPQD?=
 =?us-ascii?Q?du84R7aWTN18PDHoYJ2r9jG0gN2agW/SndMUPY0zCLiJzcWmlttL8Izs+m1G?=
 =?us-ascii?Q?rfflkoXfixoyrtE8zKJ0si5mRQbSaTW7TMTGSBpIxm9t391jaOtQa7EYv6+m?=
 =?us-ascii?Q?ACYcS45Ornp6iuMwxo20De0EuYs2ov9r3YpMeB9t45YpEEtsJT8Z6JNxffnJ?=
 =?us-ascii?Q?xu03V7WrMlNOgQEOpUt0w5KmyYmoppZJRsP5DZUy3KpmeTDdgWeSc7PhVKc6?=
 =?us-ascii?Q?nHfVOXehOSEUjXUlNpFAVapaaDF2aBJiWQfcdOunJQxDtd2p5YGSHDUvTgvF?=
 =?us-ascii?Q?Rw87yq02HGyYni3gVaXVo+j/Eg1qsrXe7xmLFHEll9lv1QXsAajnpYNGhjHo?=
 =?us-ascii?Q?LodbV9uwR0CtD0Suoj7cQUrf0ydXhG6z6EmRJeQDWpIcTDEjJhsdnOLAzs/n?=
 =?us-ascii?Q?Bjzml6tI9/NCt5lv1gjEPUYUmbgNHJaL0+Z8RD+Ut/wtQIAsQVRD0EtR4SRm?=
 =?us-ascii?Q?fpXwnI1K7XsFJnuYdCIt9HzeZGoJSTrZgpbcyCGGYrvv7Ash00Evff8j7ayL?=
 =?us-ascii?Q?dt9C+yKATM0PZ61AAXscofxuY3LYP08BR8WKrFDTEPtmjxeubBtXik1XaV2/?=
 =?us-ascii?Q?gb0nhuLdVJJT0IIBoY7OexMmY5ezxMjNwtef3emLfsDnDaJSoBmY8xLPzCsz?=
 =?us-ascii?Q?39SWlYVMaqLkmneI+HtKpXx76FSWCD9khOTzNqQx0Exg3w/qaLDVuEjznwO3?=
 =?us-ascii?Q?W/BrssOVLkWtgQ/42vThr4R4eoGmXa0mElTl7C6a5Oz49WyzrzmRo8K9BVSD?=
 =?us-ascii?Q?GvrgUJteE1/2Kvj7DZPaW/QRzv4eiAYkOnnvEOSGTbQ4Mt3xcZg5Vxp9Gkrb?=
 =?us-ascii?Q?MmTzpJozxzdhLOKfHPILFvgvruRd/oVBodS9xc0ICFgopnrMCcgl+75vOw8D?=
 =?us-ascii?Q?3/QJPnUh6/KmzWl4SL0peaCPOa1+CZcTRJplJcfrjxl7Oxe900d/JjYPY6XI?=
 =?us-ascii?Q?U+zhlJWalxxVA7Rgdyeh1HGPZGlijN+KCOtJfwbMziidNlyUS/K5bhVLtHbv?=
 =?us-ascii?Q?u5qoL1p4ouhcaOZG7HDM036V5uMhFliqOKcHQ5b0bdZJfpiF2ePbEC0bk0fT?=
 =?us-ascii?Q?FKuq1G6r8NGLb94I5yqKBvQ2BcrSTHssOeaeUPcjsJ/iSf5KY3JKM+vGAwcf?=
 =?us-ascii?Q?C5xKKeXnMkibWPMvW/avB3kN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e7b6d-ee6b-4611-a54e-08d8f2ac04f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 12:13:10.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EkHioaiR+r9p+H52PQ1Rllc7Zd4x6C83sUqeDZgNtdsdT2yrRSqLwtOJJBOTnXIm7ERCjEPdO47ZzdrKPejxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1147
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: 29 March 2021 16:57
> To: Guo Ren <guoren@kernel.org>
> Cc: linux-riscv <linux-riscv@lists.infradead.org>; Linux Kernel Mailing L=
ist
> <linux-kernel@vger.kernel.org>; linux-csky@vger.kernel.org; linux-arch
> <linux-arch@vger.kernel.org>; Guo Ren <guoren@linux.alibaba.com>; Will
> Deacon <will@kernel.org>; Ingo Molnar <mingo@redhat.com>; Waiman
> Long <longman@redhat.com>; Arnd Bergmann <arnd@arndb.de>; Anup
> Patel <anup@brainfault.org>
> Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
> ARCH_USE_QUEUED_SPINLOCKS_XCHG32
>=20
> On Mon, Mar 29, 2021 at 07:19:29PM +0800, Guo Ren wrote:
> > On Mon, Mar 29, 2021 at 3:50 PM Peter Zijlstra <peterz@infradead.org>
> wrote:
> > >
> > > On Sat, Mar 27, 2021 at 06:06:38PM +0000, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Some architectures don't have sub-word swap atomic instruction,
> > > > they only have the full word's one.
> > > >
> > > > The sub-word swap only improve the performance when:
> > > > NR_CPUS < 16K
> > > >  *  0- 7: locked byte
> > > >  *     8: pending
> > > >  *  9-15: not used
> > > >  * 16-17: tail index
> > > >  * 18-31: tail cpu (+1)
> > > >
> > > > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> > > >
> > > > Please let architecture select xchg16/xchg32 to implement
> > > > xchg_tail.
> > >
> > > So I really don't like this, this pushes complexity into the generic
> > > code for something that's really not needed.
> > >
> > > Lots of RISC already implement sub-word atomics using word ll/sc.
> > > Obviously they're not sharing code like they should be :/ See for
> > > example arch/mips/kernel/cmpxchg.c.
> > I see, we've done two versions of this:
> >  - Using cmpxchg codes from MIPS by Michael
> >  - Re-write with assembly codes by Guo
> >
> > But using the full-word atomic xchg instructions implement xchg16 has
> > the semantic risk for atomic operations.
>=20
> What? -ENOPARSE
>=20
> > > Also, I really do think doing ticket locks first is a far more
> > > sensible step.
> > NACK by Anup
>=20
> Who's he when he's not sending NAKs ?

We had discussions in the RISC-V platforms group about this. Over there,
We had evaluated all spin lock approaches (ticket, qspinlock, etc) tried
in Linux till now. It was concluded in those discussions that eventually we
have to move to qspinlock (even if we moved to ticket spinlock temporarily)
because qspinlock avoids cache line bouncing. Also, moving to qspinlock
will be aligned with other major architectures supported in Linux (such as
x86, ARM64)

Some of the organizations working on high-end RISC-V systems (> 32
CPUs) are interested in having an optimized spinlock implementation
(just like other major architectures x86 and ARM64).

Based on above, Linux RISC-V should move to qspinlock.

Regards,
Anup
