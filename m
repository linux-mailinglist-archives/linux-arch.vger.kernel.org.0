Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8232B49A
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhCCFNT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:13:19 -0500
Received: from mail-mw2nam10on2128.outbound.protection.outlook.com ([40.107.94.128]:22490
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379612AbhCBBaD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 20:30:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe8Nz7L2rBqzfNu7V/DRVU/M5eLWt4BANdzEdRAya2T5i5p05SK0HKeZBCNz27LOH5C3Wi0dsc1TX24DyZytKM9hdXpkW5pEqTS1QHCVF9CU/Pq2O90THqSxelDGP7epeYd6NvEhkNc4iSy8ED2Ox9riVn5siNRBTx90tnqfCK123OF2Z1intzusn1XarUnz2yMczIhw+JYBkd2lFQiQbo+rzZdlcWvnIZX9DSG0aQ4KjR7undyvw86Vg0q6xuu3TpDsSdLiZzF7GhAse7Hgms8uy7ug6RoN27B1dTRiLYnD4fl/fX5cUWHd9OYHCJx6yrzXqZD5ldfyagHeLrjmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGNEoNMf17IMj+F5XqN76c9SWFaElWx3yjegMp/t2B4=;
 b=MDxYZqzL9aXpIFVvqq+Qz470ScKeASLWLquCKgCV9uANtZatr6CYWnqhQVD9fVDJEbdeK+fzd/2D8W+Z8cmEzDBfQgI4nJnapg8EbJx+CkmjTUOVX8QBTnM2qy6++60/TTOiUwl26MKgZknxmCcckUPwtNd+u4Cb3GnoWQ98Q8xEptRO5mjD0M7Qh4/Yja/spSvHPywV09K5kGSt7Uar+ezB+O6rfQXFGadOL9Utk50aR3nWZx1N+XuqVd8i0xr4c3fMjlLunHxF1YXmo5P8HmAQWSKA3SDP6yjfEQtbDqlkssmTkKYFjtXFXSC4C14gsSdcuy6NdVYY3N+FuS70Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGNEoNMf17IMj+F5XqN76c9SWFaElWx3yjegMp/t2B4=;
 b=Wtg/1KwjFJxf/w2BCyKWdABO1gauqjHYycy6gCPNOGzjHHWXfO1ZmYwZ3wDSwTc7j/YhZP8nkaJPK0hJ/N3+0Y/ax4PQKWQyvKQfLOyHG+PHtjMGNujV/D6Smv5wbaYqDLjcN8vhds74IgQCZcHlCutP3r+v3ATawh1eXSaY6VY=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1788.namprd21.prod.outlook.com (2603:10b6:302:b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.7; Tue, 2 Mar
 2021 01:29:10 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 01:29:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
Thread-Topic: [PATCH v2 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
Thread-Index: AQHXDjh1EVCQ9KI360KRzkAsBhzaBqpvDm2AgADWwPA=
Date:   Tue, 2 Mar 2021 01:29:10 +0000
Message-ID: <MWHPR21MB15930DD833E49415610C021DD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-8-git-send-email-mikelley@microsoft.com>
 <42dc252a-b09a-afeb-6792-9b77669c16e9@linaro.org>
In-Reply-To: <42dc252a-b09a-afeb-6792-9b77669c16e9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-02T01:29:08Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bcb391f3-f8fb-4508-99fb-3f8bd7baed53;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13f7cb7f-71ba-4da7-beb6-08d8dd1a9475
x-ms-traffictypediagnostic: MW2PR2101MB1788:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB17883C7286FE58161B47519AD7999@MW2PR2101MB1788.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AgpkdNKKQ7rQmBXdIHEsnH6X1PUEHkBRZTlmPZLKMwfMW8+Ptp3Ko+uIKq1IF6aA802UbEzDOsbIpCL9zGb8SqmSA/5w1iZBY82ubGe/yG7S24YgPZaFAH+y7hv2wrb8svw0SZJ/U6R7xuH0sYqYnYnzTMk3+g/P98gGgEa7QVDLNlgMuscp9xRS3au+mgUddEEeoDHv81kGNxSP57avJRTan+zn/2ljt6TAYqUb5yomXXMp2+iKFYjjnPFEgIkEzMHrEciufMf8LFasWvp1OGABXM6dK7D6ThsmlpZP0YatPSYvlJr0AKLQ/vU3OOQodzr8bQMMQf3yWcgTI8nAOH3Kssw1peFnGKB1KEQhA+VxSHtLUSI6hVE2GJ8486JZrhYVU5+zrjrAhHSuo0prFtAFtSGSjaA3Xz/ACiLMfrlxfWFC4mUNfyJhGwmWFb6gp6soDaz+s959JXai7zqdk/b5YFGAbEgLkcv41a2Q1ILcDfxqS8f+9OGfgBijvOWde9cs8/8R0FgM6RHzt06t1p2F/3QYBtjSw8MICfXrh7Q+qqbvxvngukAJCT/w6SHC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(54906003)(55016002)(66946007)(76116006)(921005)(86362001)(52536014)(4326008)(110136005)(316002)(8676002)(66446008)(9686003)(66556008)(66476007)(8936002)(64756008)(478600001)(2906002)(10290500003)(6506007)(53546011)(8990500004)(82950400001)(7416002)(83380400001)(71200400001)(26005)(186003)(33656002)(82960400001)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0mY2qq0nBBWCfLUoCeL+rdFYBNdDb5F4ppCHOAcGNouwQtrZ7AwFgK7RdZvD?=
 =?us-ascii?Q?t6Q0ckzPjGL3sN4n3jkZd/IdIz/ufu9imHzOAObZSxo5b9rTZEPJSYTiV8UB?=
 =?us-ascii?Q?G+hW0oZ/vx4NBSpBPBF6D/4T+6lgwbbVRYYar6JEjf/BXYP2FG79n74oR/Ra?=
 =?us-ascii?Q?9BAuoI1OO3p3INwW6oYdHGf3WUY2Y6LPB8HXwiQcxEzSi3WI2CRdNCLop7HR?=
 =?us-ascii?Q?4IeBUwhOcsw1YroM5naj18gQ0VTEkEDoGQVFhgPhOaYqTrIQpeLYXUq3UIp7?=
 =?us-ascii?Q?QxPOsFUFdIOsu28sZNeXTq7OooXm+wW64FAYrw7JRbDTuPuam7PcLJoPX6Cw?=
 =?us-ascii?Q?qhl6pn3Nrd6C7PyIZZZg2O0RaOngr5uI2IkTmDj3kRvxAMFQlAgX1GNhgEdK?=
 =?us-ascii?Q?Cb2xeQI57Y9c6zzeXnklavYpVcwsYJP9yBYMTo3crub/+Eg1GIx9tf3WlZzf?=
 =?us-ascii?Q?EbPkSImTch9pPWjj47WL5lQgKANd6RjRkyCAEzZnVIw+MRgMuVekdV0Wpf5X?=
 =?us-ascii?Q?N2HRcI6TAFPMXmLgt+LP1S6H6W5vrj0A6p9ujob+/1BjgbPArkAvpjY1ghvC?=
 =?us-ascii?Q?nRWLshjSuaNeJNVCzsgZl8BNRKE9jK79BAq7EKCHx7w2U8x6l9tRQP2Zpdgu?=
 =?us-ascii?Q?Lk1Q4tlhk2Vq8qVSFW0DSU6Joj2VlsVX+bJBdbN4XOKTIzJ8ctf/IrWR7TsR?=
 =?us-ascii?Q?qha9h27NuUrC5RSn7vECe9mkJyperkjdLz2ye6m0LGH56m/VSL3FHi/iiToQ?=
 =?us-ascii?Q?OfWDdNGGlsP5hvAxQP40Cmv7EsMY5WZmJGfhkuwCjEu8GIyp1OMmze2jYYQn?=
 =?us-ascii?Q?0hI7kcyp/Ryt2wszwNf220t9GBFfsF3m0+Pi91VgzxRqWPvIGY8+EyxaRyXu?=
 =?us-ascii?Q?yiD9NIkB/sVGeautN+mLpBiLncz7g4g1EBUOSFkE3fGy3ifV45sPo6ibByvO?=
 =?us-ascii?Q?FTZ5+1Wqisph4guXTJv9L6UJkkRn4MhpRsffftCpGo6juEorRkxjnsrR0cM9?=
 =?us-ascii?Q?juF4JdVH7HsXuSnyVamgz5lG2mZ9O5LRlLgt67hAkBWpE/QPH2HVkSk7l/2w?=
 =?us-ascii?Q?fu7s0PfmYR4m7AlIFXlPC+va5VfcK7cKmlQt09bzHs9Ki6XhdLunYldSxll9?=
 =?us-ascii?Q?wReuwhdvzLsTbeKeqC7ZgXbfUWWUjC0q59Jv0u6Obalr08i/LaSbW2bNFYxK?=
 =?us-ascii?Q?ICCpEEdiap+TadvnKACGZ0bfF/l8FE7xT5dI0WKf1P8qTw6CGzPcwew4aFa/?=
 =?us-ascii?Q?g3AAPrSxfnX+jfvcDv6l/ILgBSpnWVHMhlnwKuLGT/7OsHFYyM8B5wmMcc18?=
 =?us-ascii?Q?6zHDfgmcEpMHVXPLQq02PbKX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f7cb7f-71ba-4da7-beb6-08d8dd1a9475
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 01:29:10.1878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjvnMU1LxH0lo4asOHGI4yiuiRg0wwqIbnZlCyF8QimuihVjIcQfGSufQE8f1T82OIy40wL4RDwmG1vKG00x+YrpGkcj14regobOckYeKKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1788
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, March 1, 202=
1 4:22 AM
>=20
> On 01/03/2021 02:15, Michael Kelley wrote:
> > While the driver for the Hyper-V Reference TSC and STIMERs is architect=
ure
> > neutral, vDSO is implemented for x86/x64, but not for ARM64.  Current c=
ode
> > calls into utility functions under arch/x86 (and coming, under arch/arm=
64)
> > to handle the difference.
> >
> > Change this approach to handle the difference inline based on whether
> > VDSO_CLOCK_MODE_HVCLOCK is present.  The new approach removes code unde=
r
> > arch/* since the difference is tied more to the specifics of the Linux
> > implementation than to the architecture.
> >
> > No functional change.
>=20
> A suggestion below
>=20
>=20
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  arch/x86/include/asm/mshyperv.h    |  4 ----
> >  drivers/clocksource/hyperv_timer.c | 10 ++++++++--
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/h=
yperv_timer.c
> > index c73c127..5e5e08aa 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -372,7 +372,9 @@ static void resume_hv_clock_tsc(struct clocksource =
*arg)
> >
> >  static int hv_cs_enable(struct clocksource *cs)
>=20
> static __maybe_unused int hv_cs_enable(struct clocksource *cs)
>=20
> >  {
> > -	hv_enable_vdso_clocksource();
> > +#ifdef VDSO_CLOCKMODE_HVCLOCK
> > +	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> > +#endif
> >  	return 0;
> >  }
> >
> > @@ -385,6 +387,11 @@ static int hv_cs_enable(struct clocksource *cs)
> >  	.suspend=3D suspend_hv_clock_tsc,
> >  	.resume	=3D resume_hv_clock_tsc,
> >  	.enable =3D hv_cs_enable,
> > +#ifdef VDSO_CLOCKMODE_HVCLOCK
> > +	.vdso_clock_mode =3D VDSO_CLOCKMODE_HVCLOCK,
> > +#else
> > +	.vdso_clock_mode =3D VDSO_CLOCKMODE_NONE,
> > +#endif
>=20
> #ifdef VDSO_CLOCKMODE_HVCLOCK
> 	.enable =3D hv_cs_enable,
> 	.vdso_clock_mode =3D VDSO_CLOCKMODE_HVCLOCK,
> #else
> 	.vdso_clock_mode =3D VDSO_CLOCKMODE_NONE,
> #endif
>=20

Is there any particular benefit (that I might not be recognizing)
to having the .enable function be NULL vs. a function that
does nothing?  I can see the handful of places where the
.enable function is invoked, and there doesn't seem to be
much difference.

In any case, I have no problem with making the change in
a v3 of the patch set.

Michael


