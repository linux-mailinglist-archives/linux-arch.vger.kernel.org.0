Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC94624C08
	for <lists+linux-arch@lfdr.de>; Thu, 10 Nov 2022 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiKJUix (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Nov 2022 15:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiKJUiu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Nov 2022 15:38:50 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC201EEDD;
        Thu, 10 Nov 2022 12:38:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH9/P0riMUrBEkx7xcxkgSSJA6oPxK3c7YbBXFHtCD7jTutTKH9PUm4JfU/dr19ZQl8v+t0eiqBQofaOqn2xlPpN0MSnWOPe0fciRpjM+zSgnDsuFkkwP064Dz86xvbG+2eVW4zaZyapFVkAmzIdZlEjHRS2gFfLnvg2S4nqnTRNaYVfeIBClZmpFm+PcABlNub/ptHIcBXu6PdWQVgPQ3MFlAWhI6vli5hQ+zy0bfNv8vd+le33+XMDGWWaxt2k7G2nGqe3jZTEvG7FgeU5rBYAaFVlyyZHMkkWYF9QhipoilM2eOjF+3WtN+NBoXSHPX6dhfO/BLkGOShnGIIj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x4uNCP282tyTlzTa+UpCWmXpZ5+7aGZjddwxeWSABw=;
 b=gsenkFhw+asRlzU0u4akOSNvnbbaje6cyrQouuuFS+8wSbUv3sghsYpufwcx9RfLGlMzebL5VV17EN69qNHRGiXxidUyAH0uXYez2YXMMvj8yY4Qo7N2vQyCQ3H+TgdyjN+NA+rkXGmtrvHVagpSw3FaTzu+IxyNCOvEu5WHLXI7OYasFTY74W3t77mkqVdWQ7XW2WglbbRGnF8R81AAqNkl1xAg2uuy0Iqub1mBAjLAWCbelu7kfZ8u0Hbl5GMTAtVcj//v68YDPa1C3S1UTpXcLj3SzNC5FOk2zBnd57laNipdpXCtVAVNa8NYk6zvx2u+HqkBT/xPBRqjfkwqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x4uNCP282tyTlzTa+UpCWmXpZ5+7aGZjddwxeWSABw=;
 b=HpD+WjGPYkzEHGPJIKboHyX5c5BPBR5982eDiakbDyOAAuKZRPfv9DP2j+0JRFYcVQXvMI6n7cz8MI6mXTwjRXBXf6g7yS/axKy/wEtCn7hWacmEODE70cWbkJg0DE+Dxjr731DlH8RJbagbLw5m0JoSHG187TbwvF/o7mfMa0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 20:38:44 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::36e7:b51d:639e:ed6c]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::36e7:b51d:639e:ed6c%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 20:38:44 +0000
