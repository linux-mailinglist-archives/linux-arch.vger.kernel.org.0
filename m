Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4CF636035
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiKWNm3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 08:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiKWNmK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 08:42:10 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022025.outbound.protection.outlook.com [52.101.63.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5D26A6B7;
        Wed, 23 Nov 2022 05:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSqYARuXqXMYOMffju40kbba/KOvcTm4BNr7nz4u3PMJ1xdNRL1/Nfji98e4F6iLF+aYslkD9hbe+pthIS7W3Ykx4tqxw/f0uPezHfBf+zKG2aFJVipS/YZZu16AHwza4a6W9lJkvlTJLKTtMgB0wJJ9ueWaHl5DImR2PPZhXyf9tTLB1EVCnG4KtNx6mAqAQZ5f6JLjM5u+sVyleHkMTk3dD39HF3zuUIKsIPlGsDPoi8LWAH+IEQvwrMyUMmxqiTB6UnFJDljH00XFUHSkYyDt/0Thwfw2kdvAtwg3RxIaYRG0M3EghO/omyhbGtE55LUVhbkgfKge9eehT5iJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqRDPEjh5EphBxxdVegy38axHvZ7wwnggr+jflnkLJ4=;
 b=NxIZx7tNTwEpVl6+71NdCjqYs9PRrW6EQ2y9giK6XJxQctrU85NzxJpU+2fmBnldFDJVxJRl0Jd4pyWVWKCLpF7JI5fIy5bREucNuTrOZDJzzWszVI+9H8V/tqVF0NSbblCmA4GrjmNwSUDaSuq1rp55vHAyaaISvj1am7hqBWIYd6+sEnucTBa6EkhkHrXb4szPPE67ts/gJ13Vm9IJqxZpzZc8e/ECoUh5P+OxVKnwEQAL8K/F5KTmNUTge3eTvfpl7DLMXQMW8DzxGv5q/RC7Y2IlQ5B3dS7BZ4cVAmOWYdcBlmxiQlvjPr1QUWUO9XK91VrvwrcGveoxfBiOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqRDPEjh5EphBxxdVegy38axHvZ7wwnggr+jflnkLJ4=;
 b=hNt/OTNKU7b2YsQHdULiVqganh2W0Pc2OzEshKeo2iIDCuf46uoE1x6lxqcc1ufgDMX4yYHSImCbIMB8Zy2Mf17yQVtRZSmJvMkvXhSzh/cctDl7QcXUSJz/2cjQrtTRG3sxNsr274HkQBQipGqfSMcToCUfVAZQxfp92f77kaw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3238.namprd21.prod.outlook.com (2603:10b6:510:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Wed, 23 Nov
 2022 13:30:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5880.002; Wed, 23 Nov 2022
 13:30:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHY/eLxUC+R7dtU7k2iFNVaV12Qj65KDzwAgAHMAYCAAKUk0A==
Date:   Wed, 23 Nov 2022 13:30:23 +0000
Message-ID: <BYAPR21MB168849571A1FF2CD9BFD8579D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-3-decui@microsoft.com>
 <20221122000100.bizske6iltfgdwcu@box.shutemov.name>
 <SA1PR21MB133596B911C6A45142B83B52BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB133596B911C6A45142B83B52BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=14cc37f2-9a35-4b1e-9c6b-34c156199a7b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T02:56:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3238:EE_
x-ms-office365-filtering-correlation-id: 65bce53d-b5f0-4858-07f0-08dacd56dfd3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Zqvr5ObxQvLZJ3/eFQBuwgOQpuJtH1Ib8pmyCm7feZjWV3k6cWFnMBcbI2OjOQCqPvfcHDFYWzi7zX8+Q4a/OVF0PuSGIlXn7zagelOu2Sw6aepPsd8hrFcy61BbxqpCRzcbUpzeUBJTVWQs6C5paMVu3X6qAu0BcY2JCTxWyyse63nw3TQfZiuxz7lSFHP8zzYv9EvgSQS7Rbi/l1J0YjlpWm9mTffHpPRaXEsAl1EuHGbLz0XipiaJcP0Wjk9YILzpPoACuLa01L+UgLQWTlAOlOh8Cq//vY6qriUJkARJfMzrmcdboE8Jzba82DJ+S1NhWkgnFjgC5NUVlOft8kHKJ44cLKBLnBjtB3NHvepxNJWhIG6OdyRjLRrPghs96KaOhbD2p23UaaIlmkikbzPtTvzGgRRSfwAZOmRT26pzLrxyh6PtIg8ZhNRmNNPQkJuRXUU88rvWj+5CRLrkWMmxCD++CKk6S2GlAJ1njdE4EYiKJr1nnCc4MQaTXGoODqBgQY+pPuoJdfq9gy1tqmtv5BcWEE3Cyc1/J9LjQVw5lWgJnF4cTN5SvOsCjaGRNmfF+UrwyslcQeWMlizLH33pg41dKI849TAaLikaz6s+CHZ58+QdMPYLKDFFGfcD4SKa+cFbdQVqGJefAIBQqhwUZZUWwURxn3rOxZjAHC9EGoXYtcDsVEQnLBSmpz/pkaV9l5aGQEY5KkB+wzqCzlDV1fbIWvEQZ8J4AZUA7u3y8SKuTXI44obBOEs4Og4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(2906002)(478600001)(8990500004)(83380400001)(86362001)(5660300002)(122000001)(71200400001)(7416002)(186003)(82950400001)(8936002)(82960400001)(52536014)(38100700002)(41300700001)(38070700005)(8676002)(64756008)(66946007)(76116006)(4326008)(66446008)(66556008)(9686003)(66476007)(110136005)(10290500003)(54906003)(55016003)(26005)(316002)(7696005)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6jKA2HWiZiDNDsNciWcEBtHUdOx5NdHD4nUWMIB/pQpek4hGN+GXkiL+Wtg5?=
 =?us-ascii?Q?+0wkeIYNje86Exb+Dmn8jXCmN3cVCxUq0inwwv6rzCKbL8mb3s7ZBj6fCVjd?=
 =?us-ascii?Q?lgQCXtGw3TVlaK59mG6OXvQlzQ+hWpDxah8wU+Nm+DcQno5HLMczzAfBdkHF?=
 =?us-ascii?Q?UyxLeuP7GSgbNnw3qQKAIj8IpeLKkb9DCDYTEEVwlOMWFj4YPlptrzfJJjyl?=
 =?us-ascii?Q?YUDPa9vpr6iEjcmp13UxQnNCEdrHNgBUPzUE0RxBUBGON3mrOrtPfxUDINs/?=
 =?us-ascii?Q?B11LM5DKZhRS/8IDh8TVbg+Lb7pSCL+eeR3SnXZbBqgVatgWsIyLFDok/y/f?=
 =?us-ascii?Q?4O7BdHn3vEUT3rQVdxeQOIFhffruaOi01GQT1H5koACgo7/TMB+OiCOAK+8u?=
 =?us-ascii?Q?j9mxWDDazQ7QyTYDf86CKsQ5CUTJIiSHMZPSErNfdOXIQKFjPIdJ1lE8rTHB?=
 =?us-ascii?Q?Y4+dO4bPdgKlc4uFCQRcxbL0U3YUF5X/E4OZCUqQor0P/htZglHdikrxrQdT?=
 =?us-ascii?Q?H2KoopFVzHn+6mhqCQFwJvN+zXz1o0wtc0j2f3fjXw3t6HxujkW0uzCwZjAr?=
 =?us-ascii?Q?0x/GGkdBKrgePIdFEQwdzLZVLsfnOOL3lLO0vpVqooS3SGk1PwoYL/P/MIZX?=
 =?us-ascii?Q?/f7tUPgPjjVpNaQHrra4/NEAZXWx6QkP7uxrt38pDtrlW64vN5CcZ0x6UUmO?=
 =?us-ascii?Q?HFVA3x0YEtphZeOOFZckckie+tPhrrD6pRcl4AOd9qaAxnQTGg1bSYFHtA8N?=
 =?us-ascii?Q?G2csJsGpbtqunUK08yXnPkjmKY4N8InHcA5xa/n84GGyQwJH1KfgVoDP6v5m?=
 =?us-ascii?Q?ZOeD5e2SXZ96Uijq6MHuCPrm+jKikos2esOqFHfmlNVNuQcpDNdW1R3MsiNy?=
 =?us-ascii?Q?I7EPsvYay0SvicZY5u3Z/mGYAuY1QZythITeJgAml/cHef8cCqaX0cfmWuiD?=
 =?us-ascii?Q?M9ug/e7hNT0JosEkKwq74Ts3RK/yK72f2a4mGW+5XxKghBn0oB7kakaw96ZG?=
 =?us-ascii?Q?r7lZ26NaF/F2dLUv0C4TE/U3xltWI4X7V81KAV4KBPOemBCJjY8t/Mbesn7E?=
 =?us-ascii?Q?WzJQSMx5D2Mds/1TR4UWU1mg0JleujGB4HDi/nkesjb538Q3u7md8f58R5N4?=
 =?us-ascii?Q?/ofWHHcshx7+eInxSgCDNkt7+ctaW/iAYPTKmXzWZYN9OHFThEvjFf/fdJCt?=
 =?us-ascii?Q?im1+EveSMhHdz/Dxr0wgnjzlkYyHvJnZHIxrDVjG11Lk0dUY+Y9vgUlLRk9+?=
 =?us-ascii?Q?Ry3StVdcodnZmaXSSPBXfpxr8Am9+XuIdgEKvirxHsHDZ9A0VkxknDHuR0L9?=
 =?us-ascii?Q?LzY12rUzOo922ctt820SXhJqcx3Q/ki68Y/hXf9oEY/Hr5Y81hEk7vXt0yU6?=
 =?us-ascii?Q?gZBF5+vBiYPaj/vioI40UgacFZHWgKWqjxH+ZD0ZbiivjgwC3b8MVCLVjBpW?=
 =?us-ascii?Q?mAdJExHUE4MYjrR5oSIsPdGkgw0y+Omjd4ap9CRwmqhHEmDFPj0ClbuKQiQn?=
 =?us-ascii?Q?+FfGezjBKx6+9PBMZRBLtuZ2c6Cpe4/BJuFyj74M/TS9MdFmb3vH5VqfIkX2?=
 =?us-ascii?Q?vCLqYAjm9S43kWdzcMzP/BnsKGK9mSgatpudA3brxDNuvl4czwDhTJstqYC3?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bce53d-b5f0-4858-07f0-08dacd56dfd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 13:30:23.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruve6Ur4aM+mZkPBrgyOziptTPNteDgshuAKgCgU6WxfeILoaIZQSmvxQ3mwdbAnZwQnE6n6+Jfn4y2QIeFwWIwtI2gndG5WkbaGXQXpdIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3238
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, November 22, 2022 7:2=
7 PM
>=20
> > From: Kirill A. Shutemov <kirill@shutemov.name>
> > Sent: Monday, November 21, 2022 4:01 PM
> > [...]
> > On Mon, Nov 21, 2022 at 11:51:47AM -0800, Dexuan Cui wrote:
> > [...]
> > I'm not convinced it deserves a separate helper for one user.
> > Does it look that ugly if tdx_map_gpa() uses __tdx_hypercall() directly=
?
>=20
> Will use __tdx_hypercall() directly.
>=20
> > >  /* Called from __tdx_hypercall() for unrecoverable failure */
> > >  void __tdx_hypercall_failed(void)
> > >  {
> > > @@ -691,6 +712,43 @@ static bool try_accept_one(phys_addr_t *start,
> > unsigned long len,
> > >  	return true;
> > >  }
> > >
> > > +/*
> > > + * Notify the VMM about page mapping conversion. More info about ABI
> > > + * can be found in TDX Guest-Host-Communication Interface (GHCI),
> > > + * section "TDG.VP.VMCALL<MapGPA>"
> > > + */
> > > +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc=
)
> > > +{
> > > +	u64 ret, r11;
> > > +
> > > +	while (1) {
> >
> > Endless? Maybe an upper limit if no progress?
>=20
> I'll add a max count of 1000, which should be far more than enough.
>=20
> > > +		ret =3D _tdx_hypercall_output_r11(TDVMCALL_MAP_GPA, start,
> > > +						end - start, 0, 0, &r11);
> > > +		if (!ret)
> > > +			break;
> > > +
> > > +		if (ret !=3D TDVMCALL_STATUS_RETRY)
> > > +			break;
> > > +
> > > +		/*
> > > +		 * The guest must retry the operation for the pages in the
> > > +		 * region starting at the GPA specified in R11. Make sure R11
> > > +		 * contains a sane value.
> > > +		 */
> > > +		if ((r11 & ~cc_mkdec(0)) < (start & ~cc_mkdec(0)) ||
> > > +		    (r11 & ~cc_mkdec(0)) >=3D (end  & ~cc_mkdec(0)))
> > > +			return false;
> >
> > Emm. All of them suppose to have shared bit set, why not compare direct=
ly
> > without cc_mkdec() dance?
>=20
> The above code is unnecessary and will be removed.
>=20
> So, I'll use the below in v2:
>=20
> /*
>  * Notify the VMM about page mapping conversion. More info about ABI
>  * can be found in TDX Guest-Host-Communication Interface (GHCI),
>  * section "TDG.VP.VMCALL<MapGPA>"
>  */
> static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
> {
>         int max_retry_cnt =3D 1000, retry_cnt =3D 0;
>         struct tdx_hypercall_args args;
>         u64 map_fail_paddr, ret;
>=20
>         while (1) {
>                 args.r10 =3D TDX_HYPERCALL_STANDARD;
>                 args.r11 =3D TDVMCALL_MAP_GPA;
>                 args.r12 =3D start;
>                 args.r13 =3D end - start;
>                 args.r14 =3D 0;
>                 args.r15 =3D 0;
>=20
>                 ret =3D __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
>                 if (!ret)
>                         break;

The above test is redundant and can be removed.  The "success" case is
implicitly handled by the test below for !=3D TDVMCALL_STATUS_RETRY.

>=20
>                 if (ret !=3D TDVMCALL_STATUS_RETRY)
>                         break;
>                 /*
>                  * The guest must retry the operation for the pages in th=
e
>                  * region starting at the GPA specified in R11. Make sure=
 R11
>                  * contains a sane value.
>                  */
>                 map_fail_paddr =3D args.r11 ;
>                 if (map_fail_paddr < start || map_fail_paddr >=3D end)
>                         return false;
>=20
>                 if (map_fail_paddr =3D=3D start) {
>                         retry_cnt++;
>                         if (retry_cnt > max_retry_cnt)
>                                 return false;
>                 } else {
>                         retry_cnt =3D 0;;
>                         start =3D map_fail_paddr;

Just summarizing the code, we increment the retry count if the hypercall
returns STATUS_RETRY but did nothing (i.e., map_fail_paddr =3D=3D start).  =
But
if the hypercall returns STATUS_RETRY after making at least some progress,
then we reset the retry count.   So in the worst case, for example, if the
hypercall processed only one page on each invocation, the loop will continu=
e
until completion, without hitting any retry limits.  That scenario seems
plausible and within the spec.

Do we have any indication about the likelihood of the "RETRY but did
nothing" case?   The spec doesn't appear to disallow this case, but does
Hyper-V actually do this?  It seems like a weird case.

Michael

>                 }
>         }
>=20
>         return !ret;
> }
