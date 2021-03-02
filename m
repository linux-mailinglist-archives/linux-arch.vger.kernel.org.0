Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89A32B4E7
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450164AbhCCFay (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:54 -0500
Received: from mail-co1nam11on2099.outbound.protection.outlook.com ([40.107.220.99]:49344
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1840150AbhCBXHv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 18:07:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfjGAkq1m+BH5qtWhvHnbV0hNDdPFr+RD9OXtTJKlikUWXFAsN5a7pjSYi7J09FhHdWXrTWXu+ThNWvQ4VkwNudOQbSjNuiJeGGgKeDo+M7XnJG1mRxktJ9/DRcLt0GZnYRLlgN6Trbe/y7CkcGLJWQq0jlo/xHUaYzs0SMn+fhr4jxZZxlLQKvDFb9Pwjk3WSJytY4XNNe+vtE1zCOgtjWjhBu15GyfJy7ptCw8cRbgbJWjV9uPdNwFsRU6UDetQIGCLIutqa5YPO3uodIa0n4sbI+mjEu2dSA3twA0ICUmMxm8E3WCEHoaGbKqJ80n+7nHxtp383Gy8XwIdLXn2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHAYMM1NHv6c1BK52afcNb0BTehwHnfaDDz5sld0uRA=;
 b=JfDFbZbhNnt20if1XojP6kmAx7pM6g08Y29N921pcmL3Yq/BorfW1mY9NqAWTsj4PpH3HN8r1kuyitksWT4dAqfgAwhzVS5qGNwos/3sp9j8/tYHFZKb8Cw/1ET/BkBtmT17FIsMYMckbh6EIlA3hn1UwMMGkaYgWkdiHaIMMRR3wyF0BvtOhUocYn7EM5b2GNy8nUl0bBjNL5F/TMmbcm1QJOiKEQas4aVm+wYOBsA+2co1OUVZYqliKDyxXlckA5vrXuUqwpQ/if9x2gPHKtCpQUX2dp0j/JYvz9OXyodH+rJ+pdCTUT/re3/b5E0qm2LmBZOJDFeP2rSyDNIllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHAYMM1NHv6c1BK52afcNb0BTehwHnfaDDz5sld0uRA=;
 b=jCtzKZm2kxTD+chsvuxv+q2QNSFKszNzoo3jjb0FFKrHTsIhTHeVDVH9/kfztBBcyurdPbrT+oip/Zcpt4Izs8hiX1eX0ELb8YcYgCL3MwcpOPcmE+v7jCwPsmjHgFkMmhR4y0vB2DbPDWLqun1+sVc9ts3565Kk099OwpDlEWE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1970.namprd21.prod.outlook.com (2603:10b6:303:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.8; Tue, 2 Mar
 2021 23:06:51 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 23:06:51 +0000
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
Subject: RE: [PATCH v3 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
Thread-Topic: [PATCH v3 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
Thread-Index: AQHXD6x01LY7XmpNTEG5OPuJxVWUH6pxQ3IAgAANFHA=
Date:   Tue, 2 Mar 2021 23:06:50 +0000
Message-ID: <MWHPR21MB1593EF82FC3C8B5F9D466E5BD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
 <1614721102-2241-8-git-send-email-mikelley@microsoft.com>
 <25234414-d905-0f9c-af92-9a9e4cde30c4@linaro.org>
In-Reply-To: <25234414-d905-0f9c-af92-9a9e4cde30c4@linaro.org>
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
x-ms-office365-filtering-correlation-id: 1e83b580-bb79-4628-f2f9-08d8ddcfdd23
x-ms-traffictypediagnostic: MW4PR21MB1970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1970EDAD46D359A92B2D4E36D7999@MW4PR21MB1970.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UvNUQxdNNPi39hFH/3qge2VUOCJq6qz3DJwsyo9dRSe99pvqXOvfW7X6G+s4DnqEYlfyvDHEOfTTiBXssfkO3bCHODhGfgqp5rJrQJSdGkllcVcdqOVsS6ZRQCsqrRLaYRnLfqvJ2SFbCRrPyzmHr6irFJgY8cA2myeeskd2iVmnOJpA7TriWUUcx2c4rUcGHGb+1EZM6WhiGNxjrM+RoCwdwXA7pgRGs2gF8QEpULrsKN5E6YV9YVTkWTVAslGV7BqsIDv1h7bqqQaFsOK7H4U73xT9ZS1JXWcA03WZCPRGRgsEXfZCdr5Q6Eefilr48D1/3Q9/ZWa/XnwMg7Sr3JX16ReelOXo95E4DnWoRTFmz3q87F0JnNLKaMIKwVMICcjuh9CfQoeO27PcLfeuFEqwoPxFC97yjt396vCSxsSPjrAxNa3LduUET57qiJNw/TxSEffpYT2S2f27ZYT5YJ9btsVJyaT4wROFnjLy6E3SnjtbB9bQ9nC57yTW1gqTfKcGKeFlbjeDCKAsLcQid4vWUEKFihIBbYKasW55SEQdNDXJ3O7EUMsNV4Asa/hnBCvp8s90g2YEFLCXZ7eAPU5Arydwla7pxV4vOSxqMJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(9686003)(7696005)(55016002)(71200400001)(2906002)(76116006)(5660300002)(110136005)(54906003)(66946007)(53546011)(4326008)(10290500003)(921005)(82960400001)(82950400001)(8936002)(52536014)(6506007)(26005)(66476007)(64756008)(86362001)(7416002)(66446008)(478600001)(83380400001)(33656002)(186003)(8676002)(8990500004)(316002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VpgITsOqgIgxEyi63bR5q1EA3w+CtdpwLGxXninH1du8dQQFclg2QjcerXLT?=
 =?us-ascii?Q?a9HJOzr1H1NdmCP2PWjXbUTO39Fhmy69q6azGRn2VnyNUWgeBGEtnhnSTt11?=
 =?us-ascii?Q?SScKg0EYVacsWFd0dhXjRfOa8QU6FHmGpi+k2JXhEVEjWaLnet+rTumljyDD?=
 =?us-ascii?Q?RzsYHlHFZmU1KzN3j8xCUHsKFR/dLCDFZMPqHktPwqgPZZQEN2bSyoXsyQpp?=
 =?us-ascii?Q?bXaSI3JCb9YJAkY6rGw2cZ3s9Z2QBealDRcj0CuReQ5hbCf64Tijjz3rS3sC?=
 =?us-ascii?Q?XOwdYM4/xLmsSXfdgD5QAzCaYP5agLKjl5GdXWnRLdFqPk9RFvo8QmPknVYU?=
 =?us-ascii?Q?+9Tt3UKNJikwQtcS1IiVBv2ddW2AMe46hwyPiY8TsNc/PdfBAOvGRKVXU3xx?=
 =?us-ascii?Q?oiD/O8sH+GfcZXodFtWuIQLCH7dDGNuQhlIP3QHqyQR3+vpnD5dgbBQURJno?=
 =?us-ascii?Q?Bjy74b2gam4u4m39qdiUTGPE+OviTv9EPCLSC9gUcr6QDrbZHmmSIVwmoOl+?=
 =?us-ascii?Q?39jkM/yTWFU29fBbCMiGDbaL67byaE+zFex1qAcy4SQeGTCci9qEjDTq9sa1?=
 =?us-ascii?Q?qm5LjBAdF7ubBxkHesRQYYp+no8m7LCredKyOqNGg/mq0r0NnmU7ekLLKYL7?=
 =?us-ascii?Q?QjhCMQ+SijypT6/mHsJ1sQoDMRuCMdNrn1I0AK4DWQpJFJaGlXT9CilvgbNY?=
 =?us-ascii?Q?jiBJFuKkDikcpAPokKOXVrmIG4up7zIxy2QGA8fkxVPeID8ScJH7zP1TXpF1?=
 =?us-ascii?Q?JbomF6zZ5mGWFa6HoEePSq6cp8OTjq5L5Hm2XKweCqbADx+lbjb+gV9W29V4?=
 =?us-ascii?Q?9Qq3raNKTBXRfkpKxfYpFQ9IgzM7m1mz7pl6Nfm/71jVzgoLdXeQNTI0AU4C?=
 =?us-ascii?Q?QxiSE3k3swM07wgQqWmIA0iQvqU0oXcKqGSDa7t2C8vVgAtFA+rO9E0CziZF?=
 =?us-ascii?Q?zDP8QwmXkwc1rDGpxJ8c/PzzR2Hf61zTLcWTfK+WIpNAKkU2FgILxxhlB/63?=
 =?us-ascii?Q?efb1bkeJFMyfDL8PLoQ5S2LCTX8LcBQVy5iZ3pmmXayrv+igwctGhf6HC90e?=
 =?us-ascii?Q?EhN8FvWj4SzoMdu9t41IABWXOtHgEvzzNq8hE1P1j0wCCL2WUCTfqbL5LfwS?=
 =?us-ascii?Q?61ODgFxRcrFM2orVsZEDdvBdK5Cw1xjPLeBNCfl1st49nEL0oipDTphMeW26?=
 =?us-ascii?Q?ajfkrOw1gw/An1bQnbmq0CWM2tcw6+lJ58dlGKjhwe5tA3McIbY5SvFHLoCm?=
 =?us-ascii?Q?VdCqx3NUK3RIxUWFeKMA+hEIf3K+csTXDJb/XFMUMaivhR0wCVNUKpMSYO6B?=
 =?us-ascii?Q?c9vX7nX36dQNbJnXW4QYbMew?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e83b580-bb79-4628-f2f9-08d8ddcfdd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 23:06:50.9485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoAM0Si3l2+aQaArwWqbkh/nh8j8+AxDQzNM6FLTMkVUpQxf5LexB0NcPqWhPbCsMrIzu23LgBhav0GTt49yD3vfNOEiOKMQOy0Cgu0vnSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1970
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Tuesday, March 2, 20=
21 2:14 PM
>=20
> On 02/03/2021 22:38, Michael Kelley wrote:
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
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  arch/x86/include/asm/mshyperv.h    |  4 ----
> >  drivers/clocksource/hyperv_timer.c | 10 ++++++++--
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/msh=
yperv.h
> > index c10dd1c..4f566db 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -27,10 +27,6 @@ static inline u64 hv_get_register(unsigned int reg)
> >  	return value;
> >  }
> >
> > -#define hv_set_clocksource_vdso(val) \
> > -	((val).vdso_clock_mode =3D VDSO_CLOCKMODE_HVCLOCK)
> > -#define hv_enable_vdso_clocksource() \
> > -	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> >  #define hv_get_raw_timer() rdtsc_ordered()
> >
> >  /*
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/h=
yperv_timer.c
> > index c73c127..06984fa 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -370,11 +370,13 @@ static void resume_hv_clock_tsc(struct clocksourc=
e *arg)
> >  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> >  }
> >
> > +#ifdef VDSO_CLOCKMODE_HVCLOCK
> >  static int hv_cs_enable(struct clocksource *cs)
> >  {
> > -	hv_enable_vdso_clocksource();
> > +	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> >  	return 0;
> >  }
> > +#endif
>=20
> We had a confusion here. The suggestion was to remove the #ifdef here
> and add the __maybe_unused annotation to the function.

I wondered if maybe that's what you were getting at with your
most recent comments.  But the code doesn't compile on ARM64
with __maybe_unused instead of the #ifdef because
VDSO_CLOCKMODE_HVCLOCK is undefined.

Michael

>=20
> >  static struct clocksource hyperv_cs_tsc =3D {
> >  	.name	=3D "hyperv_clocksource_tsc_page",
> > @@ -384,7 +386,12 @@ static int hv_cs_enable(struct clocksource *cs)
> >  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
> >  	.suspend=3D suspend_hv_clock_tsc,
> >  	.resume	=3D resume_hv_clock_tsc,
> > +#ifdef VDSO_CLOCKMODE_HVCLOCK
> >  	.enable =3D hv_cs_enable,
> > +	.vdso_clock_mode =3D VDSO_CLOCKMODE_HVCLOCK,
> > +#else
> > +	.vdso_clock_mode =3D VDSO_CLOCKMODE_NONE,
> > +#endif
> >  };
> >
