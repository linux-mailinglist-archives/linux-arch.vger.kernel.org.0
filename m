Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBEC64A521
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiLLQlb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 12 Dec 2022 11:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiLLQlB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 11:41:01 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0D164AD;
        Mon, 12 Dec 2022 08:38:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrOWwC7JumE9GBvxhgwjIbB+diMTqflty/b2Tf9EWqmD6ECiowdVQnAn1ZBF1p9NjCGe1ECiN4O5dDsktwANoI+2bpDosMF/7DlYMt2w5k1DF/4/+ZAEHh9TFPRW0FfBz904MhGxI1Nfc1hZHl7QZXX7FA/1Eth2YZbjbNcoLXNpV1oZH3Y2Mt0bnDOF5N0DncecDFqTlqq2tiZnixmpFO4FzUQeBAHpC5uvM+ICDZKKUgjOwS7nKYQoiunHp8w3x4Xw0s27s9ln7zbeJ4NNllujeYHmz+doJQkFNIiQdc8kDtU0U/nO5vnlI/+K/eEco44ucyFL3Qfsh5u59+m6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXKaMPvsyb4ktaUyYmG5RolOMuinLtHuKPvBrRj7+X4=;
 b=kDXbjuHftgiQL98QiMWxDNtUBbo31wa3VEuy/uSFH3eq9DKIsBB7/bo4FH4ISTa7RPcA4Mt2boRa66ysXMH/Wg108CXsdqRI2TXIqt+irZUKB1WSpnfmKpO1wpfzq4gwAWsuRKMVB7W1IjxoJ42IRT/TArgq9Ga1Xh/Q/Zpqh0k105//uQKZdhz3tlOI5i4wgt6rDYTrKxpXf0e4gr24I/YvgEFWBt78BNmuD47sYDlHveDs1vj2qc0eLGUMlCgcXcRBidsfxNNmKySiRsTraXDtCkVGI57N9otJiZHaAvnjMLWASFaCvhoKThxIxHQU8jjS0f8oZzR37Xi9CUKE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CD1PPF08B6E7A8B.namprd21.prod.outlook.com (2603:10b6:340:1:0:2:0:4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.1; Mon, 12 Dec
 2022 16:38:41 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Mon, 12 Dec 2022
 16:38:41 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH v2 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHZCdO5oF6MXqWJVEq1rq5J7Jhdia5qe3Mg
