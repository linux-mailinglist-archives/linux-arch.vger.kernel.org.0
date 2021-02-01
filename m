Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F6730AE52
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 18:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBARq6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 12:46:58 -0500
Received: from mail-bn8nam08on2091.outbound.protection.outlook.com ([40.107.100.91]:14075
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231186AbhBARqy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 12:46:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQumF9DQ1SmMopS/flade9yM27Lg4bnqM1CNraq5V3FN42Mb70eHFKF+wz9rrJeUzu47zmvT54Qjm6zljwVs9OV469ma2fy6wfzwUYKzNrpCjSMu36pEds3B70DWsQY/OBsvv9DzqSTIfd+Y7yZi2VNg4RDa2wt66wrYZbuVlqyddey26zegvh4gIiVl0k/wgQHuryESCFNYDIYyo3kIZNw7KR4EF2kVYCMFTPLbyl8uS3ZDOAyU0k6iCLtVpxIUux4bbOhdSwyNe8w7Rd/d7Bq6au5ZaV0MXAyeOjBDwy9CqUGINSDy1Vpc7PQiJOT1frV4w3h/kpRSN5BF2TM15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfNcOq8CTaOFnbTTxZEB3D8Ty0YIg4ahyt6y1wDz9+g=;
 b=LwavaH10/717bg314myuwg7+al82EpxXS4z/heN70t2FOC7FMLqYni13AImuTcF1LpQxmNfBFlc0GBYzGNKiNqlNAxKkBGiOIW6U/RtKEvMR8uLf7LEyThfobXN7Ik/GPcVVpKoZi/q+TWitODgCYJt6N/ObqkqEpRLBVMfuGry3QHvUL5Bpvw8XFpF7+jb+SOQIzIVhGwMarZqCnDLM0sz9DmMlrdt1w6wwIMXDoR3TDk1ockHFIg9CWhGB9Aj6itOa1BUjUfQjMu97RY7k+mYl14lyloRrS2vsvUnFRTlTGYi+RSiUFUajPQsEDyjy8FNiQgY7EJpWyBJ5Q2pD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfNcOq8CTaOFnbTTxZEB3D8Ty0YIg4ahyt6y1wDz9+g=;
 b=jHYWFIJx2dfMn6BrpfO8f0VsVpGW+pqFVx0E+o9WzMJTi7FBy/Ok5mbGLM29O6wVrr4lgBbOdI73vCDcciEXQ0IasaR6DuWQWaC4X5XsQXy5t4UJhEGnpIv1VOs1neYupKJqzczc/00gEtzS63lA3bV+mYEfAAlUix/iWMhXkvM=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.4; Mon, 1 Feb 2021 17:46:04 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Mon, 1 Feb 2021
 17:46:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 hyperv-next 1/4] x86/hyperv: Load/save the Isolation
 Configuration leaf
Thread-Topic: [PATCH v3 hyperv-next 1/4] x86/hyperv: Load/save the Isolation
 Configuration leaf
Thread-Index: AQHW+KlUHxUzBt4Wd0ewFhfFCLbUmqpDkp0Q
Date:   Mon, 1 Feb 2021 17:46:04 +0000
Message-ID: <MWHPR21MB15935C50996A097C6BCD194CD7B69@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210201144814.2701-1-parri.andrea@gmail.com>
 <20210201144814.2701-2-parri.andrea@gmail.com>
