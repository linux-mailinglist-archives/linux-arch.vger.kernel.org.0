Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136986F3038
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjEAKcq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjEAKck (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 06:32:40 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020023.outbound.protection.outlook.com [52.101.128.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C60910DB;
        Mon,  1 May 2023 03:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFgvfnU9RBIO/uBzVLZ6NeHvtnaJgOkyrlOLPOy9S14lNwi+BrM/NIAlrfPSCXG5kfb3E/bfCvbzqPifcAXFXACsg1foK3VsTuEI18OmyzWTt0ODfT7riz+qgJRoPCca3HbDdjEOHtCk85IJmSMTWgyjYGt2TVmIpv7EZL8Hmjk9mv7Pz8JQJ9DjWY1stA+wBp5fPFKUXHA6OmtV6cYCtuzMc9RHSyP0fEG4WMpzp8Yabaua4I6+syhRI2Aww0TIF3llUZDetpiXjtFAiTVtbzeep2qSWS4I5wPo9TYFBrz4ez/xWv0gtPaZMCPmr7wSYGLBA/Vohx0qNDc56vcQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI/qKiulEsF4wZsAt8Jk3bpYjtahhxJ68XiL45gRZzI=;
 b=jHdXJiojpnxXCkKR5OCMcS0jMhumYMVIv/NBsEc4hLAbKJ+nPYSgNFqVR42DiWXPsSK4eQrEIbBzBhEUvs/A7klGytjaS0atqZc2MGcmNhu8Jk6wJkcEUv+KagUTOc6m7l15Iy5dLfFrg70YkDE4kdnGA4ZDucPAljGlaF5so+jg/VP0B6uLAmkzCoP8bd78X1TLo/oKuc3fRpdeNFiFfXwNeW9wR413esiBjN1ukQz48bgWIfcA240rBbs1qDVf5MQ3q2NCBtXMwrh688hOrhw2vFgAW6wkhe693EPhDpY3rPqJA7tDw0SfYM0Co0ExvOsKZjGLopRNNEBEsoiQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI/qKiulEsF4wZsAt8Jk3bpYjtahhxJ68XiL45gRZzI=;
 b=NiBUe/LHtWvCVtcdfA1NS1QULRgtNDCUwxd5SsmsaIPuf0VEqlMrQamZunyS6C1QD690ePR4JrSitsB2YdRum58hX/SjO30NHleSg1dZOhJrNgbU0+KafeGG2QdkMHEvRnFeFJ0RECZg16Ka+h+/rshXgSKhskKJDAFkQMDhULc=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 SI2P153MB0672.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1ff::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.5; Mon, 1 May 2023 10:32:26 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6387.005; Mon, 1 May 2023
 10:32:26 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [EXTERNAL] [RFC PATCH V5 09/15] x86/hyperv: Add smp support for
 sev-snp guest
Thread-Topic: [EXTERNAL] [RFC PATCH V5 09/15] x86/hyperv: Add smp support for
 sev-snp guest
Thread-Index: AQHZfAsx7OPEtGqXGkOTjZ7IFQQyZK9FN+7A
Date:   Mon, 1 May 2023 10:32:26 +0000
Message-ID: <PUZP153MB07496A03FF7B1FDEEEBE0520BE6E9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-10-ltykernel@gmail.com>
In-Reply-To: <20230501085726.544209-10-ltykernel@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dc827253-69ca-42f6-a0ff-e1e4081a7d57;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-01T10:30:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|SI2P153MB0672:EE_
x-ms-office365-filtering-correlation-id: 79cfc65a-87a1-4d29-1ec4-08db4a2f5b70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rM+Y3LPMABvyWHB19OIgDWlzLI4oY/vLwnc9JVDf2VpfokhA7UWWfjJ59jOmw96MZCd+4IpuZ9XYVuMizRA53a4Tb1SWwx7QxXcCDapY9uY1Y7a32nfk/QAmQ3O832o6nCMttgL5+HTg35mLwDHKpoXJr79V7DDqGPdj4E11n2aVLnZ7WZ+LqRszgMi0ioG8YNFBqPg/pp2qBBc06omavgJ/Oc3DeS9gxSn+a/zpzovVtEg+DQoNvaLkWIEaNzUSyhltkvz5bSjNqnB+lQwaTc7u5OFE538Io38N9yReIwgBYn6e+n5xQxFAwJMVK5gTHOpXW8UHahztxa6AKBQeHeih2oku3HmHoBtDIK8zHB8tQYADF4PPaGjuafLD2Aj7cDHQ1j7nFWm3fhZEZArfrRrBB+LTMLDmRt24CtvhFn5b0xF51NVQNvNilPu24R5huBbGD9HWpgtcAmDBCCsNV/6EuODoAgwuMIlCiYQPKlBvkoud9Y8FL9exVvwVoKLcLfp2UWNQway+29rgGiJ20mNCS0lugs5ESUCHLFGiVtAZlfxnMzxscRvO/CVQkGGLHSBshz4QYFauqA9uGgOWVNEvxnhIqsXrlI7gjx+fHIhPehVNv53fpXeD4SG0Yb+GkH9VGqbq8qGQP9AssnzanqTAimTUF+1MYZvKpdV/9kf4gJKV2lQP0LFuyZEysveY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(86362001)(33656002)(38100700002)(82960400001)(38070700005)(122000001)(82950400001)(921005)(7406005)(8676002)(52536014)(7416002)(5660300002)(66946007)(66476007)(66556008)(786003)(76116006)(4326008)(8936002)(66446008)(316002)(41300700001)(64756008)(55016003)(8990500004)(2906002)(83380400001)(71200400001)(110136005)(7696005)(54906003)(10290500003)(478600001)(6506007)(186003)(53546011)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PbViEGN14CRFSqRAkiaENdBzToodDC2T5W1CSvVWASd98WExRr2+8ByI5C3b?=
 =?us-ascii?Q?lsoJV6y2D/zFDbIvKTX42IhggVg1chum5RSmNFvVB0xJ6F+6WK6/5DJ0Wjzc?=
 =?us-ascii?Q?q+AMxcQ/YATb1WPzzKPTbRkyOlTyvYi3HA2ELICOF0qybdsKPxJGcUpMIe38?=
 =?us-ascii?Q?uaINRDb/ioINqjd/NE2b4RZKIbl+8kaGfKjURLoVS2sZLN5pCRol3EObBwbi?=
 =?us-ascii?Q?xXS5fQl2A5cCoHsDdRndlaucK8VP9tjYPRiTL36C4JPP0S8bmim1eRmBQX2P?=
 =?us-ascii?Q?3iOgTl5rXxKA+2/2tp3ULEozUFncUBf+g6GX7xLBpcEew8oUNHM9krJ8FW4Z?=
 =?us-ascii?Q?W9Gsp9zHJmQu0jMbbZhfAswo8BqSng+l281xlmOsKj80ZkHije9GvqsluPkP?=
 =?us-ascii?Q?KRROfCBAuhE/zGfl5XJFk3mfBzvKbDBSXxa0wkIWKcr4rulSCJTIywnG8KgX?=
 =?us-ascii?Q?YPVhtXEjv97EFIQVMZiH3hRGpBtZfG2dHlEY5/6DLHFuyBSKV2O5QdCDRAHl?=
 =?us-ascii?Q?gOe6LvEFsqbdnF49TKh1taHIt9ivRf2NiTQVRuOPzr/tNhMLh1NkQMBY6VlO?=
 =?us-ascii?Q?1grydfVY3WRKnFo3itxqQyM8yeOACPHwNeg6gnOzq9vEiChTNR6+p6XnsT0O?=
 =?us-ascii?Q?5UDaDziUExPwsrrRmlbJ69IK1sjJw07Nb18jYylakibYMMVjApazF1tfjdwz?=
 =?us-ascii?Q?QhHVtOd3qhoYntRy0cnifmHnFOm1Zs6ZyZjxPhsge6p4yizL+r1od1dWJ60y?=
 =?us-ascii?Q?WSe29Tx8f2e5r0QH4WUc1JkGSRUPs8jILmTBEnKqr01MMhs+2aehsn4pEeVg?=
 =?us-ascii?Q?L62IZavXjt/V4TtqwO1CezNG2A/lVrWzJFL5vE57F1WCiRXinE7AmOApAsya?=
 =?us-ascii?Q?3tc7xyNdiAfQOjMS0bZAwDrT8wyBTsUhzwHeKu9QzKZC1BguGFTjWHsON7qL?=
 =?us-ascii?Q?OqmaEkE/Gm3utdKuM0QyPXp0MmLrjcPyqOfZCv3MW8gya1upJDPB6RZEazxe?=
 =?us-ascii?Q?rGvTTh4tgH6eMEwIJ/tV+c/zCxXyGeIhkEXMHadlierirKZxKPCUJKNu3Q43?=
 =?us-ascii?Q?lNXIAGiSuMMgHu9U9eZ3igjyRnD7SX0lXNmy6AgOjbuslXQdZY2W0E11uSJr?=
 =?us-ascii?Q?3e3F3dQ7TNwGG1Cvah/u5ZxlOM2syETZ3biVqaaYJXh+f3JezS6MjhNgoJ/C?=
 =?us-ascii?Q?QuRDBmoFJTkgCubP3PTd2nARg3ogroooYGruJ4QD59jV1AVeoTFFT2ejP0yW?=
 =?us-ascii?Q?RhegX8ecGz6tCuaBANxB4qck5SDYbhvKW6As76YImFbRG46omh1FODbR7x9R?=
 =?us-ascii?Q?rXJGI2g3Ac5OeYjABW15k2VpXn1dgdzTilCikMEK7HAJ9gI+R+ZGr0PJAUnb?=
 =?us-ascii?Q?pzn9/2VTevoVuDO8dR/SCIkjqQiLUZxN6k5Vi30i14tOVq3ZpSEt1DEiRE/k?=
 =?us-ascii?Q?NdHhDOHLYZU1Vj9EKoshhFWzi0Bxs1hE90EiPzDM2SBRmXL81zHBgKQaqT3x?=
 =?us-ascii?Q?ENZO+Y3M3zGt7CsbxrvEOZc4SsbR1ZwnQlNUeVc1VZ5qAvJedApj5wZkcULT?=
 =?us-ascii?Q?TLJpKJAwRWxie49Nu5iu3Nd6NqgzfUz6ql9ERbxY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cfc65a-87a1-4d29-1ec4-08db4a2f5b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 10:32:26.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5Yb/4QHGAvuvIOfjDvzaW4wdZoIszAAS++nIwg7uc2fEHQg1+qTBdXiznl7grkjXMZ9KpW1GhiLpayhgOOgkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0672
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Monday, May 1, 2023 2:27 PM
> To: luto@kernel.org; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;
> seanjc@google.com; pbonzini@redhat.com; jgross@suse.com; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; kirill@shutemov.name;
> jiangshan.ljs@antgroup.com; peterz@infradead.org; ashish.kalra@amd.com;
> srutherford@google.com; akpm@linux-foundation.org;
> anshuman.khandual@arm.com; pawan.kumar.gupta@linux.intel.com;
> adrian.hunter@intel.com; daniel.sneddon@linux.intel.com;
> alexander.shishkin@linux.intel.com; sandipan.das@amd.com;
> ray.huang@amd.com; brijesh.singh@amd.com; michael.roth@amd.com;
> thomas.lendacky@amd.com; venu.busireddy@oracle.com;
> sterritt@google.com; tony.luck@intel.com; samitolvanen@google.com;
> fenghua.yu@intel.com
> Cc: pangupta@amd.com; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-arch@vger.kernel.org
> Subject: [EXTERNAL] [RFC PATCH V5 09/15] x86/hyperv: Add smp support for
> sev-snp guest
>=20
> From: Tianyu Lan <tiala@microsoft.com>
>=20
> The wakeup_secondary_cpu callback was populated with wakeup_
> cpu_via_vmgexit() which doesn't work for Hyper-V and Hyper-V requires to
> call Hyper-V specific hvcall to start APs. So override it with Hyper-V sp=
ecific
> hook to start AP sev_es_save_area data structure.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change sicne RFC v3:
>        * Replace struct sev_es_save_area with struct
>          vmcb_save_area
>        * Move code from mshyperv.c to ivm.c
>=20
> Change since RFC v2:
>        * Add helper function to initialize segment
>        * Fix some coding style
> ---
>  arch/x86/hyperv/ivm.c             | 89 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   | 18 +++++++
>  arch/x86/include/asm/sev.h        | 13 +++++
>  arch/x86/include/asm/svm.h        | 15 +++++-
>  arch/x86/kernel/cpu/mshyperv.c    | 13 ++++-
>  arch/x86/kernel/sev.c             |  4 +-
>  include/asm-generic/hyperv-tlfs.h | 19 +++++++
>  7 files changed, 166 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c index
> 522eab55c0dd..0ef46f1874e6 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -22,11 +22,15 @@
>  #include <asm/sev.h>
>  #include <asm/realmode.h>
>  #include <asm/e820/api.h>
> +#include <asm/desc.h>
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>=20
>  #define GHCB_USAGE_HYPERV_CALL	1
>=20
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted
> +__aligned(PAGE_SIZE); static u8 ap_start_stack[PAGE_SIZE]
> +__aligned(PAGE_SIZE);
> +
>  union hv_ghcb {
>  	struct ghcb ghcb;
>  	struct {
> @@ -442,6 +446,91 @@ __init void hv_sev_init_mem_and_cpu(void)
>  	}
>  }
>=20
> +#define hv_populate_vmcb_seg(seg, gdtr_base)			\
> +do {								\
> +	if (seg.selector) {					\
> +		seg.base =3D 0;					\
> +		seg.limit =3D HV_AP_SEGMENT_LIMIT;		\
> +		seg.attrib =3D *(u16 *)(gdtr_base + seg.selector + 5);	\

<snip>

> generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index f4e4cc4f965f..959b075591b2 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -149,6 +149,7 @@ union hv_reference_tsc_msr {
>  #define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>  #define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_ENABLE_VP_VTL			0x000f

HVCALL_ENABLE_VP_VTL is already defined.

>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> @@ -168,6 +169,7 @@ union hv_reference_tsc_msr {
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
>  #define HVCALL_START_VP				0x0099
>  #define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
> +#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099

We already have HVCALL_START_VP no need of defining HVCALL_START_VIRTUAL_PR=
OCESSOR.
- Saurabh

>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af  #define
> HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0  #define
> HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db @@ -223,6
> +225,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_PORT_ID		17
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT                      120
>  #define HV_STATUS_VTL_ALREADY_ENABLED		134
>=20
>  /*
> @@ -783,6 +786,22 @@ struct hv_input_unmap_device_interrupt {
>  	struct hv_interrupt_entry interrupt_entry;  } __packed;
>=20
> +struct hv_enable_vp_vtl_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
> +struct hv_start_virtual_processor_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>=20
> --
> 2.25.1

