Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0046B7F76
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 18:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCMR12 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Mar 2023 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCMR10 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2023 13:27:26 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021024.outbound.protection.outlook.com [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20996BDEA;
        Mon, 13 Mar 2023 10:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn5AQzCXXUGHE6T+XbItOolJfCFVc0ebza6TabmyQO/46aaBuy/qVBy6dVOo0tb7VLXUfAuaMOn6zmGY6j1x6FYiS83MXT8bMPO0upI9qgz4Ezj2w7pKvoJLVLh78X6QuZY3IJjsJD5PtMBqKqhWkGWs/5gbG6BkwmnIYy6oo9igRP0wV9gWkieYoRHuDPNeFfMoBJXIOCqLNlf9lT+khVgY7Xle51LnGFhpmz0wJQ9v+K7I6wgATxJu+GYwNDDqxpvajykT0gILjjty4U0YYtZkjxPYhRibxBvz/ZtJhJdBsSKVRHExDpOKzaxYhCT/uMExktTVk2fqWntMqF3TPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/CMWN15hWBGS9HglGzHY1pT6XWALkCWdJeowVpxHMQ=;
 b=Fy1kuYfVDWJOTxlYYHNOUBMtvURRepc6EaQ9YFymQyTgLF8PNhOqDRPOTQF0yMy/E481BEKZn977cUe6ewc2K9FMyFGBsugmriTdBG7MK52xcJ28YtVp0NYvTy4o9SAMBTBUGMbcdYfXOaJDnPhgPqL16PcvwFum3FG9iw1YaI9EXG2Mv7pIAG7N93C0keonB1OCNtCo1ylYWWwSaOC+SS8quC+vRGKutIWJwsmx1cO7oq+VR/Yrl9aCSewLqifcfgUM8Smib8MGZPTR5UIfeMphTGzU+YQrz528yaXaxJGg2n98CTZ44SiyhaMkGove7EexcofttIdmqJoXL8JGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/CMWN15hWBGS9HglGzHY1pT6XWALkCWdJeowVpxHMQ=;
 b=fLjej0hhV4QK3JgSsJaqHcd5DCbrBlY0sP8xgMza8sSbBNyMqgXbjFqv9yCZM6NWUX73O0LZGXu96qU0U0v4HEj5mVD/uuyXPv4OcAzXQxd/oCmtAW0/1U/YF7/pETNcs/xhEGd2wWCEkePVCVZ7gB5ej4+3HdW68Vybgscwyx4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3218.namprd21.prod.outlook.com (2603:10b6:208:37b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.3; Mon, 13 Mar
 2023 17:25:39 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6222.003; Mon, 13 Mar 2023
 17:25:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
Thread-Topic: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
Thread-Index: AQHZUrYLJvWcOfiptEWTYxRlOTKsIq74z1wAgAAmUQCAAATasA==
Date:   Mon, 13 Mar 2023 17:25:39 +0000
Message-ID: <BYAPR21MB1688264502B9A863E6F9E570D7B99@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
 <1678386957-18016-3-git-send-email-ssengar@linux.microsoft.com>
 <87a60gww0h.fsf@redhat.com>
 <20230313170210.GA4354@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230313170210.GA4354@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f89bbaf2-3f09-4c1c-8ec9-0c71ecc27c15;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-13T17:19:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3218:EE_
x-ms-office365-filtering-correlation-id: 155eaea8-6658-4773-012b-08db23e7f711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vevniwS1+AkWkErg7w8taVjKgf+OZeMeetsk7JfaAprm+Ufz434oWUeMOV9VsIxADebPvjYjo+0gP0c1R6em8f6baN8K5mKtm9kt6HyCDSOHso8nyr6V1361f0W92BkdOaPuUfG054ha/tOJw6asuJhebb+oHAhkd3gLfpOhTxFsIuwX+QhaZk+ofMrPBSl6zO3JWDfK5ECykmTWNAUFEIeT8WkrDoO1YAwQ6m1j1SqVt0oWJsk3j5/YxoCSNl0yisqCRRVtYd5fmS6D22nWumpXaAp3YJwcN+RzVVBc1Mc2Ed33ANwBaSpAUJ4mIypycadWQ5U7XrXg6TXUA/Z4aN43/9WG6T6Y7a05Sk4GkJDiDT7qmS5VYC/Eaw6M4MoYpkcPcw5pv9W3zHoFEAiqTe4w0uxpMt4IyEDyDGThqK0OLYrulsVvKeMyz4Ml4vB3SlU3QK+2ta3nr2OkXkOMzUzlURdYIImFr5xvHbLQQs0yacP+YhM3x7rI1ri/SVgXKaXTEaimTDaMLHXaEy5pRxlWdrcoseT9YHm2ngvoUDCn5NvlCuW1j2gwhmfttVZ8CqLQAcbRBmFswuIzFSMWMSHEnDshVJYc+whRkkwJr9TmGeaBlYXXc5pPwTm2wAggj6fV6AKHlCw/XUIzotvCka228pnJeHoQY0OUsZmnD+rWrgb3TBLuhZrOkXKz/msfSx9mL0iSpDF1s2OYd8t6GFo4RkKSZqBTRqFfClgxrDVNy+GILEecM3WCfcFPot+Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199018)(7696005)(71200400001)(6506007)(10290500003)(9686003)(26005)(8990500004)(478600001)(83380400001)(110136005)(54906003)(66556008)(76116006)(4326008)(66476007)(64756008)(66446008)(66946007)(8676002)(316002)(186003)(8936002)(52536014)(5660300002)(7416002)(41300700001)(2906002)(122000001)(82960400001)(38100700002)(82950400001)(55016003)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TYFcjgI2LrIt9pCckqu9EOg5ki3t4vHfGLQMV8sNN+O87Ncld85NF1O18udP?=
 =?us-ascii?Q?jx9Fkpb7Qk/j4VVQbS8BcRoMcjQaZQ0tSKrogNHwozLrFlW03XIrVDoWZkpC?=
 =?us-ascii?Q?UzGrmCpOI9rXYl/JLEs2Tf/Q/A9d2B/GA09iT8btYAe7NLYG1cbcFoPXcHO2?=
 =?us-ascii?Q?sXAaSDDtq1NcKIhvXuvlqlri4EMcB5MmmeUUQYSi6CM0psOeznaSN2OTgnEv?=
 =?us-ascii?Q?pboWWiLua/UL+nR5tejRYHX8ehG07yhkVtTVkx1/iZKE0X+haeSDpw7BACK3?=
 =?us-ascii?Q?FtDbtwZaduWrgkot2B8R4MEA4/MimsVaH29phy3sX3UGxzWLGHOHT1zpvwEv?=
 =?us-ascii?Q?mWQYnULbBWXzPK9IfOlLuWYNlbkU6dMm98GCNScWKe97FPJEIQTAhmqaqrpb?=
 =?us-ascii?Q?dJj/SltoWIRg1n9hCLN2gxYWSiAYpcl+nBDbt8+S9RrOpcphDxHffhXacZiD?=
 =?us-ascii?Q?9XubgalnKpcWEwSQXw+s/o54GuePhk98TI7gIUUBbfcFsQeJFolOx4upda+b?=
 =?us-ascii?Q?wJv4aL+wL3wEXW+oEkBBuII1ofT/Dz2GdLd2E221hhWGoPEh6En+nsgzH00z?=
 =?us-ascii?Q?wy+zn7sZUOG24ifMaUeJwH9tJwe2Nc5Fa0vS5GyqNoUQnPsyO5ws1YBaYoFO?=
 =?us-ascii?Q?3/5a0mvorn5v1EYLZMMHaSK4EoR+/gdGskzRm63QE/tPKWm0y3VZQgqMk/4m?=
 =?us-ascii?Q?VOk1P8aG61jvIyOZFlbUcH9qN++HQBXQ8kvMM+Awv/lDbLxngBSBvu2TSDE0?=
 =?us-ascii?Q?g7Ln6tKipD2RpOvaibym9uTM3WSichywfak55lUa31EuAoKH6l5hR6ogoo1t?=
 =?us-ascii?Q?5vh40I157RTIfuV1mNUJKjCJTXoAAVaO3KCjN50fAQ6PMdW9eAAxipniPg5j?=
 =?us-ascii?Q?ru6ZBW/pMjsqm4oConwiJ3LYYda3adsb2p8RGQwxY25Vz2nvzMZLaaiI7H+p?=
 =?us-ascii?Q?iZOjMAQ8ETQ3YCRro5ElSwvyxrhipCEfycPOPN/bNPMXFax/Hg7ajXknD46R?=
 =?us-ascii?Q?zcNFEa+E7szA9bCtrHmzoGZ8ZrCS2VBBuyZ5cOvLyvTzArrQEX7PnVhBBbUJ?=
 =?us-ascii?Q?d+U6t90U/k1EeLXcJEbvrmHq/i1WibKeJPxLDCSq5VwYZUbxpw61eIRj0/dE?=
 =?us-ascii?Q?VORPOYo4n+2/U1oppw0ObELitPdoC3SuWriXng8DU3kQplSt0j7KYAXllcAq?=
 =?us-ascii?Q?w/3gabkCw2qN/MMKrmeYW4v++AYHFmc2PmYiMzEeJeIZbY2k57bvgUNYuJLG?=
 =?us-ascii?Q?CF6BtWvrKRJdIZ63FQ5Yzf6WQCmcMP1uBa+5cBb6DnyrR4v9cW04177CFQ5E?=
 =?us-ascii?Q?PVu1pk+ejbCXiycW023MeT/Yuu4Idgp5+hVGUdccnAf0VzEOkNJ4C/bd0BkU?=
 =?us-ascii?Q?WurMPMPbP5WSqvAOMdiCYhSOnjXg3FBZLgIWjH3A2PZYBF4CglgWP3gT7P1u?=
 =?us-ascii?Q?+Yx0QqQ/4N/58sDUBr9a3JHIbgwPNLaP1bJlHv93p8G8fR25frY46uVPczw7?=
 =?us-ascii?Q?4SRSGUHO5v6/yu0fkwTJUwVwF67GnmF+bBTIJILAkCXcA1nAucKFYqLvMSM3?=
 =?us-ascii?Q?+5E/EmbJLbrzjcQ272qzXNUH7HNtR4vlr7yEI0ruT6gJu8pWro/cfHt93FzG?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155eaea8-6658-4773-012b-08db23e7f711
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 17:25:39.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2HdeLwtl37rclVtGXAsF1DdM0kFSsPKKdtbstzjmtsngYpwVaWWAc1Cj4UtMVfCquwNcmyaGkHA6u8A5czbN1pNnwUrH7CAk5FIipd/45s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Monday, Marc=
h 13, 2023 10:02 AM
>=20
> On Mon, Mar 13, 2023 at 03:45:02PM +0100, Vitaly Kuznetsov wrote:
> > Saurabh Sengar <ssengar@linux.microsoft.com> writes:
> >

[snip]

> > > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/m=
shyperv.h
> > > index 4c4c0ec3b62e..4ff549dcd49a 100644
> > > --- a/arch/x86/include/asm/mshyperv.h
> > > +++ b/arch/x86/include/asm/mshyperv.h
> > > @@ -11,6 +11,10 @@
> > >  #include <asm/paravirt.h>
> > >  #include <asm/mshyperv.h>
> > >
> > > +#define HV_VTL_NORMAL 0x0
> > > +#define HV_VTL_SECURE 0x1
> > > +#define HV_VTL_MGMT   0x2
> >
> > Don't these belong to hyperv-tlfs.h too (even if they're not directly
> > described in Hyper-V TLFS)?
>=20
> Can move these to x86/include/asm/hyperv-tlfs.h
>=20

