Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24B56B235F
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 12:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCILtH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 06:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCILtF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 06:49:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267975F50A;
        Thu,  9 Mar 2023 03:49:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAqc71EQu/r99TSAP+K26QXaq03tUgtSskUpNp8ftFWxeXc0xj/s7IlzCkA7mvDQfU9CsdDnRFR6/gE8SyOMoR+oh7cTogZHQ3LeB+shJCTSUBJbsemClHxsxIZjTgaZI7n/kSpzUMzd0RomO260T5rGhNG/za4PHRiyklkTcw9ncr7tpttUpCNi+KDOFjk5pfYGdRkKwpKdwZDIwgtYBDqM+7SqJWj4gfInVux/RhAsmJwvB3kNMxSewWY+1nWWbwuH09NikhjZjLgD97f/W3h3yC7NdhaDWkvUuijEbhYPY/8CgUomWrFryrTnTlExLBTb3nuY/hRgpJmPWrFXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShpW/gHxseuNtFpFnjVniU75viiPW78uyFtHynOxTFg=;
 b=jh+cmAKwOktcLwrxHPvKWDGSnBQ8dJNYjVZcuvjpqQ7QiNdI2o6KheeaZB5Ec62++/mMwXyJrBAk+07idhWB+GLtQ1qZ7z5yoI6lISTegKe4HsC5BcE/tdn63FeKTNMijJoFRMKxnYAikJZdYllOsSYdw6vxf5WI4FCHF8tskoPVJQHuUQ5Q7dWOKzpqse+LjYqQESyFakioh6IySNnvgRoz04jpPOvmGQIBuem85NfTV2JwaFlrvX9dbqTIJeTLlsn009O631TdcZ4/aSqCw5+dnM8zua1U9VzRDeVq0YhCtWeMXHvpFChlMWzME6+vylbm9md9anADZG7FwpynbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShpW/gHxseuNtFpFnjVniU75viiPW78uyFtHynOxTFg=;
 b=n9cT5C8bf0rq2wFtW3v7eSJWHX+yMroQMOle0W531wlOKxIJ0Smofv4IeDRyyP3smqcaeqEuSWcnASND1uQyjERsqgDAiYMylZ4g0KYa7PWbhxbb4fYp03wefJrm5Vtq5oBX/r9ahR2bpHFF0lfujWA4FvJVkKwGSjxZXUPffTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Thu, 9 Mar 2023 11:49:00 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 11:49:00 +0000
