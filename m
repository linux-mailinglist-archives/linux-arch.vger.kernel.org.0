Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3296DB1C7
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 19:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDGRii (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjDGRif (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 13:38:35 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4600B755;
        Fri,  7 Apr 2023 10:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSYoa69jLx1qPLLcM+4LEofTMHIYG0/cqXDNEe2N2yEEJLpSuFJ8BYUFuwzl8p8vPEM2OYOyKlCG3Z9NFbesEbUz54dmD8geOBX2S6imdKD2F4pOpEZOQjvVqOgZ5+xeqSGn4L4+vyDb5WqTlQeYvvZR1IU1Kp7VnYAEheAdNycIDEuUPCDfoFByFjMDt+B2H/KmryO6QrXowkmwcpEVqU760BaEacBJ8HzwY5WhPQ65I6+HEqtG3hzgWcyz/pjtKACEqRVqbkgBuIBO5GEWWiEb+SvW8sP4Mik5K+6ePf7sJB8mYt6HKtnurb8QN4yVJzeE2Nd8FT0IuqvMuqHiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVcGRHhHPXNqIBrt0tENJPJnqyotat/A1hbaXL4BS2U=;
 b=RPvxdTn8rL66iqu0Omnz9wrWnl6uY5s2gofpsDSaalDIqbQMUKuGLnQrCY+VWZDp04GbZj8vbScLZB86eOo9Q5cWkKEiAkiT3Zd3KeOG8Hkr/Y/t9jsjN+zt8mrN1V+Ro6w9loiuOyJQyWAOSI1nFoHqpbr1HL0V08qRsbYW60t+c4966zdmCiWelbXo4VwJNKoMuuVIm941gXfATRsVecTj0hCqnuAF9Kd2OxgxJ5LZYWhTP7Htrw6C5Q8gsenMkYZTzDMRlBuu/Idhq/7zqZyIGRiDy011zfsW40CZKoh8NMzmYnxuQfh935821DYABK/67ulay0d+roGhtLK/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVcGRHhHPXNqIBrt0tENJPJnqyotat/A1hbaXL4BS2U=;
 b=ihGseaPbfl9d9HbYNKGrSdTR/XIIojyR3rTFdoRaa0vajBROLe5Wk5g8FgVSQAC7kvakpQselyU38PJP+SaBKSFCgwL4WKbl5OEXb7XWHvM32UeUlHLIh8inIaMf2GXfmSKQZCqkoTpPyIGuHiQ+8QEwacTBzMq8mWjofX6OPRk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1954.namprd21.prod.outlook.com (2603:10b6:303:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.17; Fri, 7 Apr
 2023 17:38:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 17:38:30 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>
Subject: RE: [PATCH v4 1/5] x86/init: Make get/set_rtc_noop() public
Thread-Topic: [PATCH v4 1/5] x86/init: Make get/set_rtc_noop() public
Thread-Index: AQHZZtQCvsFUj0Ann0ijc8Vm4YMcaK8gHlWAgAAB3+A=
Date:   Fri, 7 Apr 2023 17:38:30 +0000
Message-ID: <BYAPR21MB1688F9640E9006C184EA481AD7969@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-2-git-send-email-ssengar@linux.microsoft.com>
 <ZDBSHTEISe5rAHqn@liuwe-devbox-debian-v2>
In-Reply-To: <ZDBSHTEISe5rAHqn@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe7fdba0-018f-45a7-af15-0a75bbebe156;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-07T17:32:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1954:EE_
x-ms-office365-filtering-correlation-id: 7db32635-b163-417f-f152-08db378ee71d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqE6/NixICHbEs6dJX9vr9kNY6DtLzM09GYMLBvualmUcQIa0RJLZBueRMONT3RSnInX3sB845FVzYB9EfYemuf7tvCt8D52pmheC7AfZRUuctv2Ztn7HLXttn1yQ+RQkzKsZqsy4YZCH+FSwwwR6AC6kS+v1dHAHovQ0cOQHhUG5EaBSAUaehm3R8wK5ghUR/J7/TcuDlJ2QUkNuS8rZfi4sumFMKtyOIozmfOfb3vqcm3ra1Rjvhb2jATY8mYz05lfl/bxRYTG2010opJYBU6C0R76jyqu1mdtRB0I+iiN28dXGO7q2Zk+GiFF0wqZR/ZrunjR8Obka5/u58MqRUQnZXvIFceTkoE5XPrAIfq/fMPuQfx/nK0Gb8m2f4zPl8tDZj/Ui4EkMIf2hamTTuuV6dVE7/SUQHycXYsPsCygxa8tWNQ8smocnbSWhH2uKxt0ytAWEpKuiDQFJ5lCTBAucC6XwuwcfvB6E/YgQ2BHbNkMEB4j0CFGqa894h/S4UzH+an4VEjRD21EazxbbrJ4FdCt0WKyGIK17nhO3Wvz7cUxo28SnI40Bq3pObFzl4HYssBo7rhCTRB5hQwwKpc3QpKqzMiljmmZvg6UcAaqTfUrHj/lHEcTT6YVsn7NraId9ko9J/wFRFbX+CsgZIt0oabK2T/UkXh3u8efN3w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(786003)(10290500003)(478600001)(316002)(110136005)(54906003)(55016003)(76116006)(8990500004)(66556008)(8676002)(41300700001)(64756008)(66446008)(66476007)(4326008)(7416002)(71200400001)(38070700005)(86362001)(52536014)(33656002)(8936002)(5660300002)(2906002)(66946007)(7696005)(186003)(82960400001)(82950400001)(83380400001)(38100700002)(122000001)(26005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6nkqmYeIxbX3dhU9Lg1I5YzZuB96kPnTwQAl5RwMyKzgcW50Btt3hnabRYrT?=
 =?us-ascii?Q?xUYYsqXMcNHIoxa4IpNI/dxWM9uRhk1qL0K/4sifrKPDwAHEbrUoAvvZP6PK?=
 =?us-ascii?Q?DPXocTpBLnWyA+10OMhwd7+WZx7gxNcjugouZhDn0tQAGcHwXBJS5SghSguT?=
 =?us-ascii?Q?OB7A4I+mWALqPVZSpzjBVD9c6z0akIesHOOiX5UhftMDLgyJMptYvOoKQqIZ?=
 =?us-ascii?Q?hf32CpBQ0yd/s1qwlXk+q2v+hpbdO6QUaR+MLRlG/FG6Y54M2kP6k+BGUkJX?=
 =?us-ascii?Q?xvi1bJlB8sZNLEHqzQq7GzyaXCpVsNQQYhdv25wpXZCHsnX0R62f0oKjof0L?=
 =?us-ascii?Q?jYBjaJFFZBHjEYoiXvRs6ipfvyN1sm2ULCXyAXhi560YbTYFt9L9uYJm4JlV?=
 =?us-ascii?Q?yp4CJIg+2Dom7qBHy1vKwX8Cb7c2sgINYje/0KmoMsSmD8bL7M+LUM54VKoi?=
 =?us-ascii?Q?ON4XTaAhxgC/mOJvFJXlrB6Im5LIxQv2lw7ZHfDynp1DaO62gI6ri0LYz08r?=
 =?us-ascii?Q?GgthaP4bR/NnYETDqJkzmD6g1UaiGsF+vWr8LN31HeLEYsSJ2KMQWsOzoqu2?=
 =?us-ascii?Q?5qdFh6EcFkJ3V2jyFuVmVWMC/3W0++qyztC8QKoOrpslyAnuGbkw/e4+vJdU?=
 =?us-ascii?Q?+gDQZqFKAcF74bgswfozqka6SYLtyF4/O4jXM0n7f5wD3ZqoIYOC+0KvEmeg?=
 =?us-ascii?Q?oEvO6HEuJF4lUQHY2XmOSQTRW1w6k8d6AStGmgstHz57aTZrotNIpSiL1biS?=
 =?us-ascii?Q?UWkmQwkWaTh9GpqgnFAEHZSjERJ9/uyAdzAfSYTZHVAGjKqe7AGWSsDw5J58?=
 =?us-ascii?Q?C6pj4/NmDge6PX+g553FZD4pZsVAmkZwZwNAftjSgrwv7mB7b/66fw5YLaxo?=
 =?us-ascii?Q?UdU9icIDrUt9j9gAzY2qiLfdYxwRZPEMUYp8YSkBj93bCiW7OeiQbPB99e/o?=
 =?us-ascii?Q?Xi5+BbtkHB2jk5Hh6I1tyn4rsGdwxY95TVUrG4NYO/klqtAO2LCjWgjPcYIO?=
 =?us-ascii?Q?MfsxpSH9fzxsRWkhviN0aQDyS/B7Tdqn52gHkVhCtYXZJt449mzrdspuIjzB?=
 =?us-ascii?Q?Q1f7KyJ9sfKPbGlohMYXTGGG2HxoN9gWrIbWgDaqNbTr/2GD1Mu5HQwQ2B0S?=
 =?us-ascii?Q?kTxGhuPc0M3aTEPMHx75lxYnajV00u9n3phJi+pIXaBXTiyCw+9QOYclZTMM?=
 =?us-ascii?Q?cFqJpLTjptoVnQRXaem+CYZd+8jAGdr1K/6ogimOmBlTvlQmTJsqi5WBHsOJ?=
 =?us-ascii?Q?cjScazSPRAqJHithQPj0cRoSuwFym2I38LKVaWNX8BPo3tyaYZHnS096W9Lq?=
 =?us-ascii?Q?bNDIlZka7dvW26PDbI3EKlITzcBdnLckj7bEiFuXqTwpaOko+pK0JS9zQSLI?=
 =?us-ascii?Q?375vUbaOxFpjDQ6ibxfTJOVQA6Zav3EuOzs5C+b/Lp/vE1FK/Z97PF1DOzOd?=
 =?us-ascii?Q?8xlPUjMORRmTtK2PwusT38KlepghUtK2z+MM+fKbtAOxxXkcGeX7gR85ZDDI?=
 =?us-ascii?Q?wMIzz/hrI2cvWAXsihAl1GlKRwc6vFoGJugTomX9f4owUs7d3UmLvNFu3qXj?=
 =?us-ascii?Q?JohmW9/SqxZjn9ODYXP3oyJ46OC4FIdlJd01ODb6vEuFf4wtJ83tLun8YUsG?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db32635-b163-417f-f152-08db378ee71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 17:38:30.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIdSQBt98eUKJ1Elk/ZVJqOR1RcsLXS5zPavL8cI++Or/Jr9Jo7IK81N/eRAXRYRCbJEn5SskvzSG+pxiUhHBWv238hFtkyG2Gqupzi4Dt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1954
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, April 7, 2023 10:26 AM
>=20
> On Tue, Apr 04, 2023 at 02:01:00AM -0700, Saurabh Sengar wrote:
> > Make get/set_rtc_noop() to be public so that they can be used
> > in other modules as well.
> >
> > Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Reviewed-by: Wei Liu <wei.liu@kernel.org>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/x86/include/asm/x86_init.h | 2 ++
> >  arch/x86/kernel/x86_init.c      | 4 ++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86=
_init.h
> > index acc20ae4079d..88085f369ff6 100644
> > --- a/arch/x86/include/asm/x86_init.h
> > +++ b/arch/x86/include/asm/x86_init.h
> > @@ -330,5 +330,7 @@ extern void x86_init_uint_noop(unsigned int unused)=
;
> >  extern bool bool_x86_init_noop(void);
> >  extern void x86_op_int_noop(int cpu);
> >  extern bool x86_pnpbios_disabled(void);
> > +extern int set_rtc_noop(const struct timespec64 *now);
> > +extern void get_rtc_noop(struct timespec64 *now);
> >
> >  #endif
> > diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> > index 95be3831df73..d82f4fa2f1bf 100644
> > --- a/arch/x86/kernel/x86_init.c
> > +++ b/arch/x86/kernel/x86_init.c
> > @@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
> >  static void iommu_shutdown_noop(void) { }
> >  bool __init bool_x86_init_noop(void) { return false; }
> >  void x86_op_int_noop(int cpu) { }
> > -static __init int set_rtc_noop(const struct timespec64 *now) { return =
-EINVAL; }
> > -static __init void get_rtc_noop(struct timespec64 *now) { }
> > +int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
> > +void get_rtc_noop(struct timespec64 *now) { }
>=20
> I just had a second thought on this -- do you really need to drop the
> __init annotation for these two functions?
>=20
> Thanks,
> Wei.

I think "yes".   In Patch 5 of the series, these are plugged into
x86_platform.get_wallclock() and set_wallclock().  The
x86_platform.get_wallclock() function can be called by
read_persistent_clock64(), which is not a __init function and
that may be called during resume from hibernation.

x86_platform.set_wallclock() is also called by a non __init function
update_persistent_clock64(), which is called by sync_hw_clock().

Michael

>=20
> >
> >  static __initconst const struct of_device_id of_cmos_match[] =3D {
> >  	{ .compatible =3D "motorola,mc146818" },
> > --
> > 2.34.1
> >