While VTL 0 is always the "normal" VTL, the use case for the other
VTLs isn't controlled or specified by Hyper-V.   To me, it did not seem
appropriate to put the definitions of "VTL_SECURE" and "VTL_MGMT
 in the TLFS include file.  My earlier recommendation had been the
Linux-specific mshyperv.h.

That said, to me it's not a big issue either way.  I have a preference
for mshyperv.h, but could go with either.=20

Michael

> >
> > > +
> > >  union hv_ghcb;
> > >
> > >  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> > > @@ -181,6 +185,11 @@ static inline struct hv_vp_assist_page
> *hv_get_vp_assist_page(unsigned int cpu)
> > >  	return hv_vp_assist_page[cpu];
> > >  }
> > >
> > > +static inline unsigned char hv_get_nmi_reason(void)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > >  void __init hyperv_init(void);
> > >  void hyperv_setup_mmu_ops(void);
> > >  void set_hv_tscchange_cb(void (*cb)(void));
> > > @@ -266,6 +275,11 @@ static inline int hv_set_mem_host_visibility(uns=
igned long
> addr, int numpages,
> > >  }
> > >  #endif /* CONFIG_HYPERV */
> > >
> > > +#ifdef CONFIG_HYPERV_VTL
> > > +void __init hv_vtl_init_platform(void);
> > > +#else
> > > +static inline void __init hv_vtl_init_platform(void) {}
> > > +#endif
> > >
> > >  #include <asm-generic/mshyperv.h>
> > >
> > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/msh=
yperv.c
> > > index f36dc2f796c5..da5d13d29c4e 100644
> > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > @@ -250,11 +250,6 @@ static uint32_t  __init ms_hyperv_platform(void)
> > >  	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
> > >  }
> > >
> > > -static unsigned char hv_get_nmi_reason(void)
> > > -{
> > > -	return 0;
> > > -}
> > > -
> > >  #ifdef CONFIG_X86_LOCAL_APIC
> > >  /*
> > >   * Prior to WS2016 Debug-VM sends NMIs to all CPUs which makes
> > > @@ -521,6 +516,7 @@ static void __init ms_hyperv_init_platform(void)
> > >
> > >  	/* Register Hyper-V specific clocksource */
> > >  	hv_init_clocksource();
> > > +	hv_vtl_init_platform();
> > >  #endif
> > >  	/*
> > >  	 * TSC should be marked as unstable only after Hyper-V
> > > diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/=
hyperv-tlfs.h
> > > index b870983596b9..87258341fd7c 100644
> > > --- a/include/asm-generic/hyperv-tlfs.h
> > > +++ b/include/asm-generic/hyperv-tlfs.h
> > > @@ -146,6 +146,7 @@ union hv_reference_tsc_msr {
> > >  /* Declare the various hypercall operations. */
> > >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
> > >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
> > > +#define HVCALL_ENABLE_VP_VTL			0x000f
> > >  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
> > >  #define HVCALL_SEND_IPI				0x000b
> > >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
> > > @@ -165,6 +166,8 @@ union hv_reference_tsc_msr {
> > >  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
> > >  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
> > >  #define HVCALL_RETARGET_INTERRUPT		0x007e
> > > +#define HVCALL_START_VP				0x0099
> > > +#define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
> > >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
> > >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> > >  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
> > > @@ -218,6 +221,7 @@ enum HV_GENERIC_SET_FORMAT {
> > >  #define HV_STATUS_INVALID_PORT_ID		17
> > >  #define HV_STATUS_INVALID_CONNECTION_ID		18
> > >  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> > > +#define HV_STATUS_VTL_ALREADY_ENABLED		134
> > >
> > >  /*
> > >   * The Hyper-V TimeRefCount register and the TSC
> >
> > --
> > Vitaly
