Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6EF617506
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 04:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiKCD3z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 23:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKCD3l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 23:29:41 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020018.outbound.protection.outlook.com [52.101.51.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E7140D2;
        Wed,  2 Nov 2022 20:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwUDcjLOD8D4vav9z5/4IvmX/Np9bWWlaIs6g26JP2Fj8qac9aMSYztnY54B4gJ8TlYSyFhuRbX6LNfquV8rLpNRtwbvw6iwnculp2Xyjn8ax9jsfxEcGhnwK0q/qyeacNAxWVYB2LQXStOjbkfV10cntH2Tj+/7VyevhHbiX9nt2l5RgxCEbBVIlnaWAayTSWLdYBoD/Zy8SCbVvj7EbyLSLmntQOH/vgaLUnuIlGW7j3PfE2CiBZDrrRE283TYZP9gNTaOHx0jrN1LbMLuhQlhitMydVqSs3hYzNIhON7bbz7NxfKspRvF0Pc1ABXAYctoX9aKrksIeQQxrvJlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohlwCDMUVLSDwbME9Ih3nSxFIDDF/BM1N3aomU/DWSY=;
 b=LlUjfnsIx9CIl7gezMIvQXc17nWeR3tAHThSCPP58kJa9aEx1qwoCWOaPDb88RmTPJbt2fLhbBnzSwlR4QAzAwzfiex4aTfiPZllqHCBx0TnLWddih56MdsmQWQTPlmBYsC6QyqkAEvFkuSxSj+fHYsjj1y7iBETEW2XPva+CXKyaL/V+1W615PniUum/tTmBzX04mykbia2R2BxcuhPa7jXlSsVZvQ4WRMh+C/cSbUNTRbEH4lfhWoAPFKrjHMPJ30vI2a6CaKUcxV7X45UPyztyEHx7kwO49STR6kpv9i40h+bUlG3i793xk5J6RKfT/orr8j7VZAg5hWk9majcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohlwCDMUVLSDwbME9Ih3nSxFIDDF/BM1N3aomU/DWSY=;
 b=SKIiPE5OVSKM7PqrYc4p4eNN2StJc1tCCBLkQplUDjKSkEkS22uhR9bQahowwMVlIk2gxU+rmhwDQ7EGT35w0d2n+rLfTpy1Vv9EENQaNMFUjlcB76//LBrTTPm9bXPMtBnoCl0HKIDCvX4BSC2l7pACaC6o+ZDEoRi8elu7Cmg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3660.namprd21.prod.outlook.com (2603:10b6:930:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.4; Thu, 3 Nov
 2022 03:29:33 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Thu, 3 Nov 2022
 03:29:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] mshv: Add support for detecting nested hypervisor
Thread-Topic: [PATCH v2 1/5] mshv: Add support for detecting nested hypervisor
Thread-Index: AQHY7tn5bsmdAZwizU2TVR2V3RzjLa4sfhsg
Date:   Thu, 3 Nov 2022 03:29:32 +0000
Message-ID: <BYAPR21MB168821FC33948CB96E5BDB7DD7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
 <4200eb3ffd5453cc9c9812b05283f6c2d6a6bef5.1667406350.git.jinankjain@linux.microsoft.com>
