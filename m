Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC276DF933
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDLO74 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 10:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDLO7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 10:59:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2114.outbound.protection.outlook.com [40.107.244.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B928AD;
        Wed, 12 Apr 2023 07:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkYOM3EGWkD8rG8iwulyzTu9ox4jeKNIpZhlLb5qYQ21Xgopk/dJxFOh4O26bf216brb1XZk5h0B1rd+FYEtGaEK6YM/7uzKAde7wgFNg2wayZkk5mwrCCtu6etA/r6ZkS3zZfST2A0vlhNKTFHMPX9FZtV8JyNPWFKYBVp0SzO9fZZu9bYT7t8zMK4y7gHbLxusGMsbzf76ZHD7oY6KbNXXbadfC0C5Dizdi1w2B/4CF6hAhI6wHrlKIm45rHJmRScADBNKNz2ha4x5pEw813sU2UvAqkfkLQ5LJymnPJeQrViX2UtUi3gRW57O8fKpWLE7l05rAIXF0ZwoEzTADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz/ydTEovSjwCUV+ZJe8jMhGdynP3Va2C2L0v6GPihk=;
 b=TTIr1nkek0XNa1leylkpN4thdW9JhG2HMknV2SgXnfaX/j2BDkRE/v+5NE3vLzMFS9PslPsd3qxWprpJJBSjSYbJMsjxZQki+b/i70ruCTXRQd/G3+HmOlPNNuce5M1gXaArFtJw+RhClmb24QTOTmrqNDl1UcFo7BhFt/IE4h6JZq10ew/3m0/YsF7kafKqs9JSYk3NyLLxHPgRxhwHyKibIJ9rTl1D5su0l3oQUgG2uY8QrEyKrq4C7uporP1Fuq4qMb1NczdkXu7AazcfYj2smSIagI71S7g9wFnUsGJYwY+OPo1uWPR4p9+pLPGhCkAg7JVWYKPBKAaTj2+9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz/ydTEovSjwCUV+ZJe8jMhGdynP3Va2C2L0v6GPihk=;
 b=hgOWP8p7xYfLuzeNFBWDKQDLpNnFWqsaEfvocgzc1NYBvLOCeUF6YVxTaCoTKdJJFB+BB7jfJfqdK9cLjgT3z20TwEyXWpG7t02CJt9cwghdg1FEQQYZt0CnTr7/lYIk8jszDiRLuLMzpvJtgBG/h+NATIA2BxpLVrGasScD5Zw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CH3PR21MB4016.namprd21.prod.outlook.com (2603:10b6:610:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Wed, 12 Apr
 2023 14:59:45 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 14:59:45 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
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
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V4 10/17] x86/hyperv: Add smp support for sev-snp
 guest
Thread-Topic: [RFC PATCH V4 10/17] x86/hyperv: Add smp support for sev-snp
 guest
Thread-Index: AQHZZlQPVSjp+rVBdUS2/G4UxLSwka8nzVYQ
Date:   Wed, 12 Apr 2023 14:59:45 +0000
Message-ID: <BYAPR21MB1688D729D203638C17FBC82AD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-11-ltykernel@gmail.com>
In-Reply-To: <20230403174406.4180472-11-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d03f3e91-80d0-4246-b006-49a3b3c34a11;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T14:42:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CH3PR21MB4016:EE_
x-ms-office365-filtering-correlation-id: e128a1ea-6f38-401e-6ee9-08db3b668db1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SU7dZAkQeyQp/SjAelI7Zr19Bf5K96SS+G/7hdf9rb0SUCcKYmQ9z3dKzOfGjdctwKvNTIoxJySiKb4L4J1vn6gudfNhwdMtSxbml0K9tvoR780SGq21TPjQHpTzdyIf32BKZLsN+WuNQnnuJHn+4NOvbmE3jEYIRFRKVJN93ozda2ojRUgrOW6sv82WVLe3zKviVG0mhpVs1zI8NC1rwVUPawGhxPR7sfbla71V5urFXYMKEw/aX9LWgH3nEuXr1E9JHavG5PKrQ1QDgxO986T4KwmRa4VoMF7UM6AhDecv03IPRqkIU8pQcyTLkiwxgM5N0DxR0r+7XCXT6hBl0cXdBFnFcP2+7RqtLU/uxEM4d8kNT0BTXbcrgWZUMrJ2cNI991znPXyyJEGvR1FXhwavHFzvLNrsxnP7IKuEXlkgzqxj3LWocC2iqwjsuD00nptciQezNsUNTKthoWE/ba713A5VZRKx5FpQ7xWvBquy1MQ8pXP4H8vODgPzT9Cen8f10+R+GL0S4kTFrDMPoZnxSx58YDyX6ziZLQdXB398duI6gvz1GW6OcGDfzgoh0yFF/6mFE6CU0iRmYZU490VlaEuQT9VdCd8qFJZuP/meDajfo8N9cMZvObk5yiyKTXCeixmztdvdKvrNNDmsyc6IsQujmjb/PfjrGkOzgps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(33656002)(38100700002)(122000001)(7406005)(7416002)(5660300002)(52536014)(30864003)(2906002)(786003)(38070700005)(8676002)(55016003)(86362001)(8936002)(4326008)(66556008)(64756008)(66476007)(66946007)(66446008)(82950400001)(82960400001)(41300700001)(921005)(966005)(83380400001)(76116006)(26005)(316002)(54906003)(9686003)(110136005)(8990500004)(6506007)(10290500003)(7696005)(186003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mofzIiWQO6fgFce4zyhRNKSjMIYWc8Zg49ZS+zBd0dyo9IYDwOK1VmGUEfw+?=
 =?us-ascii?Q?Ywcj0SO5cJCkKd0TURKzuvs6I2lg45jd+izmCAFExLJSHfF3H9zfP8/ilbOe?=
 =?us-ascii?Q?pTZi6G2uMa4SkpkTVaCTmyfsylJGZh0Tz0KwrFtcIWqDEXFqnsTf5XH4j1q8?=
 =?us-ascii?Q?n1rQJJhFVR9erAMg6fQCo2a9AObq0PvnqSANlI+h0exUCF8eBdcU5TKNWdbl?=
 =?us-ascii?Q?o39HT7EeZ3fSgOvsT1syMPHfs4+V7o70GtO3hyToxcgvYFudrHAyC80PTD7s?=
 =?us-ascii?Q?UOtEVEwp5SU4dDFHsAD1kgUaXq9wGNYO21yMzEkcn+3oc1Xq5u6I1CvGgxcx?=
 =?us-ascii?Q?2XHbP0AQyTuaRHLqsmzOCx6lhRqqzFfaEP17QFRIZ9aKwX8W9igRNYVSeWPb?=
 =?us-ascii?Q?74fk96sWZu8zJA20Pucj1EsjV2y+Pneid8mZW7Ri28hokD/NinnEE/kk93A/?=
 =?us-ascii?Q?3FBHS8vhQOS9Okb+SGaq5LB6Huh/T1t7a3OM0yBobF3BLk5N+5SeeXEDYmjO?=
 =?us-ascii?Q?nK7c/m6tPTmuKFypfeUDlG/cBGlD4wanyXWRUzdCwDVgPgU60YoAmJ6gmAMJ?=
 =?us-ascii?Q?4g/ebrKlYlQBTIzJho+Nsj9RNawGPVi/eOZZ1kGZoxzFaiNz1T1UKdSjCwmf?=
 =?us-ascii?Q?zcZWpWf4ugXEYaJmkpNbOe+uCBptu+3sm8UTLXtuGUClZ3fmyNFHezmv1SS8?=
 =?us-ascii?Q?L+eI34v+nU8nOVOBMpecpYoJVkeidm1P8b0Sl2k2CAlBRc9qDHb26kKHMpHT?=
 =?us-ascii?Q?9DzM30K3BP0oT2ZM6jDxXPjXcUID9UYkmoFOZH8KbTTGDcJllUeDg+cIAdGT?=
 =?us-ascii?Q?65doDpXixOud+olp2fvxAhQICpYokDvLNmrpoTOrGkluffCrvQ9bizVNiQ9z?=
 =?us-ascii?Q?GL63jJe9+NdPYknDReJbIwhilT/R6Gdv0fBVMCujxqIYucGKfCA9yWNP0l+x?=
 =?us-ascii?Q?avHbcuALs6QYo6iUQcSvEqajLOq2wCBg2tQWHbC9qJtLAKOrXcTlQiYjC+h5?=
 =?us-ascii?Q?WVJzQ9rcVj7w4BiagbxKDqpsjw6u3yy3sWnyl4p/PAJUgx0Njwpy4anf1P3G?=
 =?us-ascii?Q?9JDUhH24qoqEvZxlV+Wu74IMnwaCDUwBg/XJq/5KpKveXrIHCNn/5dfM88X0?=
 =?us-ascii?Q?FbMz7I8It8Iu0QfpYzQgd+MxWOdMnl0IZswyG00YUryb/PhK2h7Zb1CFGdIC?=
 =?us-ascii?Q?9tcE1TECBO0dZK9qSxEcC/v8DdkHxHmIAWQfuIYQ9SsZe48jj4k2w/eo4frA?=
 =?us-ascii?Q?sx4LAbxO2nBCMs2e2hhsJWxcZUUQApf0O6D+tZdQhkTiivoxi+9NqAI3/ZLv?=
 =?us-ascii?Q?Qk4LvxFCCpXhy4FeGGbpWyXdCIZTJw63PtO1vrUA0y0kR6NBR4QobgzsgwV7?=
 =?us-ascii?Q?f4ZxGMH0tjAaU1FS9DQv4JewEaKdd6oZ1gO8Mre56UhB3Ny+7+mXqKXOUIcJ?=
 =?us-ascii?Q?Wy5wMNzwi+gGPSMR2ZJgLt6LR08X7F19eQJMmzMOBFj2O3i9IdBHtGOv+6dg?=
 =?us-ascii?Q?NQbJZOL8ia38IkS2yGHy2lhiV1DjUlFAzGn1Z1g09P26fhI9GNbBgt7JKt/6?=
 =?us-ascii?Q?yGq7e1TXubjb+zNtz204fyIgsRtaKsbWB5MScKoBaexl6BwrmLkMem6AlmKr?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e128a1ea-6f38-401e-6ee9-08db3b668db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:59:45.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hD921riyHIuLWB9f/A7lo2l7J7OAEru3TX5kxTO50d4SwZZVYY5iWB8BK60qFFYq4s4u3VS94YpbqSepORUo4oSer7cJUwsfRT19rB7MnoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4016
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, April 3, 2023 10:44 AM
>=20
> The wakeup_secondary_cpu callback was populated with wakeup_
> cpu_via_vmgexit() which doesn't work for Hyper-V and Hyper-V
> requires to call Hyper-V specific hvcall to start APs. So override
> it with Hyper-V specific hook to start AP sev_es_save_area data
> structure.
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
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c0f3fa924163..51243148b8e6 100644
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
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_S=
IZE);
> +static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);

