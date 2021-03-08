Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F12330FEC
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 14:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCHNtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 08:49:36 -0500
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:47200
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229457AbhCHNtU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 08:49:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak0Rq6oqdH8RQnBK3RP8D0fl/7UrWU/HoPLOQCQ7+cZ/zLcjSJg33x2M8MxQvLAetsxmy8xsVHv2Z8j0LNdar775yzVyqeVKevdu+jcP4Q4iRnfichWWivrWd6KFIT1xc18HR0w2ziYDvHHZLmokOrcP+tcnENbDHx2LMUCJvHE6W9FybOjl0yzy2f4yTUOqcBx/baZF6WB7MrmfqM3VQo2nA3Mu1cmOQyKOXLUCqpGvz0JbuRa7E54KatxQZf7qttehSouhie3WFhbC23IedOdO7im/6t3gB5PV48linE9V49pbFOXEP3G+qlxlEtaDlCAGCImrvu4cmzUYLDmPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBZk+aBBbU7r2WBBQ0YTgdy6yv/nJu6XMykQLxpqSD0=;
 b=QJSTYE/0tPwUZILzjeie59Xvl1n+/PvtAYI9yQM2k6D3X19Fzx93S7A7/b2u7pMDoRlIzJIhH6rFzSRO2jjc6KC347rQyUqQkyASvp1Z/mwKC0yH9D64cUCxJG7oGoSUFWHoPbMfM61etQqtocl9XxY0+2RAf3UkOxIyeN8mIw7bwTJ5P+x2fyJy+LQSBAc4+slx287LGBRIxS1HKRYVYj/rh/Vf4EzXsEPk2J4l8rT5xJ8bnynC9Mz6jBWukweAyCX4V7Zmk42uHgrImn0JBDxBc3Yg37PgFgfCcCKuQU1Ea6I2sXxVNudft6/uxGBqOdvuh0KtptC7U5KTLAzZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBZk+aBBbU7r2WBBQ0YTgdy6yv/nJu6XMykQLxpqSD0=;
 b=A8O6ix2Lii7TOnLFEPq5YI4wKvsKVhzDRRk/YBYo2zm/BYnFoXZIVNRHM0/23TnBqWFjdYRZVvCyVzb0Kb8teBHK5zgb3fZCV2fgJQKwZ/BgU5caGoEengDo0KmAiUDz66JN494u9okVlXiMTwMoicOPBklzK4uIL12X4S48ZRA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (10.167.236.11) by
 MW2PR2101MB1035.namprd21.prod.outlook.com (52.132.149.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9; Mon, 8 Mar 2021 13:49:11 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3955.005; Mon, 8 Mar 2021
 13:49:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
Thread-Topic: [PATCH v3 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
Thread-Index: AQHXD6x01LY7XmpNTEG5OPuJxVWUH6pxQ3IAgAANFHCACNMGIA==
Date:   Mon, 8 Mar 2021 13:49:10 +0000
Message-ID: <MWHPR21MB15933A79CB7C4552FEA6F583D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
 <1614721102-2241-8-git-send-email-mikelley@microsoft.com>
 <25234414-d905-0f9c-af92-9a9e4cde30c4@linaro.org>
 <MWHPR21MB1593EF82FC3C8B5F9D466E5BD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593EF82FC3C8B5F9D466E5BD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-02T23:06:48Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a699e977-03e3-4a5c-9be1-4d75c48ddc00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c72df59c-01af-4939-cddc-08d8e238f3d3
x-ms-traffictypediagnostic: MW2PR2101MB1035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10358489399AB7BB8D57502BD7939@MW2PR2101MB1035.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwZTymmSqk0RgzG9vRfEozRtI5yAsIHGUgYPQAWg7n9+tp2PSuditUYTegr5EcPKRCDWqqkiW5RlG0so9UnHcPyxNMBH5J0e/+HBnjy0hssKOutYjv+rOfutfShOOaH/MK5vs7KBGyKS9twdw3LOzUF2dx/tf3m9iSC5qvtPa0hImaU5JOYvgsFhBMw6mmRJWhgQ6nb8UdJJX827/MnyoUoQeUNXcNNoIatf5CucB75q1vlYkNEybvnGK6AYCr2MOdpeO6loZg4QY/YNRJl8uXKKuL1xiaDW7M1aHLG1PqeaVfuAfE9qtnqHvDq4WwQMfIZFAvSe7VCJTYUX18h8vgPA4PB9315HxHO3AWC0F30xQ9F4a+jMO0TAUVPflVkiAr1TaYS24sy+4xisWAcaDQz0PuxAr4g1SB9J8SftJ/7p0hYXoDqpEnBxnudS9vwRb0Jn/nkB+W7iXa6a14NkPL0LzGY5iHhmTy83RVseubsCVJyAcgtkeYh3OZZGuUDbL5O/pklPM/3uo/nzF4s98w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(76116006)(26005)(54906003)(316002)(6916009)(10290500003)(71200400001)(66476007)(2906002)(66556008)(7416002)(66446008)(64756008)(478600001)(9686003)(8676002)(8936002)(52536014)(6506007)(186003)(83380400001)(4326008)(53546011)(8990500004)(7696005)(82950400001)(86362001)(82960400001)(33656002)(55016002)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?k95uA2o60Ebgk6JtC/U1aF5lyAOJnCNg45OlYDDShxNhlcrwohYMHobwGe00?=
 =?us-ascii?Q?fWM8gGXF649yhLy/a5+SSm+Nm4j/KqutHUrEBdINd47+wLRjUdGWDyW+wo0L?=
 =?us-ascii?Q?sE83GBrJGjsdOCEblmvyxSMyTSG3wu5WHilxlWMlt6pVB9CtIHVdKEx2uVKW?=
 =?us-ascii?Q?liJ9Xr3PqyMab7WFP6LvM/QhBCMyiOm6ebHbYEgctckvMQ/3xkY8rUMdJH12?=
 =?us-ascii?Q?RP+gNtfcLYLHeNWErDHHVyCaJfST7yeRHVBlV475Nb4FIxWU7Jw49V5wP5kt?=
 =?us-ascii?Q?IXXCNaa1Lk9zipuFaugV6lRX7v0CkdtZJQfSc2ATDPw+9Jf9dQvQgX2+X6sE?=
 =?us-ascii?Q?4fgdRY2gs2gT/oje9fntg8wiijqzznQC6R5kP5cHjDS/35rHpTvjpSNnArSp?=
 =?us-ascii?Q?RZtuQyyALqX/EmSDRD12Adxum6BSi/2d0lxUcG9sQUKwPfbpZXdlM0E+TNdL?=
 =?us-ascii?Q?UXMgQRFe5jygK0xSN1laMHoZJd2xMh6YVnA2ZF/qbJ+UV1yjqlmU7uVgtits?=
 =?us-ascii?Q?d52p5YoZ8ilzWJOuOwY4+B1t1CcE1pc0Ff/sef8pSfFy/eydW8SgOMP59nqn?=
 =?us-ascii?Q?xAmur6gatl3uyK4bTfMoNK4FoBCYKJVNHrtaS1LeUOHDIFaDqTC2n4bXvfDa?=
 =?us-ascii?Q?T2X3Zng8WDKUjW+HI/If3vRR9rvq9wJJUfZ5uT5Zap8wHnrixUjBrfZlFyCt?=
 =?us-ascii?Q?PLKtOEZAS1EGigVWsJ+TIt/JCOQzT6tVT4bFlsh8yrdMXa5GXs7kkyYXewrl?=
 =?us-ascii?Q?k/N743bK+HKwmTE6J9cp06qVpDqkRHf634/NJDynj3oVg2NLjoqDYAgr4U1N?=
 =?us-ascii?Q?mZud+pENUSqZMeW5t3tU+73gEWZPFH6q5TRVtdSE9O3/YQHSmKL64wfAYVk4?=
 =?us-ascii?Q?w7i+wKarrxJ+7VO1Kfo90VqYkyYMS7+h13Ie7Wd+tLL6Sq3+zRQagNIWLUXy?=
 =?us-ascii?Q?gejCdlviRcgvO2ZRGq/z5I/s6i3oACTDkfMkdgTNim4mnbDCvSqBHizz4kkY?=
 =?us-ascii?Q?zqnfKKBFb78dnT585kp4ymKmLUyJLXyPP9fZ4XVW5EuNnDZSdF//xcIV3zA+?=
 =?us-ascii?Q?SNyYMHktbimNY0EZVvd4hBx53HNxN3qeC+ucjVGjN1H20zNPYg0hSw4LL3Dq?=
 =?us-ascii?Q?v4TX1/RUF3cvwTt3/WpXiXH77I6qa4fz9ow5ae3yBnxEwLAdNqPEDpdZ5F2S?=
 =?us-ascii?Q?qlF2K0qlvzlKdZnIbHxPhqY/PC7lMl+6GQ23gT1qA+/ruKMnxX6sVURE0G0E?=
 =?us-ascii?Q?SUj5JeMzJzMpOBz6VHtkKPdm/wg3OE3aQ9UVVUK3gcv2Eg2viDktus+aqmJo?=
 =?us-ascii?Q?3GmlaOEKt24QL/mtc2Uh2Xdt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72df59c-01af-4939-cddc-08d8e238f3d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 13:49:10.8875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4yKQBUKnBvGfPPBqGcAWDupdyBt68zh4SBgwIVr4YGOPEzbwwIHyZ0P8fgr2fkLLhLgATNz/TGZ8NyPUg20g9kyaN9jYMLGUYVzfkQb44Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1035
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com> Sent: Tuesday, March 2, 2021 =
3:07 PM
>=20
> From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Tuesday, March 2, =
2021 2:14 PM
> >
> > On 02/03/2021 22:38, Michael Kelley wrote:
> > > While the driver for the Hyper-V Reference TSC and STIMERs is archite=
cture
> > > neutral, vDSO is implemented for x86/x64, but not for ARM64.  Current=
 code
> > > calls into utility functions under arch/x86 (and coming, under arch/a=
rm64)
> > > to handle the difference.
> > >
> > > Change this approach to handle the difference inline based on whether
> > > VDSO_CLOCK_MODE_HVCLOCK is present.  The new approach removes code un=
der
> > > arch/* since the difference is tied more to the specifics of the Linu=
x
> > > implementation than to the architecture.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  arch/x86/include/asm/mshyperv.h    |  4 ----
> > >  drivers/clocksource/hyperv_timer.c | 10 ++++++++--
> > >  2 files changed, 8 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/m=
shyperv.h
> > > index c10dd1c..4f566db 100644
> > > --- a/arch/x86/include/asm/mshyperv.h
> > > +++ b/arch/x86/include/asm/mshyperv.h
> > > @@ -27,10 +27,6 @@ static inline u64 hv_get_register(unsigned int reg=
)
> > >  	return value;
> > >  }
> > >
> > > -#define hv_set_clocksource_vdso(val) \
> > > -	((val).vdso_clock_mode =3D VDSO_CLOCKMODE_HVCLOCK)
> > > -#define hv_enable_vdso_clocksource() \
> > > -	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> > >  #define hv_get_raw_timer() rdtsc_ordered()
> > >
> > >  /*
> > > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource=
/hyperv_timer.c
> > > index c73c127..06984fa 100644
> > > --- a/drivers/clocksource/hyperv_timer.c
> > > +++ b/drivers/clocksource/hyperv_timer.c
> > > @@ -370,11 +370,13 @@ static void resume_hv_clock_tsc(struct clocksou=
rce *arg)
> > >  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > >  }
> > >
> > > +#ifdef VDSO_CLOCKMODE_HVCLOCK
> > >  static int hv_cs_enable(struct clocksource *cs)
> > >  {
> > > -	hv_enable_vdso_clocksource();
> > > +	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> > >  	return 0;
> > >  }
> > > +#endif
> >
> > We had a confusion here. The suggestion was to remove the #ifdef here
> > and add the __maybe_unused annotation to the function.
>=20
> I wondered if maybe that's what you were getting at with your
> most recent comments.  But the code doesn't compile on ARM64
> with __maybe_unused instead of the #ifdef because
> VDSO_CLOCKMODE_HVCLOCK is undefined.
>=20
> Michael
>=20

Daniel -- any additional comments/feedback?  Getting your Ack on
this patch should be the last step to wrap up the patch series.

Thanks,

Michael

> >
> > >  static struct clocksource hyperv_cs_tsc =3D {
> > >  	.name	=3D "hyperv_clocksource_tsc_page",
> > > @@ -384,7 +386,12 @@ static int hv_cs_enable(struct clocksource *cs)
> > >  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
> > >  	.suspend=3D suspend_hv_clock_tsc,
> > >  	.resume	=3D resume_hv_clock_tsc,
> > > +#ifdef VDSO_CLOCKMODE_HVCLOCK
> > >  	.enable =3D hv_cs_enable,
> > > +	.vdso_clock_mode =3D VDSO_CLOCKMODE_HVCLOCK,
> > > +#else
> > > +	.vdso_clock_mode =3D VDSO_CLOCKMODE_NONE,
> > > +#endif
> > >  };
> > >
