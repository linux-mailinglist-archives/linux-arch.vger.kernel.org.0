Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE032225D
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 23:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhBVWtq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 17:49:46 -0500
Received: from mail-dm6nam11on2122.outbound.protection.outlook.com ([40.107.223.122]:16224
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232363AbhBVWtg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 17:49:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxd+GP0+Tdu8DPCJYZlkQVBfS0At5J1hmReuh8cTPRGgrBWkqwQRZ/rpjAMJ5b3AFKQweuCZk6Cbz3afCaqCts4PCtZJ++02m6y/Is+6kij9J2X6mhNDl5Qacl1ov6MSwjXCW1/TOAx8HL5ZKszCEXfQAixWF1wDT8VW7v9+ckvSXXk4Kj2h4RhA4s6ylDmkFknl8RfUSEo13uzDvYsU7p76ezLtIShHz4mGl9z0fOXdf3vpWHgoGrE+yhc+ihivZiBrv0Lba4iAEZL8+dok+04RmjXtU4wLQ97lnTSh30BHck++qDt7gtbf1CD82ROohdekNz5b1juHbkr9dlx1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX954zGmBOJVKeBUFDCbV1KjBJMrEmSwGqARNI1wOC8=;
 b=nOkXYz4OjyibWEkjI7rmKkzBBhzTbrKd92K9vr/lLa5RJ+rNqGJb0jsr8PrhknzUHC7J55BO3oumwxupTF088C8cvsYdKRKoOKtM/XnVqTdfGVfLd3joJBpmcu6hcpxz0LZKr9KehsHZk+g6S3dTuzWNUQo0Vp0/9vZI9iY8IIcT+Y4OtLvzD74MZAr75bSnbIeKVqtraNiZjnikauIImmytTPdAr5JUVxr+oedeAM+L29A3LnRRq/3wTPMx6dme2ilPxGqtEZzjYoCsqaMz6iCJEtSTEMhiTjPbDhUxjqUfKJg76xN3I4tS640elMxGRQCryT+qgsRpyg+YJ/pSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX954zGmBOJVKeBUFDCbV1KjBJMrEmSwGqARNI1wOC8=;
 b=NUlB7KXZ85z3PvNq01FC+Y3Xk0fuNHlfWdOVIaDDmmZ8LPcNzGBoE2vCaI6VEJ2H01HdxTh0k77t0QdAT/K0Crz4E+PdZ4Co7b0p3TlRWXMpU5IFPeAG3Y44h2HuiOXVnKKWXjAGDApNg0wcaXFviW72LTWKVg4NYLsZjReojEI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 22 Feb
 2021 22:48:47 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.002; Mon, 22 Feb 2021
 22:48:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 09/10] clocksource/drivers/hyper-v: Set clocksource rating
 based on Hyper-V feature
Thread-Topic: [PATCH 09/10] clocksource/drivers/hyper-v: Set clocksource
 rating based on Hyper-V feature
Thread-Index: AQHW9OprZsrypvs55kaNaRVkIO+Tq6pkfguAgABq4oA=
Date:   Mon, 22 Feb 2021 22:48:46 +0000
Message-ID: <MWHPR21MB159313CF48D9124805E4A694D7819@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-10-git-send-email-mikelley@microsoft.com>
 <YDPVRy+QnZzoM+eF@boqun-archlinux>
