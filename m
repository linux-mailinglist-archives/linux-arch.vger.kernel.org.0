Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5738A624D22
	for <lists+linux-arch@lfdr.de>; Thu, 10 Nov 2022 22:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiKJVgq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Nov 2022 16:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiKJVgo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Nov 2022 16:36:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1780F1144A;
        Thu, 10 Nov 2022 13:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd6Qyc4BbNEMCSkLkHwZRfLbpmEjfZKmjqMEGskFYpDQie93Jnf+0yZeNnt0dXcyx59rZ81paaA6ZwT3Fzo8sJ0/88hQsIs/e8w95iNRiRQxljlGtlD3l0n89L3N90V0S2A973gWJotrdjg2YdZYh8ysq1V1ckTptQljgu8I+fYPmkQReYD8hUXA1HV9C8BrqBbV9KX2WIujQCeitywON2wj7dMu8KqMeZ6u+kPSqk7ozy8qkFkH6JXSp3bntSUu/NHvXrs7WtsfMUS8v6wLt6yBiKgEo75rmxvjwvc6bx/Tebe2yQSLgNk3fUmJhkieHtgjt+l/bKt1moKZsOgxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRHSJtqdtIkidb10ph1kX+8hooW+ZAbiaPFgXsewo18=;
 b=U2563Nlr0E52TVdQoOQdFyXSBnJV6CyW4kbZwGpV1sYgF4w5wrwnE8ZKt6vgMDntGTH+Ec08BfW/UKBkKCelAfaVfrdH32hyGLX2yIzSwAvxBWrTzEdjMpQwxzldnybXMx081+97XTQj1TM4WtLd1bYYpZKMqkkxP5VQJkRqUBjq0D5KIPeI7O3JOEyfkgHKQXnh4Zue4vBXkosx5guD8zhwtPFtoYxXKYDe6FZsklW3MB6CVgk9CZWEd178cqMHOZLWix4Rrs9Ygs3/IVboI1BG5TcC0J73S1Riyn3TJYQYnJL+xPoCVYJ6oAwdkgnlQ5mIsOHh/fecNqsBUN6vBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRHSJtqdtIkidb10ph1kX+8hooW+ZAbiaPFgXsewo18=;
 b=kSFsIo3qJProP8xgi+zclV68SS4jBW9STVr05yzK1FwTGI69BKVDJb0NkwVDMPPtB7jV4O1AMkPAihCoX0aMwch7v4N7jgW+DwkNwlwxzqQwkxsl19buudE8YS0GdrCK/V5qXQkfc8GkoVKRdvoUhhFG3puLgCeo0j3Zm5ynBPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 21:36:39 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::36e7:b51d:639e:ed6c]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::36e7:b51d:639e:ed6c%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 21:36:39 +0000