In-Reply-To: <4200eb3ffd5453cc9c9812b05283f6c2d6a6bef5.1667406350.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0eb085d0-f775-4f75-b370-bb3e34c0f466;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T02:42:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3660:EE_
x-ms-office365-filtering-correlation-id: 390b2e2b-ede0-4e83-64c0-08dabd4b9fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GztlRupTUmLPHD6IkD2XlR4UEgDfGqHlJ04fqRc/FMTuM7hkyVqbr7WX85pQZKCoemydgf3KdObRGEbWfLcPWCt9pziyh3FcoyAJnW4KkmacQ7jEfXY9WvrKP5HElTeAfy+rEFHJh7CfuefHUizV/GY3k5VzpGQs9WGK1n0Ykqe20FrJZxOxyl/po1ThbYlEAK72Pkxvksn4t87xqCRolx90waByQh055Lpoi4RU6xNWwngtWeLR7XVyKwCWkzx+jJZn4Hiwsl6QRJ/qChs+IgayWxJnh6n77IcFPYcEoGl4a+lVbW9DpNusgJMHMZkinhASt48OtwtbIT1Hj46LwDsD7/8UUPWk4Us+jOb0aK3QQfTpsbggTc5dF2J+xs315Ko0mIzlGhVXMP8qLyK+jPUqGdz1gByfXqEIi6CR69jhzAReziERekQVw6T+lKbE9wmiUmXZ4xm24wCInyhVFAJDnlSMm31k4gbOTotsZV5Oi5YrminmNb2aJ19dxrHVAtbK0Rd5y+HjiGEPkBzSe74IpzdQBo6hSmsXfb0wUb+P4hCXKBkv/PxCEvL6H4iAZCAISSfUZ+HBWkny+tozHBUEmlu6Js3xLjTtakVFiEHcY5ifS85MSQRBJ1aeY4gjjoTNMGz5eQJO+ySzQYpWH0Y4dV80yFPeD7hH4m64IwJY/KxM8/kdFrZ0UaIYqkMpNtWUOYDXRZI+bp5j2R6Z5cQ9kUcQjLM6cVGOU2EbXabTPTQpApciH05alf7dor4g7AV6bz13dQfTHHevxZ0rTLtOj1lnJYy1GHVRxOhjld3QbpaiIEqTywmyLelUxhQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(8936002)(52536014)(41300700001)(54906003)(110136005)(66556008)(66446008)(6636002)(64756008)(316002)(66476007)(5660300002)(76116006)(66946007)(4326008)(7416002)(10290500003)(8676002)(2906002)(38070700005)(8990500004)(478600001)(71200400001)(6506007)(122000001)(9686003)(7696005)(26005)(38100700002)(83380400001)(82960400001)(33656002)(86362001)(82950400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wz1PyV9X2BPxVwcAVf+Pq7MVrWuvqf3I3BwZ+MnOfYUwpSMmqxZgTPpol1Jk?=
 =?us-ascii?Q?Jo88I6vPCGg/cXee8U83PTb2bVxwXikUdePliFnikAt/0cx0dTCu7Gw5PyW9?=
 =?us-ascii?Q?3J3SF2nE7kK5wSSDCLsbrHpLCbG2NV0fi/zNdvLVHxCG6ScyacK/A1ORaE1o?=
 =?us-ascii?Q?qdhfmqrNeZ+hUW57e7TjnhH/SsnsdYTF44GYIiKSV5SFXQeE2yLVkohRuzg7?=
 =?us-ascii?Q?UMkdd8Sf4HFyNU68gTtYaT4bvCNEBHwdmSiWMMeowBHhJZ8TNJMjVQbigGmv?=
 =?us-ascii?Q?sx/ykUm9PvLsA8/gjftvKljB87heOUlFTCoEpweICOruY7Hq4V9amuAiA9bd?=
 =?us-ascii?Q?/1PC8BXtnyopMj8657SRQD1U16vlj9FhcL2gnYRfrCmBfUY+vgPRN0rivMND?=
 =?us-ascii?Q?unkWARWixSvaUTzk8OnKSu0Bo3SlB19znXAMQCC4SJRyqUFgln/FBv1puRuF?=
 =?us-ascii?Q?XhCzFoHefYlwArcnJ9JWmAJ447aDaBApBup3dT037+Q+P1OhM1oqClnO42k/?=
 =?us-ascii?Q?1Ios//476WlYmQSpF9AatepZVPhvn5IeJGGSjPVASnCPYsiWd5lN+61eZQHg?=
 =?us-ascii?Q?uhRF8v16AtwsDl5wDaJhCgbVObbUJQKjj5YDhXi02HBq3GQoIo/u3gXqmFmp?=
 =?us-ascii?Q?7wvCU2oRDH5Ts3K0RRyjH0K2N+OKgHlVEKoyii5o+REh/qoazLvQ6nOskNQf?=
 =?us-ascii?Q?gilt8krR9npZFvIVn4xbF+o6Dhxhe+xTLPYC0KNsY8CsBZC8jRyERvhN0Gwe?=
 =?us-ascii?Q?ZpIkvYIcn5stke3AkBCUOpAzrLRMkS//8As/6ksVfMe9CrgYlNRo3Z0wKomU?=
 =?us-ascii?Q?G8cAKyY3uKBgsaqOt/EBSai4QT4pVonYohhCSTCeGUKb9mVf/lzDwrACPxKV?=
 =?us-ascii?Q?aixH/A6M2k5q3PGAQD/XrthSPJxpeM5grIim9HpHy4bF9mvt99ZwH9+6SswM?=
 =?us-ascii?Q?vlwK+wFadP7pxQhFqr0Sm6r1AIunzCvwEpZZWV50OyAiyjOzqWSRu/4WqdX7?=
 =?us-ascii?Q?ru+kN89XgMmEbOB5oAZoapi2Lld0p0tl9wDdmvs7JBbihNbkCxeGJs757qD/?=
 =?us-ascii?Q?uZuG1X4k2nuK9RAqpciylB0eDWdauYDz2ANwefqq0+rXDrrbRYf5FLc5UIms?=
 =?us-ascii?Q?guXVQMKRkYScUAS69NE0J80bwnVpksoeU3C3MMZesg3H01Dkx71DXQKZMvom?=
 =?us-ascii?Q?gzEF1Wx1Ek8Vn0ocXTC60NYIPFHRsT8HDV4dPHFVjYslL1xcGtgK8OF3p6Uh?=
 =?us-ascii?Q?BJYaA1qRGMMlW82EQKKy9H5AEC/7606hBQ0lM0HTVpXWF2555Ac64HQmh557?=
 =?us-ascii?Q?OnX4u3kZaPIIwNG2LwU8p3HQydLQmDPFMUgXcaawHBs+pn/Nj7f9CfIJlLa/?=
 =?us-ascii?Q?L5O6eCLEe8qvSkI7hD55KTGrTFSm9z8SQvhKJVEPOP1aAAGNlD3iKC4/nsoo?=
 =?us-ascii?Q?nHb3yi1N/LRRqUcHXnoFm+TjYmtlw9TtkJyWIGjwZNUxeX8zyFMfinicMtZ4?=
 =?us-ascii?Q?lSgbinRMcAh1LWtymHwZKc9J1Ok+p2TDofCctWgrd0bjdvKFoD0xkNKqh/MZ?=
 =?us-ascii?Q?RNROlXnnJGxpS8fR8eoC9FJWwIC+x6xhTjHe/7zokPUtA0hbwUvTlnRuk4+d?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390b2e2b-ede0-4e83-64c0-08dabd4b9fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 03:29:32.5973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0adWLhHjRXMwsCR32Guw6uV4MCvSQGqyyq+ZUzH5mrCk722ZtrM3AvZlhPdoEib7JPSbeI/VJJ9mexocFygfHpE+fHKO3CdH4vSxCdVA17I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3660
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Wednesday, Novembe=
r 2, 2022 9:36 AM
>=20

The email subject prefix for a patch like this is usually "x86/hyperv"
Check the commit log for arch/x86/kernel/cpu/mshyperv.c, and you'll see
what is usually done.  It's best to maintain consistency.

Same comment applies to other patches in this series:  Check the
commit log for the relevant files and pick the prefix that fits best.

> When Linux runs as a root partition for Microsoft Hypervisor. It is
> possible to detect if it is running as nested hypervisor using
> hints exposed by mshv. While at it expose a new variable called
> hv_nested which can be used later for making decisions specific to
> nested use case.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 3 +++
>  arch/x86/include/asm/mshyperv.h    | 2 ++
>  arch/x86/kernel/cpu/mshyperv.c     | 7 +++++++
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 3089ec352743..d9a611565859 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -114,6 +114,9 @@
>  /* Recommend using the newer ExProcessorMasks interface */
>  #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED		BIT(11)
>=20
> +/* Indicates that the hypervisor is nested within a Hyper-V partition. *=
/
> +#define HV_X64_HYPERV_NESTED				BIT(12)
> +
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 61f0c206bff0..29388567eafd 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -190,6 +190,8 @@ static inline void hv_ghcb_terminate(unsigned int set=
, unsigned int reason) {}
>=20
>  extern bool hv_isolation_type_snp(void);
>=20
> +extern bool hv_nested;
> +
>  static inline bool hv_is_synic_reg(unsigned int reg)
>  {
>  	if ((reg >=3D HV_REGISTER_SCONTROL) &&
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 831613959a92..2555535f5237 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -37,6 +37,8 @@
>=20
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> +/* Is Linux running on nested Microsoft Hypervisor */
> +bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
> @@ -301,6 +303,11 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: running as root partition\n");
>  	}
>=20
> +	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
> +		hv_nested =3D true;

This reference to hv_nested will cause problems similar to what happens
with hv_root_partition.   See the comments in hv_common.c about how
hv_root_partition is handled.  I think you'll need to do the same thing
with hv_nested.

> +		pr_info("Hyper-V: Linux running on a nested hypervisor\n");

A nit:  Let's drop the word "Linux" from the above message so it is
consistent with the previous message about "running as root partition".

> +	}
> +
>  	/*
>  	 * Extract host information.
>  	 */
> --
> 2.25.1