In-Reply-To: <20210201144814.2701-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-01T17:46:02Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab11f1f3-f35c-48e8-be90-0bd8176d5d7a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea5a2bcb-bf45-4b40-30e1-08d8c6d93f41
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18755C546E48FB5DD38CF730D7B69@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MFbwSxnD1s/SPO5hqre24d+H/p1fP4n3T7cbs2yaPx0on2Bya/Blmd6DOPPP1ZCt+7ZkAwoAMPUE323j89LE4+OBre/Ojfohscm9ZpEmUkJGmZsG2rYvpKRiwga3WtNCVCB6Sr3d56lZrQaCRkclTj5A+O9PiBxExzFXQxfrZNMCM+B8azr7sOtCOWB6RJVXjULMLiPKtEQHvUgfVlK21uGcPSHnCKHADzqb1LHbSB6bDWIMnvK49sySY6ZUsZZA0DJSu2vqqp+MdyRvct8T8JRoiGcCUMWatxpKwDKqFC7AfaHz6GFArlgEjalgJpqQCr8Vzt1ShIKEcvzKfh4eJigestYq8mT6LCpAh1Ad+K0aZkclBWEwsdyGqOwL80fCMmoDD1k2LLuOAEfmSeq5rqpHXB+sEZFJ52HBjm/ybMdCT+JPWhW55ib+RAW3yc2D44WolabHrD8slzHal5KJnzLLS1108yfzFh7+VSig8agzquMkGx0IV4iN9xID2uQBFPryZlNbLF+Byuj+7d1Eag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66476007)(66446008)(66556008)(110136005)(64756008)(54906003)(66946007)(8936002)(316002)(8676002)(8990500004)(52536014)(2906002)(83380400001)(9686003)(55016002)(86362001)(76116006)(82950400001)(82960400001)(33656002)(26005)(186003)(10290500003)(5660300002)(4326008)(71200400001)(478600001)(7416002)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vA5iVFKA9f3SCDunFi1QQbDEfFEcdyELxO74/wQj/g9oFxQcvNlNXSDah+6O?=
 =?us-ascii?Q?e6naD38bJc0GnJdCqBtm4OU9/MZWi5pxBqydIeIm9oprcLIqLirgEH8tKCBa?=
 =?us-ascii?Q?/blCaqeNTFUvP136a1q3Hr1Ou6P55iSZEPgejExcWMGE2BeXfaWy7XNF+Umg?=
 =?us-ascii?Q?A1/tNBs1zbTHSCnY6H4M7TSEr23/p0dlHhDo8TZDxeoAmA8clh6u3oPy/g/1?=
 =?us-ascii?Q?Pk66kvl+rT6+zghjbLf5tHK2BGkijqZKvXMEfmp1wJXW1x8XM9/qy8E7lfzo?=
 =?us-ascii?Q?I8YnkLEMOdCCdzCiJGKq3BbcleDwQJPwNytArst22QutNHC8Xjj6ud2+7AVD?=
 =?us-ascii?Q?+YRpVeZZRPuRkbIoQVw1wU3rSSnwuQ6v7EbDhq8kmXexhi1BRhMxFEh/cwjF?=
 =?us-ascii?Q?X5h7NCEJAf1l/CUxI9N7UHfmsgRMN6bdg74//DtxRqu0D5VUd/Lc1HuEHz2Y?=
 =?us-ascii?Q?SrFT/o/6pFjhtj0FiMZ1Yg3vObdvx7sBr6j887bPBaHa0BSybwJUfAUzuT9M?=
 =?us-ascii?Q?EnsjiAQ1w8uASBEnlDgMTjPJ6FXsgbzVbY2LSB0tWvFyOS9rDVrBcUIX3uoY?=
 =?us-ascii?Q?HVpSB1sybn67XUw/zvr2S4dnBtVuTwLlzTs0Kz+hoyiotbY25qKRzyJw7xFo?=
 =?us-ascii?Q?jJcdGRDF4K4Rcth9X4aV2rHsYsK0MQKVNMqI1yeo0bP3e3HaQKn8uWtlg/89?=
 =?us-ascii?Q?xhFuojoLoSNi9VDEA1Tyz4YYi7KdoxrQHrcPdzbRLjqI/4ijZszofbO0zTFd?=
 =?us-ascii?Q?ezKw8p89SiSiIwUzk+LzK+pwxBIXZxAFIZWiEiRuH5Qp9Vlb1sujLaYZUdZu?=
 =?us-ascii?Q?Ua+Qmb04ZuSx8Ena3TRZKufJytxok4HH06xxq6kRCejCSW0igITwpAx11Rz8?=
 =?us-ascii?Q?ngN7blYGPWgBY1Fu7RMFbDT4w4N3zBylsYkS9Y4BUVCKm66DmDpQHwdcgzxc?=
 =?us-ascii?Q?NuwAGnzQiHTbNhLztiywZ8qALX6Ehyd7Xc7XlhLI/TqEdZG9jeq5y56ar9fX?=
 =?us-ascii?Q?GCvYbfqYQd0tKUYWVQCcBrtNJfKfsoJS2r7T7wnXmEu0YqGjfib9mJiKVKL7?=
 =?us-ascii?Q?bvTvo2URWoLXKQ0dbEXBeLlmu4eXH/uFSt9tPyIHnmUqMMGEsm/Cd4XUGWCi?=
 =?us-ascii?Q?6P76GFS43zxOlkbaz9fKU+HU2yHW1vlLmaB/uevA9m3Cp6FokuyJrN4g4pS6?=
 =?us-ascii?Q?3mTwv7saWiDNCg2y2aHPCebY8T91VQwCj6tblW0YMyqd2CpIWqsoFLmWupP8?=
 =?us-ascii?Q?Wy40sa/gO4yDEldK88UQzcrlpem1jWpwUyT/8EAr6p+1pPEPFe3cR0944V1C?=
 =?us-ascii?Q?ypwCVjCbPmfoZoLrghcA4tHd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5a2bcb-bf45-4b40-30e1-08d8c6d93f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 17:46:04.2266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbrRpCGBoIdm8DXtsU3JbfgNDJfVYgzz0UBN50NHUO7K/1OuEe9v/HCsnGTIReBmxyW8SfmN91ua8UTD/e9flPVgbMXnue7CAr+jXEkJDnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, Febru=
