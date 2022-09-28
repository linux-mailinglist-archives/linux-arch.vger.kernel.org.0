Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D505EDCE4
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 14:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiI1Mge (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 08:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiI1MgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 08:36:17 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD29A9E3;
        Wed, 28 Sep 2022 05:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ianokrZuExLkbmv8rTUc9J31q2wJaiGijhJVTfrp8sdNM7N2YBqM2wnMx3S0G9aJk43l3Go9/9Vgd6Xr8UurhNCLVnDn69h7vb1rWnkR/7VO++TYWzmhg8jgubMA0fE9tuOyQFP66uxoYHAbhomXt6AsTuAY770TPk+wC3fKHwRcZydbq9A4nRHWI7/7Wr9Fgef9XGj06F7pd3vvHHEkTdtNbQvOhBcYnYBMEdrxXaKSl8TNiL+Gq0S1sumWTdqoVM9AQZSzFsAOdOIDo4sKnX/xiYIcTxFm5XpbV/90hlMA+ywzF13GJUbc9wfWmui9aJSDgKCIT84DgzDDnMnJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sks57Pdiy3DsUlY78sGLqKQaKqUnegE7blTi16axG4=;
 b=dZkBToC/d56NweJOEvUgM0AbsNmHRhFH2x9UpcG3D83wQjXGqLNNXCLPMpaxRlGtAqW13m8UURh3x5WHUxOZGvbmYz8O09yiSIpi1McrfvQf0HKRpmOOjtyn1J/t0fJ18Q1Zk1ZuLrkDLZEFBOWVXKYFEoOMJJk5YPbmWm1+F9T4L/qwNO9HDfaZyhAPlEo92xlqpvXy2+tOsBSE5wqpTqTCuBxNFzO1gLfdg/Vrg81ZMR3x0Pdgjty0TlKwlZIDGF0Et/e3CqBqSriP5niapUoDk2zmbR3L085m3fy0AYHmH9mSjpJagK0qwsUmruWvgdQJAcOQvTaGSgIZTpAuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sks57Pdiy3DsUlY78sGLqKQaKqUnegE7blTi16axG4=;
 b=Aa94+g/Kkm2lz81fte5LrtzQD92jrOuA9BiGFroV8VBS88Ir3zKVmDuuInvuIaJa/O1S1mF06UDY27UH2PbrqZXUg2qHdJ2ahEymsXxyC9JQ2t76fbRlDwHqDa0O6PiKvw9cMPzC/K1AXiOqlUfg526H3RgTYAFonkYLvypbzoI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1917.namprd21.prod.outlook.com (2603:10b6:a03:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.1; Wed, 28 Sep
 2022 12:35:52 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5709.000; Wed, 28 Sep 2022
 12:35:51 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Li kunyu <kunyu@nfschina.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v6] hyperv: simplify and rename generate_guest_id
Thread-Topic: [PATCH v6] hyperv: simplify and rename generate_guest_id
Thread-Index: AQHY0wWAn4eYrCeFCEqrBCnuHNCYHq30xvuQ
Date:   Wed, 28 Sep 2022 12:35:51 +0000
Message-ID: <BYAPR21MB16889F4DB933D8B4D110F4DAD7549@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20220928064046.3545-1-kunyu@nfschina.com>
In-Reply-To: <20220928064046.3545-1-kunyu@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94b32edc-c39e-4877-8064-24ccdf3b9ba9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-28T12:33:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1917:EE_
x-ms-office365-filtering-correlation-id: 16f02614-19f8-454f-c400-08daa14dfab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jm+YPNO947Zj+cTm+Zfk1CdBP8jN7UFSFEKjovzA5mGGlkqirJHgmMSZf87m22LYGdDJn3WcZ4Dadi8zSgPxI9m55NZJ5xtxPpOoNeORSsRXVNzr3CEuc6p762FjmjpwSMuEXxXcr085nvF74GNuoxgm5MQakX17LhzwZ93NZabpIMP4sK5Oy0fSJO1ObbZoZP3spOG/zU4oMCrN255N2VCIuADlYSgzNtdmz+dasyOCbRDB3uWbt/Vw7P8AjbA4RZGJnDh5k5uxPQJ9g0+607skzFCoUcW+WFEvkCxo+3jwSK6F/Np+Db8uc/Xud4uNmaFt8ljHDaLcBDiIEHZxc4LtGvTnt1QkW0EtHrxAu8a4h0eGy2ibo2aMFaK6U4uFmgBKbK2GPfBD26NPTc49NsSnRQeFarmuweXUzVdZx+m8fsrF4rQxEQPTSdCae8KEtIu2QxtBsNyPmOX4Lk+vODIf6iV0giMV532OX0ae6HWLAiM2UAHEjW4TtovXCmcTE6ZP8I/YNUf1YRPAL2yjvjqKzPEcYMmjpJVBTG+JKUUXh0C945vZtRcInvr387eHVkjVg1zfdAI2pxp8Q44etBZC56fYE8WRTZeNkD3NgqNpw53kOGbN4+HnU0sZPK3U+Uk+nfnpB1oh9AIJ/Bsd2xopWgihpA4u4dSKUy/s2WYdqs7OP9lGiA3aQNj05e/X8Va6UtlTjvujXyxjVyZlCaxUp8XHhLaQaeyZzBihE2X0O+MiYbRxmKpHkD/AlZHrDeyYeVAM1wGI6aKS2hEUAfleg0fyE3N3YoEFC7HBjcHhcYSiNKPnBa3ne56/TmBPjk2AQv+clilffnsM1jXE7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(64756008)(4326008)(33656002)(8676002)(8990500004)(2906002)(66446008)(316002)(66476007)(110136005)(41300700001)(54906003)(66946007)(76116006)(86362001)(66556008)(7696005)(6506007)(9686003)(26005)(186003)(83380400001)(71200400001)(921005)(10290500003)(55016003)(478600001)(38070700005)(82950400001)(122000001)(82960400001)(38100700002)(5660300002)(8936002)(52536014)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FQiSLB37Di1Z0T6ZM7D/TWZ7Y31BPA0Q/WNnSlEu6lEKriwx3tRrc1nNfCR/?=
 =?us-ascii?Q?THQb7luE1kRD2yrsUyCG1CgQnUd5hKavWQp7amgLgx98Jvs6pIiECDazkIBt?=
 =?us-ascii?Q?ssM4jNx4KQzI9IaiX5aYrj2lEUnyNbV68jB4g4vDFLtzI+dmc+JUuHeDtr/l?=
 =?us-ascii?Q?czt8wbYyquuah6Ds1BVmHIkkLWspLtr1Zw2+tLrGKsCiPAgugi9Yk3qBMb71?=
 =?us-ascii?Q?eOXYKYcExD03gDWQP5ooAD1L4mlfwmCwofL5fko/F0jhEOPlyHkrX5QUfm34?=
 =?us-ascii?Q?/FD+IivSIQwLuiKmit87sNsrhFfJ9J3oTCi0zs+ZhgVtk07H/df5iyLXIOjI?=
 =?us-ascii?Q?fP9Rtsw0h828/7UDxa0t0tDPuW+zodxcYiNMVZzGs9Q4R7q+gRbsWS5tbkWj?=
 =?us-ascii?Q?PJknBSFppINAVyg0PKjYNDKeJfYrWhUlm00qLFR/XNDAys0RGevdGBJq25Q1?=
 =?us-ascii?Q?unkXKrQLp24OF4tCvpy+ytBwfy7fOdMshpRmUuBibLhlSYPz9YQ2itRqXOMP?=
 =?us-ascii?Q?EwHtxW9qvjGAStNaD1B+tVSYNrmZXHin+DWwojN6m+RLhB610RtFT38hnO6K?=
 =?us-ascii?Q?UR2eJzWOBG5yLa6gWMTtBW06fvMFb8Rk6mkJXeIXrMtdb9GCHTezL0EgSRow?=
 =?us-ascii?Q?UEBFfI+k9Y5FSElheyWWj0Ns6aPb2IPsLHviBqkXoYVOPyBjbSnS+YxGTFLQ?=
 =?us-ascii?Q?cvzIqFNmieWV4K9ka+XuTsmZvC5ohOdDHbxlbVlrybYeTsGYiGnhr2Ov1T2l?=
 =?us-ascii?Q?d1Yn2vkkNusM4KVMoaT6N5LsCIn4SkecX+RKxHDatWp1p2z/4EWhB/qG0bJI?=
 =?us-ascii?Q?SEw4t//YJVxpV7z9L4i3mLOCrqluwTUgXQPLdfa+A2l9ORvdsbcS1yiDp25U?=
 =?us-ascii?Q?fuACNbnrCG6ZQxA2glhEUpGB7jmykxLmZwOP8rMjuDmXNDk2FO64TuamnoVx?=
 =?us-ascii?Q?dGtfygtZDdud+AXGNi7joWrn6DYQgsGKkT4GlgW7q2zoVm1ejCmKaYBNBvrR?=
 =?us-ascii?Q?BXmz/3EkKc9kkn5RGOQYZLY9xVHBG4rmH2TIwkC/aPh/cf4DoG/NsjUDIWBh?=
 =?us-ascii?Q?PdcinUrGSKTIMp9gW4au2sywzRXP9YiFpbkhe5RK0nkbO/Xc8yOQ0KeYOFxD?=
 =?us-ascii?Q?mL8L5ZJeie7aQKT27rNxdcKDD12FR6AyeM4eO3WocbKsJ6gW1GsJmgZfkuO3?=
 =?us-ascii?Q?nZUsVpAFMMzlxfITMwyOJ/OunjL6wKwKrPZTl4DxKlLPyOzoFIUUiG6j+2+D?=
 =?us-ascii?Q?ym1eQAv92OXdQ9HENfT7hii/F9Ei0s2EWsO43jg7Eysrsx/t/foOoDQbX34T?=
 =?us-ascii?Q?LYb8nW15egJcq5b4pz7opOJ3BPwhCJS0BGG0OzEEOCFWQ6GkRSt02DsI5Rvt?=
 =?us-ascii?Q?Ea9c/agx7pxO+U9M2aW8UEjF9VO8TxvI//EcVt8zZ8Ej92IseVvZGTJFzbTE?=
 =?us-ascii?Q?/bEYDFppcrSYQM51AAEBXdMX0J3phiaccOHQMKhp/6OKbwH4gkZqZ49Mg+7m?=
 =?us-ascii?Q?SNGOSQxHbDmhW32GhawZdgzd5m1Xu472jqkOu3g3CzELUD9Vk3w7OwfNojgP?=
 =?us-ascii?Q?TVAdzrJZejcCmg+SnM6bHwyRIzYbc45ItjtFQHwhlBP5ndL+RKqzaCcE5C0a?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f02614-19f8-454f-c400-08daa14dfab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 12:35:51.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PZSok9oNCy8FM1PB7VmZ0fuB3cvpPWCaeGJMHl6I9sxYXcYxSZvCpbj7st1kpBLUMqYj5siVm/x54g2J0zVu/CPe4M7KYqGuRJrYXm06r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1917
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Li kunyu <kunyu@nfschina.com> Sent: Tuesday, September 27, 2022 11:41=
 PM
>=20
> The generate_guest_id function is more suitable for use after the
> following modifications.
> 1. The return value of the function is modified to u64.
> 2. Remove the d_info1 and d_info2 parameters from the function, keep the
> u64 type kernel_version parameter.
> 3. Rename the function to make it clearly a Hyper-V related function,
> and modify it to hv_generate_guest_id.
>=20
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
>=20
> --------
>  v2: Fix generate_guest_id to hv_generate_guest_id.
>  v3: Fix [PATCH v2] asm-generic: Remove the ... to [PATCH v3] hyperv: sim=
p
>      lify ... and remove extra spaces
>  v4: Remove #include <linux/version.h> in the calling file, and add #incl=
u
>      de <linux/version.h> in the function implementation file
>  v5: <linux/version.h> is changed to the definition position before v4, a=
n
>      d the LINUX_VERSION_CODE macro is passed in the function call
>  v6: Modify the patch description information to the changed information =
a
>      fter discussion
> ---
>  arch/arm64/hyperv/mshyperv.c   | 2 +-
>  arch/x86/hyperv/hv_init.c      | 2 +-
>  include/asm-generic/mshyperv.h | 9 +++------
>  3 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index bbbe351e9045..a406454578f0 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -38,7 +38,7 @@ static int __init hyperv_init(void)
>  		return 0;
>=20
>  	/* Setup the guest ID */
> -	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);
>  	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
>=20
>  	/* Get the features and hints from Hyper-V */
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3de6d8b53367..032d85ac33fa 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -426,7 +426,7 @@ void __init hyperv_init(void)
>  	 * 1. Register the guest ID
>  	 * 2. Enable the hypercall and register the hypercall page
>  	 */
> -	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>=20
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index c05d2ce9b6cd..bfb9eb9d7215 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -105,15 +105,12 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16=
 rep_count, u16 varhead_size,
>  }
>=20
>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
> -static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_versi=
on,
> -				       __u64 d_info2)
> +static inline u64 hv_generate_guest_id(u64 kernel_version)
>  {
> -	__u64 guest_id =3D 0;
> +	u64 guest_id;
>=20
> -	guest_id =3D (((__u64)HV_LINUX_VENDOR_ID) << 48);
> -	guest_id |=3D (d_info1 << 48);
> +	guest_id =3D (((u64)HV_LINUX_VENDOR_ID) << 48);
>  	guest_id |=3D (kernel_version << 16);
> -	guest_id |=3D d_info2;
>=20
>  	return guest_id;
>  }
> --
> 2.18.2

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

