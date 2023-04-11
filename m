Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4456DE10C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 18:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDKQgS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDKQgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 12:36:17 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B019B1;
        Tue, 11 Apr 2023 09:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIuCbrgx2ABWvyYE3ai6BEOYAl83uopSsxKvJdRIbXe/k3YG2HIcHaQf59kTZ3EC3evyEEUVchpkFJaHJdW8nyZLW5EiDe4hsG5yi0glAra7yHzGzoFm5Iygdqinef5RNDIDbG7E8Iv64L4geIIduL0NA/bS5Ehdqtew3lxS2aWLdoac9ii4KKbZlqRPqphh0qxePGbwrGxCEsaHbKxvvpbCJnh0BAgPbyeYsOi61HL2G7AXNOpdCdA9Wk0aU3hLWuCEE9w7gAWkHmdKv+4jGIW8upS6gT7FzOKBNCJSec9xoHyyUvkldhCT16RmxPo+vfzo5ufFdhC+1NriSXSjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uPeQqtto8DobLnLfsUFYEU0OUku4L8LbZflfIzT9bs=;
 b=nxujkQz7fVPyCkqas63071e4vTNIVmHFSdz30j9/+TjWmqQyqFj+nt6rt4sFtEE09W6nyV7agPYLaZc7R1PsubLKGFmw/wM2D/XI5NwGR15DhLhxrp6gKDpDPbhSAxDBkphC0eawzsgV16lMdNgT3zB7ql2zFTJtKIi6DLiSUnsj0iMb/8GrEnKcEMprSAYonAZrh6YzRc8prpUnA3k5c2+doqxFc8xAyKdcf61y7MqdHp6k9dV6wfznPNMkVfpPJjWmAPsHR7NZGGimWFrTh6LvGJz4T+Tyws6Ay1UMIYSe/ZnicRuTj/3JK+UYWw2IofpI21JWZMnL1HSy4pEJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uPeQqtto8DobLnLfsUFYEU0OUku4L8LbZflfIzT9bs=;
 b=CVzTJMEE8Q5Atv5rXUk+zjBMea7X4DdU6R7h9wYD/3ZWWs4cFBMO9Oe+r2t65JcwFmQhnG3z1DkuFK4RVqao7+wH5ZR8+HMp/1fgem9SSM1ahxl2mBV5dJgQhhpunZ3fLMY1s+mtOlOLCAmS/1HUoKBA6KxXW2cR3TSGyjWpiMo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3337.namprd21.prod.outlook.com (2603:10b6:208:37e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 16:36:05 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 16:36:05 +0000
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
Subject: RE: [PATCH v4 4/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH v4 4/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHZalugD2m6e7fqJUeqaQjbv610Dq8mUVow
Date:   Tue, 11 Apr 2023 16:36:05 +0000
Message-ID: <BYAPR21MB1688F1138192C3ED0130F29CD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-5-decui@microsoft.com>
In-Reply-To: <20230408204759.14902-5-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f01c7767-e71d-4376-9cf9-f8d715489606;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T16:31:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3337:EE_
x-ms-office365-filtering-correlation-id: cb51abe5-1092-4de7-b913-08db3aaad879
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0yiq16wT4XGAhGHAmtGRJYFqwPB1vqbalb3nh4KP2/j9x79TePjZAjqse0RrRuJv9JvdP6V9lE752Nze+WkQ8/wzA7P4eZiK++E4MnzF/Xhph7ObjOu2wZESqzKvh7JkU5FRFb5ZDvXKbUOTtPQjFx5u5OGz8oDr4D1MiXKpi43koyVhmzC4MptRW+AMr0/s8jhuz6wHhaY35LPkkdLk9WGYyIhZKijBtkWZUOVis39fu/MmMnoil9CFD77vC7yYqWwX4GEFxkrOonfNRbnZrPaA/S7FwHRDDDBwSQqYmMd94JpzrQ0e232uO0Vnp1XiUfnstH+vNC3WigWkAVwDX36AM/xdzEItvcTsCWxp9DnMTRJWhcdyDDoLJbobsYrRKW6CF/C1GpdECQ0ie+CN/yQoNkbu3P+2IC0Ru15rGUkX9t/lMvdvpCYsD0ZwoB2CK6YJiNqAXpSxvTM4DZdzoaMF8hxOzmSalSpNqBFG9wvzbdkgLNxE22sHfoeZ99ueJB0LwMbZ2KVF4wJn+SCYr5IlwhEPjRRibTWbCHpZyqvKhxf41fvh6RZ8Qn36FtvmmDzECiXoivfMxBsTXc9A9C+QZV/HG6kiLyURpHvW9pC0MRWTVgM1DLeh6vHFclYRz6VdNKsBo0Nk+ZZlkn3FP6h/iKj379lmeyF6yjS/vmhlTH+5TKUljQsONrYu0Ap/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(7696005)(66446008)(8676002)(66946007)(66476007)(54906003)(478600001)(71200400001)(66556008)(64756008)(4326008)(76116006)(110136005)(41300700001)(316002)(786003)(86362001)(33656002)(83380400001)(9686003)(6506007)(26005)(107886003)(2906002)(8936002)(7416002)(8990500004)(55016003)(5660300002)(82950400001)(38070700005)(82960400001)(921005)(52536014)(186003)(122000001)(38100700002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mu4uxv3xsO4IBY8Ty6n7emg3HTGcddmbx5PSgK8Qu7vqotFohDrBVVj0abxq?=
 =?us-ascii?Q?EEEV3i/zBvvxLT7Jq+Wi/4CMwO70HYwGqjmD0zBZCXTdyhfC2AYA1N9IZaDt?=
 =?us-ascii?Q?n22LtO2MteHU/cQLB6owdNmRwTFKr/BN6wgQ4S32D5EQ+khSqGwckLkQCaHn?=
 =?us-ascii?Q?gZaJmiGF17wZCa64TxLLFzknkO1DjU2wEVdia7SEdgFlz8COHrR11qrzO2gm?=
 =?us-ascii?Q?yK2BCv5fyV3Op1rLdNqDSogm4HZdDw/QURi74/ZWSC+WkS2veL2wezong8BV?=
 =?us-ascii?Q?iqiGeWARoJaET52tCH5CVW5o4CUBctViOYeOUUhWE9R+9GljrDHpVJpd4tQA?=
 =?us-ascii?Q?IZyfibAGiRquxycBOlu7Zim1BxKQIE6CvDrCTGqPQ96jT16EwPt3dovvLz+K?=
 =?us-ascii?Q?UFbjV/Rm0c8QCMjMMvE86orhTsGZiDx5a0qYhdTA02Z8QNYbttRGutcjjzA+?=
 =?us-ascii?Q?I3LGuZXCmJyDO+k1o9oXzYrtO6G4CAAKmd4dj0V9N0cJj4PoO3WEtuN/qT4p?=
 =?us-ascii?Q?5GvMGtBicMpqvVOu0LnBt7r6HHRtWTtiA3m+v9M7lyCssZO316Tvv9o6OsWK?=
 =?us-ascii?Q?RNsyImolgNQgXBKgMZKwFj+7TSJ4HuBWAVHNB7FE7+hPdTaD6phl4XZygPO7?=
 =?us-ascii?Q?glatvX/w4x4uuUbDmDFkyITxSh+4CHypmHCcZe94fTtyxfthj3kCSEFAQkzR?=
 =?us-ascii?Q?unPtT3YwWm0uCntj1eKrVMu6eZ0Hha8YVROyRB0aDJgUdB/cbhZRdz2WaWPQ?=
 =?us-ascii?Q?MW3/Gj+LtASX5n0DO7h7OgV3Xh/0Y1RyMoedq8tspvn+lOmVNk27L94aoVHK?=
 =?us-ascii?Q?o5DYSlPHomxRnKOPLfnYUmwHDasXnDciJCPvhFSVjaTA/xk3cvUQoimPA+s3?=
 =?us-ascii?Q?IlWnk6G+3W1NRi+KbH7Vm3d975A+qycRbypyRVd8d1rCNx+DXn2p3le6wlS8?=
 =?us-ascii?Q?RrTZlnPD1EnAfA+UDhXBbuPaOYRAX334QDQrbiDdbzEF+3bXsa1DvcqPQjIB?=
 =?us-ascii?Q?HJ8xbMKh4fr/R4bJ7uUjssznJRxUrzKj3cpIsPHP4yhV8yXlPjVzlELLk2Wr?=
 =?us-ascii?Q?f40v9ZJZkZLWeQo+6McpKP9T36rDJ9lY5ktgoW+2MPTjTNbkJxBpj8WSN4Ns?=
 =?us-ascii?Q?Kh8svnviaK3BgJfp3r1TIOktJgRvoWRJm7v90Fs2kqpHE8GsCwdBq9TrP2Ks?=
 =?us-ascii?Q?0snqHy4+aB5TOPA/Ly0gR39JAGOPAdjLy0QbrtRZdNfO/qfmQ/Fm6AFF/zqz?=
 =?us-ascii?Q?dELEzIaqE4B2TRxqztSySNtAeJ5JZYU6WbGNKO5rBJHKTrUjQDGVWM9CG3/I?=
 =?us-ascii?Q?kySsdObBBlzipjWDgn4YIn/12l3DxMeNh3IpwXN1qcOyuuLXZxXx8O74x2fp?=
 =?us-ascii?Q?L8Brg/yOu3FeT+i8278iRzglmyC07wN1QElYC9/f3EMZfEDIB6HNKUd1PRrl?=
 =?us-ascii?Q?JoiejcYNue9oGYZBmIKTvojNppYSCrXzCJ7CvsZmmYAHc55Vkx4lVVVXmUz3?=
 =?us-ascii?Q?EuZpsJrL6vXPp4pr855pg9ftXW41uV+uw+9rA5ikFzvFGlsCYi+3CN9sRmsQ?=
 =?us-ascii?Q?cqiw16zmddDvnqYQoZmLKxc+RxSzRfAl+Q+lls2baRUSPxI+INVrLqg9SWc9?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb51abe5-1092-4de7-b913-08db3aaad879
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 16:36:05.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnXgtdD3oAxYmx69zXD9xYDcVCshwJ+RG9hbAJ35KtndhOzIvTu1X5kSckwzb0UsV1hzAsvaorcQX9esuQptny+dae6YePa6FL4BLZQmO4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3337
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
> A TDX guest uses the GHCI call rather than hv_hypercall_pg.
>=20
> In hv_do_hypercall(), Hyper-V requires that the input/output addresses
> must have the cc_mask.
>=20
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> Changes in v2:
>   Implemented hv_tdx_hypercall() in C rather than in assembly code.
>   Renamed the parameter names of hv_tdx_hypercall().
>   Used cc_mkdec() directly in hv_do_hypercall().
>=20
> Changes in v3:
>   Decrypted/encrypted hyperv_pcpu_input_arg in
>     hv_common_cpu_init() and hv_common_cpu_die().
>=20
> Changes in v4:
>   __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT) -> __tdx_hypercall_ret()
>   hv_common_cpu_die(): explicitly ignore the error set_memory_encrypted()=
 [Michael Kelley]
>   Added Sathyanarayanan's Reviewed-by.
>=20
>  arch/x86/hyperv/hv_init.c       |  8 ++++++++
>  arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
>  arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
>  drivers/hv/hv_common.c          | 24 ++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  1 +
>  5 files changed, 64 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a5f9474f08e12..f175e0de821c3 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -432,6 +432,10 @@ void __init hyperv_init(void)
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
>  	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
>=20
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> +	if (hv_isolation_type_tdx())
> +		goto skip_hypercall_pg_init;
> +
>  	hv_hypercall_pg =3D __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
>  			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
>  			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> @@ -471,6 +475,7 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	}
>=20
> +skip_hypercall_pg_init:
>  	/*
>  	 * hyperv_init() is called before LAPIC is initialized: see
>  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> @@ -594,6 +599,9 @@ bool hv_is_hyperv_initialized(void)
>  	if (x86_hyper_type !=3D X86_HYPER_MS_HYPERV)
>  		return false;
>=20
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> +	if (hv_isolation_type_tdx())
> +		return true;
>  	/*
>  	 * Verify that earlier initialization succeeded by checking
>  	 * that the hypercall page is setup
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 3658ade4f4121..23304c9ddd34f 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -415,3 +415,17 @@ bool hv_isolation_type_tdx(void)
>  {
>  	return static_branch_unlikely(&isolation_type_tdx);
>  }
> +
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	struct tdx_hypercall_args args =3D { };
> +
> +	args.r10 =3D control;
> +	args.rdx =3D param1;
> +	args.r8  =3D param2;
> +
> +	(void)__tdx_hypercall_ret(&args);
> +
> +	return args.r11;
> +}
> +EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index de7ceae9e65e9..71077326f57bc 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -10,6 +10,7 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
>  #include <asm/mshyperv.h>
> +#include <asm/coco.h>
>=20
>  /*
>   * Hyper-V always provides a single IO-APIC at this MMIO address.
> @@ -45,6 +46,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, =
u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
>=20
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +
> +/*
> + * If the hypercall involves no input or output parameters, the hypervis=
or
> + * ignores the corresponding GPA pointer.
> + */
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output=
)
>  {
>  	u64 input_address =3D input ? virt_to_phys(input) : 0;
> @@ -52,6 +59,10 @@ static inline u64 hv_do_hypercall(u64 control, void *i=
nput, void *output)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control,
> +					cc_mkdec(input_address),
> +					cc_mkdec(output_address));
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
>=20
> @@ -95,6 +106,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, =
u64 input1)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, 0);
> +
>  	{
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> @@ -140,6 +154,9 @@ static inline u64 _hv_do_fast_hypercall16(u64 control=
, u64 input1, u64 input2)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, input2);
> +
>  	{
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index c55db7ea6580b..10e85682e83eb 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -21,6 +21,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/set_memory.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>=20
> @@ -128,6 +129,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount =3D hv_root_partition ? 2 : 1;
> +	int ret;
>=20
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>  	flags =3D irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> @@ -137,6 +139,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (!(*inputarg))
>  		return -ENOMEM;
>=20
> +	if (hv_isolation_type_tdx()) {
> +		ret =3D set_memory_decrypted((unsigned long)*inputarg, pgcount);
> +		if (ret) {
> +			/* It may be unsafe to free *inputarg */
> +			*inputarg =3D NULL;
> +			return ret;
> +		}
> +
> +		memset(*inputarg, 0x00, pgcount * HV_HYP_PAGE_SIZE);
> +	}
> +
>  	if (hv_root_partition) {
>  		outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> @@ -157,6 +170,8 @@ int hv_common_cpu_die(unsigned int cpu)
>  	unsigned long flags;
>  	void **inputarg, **outputarg;
>  	void *mem;
> +	int pgcount =3D hv_root_partition ? 2 : 1;
> +	int ret;
>=20
>  	local_irq_save(flags);
>=20
> @@ -171,6 +186,15 @@ int hv_common_cpu_die(unsigned int cpu)
>=20
>  	local_irq_restore(flags);
>=20
> +	if (hv_isolation_type_tdx()) {
> +		ret =3D set_memory_encrypted((unsigned long)mem, pgcount);
> +		if (ret)
> +			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
> +				cpu, ret);
> +		/* It's unsafe to free 'mem'. */
> +		return 0;
> +	}
> +
>  	kfree(mem);
>=20
>  	return 0;
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index afcd9ae9588cb..83e56ebe0cb7f 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -58,6 +58,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputadd=
r);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  extern bool hv_isolation_type_snp(void);
> +extern bool hv_isolation_type_tdx(void);
>=20
>  /* Helper functions that provide a consistent pattern for checking Hyper=
-V hypercall status. */
>  static inline int hv_result(u64 status)
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

