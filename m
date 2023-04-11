Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE46DE0FB
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjDKQaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDKQaT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 12:30:19 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1E4ED8;
        Tue, 11 Apr 2023 09:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEYsnN0MYFOA0NO9cD8tnK27Z8OMZZsYYc5YsLEbluWd9cL60i0t/bXjz69oqd25FakjwGkdt/IuLgvaQ+44c6bgWI/PuLieJQ3kFnmCXYQb0jI90QvbfhbqkzJHMQkk9VjgaIC+mqPwT8Jae19jpFhr7mf78+nII1ZtynD0rwdC1mbZhbNs54CB+BiBjYdgCtZDix9sk9MGis+TJgyDvoQq0rv1F49/p86GN75QVTGfmrUVCztIIqQJ25XfZjEh6PUvYa6MQn/fBjAuLxn5b+eML4emu8wghptRXHVK+QWeNath/vt/pDxkeIwdUz64NjRPMy3SlyA1GqEMmu5bUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b6eitFh6HIRo++/riJmuWiNky0WSzIdZHQxYxiDQ7M=;
 b=IafY0/dVB/R44mSpS4vsi3ygsHgagcIEo0wxh/mw+TbRHmXv+QM6wctLutJVgbbUWaavx7gdrvc3Iisk7SVrJyRl2Mxwwo/iLZfbdPH8feC0+bufLenaXEW4q/Byjojh8BlhY+QAVHBSwTga0mCxw7AEQOJt0jXP/Xr6OW5BwXRr4dIy3s0Ni7oN86HU92BflucXPjXxP/J44kY11tAoNHOTWsAV2bCycmyhU5zo/ikBMWRuLLfkO6Bf6eQ1x/aj1ZpSnxgRpeJEUmwbO6FvnbGfPpb7OrN1qUmf9wyToFq+OjT8SWvUpSI9Uth+nggtS2o+1n/fqHHK7axX57J+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b6eitFh6HIRo++/riJmuWiNky0WSzIdZHQxYxiDQ7M=;
 b=XwWTgoubRE3PfX0tqUEvmR1fZyH+dQP1k+u25oBISCSEnKqTGD1ZkYSVBQCYRqoBmLQAaByZljBOk92tQ4dhJLW5M5SWSlMDtNyvx85nJxlLvlS/kIB7HgaiZsGTkNa/T4eAywr4c68CxYtk3Z3z3gCYrNO/0DRqQ25PR+M7tDY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY1PR21MB3942.namprd21.prod.outlook.com (2603:10b6:a03:52e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 16:30:04 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 16:30:04 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v4 3/6] x86/hyperv: Add hv_isolation_type_tdx() to detect
 TDX guests
Thread-Topic: [PATCH v4 3/6] x86/hyperv: Add hv_isolation_type_tdx() to detect
 TDX guests