Date:   Mon, 12 Dec 2022 16:38:41 +0000
Message-ID: <BYAPR21MB16880DC440AF1E9FF8DD6FBAD7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-6-decui@microsoft.com>
In-Reply-To: <20221207003325.21503-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8dbf0f0c-bea9-4e95-9714-924839bc110d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-12T16:34:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CD1PPF08B6E7A8B:EE_
x-ms-office365-filtering-correlation-id: 10434508-7983-400e-0198-08dadc5f53f8
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jROJXwnbS/Nqq0JCZJclbodgTIgyjV/VljkzPdAt3fOEJaaunjYRfpE1U72Z2ez3u2lntpEi5xM7nRoVt45J2qAEducZl9bxoKS0YuBvJqHoAr3iuHfkAGzVVNQF51Zav9lwzmET7m06v/Zms0w3F0nwSatzD9Q+1jCP843TgGXGOlksERlNzRzJFZkUzQBKL09l2CIJ1xdMyZsyPfxHSQdRaiqQSXN5MZmhiyqHZyzVKaqVkTTqXlDvFnkIFgXaE+bJtxz/2mQ6BBuCQAAYfhZwoY9UyqSOs/fBlh3G/Lo8RhU1NIT0ZUYJL+Y7rUUxhuL40kXrrnUJHM2q+vHK0iHp0MAVbs3n2zEprBUBjwRnmbSOaRBWsG4NSTkcpbx2QHXhQ3FSUIPHA9Ltsm4qmnBXi4SCADhDmjTJwG3rdvWIaLRLYq++EcbgOg4DY6Q5U4VchdGaXYcl1Hn58wdKCJsTmLz5f2bzSR1OLtqX7zy45ZN0u/blD8yp1RUL1iD38JSAlRg6kfsMVZWhalS4JIk0q/NrkxuLr4tQx9qkTwXpZNzlZTzs3f+RhDS7ECXdKeBGeNdtY5bxM9iHgBPl0VtDekxJ447awLDMLgXzI3He9LiXD9RzriIpOnI0KBdpl/RPqk1ZLMNNoDne9QDWK4xotnEfUi2AIjE+ixPhgsemDITk9HERHYqf8hS6DEcRAeHEb5y2R7pAi3dVUVdad57P6SMRCbu07SCVtgo7tUEzF8TelBgArnWlJ50UYqM8LCComDfJM0GPyuhY68h6cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(33656002)(82960400001)(8990500004)(921005)(2906002)(41300700001)(478600001)(55016003)(71200400001)(38070700005)(38100700002)(122000001)(86362001)(82950400001)(5660300002)(7416002)(110136005)(10290500003)(316002)(4326008)(66476007)(66946007)(66446008)(64756008)(76116006)(66556008)(8676002)(26005)(83380400001)(186003)(6506007)(9686003)(7696005)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ON/n5zLuL/zIbGPOpzaCXbALj0fbBG3QQZwO0yAH6EgDtA3aLVTdBYmXhFDQ?=
 =?us-ascii?Q?hvZF+KJOS7W+xtY3PXZHr2OUt80k8++g3ni2LInNGPCeD4zwG/aIgucNTeD0?=
 =?us-ascii?Q?uwxYM4zRLGFZj5U/GMxVJ8UbtCHrYhQlxpHPRFShhqWqtYnbywpUK5QfF0/2?=
 =?us-ascii?Q?FUFR6jvD2IdvneH2KlkVZdao9w0iW4Za/inL0cVAN95GPlVVt3MNUpG74eS8?=
 =?us-ascii?Q?UDY8vQ7llELVgjsQecDJiUlsr+A/J8wX6gZOocLtXWw7erpiab+Es5VpOiBx?=
 =?us-ascii?Q?c1AHWxedpVNqtI/7GgVuUaAYeG6NBI02wMElKNbKUf8Wa50NsHQpnYX8I8KX?=
 =?us-ascii?Q?V29BDS7YJ1aLU30hlFjCJ3IhK0XU9RMra+SXG/zw7j7MNnYI4Dig/L4m7+WD?=
 =?us-ascii?Q?whZrsVSz9Ondp6c9Sok8fK/alKtDtoSA6zknzbc0HPS9ZwW8i5+oHXKqgnMv?=
 =?us-ascii?Q?abPv640NjcPJGPCj/ALII7evKiLXSMsbxZmUCfn0xZ5lvgb/XZWmWg7CVY02?=
 =?us-ascii?Q?jxH6HhwfYHYJBMjam8R2ZT6Vnifvae8H21R6tZwMOz348Rep3LPs0TNoV7A1?=
 =?us-ascii?Q?vI/sfC4IUdVgOSeeBz5n0FpamKk/kWts88aXGfQquCML5EJaBu2vugxJHZIB?=
 =?us-ascii?Q?aqtq9k2kJAIGoICWeG+Qr9K3POppmSZ/Hc6hYXlj/9tGzXEIn5UntT92RrxR?=
 =?us-ascii?Q?WAH8UCGTBEpHuxjXeZpiypwhtSaqzjivFOCjReAQTWVfKAU3NiMScbANpSoT?=
 =?us-ascii?Q?FWyqjOVFpPG1LHNHXLmXSaGp3ZoeXR+GKqdrrUaSfECgVenzeS1XGpbOLRly?=
 =?us-ascii?Q?bP2lT2oJqMzEsP8rrRS3OXK1Nw6q0aH+BODuRchEcY3hqDTtiWN36IDdQBBC?=
 =?us-ascii?Q?mekzrEQtCDi+Yma0mrBhyRpP4hIeJpAK6LI57oVWHzjGXUdUSKY+UTkfVz9z?=
 =?us-ascii?Q?+0jwklCAzkf8VoxstQEutkN8P3cxD58JQ6ebpkSUF1rdXjYJQXDtLNE/oFo3?=
 =?us-ascii?Q?UFzGVY3dpaEzOp2Iuqcr1pA4DG08gRbwC/s4e1yT2ihUhaz4yu3v07XWocCi?=
 =?us-ascii?Q?cy3RqBCX7IZ0r+FJJBw9lBtdo9PyvXP9YxpjVunFg9SVvhtcIHlrgUYqI9/t?=
 =?us-ascii?Q?Ju+hJ9e9buVWimGp34godoh90ePwEgFUYKs1VZrLx91siouMvZSbRUTMf8sG?=
 =?us-ascii?Q?nqGZpmvm9cOS/uGyotCT7n+q/8L7GUf7pfpf0JMWZqzDJtZEJYNU3L3YSuVS?=
 =?us-ascii?Q?1moLhO/lnw6KbrNXQumnhSE0cxWTJsKZY0OilkJppZkd9I/Qj3oOS5EoIrEq?=
 =?us-ascii?Q?NxhNRUpq7hooXsHPThjUujtQO90ma3hgYocAQL5qeMVLnHpYfTU8ZO1t1OJn?=
 =?us-ascii?Q?FTjx3GeI7620WIcP4qmMfpon0KG2RAhqIRtw5a/sTfTFW7VsPW0ZJhCT+58O?=
 =?us-ascii?Q?C7eZVFSf4vKdcP5+wkzjEedhM5WpliV2L/zWT5FYI9XF2xCuY1zmkCT7FEWr?=
 =?us-ascii?Q?K0NhysfS+XB+jMUhoM1v+xjN7aRA03IF5GTvWAAwEX3NSffEj3ctIuAGnWYB?=
 =?us-ascii?Q?EqiKUqrfawNcuwtzpGswEwOf4fiJflMI9xfIu/BtLZU3cNsWnNF9J4fHSUzf?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10434508-7983-400e-0198-08dadc5f53f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 16:38:41.4643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQrLvKdEG1YmRbPdefGenXz4MbaCFOyP7kqdy2lys/6usrhikEw5tHc4tRxrkwC2Cltat1wCcTXzVqmJzNuOZS4SHYMq4ZXtW30GWx6/rVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CD1PPF08B6E7A8B
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, December 6, 2022 4:33 PM
> 
> A TDX guest uses the GHCI call rather than hv_hypercall_pg.
> 
> In hv_do_hypercall(), Hyper-V requires that the input/output addresses
> must have the cc_mask.

