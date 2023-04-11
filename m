Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8196DE220
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDKRNz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDKRNy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 13:13:54 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C45449C;
        Tue, 11 Apr 2023 10:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCMFZy2D4fvtRyhI4AvZjiC//8oV3Lnw7FadLmrtMhgRUjVUpn1ITk4c/ArmwS1ciVNp5mNqEUWUNOm5cewe37k6h/hRoWTUZ1z/RB/TkRM58KuBxEiv7GtbXDSFQHwLsyKVYv6rDxwQV0NUfEV78TGV/BoxLap4bj1Ejy9SD+6upUW+0ZpZDDBskXTDR4MAloPLg/h/2qiVnDohJS//w63KTva1Zhk0v62k3Gv4+dKOp+N+i7AZgBoNGKwEIitGMq2gbvHpnW5JqWEPJVHJIBgu7T1fY2g/huiPZ2bKNYDL8aqcxhvn7p74rAmMKLUk0pNhf1jpV0d92bNLZUs/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPb+0Twv+5/5yMnWK6I3KrMIr43y1RzGHdx0aNGSNZA=;
 b=oSrhu4TvX1NUXB/8LXm0bK1VBiODeanEhDYTAxGi+M/t6kzxaCImlLYorT8lJiCUJEPY9FM+C6YOf5N9OjTE7OLLXfqqNL6+DvZUo2LvNOidEH1zTop2X5KK6XGLYxhwEXNGMvohfbYVr/mEiuUPKsDB3sZAZGhJ7Wxr8FmC/TN3jZ4A4v2/RP7RTXcxgea0fuMPazBU5ypB0ojlUN5r89fZtTFP7y2185szO5wHYMOzCnco4JBNsnGc9IQ+J4jC7UU/lkOtm9kU9CnAReYia4glcAgej3zhvdahwU8bbK8px895+HjFHSdo+Rb2MqRC0fdHIrRPECJ85pCEHgbBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPb+0Twv+5/5yMnWK6I3KrMIr43y1RzGHdx0aNGSNZA=;
 b=AkNS0A+opyIU/4qEm4d9sbr/hfpqEeIVRjaL/Ry05IqfF7LzCxEfJltCwe7I62eaosAs0mHvTSx8dDglIO1gL80Hl2qpW2SGiVQq7oz1F7agMhAQP7VW5Y4zw6irJY4sHDnQRlOVEuYq5L8tQ/lsMUheq+JR7FStV/NctBskerE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3585.namprd21.prod.outlook.com (2603:10b6:8:a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 17:13:50 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 17:13:50 +0000
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
Subject: RE: [PATCH v4 6/6] x86/hyperv: Fix serial console interrupts for TDX
 guests
Thread-Topic: [PATCH v4 6/6] x86/hyperv: Fix serial console interrupts for TDX
 guests
Thread-Index: AQHZalujP8O9vIzAEkmR/lI5q4nag68mWtKA
Date:   Tue, 11 Apr 2023 17:13:49 +0000
Message-ID: <BYAPR21MB1688798EA7DD5ED309BAE0F6D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-7-decui@microsoft.com>
In-Reply-To: <20230408204759.14902-7-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=213958c4-6372-417c-8b38-15aee46f618c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T17:05:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3585:EE_
x-ms-office365-filtering-correlation-id: 70b8810f-8fa7-4572-6803-08db3ab01e36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZLeD3bISF9IzxU2a1BIDFX6ELQhSAy0PXSGSg/HY8L/UXjSt4qgIZF34ROoxxP9hvy4Mw2o+1XHupXnbixNwF67N/+makIUUf8mxXRNJ9MQGUkS5hmzDFRgsqJncODDW5PFv9YMW64NFJ3vGVtKRjtgc+l1LbYNTfEqnhSzvdGIrJOmeXD2iiDc76b2JmrwSKZuklfS1re/vnTMS7r0/54enElXoYuOxUBqXUC1a66qvxZ58pFHCjXYIMlDAEYlfZSTMLshJBw9S+vbHZlm0epEO1MqShuZtPPBy1ClokpmSw5ZX7JktHjejhKMEti6hyPFkvGrvVPBql2NCacuSFwRH/V7GSU1cJJ3NfIfONFxCj8cN+/E8Yise7VbrShGilbFz/1j6129iyEIpI6JhZXwtbo0D+vRW9JyvLR71DdYq/cCBEONb9UpYyVZEyHu2sNJAQIl+MBPCKfutYTo7UXjhY7DcYzwtsDGQt1gQK7DjTHHH6pWncxRSTTtrHjY5xlL1lS2pg8tPCaLkiaOlpwiHPcgbJcTv6ZkpoCkUHxTCf+17mxeykq6EbgTDaw/aOW+fhXfkmWcUs9YobTGyaQbpaEnlpSS3lCqBEbm1Yw1kMbUw0KXr2kCNsS/uyRIOGcuya5ETT9XE5ZDpDO+dVuXPKQltiGeeoukJGV4CPlHalZ9j+m+IyOuSQIDOLA7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(10290500003)(54906003)(786003)(316002)(110136005)(478600001)(83380400001)(186003)(33656002)(55016003)(26005)(6506007)(107886003)(9686003)(122000001)(38100700002)(921005)(86362001)(38070700005)(82950400001)(82960400001)(71200400001)(7696005)(8990500004)(41300700001)(64756008)(66476007)(76116006)(66446008)(66556008)(4326008)(8676002)(66946007)(5660300002)(2906002)(7416002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FNbQ9jzsY0NZX0U4AFWAXgPUr0kJy4bfbWCNi593zGh6+3vBNvMXAx6ujzhH?=
 =?us-ascii?Q?V4ia8dVPl6WFvXSto/ryStleqstMVWk/krSn/yuasT2I7Jyo5bfAP42COPKY?=
 =?us-ascii?Q?nWWdnL34905yCVqpTq/IkkHIWyT5PeGkDuzvkxqp8q5AmaI+MOAOaV02kudG?=
 =?us-ascii?Q?3If948i244dN5ojW6szxumDwqcxteTE37BXhQgqbBuJLEz4D5qQEMBsfmnvL?=
 =?us-ascii?Q?i3wHkVJJb9ZHCrac3UoVWRg00Hu3gH9lo8u7eRw5BDl6/r/PRBu7FE/a3DeN?=
 =?us-ascii?Q?J+c4r5Dx8GrfoKYPrUA8XYfe75azxM1I5TPH50/bPrkyjBVGlNbluydQUawG?=
 =?us-ascii?Q?SrZI+OFyTPdsNZbVnrhc4bxdB8aAApvTj4ubAqhCnyMegVY0aOV4sUQlRT33?=
 =?us-ascii?Q?Wwa1XlNp7HTyVlG+e4mOcTMqygnCNnMkrmQJ/X3r1eDXiGrCj2MKQiRw++Dl?=
 =?us-ascii?Q?Txkd4unuaru6HaOI8cPDEWdluyUSkcR4Igx5p2Gi9GPGmAdnV7fvHfoGf46A?=
 =?us-ascii?Q?Une7PprR24HgQPHLVNHAZ0uMfuupyf9ixQJpBGuWYhGA4E6sgx7LT0xR3wo2?=
 =?us-ascii?Q?12u/V//14p+tfQHgjqXJNuf8mbAUGn+KL9QeA90wJrFNkEVk3mzQPP+jr7nY?=
 =?us-ascii?Q?DzR8YvHONRcOA4JvoU3CYfC01y5zROmBqSb9DIhr+HvOEbByaKv3lemtvxk5?=
 =?us-ascii?Q?IeKKVTRFr8eel/oT/fMbxivPwWVDx3osqOS07f9v5n0yTc1roXuR7d/YGkDA?=
 =?us-ascii?Q?28ob2WHf6PQKPGGyk/MCCv8DvPyEO0IpR50UqYNWnfUdLmGu4CgHUzA4aoOE?=
 =?us-ascii?Q?h8nh6Nvwm688YLZtKsOZn7jHU6cQ1G+ZEEdzIbaFFZNrOwJIqYwHg8M8yZ5+?=
 =?us-ascii?Q?QcTJbZxJaDSUjHqe+VrrpwT0WWY2sDMn9+Cy7Wb3BKxUHooB4vIGi0wIA5oR?=
 =?us-ascii?Q?xjbd3B0XuQfKSV++vZ/qaqTIxVP/FRCh85XGxLZlwh9ZJP4BNDIXTl+MSVFG?=
 =?us-ascii?Q?0HM9wlojbYORtV4BZwlxRXufk+dGQlLtHNNOciD36VAGAHL7NV09HWNmowmK?=
 =?us-ascii?Q?k5+rL5xIxF0o6BkA51Aj1aVc2JnUwscRUGvySXAcP8nBKNHEF/ttzrc/CFLX?=
 =?us-ascii?Q?y0X6uwV4UMAe+j/Ncte96xDYaeJEqQeyIAjqrbQMnbtSiguxinyXN5wE9X+t?=
 =?us-ascii?Q?FO8R2y4IxUWLth/Rnob2tzre+3DHO+HoMVY77tWmd6SBP2G9NRYBQcEuoxod?=
 =?us-ascii?Q?MWzm3nW4wk0PoTZYd1BA5/X5ffS2zY3WjpD/IwuVwOHE+4wTu7WbIUTtNt+S?=
 =?us-ascii?Q?k/fsmex3wTxNQluWLpLXSq0HKcg9aFcVl52P8B3Y4GGPWhi23brEbiiJcka2?=
 =?us-ascii?Q?KFcWYYfnbbKiV12gL41+zr5nsYEKXWfabizU5W/3E5UIp3tzLKJr1NRsEp6L?=
 =?us-ascii?Q?Htc1Q2wOOS9ji/s54BdnKUz0eWmF0HnFKQSQSoeP9nbEekptbEuBIkurfumo?=
 =?us-ascii?Q?t50PGkbrNnKWGbPRRkXYwCejBWJ9a44J3DUzJHuwZOzykm3cBKvTyvYyw87A?=
 =?us-ascii?Q?HhbA4goHAmKh5y+kdxxhFQMqdxDpjUx7jtwU0bEFOe5LyQOcGxNVGdaGCwTB?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b8810f-8fa7-4572-6803-08db3ab01e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 17:13:49.8233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9QprZSqoUgOU2Hk2RBFq2dZnM8LAbHksYwvmTP1q8sAOras4O4cuM5o0xsdqCEzkxVBQ4ZivxTZwlE02i5PKXItcTopnAULnkUAqJ0uS4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3585
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
> When a TDX guest runs on Hyper-V, the UEFI firmware sets the HW_REDUCED
> flag, and consequently ttyS0 interrupts can't work. Fix the issue by
> overriding x86_init.acpi.reduced_hw_early_init().
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes since v1:
>     None.
>=20
>  arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index e9106c9d92f81..deedced0f2bb0 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -318,6 +318,26 @@ static void __init hv_smp_prepare_cpus(unsigned int =
max_cpus)
>  }
>  #endif
>=20
> +/*
> + * When a TDX guest runs on Hyper-V, the firmware sets the HW_REDUCED fl=
ag: see
> + * acpi_tb_create_local_fadt(). Consequently ttyS0 interrupts can't work=
 because
> + * request_irq() -> ... -> irq_to_desc() returns NULL for ttyS0. This ha=
ppens
> + * because mp_config_acpi_legacy_irqs() sees a nr_legacy_irqs() of 0, so=
 it
> + * doesn't initialize the array 'mp_irqs[]', and later setup_IO_APIC_irq=
s() ->
> + * find_irq_entry() fails to find the legacy irqs from the array, and he=
nce
> + * doesn't create the necessary irq description info.
> + *
> + * Copy arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init() but =
doesn't
> + * change 'legacy_pic', so it keeps its default value 'default_legacy_pi=
c' in
> + * mp_config_acpi_legacy_irqs(), which sees a non-zero nr_legacy_irqs(),=
 and
> + * eventually serial console interrupts can work properly.

I had a little trouble parsing this comment.  Slightly better wording is:

    * Clone arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init() her=
e,
    * except don't change 'legacy_pic'.  It keeps its default value 'defaul=
t_legacy_pic'.
    * mp_config_acpi_legacy_irqs() sees a non-zero nr_legacy_irqs(), and
    * eventually serial console interrupts can work properly.

Otherwise,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> + */
> +static void __init reduced_hw_init(void)
> +{
> +	x86_init.timers.timer_init	=3D x86_init_noop;
> +	x86_init.irqs.pre_vector_init	=3D x86_init_noop;
> +}
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax;
> @@ -425,6 +445,8 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
>  			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
> +
> +			x86_init.acpi.reduced_hw_early_init =3D reduced_hw_init;
>  		}
>  	}
>=20
> --
> 2.25.1