Just a question:  ap_start_stack is a static variable that gets used as the
starting stack for every AP.  So obviously, once each AP is started, we mus=
t
be sure that the AP moves off the ap_start_stack before the next AP is
started.  How is that synchronization done?  I see that do_boot_cpu() is
where the wakeup_secondary_cpu() function is called.  Then there's
some waiting until the AP completes "initial initialization" per the
comment in the code.  Is there where we know that the AP is no
longer using ap_start_stack?

> +
>  union hv_ghcb {
>  	struct ghcb ghcb;
>  	struct {
> @@ -437,6 +441,91 @@ __init void hv_sev_init_mem_and_cpu(void)
>  	}
>  }
>=20
> +#define hv_populate_vmcb_seg(seg, gdtr_base)			\
> +do {								\
> +	if (seg.selector) {					\
> +		seg.base =3D 0;					\
> +		seg.limit =3D HV_AP_SEGMENT_LIMIT;		\
> +		seg.attrib =3D *(u16 *)(gdtr_base + seg.selector + 5);	\
> +		seg.attrib =3D (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
> +	}							\
> +} while (0)							\
> +
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip)
> +{
> +	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
> +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	struct desc_ptr gdtr;
> +	u64 ret, retry =3D 5;
> +	struct hv_start_virtual_processor_input *start_vp_input;
> +	union sev_rmp_adjust rmp_adjust;
> +	unsigned long flags;
> +
> +	native_store_gdt(&gdtr);
> +
> +	vmsa->gdtr.base =3D gdtr.address;
> +	vmsa->gdtr.limit =3D gdtr.size;
> +
> +	asm volatile("movl %%es, %%eax;" : "=3Da" (vmsa->es.selector));
> +	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%cs, %%eax;" : "=3Da" (vmsa->cs.selector));
> +	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ss, %%eax;" : "=3Da" (vmsa->ss.selector));
> +	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ds, %%eax;" : "=3Da" (vmsa->ds.selector));
> +	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
> +
> +	vmsa->efer =3D native_read_msr(MSR_EFER);
> +
> +	asm volatile("movq %%cr4, %%rax;" : "=3Da" (vmsa->cr4));
> +	asm volatile("movq %%cr3, %%rax;" : "=3Da" (vmsa->cr3));
> +	asm volatile("movq %%cr0, %%rax;" : "=3Da" (vmsa->cr0));
> +
> +	vmsa->xcr0 =3D 1;
> +	vmsa->g_pat =3D HV_AP_INIT_GPAT_DEFAULT;
> +	vmsa->rip =3D (u64)secondary_startup_64_no_verify;
> +	vmsa->rsp =3D (u64)&ap_start_stack[PAGE_SIZE];
> +
> +	vmsa->sev_features.snp =3D 1;
> +	vmsa->sev_features.restrict_injection =3D 1;
> +
> +	rmp_adjust.as_uint64 =3D 0;
> +	rmp_adjust.target_vmpl =3D 1;
> +	rmp_adjust.vmsa =3D 1;
> +	ret =3D rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
> +			rmp_adjust.as_uint64);
> +	if (ret !=3D 0) {
> +		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +	start_vp_input =3D
> +		(struct hv_start_virtual_processor_input *)ap_start_input_arg;
> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
> +	start_vp_input->partitionid =3D -1;
> +	start_vp_input->vpindex =3D cpu;
> +	start_vp_input->targetvtl =3D ms_hyperv.vtl;
> +	*(u64 *)&start_vp_input->context[0] =3D __pa(vmsa) | 1;
> +
> +	do {
> +		ret =3D hv_do_hypercall(HVCALL_START_VIRTUAL_PROCESSOR,
> +				      start_vp_input, NULL);
> +	} while (hv_result(ret) =3D=3D HV_STATUS_TIME_OUT && retry--);
> +
> +	if (!hv_result_success(ret)) {
> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
> +		goto done;
> +	}
> +
> +done:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
>  void __init hv_vtom_init(void)
>  {
>  	/*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index a4a59007b5f2..e23c987deb7a 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -55,6 +55,20 @@ struct memory_map_entry {
>  	u32 reserved;
>  };
>=20
> +/*
> + * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
> + * to start AP in enlightened SEV guest.
> + */
> +#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
> +#define HV_AP_SEGMENT_LIMIT		0xffffffff
> +
> +/*
> + * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
> + * to start AP in enlightened SEV guest.
> + */
> +#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
> +#define HV_AP_SEGMENT_LIMIT		0xffffffff

This code looks like it is erroneously added twice.

> +
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> @@ -253,6 +267,8 @@ struct irq_domain *hv_create_pci_msi_domain(void);
>  int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vec=
tor,
>  		struct hv_interrupt_entry *entry);
>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *=
entry);
> +int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool vi=
sible);
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip);
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  void hv_ghcb_msr_write(u64 msr, u64 value);
> @@ -261,6 +277,7 @@ bool hv_ghcb_negotiate_protocol(void);
>  void hv_ghcb_terminate(unsigned int set, unsigned int reason);
>  void hv_vtom_init(void);
>  void hv_sev_init_mem_and_cpu(void);
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip);
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> @@ -268,6 +285,7 @@ static inline bool hv_ghcb_negotiate_protocol(void) {=
 return
> false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
>  static inline void hv_vtom_init(void) {}
>  static inline void hv_sev_init_mem_and_cpu(void) {}
> +static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
>  #endif
>=20
>  extern bool hv_isolation_type_snp(void);
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..e34aaf730220 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -86,6 +86,19 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>=20
>  #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
>=20
> +union sev_rmp_adjust {
> +	u64 as_uint64;
> +	struct {
> +		unsigned long target_vmpl : 8;
> +		unsigned long enable_read : 1;
> +		unsigned long enable_write : 1;
> +		unsigned long enable_user_execute : 1;
> +		unsigned long enable_kernel_execute : 1;
> +		unsigned long reserved1 : 4;
> +		unsigned long vmsa : 1;
> +	};
> +};
> +
>  /* SNP Guest message request */
>  struct snp_req_data {
>  	unsigned long req_gpa;
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index cb1ee53ad3b1..bcf970901512 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -423,7 +423,20 @@ struct sev_es_save_area {
>  	u64 guest_exit_info_2;
>  	u64 guest_exit_int_info;
>  	u64 guest_nrip;
> -	u64 sev_features;
> +	union {
> +		struct {
> +			u64 snp                     : 1;
> +			u64 vtom                    : 1;
> +			u64 reflectvc               : 1;
> +			u64 restrict_injection      : 1;
> +			u64 alternate_injection     : 1;
> +			u64 full_debug              : 1;
> +			u64 reserved1               : 1;
> +			u64 snpbtb_isolation        : 1;
> +			u64 resrved2                : 56;
> +		};
> +		u64 val;
> +	} sev_features;
>  	u64 vintr_ctrl;
>  	u64 guest_exit_code;
>  	u64 virtual_tom;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 71820bbf9e90..829234ba8da5 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -300,6 +300,16 @@ static void __init hv_smp_prepare_cpus(unsigned int =
max_cpus)
>=20
>  	native_smp_prepare_cpus(max_cpus);
>=20
> +	/*
> +	 *  Override wakeup_secondary_cpu callback for SEV-SNP
> +	 *  enlightened guest.
> +	 */
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu =3D hv_snp_boot_ap;

In another patch set for starting CPUs at VTL2, there was some discussion
about using wakeup_secondary_cpu vs. wakeup_secondary_cpu_64.  The
decision was to use wakeup_secondary_cpu_64.  See=20
https://lore.kernel.org/linux-hyperv/1681192532-15460-6-git-send-email-ssen=
gar@linux.microsoft.com/T/#u

I'm not sure of all the tradeoffs, but I wonder if wakeup_secondary_cpu_64
should be used here.

> +
> +	if (!hv_root_partition)
> +		return;
> +
>  #ifdef CONFIG_X86_64
>  	for_each_present_cpu(i) {
>  		if (i =3D=3D 0)
> @@ -503,8 +513,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition)
> -		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
> +	smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
>  # endif
>=20
>  	/*
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 679026a640ef..b3f95fcb8b18 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1080,7 +1080,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsi=
gned long start_ip)
>  	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
>  	 */
>  	vmsa->vmpl		=3D 0;
> -	vmsa->sev_features	=3D sev_status >> 2;
> +	vmsa->sev_features.val =3D sev_status >> 2;
>=20
>  	/* Switch the page over to a VMSA page now that it is initialized */
>  	ret =3D snp_set_vmsa(vmsa, true);
> @@ -1097,7 +1097,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsi=
gned long start_ip)
>  	ghcb =3D __sev_get_ghcb(&state);
>=20
>  	vc_ghcb_invalidate(ghcb);
> -	ghcb_set_rax(ghcb, vmsa->sev_features);
> +	ghcb_set_rax(ghcb, vmsa->sev_features.val);
>  	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
>  	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CRE=
ATE);
>  	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index ea406e901469..b2f14aa608f7 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -148,6 +148,7 @@ union hv_reference_tsc_msr {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>  #define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> @@ -165,6 +166,7 @@ union hv_reference_tsc_msr {
>  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
> +#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
> @@ -220,6 +222,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_PORT_ID		17
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT                     0x78
>=20
>  /*
>   * The Hyper-V TimeRefCount register and the TSC
> @@ -779,6 +782,22 @@ struct hv_input_unmap_device_interrupt {
>  	struct hv_interrupt_entry interrupt_entry;
>  } __packed;
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