Thread-Index: AQHZalufBbh2IpbFH0CJx+Oha2y0Ta8mUMjw
Date:   Tue, 11 Apr 2023 16:30:04 +0000
Message-ID: <BYAPR21MB16883650F01B74B89120667BD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-4-decui@microsoft.com>
In-Reply-To: <20230408204759.14902-4-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0feb84a4-05a9-4f45-a69c-d412bd127220;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T16:29:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY1PR21MB3942:EE_
x-ms-office365-filtering-correlation-id: 213335a1-f372-42bf-c9ad-08db3aaa0145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t7/XYXEXMjHV3xpaVf29e7YIBMK4nf+qiidLV3cuDo+vJDF2moh7nxT1yRKaImA4bqezmtoRXQiu1HjWHXjT1bzj/lJNfh75VyWvMxF8isTDba6IKLssBgjXl/yUXpSg2v+tRNyqfiiAeU0crfzRMB/ZydxwXGeyeuIjnXSAUaOx4N1niod0PO1gPiQoY4bMmeZhI+e57a+LiRZTtvtoaQVihw2xsTBjvAfO/XVh0/ygabP19JCYzjgtqOBzGjYHM+E/3Qa1K6FkAnowCCMELPRbCYWTNXN0aoaFT5cy8rluic/IZN/+hD+cwDClcKI4UZHrTVO239VziDrWuF1AxkUf+AlMNeDV2oO1uq5s2WNEFJwQuvquMDeDoPP4HqezFZrwS42G4JaF6ntjaxRUDapJHgzVOxg8PHHUQOizbkq2dsh985wMyPemJB+ey+PQ/7ecR32Yn2uHZq0T53X/BavX3v/PO2DGoD6hpkxyCaR83seTd8++lHkAth8FB+C0HpEeVwpQ5kb5jkF/Aj7yqHeINe7Q2C2EDo3pRNoNmqlfavHY3iv0+giYJVt+tCgFLpjz2g7JGWpRZFtduq0DAjWZDwkv4RJ6AWCZ6oaYBtt/di+VWgg8Uiof/hpZ5ZiZUcTRhQ2cmltPa8der9K3qgJDGiuSNy+xJcSm/ZldW2mbHKVTV4IVu6S4AOJEH8w8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(52536014)(8936002)(41300700001)(38100700002)(8676002)(64756008)(66946007)(66446008)(76116006)(4326008)(66556008)(66476007)(71200400001)(5660300002)(54906003)(33656002)(2906002)(478600001)(10290500003)(7696005)(7416002)(9686003)(55016003)(26005)(6506007)(110136005)(316002)(786003)(107886003)(186003)(86362001)(38070700005)(8990500004)(921005)(122000001)(82950400001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VQUOQyLxRafUSG/H97hrMCck92zJksaG0uQjVRzDcBEOaCUkqhcBoX+cNf4/?=
 =?us-ascii?Q?Pta7yjFItKokJ8IWFmhJ0GuFSFA7nyo/sB3Y6quLjUfBiZ2SufP/qmvKtxfn?=
 =?us-ascii?Q?7q6nyIVhYYJAgwSGviCQdIfHJIGLQrSjWC9XHV2XDjhmcI5NTMd2mO7bzQEx?=
 =?us-ascii?Q?KcCUkwZUcaiq36rFJKjMqGX8vpai/7ZIroFXGYuW0pVNYYt6OvAqbSiZ2Gzd?=
 =?us-ascii?Q?xXc9ukwaIYqVA30CE72slGfeeiGzVz3uisPNHiO6ydOuaWrX2gn8Q3NQxdw0?=
 =?us-ascii?Q?hwK9mSwyZRckPK286TBxHXya/JsoTCePENHhdaWx/vBkv/IYIU71BmRbyzsM?=
 =?us-ascii?Q?EmF7/sCAvNsYnr890Hly/A9bx4A1m3uvyPdbspOC8fXHZU63VycwV7OyGS97?=
 =?us-ascii?Q?50/NfHB3T4pBdaQh1Nr4mZTucv0VacdFfs1Ja1DctEenJcJfWcyR2ymgElH3?=
 =?us-ascii?Q?/xPD+X++0R1aG7BiaJWX2mQn7PXNoVtCN6RrNxIb4EdpCegSzO/ZJG1NXxa3?=
 =?us-ascii?Q?N96it75oLXN6SfGpvOn/ScS6giockKzrEi14PFKT23XWxHDzoJIPiFRrtU8e?=
 =?us-ascii?Q?0zM9U64bf3J518mRkGrqkrK9sAm0cRAmRqsJwv2o4uwhoTpI4FzxFbO995z8?=
 =?us-ascii?Q?fysN+47TRzsrrlXQvElcTtP01SXIQmilTB/h63gPODB21RkSiR8/h7RgOLSo?=
 =?us-ascii?Q?H6n05BAjizlSshxj9D/vyiYrfHaqOVnEqlx4EbejONV/R84LTDnblaHcn/mj?=
 =?us-ascii?Q?pP2/SSP0CA82ivMFP/OZD24ZLyD/4aPAgdhaWmrRIQOsIQQcPCyFOJaba8Ld?=
 =?us-ascii?Q?tYX1dr66dNMOCo6ZsGvXU3JaWs0L/FUd9OAnlO9l2rwJ3WuPh+N5Nzf5CeDW?=
 =?us-ascii?Q?1NckhI0q1is92WMfoGzalmx698X6IGchIXhk/eIiN/UgsWZt5Bq1L98g/GJb?=
 =?us-ascii?Q?qSWUlioENdYQ/UkgAQvPZ0gl/GMf0B3AXKfAkbrrsfiO/hVrzNI2OPbglhFW?=
 =?us-ascii?Q?w+obJ+p90b1DpcAD8BmHplfJDkUjqr8cKbVpEzYswMlpTII/bJZrhH+2+Ucq?=
 =?us-ascii?Q?Z0mK6/QrWdvaTlmXZf3WrOsxK7FfNd3gB9ec6lDxW8NsiIGD6hM2hxLrmj8h?=
 =?us-ascii?Q?sB2euVfp3LJ3JHBTu9Q3VbW3CKXPvFzCdCyNGK35rTRGRtnh7XIxhHYvp/QO?=
 =?us-ascii?Q?0YaycFccFDCGzlU0F55kiutz1cZEqw10xa8QPsijOUrI/8aOxuCuHtr+htEO?=
 =?us-ascii?Q?VkvGjw4LZJDTxvzmtH+2jpVdIpHW1MV12oltQaqdNqO4I9Rmwdcn0ZCgfFQ3?=
 =?us-ascii?Q?TwmEYZ3L5soOXPZW/e6jq14BatOI/K8GNxhZLo85C04zYWJTfBv5cKoGrkne?=
 =?us-ascii?Q?9BngCRLs+wFgB0EN1gkhfyyEH0aZLidolJPvICmwcMKBG/xgVUCm7D49ZAC1?=
 =?us-ascii?Q?/er57CWN6Sc1u71N+0Dg3BuPiPEu7DaipCXRRwpY4u0WG6pIk6Xl2tDQ3Bsl?=
 =?us-ascii?Q?z+kdugoLgs7lJMJzUs3MDLiKFJgkFhLaMP6hJL9jo5JlygXFSwUpfsmzq6lf?=
 =?us-ascii?Q?PVYAsW0WuwqyNRsNHQ3R5ID4CleRXnCK9ej4+2vGnfUN0yCWAi5JzNEMpswF?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213335a1-f372-42bf-c9ad-08db3aaa0145
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 16:30:04.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrByBQTzx+tPzlRBc4vrG1ltgCeVZzMknLutx6Voys0ejwbE2BF8WtavON7FeDuCT4mrbfG6Ygn+GQ+kteZn150qCbqpxpF2iuUAYye/ZS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3942
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 1:48 P=
M
>=20
> No logic change to SNP/VBS guests.
>=20
> hv_isolation_type_tdx() wil be used to instruct a TDX guest on Hyper-V to
> do some TDX-specific operations, e.g. hv_do_hypercall() should use
> __tdx_hypercall(), and a TDX guest on Hyper-V should handle the Hyper-V
> Event/Message/Monitor pages specially.
>=20
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c              | 6 ++++++
>  arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
>  arch/x86/include/asm/mshyperv.h    | 3 +++
>  arch/x86/kernel/cpu/mshyperv.c     | 2 ++
>  drivers/hv/hv_common.c             | 6 ++++++
>  5 files changed, 19 insertions(+), 1 deletion(-)
>=20
> Changes in v2:
>   Added "#ifdef CONFIG_INTEL_TDX_GUEST and #endif" for
>     hv_isolation_type_tdx() in arch/x86/hyperv/ivm.c.
>=20
>     Simplified the changes in ms_hyperv_init_platform().
>=20
> Changes in v3:
>   Added Kuppuswamy's Reviewed-by.
>=20
> Changes in v4:
>   A minor rebase to Michael's v7 DDA patchset.
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 127d5b7b63de1..3658ade4f4121 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -400,6 +400,7 @@ bool hv_is_isolation_supported(void)
>  }
>=20
>  DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
> +DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
>=20
>  /*
>   * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
> @@ -409,3 +410,8 @@ bool hv_isolation_type_snp(void)
>  {
>  	return static_branch_unlikely(&isolation_type_snp);
>  }
> +
> +bool hv_isolation_type_tdx(void)
> +{
> +	return static_branch_unlikely(&isolation_type_tdx);
> +}
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index b4fb75bd10138..338f383c721c9 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -169,7 +169,8 @@
>  enum hv_isolation_type {
>  	HV_ISOLATION_TYPE_NONE	=3D 0,
>  	HV_ISOLATION_TYPE_VBS	=3D 1,
> -	HV_ISOLATION_TYPE_SNP	=3D 2
> +	HV_ISOLATION_TYPE_SNP	=3D 2,
> +	HV_ISOLATION_TYPE_TDX	=3D 3
>  };
>=20
>  /* Hyper-V specific model specific registers (MSRs) */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index e3cef98a01420..de7ceae9e65e9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -22,6 +22,7 @@
>  union hv_ghcb;
>=20
>  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> +DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
>=20
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -38,6 +39,8 @@ extern u64 hv_current_partition_id;
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
> +extern bool hv_isolation_type_tdx(void);
> +
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index ff348ebb6ae28..a87fb934cd4b4 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -405,6 +405,8 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP)
>  			static_branch_enable(&isolation_type_snp);
> +		else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX)
> +			static_branch_enable(&isolation_type_tdx);
>  	}
>=20
>  	if (hv_max_functions_eax >=3D HYPERV_CPUID_NESTED_FEATURES) {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6d40b6c7b23b9..c55db7ea6580b 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -271,6 +271,12 @@ bool __weak hv_isolation_type_snp(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
>=20
> +bool __weak hv_isolation_type_tdx(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

