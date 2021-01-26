Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216C53034B0
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 06:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbhAZFZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 00:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbhAZBzJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 20:55:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20700.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::700])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2981C0611C3;
        Mon, 25 Jan 2021 16:54:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnmAYfFWqcVOZFJwuqMQjscP2eDuuZ00qX0lKv2hBvWXUBNZlIk240naGEiVSHtE9KKbLlXLkE98D/ciQPj7q6CT8tQxdFPC4c0MRffcF+FHSaAkTPH6rodA6EnjRzU9LSOEMCkF+hthrGDtephy1519hRVZgAuK1E+473ZxYae6SX3oz3PnsOxC2TnRKK40ChDU6HmAKtMHXD249EIZ0DoERLEcqVvBhupADJrNNHUZwHm3LN+sHpjWnlF7y78yGmjmxZfOVsDwZlNSeWsQs1DtCZnUbKDON8GdlVhXy7BH69sGrtFHWwF0YTsSUcnsLs6/csv7OEuh1KJwsOuNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XZz7m6AYFIvk6s1FDceHRrbp2rFOeOko9//G+INEAA=;
 b=LnY84S7ns1zUu11mczozPn/ScLcX1FpPanS59fyWdYMysReRMJb5y/F7KFYQmEO1qt9s2UvlLlZHrxEvCuJcneBrNi2UxX6a8Jnr75lyymFAWnzQQNxFdJIDbbVtnwH9ZKMI5wwBEN6DYQxOmYelI8Fd0BhraYQWscOjObGOYHmLlKZ+/Nyu1xMgirQOX5tcMSOv3kLF2sBy9JihJtbVje3l74x/IqVE+YlvA2YH7g24difQFhCRQA5UPBbtZkQmNp4VRe9h6PUHN0S8gCUa1d2arPtPK3hNsZN9EIC9qvkAav2cBEsV5khV5HNpXjawZRogU9GNyYKmX3zuxCFKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XZz7m6AYFIvk6s1FDceHRrbp2rFOeOko9//G+INEAA=;
 b=RY6JBW9Q2Ki9KaKMuEGOjPoSCi13okXJb7v2CBsdzw10vOYyan4qHsLlurr6p6gsl/N5/Py6950Vq9CSb0uLJppT6Aa6abABWeqcwLBLSiVgkwDKblBeMNwO4Y8vB2MDPyhyzOcxaBg2+zH7Zs6oFa2vNxPoX7/hb+zEC/iZzyE=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1873.namprd21.prod.outlook.com (2603:10b6:303:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Tue, 26 Jan 2021 00:48:37 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:48:37 +0000
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
Subject: RE: [PATCH v5 07/16] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Thread-Topic: [PATCH v5 07/16] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Thread-Index: AQHW7yPz+GhbbxilDEuVBBNQAujR/ao5GZ8Q
Date:   Tue, 26 Jan 2021 00:48:37 +0000
Message-ID: <MWHPR21MB15932CD9CB9DA046EFFBA310D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-8-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-8-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:48:35Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3d8f1d5b-0f6a-4b85-9f60-759f5ad61fb4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f9902b9-dcc3-4872-7622-08d8c1941dfe
x-ms-traffictypediagnostic: MW4PR21MB1873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB187386540761982EBA53C17FD7BC9@MW4PR21MB1873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/woAQi604xGOSsAPA7ZKTfS5PM7JsvA9pkG/axOM9N3ImboNZ+JWOfg8sfovl+vdzCM8DJpW6SgyQ+dKGbDwz+1anGn+Ruwb+7S5UGJAjtlLpYRSZQD1DesUUbRtnBgWsRUHaxlcCYbrwnRjA1sIYx4ZAYeW+b5TehS0Toww/XvY9np/QUFMQ0yGwEJ2hhNqelP8Wqx3UHzlSmBIMYPUyFk3bxNwm3r9Bw1l8tWSkmu9Q3dzfxNuWgKQf9tbLTqyLQzD9sXwUCVPkExgkd5fEdQhcOsxv4s2mdDZBa3vsAc5ZpkHxKzDDOJe1XoV/V7zEKC+Z14ePpf9zSuTzI1/8QDjvHgFzUD31BaGxlRpcge7FHafX/qxxTM8HbW/bIR+IWQOTtjIUbdU4lFJ104wKFFioHSKrDvCCDzcz9J6AmtUV2KJhwFM2OrdGFMHwiUuuP2PklQuQdOEz+y3mxsb/eubSL98yVtie+H8R1LJLminHlf4s2EctaOM3dyazY/DxFetryjL5ijqqf5hKpzFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(47530400004)(26005)(82950400001)(8990500004)(7416002)(83380400001)(82960400001)(7696005)(55016002)(9686003)(76116006)(6506007)(186003)(54906003)(316002)(71200400001)(478600001)(64756008)(110136005)(2906002)(66556008)(33656002)(52536014)(10290500003)(8676002)(66446008)(86362001)(66476007)(8936002)(4326008)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cSQYJ+V1NAQzC+WFKRWZPhXO/3BNPwLxtGrtK4EhN/OSSmPFi28l/tYnnLwT?=
 =?us-ascii?Q?TZmXYCYz7fvh0Zz4gpKXlWePF23Yc77/bPIErhOOHnmWABCN3F9+fj22GqUA?=
 =?us-ascii?Q?JAtkMs4cD9qz5ztBL5hgoVUa9rJPR9HLZE+ktHsx6AlEhdWWeA6kWp+BVYS0?=
 =?us-ascii?Q?1KmvZzVlzFjJMVo13PAs5/Nprj/8+2V3xKHSauu+XVWCE4VptdyCQc1Y+HGW?=
 =?us-ascii?Q?ioL+oe4XZ6t2zmd6m+nxFbECe/IuquX2d2IVNIUo/0FQnS3WhjBQJuQtk3Gm?=
 =?us-ascii?Q?I1y05MKOlECGTnEr/rHaa0x/PcFPn5Lo2I03EPZuzeUN/TmZUpuFFPjJHU0l?=
 =?us-ascii?Q?b1qqOAPfEwYOUXg0DZJILu+guQD/rAoXbpDb7Nusb+yDXPPGJHhxmaTbOtcn?=
 =?us-ascii?Q?EpDLdMyDkMqD1uW/s/AjoN760fDIqskYp8cYamql94+NBKdgD4+DLVD3BGED?=
 =?us-ascii?Q?Wv+DY7J1mLiIm1DIm+FFRv59DzlALSsg5iw32RTTxBwA3Ohcootji1+mFZEm?=
 =?us-ascii?Q?80y3TYJjKNW8UOac1XJtYtwasLGTTozd9rfA1RwQXr9+UFWNUSdBRU1AOm19?=
 =?us-ascii?Q?th/MfaG1tcBrSybOLu56vvbDu3jhGSZQKSO4Pwbse7zFXSPCqNp70O8r+c80?=
 =?us-ascii?Q?Z2WIVOexZLUj2Vas4dEtG832DTsgy1PW3SvGpK4PEt1Ol8Cn1A/ycalJ1wR9?=
 =?us-ascii?Q?iBOCXeuc8Vy73+Qp55/I/LOxbxbp2lGxKUmKXyjym4OqxPcpOssPhAWNRrTO?=
 =?us-ascii?Q?EbU4G/DQQS+CYv/y9Zo/XruSMHiua7tehTyIx+SDkXOuov7d+5M3nR/bn7gY?=
 =?us-ascii?Q?+e/xsCmWJ8P6akFsbtIdAfHuJdV9khVJgE5arNELwq+NrhUYJU9C5qnbGxaS?=
 =?us-ascii?Q?QjhQ1u2ABXILtOVTlRBTDedl6tdFarpb+SsoNsm+VCzycoFA9At58iq42JoG?=
 =?us-ascii?Q?0X1Nmv++LQsH3JzpUSFNHYiZpL+yPazaIwNqBNntUlpkkEv/LWYqfqZ9Wva+?=
 =?us-ascii?Q?1b93l92L0mxQG82VJbrFr9ydjhMWyi0hpMlKkL7/wVhNvbyY1mVOWXluvxPb?=
 =?us-ascii?Q?BzDYOB1w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9902b9-dcc3-4872-7622-08d8c1941dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:48:37.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GczV6INy1lt5jlPTEHh1Q/dM+Qda1FnQEXoQFGtjA1ke39itLHzwCHVaSkvvQvZqBNSBDAkEfcjx/Y0HxJ00I73M7Hk6Ddx2GYLvZ73o9LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1873
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> We will need the partition ID for executing some hypercalls later.
>=20
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3:
> 1. Make hv_get_partition_id static.
> 2. Change code structure a bit.
> ---
>  arch/x86/hyperv/hv_init.c         | 27 +++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  2 ++
>  include/asm-generic/hyperv-tlfs.h |  6 ++++++
>  3 files changed, 35 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f4cb40e53fe..fc9941bd8653 100644
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
> @@ -331,6 +334,25 @@ static struct syscore_ops hv_syscore_ops =3D {
>  	.resume		=3D hv_resume,
>  };
>=20
> +static void __init hv_get_partition_id(void)
> +{
> +	struct hv_get_partition_id *output_page;
> +	u16 status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) =
&
> +		HV_HYPERCALL_RESULT_MASK;
> +	if (status !=3D HV_STATUS_SUCCESS) {

Across the Hyper-V code in Linux, the way we check the hypercall result
is very inconsistent.  IMHO, the and'ing of hv_do_hypercall() with=20
HV_HYPERCALL_RESULT_MASK so that status can be a u16 is stylistically
a bit unusual.

I'd like to see the hypercall result being stored into a u64 local variable=
.
Then the subsequent test for the status should 'and' the u64 with
HV_HYPERCALL_RESULT_MASK to determine the result code.
I've made a note to go fix the places that aren't doing it that way.

> +		/* No point in proceeding if this failed */
> +		pr_err("Failed to get partition ID: %d\n", status);
> +		BUG();
> +	}
> +	hv_current_partition_id =3D output_page->partition_id;
> +	local_irq_restore(flags);
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -426,6 +448,11 @@ void __init hyperv_init(void)
>=20
>  	register_syscore_ops(&hv_syscore_ops);
>=20
> +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> +		hv_get_partition_id();

Another place where the EBX value saved into the ms_hyperv structure
could be used.

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

