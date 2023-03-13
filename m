Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1106B8030
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCMSQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Mar 2023 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCMSQd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2023 14:16:33 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020024.outbound.protection.outlook.com [52.101.61.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D87C942;
        Mon, 13 Mar 2023 11:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPUxD2yzT8RScZWW+2YUCOfYg4QX4zE/6drUHOJEFN7ZqUAF1UOkh+8BlG+1KiRiDpZ1C3hrxXnTAvVQpwsnBoXbjtj0M+N9IXLr93Pj3IL/2mNvKXBTMMZptdU4uBt+6jDWao3zMwN8DyLTJ2MiIXxyGjk4Af5hPU6xVwstsnNPo+it2aPYDpc0WoRYcZKbJHdmmSq2MsKvyg7JcZHxuOBpW/REcvONUAexrD7++GFpb4UoRsHReVWxJtRr+wi4ehEv3wJgEYtkiVmIYfX3Db0U6QF2BAz3qf3dSM4sKcTGMW9FZdfRDvs2zSobSlUUYvBPASeyXtefKwWF8Fowtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFJXpsbghxIDZOFFlu2qLyojhmqis6FAyUYPhwAeTBE=;
 b=RlCs3jVgsyAQhigmqyCVaFKPK0xGYZTuv/pK4AnPYUIrTSQFcA4iO1AnrPKj5WCcyMcb8u9cb39q8mmn6yHXc7UkKZ3xeRVnqeirTfBr8m3EwFsetB4l88aHi10Ps0xgfrT49Zx3BnEsvtaofMRPn4KiR0dH0COjc3Wx3XhIQEMl9pN3KgjNpzmprdFBE2XIJzvgd9cUHeA6AWP6L6e00IEDTshbqUGnxHLPENQhjabRhg7Bjo3seIYjg2lYtyWtxk6G/UR5jmCFeAPuVfFn3cngLu9cyYQ9tOuuz2cu5WZXHFtvxSpr0v8TuzYjF+p4UxIPkXtmbpmxFy7tkiAopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFJXpsbghxIDZOFFlu2qLyojhmqis6FAyUYPhwAeTBE=;
 b=WKEGTtzCTfL64Dwc+kchH5JEEKlIf7M4tyU4VVTWMNDBpB4dKC25yDengvpF+pfR3Y19h0XU/v+mh0UwwDG/Nk0ENc44tcmfDALdDEgQEI3BpL/VFTgnw68wT3ynsDY30uyz8SabyW7uqDNRMfmDTu/3L3pM4TUpKWQpKckJ/rc=
Received: from DS7PR21MB3127.namprd21.prod.outlook.com (2603:10b6:8:77::16) by
 BY5PR21MB1426.namprd21.prod.outlook.com (2603:10b6:a03:232::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.3; Mon, 13 Mar
 2023 18:16:27 +0000
Received: from DS7PR21MB3127.namprd21.prod.outlook.com
 ([fe80::5a51:71d1:aa62:a7b2]) by DS7PR21MB3127.namprd21.prod.outlook.com
 ([fe80::5a51:71d1:aa62:a7b2%7]) with mapi id 15.20.6222.003; Mon, 13 Mar 2023
 18:16:27 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
Thread-Topic: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
Thread-Index: AQHZVc2QXZ33ZRlfGU2JPNSvGGsDh675Al3w
Date:   Mon, 13 Mar 2023 18:16:27 +0000
Message-ID: <DS7PR21MB3127E3FBE1ABB368C6CBC097A0B99@DS7PR21MB3127.namprd21.prod.outlook.com>
References: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
 <1678386957-18016-3-git-send-email-ssengar@linux.microsoft.com>
 <87a60gww0h.fsf@redhat.com>
 <20230313170210.GA4354@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230313170210.GA4354@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b4b11f8f-4732-42e8-b64f-6bb50e83a57b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-13T18:09:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR21MB3127:EE_|BY5PR21MB1426:EE_
x-ms-office365-filtering-correlation-id: a4add02c-1651-4275-321d-08db23ef1026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ee0h+nEpht3eDWENxBhlELX4/h8SUl6ydPJGPJ1Ow6s59pttsQtA3JqEMq7Kt7QTuzCYOza9t+jBL8SJ9ilpdJ0lTlEHd2U+ga7jk4Z1m4UJpHfl++2NXVbQNg31abtq8EipNtWRTgSzUOmYUM9ZAzmJEuLnKFHbcdPfkVc2hmfXNMT5mbnyn3SE71livcIvhSsB900eWjydAm+zB6Pr3wmAD4tc15k3GzATk5NNlG4oOeHXzQ7JltDLTL6vqx3vG+H8tTcJE+VkvYcoOPdr2U5wrDTWnRyYa6nGuQeR4QhLyM3xV78eupy0lNI/oiBG5azNX5pTWwu4sLWdN5kzSq7hDOwpq/u3mhdJpVIYhMFUQVE66NbInqkG7owfLtt3Zvnw+vkvG/GVkGQU2GKlwmXO3EGJKH+N1hRK+7NCMT3JBffxyTEaOEYQbaEi1rvZ5dTXyUyBKOPDIjgubB3tsXAUiF8uXGirPlOyvZ3Xfzf/oN0VAQN3rjKksKy4tUxPbcYd1rv2jpQibFGZKbMl7mfzljY5kvhtw+uw4aFf5+qYO2wZTbqtWEgbf+8gfuvPDdWGuh3TPpqw5iYMu+i3OSGX3DSHpw7+kbWj7gNcPEO/8m3aMCTZImbgamUoc8y922qI/VStr/qj2icyEqw6iwOb/xohrGLvgWHhJpaDKctWEDlYBqnJoYoGPgeSN33zHKVWmCqFtiUU6CtROSQjjKeffw4x8lBZMaZJmjUMEVT3xBtJ8QJfgayOKlM352i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR21MB3127.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(33656002)(478600001)(10290500003)(316002)(110136005)(7696005)(71200400001)(8936002)(54906003)(86362001)(5660300002)(7416002)(52536014)(76116006)(8990500004)(2906002)(66476007)(64756008)(4326008)(66556008)(66446008)(8676002)(66946007)(41300700001)(122000001)(82960400001)(82950400001)(55016003)(38070700005)(38100700002)(53546011)(186003)(83380400001)(6506007)(9686003)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hZ2sP6PN+tr/+lMSrSlXOqsMySVfQnlNAkXYBufGjOqDcV4I+b7Q1OnMlO/F?=
 =?us-ascii?Q?URwMVGHYjxdxqWt4vmvyn/d3GCKp3MU2RDBk8nFyNmFyRnDpIdNieiXNpNBn?=
 =?us-ascii?Q?6Tp3EOP5nP+QqAQFaW1TpeFbVJ47dHrNGI+zqapRBiDz9lnQdxlJKGzs1Pz8?=
 =?us-ascii?Q?ukPr5Cn2aP5xh7OJAl3IO7f/XYjnu1vuuUz628ttWkHrrK3UJFChx2YLVDYJ?=
 =?us-ascii?Q?9TLZY2YFtBYAM9qh+bYmhGzdewFKPVpZax3ygExm0JCQlL0Z8ezh/JEmdmJK?=
 =?us-ascii?Q?mHSZKed60TV/mtMm/PBkuSumDeM6saw4GjORllz4Y2878V3g7FskUGXDRZZr?=
 =?us-ascii?Q?+IvStjP9xr1/5LlPTxYBltJNySqUWssBXh7UXeh5gq1xzKTGVbHS5Ow8qBGN?=
 =?us-ascii?Q?+AFC/rxqpUXKhjYdZzeBzjHiRKu4xMRwqn4QAgTaAfowbf2C4sVNyG+n13iF?=
 =?us-ascii?Q?NMo8zz0scHf4P16ymB+n5AVAkJWuzNwVGgLsFmyDhGM5Tbb3TnANlfg3OW8Y?=
 =?us-ascii?Q?hBJ3pEV8v5PVKwKvTfv4tT1EXYf/9d+NFFwC4AWW7hXnTC99a5HBGRv6RJ0T?=
 =?us-ascii?Q?Aom+hiS3HLTJ+kyRvl0AzVkxeRaXmpXJHvXvebmeleu383VL5GT11THF40N9?=
 =?us-ascii?Q?SIGbOKeTbYxe4I4RS665dbFpmI4JGi3MddqqsoMe8VPJb7MAepnBlEsEIwRh?=
 =?us-ascii?Q?JwCys8Edf7F90eRx1ARF04ppppTx3CMITdCkkMIKxvfWfPCsGeAfLA6g4XC8?=
 =?us-ascii?Q?G7YW6HvjEiT66lQ7dT4WpkjUFBSh5P5ThOu63iHWP/5MbTqAYasE59oUpO6s?=
 =?us-ascii?Q?LhpJsDGGoODeYx39IZUNw/bhym3DToGE5Q14iUYhr9BbYgWzNYoVkXI+/ELJ?=
 =?us-ascii?Q?J7EXa0X/a9ezJpYO9SYoQhhhNfAP+dtm9qaOxKOjYftMKSAhOEFVncOp0LZS?=
 =?us-ascii?Q?Tti7BAGPwXttJVcpoEpFSaKxEDMbmiVduzckbx7oV0GJb61XTRC+tIlbqpCY?=
 =?us-ascii?Q?jGNwd1U+w8t2+k3OJLNenAjigZKx9nOWe7rJGg5/A6SB4QH/ukWE+X+dbjId?=
 =?us-ascii?Q?CdPan2gtySfeqSe3VJmWVc216HkIVfEg6MDxz5swDJP1SmhYiud3stgdMQjm?=
 =?us-ascii?Q?HcCTY2pS7LbETRN6vy/MabZ2JlU1CSledenfph/2LpHaAZaa4MFRVMnKTbOk?=
 =?us-ascii?Q?W44RHNNSdoBuJoPnJgu8QalGK6guLLT7DeAPjcsD84JK5AVYsfpPXBJaIuJV?=
 =?us-ascii?Q?tDmWeHxyzitqo39MzgVH0CPY4aSmUmZeAVTadPIRIDjaID5I3h+3N119IeOS?=
 =?us-ascii?Q?4Qo7jsAPFWm9k4d/h2o76S+GuOH0SdS/W+U8I6bLP4e8u8SnwvDU/Kbx+6Gt?=
 =?us-ascii?Q?QseAz7vMvLQJwdAQH951xvOgHS9IRvdg02tyu/+SavjvZgVIAe7TVSO6//T/?=
 =?us-ascii?Q?QdCOOnxGXmu0FDgDjiOCdU2+lEcrRGqTYvguFUodrhBA3cS9rZEiOszdfPqn?=
 =?us-ascii?Q?mnSuwqIpjB06PMgoJpcabuIVordauFdDJJulXP5NGYfhWRYmhZU1raSQH4uW?=
 =?us-ascii?Q?AX0MLnCvcn8iarKwZwq8VftbInp/l63OD2KSGhEj5zvzGc8C0G0vDDT4ybfn?=
 =?us-ascii?Q?AMtLxEbGj2sAh5l3ATLSP7QhN7S4FFfAarOesz5tj9Vy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR21MB3127.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4add02c-1651-4275-321d-08db23ef1026
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 18:16:27.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zYjy3gUiYiYV19eIZ4FyTQ5WZcFltP8EDwB0o9DAfgkFT1c8VpcA1EKZwgZuKgvgMmjrVKbV2BIw/BC4FXtFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org




> -----Original Message-----
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> Sent: Monday, March 13, 2023 10:02 AM
> To: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; arnd@arndb.de;
> Tianyu Lan <Tianyu.Lan@microsoft.com>; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org; linux-arch@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
>=20
> On Mon, Mar 13, 2023 at 03:45:02PM +0100, Vitaly Kuznetsov wrote:
> > Saurabh Sengar <ssengar@linux.microsoft.com> writes:
> >
> > > Virtual Trust Levels (VTL) helps enable Hyper-V Virtual Secure Mode
> > > (VSM) feature. VSM is a set of hypervisor capabilities and
> > > enlightenments offered to host and guest partitions which enable the
> > > creation and management of new security boundaries within operating
> system software.
> > > VSM achieves and maintains isolation through VTLs.
> > >
> > > Add early initialization for Virtual Trust Levels (VTL). This
> > > includes initializing the x86 platform for VTL and enabling boot
> > > support for secondary CPUs to start in targeted VTL context. For
> > > now, only enable the code for targeted VTL level as 2.
> > >
> > > When starting an AP at a VTL other than VTL 0, the AP must start
> > > directly in 64-bit mode, bypassing the usual 16-bit -> 32-bit ->
> > > 64-bit mode transition sequence that occurs after waking up an AP
> > > with SIPI whose vector points to the 16-bit AP startup trampoline cod=
e.
> > >
> > > This commit also moves hv_get_nmi_reason function to header file, so
> > > that it can be reused by VTL.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  arch/x86/Kconfig                   |  24 +++
> > >  arch/x86/hyperv/Makefile           |   1 +
> > >  arch/x86/hyperv/hv_vtl.c           | 227 +++++++++++++++++++++++++++=
++
> > >  arch/x86/include/asm/hyperv-tlfs.h |  75 ++++++++++
> > >  arch/x86/include/asm/mshyperv.h    |  14 ++
> > >  arch/x86/kernel/cpu/mshyperv.c     |   6 +-
> > >  include/asm-generic/hyperv-tlfs.h  |   4 +
> >
> > This patch is quite big, I'd suggest you split it up. E.g. TLFS
> > definitions can easily be a separate patch. Moving hv_get_nmi_reason()
> > can be a separate patch. Secondary CPU bringup can be a separate
> > patch. The new config option to enable the feature (assuming it is
> > really needed) can be the last separate patch.
>=20
> Ok will do in next version.
>=20
> >
> > >  7 files changed, 346 insertions(+), 5 deletions(-)  create mode
> > > 100644 arch/x86/hyperv/hv_vtl.c
> > >
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> > > 453f462f6c9c..b9e52ac9c9f9 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -782,6 +782,30 @@ menuconfig HYPERVISOR_GUEST
> > >
> > >  if HYPERVISOR_GUEST
> > >
> > > +config HYPERV_VTL
> > > +	bool "Enable VTL"
> > > +	depends on X86_64 && HYPERV
> > > +	default n
> > > +	help
> > > +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> > > +	  enlightenments offered to host and guest partitions which enables
> > > +	  the creation and management of new security boundaries within
> > > +	  operating system software.
> > > +
> > > +	  VSM achieves and maintains isolation through Virtual Trust Levels
> > > +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> > > +	  being more privileged than lower levels. VTL0 is the least privil=
eged
> > > +	  level, and currently only other level supported is VTL2.
> > > +
> > > +	  Select this option to build a Linux kernel to run at a VTL other =
than
> > > +	  the normal VTL 0, which currently is only VTL 2.  This option
> > > +	  initializes the x86 platform for VTL 2, and adds the ability to b=
oot
> > > +	  secondary CPUs directly into 64-bit context as required for VTLs =
other
> > > +	  than 0.  A kernel built with this option must run at VTL 2, and w=
ill
> > > +	  not run as a normal guest.
> >
> > This is quite unfortunate, is there a way to detect which VTL the
> > guest is running at and change the behavior dynamically?
>=20
> Only way to detect VTL is via hypercall. However hypercalls are not avail=
able
> this early in boot sequence.

Vitaly, we looked at all the options and we felt this detection did not hav=
e to be dynamic and could
well be a compile time option. Think of this kernel as a Linux based Truste=
d Execution Environment that
only runs in the Virtual Trust Level surfaced by Hyper-V with limited hardw=
are exposed to this environment.

K. Y