Message-ID: <a25a21f9-0059-3e39-4284-7c4164d170ed@amd.com>
Date:   Thu, 9 Mar 2023 12:48:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 12/16] x86/sev: Add a #HV exception handler
Content-Language: en-US
To:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-13-ltykernel@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230122024607.788454-13-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: fd81b0c6-3eec-47f9-eb2e-08db2094455e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6b3Bzt/6+cxcW9jFwrM9ebLcmrbr2SQaz9kp7rq4SZcaIBuSXoPK436wQKABZHR6kuM5oHTBYyUruHiDrDq4r1Tdt7NtgP5pq9QJ+hIsQ/cOjng3wBBzR5lZOaTz/5Wz4G6Qdaa7zGvt2FlNS5vN1QNe2Ucmrv0txl5x3fT43qHvRHzjNLibsGZyeMprdYPpYN2aT+NuhF6Rqx0UadZ3ZILrcCystwa8QRIgxu0rj3tQV4dMCpBBVuZ4NmswMzoC6wpsECwKZeNmIJX/S6voqoGAi+Hgaa9aiN47Ve7x6zT7anMx/Md0ZSoVOXE3NS/+YXcItMIN+9wnYvOV5LQJ+njpbhshCtHLg9ePSy10EAvaYcpndaNIneDKTAsWHNZDbRdGnjXqmof2sXtjvuGhRC+VBdZhefToAcONskP8s4Sqndmez58waKqd1+PbgpxjUIzUkiTWrkd+HHCBf57elCkI2cJ2/1HP06aoB3VBdPBKLCMUfA+noo2SyJ4ygK8mUMzyo3hn1Zxg4zTzW6yhj3dZO2LiYzChRmZwx/4KKtTUqa8WIL6Tr8BMgReVm/XbjRUQEHBJxb+CIrzYMH0JH4+NObct6aauYesWG5Q0pWCsN5Erkid32N9uXKYOPa+tjzle+f1eM/VTOh64I3tv8oDiqA78TPi5Oi/SGSz7ujvutb/P1AgyW010bol6A5/4eMvZ6WIAiGGvWfrUyQz9HhovilsNmr7HoRIHTys6QK1XLfHg2vCCiVxllcK0n0T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199018)(186003)(38100700002)(921005)(4326008)(5660300002)(7406005)(30864003)(6666004)(66556008)(2906002)(478600001)(66476007)(26005)(41300700001)(53546011)(45080400002)(66946007)(8676002)(8936002)(6506007)(2616005)(7416002)(6512007)(36756003)(316002)(66899018)(86362001)(31696002)(83380400001)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0JMZmRPRTZiR0gvM3FHSmdsMFYxU3N1SndLMyszajhCL1hiekpHRk1QTWJz?=
 =?utf-8?B?RnF4MDYvVmtQcVdaclc4bEdEdjZYcEdzc0QrakZKTTFXV1gzWjc2THNqZUhh?=
 =?utf-8?B?TGFXV0hOL0lmWjdreEM4RHgxaEMwSjU2WGdhQ0dwcitTSEtiQzA1RStSUFpt?=
 =?utf-8?B?a0Q0eUZnUk9vcWlPdGhXKzZpakNnbk5kdGY1eVFHY0NKbDdNb05MTkIxVU1h?=
 =?utf-8?B?MjVOQnBFcDNmSHNKVm50emRuOHlVS0libzNDUTd1Ri9PYlp2SVlNT29qMGpJ?=
 =?utf-8?B?YWJCQlNJVGR4NWg5WlN0V25zUWJaM01mZnM5VmVEM2hXbTZFdjhMT25QbXBo?=
 =?utf-8?B?enE3MllsN01UMVlpT2twTWxCVHNZRHJBR0lLYWNoNklNOURBWW5JM09JQzh4?=
 =?utf-8?B?ZzhidFk4Z1Ztc1dqNkIrMFlsdXRFYjVhQmJYT3l6dE1QQisva0V1Y2JWMnpv?=
 =?utf-8?B?bURNRWNkSndIVEhzY1oxbjM2ejc0WmpQZ3d2eUxabHJDcGZieW9GVy90UE9C?=
 =?utf-8?B?WFJPVnAzVUlmQ0o4N1N0UzYzbDVJdHEvOEplbTRWazhUNTdNL0tYRzVyVW1n?=
 =?utf-8?B?dEZYT3FyNjBqbTcwWkwzWkxnUW1DS204Nk03ZGFudEgwZUxzcTlSS2g3V1Rr?=
 =?utf-8?B?NVVjUXpLOUxZbVpiLzBhZFluTnkzaEFING5xN2xEdCtYek9WdWV6dkxXc2k1?=
 =?utf-8?B?Zm5ZUGIyK3c5ZWV5QXlTT09WeXY0bitQWElrNmFlejNaczJudlhVa0xXYWRn?=
 =?utf-8?B?TDY0Q0Q4MG1iUnFycE1GbGVpRVpSOGM3U2FVOTBrSEVidkhpZ1pCVGZZWVMx?=
 =?utf-8?B?U01tWXUzRXVGL0M0d3grdnlRUkY0WTRkVXptRzltY0ptZXZRRE1XbnJXNjhL?=
 =?utf-8?B?Kys4M2g1bWJSbEhhMENFdGhnWHIzVVVRV3RBMC9NTlBNN2lTVFhuaG5RWkR4?=
 =?utf-8?B?cE1JeU5vKzVCb052L0lNdlVrTmZLK3dFYjhyM3FvdXNmcSt5VWxHUHZwWjVr?=
 =?utf-8?B?dERaOUgzM3pCMmcwallsSlRvU0lCL2c4amZwVE9aVXFJVG5KT3U1MkVpajh6?=
 =?utf-8?B?OUQvNERuR2V1eWxuYXcwZDFaQTFNbnVFMWo3ZzJCeGI2TkVsVHNaWHpTM3VS?=
 =?utf-8?B?aktibkpBdnlmRjlyWHgxeHJWK2ZlTW96SEpkdUpjQmN4ODQrcUpJcWxPZUVN?=
 =?utf-8?B?SEVxVUhpdEhSN253WmcrL3VPL1FwNTZjeFF4RDVydHpBS1hXaUJ1UDk0WUhk?=
 =?utf-8?B?a1F3eXpKVEttVmFoRjc4MXR0di9VdjRUczZ0ZjBzcUs1dW5KQmRoVFpGYU9N?=
 =?utf-8?B?ZXE5ZSsrZEppcjlEZ0RBSGhJQWFsb3lmRHZZVTRkYVFZQjIydXQ3RkY2TDZ0?=
 =?utf-8?B?OUFHc1RqZFdIU2xGckhVSDZrL0RaL2F5c0Nna3ZFMTZCR3FHa2ZhVGd6VWhW?=
 =?utf-8?B?Vmp4NmdqMmJ6NlcvYTZicG5hMVorOGUxZmQvalBncHFEZ0NUcVZ2anZ3ZVhQ?=
 =?utf-8?B?cXR3QStXcFZqdG9LRlkzc2J3cTVVYy9DOHU4NzhLSzFhSGpYNWJRRTBXL285?=
 =?utf-8?B?Ky9MMzFnYlFwSmVJT0M3K0lpeGtIVG1EWElVV3BhUDc0WFFDYTRydWx0emtG?=
 =?utf-8?B?YTA1cmpVKzNucWVGZ0xIZ2EwbEhON0RUekdaTHo1Sks0ZHl1U1VHTXYxODZ5?=
 =?utf-8?B?U3YvVm5ZYXgrTkFORFVjRk1oOFdycWo4VEpRdG9EejRYNFRHRnFRbE1odlBG?=
 =?utf-8?B?Wk54YkVzK2d1eWpnSHVaL0dkZWZLakV0c28wdFg4SWlUQ2tDbTYyN2JuSXJw?=
 =?utf-8?B?V3VLRGVQaUpQakx3cXAvUko0KzNvQXBmdzNMQWYwWXllTmJudmRBWHoxc3Za?=
 =?utf-8?B?NDNSUXVSUEkzMGlXS2puY2MzVkxhblNTKzM3aEl4NUFiMWNlNXYyVGhOWGpB?=
 =?utf-8?B?ZWZjeGdOWUpSd0xzVFA5a01JellFeXNxU1MzOUxPN1MyUmZ1ZVNSdzJzeXpQ?=
 =?utf-8?B?L0xWQmdaSnNlY0E2Z0ZhdjI4d2ZHejFzOTVkemJBWFdBdGRQdUZ0UmhVck12?=
 =?utf-8?B?N3BCSlBGS3pqcTFERWZJYmFFamtwR2w0Rklaam51ZVl4L1lPYlFtODZxYW1j?=
 =?utf-8?Q?yA5TFUwklGtvTESjY2TFzPPRv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd81b0c6-3eec-47f9-eb2e-08db2094455e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 11:48:59.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0aepwaLJhVQdJQMTRpChx2eBYBHNCz9lvEeURba0jiZKcJ15BEaHNjM9i+QmM/ZU6hfEnsrCmMX9eKLkCjCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/22/2023 3:46 AM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Add a #HV exception handler that uses IST stack.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V2:
