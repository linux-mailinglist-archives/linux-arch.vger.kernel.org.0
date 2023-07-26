Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD076293D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGZD0k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 23:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZD0i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 23:26:38 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5625121;
        Tue, 25 Jul 2023 20:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSPCq6JsNFJRAHOjJm2QC54eji7ZihhlRNzU4mI95p/RFwQC8OshtK4X+fG/HkzFvVfuzAPBcG9EoZCLJjpwgAKRGTAWaQP8s8UlNN/CmF9rsGs2q9/SPW0JlJ8FQdAVgz26WKhTSFPL85ei1CUz+QdUwGAmyWj3nsQAX/1CRpy6LjgE8FzsBRqwl4a0ZRejVZ7XSSBdO9CXdX1CcbUTv8JGzf6bJIO3cRRxi/ouYSGqcpXoCIupocVFrLYIumaVBxASFKDFV1t6Y8C/lycDDzbfA4c3wZ5h+MdXngJWNpU5+l2DX0NnJuzRrt0T3cQgMl9XgdITaSt/iq5+H0JhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4pnODuBuCmOzHQxwKOD/vFe0jpdngPdakDgq/LAJqs=;
 b=OCcnW+fadoYRldUEw0gyxqSMPPWjneV3CJHz2IKCh9E/4ueqMKWlIScOG1Lqa1L6rIjviuilKQBrjiPYduy/rnC8uOOBpKGEK1aJJarg3hJieVnZfj2te2uxNN3IGdWPPIlzh2lwgHR7wyzdDq7065QA9urukYSFTzR9+JXwh5QCeUmZBywFd0sHwXzsh3+oBCR+VV/jHXAj26NGpFqEpt0UOzJqceYxbUK/PqGIXfV+Grph9ZBRN6SYO0p5Np56nCOmAQVfV/F37s82HL7AJj7k1RKasV+Bo/dack3cQX4EMeMdJu3EStlO4sfO5nFZlE/WCchV9v8nSh9OpNgAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4pnODuBuCmOzHQxwKOD/vFe0jpdngPdakDgq/LAJqs=;
 b=IgK6vAfA9B0ahRK8BD5vGZ/vL+Y4f5xBwwRZ/4WAO5ZAxO0NUvERTSNhyYJ4FP9eU+GqQlS4BH88fsKBVtHD/HP5oB7grQD+15N/fUU+8hthzHAOOUJRcapAqk/wV64F4HFca9/r38OqQZGMx9V9COKQzDmsfm81/vYLgHzVdsI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH8PR21MB3873.namprd21.prod.outlook.com (2603:10b6:510:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.0; Wed, 26 Jul
 2023 03:26:33 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 26 Jul 2023
 03:26:32 +0000
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
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V3 1/9] x86/hyperv: Add sev-snp enlightened guest static
 key
Thread-Topic: [PATCH V3 1/9] x86/hyperv: Add sev-snp enlightened guest static
 key
Thread-Index: AQHZuScxWQ72bOrJZUy9+XXmSrbjja/Lb3gw
Date:   Wed, 26 Jul 2023 03:26:32 +0000
Message-ID: <BYAPR21MB168882A8175BF52B3BEAED2CD700A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
 <20230718032304.136888-2-ltykernel@gmail.com>
