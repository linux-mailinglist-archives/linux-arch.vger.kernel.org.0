Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E6D76621F
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 04:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjG1Cxm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 22:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjG1Cxm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 22:53:42 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC1B135;
        Thu, 27 Jul 2023 19:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGcUtPeO/3J8SA30fPg8OVL+gCE8FokjL8hRk8gJyIgkSBpjTnwyMPozkWtTM1qgMtoUkEaa8j1A0OZ67HKeUbeJfpUzNLE9p8EKyg3DNe5AOLORrrcfAWR4RnuIiGCnCGTiXz/+K2F4tkCQJjCGhx8vm4LHLtIMP1Zawvf6+oy3Hh5dKP1sG/qvt7ufF7bwgputqiMUhPSUcF5qx68difOcwXVymUPL5W9TagnTRzil1y+AgzkrqAbSykxGU/dTVHmNtPAYTfknZVaHvS3EaUWRGjSXoavHwEaG68JVJSNzzAKf6/wyyHCsPNrOs6d1pfOGwDFRal29gDmKBSTFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywn4oIF7yIGoQpPJTc4FeEzxo+K2CG9BwwAqk6fmjvs=;
 b=Vvoj6swxMwh6eBEAvoOcyu2TZN7m2+IDxg4rybLbYVoki6owWf9kark/vYWztDS+7OC05N2ksZVoNQIK06HtPF2jk5xSZfoHRyao93dACSbQt80+HcvHBQNojPP+v163l9fUqJY7GD63P0d2dxiAeuVcJJ1GYqFjFNCPxQabWzgy4t23mhlUAFy/ytSVx6Tu0SMSE+6GHNNCBFp9LQ85YKtPWPD8cK6V2+dYxQti53rLYbeoH+ipdpB4s/0TWZCvNJtoesmgBjhF4e9EKv4Ez6K4I8MeTDNydH07o6/SC110FLbeF5sWlQDlZxHPlMscX8kIRRDWMUh4Xgj1GXg6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywn4oIF7yIGoQpPJTc4FeEzxo+K2CG9BwwAqk6fmjvs=;
 b=eC20vs9U4/RsBWu6xIYKDNIlG905lInrOKMkRrdFeKbVByjy9Q2TeTYvGfR+PNF+EoL9GmWNaSYrRAuzhfxcw19l8jUHSe3kviW0gJDVwjzn20Qb2Vx6nCpNSJYSe0wxCS6scdY/GTVMS0RWIt8ypiBli7VU1Mb3zkeB/n9zEYk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3345.namprd21.prod.outlook.com (2603:10b6:8:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.12; Fri, 28 Jul
 2023 02:53:34 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Fri, 28 Jul 2023
 02:53:34 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to
 isol_type_snp_paravisor/enlightened()
Thread-Topic: [PATCH V2] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to
 isol_type_snp_paravisor/enlightened()
Thread-Index: AQHZv7+RsjMozEQY302P4ZO9WR4CfK/OewCQ
Date:   Fri, 28 Jul 2023 02:53:33 +0000
Message-ID: <BYAPR21MB168896AAD24E773B92DD2B10D706A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230726124900.300258-1-ltykernel@gmail.com>
In-Reply-To: <20230726124900.300258-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=033a481f-71f0-47a6-a529-11df2d193246;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T02:43:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3345:EE_
x-ms-office365-filtering-correlation-id: acbcb1c3-59f9-46c1-e84d-08db8f15d55a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWOhJeOYwfxKHJgXok9WcfgcRh7zcXYTrtV7DvrFyyrcyCHKd0w4zfcQlXOhmlR/hg+GlUdE0xXz0LYsR+sdMx5veeA9VsZ4fWeX2us6ad4XdhAZ3DT3ceaev9ZYn1+KqHmwnv+rDdIu/RIfdo8OUxrwRRt5GeyH4a8J3NDbCfts4KngIOPp8rnicy68q0n3ZvbP/xhdVkjYcBxlJYEnDRXy9H18+XaBfZIT2If2Xp7LifSeG6ZsJ3uQnCXe90017SLT8AE8M8XLL9POBVImFWdGDvO98E004AZ5/vlBvFztupF3tC1qoQXx2lD/0d4vKcsBCGqfCCj5YzOIgLCJYVw5PgN7ZYFmCK1rDgNMc8miJLtbtzyDY4/6BuJ08VHTALuar55f72mPCtxoLuujLdjHcJP7uFg+VBuoUMl58yQQfNnfkM6qMffwyYsXbECeSv3KTMb17wCnCLioXZss1SYaB/v8PUUZzc+h6ZtyGGjujMlJ028tmWZbmgJ8V9sD8CWq2YfsHyszvI5B6MxIi1qD2HMvQnkl8oKi68ExAUfht1LcB1/tHI3HkNh3Ri9N9Gbx9XmlEnNi3W+urX+ZrcY/zmR3+AjGkOpCAKZOk3gz5Fz9KO9z9Fl4bTfRtQbfQ3n9Q3mth8xhgHcuxmr2U8dV3ZP8J9GL/JZYhcOwL0A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(71200400001)(478600001)(54906003)(10290500003)(4326008)(7696005)(110136005)(82950400001)(921005)(64756008)(7416002)(41300700001)(66556008)(26005)(8936002)(6506007)(2906002)(38100700002)(966005)(122000001)(66446008)(66946007)(316002)(52536014)(9686003)(82960400001)(8676002)(5660300002)(66476007)(186003)(76116006)(33656002)(83380400001)(30864003)(8990500004)(86362001)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TfOrSaRPhPRitFemRmj3/70e6lMAYf1V5/xqBtvQgMF0r/4F1u3pxKKYqBfw?=
 =?us-ascii?Q?VT5aePi4MWcHDy7yg1z9HjuQGPv5bWct8dyvayjCYZQGL6JEHWv0ir+CKZGD?=
 =?us-ascii?Q?J8qaICKeHERe9U//7+x7EL/fOCET1JjAXIZYF/LJ+YisunYmJWb8+FIw6XKu?=
 =?us-ascii?Q?DnThyUUZH642eIbmlgYtpJ3OEINi1rl5oh4BX2YQOOvnQMtwHRBUoyHaguMw?=
 =?us-ascii?Q?3Ff3j3iNNOnnJPkk5Ns54JwKndobxgT87+4GTMVM6uxeRCtiNgm3MaE/gIgR?=
 =?us-ascii?Q?A2vxHnXt8k+H8srl1tqKZsTThHUix+FdGX6KnIsyJn/nTYwgIv1jpTDr3Z1j?=
 =?us-ascii?Q?AnF6WLc6v3xpP1LPOgGOdSbRih3UR6VXgbpnNuQJGP49BI9koEBTG7IzyNGJ?=
 =?us-ascii?Q?TJ2/dZ+oYOWnjtXsUWHIGwLNvkIQK9U4GuVdkx9peEkoMWgbrowef1p2V6gX?=
 =?us-ascii?Q?+XtSvEBNJqvROSG0YgYPUjBNHJlgW78YvjmzImRMNIHNUf5RLTSRvYOn8KmK?=
 =?us-ascii?Q?ziwY0b/nB6xOqZtIhcf4kSHVq9RGbt9oM79dqhnBAyDViPlFowsjmuVxV+cM?=
 =?us-ascii?Q?JY02tgbBf5+MRabj9Yj0lctuwGsh8+IuzEgep9DLBHn4sHMmY35QdOXCS3fu?=
 =?us-ascii?Q?Tiz2n8YO5CkHgrW7yLCylncSyhNwss7ZY2Nei+8PWSCNFfsGfeM5mEDdR23l?=
 =?us-ascii?Q?/4O4aylpgF19fgMUDY7Oj33hbCbprKR9ZsLhlxV985hdRwYgAPnNDu+rTwaI?=
 =?us-ascii?Q?ffUDx/+G1TljhTTwJ138zU8e21uq+XlBjkTIHB3nLtQMclKDpKqxfp2bVxOL?=
 =?us-ascii?Q?3O8MklNpXER6jgEjyQiD3l07mjhQrZdMfArlkjHFELqxDEleo897TPd9YW64?=
 =?us-ascii?Q?1rr79zgKiN1WEYdEywbSSmA6hk7B8p5aHk0YSeLvcmwHmOid688HLsAulCMB?=
 =?us-ascii?Q?EPo4Ty+ROY4XV6882eyzcaxsUvem4rvNi0A6qYRWWkFwmW2F8NzsaP0lsxkr?=
 =?us-ascii?Q?thlnhp1hdfQZ1Rukr/nscPZiHH6mq+tRh+CzmGRCQ4txj+O1v+JWwG8jBGfQ?=
 =?us-ascii?Q?Rv+6fBiEh8sQqxb72WiS2C0n9VwCHdhYp2uU1kl3TJL0o1XJLmQnMiRr+AkG?=
 =?us-ascii?Q?CdnsKZ4Fzoo62RNlE515BQOPllxTzA1kEh4Yl2TI7LlDAGCF/4oSYog6i8+w?=
 =?us-ascii?Q?4zyJ7jNXYnD3XMDTvRpoo9GTxxAr3CBX6v0rJI2fNGyq3q/4A5uYqGkh3BZ4?=
 =?us-ascii?Q?HwOp+D740wvKoQxwyoj0mwmtmgYqirMWSsf2wOPtOXyCvwIp7j8ATmC1TZi8?=
 =?us-ascii?Q?jBGTx3D5x8EmpUXLzpDi3uIYWQflx0kphxP32cIBjp2Wo/tiY5Oo9w0k+n4C?=
 =?us-ascii?Q?766BhFDA7OLhqODuGSe9qLq8CxFHt2Z2xbnzZ/P+yiSJ173DMu4e44zxR7G9?=
 =?us-ascii?Q?7LnqqdltfyOi9fg7DXKi9452o+S3BDv3rs48EKoPVjUx1E/Ef8/tk14JwRuM?=
 =?us-ascii?Q?Z9B5CA0LWw3oaS+SP5FGagez4g09TYxZIkwL4YO4QrN10iyuLhisHQ8o84yL?=
 =?us-ascii?Q?z+O+TpH2KWhfxcMYO5q30m770Fp8Z/RR3OpOlZdG6uxX726ph5HfV7RByLBP?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbcb1c3-59f9-46c1-e84d-08db8f15d55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 02:53:33.9289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: od7U5qCoAikGRAaFXeAKcLQh1+XNS/M8wSOHnOVXSqVkUJu8LL/IJi7zXkVwJDzqh2WmgfbTeZcogjWS6gx4QeLZnoCfoMunju9iMsOJpiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, July 26, 2023 5:49 =
AM
>=20
> Rename hv_isolation_type_snp and hv_isolation_type_en_snp()
> to make them much intuitiver.
>=20
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> This patch is based on the patchset "x86/hyperv: Add AMD sev-snp
> enlightened guest support on hyperv" https://lore.kernel.org/lkml/2023071=
8032304.136888-1-ltykernel@gmail.com/
>=20
> Change since v1:
>        Add "hv_" prefix to isol_type_snp_paravisor/enlightened()
> ---
>  arch/x86/hyperv/hv_init.c       |  6 +++---
>  arch/x86/hyperv/ivm.c           | 17 +++++++++--------
>  arch/x86/include/asm/mshyperv.h |  8 ++++----
>  arch/x86/kernel/cpu/mshyperv.c  | 12 ++++++------
>  drivers/hv/connection.c         |  2 +-
>  drivers/hv/hv.c                 | 16 ++++++++--------
>  drivers/hv/hv_common.c          | 10 +++++-----
>  include/asm-generic/mshyperv.h  |  4 ++--
>  8 files changed, 38 insertions(+), 37 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b004370d3b01..3df948c69cff 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -52,7 +52,7 @@ static int hyperv_init_ghcb(void)
>  	void *ghcb_va;
>  	void **ghcb_base;
>=20
> -	if (!hv_isolation_type_snp())
> +	if (!hv_isol_type_snp_paravisor())
>  		return 0;
>=20
>  	if (!hv_ghcb_pg)
> @@ -116,7 +116,7 @@ static int hv_cpu_init(unsigned int cpu)
>  			 * is blocked to run in Confidential VM. So only decrypt assist
>  			 * page in non-root partition here.
>  			 */
> -			if (*hvp && hv_isolation_type_en_snp()) {
> +			if (*hvp && hv_isol_type_snp_enlightened()) {
>  				WARN_ON_ONCE(set_memory_decrypted((unsigned
> long)(*hvp), 1));
>  				memset(*hvp, 0, PAGE_SIZE);
>  			}
> @@ -453,7 +453,7 @@ void __init hyperv_init(void)
>  		goto common_free;
>  	}
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isol_type_snp_paravisor()) {
>  		/* Negotiate GHCB Version. */
>  		if (!hv_ghcb_negotiate_protocol())
>  			hv_ghcb_terminate(SEV_TERM_SET_GEN,
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 2eda4e69849d..2548d904e45a 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -591,24 +591,25 @@ bool hv_is_isolation_supported(void)
>  	return hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE;
>  }
>=20
> -DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
> +DEFINE_STATIC_KEY_FALSE(isol_type_snp_paravisor);
>=20
>  /*
> - * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
> + * hv_isol_type_snp_paravisor - Check system runs in the AMD SEV-SNP bas=
ed
>   * isolation VM.
>   */
> -bool hv_isolation_type_snp(void)
> +bool hv_isol_type_snp_paravisor(void)
>  {
> -	return static_branch_unlikely(&isolation_type_snp);
> +	return static_branch_unlikely(&isol_type_snp_paravisor);
>  }
>=20
> -DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +DEFINE_STATIC_KEY_FALSE(isol_type_snp_enlightened);
> +
>  /*
> - * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
> + * hv_isol_type_snp_enlightened - Check system runs in the AMD SEV-SNP b=
ased
>   * isolation enlightened VM.
>   */
> -bool hv_isolation_type_en_snp(void)
> +bool hv_isol_type_snp_enlightened(void)
>  {
> -	return static_branch_unlikely(&isolation_type_en_snp);
> +	return static_branch_unlikely(&isol_type_snp_enlightened);
>  }
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index c5a3c29fad01..e543a5a1b007 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -25,8 +25,8 @@
>=20
>  union hv_ghcb;
>=20
> -DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> -DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +DECLARE_STATIC_KEY_FALSE(isol_type_snp_paravisor);
> +DECLARE_STATIC_KEY_FALSE(isol_type_snp_enlightened);
>=20
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -46,7 +46,7 @@ extern void *hv_hypercall_pg;
>=20
>  extern u64 hv_current_partition_id;
>=20
> -extern bool hv_isolation_type_en_snp(void);
> +extern bool hv_isol_type_snp_enlightened(void);
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
> @@ -268,7 +268,7 @@ static inline void hv_sev_init_mem_and_cpu(void) {}
>  static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
>  #endif
>=20
> -extern bool hv_isolation_type_snp(void);
> +extern bool hv_isol_type_snp_paravisor(void);

This declaration of hv_isolation_type_snp() also occurs twice
in include/asm-generic/mshyperv.h.  I think this one can be
dropped entirely rather than renamed since
include/asm-generic/mshyperv.h is #include'd at the bottom of
this file, and there is no user in between.

hv_isolation_type_snp() is used in several architecture
independent source code files, so having it declared in
include/asm-generic/mshyperv.h makes sense rather than
being in an architecture-specific version of mshyperv.h.

>=20
>  static inline bool hv_is_synic_reg(unsigned int reg)
>  {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 6ff0b60d30f9..3c61b4b6a5e3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -66,7 +66,7 @@ u64 hv_get_non_nested_register(unsigned int reg)
>  {
>  	u64 value;
>=20
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> +	if (hv_is_synic_reg(reg) && hv_isol_type_snp_paravisor())
>  		hv_ghcb_msr_read(reg, &value);
>  	else
>  		rdmsrl(reg, value);
> @@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
>=20
>  void hv_set_non_nested_register(unsigned int reg, u64 value)
>  {
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> +	if (hv_is_synic_reg(reg) && hv_isol_type_snp_paravisor()) {
>  		hv_ghcb_msr_write(reg, value);
>=20
>  		/* Write proxy bit via wrmsl instruction */
> @@ -300,7 +300,7 @@ static void __init hv_smp_prepare_cpus(unsigned int
> max_cpus)
>  	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
>  	 *  enlightened guest.
>  	 */
> -	if (hv_isolation_type_en_snp())
> +	if (hv_isol_type_snp_enlightened())
>  		apic->wakeup_secondary_cpu_64 =3D hv_snp_boot_ap;
>=20
>  	if (!hv_root_partition)
> @@ -421,9 +421,9 @@ static void __init ms_hyperv_init_platform(void)
>=20
>=20
>  		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> -			static_branch_enable(&isolation_type_en_snp);
> +			static_branch_enable(&isol_type_snp_enlightened);
>  		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
> -			static_branch_enable(&isolation_type_snp);
> +			static_branch_enable(&isol_type_snp_paravisor);
>  		}
>  	}
>=20
> @@ -545,7 +545,7 @@ static void __init ms_hyperv_init_platform(void)
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>=20
> -	if (hv_isolation_type_en_snp())
> +	if (hv_isol_type_snp_enlightened())
>  		hv_sev_init_mem_and_cpu();
>=20
>  	hardlockup_detector_disable();
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 02b54f85dc60..f86570f3bc1e 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -484,7 +484,7 @@ void vmbus_set_event(struct vmbus_channel *channel)
>=20
>  	++channel->sig_events;
>=20
> -	if (hv_isolation_type_snp())
> +	if (hv_isol_type_snp_paravisor())
>  		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
>  				NULL, sizeof(channel->sig_event));
>  	else
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index ec6e35a0d9bf..3a6e5ecd03d8 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -64,7 +64,7 @@ int hv_post_message(union hv_connection_id connection_i=
d,
>  	aligned_msg->payload_size =3D payload_size;
>  	memcpy((void *)aligned_msg->payload, payload, payload_size);
>=20
> -	if (hv_isolation_type_snp())
> +	if (hv_isol_type_snp_paravisor())
>  		status =3D hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
>  				(void *)aligned_msg, NULL,
>  				sizeof(*aligned_msg));
> @@ -109,7 +109,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!hv_isolation_type_snp() && !hv_root_partition) {
> +		if (!hv_isol_type_snp_paravisor() && !hv_root_partition) {
>  			hv_cpu->synic_message_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (hv_cpu->synic_message_page =3D=3D NULL) {
> @@ -125,7 +125,7 @@ int hv_synic_alloc(void)
>  			}
>  		}
>=20
> -		if (hv_isolation_type_en_snp()) {
> +		if (hv_isol_type_snp_enlightened()) {
>  			ret =3D set_memory_decrypted((unsigned long)
>  				hv_cpu->synic_message_page, 1);
>  			if (ret) {
> @@ -174,7 +174,7 @@ void hv_synic_free(void)
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
>  		/* It's better to leak the page if the encryption fails. */
> -		if (hv_isolation_type_en_snp()) {
> +		if (hv_isol_type_snp_enlightened()) {
>  			if (hv_cpu->synic_message_page) {
>  				ret =3D set_memory_encrypted((unsigned long)
>  					hv_cpu->synic_message_page, 1);
> @@ -221,7 +221,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (hv_isol_type_snp_paravisor() || hv_root_partition) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -240,7 +240,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (hv_isol_type_snp_paravisor() || hv_root_partition) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -323,7 +323,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 * addresses.
>  	 */
>  	simp.simp_enabled =3D 0;
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (hv_isol_type_snp_paravisor() || hv_root_partition) {
>  		iounmap(hv_cpu->synic_message_page);
>  		hv_cpu->synic_message_page =3D NULL;
>  	} else {
> @@ -335,7 +335,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 0;
>=20
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (hv_isol_type_snp_paravisor() || hv_root_partition) {
>  		iounmap(hv_cpu->synic_event_page);
>  		hv_cpu->synic_event_page =3D NULL;
>  	} else {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 2d43ba2bc925..e205f85709ad 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -381,7 +381,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  			*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
>  		}
>=20
> -		if (hv_isolation_type_en_snp()) {
> +		if (hv_isol_type_snp_enlightened()) {
>  			ret =3D set_memory_decrypted((unsigned long)*inputarg, pgcount);
>  			if (ret) {
>  				kfree(*inputarg);
> @@ -509,17 +509,17 @@ bool __weak hv_is_isolation_supported(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
>=20
> -bool __weak hv_isolation_type_snp(void)
> +bool __weak hv_isol_type_snp_paravisor(void)
>  {
>  	return false;
>  }
> -EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
> +EXPORT_SYMBOL_GPL(hv_isol_type_snp_paravisor);
>=20
> -bool __weak hv_isolation_type_en_snp(void)
> +bool __weak hv_isol_type_snp_enlightened(void)
>  {
>  	return false;
>  }
> -EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
> +EXPORT_SYMBOL_GPL(hv_isol_type_snp_enlightened);
>=20
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index f73a044ecaa7..b8f2b48b640f 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -64,7 +64,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>=20
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputadd=
r);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> -extern bool hv_isolation_type_snp(void);
> +extern bool hv_isol_type_snp_paravisor(void);

This declaration duplicates the same declaration below in this
same file.  One of the two can be deleted entirely instead of
being renamed.

>=20
>  /* Helper functions that provide a consistent pattern for checking Hyper=
-V hypercall
> status. */
>  static inline int hv_result(u64 status)
> @@ -279,7 +279,7 @@ bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
>  enum hv_isolation_type hv_get_isolation_type(void);
>  bool hv_is_isolation_supported(void);
> -bool hv_isolation_type_snp(void);
> +bool hv_isol_type_snp_paravisor(void);

Duplicate of above.

>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);
> --
> 2.25.1

