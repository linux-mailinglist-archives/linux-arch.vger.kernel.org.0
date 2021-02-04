Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE34A30F7E4
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 17:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbhBDQ3n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 11:29:43 -0500
Received: from mail-bn8nam12on2108.outbound.protection.outlook.com ([40.107.237.108]:9569
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238050AbhBDQ32 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 11:29:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0lToXelw53Oivxt/QQV0uoYSP+L9bpm/RMJJFQ6noTPRd3bYCMcCykqazPfXBtoqG/sa8js1X9zMRBpZ0oTCAkoJ/Bws3Qwde1XDB3k+TMWgodrGRGX76nrTQwrgRKD/KHNQ2wR77/Ir/YdJ4iKUfubfbFUrW23Pr7km9VyBpJ+pbfKlvWYJ1NkVVfZi8yvUibe75qLeI1AuzpibSjaY5flXO6GXpuXa6MA/TYwPD6bzGDBhwSRkxf7OLxzCnK0CokcvZAYEH0MtMYj3SM7GvuAoQ6vqiJvvGa+i1rKY2mz4nYTUP3BVzTfwvl1DRlQ9GTHgblEP7F19pV12N5xmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyZ+i8gYDe3pYFcO2I4hJRYIDLDTuJL86RF3j6KIRPI=;
 b=FpOmQjJheaNWtjE4nBwAglY89869aNrO3qOEgiXR8AoeTg98b4M+musigMwj8UsIZa/hCDGrv8YAD9L5rGQZRKyezijNJXl+nTrVC2NvGwSWvyGCjyQF3uDeDl8Ow54ygOaUpEAjOS3OwRR/voAn2b7sF6+W0wailYVu1h0TOpK1CoJirK53sFxNQNHajN0BgzgmZ/zsQ6lwyuyCJO38Nh5nnWJ11jHEHPaJcjujtf4Wpe3QdAwa0epIE4swLEXwZ7F7nLrrpqC80xgs1I9mUPVJSZwxCZGndg8H8JTkBJh4LeMXBj0n12K7SRa1ZwLyjiQUVh3wjtimV2f3JkWB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyZ+i8gYDe3pYFcO2I4hJRYIDLDTuJL86RF3j6KIRPI=;
 b=PdcNzSS6vxS1vnK0kDne1qADPM2x0C1Y2AqNDN6+x799R6QG4j84fUpoinmSJgPFEx8rfhSzxCMydNfCuyXfq3Slj5JeITsCjrM8sDVgI06R8owPRNnqWC0se1kvl91TBSmIUIctzKg99/MT3VinVL29p7MdyINt3gz5z2LkIdY=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0864.namprd21.prod.outlook.com (2603:10b6:300:77::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.4; Thu, 4 Feb 2021 16:28:38 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 16:28:38 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
Thread-Topic: [PATCH 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
Thread-Index: AQHW9OpqgPLe+5aabUmkUFr0v+Rt/KpDrbaAgASMiJA=
Date:   Thu, 4 Feb 2021 16:28:38 +0000
Message-ID: <MWHPR21MB159351D13368615E9E3A8C46D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-9-git-send-email-mikelley@microsoft.com>
 <20210201185513.or4eilecqhmxqjme@liuwe-devbox-debian-v2>
In-Reply-To: <20210201185513.or4eilecqhmxqjme@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T16:28:37Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fc0368e-bd80-4b6a-b5d6-94da634b09d2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97b2ad99-d956-4d61-bed8-08d8c929ed80
x-ms-traffictypediagnostic: MWHPR21MB0864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB08640580844D899F607708CFD7B39@MWHPR21MB0864.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNZDXX33QaXalReQUggMBvDr8cJtkvEeWClfiiV52wc6ERsUUmq6UyVivmY8+IR/yExIypyLV3TLQRHJcL4HC6Hugb03kFQrwE0ovHhrLdLfrT3il4DOTvg30MZzFojbBvB5W9P8RJVIcPqepo8w4/N++OlnIjLx6X5TV1JWq/xSpHKHVGsVDxkQdZC4yHNOZWU+UcwfubLy78y/w3CfD7WF13Q92B7uvkvitNF8H7xNDoRzs+q40s6aiMYR4I1457XQM9u8vGeavKLBy60VIBTYbeIrGjaRSDyTpGzLxIH2YVznkdPTvRNgy6d8IiPAa9Z0jgKtPtOs4w8CBxLIpSeLJQHJBCQg1ITc2TLKX9SrhyTXxQxSt7q98otoXhCnOIPdVKJbV4I8Rh7I7FdWDMtlTL74oSFc8KY8/stB99OrtTImSrQf63tg8sD29SlTrigD1Bmc8CpPjjvB7Sr3cI8tpHoUQVyj3f9aEIx5j6eudNz472uo2x2KWB//ZSU1upVnV+DTniF6r5lu/1DrGlAID+AAuny9wZoZ3wlxGdp3tpVA2MYtE5EfWSKgJJIxPaqXiQ81wj/wJBwvThe+B8NPqIbyLKqj290GzsufCIY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(6916009)(10290500003)(8676002)(86362001)(33656002)(7416002)(54906003)(52536014)(82950400001)(82960400001)(83380400001)(966005)(5660300002)(66446008)(66556008)(7696005)(64756008)(66476007)(66946007)(76116006)(55016002)(26005)(6506007)(8936002)(186003)(478600001)(9686003)(2906002)(71200400001)(316002)(4326008)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0s1pTdDncXvkcPKiF99XJxaI524M2DbNq5SV7YJy4xhbSjbyhkB6ZpqztQU1?=
 =?us-ascii?Q?ZmRkvYZmdXESiM1SeWr6nYoPT5T5A7F+YMWtE8Du8Y687sg0XYOHVpBRnDOn?=
 =?us-ascii?Q?BGoJ8rkklwCgdzqNlgxbh4CZfU7XVNm7DoP38o7qHUR1WMIEvgyPDt65NT2Q?=
 =?us-ascii?Q?VAxL0IWIYnb8h84I4VnPCgYFkw8AawjtaaNXlDyU121VBV4L1ceMtvu6KWMS?=
 =?us-ascii?Q?nueorMD2/1o3Kpdg9VaO4wZ3n0hTRxs/B+sc1OZNGTbHEA1iZUuK6bmG83Q3?=
 =?us-ascii?Q?+zFFt0RDJez0fyVLNv2ZwgeK2466eTpucjtCSTvF0Hae16q2+qirGelAM0vR?=
 =?us-ascii?Q?b81u+gPxLfRyrxg/N7vS7ZeqPN1n009U8PumVT3XkbCVS80qtEB29j1wUG5f?=
 =?us-ascii?Q?00MrX7h6d1cCHDivqk1AwQYxYjXk8PUeNPxK+n9OfDRHQy0MFQp9tdF1d+Rq?=
 =?us-ascii?Q?DEpCgKb2vJEn8GBMQbUu7FPI/fAzU/R7n5tviY21NOEadhdjecPueeOdQ1WB?=
 =?us-ascii?Q?iJsEAdfGLOs4zue39xctTQq3nodZkHzbgubXSzodtj6iw9z1rB/Bs2e0asZT?=
 =?us-ascii?Q?tSaNy8gKLu9scjemEo5FJG1d+DJtB9JSvyjepsLGm1dxLaNcNpijJU/jfor0?=
 =?us-ascii?Q?Grz+iIrXEPd9CJqav7ak3JPdbnIdBt6PUdbOf1K/I6cjNwFpfAhxMRNIIFWm?=
 =?us-ascii?Q?j2E13FRqqm06PIprF4RBNqXwGqtsrOrGPD1bh3/IOMNGcLrgwZOzzZD/0YMQ?=
 =?us-ascii?Q?pStI1cBz290sl51DoHrXrSCylduX35MrcTaiVXd09ut4gxfAedXifWlmYa2Q?=
 =?us-ascii?Q?AxgsgmLHBo1gVxAXyvydnUe8/NPK0iq7lDsf0gzVQ5DSTonkxWzSP3yTI/Fx?=
 =?us-ascii?Q?s8ZIqysd41upPA56gYBLsB8q2c9aND+dmp+HN89kWW8z1xDb0o1Od/YqXNip?=
 =?us-ascii?Q?Ok39PDtZATiEuH/XegAgZ0tfZ1HHnNazrvuWao0HtIclME8kwqYh+6DXC1FE?=
 =?us-ascii?Q?Pls/isHC1lW6Hy+P0lnRHjLCWIFrrqGSeOOS97Ed0kVbH83u6Ng3tSo6NCok?=
 =?us-ascii?Q?RTpVokK8kVBbjgduY8376URwlhGa3CGdrYBmCEkTITPPDukQop3GBPkGAdhB?=
 =?us-ascii?Q?hwlZo53cqono8ERVEg+/I0SSiisaj52XBO1vd/d1jhTPe2q+Qk+IhKEyyLCb?=
 =?us-ascii?Q?YJXKcqoAbDimGx0mgEld+DbTTVAYlxJxLrshyWXYPlrbQh6FCJQOfgB3ALm0?=
 =?us-ascii?Q?0Qln5Ak8siTHI28OKGY3BWjq0V5dlxHpV0QzIj5pdE34y2bwJdE77VWY2/j6?=
 =?us-ascii?Q?rxE6HeswbT6yvMmmnn+6Z4G7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b2ad99-d956-4d61-bed8-08d8c929ed80
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:28:38.6576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYLpigNhlnzn3OerwEWz1NMiA0NynLvx5hUIEKD8Eqw71Bic8fo+VlAUEMv7IqXXMm1R1gPZRnrZQztDo5LtC16u37M9OrYKo5dsDx/4t7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0864
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Monday, February 1, 2021 10:55 AM
>=20
> On Wed, Jan 27, 2021 at 12:23:43PM -0800, Michael Kelley wrote:
> [...]
> > +/*
> > + * Reference to pv_ops must be inline so objtool
> > + * detection of noinstr violations can work correctly.
> > + */
> > +static __always_inline void hv_setup_sched_clock(void *sched_clock)
>=20
> sched_clock_register is not trivial. Having __always_inline here is
> going to make the compiled object bloated.
>=20
> Given this is a static function, I don't think we need to specify any
> inline keyword. The compiler should be able to determine whether this
> function should be inlined all by itself.
>=20
> Wei.

There was an explicit request from Peter Zijlstra and Thomas Gleixner
to force it inline.  See https://lore.kernel.org/patchwork/patch/1283635/ a=
nd
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/a=
rch/x86/include/asm/mshyperv.h?id=3Db9d8cf2eb3ceecdee3434b87763492aee9e2884=
5

Michael

>=20
> > +{
> > +#ifdef CONFIG_GENERIC_SCHED_CLOCK
> > +	/*
> > +	 * We're on an architecture with generic sched clock (not x86/x64).
> > +	 * The Hyper-V sched clock read function returns nanoseconds, not
> > +	 * the normal 100ns units of the Hyper-V synthetic clock.
> > +	 */
> > +	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
> > +#else
> > +#ifdef CONFIG_PARAVIRT
> > +	/* We're on x86/x64 *and* using PV ops */
> > +	pv_ops.time.sched_clock =3D sched_clock;
> > +#endif
> > +#endif
> > +}
> > +
> >  static bool __init hv_init_tsc_clocksource(void)
> >  {
> >  	u64		tsc_msr;
> > --
> > 1.8.3.1
> >