In-Reply-To: <20230718032304.136888-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=35cb1bda-fd77-4d1f-bada-e2de4f19ab37;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T03:25:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH8PR21MB3873:EE_
x-ms-office365-filtering-correlation-id: 2e817d7a-ec28-474d-6b3e-08db8d881bdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BCIdzkN9h+sjolRg2UWgFHYb1sA1k0AFb+vyATGGBVm5/xhXXHp/pjzA94GoLP33UPqJl0qECtcPZTqqHKzNux8h0bLQ4Pp/mKt/fovZZuLRiqxZzNWjssyGdrkCw+bF0ricRgVwhx+Qbgrzt3IyRV20I4MvmrBMJltbqJCB5Y8haZfM/f8v6dzsL6kdLb5dAVXTv0vxyMjcM7fbbab/guXg7zpBxhHmKhC4UFG3sEHu9KWefx8sF3qBvEYu1m2FPRDLPDEbyHnc0C7eueiQGJa8j1sUoGT1Y7TPtTxvZdVXNm4iWdIsS/1CtIgK39pQ+1uPPbiaDidhx0dpXShkZRqZXfVfmRKraTnbtJNR2bedS+QcSclZ3z+Odr4YFEPXJJ3xUfJpbO2H2l9NLmCx0Nu0IXMcYgwDBmhCeqkyhmUEmswXmKkva1BpAqKWqVd4L6+tOV/rjpCxZBhFgXAp3qu+z1vvlxJvzgijnlFUgYRwEYiw1/l+YBzUdpbtF1s9pcz0CQRW4984CFvoyS5FbvdqkuEEeM+O4ofSvitBzonMTDsrOvAojWogNqmu0+sIi3buQND4lQOajGSsGV9MveiK68ichtR7ZTPjUhAlFCLczJt2WkwurjznV4EepHbaM2Eo+5eIG87MMarfnXI+gRAHWQAUMKU06AMH45V7xAbIRnYOl73pdft/imfpups
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(38100700002)(921005)(8936002)(33656002)(82950400001)(82960400001)(122000001)(66476007)(66556008)(64756008)(71200400001)(66446008)(7696005)(54906003)(41300700001)(110136005)(86362001)(8676002)(9686003)(5660300002)(7416002)(52536014)(66946007)(76116006)(316002)(10290500003)(4326008)(478600001)(6506007)(26005)(186003)(38070700005)(83380400001)(8990500004)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?so26qDDuZBlooOGjZxeCQGN2fvdNgtTlu6LnpeVOMAIUm8YA5A21XGWX96Xx?=
 =?us-ascii?Q?ABdfzLHnHTandeOxb8M5t6rpWeHAL1jNnl732+avi2wbuTV2uYrwUuoRJ4bh?=
 =?us-ascii?Q?mvggfOb35pph3ENSxJ9ONM6zdYPr4mjXLyFGTJVqrwvVq9dmsuPyOUAvH8VX?=
 =?us-ascii?Q?UYRsLkGRtyZNv/UExHw+J+hTxOXCGoRocSUOMolN+BqteZW0Cxp27ChMYluT?=
 =?us-ascii?Q?tP4OxCmlRNuFa1QnpDIRbjcyaHsSEN6LY/s0D2ulZkDFQJIgHLkgGrQfTj8A?=
 =?us-ascii?Q?xZqXEfGy5phwL4bQwPRkltqWdCwOiZfOPm/razvXl1fA1UjqiLeraUMQrdYQ?=
 =?us-ascii?Q?hsRcyZOUjAy01ZeessSresxJI3GiVRyUvh7wzzMQ0y65Q6YRrm3KsSkPEkh8?=
 =?us-ascii?Q?oO9/8LY5+D3WNXyOwM+6oh9rmR2scxEhjMZMyyLBWefQu3pFK9Q2gIMpPG2U?=
 =?us-ascii?Q?D6VohrDrXJilta1+TolJuckzgD8BSyqv9Yzylnrfbgy1FD9GJBF3IDJCkqrd?=
 =?us-ascii?Q?VS9G7p1LN11muxc6tyvRhy14rttjnylzddC9fbnabults37RaUT8uE7sK4EH?=
 =?us-ascii?Q?OifcHJOxyRFUS6Ic1ZUI2l/bpqAc6uE5NbNMQG3xpt4m8n18rLnwzHGb9OUC?=
 =?us-ascii?Q?6LwwvWJTbh7SDLK2ldZD5BVQmsyOl+TnQvpDcFsbKqm6eEEEIsMACxFhCoo1?=
 =?us-ascii?Q?yWfgWcfLECCejJs0e1dFcpEXyUc8QqkY5PuZpVVl8SMubyuO209zHwGZFaS/?=
 =?us-ascii?Q?wzusUqNpPkV4uXsbckiB9UUYA/hMY4Z4m/qN6IPKxEl+a592HmTwbGy+TzIV?=
 =?us-ascii?Q?nyF8HclC6H0Ky87lSWyXr4BraQJg5JDGY4Q/ZQY8vIhre4xRVi/aQAJ1w52i?=
 =?us-ascii?Q?4TmQExCwibE+o2B9YEbhV4jiicfDFIq+h6cbjc5YKBF2++1YEdYrkOxXs3q6?=
 =?us-ascii?Q?vy9u8M1/pGaY+UfZHzAn41Agc2tB+Myf+09NkYEnBJTt7/g/w2w5AxMiC060?=
 =?us-ascii?Q?6xpsgc1XHGjMT07olhTHRrWycsIdGc4GaoG1YDFHVYZRy3EWmAKW+qqhJx8M?=
 =?us-ascii?Q?ZAkSIgZwIqonKGguo0iS/YSTn43nlqnf/IysdRByBqeLkEmYMajvYNQnO9/O?=
 =?us-ascii?Q?3OdzMxokGcdAdsUNypk4imwBGPu7F++jOYabb+uJF0R6wnFR9iYiVZCtekMA?=
 =?us-ascii?Q?TCiCy7yhRHnwXuAGFickY9AbR1qNyAPPZFTG6ydVJMFQuxA0wzpbuLylnyzF?=
 =?us-ascii?Q?ZgU4WTyqcifAnPUCkB8xEfWQ17H5HFy63hmoyBW2Xzm6D3t4S6y2YKaRsqpt?=
 =?us-ascii?Q?yqfnZ77TsKLQlG0TjlVTGLhyc4coLd3PEspAgGg7W7i7dN4CvBqeiG329iJh?=
 =?us-ascii?Q?+W7VWH/UmMb/qKtAFxTANBCnvto2/mL5PwmS8rbTtnc8o1kyZLWv96oQWpbG?=
 =?us-ascii?Q?zXJW38DsKZkCbka+hHAHPrFjAPeshojbd2OJL1uh8/V35+5UoPlhFE2rKvU/?=
 =?us-ascii?Q?wYsKsIMz7p3FSq0cJLHnVxmmGL87sfxPeWwYPFHUqcpj50dBh9p5QQbWuITp?=
 =?us-ascii?Q?BmnAJEIsTRxh/HEhL+2MEduTZma1ri4dqweEILOFdT5Jx5Oq8dPJX8pLYBn8?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e817d7a-ec28-474d-6b3e-08db8d881bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:26:32.5462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: il4YL7lKLsnE5wQvbGUjr3waWcPAesnn5eaxcT053CCCDVtu5dibnRCukhNiO2+WQWwK3Ric5BXom2wOV53uq6GUmNO3y0MGbz4kpmmm3zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3873
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, July 17, 2023 8:23 PM
>=20
> Introduce static key isolation_type_en_snp for enlightened
> sev-snp guest check.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 11 +++++++++++
>  arch/x86/include/asm/mshyperv.h |  3 +++
>  arch/x86/kernel/cpu/mshyperv.c  |  9 +++++++--
>  drivers/hv/hv_common.c          |  6 ++++++
>  include/asm-generic/mshyperv.h  | 12 +++++++++---
>  5 files changed, 36 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 14f46ad2ca64..b2b5cb19fac9 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -413,3 +413,14 @@ bool hv_isolation_type_snp(void)
>  {
>  	return static_branch_unlikely(&isolation_type_snp);
>  }
> +
> +DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +/*
> + * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
> + * isolation enlightened VM.
> + */
> +bool hv_isolation_type_en_snp(void)
> +{
> +	return static_branch_unlikely(&isolation_type_en_snp);
> +}
> +
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 88d9ef98e087..2fa38e9f6207 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -26,6 +26,7 @@
>  union hv_ghcb;
>=20
>  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> +DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
>=20
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -45,6 +46,8 @@ extern void *hv_hypercall_pg;
>=20
>  extern u64 hv_current_partition_id;
>=20
> +extern bool hv_isolation_type_en_snp(void);
> +
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index c7969e806c64..5398fb2f4d39 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -402,8 +402,12 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>=20
> -		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP)
> +
> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +			static_branch_enable(&isolation_type_en_snp);
> +		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
>  			static_branch_enable(&isolation_type_snp);
> +		}
>  	}
>=20
>  	if (hv_max_functions_eax >=3D HYPERV_CPUID_NESTED_FEATURES) {
> @@ -473,7 +477,8 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	if ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_VBS) ||
> -	    (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP))
> +	    ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) &&
> +	    ms_hyperv.paravisor_present))
>  		hv_vtom_init();
>  	/*
>  	 * Setup the hook to get control post apic initialization.
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 542a1d53b303..4b4aa53c34c2 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -502,6 +502,12 @@ bool __weak hv_isolation_type_snp(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
>=20
> +bool __weak hv_isolation_type_en_snp(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 402a8c1c202d..6b5c41f90398 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -36,15 +36,21 @@ struct ms_hyperv_info {
>  	u32 nested_features;
>  	u32 max_vp_index;
>  	u32 max_lp_index;
> -	u32 isolation_config_a;
> +	union {
> +		u32 isolation_config_a;
> +		struct {
> +			u32 paravisor_present : 1;
> +			u32 reserved_a1 : 31;
> +		};
> +	};
>  	union {
>  		u32 isolation_config_b;
>  		struct {
>  			u32 cvm_type : 4;
> -			u32 reserved1 : 1;
> +			u32 reserved_b1 : 1;
>  			u32 shared_gpa_boundary_active : 1;
>  			u32 shared_gpa_boundary_bits : 6;
> -			u32 reserved2 : 20;
> +			u32 reserved_b2 : 20;
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