Message-ID: <aed619fe-3e08-e99d-67c3-3a91da47eefb@amd.com>
Date:   Thu, 10 Nov 2022 14:38:38 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH 16/17] x86/sev: Add a #HV exception handler
Content-Language: en-US
To:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221109205353.984745-1-ltykernel@gmail.com>
 <20221109205353.984745-17-ltykernel@gmail.com>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20221109205353.984745-17-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0432.namprd03.prod.outlook.com
 (2603:10b6:610:10e::20) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a05006-0ef0-45d7-9c5c-08dac35b8f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vwmno5LTvF/FO0tykI6pY0CJ/lF7A4MMD3q+BdRID58QL5zCsJd3w51lt2jwCuL9PFZQl0i4iiG9sp+fesvZI65l+FQ+WMAvWEjCageqZHIsxzbNF1g92yIrcAg2/ji3XSUJEBC1bVDRFVH6OsAOvHotdZi2XLvX6j307diMUDtEf+srEr59Z4DxH8grtJ0FipIQnB6pI+Tq2369kGvxh9XB28y8z5gx1vUlVrYmH6Gk4iVolOUinFgNTwSGSHcbEN6T6/tXL3g+HzppIaiiWtR/2HRUidOhd7+2iVAmnSbOgZNvsuITOMz8nQrZqEsUjunRod/oBvr5jR1RQcZhVixjoHJFSi7anlmoNO2QgiamAAc9WaWiVn4gP3FrgSCVVe6wIu+qgXr67zTDOgz4MAH63E8cTXCqCEzTca5m8+yYVK7M/uxNLAkQqCyOPB0pvI4fomndYX3CYB90O5qBNCoGQfUC+2lP4GMrNRzragb2zx4Xy+qWZwKXVS2yXo4RMCnFk8qJLGDZTfNZK10C3ZYMEDcG38n/xDmdPr+lMIhEKsLxokNPUPqHxbgc46aARbYBJc/zn4KXOT3pfNzOrDIngMf4xyNnBMKCxE71x7yCWujUc55DIhydKUa/yQ9nuc2NlBaASgm7lfKzJlnCVTlB5dI/McFYj9ALdpK73NiY4mOwZOlOxzeD0/uiXaU3ZkbW0X+jCc4itUWkbMgDEfkUcUrNtqfUs6GVexiI7reeUCcq5ZXKKOzTzjTzSeGoGWbN9HkFCJXfuT8DD8JzYPzJDgaPj5Ec4dJX0Mykr/hPCzS9E6oPml/2Xi+wmf2g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(83380400001)(2906002)(31686004)(66899015)(66556008)(66476007)(41300700001)(66946007)(8676002)(26005)(4326008)(36756003)(86362001)(31696002)(38100700002)(316002)(921005)(186003)(2616005)(5660300002)(7406005)(8936002)(30864003)(6512007)(7416002)(53546011)(478600001)(6506007)(6666004)(45080400002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akxQMmJ1R0lUSEJjbW9BNldwdksxemtuVXVycXY3cjd4NjJHZEtWR3h5WHE2?=
 =?utf-8?B?emI4Q2I3dFVMZDJLTDA0VjQ4YVdOUEdPNWVVOG9Ub3V1NTlicFNxM25IRHpZ?=
 =?utf-8?B?YnF3R1JDV3lFNTMrbE9mMXZpOXVmRlREVnhNSlc2MmpncWtQREpTWjZMaVlH?=
 =?utf-8?B?UzVSeFVrUHU3eU1oclRIZGI4MURyenBVTnpqcWRWTXM1MmdHSitITHNXN2lP?=
 =?utf-8?B?OWdYRlpzZnl2anlQc0FvY0VMeEw2b2loZE5TVjVmWnZnejZrQkRWaFZaOFZq?=
 =?utf-8?B?Mm9OeVBZVXdjeDVvOHFRZjd3WFRuZUpEdWNIWFJvdm5PN2tpSWxVUzAxblZW?=
 =?utf-8?B?bGdTK3IwR3lsakh1S3c2amZaM3h4dFlRTXUvSkdyOThkdWQ4RWdtYmtqYndh?=
 =?utf-8?B?V2VLVkV3S212R1lNOUJUWEN4K0dBL2lJdE9FWTNSek1sM2xpdGdabWJZUUVm?=
 =?utf-8?B?OHlkU2VDZFE1c3pUWDhHeFJkbmwwRE9jcHpIL09QVm52b0JYcC9tZVNOcVh5?=
 =?utf-8?B?ZHRnZXFDT1UwcUdwTFVwNGRmV0hyeDFRM2tDZ2dnbWFlZmpsTWppbm9zTk55?=
 =?utf-8?B?NDZ2YU10K3prSFRNZm5HdWttTjF4UVFZWWw5VTJqc3dWdW9Na0RJNDFvTlBu?=
 =?utf-8?B?bHhjS2VoeTZkYUorbkhuVzU5dTdhWUJsekxZeHNGYTZ0dmpyK3AvUTJUVnA1?=
 =?utf-8?B?dEVVOFZJWGVXcFZVay9CbjBuUVRPNGNTYTVvR25FR1I4U2xzaXhDeU4wVXR6?=
 =?utf-8?B?Q0J0djNYaDNWVFpXKy9OYi9Za2xhRjdHajVVOU9EdUFZUndKV0pPREhLQjkz?=
 =?utf-8?B?VllkQ2tXUTlUSnBRbTQrWEFwaEZGdXQyRENycWRYai83OTZ0WHlwTk5NaTd5?=
 =?utf-8?B?UFhucCtNZFdaNEE1T0xJalN2NGJKOEVFVWtCOWdKampWTXRyZUlubGpMNGlY?=
 =?utf-8?B?bU1kNmR1QmZ4NGRLQmxqT0t2R25BSmtqSHJRdlg3NFNqUEgzc25Vdy83dGhW?=
 =?utf-8?B?dlVzUHNWOHlLVHRUQ2Y5U29NYzhJQ3crQW93Vk9XL3A4cWxyZG93dGo2YkMw?=
 =?utf-8?B?bUxsNlhpdE9VWStZdVJLQmFNVVhIWGc1RGRKUVQvZklsTzA3RXF0eUoyemt1?=
 =?utf-8?B?MTc5Tk1Md1BXRmNuYU96SmVCOWtLejZ0bmlxaVdVOXJCMWhURTFsOHR0SlAr?=
 =?utf-8?B?QnE5NzZzUno0RTJxeWtLTENRRGcyZzFxZDAzN2RGREpnbFBqMFdMS1VzRFpZ?=
 =?utf-8?B?MURXdDQvbmtaYjBQdWpvVFRGOFVQL1ptb1kvdEdIWEF4dU00OU9oR2JBamVz?=
 =?utf-8?B?WUplbThkNXBMZ0dBRGlSNTY1MmQrNW1DeWNlRlVSaVR6TVhwMlU3bGh4bExY?=
 =?utf-8?B?R2FHWFJrOTN2STlwZGhqZTZ1ZjVwYzRnVTdzWGN2U0dpYmVMR1Bqbm5TanZL?=
 =?utf-8?B?Q01WUFBRT3Y4NkZUaC9lVXRCVU5SbGdOK3JMZ3Q1M01ndG5SQlNuWktjTlht?=
 =?utf-8?B?UU9SeldNWjBZRUdydng1UDZTUjJ3WnNzaE1MQ3gzRkRyVE80N055LzZpbDhK?=
 =?utf-8?B?azk3cFhEVnY3OS9rNTN1azg0YnNCVUNVak45cGVNWXJLVUxLNkxNMVNGTmxz?=
 =?utf-8?B?cnphbXNxVHJJZVdnakdKcmRiT011cTFNdGQrVC9PdHdBY2ZCa2k1ZGl3TXBP?=
 =?utf-8?B?NjYxcHh3TG9iY2l1WnlCOHVFRGZMUEl2THYxbGxqTWFHdUtOUXRvNEZFbWE5?=
 =?utf-8?B?cHJLUmF3MERNOXNEY1dmNTFDR3dXZ0kwR3pyTzl2SFIxZmg5MEUwcWJoK3cx?=
 =?utf-8?B?eTNiWitFNExPckRiUnoxSEh3Nm1uZ3ZLMDRub1RwaUwvN3Y4cC93K3ZWVDRG?=
 =?utf-8?B?bVQ5L3RrbVNkOTEyUG9hTURkdzRFUkhBaWo3MWhxZ0dSSkJTY0plZUNRL1Fk?=
 =?utf-8?B?c3daVXRWR2wyMUMvUVJLOHVDdmZhWVJOK09OM2ZsVkFKNmJJODc5elVYMlVj?=
 =?utf-8?B?SFpoSCsrZkZRZGF0dSttS0doWjRjZC9vRGlrRWQrVGM2VFYxMVdBOGdEc0JC?=
 =?utf-8?B?QXhuSm56eWR1V3VYS3d6UStDN1daVjF2WGpNSDhxZEFqWVZaMi83TXh1OHAy?=
 =?utf-8?Q?b8tVn+UtzPVK2pqL+Fj4tGRmS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a05006-0ef0-45d7-9c5c-08dac35b8f25
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 20:38:43.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lF3oqll7RMsQmfpmlBgJ6Ut/ZbBt9B+BrOjHzo/gYx0lPTKhZP3JAqNjGLFnkFV3+eXdsNTpq5tI6ALtRKIYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Tianyu,

On 11/9/2022 2:53 PM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Add a #HV exception handler that uses IST stack.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/entry/entry_64.S             | 58 ++++++++++++++++++++++++++
>   arch/x86/include/asm/cpu_entry_area.h |  6 +++
>   arch/x86/include/asm/idtentry.h       | 39 +++++++++++++++++-
>   arch/x86/include/asm/page_64_types.h  |  1 +
>   arch/x86/include/asm/trapnr.h         |  1 +
>   arch/x86/include/asm/traps.h          |  1 +
>   arch/x86/kernel/cpu/common.c          |  1 +
>   arch/x86/kernel/dumpstack_64.c        |  9 +++-
>   arch/x86/kernel/idt.c                 |  1 +
>   arch/x86/kernel/sev.c                 | 59 +++++++++++++++++++++++++++
>   arch/x86/mm/cpu_entry_area.c          |  2 +
>   11 files changed, 175 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 9953d966d124..b2059df43c57 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -560,6 +560,64 @@ SYM_CODE_START(\asmsym)
>   .Lfrom_usermode_switch_stack_\@:
>   	idtentry_body user_\cfunc, has_error_code=1
>   
> +_ASM_NOKPROBE(\asmsym)
> +SYM_CODE_END(\asmsym)
> +.endm
> +/*
> + * idtentry_hv - Macro to generate entry stub for #HV
> + * @vector:		Vector number
> + * @asmsym:		ASM symbol for the entry point
> + * @cfunc:		C function to be called
> + *
> + * The macro emits code to set up the kernel context for #HV. The #HV handler
> + * runs on an IST stack and needs to be able to support nested #HV exceptions.
> + *
> + * To make this work the #HV entry code tries its best to pretend it doesn't use
> + * an IST stack by switching to the task stack if coming from user-space (which
> + * includes early SYSCALL entry path) or back to the stack in the IRET frame if
> + * entered from kernel-mode.
> + *
> + * If entered from kernel-mode the return stack is validated first, and if it is
> + * not safe to use (e.g. because it points to the entry stack) the #HV handler
> + * will switch to a fall-back stack (HV2) and call a special handler function.
> + *
> + * The macro is only used for one vector, but it is planned to be extended in
> + * the future for the #HV exception.
> + */
> +.macro idtentry_hv vector asmsym cfunc
> +SYM_CODE_START(\asmsym)
> +	UNWIND_HINT_IRET_REGS
> +	ASM_CLAC
> +	pushq	$-1			/* ORIG_RAX: no syscall to restart */
> +
> +	testb	$3, CS-ORIG_RAX(%rsp)
> +	jnz	.Lfrom_usermode_switch_stack_\@
> +
> +	call	paranoid_entry
> +
> +	UNWIND_HINT_REGS
> +
> +	/*
> +	 * Switch off the IST stack to make it free for nested exceptions.
> +	 */
> +	movq	%rsp, %rdi		/* pt_regs pointer */
> +	call	hv_switch_off_ist
> +	movq	%rax, %rsp		/* Switch to new stack */
> +
> +	UNWIND_HINT_REGS
> +
> +	/* Update pt_regs */
> +	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
> +	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> +
> +	movq	%rsp, %rdi		/* pt_regs pointer */
> +	call	kernel_\cfunc
> +
> +	jmp	paranoid_exit
> +
> +.Lfrom_usermode_switch_stack_\@:
> +	idtentry_body user_\cfunc, has_error_code=1

#HV exception handler cannot/does not inject an error code, so shouldn't
has_error_code == 0?

> +
>   _ASM_NOKPROBE(\asmsym)
>   SYM_CODE_END(\asmsym)
>   .endm
> diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
> index 75efc4c6f076..f173a16cfc59 100644
> --- a/arch/x86/include/asm/cpu_entry_area.h
> +++ b/arch/x86/include/asm/cpu_entry_area.h
> @@ -30,6 +30,10 @@
>   	char	VC_stack[optional_stack_size];			\
>   	char	VC2_stack_guard[guardsize];			\
>   	char	VC2_stack[optional_stack_size];			\
> +	char	HV_stack_guard[guardsize];			\
> +	char	HV_stack[optional_stack_size];			\
> +	char	HV2_stack_guard[guardsize];			\
> +	char	HV2_stack[optional_stack_size];			\
>   	char	IST_top_guard[guardsize];			\
>   
>   /* The exception stacks' physical storage. No guard pages required */
> @@ -52,6 +56,8 @@ enum exception_stack_ordering {
>   	ESTACK_MCE,
>   	ESTACK_VC,
>   	ESTACK_VC2,
> +	ESTACK_HV,
> +	ESTACK_HV2,
>   	N_EXCEPTION_STACKS
>   };
>   
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 72184b0b2219..ed68acd6f723 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -317,6 +317,19 @@ static __always_inline void __##func(struct pt_regs *regs)
>   	__visible noinstr void kernel_##func(struct pt_regs *regs, unsigned long error_code);	\
>   	__visible noinstr void   user_##func(struct pt_regs *regs, unsigned long error_code)
>   
> +
> +/**
> + * DECLARE_IDTENTRY_HV - Declare functions for the HV entry point
> + * @vector:	Vector number (ignored for C)
> + * @func:	Function name of the entry point
> + *
> + * Maps to DECLARE_IDTENTRY_RAW, but declares also the user C handler.
> + */
> +#define DECLARE_IDTENTRY_HV(vector, func)				\
> +	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func);			\
> +	__visible noinstr void kernel_##func(struct pt_regs *regs, unsigned long error_code);	\
> +	__visible noinstr void   user_##func(struct pt_regs *regs, unsigned long error_code)
> +
>   /**
>    * DEFINE_IDTENTRY_IST - Emit code for IST entry points
>    * @func:	Function name of the entry point
> @@ -376,6 +389,26 @@ static __always_inline void __##func(struct pt_regs *regs)
>   #define DEFINE_IDTENTRY_VC_USER(func)				\
>   	DEFINE_IDTENTRY_RAW_ERRORCODE(user_##func)
>   
> +/**
> + * DEFINE_IDTENTRY_HV_KERNEL - Emit code for HV injection handler
> + *			       when raised from kernel mode
> + * @func:	Function name of the entry point
> + *
> + * Maps to DEFINE_IDTENTRY_RAW
> + */
> +#define DEFINE_IDTENTRY_HV_KERNEL(func)					\
> +	DEFINE_IDTENTRY_RAW_ERRORCODE(kernel_##func)
> +
> +/**
> + * DEFINE_IDTENTRY_HV_USER - Emit code for HV injection handler
> + *			     when raised from user mode
> + * @func:	Function name of the entry point
> + *
> + * Maps to DEFINE_IDTENTRY_RAW
> + */
> +#define DEFINE_IDTENTRY_HV_USER(func)					\
> +	DEFINE_IDTENTRY_RAW_ERRORCODE(user_##func)
> +
>   #else	/* CONFIG_X86_64 */
>   
>   /**
> @@ -465,6 +498,9 @@ __visible noinstr void func(struct pt_regs *regs,			\
>   # define DECLARE_IDTENTRY_VC(vector, func)				\
>   	idtentry_vc vector asm_##func func
>   
> +# define DECLARE_IDTENTRY_HV(vector, func)				\
> +	idtentry_hv vector asm_##func func
> +
>   #else
>   # define DECLARE_IDTENTRY_MCE(vector, func)				\
>   	DECLARE_IDTENTRY(vector, func)
> @@ -622,9 +658,10 @@ DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
>   DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP,	exc_control_protection);
>   #endif
>   
> -/* #VC */
> +/* #VC & #HV */
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   DECLARE_IDTENTRY_VC(X86_TRAP_VC,	exc_vmm_communication);
> +DECLARE_IDTENTRY_HV(X86_TRAP_HV,	exc_hv_injection);
>   #endif
>   
>   #ifdef CONFIG_XEN_PV
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index e9e2c3ba5923..0bd7dab676c5 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -29,6 +29,7 @@
>   #define	IST_INDEX_DB		2
>   #define	IST_INDEX_MCE		3
>   #define	IST_INDEX_VC		4
> +#define	IST_INDEX_HV		5
>   
>   /*
>    * Set __PAGE_OFFSET to the most negative possible address +
> diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
> index f5d2325aa0b7..c6583631cecb 100644
> --- a/arch/x86/include/asm/trapnr.h
> +++ b/arch/x86/include/asm/trapnr.h
> @@ -26,6 +26,7 @@
>   #define X86_TRAP_XF		19	/* SIMD Floating-Point Exception */
>   #define X86_TRAP_VE		20	/* Virtualization Exception */
>   #define X86_TRAP_CP		21	/* Control Protection Exception */
> +#define X86_TRAP_HV		28	/* HV injected exception in SNP restricted mode */
>   #define X86_TRAP_VC		29	/* VMM Communication Exception */
>   #define X86_TRAP_IRET		32	/* IRET Exception */
>   
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index 47ecfff2c83d..6795d3e517d6 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -16,6 +16,7 @@ asmlinkage __visible notrace
>   struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
>   void __init trap_init(void);
>   asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
> +asmlinkage __visible noinstr struct pt_regs *hv_switch_off_ist(struct pt_regs *eregs);
>   #endif
>   
>   extern bool ibt_selftest(void);
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 3e508f239098..87afa3a4c8b1 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2165,6 +2165,7 @@ static inline void tss_setup_ist(struct tss_struct *tss)
>   	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
>   	/* Only mapped when SEV-ES is active */
>   	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
> +	tss->x86_tss.ist[IST_INDEX_HV] = __this_cpu_ist_top_va(HV);
>   }
>   
>   #else /* CONFIG_X86_64 */
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index 6c5defd6569a..23aa5912c87a 100644
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -26,11 +26,14 @@ static const char * const exception_stack_names[] = {
>   		[ ESTACK_MCE	]	= "#MC",
>   		[ ESTACK_VC	]	= "#VC",
>   		[ ESTACK_VC2	]	= "#VC2",
> +		[ ESTACK_HV	]	= "#HV",
> +		[ ESTACK_HV2	]	= "#HV2",
> +		
>   };
>   
>   const char *stack_type_name(enum stack_type type)
>   {
> -	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
> +	BUILD_BUG_ON(N_EXCEPTION_STACKS != 8);
>   
>   	if (type == STACK_TYPE_TASK)
>   		return "TASK";
> @@ -89,6 +92,8 @@ struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
>   	EPAGERANGE(MCE),
>   	EPAGERANGE(VC),
>   	EPAGERANGE(VC2),
> +	EPAGERANGE(HV),
> +	EPAGERANGE(HV2),
>   };
>   
>   static __always_inline bool in_exception_stack(unsigned long *stack, struct stack_info *info)
> @@ -98,7 +103,7 @@ static __always_inline bool in_exception_stack(unsigned long *stack, struct stac
>   	struct pt_regs *regs;
>   	unsigned int k;
>   
> -	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
> +	BUILD_BUG_ON(N_EXCEPTION_STACKS != 8);
>   
>   	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
>   	/*
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index a58c6bc1cd68..48c0a7e1dbcb 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -113,6 +113,7 @@ static const __initconst struct idt_data def_idts[] = {
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   	ISTG(X86_TRAP_VC,		asm_exc_vmm_communication, IST_INDEX_VC),
> +	ISTG(X86_TRAP_HV,		asm_exc_hv_injection, IST_INDEX_HV),
>   #endif
>   
>   	SYSG(X86_TRAP_OF,		asm_exc_overflow),
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index a428c62330d3..63ddb043d16d 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2004,6 +2004,65 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
>   	irqentry_exit_to_user_mode(regs);
>   }
>   
> +static bool hv_raw_handle_exception(struct pt_regs *regs)
> +{
> +	return false;
> +}
> +
> +static __always_inline bool on_hv_fallback_stack(struct pt_regs *regs)
> +{
> +	unsigned long sp = (unsigned long)regs;
> +
> +	return (sp >= __this_cpu_ist_bottom_va(HV2) && sp < __this_cpu_ist_top_va(HV2));
> +}
> +
> +DEFINE_IDTENTRY_HV_USER(exc_hv_injection)
> +{
> +	irqentry_enter_from_user_mode(regs);
> +	instrumentation_begin();
> +
> +	if (!hv_raw_handle_exception(regs)) {
> +		/*
> +		 * Do not kill the machine if user-space triggered the
> +		 * exception. Send SIGBUS instead and let user-space deal
> +		 * with it.
> +		 */
> +		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
> +	}
> +
> +	instrumentation_end();
> +	irqentry_exit_to_user_mode(regs);
> +}
> +
> +DEFINE_IDTENTRY_HV_KERNEL(exc_hv_injection)
> +{
> +	irqentry_state_t irq_state;
> +
> +	if (unlikely(on_hv_fallback_stack(regs))) {
> +	        instrumentation_begin();
> +	        panic("Can't handle #HV exception from unsupported context\n");
> +	        instrumentation_end();
> +	}

HV fallback stack exists and is used if we couldn't switch to HV stack. 
If we have to issue a panic() here, why don't we simply issue the 
panic() in hv_switch_off_ist(), when we couldn't switch to HV stack ?

Thanks,
Ashish

> +
> +	irq_state = irqentry_nmi_enter(regs);
> +	instrumentation_begin();
> +
> +	if (!hv_raw_handle_exception(regs)) {
> +		pr_emerg("PANIC: Unhandled #HV exception in kernel space\n");
> +	
> +		/* Show some debug info */
> +		show_regs(regs);
> +	
> +		/* Ask hypervisor to sev_es_terminate */
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
> +	
> +		panic("Returned from Terminate-Request to Hypervisor\n");
> +	}
> +
> +	instrumentation_end();
> +	irqentry_nmi_exit(regs, irq_state);
> +}
> +
>   bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>   {
>   	unsigned long exit_code = regs->orig_ax;
> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index 6c2f1b76a0b6..608905dc6704 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -115,6 +115,8 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
>   		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
>   			cea_map_stack(VC);
>   			cea_map_stack(VC2);
> +			cea_map_stack(HV);
> +			cea_map_stack(HV2);			
>   		}
>   	}
>   }
> 