ary 1, 2021 6:48 AM
>=20
> If bit 22 of Group B Features is set, the guest has access to the
> Isolation Configuration CPUID leaf.  On x86, the first four bits
> of EAX in this leaf provide the isolation type of the partition;
> we entail three isolation types: 'SNP' (hardware-based isolation),
> 'VBS' (software-based isolation), and 'NONE' (no isolation).
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: x86@kernel.org
> Cc: linux-arch@vger.kernel.org
> ---
>  arch/x86/hyperv/hv_init.c          | 15 +++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h | 15 +++++++++++++++
>  arch/x86/kernel/cpu/mshyperv.c     |  9 +++++++++
>  include/asm-generic/hyperv-tlfs.h  |  1 +
>  include/asm-generic/mshyperv.h     |  5 +++++
>  5 files changed, 45 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27c..ccdfc6868cfc8 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <linux/efi.h>
>  #include <linux/types.h>
> +#include <linux/bitfield.h>
>  #include <asm/apic.h>
>  #include <asm/desc.h>
>  #include <asm/hypervisor.h>
> @@ -528,3 +529,17 @@ bool hv_is_hibernation_supported(void)
>  	return acpi_sleep_state_supported(ACPI_STATE_S4);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> +
> +enum hv_isolation_type hv_get_isolation_type(void)
> +{
> +	if (!(ms_hyperv.features_b & HV_ISOLATION))
> +		return HV_ISOLATION_TYPE_NONE;
> +	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
> +}
> +EXPORT_SYMBOL_GPL(hv_get_isolation_type);
> +
> +bool hv_is_isolation_supported(void)
> +{
> +	return hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE;
> +}
> +EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 6bf42aed387e3..6aed936e5e962 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -22,6 +22,7 @@
>  #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
>  #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
>  #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
> +#define HYPERV_CPUID_ISOLATION_CONFIG		0x4000000C
>=20
>  #define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
>  #define HYPERV_VS_INTERFACE_EAX_SIGNATURE	0x31235356  /* "VS#1" */
> @@ -122,6 +123,20 @@
>  #define HV_X64_NESTED_GUEST_MAPPING_FLUSH		BIT(18)
>  #define HV_X64_NESTED_MSR_BITMAP			BIT(19)
>=20
> +/* HYPERV_CPUID_ISOLATION_CONFIG.EAX bits. */
> +#define HV_PARAVISOR_PRESENT				BIT(0)
> +
> +/* HYPERV_CPUID_ISOLATION_CONFIG.EBX bits. */
> +#define HV_ISOLATION_TYPE				GENMASK(3, 0)
> +#define HV_SHARED_GPA_BOUNDARY_ACTIVE			BIT(5)
> +#define HV_SHARED_GPA_BOUNDARY_BITS			GENMASK(11, 6)
> +
> +enum hv_isolation_type {
> +	HV_ISOLATION_TYPE_NONE	=3D 0,
> +	HV_ISOLATION_TYPE_VBS	=3D 1,
> +	HV_ISOLATION_TYPE_SNP	=3D 2
> +};
> +
>  /* Hyper-V specific model specific registers (MSRs) */
>=20
>  /* MSR used to identify the guest OS. */
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f628e3dc150f3..ea7bd8dff171c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -225,6 +225,7 @@ static void __init ms_hyperv_init_platform(void)
>  	 * Extract the features and hints
>  	 */
>  	ms_hyperv.features =3D cpuid_eax(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.features_b =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>=20
> @@ -259,6 +260,14 @@ static void __init ms_hyperv_init_platform(void)
>  		x86_platform.calibrate_cpu =3D hv_get_tsc_khz;
>  	}
>=20
> +	if (ms_hyperv.features_b & HV_ISOLATION) {
> +		ms_hyperv.isolation_config_a =3D cpuid_eax(HYPERV_CPUID_ISOLATION_CONF=
IG);
> +		ms_hyperv.isolation_config_b =3D cpuid_ebx(HYPERV_CPUID_ISOLATION_CONF=
IG);
> +
> +		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
> +			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
> +	}
> +
>  	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
>  		ms_hyperv.nested_features =3D
>  			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index e73a11850055c..20d3cd9502043 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -89,6 +89,7 @@
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
>  #define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_ISOLATION				BIT(22)
>=20
>=20
>  /*
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index c57799684170c..dff58a3db5d5c 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -27,11 +27,14 @@
>=20
>  struct ms_hyperv_info {
>  	u32 features;
> +	u32 features_b;
>  	u32 misc_features;
>  	u32 hints;
>  	u32 nested_features;
>  	u32 max_vp_index;
>  	u32 max_lp_index;
> +	u32 isolation_config_a;
> +	u32 isolation_config_b;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>=20
> @@ -169,6 +172,8 @@ void hyperv_report_panic(struct pt_regs *regs, long e=
rr, bool
> in_die);
>  void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
> +enum hv_isolation_type hv_get_isolation_type(void);
> +bool hv_is_isolation_supported(void);
>  void hyperv_cleanup(void);
>  #else /* CONFIG_HYPERV */
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