In-Reply-To: <YDPVRy+QnZzoM+eF@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-22T22:48:45Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=448d9234-51c5-4e7d-96c6-9a95d0641e32;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2baff209-e033-4b29-3fa3-08d8d78403b6
x-ms-traffictypediagnostic: MWHPR21MB1546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB154611D39E36EC1E9BE0127FD7819@MWHPR21MB1546.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kg8Q9M0jVC519xhVinCMJz5YupinHTUHNTSfYJgcbdpFlyBldpZ0jNrRm6YW5cSaUJwOIW/lucvL65qZ+jdDR6EtJG2UqagclJ7PCQDB+ItrgQSoU0u77gmOjzJs7LNDN08nQouximRFLybt1JpXTF1CCVTdazzmaHoujaiIqsxI0B3oQECuvDYZGZRM2GjyL39OA+xOS+wY38gbwH9yCvr20sjkDDfMlRv5Xt5FaG+MqY72Nb4N3m+Xrkt8AG+4NYHcRVjDXmF4i3AQWighP5qhlI0Djy6xk1hITgvCQya3kIMhoE1oQOdYnYJovpUlaBBdxTjqpeQnl6EPeggPTeXfYVVsUiNVXwhQ16Faq8tyBVgC9KojXsUE+mgKmjYMqXCfAfxMgnOmTfOmEo3XD4IxsIudkE2fVjokI6CSdDgRwJVOVPchr4Hj2acu1itQWnAOuxbuvyJZ+JU9s9o1Nl4KF8NX9o5PxjZsq/O6H6ztH8w3aSHAATug2IakM0ZlCWkYeyoEPh1369pULc7Ycw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(66556008)(82960400001)(10290500003)(6916009)(2906002)(4326008)(8990500004)(8936002)(33656002)(76116006)(64756008)(478600001)(82950400001)(52536014)(186003)(26005)(7696005)(55016002)(66446008)(66476007)(66946007)(6506007)(7416002)(5660300002)(71200400001)(54906003)(316002)(86362001)(8676002)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s0g9ftMBjeVqW9UdI5ALSpzzFSJvkHoQax28O6/r9SgL+6RnAFGiizcbQH1M?=
 =?us-ascii?Q?/V2eLcHKCORDbf3SVy/pR9PiqmCiiVJ48/zQf19yz0/jG+L74C/GyF1QoTIn?=
 =?us-ascii?Q?SlM9yCYfNi3T9QHarS1GPPogOIQsJPsb0dMoVFijuRkATDCOt7sSJvCW1G/4?=
 =?us-ascii?Q?Me7P4kiJWtvs3nyByyQN7FWvDGLc/RDQwSZ19SdjGQhpwS9bFje8jAt0jRJ7?=
 =?us-ascii?Q?7nKAQ1VUb1SOKRCvA6dariTNiLMEZRB5rnnYEF8+BPQKGPy3gGE6pZwMDgAO?=
 =?us-ascii?Q?1LbhOVxh4U7QJy9yWMvITGDcOlQNh3SYKsywQ3qexc4yAOkTD9zZbcoH/R8+?=
 =?us-ascii?Q?UhRHmqVfaq44NzgOGqQFqZF1nd7OermsALoBlF+6AmxQcUkL32lKISz3gNUT?=
 =?us-ascii?Q?AlPj9+WqggNp2vU3l42XDcjmyxX+ETUGOA8l0On3IIpwsl9reVEFnz7h2b00?=
 =?us-ascii?Q?wETRAzBQoxD20x/9Z1PgXTHDOAVA36EK3m9lm2jCvIql4baKaccr/mIp9TGD?=
 =?us-ascii?Q?X5b469QGSvabDBy0e+/xjjxCi4aNTi403xyYHG4rQuh2ulneoAoY76h7O0Vn?=
 =?us-ascii?Q?sK6xFUCQLMgM7og3pQRDUwPeN89re2xENN6kgczAQn1tzGtn07VAm8V2ojyM?=
 =?us-ascii?Q?xPAGrkBdy3enitv7mPXl9MqQL/1fYpVTrxz50c6RcCtrsYl2EK4gkfjSDLyN?=
 =?us-ascii?Q?sLFZsGOr1Fpmuji5faqb7/eq2N04Fuxn8dlu8HxUhbLBcXQwnYo07JjY8ONr?=
 =?us-ascii?Q?Fobq+ViHb574YQU6nql6JkRzBCkuz9MFfaDGW9ZiSuDtWG0ZUrx7qNuIt/IF?=
 =?us-ascii?Q?p0iG4eVuZt4ce5iVuR3IlimWYy3wZWHTOboHofiW1y+XZn/pNT0skpSv2UcY?=
 =?us-ascii?Q?/q/y/bEzd2r5fTbkRMjKnzXrbHzlS421+498FrIjWBK05k4tL8wJG8WJmtEh?=
 =?us-ascii?Q?0ZYGTNUFChcF+byKuX4nl/YebpBae2c5AkjDD1I7T9uQMdx/ErJ1bsZnBVsu?=
 =?us-ascii?Q?BbvR5nV811KxXDtxmBvpm93qusGficSs056r0JiWQYy+ENBMabuJX62a+RdA?=
 =?us-ascii?Q?HyajpPkK2LKqPP/xOfVxfhw8WcIcfE0f8EwJiC2zLTn6NmkcWXLiyUzeM+Xh?=
 =?us-ascii?Q?X6ESQUVKK6U3DbshPVlI/stjcTYyK/1PNAv8/Aq73hiRwZRs/14+RYrrTiCV?=
 =?us-ascii?Q?i4OM4VPSzqSArjyjNrSZv7I9vTUF0gOanybyydlYesywNovIYrEld4AZmNdf?=
 =?us-ascii?Q?W5f6XP9uKYst9Zy7iIYMhiffUlNt+F8+76g+1IjXqBviO3AVtgDCMMwdQNPg?=
 =?us-ascii?Q?yGJRS1/lKornMuAEmpRlLZ+B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baff209-e033-4b29-3fa3-08d8d78403b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 22:48:46.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHOrzznCSxLEmIF8dXlf/71CvK7tN/7foLYeSh3KK+t/bp+Aw8P1AykerwKnuVmXZijjKgK2YUk1qEaRQZ3jam/rW1X20Zcy3uqiCFP7yOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1546
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Monday, February 22, 2021 8:0=
1 AM
>=20
> On Wed, Jan 27, 2021 at 12:23:44PM -0800, Michael Kelley wrote:
> > On x86/x64, the TSC clocksource is available in a Hyper-V VM only if
> > Hyper-V provides the TSC_INVARIANT flag. The rating on the Hyper-V
> > Reference TSC page clocksource is currently set so that it will not
> > override the TSC clocksource in this case.  Alternatively, if the TSC
> > clocksource is not available, then the Hyper-V clocksource is used.
> >
> > But on ARM64, the Hyper-V Reference TSC page clocksource should
> > override the ARM arch counter, since the Hyper-V clocksource provides
> > scaling and offsetting during live migrations that is not provided
> > for the ARM arch counter.
> >
> > To get the needed behavior for both x86/x64 and ARM64, tweak the
> > logic by defaulting the Hyper-V Reference TSC page clocksource
> > rating to a large value that will always override.  If the Hyper-V
> > TSC_INVARIANT flag is set, then reduce the rating so that it will not
> > override the TSC.
> >
> > While the logic for getting there is slightly different, the net
> > result in the normal cases is no functional change.
> >
>=20
> One question here, please see below:
>=20
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  drivers/clocksource/hyperv_timer.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/h=
yperv_timer.c
> > index a2bee50..edf2d43 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -302,14 +302,6 @@ void hv_stimer_global_cleanup(void)
> >   * the other that uses the TSC reference page feature as defined in th=
e
> >   * TLFS.  The MSR version is for compatibility with old versions of
> >   * Hyper-V and 32-bit x86.  The TSC reference page version is preferre=
d.
> > - *
> > - * The Hyper-V clocksource ratings of 250 are chosen to be below the
> > - * TSC clocksource rating of 300.  In configurations where Hyper-V off=
ers
> > - * an InvariantTSC, the TSC is not marked "unstable", so the TSC clock=
source
> > - * is available and preferred.  With the higher rating, it will be the
> > - * default.  On older hardware and Hyper-V versions, the TSC is marked
> > - * "unstable", so no TSC clocksource is created and the selected Hyper=
-V
> > - * clocksource will be the default.
> >   */
> >
> >  u64 (*hv_read_reference_counter)(void);
> > @@ -380,7 +372,7 @@ static int hv_cs_enable(struct clocksource *cs)
> >
> >  static struct clocksource hyperv_cs_tsc =3D {
> >  	.name	=3D "hyperv_clocksource_tsc_page",
> > -	.rating	=3D 250,
> > +	.rating	=3D 500,
> >  	.read	=3D read_hv_clock_tsc_cs,
> >  	.mask	=3D CLOCKSOURCE_MASK(64),
> >  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
> > @@ -417,7 +409,7 @@ static u64 notrace read_hv_sched_clock_msr(void)
> >
> >  static struct clocksource hyperv_cs_msr =3D {
> >  	.name	=3D "hyperv_clocksource_msr",
> > -	.rating	=3D 250,
> > +	.rating	=3D 500,
>=20
> Before this patch, since the ".rating" of hyper_cs_msr is 250 which is
> smaller than the TSC clocksource rating, the TSC clocksource is better.
> After this patch, in the case where HV_MSR_REFERENCE_TSC_AVAILABLE bit
> is 0, we make hyperv_cs_msr better than the TSC clocksource (and we
> don't lower the rating of hyperv_cs_msr if TSC_INVARIANT is not
> offered), right?  Could you explain why we need the change? Or maybe I'm
> missing something?
>

You make a good point.  The code path that sets hyperv_cs_tsc.rating
to 250 should also be setting hyperv_cs_msr.rating to 250.  The reality
is that the hyperv_cs_msr clock is a backup that is never used under
normal circumstances, so I didn't pay careful attention to that case.
I'll fix it.

Michael

>=20
> Regards,
> Boqun
>=20
> >  	.read	=3D read_hv_clock_msr_cs,
> >  	.mask	=3D CLOCKSOURCE_MASK(64),
> >  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
> > @@ -452,6 +444,17 @@ static bool __init hv_init_tsc_clocksource(void)
> >  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> >  		return false;
> >
> > +	/*
> > +	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctl=
y
> > +	 * handles frequency and offset changes due to live migration,
> > +	 * pause/resume, and other VM management operations.  So lower the
> > +	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
> > +	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
> > +	 * TSC will be preferred over the virtualized ARM64 arch counter.
> > +	 */
> > +	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
> > +		hyperv_cs_tsc.rating =3D 250;
> > +
> >  	hv_read_reference_counter =3D read_hv_clock_tsc;
> >  	phys_addr =3D virt_to_phys(hv_get_tsc_page());
> >
> > --
> > 1.8.3.1
> >