>         * Remove unnecessary line in the change log.
> ---
>   arch/x86/entry/entry_64.S             | 58 +++++++++++++++++++++++++++
>   arch/x86/include/asm/cpu_entry_area.h |  6 +++
>   arch/x86/include/asm/idtentry.h       | 39 +++++++++++++++++-
>   arch/x86/include/asm/page_64_types.h  |  1 +
>   arch/x86/include/asm/trapnr.h         |  1 +
>   arch/x86/include/asm/traps.h          |  1 +
>   arch/x86/kernel/cpu/common.c          |  1 +
>   arch/x86/kernel/dumpstack_64.c        |  9 ++++-
>   arch/x86/kernel/idt.c                 |  1 +
>   arch/x86/kernel/sev.c                 | 53 ++++++++++++++++++++++++
>   arch/x86/kernel/traps.c               | 40 ++++++++++++++++++
>   arch/x86/mm/cpu_entry_area.c          |  2 +
>   12 files changed, 209 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 15739a2c0983..6baec7653f19 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -563,6 +563,64 @@ SYM_CODE_START(\asmsym)
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

We need "ENCODE_FRAME_POINTER" similar to "vc_switch_off_ist" here as we 
are switching stack?

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
> +
>   _ASM_NOKPROBE(\asmsym)
>   SYM_CODE_END(\asmsym)
>   .endm
> diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
> index 462fc34f1317..2186ed601b4a 100644
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
> index 72184b0b2219..652fea10d377 100644
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
> +	__visible noinstr void kernel_##func(struct pt_regs *regs);	\
> +	__visible noinstr void   user_##func(struct pt_regs *regs)
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
> +	DEFINE_IDTENTRY_RAW(kernel_##func)
> +
> +/**
> + * DEFINE_IDTENTRY_HV_USER - Emit code for HV injection handler
> + *			     when raised from user mode
> + * @func:	Function name of the entry point
> + *
> + * Maps to DEFINE_IDTENTRY_RAW
> + */
> +#define DEFINE_IDTENTRY_HV_USER(func)					\
> +	DEFINE_IDTENTRY_RAW(user_##func)
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
> index 9cfca3d7d0e2..e48a489777ec 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2162,6 +2162,7 @@ static inline void tss_setup_ist(struct tss_struct *tss)
>   	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
>   	/* Only mapped when SEV-ES is active */
>   	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
> +	tss->x86_tss.ist[IST_INDEX_HV] = __this_cpu_ist_top_va(HV);
>   }
>   
>   #else /* CONFIG_X86_64 */
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index f05339fee778..6d8f8864810c 100644
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
> index 679026a640ef..a8862a2eff67 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2004,6 +2004,59 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
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
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index d317dc3d06a3..d29debec8134 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -905,6 +905,46 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
>   
>   	return regs_ret;
>   }
> +
> +asmlinkage __visible noinstr struct pt_regs *hv_switch_off_ist(struct pt_regs *regs)
> +{
> +	unsigned long sp, *stack;
> +	struct stack_info info;
> +	struct pt_regs *regs_ret;
> +
> +	/*
> +	 * In the SYSCALL entry path the RSP value comes from user-space - don't
> +	 * trust it and switch to the current kernel stack
> +	 */
> +	if (ip_within_syscall_gap(regs)) {
> +		sp = this_cpu_read(pcpu_hot.top_of_stack);
> +		goto sync;
> +	}
> +
> +	/*
> +	 * From here on the RSP value is trusted. Now check whether entry
> +	 * happened from a safe stack. Not safe are the entry or unknown stacks,
> +	 * use the fall-back stack instead in this case.
> +	 */
> +	sp    = regs->sp;
> +	stack = (unsigned long *)sp;
> +
> +	if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
> +	    info.type > STACK_TYPE_EXCEPTION_LAST)
> +		sp = __this_cpu_ist_top_va(HV2);
> +sync:
> +	/*
> +	 * Found a safe stack - switch to it as if the entry didn't happen via
> +	 * IST stack. The code below only copies pt_regs, the real switch happens
> +	 * in assembly code.
> +	 */
> +	sp = ALIGN_DOWN(sp, 8) - sizeof(*regs_ret);
> +
> +	regs_ret = (struct pt_regs *)sp;
> +	*regs_ret = *regs;
> +
> +	return regs_ret;
> +}
>   #endif
>   
>   asmlinkage __visible noinstr struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index 7316a8224259..3ec844cef652 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -153,6 +153,8 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
>   		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
>   			cea_map_stack(VC);
>   			cea_map_stack(VC2);
> +			cea_map_stack(HV);
> +			cea_map_stack(HV2);
>   		}
>   	}
>   }

