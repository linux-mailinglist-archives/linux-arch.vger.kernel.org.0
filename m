Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3A30F8B1
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 17:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbhBDQ4B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 11:56:01 -0500
Received: from mail-bn8nam11on2138.outbound.protection.outlook.com ([40.107.236.138]:59936
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238214AbhBDQzs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 11:55:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PByxfpBWME26MQKfI7qAqyT+us0UHoatzS6Hk/Gz0wfFhUqaoQ7T5GLvTTa33tLCUcD/3LnDzakpfVCJee4+Y0Ht2xlCLyIN7RARo6568a37z4lYHaIQSzLMJt1r5PD+YANP6onNPv1/e4QwxsslHFvEmpVovEA7ym/21URI4a2yqqwycF6cHVRE/mesj7KORPnh4GDuEjGv/LUHX8DQe3ONq87NVg0o1neIPXDCBOG2W8uZ8zm4K0Txeuhx5a04RIV6rqsb4UFof+wmXbTu8T6d0fiwC4muzYqM/bbyoNXyheuhacuR22+JajQS/cKrCBz1cgc8cjUEwS4Dk9vuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t6jmafsk6s3SwO3MbPVA0qGk3BgqPgerl5NO0nohjg=;
 b=k+k3JgrqwdmH9PoZJahXiWvuix5yZlfrAzQ+vswihynrs459ZvW0Z/e9XOKFFKlZ7P+bLKLIKMb3MSajenL9vyyiuCTkpNBla7WqpBvOa2i3v59c+Hx6xmvv5GLH8GAOho8meZ5YKEPW20ehcGnzn25Heoyu4bOw7s6COSpV65uWjOYQBYsWg+1ZLtU4suMFAXtbtJOKC3gJaLX8G+ugEC9eA/Wc1nj7EPS/JLflUJMwymiS2qrOGYdKRiHbHVqad7Qcd3m1w4AfmcXAvsWdHMg10i64p8wuimpDxf0WpQ1s7IyClxqsk+wVHI9S9I9FeO8ufzp92SABigN9Qx+Jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t6jmafsk6s3SwO3MbPVA0qGk3BgqPgerl5NO0nohjg=;
 b=AtIc7BKZykkpXfPH72iuruuMn3Ko9psWBU+6U4Hd79Sj0ULY7od1I2Oh4S5fo1Jmc/VISKfyXvHn6mUt1UODrDL+pPyr7pB9opXvPJH5BCnNFFcHSh+sph8EarkbwRGlMc4MQgO72jA3sRMWSljFZr/65x7EqXu279fxTF35MhM=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1971.namprd21.prod.outlook.com (2603:10b6:303:7d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 4 Feb 2021 16:54:56 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 16:54:56 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v6 06/16] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Thread-Topic: [PATCH v6 06/16] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Thread-Index: AQHW+j3rORXmRlz8l0CnO8y8wM/FrqpIOC5g
Date:   Thu, 4 Feb 2021 16:54:56 +0000
Message-ID: <MWHPR21MB1593B4FB343237A75D45E43FD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-7-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-7-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T16:54:54Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1852fe12-d2f1-43e4-ab64-b7566707f9e3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77ad9277-c4af-4261-b09f-08d8c92d9a07
x-ms-traffictypediagnostic: MW4PR21MB1971:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB197150ECD878105E7967C3FFD7B39@MW4PR21MB1971.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DXh7MSPHqtaPiDn78lZQ2Df5c8/HbjsBGX0apDzyEN65SI8AqPB1uEWqT7Dvsgpd0X2NDvb7kYXv0046mR0xi+0jJr80C1GXZDWOxyciZ+BNDxjJmQGgS+D0cnJIrENxytQDiyY+0hJgsYFQgQ+Wv5uqdt/iXZwqzcK4PGyZ4IHVf7cWjXD4F3uharGBINhraqQc+c7Ye0wt8eN9dSCJJlMzHyIvPi4ABKqb7oHsZz0RRtGJmnVpmI4o0Hsh/OO4fbG4qjUc7+XnG8tKouqR891Dmqb1V7wRhNb7D0QFwC42cm9t5uMzfuUXzZxe3jnQdLAe6Oo5Q5J3tNVLsuKGQ0XiGHRfNUaIhfLkcfv1ttr949OB8cilpyjzMjo+H7EXtH+YNc285XyJoBnJlBl1DK9S27nXdyczsZRuix8wqiW1mHWK44fmgeEvy2gifKv4Yhq8MOKKjZxV5uvL4rBbxrepxXAt5cZn1MqtlEzi+BtaxYB0pSuOK2T4uVDtFcndJTVN9eIgdTo0JMo2hvsfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(47530400004)(64756008)(66476007)(52536014)(66556008)(66446008)(478600001)(86362001)(83380400001)(6506007)(7696005)(8676002)(55016002)(33656002)(7416002)(9686003)(66946007)(4326008)(5660300002)(82960400001)(76116006)(54906003)(71200400001)(2906002)(110136005)(82950400001)(186003)(8990500004)(26005)(8936002)(316002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QV8nDWhcFuFO5QPdFCVEywnvYpRphJ4QW+ROXE6BFOpYvsvJ7LL0a4KA/B5V?=
 =?us-ascii?Q?tugdBP/GT1myXibVRrXjLJTNk+Mnt9kAH5Bn5GbFwbTey721xKlrPwjNw/hz?=
 =?us-ascii?Q?Nz7wMK1gQVO6kia+guitZfYoWWbw/L4cNS+BW/Z5HX0TQ9MDRt52cxa17Bjm?=
 =?us-ascii?Q?VPcAAVkaNzqjJs3ZThYLbI9enIigFjUrCzfyuGt6MIE9k8yXBihhgTzp4cL0?=
 =?us-ascii?Q?WjjMPYOtJ6N/C3y6m8EynWxVgFcfO2/NKWi23DILGCaHXavBWhkX5S32e2jR?=
 =?us-ascii?Q?JucIe8QF+JMf/AH8TeOQVGO6cRiTGT1wMQsVmOh3AQ1QShl/R0QUCDNBlkHF?=
 =?us-ascii?Q?z4gx4QczOxjYNOKjcSdtuwkZMGMt53QbCFCCeasBX24T9syz7cpw0h3i8wP9?=
 =?us-ascii?Q?dOvMuJvTJHyOgudswr+PbwH+4V2zxmCRD/WZEbu5OjZ1C4Ubz41NyQ7JZNGz?=
 =?us-ascii?Q?y6V97BsAAjKyVIJlX5GwLT4hkfRZ9rBQ6hojpb+IPqWQTlbCrZKNYSl6OHIq?=
 =?us-ascii?Q?g4t/1q1HzlS+HzW0VatlyDTIXN9AnPFFRT2Nl+kxcT2MKpYMBNNCr81HrgK1?=
 =?us-ascii?Q?8yuRFbGDq4okdjZ+QgzpMEzRq4OdM0wrldyDVfGecDhdIQnLEnawfrQrXUrL?=
 =?us-ascii?Q?2RY5eIK/O/Iw4w18euQWcuw8eG2rYuisDqum+9H8e5rvHIb069/t16//f6dG?=
 =?us-ascii?Q?q37E5rkuToiCawfyYr02VlsKDXFTUY3vlqUim7qwLc/dP1+BNFnr54DxNojU?=
 =?us-ascii?Q?C0icNt0v6bXVLCmaAGY72Dr9zT1oSdxt5Jga2LV6j/mMgyvI+OxF3P+XJ0DD?=
 =?us-ascii?Q?1+3c4n99npOZzENHSOpx4bkqKAr0Sa+As9CVkcBw5Iv/dy+S3d5Acz3aYweQ?=
 =?us-ascii?Q?I9BFfXLMbgZlYv2ws1pk2zXQxPnjLq6b1dTUzdovotNQpi1UPwULMMTsHsFf?=
 =?us-ascii?Q?WJedL+xw1TrTCfY9Zr94Unyige333anCr5tjR0P8vIelyc8PbD68GzXSeBdG?=
 =?us-ascii?Q?OWcZLnCr5+JA/V9pomwqFkkR+rMRar+gcUDxUg3j0UPMMmH8fZzik8gss2KO?=
 =?us-ascii?Q?HIcNAddF38mYEHcz552omZ0TWDb+JoBroU3uJYUO0zHA/THWWF09GprXIlIN?=
 =?us-ascii?Q?h7RdbqNg9+hxSp7KpWdnRJLcJc9IjP09X/nBnXlinGPhXGs9KHqfRUq8E6XQ?=
 =?us-ascii?Q?9TzsvKv/VacLaLZ36ITPQ0OZ4IrVDbYG4bWfvlf+mvzM5+ix/zDntvuTt/oa?=
 =?us-ascii?Q?/FYVqhf/XigmEGA2JNy/hL1gtEaodS5trDEJ6gdf8AksfzpLFGMvheKWRm1W?=
 =?us-ascii?Q?wgEQmNhpNo8AuaWGHlPZZ/Ia?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ad9277-c4af-4261-b09f-08d8c92d9a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:54:56.5373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eoByIMDfFIHmQLT/dSp9QA7w6X8nJkopDHplTP0TKEAoQA3whm8ijcknye+KPuTxPx+81G+z+r7+wVMXJtEXZCkL6DgtnI0ZezpYDDuyhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1971
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:04 A=
M
>=20
> We will need the partition ID for executing some hypercalls later.
>=20
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v6:
> 1. Use u64 status.
>=20
> v3:
> 1. Make hv_get_partition_id static.
> 2. Change code structure a bit.
> ---
>  arch/x86/hyperv/hv_init.c         | 26 ++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  2 ++
>  include/asm-generic/hyperv-tlfs.h |  6 ++++++
>  3 files changed, 34 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f4cb40e53fe..5b90a7290177 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -26,6 +26,9 @@
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>=20
> +u64 hv_current_partition_id =3D ~0ull;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>=20
> @@ -331,6 +334,24 @@ static struct syscore_ops hv_syscore_ops =3D {
>  	.resume		=3D hv_resume,
>  };
>=20
> +static void __init hv_get_partition_id(void)
> +{
> +	struct hv_get_partition_id *output_page;
> +	u64 status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> +	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS) {
> +		/* No point in proceeding if this failed */
> +		pr_err("Failed to get partition ID: %lld\n", status);
> +		BUG();
> +	}
> +	hv_current_partition_id =3D output_page->partition_id;
> +	local_irq_restore(flags);
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -426,6 +447,11 @@ void __init hyperv_init(void)
>=20
>  	register_syscore_ops(&hv_syscore_ops);
>=20
> +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> +		hv_get_partition_id();
> +
> +	BUG_ON(hv_root_partition && hv_current_partition_id =3D=3D ~0ull);
> +
>  	return;
>=20
>  remove_cpuhp_state:
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 62d9390f1ddf..67f5d35a73d3 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -78,6 +78,8 @@ extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
>  extern void  __percpu  **hyperv_pcpu_output_arg;
>=20
> +extern u64 hv_current_partition_id;
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output=
)
>  {
>  	u64 input_address =3D input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index e6903589a82a..87b1a79b19eb 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -141,6 +141,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_GET_PARTITION_ID			0x0046
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
> @@ -407,6 +408,11 @@ struct hv_tlb_flush_ex {
>  	u64 gva_list[];
>  } __packed;
>=20
> +/* HvGetPartitionId hypercall (output only) */
> +struct hv_get_partition_id {
> +	u64 partition_id;
> +} __packed;
> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

