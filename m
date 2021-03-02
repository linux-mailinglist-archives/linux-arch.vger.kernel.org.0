Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7332B49C
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhCCFWl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:22:41 -0500
Received: from mail-mw2nam12on2094.outbound.protection.outlook.com ([40.107.244.94]:6337
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236036AbhCBBjr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 20:39:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcbVBCPEyQjDrYi/gDqnjlAcT/+iyEVlJo673X+U6fpiJFP5d3ATaZ48d43vvXbLJn5HAsE8juUgHJT3fAvzsnyAsfP0LGfuK4O0nfJQ+wiexpJxVYJ4Wkz+eUjXGPvygMsAyOIZ6mUk1r6hTZpi8qprDAfQtbQOOlBVwb78Lutv4k0is7QhGsTNZar5+vDrFDfi1e0FmuCmnvYGbJSMlhaZeuPSVzghYaZkgZ65FTAsw+EuUXA5pdbqNeAUSt6K32PlVsc4w+hTEdED6Ts4Ev5ODpruzN/1pkBXsZ1AiAlZ0KTzmcyktzKhPuXVmtvZ7E8KjoGaiNJm6YezoyE56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ouh/jIV9+fCuPko4Fcse61c7D73awdIxLNZQQCqRS/Q=;
 b=a5+BHYF106TXrJmIDmg686atfD9tSDFaMV2xlOD+ZtNH/KcUAX7CYG6C+ZzPTkY6TIUP0ju4O+GfOlvR7Dv80ZF67m8qD32mcQngJlIMvXoqnHmmgT5oQIKog1OkIwBNc0WvT5/nPOHYkxIwmLcZ5PZ1nlOs61aqGeL/a1mmUxP89jEe2lVyvbiQJhQ5E8ywhEZ2UaHOPvXbmO3Auh1RFhRM4ENC51V3CwmOaGaqrF6opJYBw4lfzdlVBnHQsniaWTCHsXJ1Fl8bHgZZs37Z0EU/N+/44UYVS5nj2rsrqscZzS/tQwDOLHjSgQR9Njxv5bJo6wqjs6sqqIn032w0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ouh/jIV9+fCuPko4Fcse61c7D73awdIxLNZQQCqRS/Q=;
 b=LRsSY8fS4SQ/TZvhwUEdHMitr79Iq9lt5gQyViwcrjijEZx4JmL9PCoMJ61uQwKE7uvWq8KGgCWbOGUkbPnBufP5kakZIErMYjmQpFxOUS6h5hZo5WxuE3Tm2sQheIMrRxvRQVtVgs5C7ABQ08AVZeqiqb43DZfePht6WEJfZTA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB1579.namprd21.prod.outlook.com (2603:10b6:301:81::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.2; Tue, 2 Mar
 2021 01:38:54 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 01:38:54 +0000
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
Subject: RE: [PATCH v2 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
Thread-Topic: [PATCH v2 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
Thread-Index: AQHXDjh2nVtLmMK3yUSmceNflzLv9apvMQAAgAC5eiA=
Date:   Tue, 2 Mar 2021 01:38:54 +0000
Message-ID: <MWHPR21MB1593812919AF130E61C2A1CFD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-9-git-send-email-mikelley@microsoft.com>
 <2c320759-4e0e-752f-f3e8-7594cc1d544f@linaro.org>
In-Reply-To: <2c320759-4e0e-752f-f3e8-7594cc1d544f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-02T01:38:52Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7b4bcf66-1025-4e1a-afe2-4f52acee06d8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9033cf95-3561-469d-99ee-08d8dd1bf0a8
x-ms-traffictypediagnostic: MWHPR21MB1579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB1579E2CC9F82E5CB542696DED7999@MWHPR21MB1579.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7ZgHknujzv00THDM63ALWBlvoVbgZOrjptobmlkXzy5gPORfVvbmf6qHAUjP7F4Cupa8QIghDKrMXN32tDZFw44adKe1Km6rX4cbgh2RvFHNfbHEM6TYFD6RkoL9jsWbA4X8ZiDIDwcSeZd752aPzJVdrkS1QJgDVPy7og7CNBKtPghTRVdXTOSFr3jM2XYwmVpB+X+iO+Y2wVyeWX5De+tmeaAz07g8R2gy9zYHG8gDfEAkw7lPvtxH2Ns4mEb6EoGbT5cfPr1QYudWiC02DyTOcnYcPag0fJuIkO2R7AsUp1wG8RwTULdoGfcoDpdHe0Bno5rXU7ugFBooeaKTDfHtFkTgDTQlw51zTM6y0tRFRc94CJ0TOytuKoD0dwHoLhZMrwOOE/mH1f+cKlCMb1MOmXJFZ997owrSPx3zeBTBILxtDxRJNX1sN1pmO/TNCHsyosrTw0fy2EWgkvjqxvlKazEa3awqh9py8G4ChymNMOdw2xbs0kh/Y4Wrz+FinUf6wBNuzgJOI/sp1wH9zRYDf/mUw9Ch2orM7WJKwha6oMph9vcwz1+o9p44jd+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(82960400001)(7416002)(64756008)(316002)(83380400001)(478600001)(66446008)(52536014)(8936002)(6506007)(26005)(5660300002)(33656002)(76116006)(71200400001)(921005)(66476007)(66556008)(2906002)(7696005)(8676002)(54906003)(9686003)(110136005)(53546011)(8990500004)(55016002)(10290500003)(66946007)(86362001)(82950400001)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0qgK5vKYBNnWHokuMLwJmT5G1kswGyHnQ0wuEZev/dPQcHI+7dDJHENfeqsd?=
 =?us-ascii?Q?tGILzWwaWZF3l0iaV0aZsV4kvsYGuHYF4+OdrZxFHKykZrPDvAzAOn1oOoWl?=
 =?us-ascii?Q?6m1MyF2fVdNZaEz/NC2ib/p0/cFvy+ClNr16z+8/RUcVVJIvTnS8b09vst1J?=
 =?us-ascii?Q?eFgL6b6CIOJwWl8m6Xxo7yyKJY3H0mj9O8uk4KaT2Sf0PDuLvj8EDMiFPFpj?=
 =?us-ascii?Q?1anu2KcLGrPOcuid5kSgJBTO8ahyQ+t24SDPpYw2nQPkMrspk8WYHKhPTxkz?=
 =?us-ascii?Q?TzQV1kEzpTc35aBxRDqLulgJcOnOw/3Qdc7febN18/hC9vqgwsTwt8EnQfhg?=
 =?us-ascii?Q?lM9X0h/GaR7Of0zzPzvEZREy7fOUut3aXTg9u34jzUBR/ics47sXhllNMYl3?=
 =?us-ascii?Q?VeZmv9E3q1TUEJA9QfUEFuo9RnbrXrznfQ08eB4li1JABgy4uHNJwhXal1J6?=
 =?us-ascii?Q?Z4oXJDmyoLfr7nTtZr4lPedaaCkzIbJNPSWyqZwhtkHQH0AQ66CB1BzehKdz?=
 =?us-ascii?Q?EwGQieMQxyyPgVo/We8L6q3aa45B1UnXIOm/7wgnQJuKnrrzRg95v0IdjPmx?=
 =?us-ascii?Q?XdGb08hKeMwfzgqN5l10WI1pJQInemzrmyYhcpTtLVA/vIeoF8p0+Wq5sk0i?=
 =?us-ascii?Q?XDTwuOGt1ifGbXA4e9uQGzqvMpdktfkbVyV3Km4BrB3ARfnJGq4IR7moUBiR?=
 =?us-ascii?Q?4i1gO5xrwWWD/uYBRaBxhT8eH6grHXiEMcwdxOVCSdS4AAdAgmZhUZhkjC6Y?=
 =?us-ascii?Q?n0lRpr9aez5T8l4fv6fdC4qg++j4zUQQehL34mJ5xUtvSNztyB9YUQWdTujf?=
 =?us-ascii?Q?3LNCtp4CBmKBo+zPbHbxTnFzucAJC+mlMgisgfjQAKLQ+G93yspctdzEQ57N?=
 =?us-ascii?Q?J/+l09fPmZ/mGD68YT2k4GJKAfCCQDRw2UAPu++gbC0e7JhaWiFmJ/NsYZyV?=
 =?us-ascii?Q?coSQoWAO7GfID9GSAwrMWMpA6ra0gurF2ZJexopAg6BSus/QHH1B3CznH9ki?=
 =?us-ascii?Q?q5uggZTtsaow91RcQWC2/kOMFfYDzlVVxZl8viiYohMOCiHbvKUQnUhsXUgW?=
 =?us-ascii?Q?Y1aWvf0pI8peG+ATmqFgGx29b97R4+G9Oj2xvjyEBvANJei82uAHB269cKYm?=
 =?us-ascii?Q?mX57nyTRhPATpZs+rdsmUz96vAm0L/2OtZ1zCyBvyHfmVKS1E2GeYJczVhbi?=
 =?us-ascii?Q?1jlVN6MFumIqLbDDsfcFuWEHXrbCrn5lzpdtULENpEy6D8mhSkqI1T5Ljpjt?=
 =?us-ascii?Q?d3ogk1I3eNkIWl5sxaIG/n5BlgPi8uNssi9AOXR/j5Yu7xteiTiiShC+ue4N?=
 =?us-ascii?Q?/H3YEP+0t1IYSttxrL4UY8G9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9033cf95-3561-469d-99ee-08d8dd1bf0a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 01:38:54.3602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z58RdG0IuVUyx7unClB3b6lFnv7PXxyDYBDnVryzyS6h10GldwDUChBIi7W4JTaT+1JcgjPdGgSFYO0xj6IkneNtInoGAaMHJ97SbukzNDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1579
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, March 1, 202=
1 6:25 AM
>=20
> On 01/03/2021 02:15, Michael Kelley wrote:
> > While the Hyper-V Reference TSC code is architecture neutral, the
> > pv_ops.time.sched_clock() function is implemented for x86/x64, but not
> > for ARM64. Current code calls a utility function under arch/x86 (and
> > coming, under arch/arm64) to handle the difference.
> >
> > Change this approach to handle the difference inline based on whether
> > GENERIC_SCHED_CLOCK is present.  The new approach removes code under
> > arch/* since the difference is tied more to the specifics of the Linux
> > implementation than to the architecture.
> >
> > No functional change.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
>=20
> [ ... ]
>=20
> > +/*
> > + * Reference to pv_ops must be inline so objtool
> > + * detection of noinstr violations can work correctly.
> > + */
> > +static __always_inline void hv_setup_sched_clock(void *sched_clock)
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
> Please refer to:
>=20
> Documentation/process/coding-style.rst
>=20
> Section 21)
>=20
> [ ... ]
>=20
> Prefer to compile out entire functions, rather than portions of
> functions or portions of expressions.
>=20
> [ ... ]
>=20

OK.  I'll rework the #ifdef in v3 of the patch set.  Is the following
the preferred approach?

#ifdef CONFIG_GENERIC_SCHED_CLOCK
static __always_inline void hv_setup_sched_clock(void *sched_clock)
{
	sched_clock_register(sched_clock, 64 NSEC_PER_SEC);
}
#else
#ifdef CONFIG_PARAVIRT
static __always_inline void hv_setup_sched_clock(void *sched_clock)
{
	pv_ops.time.sched_clock =3D sched_clock:
}
#else
static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
#endif
#endif

Michael