Message-ID: <ee86cb73-2d75-da41-2638-6d56cb89d730@amd.com>
Date:   Thu, 10 Nov 2022 15:36:33 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH 17/17] x86/sev: Initialize #HV doorbell and handle
 interrupt requests
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
 <20221109205353.984745-18-ltykernel@gmail.com>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20221109205353.984745-18-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:610:53::32) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: e589c9c3-9bb4-4a06-c0ae-08dac363a6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ihlkk7fhVQPlBwDjuWHN4KAi0FKhDtgdby88rTwXocIs09rbkQ/a/i/Eo2zUid6GER1wvkwC9cZ9nlLzm977lrHHTBeYRt8pu3GgdXQ4dBDSIRehmyaMjyCagftIHRhlAk5Otn02a1LMkIPriWF4e6yFqKUkEvaS6zxEn0Xp9mLM4W/lv0SaEC2YiF8qcFxt9qvcoJx+V3ZdY1lipVLhhjunleFZzNnkJCxbK9PcoHwzNMDQf/enBV1EX5DrmcvphXXwNEuVQesh5oEk3vBy5PKAzuuP7A+uKw9JyTpMsPpCwTge9ulm6wnhdlcnf/6sZ5egdX4c3dmxxHMmWj4+vLELJLGtvDIMsb7LVxZwthQPBlNRGawi134Up63us7/35Vuw52Lt7LMz+BmB9fY+yBVYTORg32peGO1ZZsnSHc18cc826hGnR8k2M6FJlwE25uXLlTXjup37nIqVh4+OgImjRaWo2egzdvTqQuraV+BErNlzI7e68WazfJKnFOazuLia+bNfl3ZeMNwvwX9gKmu5HLmfKxhE6XCkMA2AsX70ZY4Al5iAypea6cqnar87PxU4rgxZBOQwH6/x2pzmPxUfQz31CtLdo3jOj0IWxT5Sjmr39KiGgxytzOeO5LcofVxrzWw5Qz1etQAP+fPCvdXf/ACK0dFNsbXgSZCHwsfnQQ5BhymbvhMwjbXcxo4c19AuBHnv/FAYhu3ptsGRj97APxrGiYc/Z3LQgcBV1L0uOAdFEXMCaNnDIK41IDNW8oW80a9yUyMUMdP8JU50TqQATUQQuV3oCgJF545NMjE3j1c0ra5lb4OtRtXcTWh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(31686004)(36756003)(86362001)(38100700002)(478600001)(921005)(6486002)(31696002)(83380400001)(5660300002)(41300700001)(6666004)(7406005)(186003)(6506007)(26005)(4326008)(2906002)(66946007)(53546011)(6512007)(8676002)(8936002)(30864003)(66476007)(316002)(66556008)(45080400002)(2616005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlGOVlOQ3hDR2ppb0Zsc0pqSi9Jbzk3RzZxTm8rRlhqMXNqR1JQV2NFTlRr?=
 =?utf-8?B?SFdmaXl4WExtR2lSTlBpQkYyaWNqQWRod290YlY2dzdMN25xNENhSnI3cDdO?=
 =?utf-8?B?SU0xM1dYcUlhL05FU29lMEJDSXFZQU1uNW5tMHBja0RrRDYzK0hpMEVNV3Qw?=
 =?utf-8?B?Q2xLdk91QmxXSmp2WW5ZdUlob0RnRDdzLzlWdEJjWjV6UEROZmw4Rk1GQ0FO?=
 =?utf-8?B?c1ljS0tIc0haMk9IYy9RWnhoZDY5WnZYa3k0Y2FQMUluZW8raU9CVVNuZDhN?=
 =?utf-8?B?T1A4RUVrcWtrNWdVenpFMm1xbWRyZWxJM1ZBdUJ1ckFMcFY1d2JjbFJzN3Jh?=
 =?utf-8?B?TDZuZmNQcmdWMzVkMzJsOURLbWhmK2RVOUtRbEJaL3QzaDlGdnl1VHJ0d3RG?=
 =?utf-8?B?N0E5aXpXbVJra2dGaXpnaGdBZkJLR3kvQjJ0WDJRTmtRekxPVlhROVdPZ2da?=
 =?utf-8?B?NlBLSmxIc2U5T2tQZ0dXdVRwdTY3TGhKa0h3MkNXY0VBZ1RKYjdxaWRDQ2dW?=
 =?utf-8?B?cG9nVXhLRlZReE84ak5IK3U5UFNqUmFiN2h4QURyWWpuYVlJaHNLRWFQMUdt?=
 =?utf-8?B?RGFXZDdMdjJ3SnR0ekRQSTB5THF0SmZUYjcxd0k5SWZlMjF2VWRpWGJKdUli?=
 =?utf-8?B?OXF2OE8xVUxYWnJvSGV2OVRYUlN4VG83MHRYN3BwazFZdlpnd1R1TlBXeUFS?=
 =?utf-8?B?b2hPOThuWmNJd1hxSi9jRHVseFJEZkl3TnJ3NlVlRUZCSjBDbzMzUzA3a0FY?=
 =?utf-8?B?SFBTejB1ek1ES3llZkRKbGNOVVRVSHlvOStmLzBsRGlsYmRPUnJCbWdwbjZv?=
 =?utf-8?B?YlNPaERsSS9BU2JkWVFrY25JWDB4RENxNDZGOFpsbzcrTVhiV0k1OUJLTHZF?=
 =?utf-8?B?WmVGMU1EZUJqc01ybzlOa21aOEhwQ3BGZW5qc0xpbDhLSmhPNFJCR3V4bWk2?=
 =?utf-8?B?U2t6U3dXNDhxNFIxcUJNbWJkSEkyeVJJVHhTZXplS1REUVdWSmVKSW1UOS9G?=
 =?utf-8?B?RE1Bd3ZJRDFJVnJPbkM2WVhJTzJveEhIV043NHNySWRpUTlkVTlJUDhqMFJ2?=
 =?utf-8?B?UTVpRU92MG9IWFAxMnkxS3hudVF0T2lMempsd05aQURBL1U0K1VGVFpyR3Nu?=
 =?utf-8?B?WnlCNmNFN1RPZVMzYjN6c043WXZOSUpjMlZ5RGV6dWNWNFN5WndZVmxNeGw2?=
 =?utf-8?B?Mm53WFpBcUQxUXBTSFVnS1dZWG1NU0YvOG9heTFMUmVLMVJnRjhFY1laL3pC?=
 =?utf-8?B?ZysrZGZPSVNpZHVGZG5FRTB5UUNpdGtsVFlad0VKbDVpeFFHWmJpRVVOLzJU?=
 =?utf-8?B?SVIzZVo4am5pT3dTMXJ1dC9xaHNzZjZoM3F1Wm5EZ0c1Vzh3UnJCaDVHUWxZ?=
 =?utf-8?B?ZURCcGJ4QmZncnVMZUN1bVZHWVk5R2pRZGdtS3gxSXNxTW44UnpBVHlNY2xN?=
 =?utf-8?B?d0ZlUVZwVE9EQXB6dHRUU2Q4S2tkT3Z0azIrNUpXbDBuVmhDVERlMUdhZW5T?=
 =?utf-8?B?WEpJei93L2tmeWk0dkNLemhBY0p1NjdmeHJKWHNXRTVBSXZZK3NmWDAwUkZr?=
 =?utf-8?B?MWZ3eWEyNldVdWpodFc3OUNBSzdhdXpPalNpbFR6NGxOREIvSk1jVk05VzAr?=
 =?utf-8?B?OUcrUzhpVjU4L1daejNiN0J5SzJTNG82anVWQmZRSzlXK01paW13bC9KeUJL?=
 =?utf-8?B?cy8wV0k3bU9Eemcwc21NSjVxUkFXcDZXcDg5bjhZT2trUkZESTV1L0UrSkVi?=
 =?utf-8?B?cWdLNUozTW5qWGswNFg5clk2Y0Z0YldDUkpFNVRQK1d6STd4dENNbjlSVTRs?=
 =?utf-8?B?TSswaDFtZ1ZMZzRoRDNERUdQbXBrNURLWUhpaEZkQWJaQVpUNmN2R2g3djh1?=
 =?utf-8?B?LzNQYXBUcWM1RHhBanlEUk1NMHQzNE04UU4yR3NOaStNdzdSVzA1R1ZnZ0Jj?=
 =?utf-8?B?K2FqOTRrWjJ6NXk1NTZBN3dnNmhRWmd1cXBTNTRzQ3hEaEpIc200SmhScVZT?=
 =?utf-8?B?ZkJoQjFObnBqUzNzQm1RaXZDZWd3L2U2S2NYTFYybkJpeVZlZU5ZY1JIeXZY?=
 =?utf-8?B?dU5nS292N28xWm1rS2RBZjF5azVXUFNFZjJIWGdpNitLU0tWTmhibmpNbnIy?=
 =?utf-8?Q?VdNUIr/ZqRLEhjuytWK4lAUts?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e589c9c3-9bb4-4a06-c0ae-08dac363a6cd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 21:36:39.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku+ZNurgkH4VokkLFatk/l+N6zksVrR5A4CDpuyQoPbcxIthrCXXkY1HZkTOx4ztB2xpFsmRXcdyZ+L1sbIsuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
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
> Enable #HV exception to handle interrupt requests from hypervisor.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/entry/entry_64.S          |  18 ++
>   arch/x86/include/asm/irqflags.h    |  19 ++
>   arch/x86/include/asm/mem_encrypt.h |   2 +
>   arch/x86/include/asm/msr-index.h   |   6 +
>   arch/x86/include/uapi/asm/svm.h    |   4 +
>   arch/x86/kernel/sev.c              | 327 ++++++++++++++++++++++++-----
>   arch/x86/kernel/traps.c            |  50 +++++
>   7 files changed, 373 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index b2059df43c57..fe460cf44ab5 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1058,6 +1058,15 @@ SYM_CODE_END(paranoid_entry)
>    * R15 - old SPEC_CTRL
>    */
>   SYM_CODE_START_LOCAL(paranoid_exit)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * If a #HV was delivered during execution and interrupts were
> +	 * disabled, then check if it can be handled before the iret
> +	 * (which may re-enable interrupts).
> +	 */
> +	mov     %rsp, %rdi
> +	call    check_hv_pending
> +#endif
>   	UNWIND_HINT_REGS
>   
>   	/*
> @@ -1183,6 +1192,15 @@ SYM_CODE_START_LOCAL(error_entry)
>   SYM_CODE_END(error_entry)
>   
>   SYM_CODE_START_LOCAL(error_return)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * If a #HV was delivered during execution and interrupts were
> +	 * disabled, then check if it can be handled before the iret
> +	 * (which may re-enable interrupts).
> +	 */
> +	mov     %rsp, %rdi
> +	call    check_hv_pending
> +#endif
>   	UNWIND_HINT_REGS
>   	DEBUG_ENTRY_ASSERT_IRQS_OFF
>   	testb	$3, CS(%rsp)
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 7793e52d6237..e0730d8bc0ac 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -14,6 +14,9 @@
>   /*
>    * Interrupt control:
>    */
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +void check_hv_pending(struct pt_regs *regs);
> +#endif
>   
>   /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
>   extern inline unsigned long native_save_fl(void);
> @@ -35,6 +38,19 @@ extern __always_inline unsigned long native_save_fl(void)
>   	return flags;
>   }
>   
> +extern inline void native_restore_fl(unsigned long flags)
> +{
> +	asm volatile("push %0 ; popf"
> +		     : /* no output */
> +		     : "g" (flags)
> +		     : "memory", "cc");
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	if ((flags & X86_EFLAGS_IF)) {
> +		check_hv_pending(NULL);
> +	}
> +#endif
> +}
> +
>   static __always_inline void native_irq_disable(void)
>   {
>   	asm volatile("cli": : :"memory");
> @@ -43,6 +59,9 @@ static __always_inline void native_irq_disable(void)
>   static __always_inline void native_irq_enable(void)
>   {
>   	asm volatile("sti": : :"memory");
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	check_hv_pending(NULL);
> +#endif
>   }
>   
>   static inline __cpuidle void native_safe_halt(void)

Are these checks required for native_safe_halt() too ?

> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 72ca90552b6a..7264ca5f5b2d 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -50,6 +50,7 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
>   void __init mem_encrypt_free_decrypted_mem(void);
>   
>   void __init sev_es_init_vc_handling(void);
> +void __init sev_snp_init_hv_handling(void);
>   
>   #define __bss_decrypted __section(".bss..decrypted")
>   
> @@ -72,6 +73,7 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
>   static inline void __init sme_enable(struct boot_params *bp) { }
>   
>   static inline void sev_es_init_vc_handling(void) { }
> +static inline void sev_snp_init_hv_handling(void) { }
>   
>   static inline int __init
>   early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 10ac52705892..6fe25a6e325f 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -562,10 +562,16 @@
>   #define MSR_AMD64_SEV_ENABLED_BIT	0
>   #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
>   #define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
> +#define MSR_AMD64_SEV_REFLECTVC_ENABLED_BIT		4
> +#define MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED_BIT	5
> +#define MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED_BIT	6
>   #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
>   #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
>   #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
>   
> +#define MSR_AMD64_SEV_REFLECTVC_ENABLED			BIT_ULL(MSR_AMD64_SEV_REFLECTVC_ENABLED_BIT)
> +#define MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED	BIT_ULL(MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED_BIT)
> +#define MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED	BIT_ULL(MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED_BIT)
>   #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>   
>   /* AMD Collaborative Processor Performance Control MSRs */
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index f69c168391aa..85d6882262e7 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -115,6 +115,10 @@
>   #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
>   #define SVM_VMGEXIT_AP_CREATE			1
>   #define SVM_VMGEXIT_AP_DESTROY			2
> +#define SVM_VMGEXIT_HV_DOORBELL_PAGE		0x80000014
> +#define SVM_VMGEXIT_GET_PREFERRED_HV_DOORBELL_PAGE	0
> +#define SVM_VMGEXIT_SET_HV_DOORBELL_PAGE		1
> +#define SVM_VMGEXIT_QUERY_HV_DOORBELL_PAGE		2
>   #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
>   #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
>   
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 63ddb043d16d..65eb9f96d0c4 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -104,6 +104,12 @@ struct sev_es_runtime_data {
>   	 * is currently unsupported in SEV-ES guests.
>   	 */
>   	unsigned long dr7;
> +	/*
> +	 * SEV-SNP requires that the GHCB must be registered before using it.
> +	 * The flag below will indicate whether the GHCB is registered, if its
> +	 * not registered then sev_es_get_ghcb() will perform the registration.
> +	 */
> +	bool ghcb_registered;
>   };
>   
>   struct ghcb_state {
> @@ -122,6 +128,156 @@ struct sev_config {
>   
>   static struct sev_config sev_cfg __read_mostly;
>   
> +static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state);
> +static noinstr void __sev_put_ghcb(struct ghcb_state *state);
> +static int vmgexit_hv_doorbell_page(struct ghcb *ghcb, u64 op, u64 pa);
> +static void sev_snp_setup_hv_doorbell_page(struct ghcb *ghcb);
> +
> +struct sev_hv_doorbell_page {
> +	union {
> +		u16 pending_events;
> +		struct {
> +			u8 vector;
> +			u8 nmi : 1;
> +			u8 mc : 1;
> +			u8 reserved1 : 5;
> +			u8 no_further_signal : 1;
> +		};
> +	};
> +	u8 no_eoi_required;
> +	u8 reserved2[61];
> +	u8 padding[4032];
> +};
> +
> +struct sev_snp_runtime_data {
> +	struct sev_hv_doorbell_page hv_doorbell_page;
> +};
> +
> +static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
> +
> +static inline u64 sev_es_rd_ghcb_msr(void)
> +{
> +	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
> +}
> +
> +static __always_inline void sev_es_wr_ghcb_msr(u64 val)
> +{
> +	u32 low, high;
> +
> +	low  = (u32)(val);
> +	high = (u32)(val >> 32);
> +
> +	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
> +}
> +
> +struct sev_hv_doorbell_page *sev_snp_current_doorbell_page(void)
> +{
> +	return &this_cpu_read(snp_runtime_data)->hv_doorbell_page;
> +}
> +
> +static u8 sev_hv_pending(void)
> +{
> +	return sev_snp_current_doorbell_page()->vector;
> +}
> +
> +static void hv_doorbell_apic_eoi_write(u32 reg, u32 val)
> +{
> +	if (xchg(&sev_snp_current_doorbell_page()->no_eoi_required, 0) & 0x1)
> +		return;
> +
> +	BUG_ON(reg != APIC_EOI);
> +	apic->write(reg, val);
> +}
> +
> +static void do_exc_hv(struct pt_regs *regs)
> +{
> +	u8 vector;
> +
> +	while (sev_hv_pending()) {
> +		asm volatile("cli" : : : "memory");
> +
> +		vector = xchg(&sev_snp_current_doorbell_page()->vector, 0);
> +
> +		switch (vector) {

As a general comment, all these system vectors are now going to be 
dispatched through this #HV exception handler, once Restricted interrupt 
injection support is enabled on the guest.

If there are new system vectors being added, it will need the #HV 
exception handler updated to dispatch them too (code maintainence 
headache ?)

It is probably more efficient to construct some kind of a S/W dispatch 
table dynamically like a system vector table and dispatch system vector 
exceptions through sysvec_table from #HV exception handler instead of 
explicitly calling each system vector. The system vector table is 
created dynamically and is placed in a new named ELF section.

Something like this, by overloading the idtentry macro:

.macro idtentry vector asmsym cfunc has_error_code:req
..
  _ASM_NOKPROBE(\asmsym)
  SYM_CODE_END(\asmsym)
+       .if \vector >= FIRST_SYSTEM_VECTOR && \vector < NR_VECTORS
+               .section .system_vectors, "aw"
+               .byte \vector
+               .quad \cfunc
+               .previous
+       .endif

+static void (*sysvec_table[NR_VECTORS - FIRST_SYSTEM_VECTOR])(struct 
pt_regs *regs) __ro_after_init;
+
+struct __attribute__ ((__packed__)) sysvec_entry {
+       unsigned char vector;
+       void (*sysvec_func)(struct pt_regs *regs);
+};
+

and then dispatching the system vectors here:

if ((sysvec_table[events.vector - FIRST_SYSTEM_VECTOR]))
       (*sysvec_table[events.vector - FIRST_SYSTEM_VECTOR])(regs);
...

> +#if IS_ENABLED(CONFIG_HYPERV)
> +		case HYPERV_STIMER0_VECTOR:
> +			sysvec_hyperv_stimer0(regs);
> +			break;
> +		case HYPERVISOR_CALLBACK_VECTOR:
> +			sysvec_hyperv_callback(regs);
> +			break;
> +#endif
> +#ifdef CONFIG_SMP
> +		case RESCHEDULE_VECTOR:
> +			sysvec_reschedule_ipi(regs);
> +			break;

Additionally, during our prototyping and testing of SNP Restricted 
interrupt injection support, we had observed that 
irqentry_exit_to_user_mode() code path (entered at the end of the sysvec 
handler above) can potentially cause the #HV handler to be preempted and 
rescheduled on another CPU. Rescheduled #HV handler on another cpu will 
cause interrupts to be handled on a different cpu than the injected one, 
causing invalid EOIs and missed/lost guest interrupts and corresponding 
hangs and/or per-cpu IRQs handled on non-intended cpu.

Therefore, we had to add checks in interrupt exit code paths in case of 
returns to user mode to check if currently executing the #HV handler
and if so, then not to follow the irqentry_exit_to_user_mode path as 
that can potentially cause the #HV handler to be preempted and 
rescheduled on another CPU.

Something like this:

+#ifndef CONFIG_AMD_MEM_ENCRYPT
  /**
   * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
   * @func:      Function name of the entry point
@@ -204,6 +209,27 @@ __visible noinstr void func(struct pt_regs *regs, 


  static noinline void __##func(struct pt_regs *regs, u32 vector)

+#else
+
+#define DEFINE_IDTENTRY_IRQ(func)                                      \
+static void __##func(struct pt_regs *regs, u32 vector);                \
+                                                                       \
+__visible noinstr void func(struct pt_regs *regs,                      \
+                           unsigned long error_code)                   \
+{                                                                      \
+       irqentry_state_t state = irqentry_enter(regs);                  \
+       u32 vector = (u32)(u8)error_code;                               \
+                                                                       \
+       instrumentation_begin();                                        \
+       kvm_set_cpu_l1tf_flush_l1d();                                   \
+       run_irq_on_irqstack_cond(__##func, regs, vector);               \
+       instrumentation_end();                                          \
+       irqentry_exit_hv_cond(regs, state);                             \
+}                                                                      \
+                                                                       \
+static noinline void __##func(struct pt_regs *regs, u32 vector)
+#endif

...
+noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, 
irqentry_state_t state)
+{
+       struct sev_hvdb_runtime_data *hvdb_data;
+       struct sev_es_runtime_data *data;
+
+       data = this_cpu_read(runtime_data);
+       if (WARN_ON(!data))
+               irqentry_exit(regs, state);
+
+       hvdb_data = data->hvdb_data;
+       if (WARN_ON(!hvdb_data))
+               irqentry_exit(regs, state);
+
+       /*
+        * Check whether this returns to user mode, if so and if
+        * we are currently executing the #HV handler then we don't
+        * want to follow the irqentry_exit_to_user_mode path as
+        * that can potentially cause the #HV handler to be
+        * preempted and rescheduled on another CPU. Rescheduled #HV
+        * handler on another cpu will cause interrupts to be handled
+        * on a different cpu than the injected one, causing
+        * invalid EOIs and missed/lost guest interrupts and
+        * corresponding hangs and/or per-cpu IRQs handled on
+        * non-intended cpu.
+        */
+
+       if (user_mode(regs) && hvdb_data->hv_handling_events) {
+               return;
+       }
+       else {
+               /* follow normal interrupt return/exit path */
+               irqentry_exit(regs, state);
+       }
+}
+

> +		case IRQ_MOVE_CLEANUP_VECTOR: > +			sysvec_irq_move_cleanup(regs);
> +			break;
> +		case REBOOT_VECTOR:
> +			sysvec_reboot(regs);
> +			break;
> +		case CALL_FUNCTION_SINGLE_VECTOR:
> +			sysvec_call_function_single(regs);
> +			break;
> +		case CALL_FUNCTION_VECTOR:
> +			sysvec_call_function(regs);
> +			break;
> +#endif
> +#ifdef CONFIG_X86_LOCAL_APIC
> +		case ERROR_APIC_VECTOR:
> +			sysvec_error_interrupt(regs);
> +			break;
> +		case SPURIOUS_APIC_VECTOR:
> +			sysvec_spurious_apic_interrupt(regs);
> +			break;
> +		case LOCAL_TIMER_VECTOR:
> +			sysvec_apic_timer_interrupt(regs);
> +			break;
> +		case X86_PLATFORM_IPI_VECTOR:
> +			sysvec_x86_platform_ipi(regs);
> +			break;
> +#endif

What about device interrupts ?

> +		case 0x0:
> +			break;
> +		default:
> +			panic("Unexpected vector %d\n", vector);
> +			unreachable();
> +		}
> +
> +		asm volatile("sti" : : : "memory");
> +	}
> +}
> +
> +void check_hv_pending(struct pt_regs *regs)
> +{
> +	struct pt_regs local_regs;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return;
> +
> +	if (regs) {
> +		if ((regs->flags & X86_EFLAGS_IF) == 0)
> +			return;
> +
> +		if (!sev_hv_pending())
> +			return;
> +
> +		do_exc_hv(regs);
> +	} else {
> +		if (sev_hv_pending()) {
> +			memset(&local_regs, 0, sizeof(struct pt_regs));
> +			regs = &local_regs;
> +			asm volatile("movl %%cs, %%eax;" : "=a" (regs->cs));
> +			asm volatile("movl %%ss, %%eax;" : "=a" (regs->ss));
> +			regs->orig_ax = 0xffffffff;
> +			regs->flags = native_save_fl();
> +			do_exc_hv(regs);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(check_hv_pending);
> +
>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
>   {
>   	unsigned long sp = regs->sp;
> @@ -193,68 +349,35 @@ void noinstr __sev_es_ist_exit(void)
>   	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
>   }
>   
> -/*
> - * Nothing shall interrupt this code path while holding the per-CPU
> - * GHCB. The backup GHCB is only for NMIs interrupting this path.
> - *
> - * Callers must disable local interrupts around it.
> - */
> -static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
> +static bool sev_restricted_injection_enabled(void)
>   {
> -	struct sev_es_runtime_data *data;
> +	return sev_status & MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED;
> +}
> +
> +void __init sev_snp_init_hv_handling(void)
> +{
> +	struct sev_snp_runtime_data *snp_data;
> +	struct ghcb_state state;
>   	struct ghcb *ghcb;
> +	unsigned long flags;
> +	int cpu;
> +	int err;
>   
>   	WARN_ON(!irqs_disabled());
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) || !sev_restricted_injection_enabled())
> +		return;
>   
> -	data = this_cpu_read(runtime_data);
> -	ghcb = &data->ghcb_page;
> -
> -	if (unlikely(data->ghcb_active)) {
> -		/* GHCB is already in use - save its contents */
> -
> -		if (unlikely(data->backup_ghcb_active)) {
> -			/*
> -			 * Backup-GHCB is also already in use. There is no way
> -			 * to continue here so just kill the machine. To make
> -			 * panic() work, mark GHCBs inactive so that messages
> -			 * can be printed out.
> -			 */
> -			data->ghcb_active        = false;
> -			data->backup_ghcb_active = false;
> -
> -			instrumentation_begin();
> -			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
> -			instrumentation_end();
> -		}
> -
> -		/* Mark backup_ghcb active before writing to it */
> -		data->backup_ghcb_active = true;
> -
> -		state->ghcb = &data->backup_ghcb;
> -
> -		/* Backup GHCB content */
> -		*state->ghcb = *ghcb;
> -	} else {
> -		state->ghcb = NULL;
> -		data->ghcb_active = true;
> -	}
> +	local_irq_save(flags);
>   
> -	return ghcb;
> -}
> +	ghcb = __sev_get_ghcb(&state);
>   
> -static inline u64 sev_es_rd_ghcb_msr(void)
> -{
> -	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
> -}
> +	sev_snp_setup_hv_doorbell_page(ghcb);
>   
> -static __always_inline void sev_es_wr_ghcb_msr(u64 val)
> -{
> -	u32 low, high;
> +	__sev_put_ghcb(&state);
>   
> -	low  = (u32)(val);
> -	high = (u32)(val >> 32);
> +	apic_set_eoi_write(hv_doorbell_apic_eoi_write);
>   
> -	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
> +	local_irq_restore(flags);
>   }
>   
>   static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
> @@ -515,6 +638,79 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
>   /* Include code shared with pre-decompression boot stage */
>   #include "sev-shared.c"
>   
> +/*
> + * Nothing shall interrupt this code path while holding the per-CPU
> + * GHCB. The backup GHCB is only for NMIs interrupting this path.
> + *
> + * Callers must disable local interrupts around it.
> + */
> +static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
> +{
> +	struct sev_es_runtime_data *data;
> +	struct ghcb *ghcb;
> +
> +	WARN_ON(!irqs_disabled());
> +
> +	data = this_cpu_read(runtime_data);
> +	ghcb = &data->ghcb_page;
> +
> +	if (unlikely(data->ghcb_active)) {
> +		/* GHCB is already in use - save its contents */
> +
> +		if (unlikely(data->backup_ghcb_active)) {
> +			/*
> +			 * Backup-GHCB is also already in use. There is no way
> +			 * to continue here so just kill the machine. To make
> +			 * panic() work, mark GHCBs inactive so that messages
> +			 * can be printed out.
> +			 */
> +			data->ghcb_active        = false;
> +			data->backup_ghcb_active = false;
> +
> +			instrumentation_begin();
> +			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
> +			instrumentation_end();
> +		}
> +
> +		/* Mark backup_ghcb active before writing to it */
> +		data->backup_ghcb_active = true;
> +
> +		state->ghcb = &data->backup_ghcb;
> +
> +		/* Backup GHCB content */
> +		*state->ghcb = *ghcb;
> +	} else {
> +		state->ghcb = NULL;
> +		data->ghcb_active = true;
> +	}
> +
> +	/* SEV-SNP guest requires that GHCB must be registered before using it. */
> +	if (!data->ghcb_registered) {
> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +			snp_register_ghcb_early(__pa(ghcb));
> +			sev_snp_setup_hv_doorbell_page(ghcb);
> +		} else {
> +			sev_es_wr_ghcb_msr(__pa(ghcb));
> +		}
> +		data->ghcb_registered = true;
> +	}
> +
> +	return ghcb;
> +}
> +
> +static void sev_snp_setup_hv_doorbell_page(struct ghcb *ghcb)
> +{
> +	u64 pa;
> +	enum es_result ret;
> +
> +	pa = __pa(sev_snp_current_doorbell_page());
> +	vc_ghcb_invalidate(ghcb);
> +	ret = vmgexit_hv_doorbell_page(ghcb,
> +			SVM_VMGEXIT_SET_HV_DOORBELL_PAGE, pa);
> +	if (ret != ES_OK)
> +		panic("SEV-SNP: failed to set up #HV doorbell page");
> +}
> +
>   static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>   {
>   	struct sev_es_runtime_data *data;
> @@ -1282,6 +1478,11 @@ void setup_ghcb(void)
>   		snp_register_ghcb_early(__pa(&boot_ghcb_page));
>   }
>   
> +int vmgexit_hv_doorbell_page(struct ghcb *ghcb, u64 op, u64 pa)
> +{
> +	return sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_HV_DOORBELL_PAGE, op, pa);
> +}
> +
>   #ifdef CONFIG_HOTPLUG_CPU
>   static void sev_es_ap_hlt_loop(void)
>   {
> @@ -1355,6 +1556,7 @@ static void __init alloc_runtime_data(int cpu)
>   static void __init init_ghcb(int cpu)
>   {
>   	struct sev_es_runtime_data *data;
> +	struct sev_snp_runtime_data *snp_data;
>   	int err;
>   
>   	data = per_cpu(runtime_data, cpu);
> @@ -1366,8 +1568,22 @@ static void __init init_ghcb(int cpu)
>   
>   	memset(&data->ghcb_page, 0, sizeof(data->ghcb_page));
>   
> +	snp_data = memblock_alloc(sizeof(*snp_data), PAGE_SIZE);
> +	if (!snp_data)
> +		panic("Can't allocate SEV-SNP runtime data");
> +
> +	err = early_set_memory_decrypted((unsigned long)&snp_data->hv_doorbell_page,
> +					 sizeof(snp_data->hv_doorbell_page));
> +	if (err)
> +		panic("Can't map #HV doorbell pages unencrypted");
> +
> +	memset(&snp_data->hv_doorbell_page, 0, sizeof(snp_data->hv_doorbell_page));
> +
> +	per_cpu(snp_runtime_data, cpu) = snp_data;
> +
>   	data->ghcb_active = false;
>   	data->backup_ghcb_active = false;
> +	data->ghcb_registered = false;
>   }
>   
>   void __init sev_es_init_vc_handling(void)
> @@ -2006,7 +2222,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
>   
>   static bool hv_raw_handle_exception(struct pt_regs *regs)
>   {
> -	return false;
> +	/* Clear the no_further_signal bit */
> +	sev_snp_current_doorbell_page()->pending_events &= 0x7fff;
> +
> +	check_hv_pending(regs);
> +
> +	return true;
>   }
>   
>   static __always_inline bool on_hv_fallback_stack(struct pt_regs *regs)
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 178015a820f0..af97e6610fbb 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -898,6 +898,53 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
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
> +	 * A malicious hypervisor can inject 2 HVs in a row, which will corrupt
> +	 * the trap frame on our IST stack.  We add a defensive check here to
> +	 * catch such behavior.
> +	 */
> +	BUG_ON(regs->sp >= __this_cpu_ist_bottom_va(HV) && regs->sp < __this_cpu_ist_top_va(HV));

Does this nested #HV exception check also need to consider the HV2 (HV 
fallback) stack, as we may have switched to it ?

Thanks,
Ashish

> +
> +	/*
> +	 * In the SYSCALL entry path the RSP value comes from user-space - don't
> +	 * trust it and switch to the current kernel stack
> +	 */
> +	if (ip_within_syscall_gap(regs)) {
> +		sp = this_cpu_read(cpu_current_top_of_stack);
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
> @@ -1457,4 +1504,7 @@ void __init trap_init(void)
>   	/* Setup traps as cpu_init() might #GP */
>   	idt_setup_traps();
>   	cpu_init();
> +
> +	/* Init #HV doorbell pages when running as an SEV-SNP guest */
> +	sev_snp_init_hv_handling();
>   }
> 