Is it a requirement that the input/output addresses refer to guest memory
pages that have marked as shared/decrypted?  For example, I don't see
any code to mark the hyperv_pcpu_input_arg page as shared/decrypted.
Do the use cases for the hyperv_pcpu_input_arg page just not occur in a
TDX VM?

Michael

> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> ---
> 
> Changes in v2:
>   Implemented hv_tdx_hypercall() in C rather than in assembly code.
>   Renamed the parameter names of hv_tdx_hypercall().
>   Used cc_mkdec() directly in hv_do_hypercall().
> 
>  arch/x86/hyperv/hv_init.c       |  8 ++++++++
>  arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
>  arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a823fde1ad7f..c0ba53ad8b8e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -430,6 +430,10 @@ void __init hyperv_init(void)
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
>  	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
> 
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> +	if (hv_isolation_type_tdx())
> +		goto skip_hypercall_pg_init;
> +
>  	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
>  			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
>  			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> @@ -469,6 +473,7 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	}
> 
> +skip_hypercall_pg_init:
>  	/*
>  	 * hyperv_init() is called before LAPIC is initialized: see
>  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> @@ -604,6 +609,9 @@ bool hv_is_hyperv_initialized(void)
>  	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
>  		return false;
> 
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> +	if (hv_isolation_type_tdx())
> +		return true;
>  	/*
>  	 * Verify that earlier initialization succeeded by checking
>  	 * that the hypercall page is setup
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 13ccb52eecd7..07e4253b5809 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -276,6 +276,20 @@ bool hv_isolation_type_tdx(void)
>  {
>  	return static_branch_unlikely(&isolation_type_tdx);
>  }
> +
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	struct tdx_hypercall_args args = { };
> +
> +	args.r10 = control;
> +	args.rdx = param1;
> +	args.r8  = param2;
> +
> +	(void)__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	return args.r11;
> +}
> +EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>  #endif
> 
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 8a2cafec4675..a4d665472d9e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -10,6 +10,7 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
>  #include <asm/mshyperv.h>
> +#include <asm/coco.h>
> 
>  union hv_ghcb;
> 
> @@ -39,6 +40,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32
> num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> 
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +
> +/*
> + * If the hypercall involves no input or output parameters, the hypervisor
> + * ignores the corresponding GPA pointer.
> + */
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> @@ -46,6 +53,10 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void
> *output)
>  	u64 hv_status;
> 
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control,
> +					cc_mkdec(input_address),
> +					cc_mkdec(output_address));
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
> 
> @@ -83,6 +94,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
>  	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
> 
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, 0);
> +
>  	{
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> @@ -114,6 +128,9 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1,
> u64 input2)
>  	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
> 
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, input2);
> +
>  	{
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC
> --
> 2.25.1

