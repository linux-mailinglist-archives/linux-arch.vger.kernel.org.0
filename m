Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BDF646EEE
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 12:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLHLsp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 06:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiLHLsR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 06:48:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEAF26486;
        Thu,  8 Dec 2022 03:48:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMokm51dB9JGTsvla1/xY22z855WsERr4MeyYpQRSuDyZRXn832QNFH+q5bEFGCUf8ZiITZ8HFHxmtQtV45m4sGbl/Db+ysgwgzJx7YUgh6dXdHHo2TsaKN8bANjqMvZuR7p9iZtOZcVmo6cLRDziAfoM0aS3ouS0r/gXlwbviEc2H5TL+FkEhM60M98VzNlxMqRxTsdn3dGucPmIzlH5df3s26RNXvHdWwlenBK1V4MqA9U5qsaVRCOFg7a/ReavraGXwrroIdjya6w5n8xkskyxnJeBNt8+6KPeieQN0VUU8pQhHtHfqZ0snfWjN9m0vMPLvHI+6VP7S28kt341Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K21hK8tNDkBUGvPCi5/buMrj//3f4+UOZqVYjk+PGA=;
 b=e/+D30mUPTM/ITnDVF/j+Kd8EL7CrKrxFYD1WImwbns+rY5l6gr3hwxyzfEdt5BYhhgnEAp79RKmd6lmzxOz9EXozjq2PVsrtHl9gKtXlhWwj8H1PjV55zPL6xL1jtxG5tX7gJWJgYx9ABJET6tSVjDdz8IOPE03QQA84om6PQmvWJ5jQQDSZG6IaDykH3Lz2bMMEHhB0IXiraa7DzRg7LczB+f0zfg0cXEhkl/Iplydr/MEzld14cOSyoNogW18h3q5jZkVtlNNftHL49xCazoO3uhw5jHeUp9EURhPs5k/rjNcwz4Lk7NnSyB2OuXxHz3HhU4yVXT6LVlR8pwMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K21hK8tNDkBUGvPCi5/buMrj//3f4+UOZqVYjk+PGA=;
 b=kFYVyQz7suzkMLquir5JXMzPyo7mn/7DLhUafFGf7gXQuOPwCAl4/uEJdg87WdDoNkmbJ6VjwpOrMXWTcfFVZ/0BO1AVacHq+D/hJmi35MzNf+3rksIj1aXw8OD0vcvfpu8NVDZxWzSKg7O2DCi+a3WqS2ASXgcPiNQjbi6VBpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 11:48:08 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 11:48:08 +0000
Message-ID: <fe527e7a-1cd2-1e93-7149-9f68f1ef8761@amd.com>
Date:   Thu, 8 Dec 2022 12:47:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 16/18] x86/sev: Initialize #HV doorbell and handle
 interrupt requests
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
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-17-ltykernel@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221119034633.1728632-17-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::15) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 014e5792-352f-495a-1fc6-08dad9121336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHsmLv+Ac6La1EiIaqZNWX/F3fQVBk1ggpSahp4kiPfClG7MzPXtl97Czoghw6lM/AeI9KxdREzpBf897lVsyccJ8b/QYgVD65HuCC4g6qTQ6vhnkEMVob2p0WenROyvP4Q9az4tZZ22aL4DTCE5dWsstXxd0sPwYdEDuTbbej8VWnw0OF2Ia5z6Ih/4bnVeWethzD2ppo2HYkDOJWUi3X0jrO3tyD/PMCp/6G2LMKaNm07k4/GNpaU+bBrQsQAGUuvdNbN2fu11gkudTMDjLktnu97SiPOpGWBN504QA4JLojn4Q018incfLU2jBefGdxABxjDDRyrxmtJFRzZpYxGcmoCGngMwWrulaNy79miKVHKqMmYILNUZIP8WdFU+4SbtMnHVQBWMDMBTuiQBhrX8N0OjnUj/ZamQidxAHgfyI86Ooj0yCaBaW7RuCeqn0iO4n8g3zgF7oVgLzuHaGTpakNm4A0VciKYU45nrW0KcrA1px0mxFsJajIXJjWjI0759AQXWkgu4ibC37nj2RYT52e6NtsmKZ1G3sIi+i2KYuE+0n5r6xNNcxigSYQvPPvtKzv+TmSDc+DIs1+bDZnvGRG/Fp3mc9JJwsgQQxVC9LaaRQ1iWL8r82+zLBh3lBl1uDeiR8ZVUcSU2bBEGOoKQ7Y6bcWH2BKSSI7sG0A+dFaF9nuMwNG4MF5eCcUvVPsxBPoqnMMTcXrxBOn1/LAgW9YFPhobV1BMhIgs5UKUeDdllsutx1ZsqZUcYesOn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(36756003)(31686004)(8936002)(31696002)(86362001)(41300700001)(4326008)(2906002)(5660300002)(7416002)(30864003)(83380400001)(7406005)(921005)(66476007)(45080400002)(6486002)(316002)(2616005)(66946007)(38100700002)(8676002)(66556008)(53546011)(478600001)(186003)(6666004)(6506007)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YThmS1hJZ1d2TjRjTitlOUNoeDBDMnlVNCtGRmxwNmZaRzIvYXcxQkR0L045?=
 =?utf-8?B?RmNqbS9QU2FGR2JoSG9CZVMyaktpWkpIWjhuRXNpVHVBSlNLb3ZyTy90UGkw?=
 =?utf-8?B?WnFFR2g3Vmh4OC9XcHMwL1k2azBVQStFZG5PQytCbWszUVgwWWdJb2JrMjBV?=
 =?utf-8?B?dW1KNzVsaVJOeUpPV1V0VDlFQ0ROdXVUYlBCemJnVWptVm1QM1B5dldwRGsr?=
 =?utf-8?B?dUtROG1jbG1xbVFZTUNzVkVIdnVFekpETHJKeDlXQ3MwamF2U3ZKalQyZWgy?=
 =?utf-8?B?R0lob2FLamVMSjVhTXdpSW5DTEM3RytJZFpjWkszWEo3QVlFYTkrVmxKKzMw?=
 =?utf-8?B?SGQrMS93aGlmSk5JYTRNTnFZcmlwT1lxWXFUNGhlb0p4RElJNHdseTBhWlFr?=
 =?utf-8?B?MmkxNzV5dDU5V3lmaDlwNHZZWHcvREJsbkkzaUtwRS83MlduUkJpU3hPS0k5?=
 =?utf-8?B?WVZpSmVLb1dicVlwUEdKTkF5dWwwTzJuL3FDZG0zRXVIS0Y3cE00YkhmTXlU?=
 =?utf-8?B?aGIwUWRIRWtRZkh6Z1A5Ymc3YjBkK2NJUnBNQnY1cjcyNmlNamFKaXBVUEdu?=
 =?utf-8?B?MkxNVHRUZjVmWlhGZTJiYWl6MnJzSXVPTVhPMFQyUXFMOVRCelFOd0lFRjV5?=
 =?utf-8?B?UHNwTjREV1RmcHNqeEVUVDVIV3hSQ3NlR2ZDRmVnekgzTFRBTnROaUxra1la?=
 =?utf-8?B?UXBXMUFiRStXNHg1dkNZZ3lXMVFqd3hIT1ViSmxTRExKcFJFVzBrNHlKWkRo?=
 =?utf-8?B?UTdOYitaL2VzeU0xR1U3NDBIbDNZT0Q4MXlLRXY2SlpoRCtXRHBLNVhzUUU1?=
 =?utf-8?B?Z1V1MUhsQWRTbnd5T2Z0QjhVQ0I3OEd4NDUxaitBaCt0eXUzS2kraTJ6aURV?=
 =?utf-8?B?MVdYQVNCQVdsSnFxeGxra1VpRFBNeWJBU1MxWUUwd0IrOTh0eERYekV1K29B?=
 =?utf-8?B?dTdiVFNYY3gvTWQ1V1dtVXBjSEFMVUwwMDZ5SzlHTVZGQkVYZ1AvY01JYU5l?=
 =?utf-8?B?NkNqa0QvS2FWWjk1NmNpSEZDTXE4YjVCOE55NmNOREEyc3Z3MGlGcVV6Nmo1?=
 =?utf-8?B?N2lnbnR5NU0wb3JJY0tYbWFKMHZ4MnJqbXZSSHA3M3F5TjNxSVMwVGh2ZVVh?=
 =?utf-8?B?QkFUZER6QngwMDF1d2tvVk8vMktlM2d5WW93eVhwYjRxZFVzWXUvVXFOWk90?=
 =?utf-8?B?NkQyY2ZHNW01a1JkOGR3SXdIdXVLTS9LWTJXZ1A4UW05QmJwMk5KdzREdGxN?=
 =?utf-8?B?VEZGY3g1SHV2UkphMWlBanBtZ1haclQ1M2lkbktOYmtEU04rMitUVVlZaTFo?=
 =?utf-8?B?Vk5OMzBkU3poNzNaL2tJODFoZ2l3ZGhnbEFLdnBDdHBSNitQR3R4Y2Q1aUE0?=
 =?utf-8?B?bWcwV1BzVno3c3BsMHBVaHUvUGpnU0toUmhZVzFOY2VDek1PNHNZY3ZtakRD?=
 =?utf-8?B?c2M5NndrSFpVYzhDbUlrc0cxOXhmdHQ3cVY3bFNkM2dhcUoxRHUwMzY2a1hF?=
 =?utf-8?B?RXFXV0JtQXl4Q216N3JsV3dFVzJXeERndGpOM2VQOUlRc2hvamR4RThRcWU0?=
 =?utf-8?B?ZmFDOWJiOENiNGJEODFDc0xHQW1jbXJGd0ZRczdrV0dLSjlKSXJkWWVQNTFr?=
 =?utf-8?B?L0NjTk1veGpaOUIxakRSWWx3Z3VuUEVlZWRld3NoK2c1elRsMnQ2YVVZTlRi?=
 =?utf-8?B?OXkxczcyTWN3M3I0SUZsblJ3bjFOZGRTTE1CQ0dJUmhBQUxTMS9Dc08veitH?=
 =?utf-8?B?aDhnemlXUGZZZzh5UmZ3ZGJwL2pvUHEvK0NkNEc1ci9LVzFBb3NLa3g1eGRU?=
 =?utf-8?B?YWlwY21HU0N6eUR0YzlsdWxKYllaVG51eWUyUlErMnVsUUJESXZ0c1dIRFRo?=
 =?utf-8?B?R1VObEo2amxjZXNjbDNUQkRQVE8yM2l3ZEF2NlhxTzMyZFZrMWJrWHhJL2xU?=
 =?utf-8?B?Y1lsd0ZMdi9iTlRJOFVlUHlOdkdyV0NLa3F5MTF6cHRvSktuWXpBaWZ5dTRr?=
 =?utf-8?B?NjNJRXJYd0Q5RUNmZllkbXZJYjVxejBGZlB3VVdkYlB0RDBXMWtyRzlGVjI2?=
 =?utf-8?B?M1ZQQXNFNHFjRGFUS3hsRVFVR0lieUU2NkpIVVlHWUM0MTNGOVdWR1dlZHRH?=
 =?utf-8?Q?lTQQMTjL0ZzlnaCE2i4UOidcZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014e5792-352f-495a-1fc6-08dad9121336
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:48:08.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHGhTzafklXqubMuwC8444LTn4E67FFmkycwUYrZ9uzHOy6izO3vXT8ZVxKmSBSHuwl/HmRB4xj5ynt1YhhwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/19/2022 4:46 AM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Enable #HV exception to handle interrupt requests from hypervisor.
> 
> Co-developed-by: Lendacky Thomas <thomas.lendacky@amd.com>
> Co-developed-by: Kalra Ashish <ashish.kalra@amd.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/entry/entry_64.S          |  18 ++
>   arch/x86/include/asm/irqflags.h    |  19 ++
>   arch/x86/include/asm/mem_encrypt.h |   2 +
>   arch/x86/include/asm/msr-index.h   |   6 +
>   arch/x86/include/uapi/asm/svm.h    |   4 +
>   arch/x86/kernel/sev.c              | 354 ++++++++++++++++++++++++-----
>   arch/x86/kernel/traps.c            |  50 ++++
>   7 files changed, 400 insertions(+), 53 deletions(-)
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

Don't know if want to re-introduce this again? as it was removed with 
ab234a260b1f ("x86/pv: Rework arch_local_irq_restore() to not use popf")

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
> index b54ee3ba37b0..23cd025f97dc 100644
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
> @@ -122,6 +128,183 @@ struct sev_config {
>   
>   static struct sev_config sev_cfg __read_mostly;
>   
> +static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state);
> +static noinstr void __sev_put_ghcb(struct ghcb_state *state);
> +static int vmgexit_hv_doorbell_page(struct ghcb *ghcb, u64 op, u64 pa);
> +static void sev_snp_setup_hv_doorbell_page(struct ghcb *ghcb);
> +
> +union hv_pending_events {
> +	u16 events;
> +	struct {
> +		u8 vector;
> +		u8 nmi : 1;
> +		u8 mc : 1;
> +		u8 reserved1 : 5;
> +		u8 no_further_signal : 1;
> +	};
> +};
> +
> +struct sev_hv_doorbell_page {
> +	union hv_pending_events pending_events;
> +	u8 no_eoi_required;
> +	u8 reserved2[61];
> +	u8 padding[4032];
> +};

Does the introduce/initialize doorbell part better to be in a separate 
preparatory patch?

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
> +	return sev_snp_current_doorbell_page()->pending_events.events;
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
> +	union hv_pending_events pending_events;
> +	u8 vector;
> +
> +	while (sev_hv_pending()) {
> +		asm volatile("cli" : : : "memory");
> +
> +		pending_events.events = xchg(
> +			&sev_snp_current_doorbell_page()->pending_events.events,
> +			0);
> +
> +		if (pending_events.nmi)
> +			exc_nmi(regs);
> +
> +#ifdef CONFIG_X86_MCE
> +		if (pending_events.mc)
> +			exc_machine_check(regs);
> +#endif
> +
> +		if (!pending_events.vector)
> +			return;
> +
> +		if (pending_events.vector < FIRST_EXTERNAL_VECTOR) {
> +			/* Exception vectors */
> +			WARN(1, "exception shouldn't happen\n");
> +		} else if (pending_events.vector == FIRST_EXTERNAL_VECTOR) {
> +			sysvec_irq_move_cleanup(regs);
> +		} else if (pending_events.vector == IA32_SYSCALL_VECTOR) {
> +			WARN(1, "syscall shouldn't happen\n");
> +		} else if (pending_events.vector >= FIRST_SYSTEM_VECTOR) {
> +			switch (pending_events.vector) {
> +#if IS_ENABLED(CONFIG_HYPERV)
> +			case HYPERV_STIMER0_VECTOR:
> +				sysvec_hyperv_stimer0(regs);
> +				break;
> +			case HYPERVISOR_CALLBACK_VECTOR:
> +				sysvec_hyperv_callback(regs);
> +				break;
> +#endif
> +#ifdef CONFIG_SMP
> +			case RESCHEDULE_VECTOR:
> +				sysvec_reschedule_ipi(regs);
> +				break;
> +			case IRQ_MOVE_CLEANUP_VECTOR:
> +				sysvec_irq_move_cleanup(regs);
> +				break;
> +			case REBOOT_VECTOR:
> +				sysvec_reboot(regs);
> +				break;
> +			case CALL_FUNCTION_SINGLE_VECTOR:
> +				sysvec_call_function_single(regs);
> +				break;
> +			case CALL_FUNCTION_VECTOR:
> +				sysvec_call_function(regs);
> +				break;
> +#endif
> +#ifdef CONFIG_X86_LOCAL_APIC
> +			case ERROR_APIC_VECTOR:
> +				sysvec_error_interrupt(regs);
> +				break;
> +			case SPURIOUS_APIC_VECTOR:
> +				sysvec_spurious_apic_interrupt(regs);
> +				break;
> +			case LOCAL_TIMER_VECTOR:
> +				sysvec_apic_timer_interrupt(regs);
> +				break;
> +			case X86_PLATFORM_IPI_VECTOR:
> +				sysvec_x86_platform_ipi(regs);
> +				break;
> +#endif
> +			case 0x0:
> +				break;
> +			default:
> +				panic("Unexpected vector %d\n", vector);
> +				unreachable();
> +			}
> +		} else {
> +			common_interrupt(regs, pending_events.vector);
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
> @@ -193,68 +376,35 @@ void noinstr __sev_es_ist_exit(void)
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
> @@ -515,6 +665,79 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
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
> @@ -1282,6 +1505,11 @@ void setup_ghcb(void)
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
> @@ -1355,6 +1583,7 @@ static void __init alloc_runtime_data(int cpu)
>   static void __init init_ghcb(int cpu)
>   {
>   	struct sev_es_runtime_data *data;
> +	struct sev_snp_runtime_data *snp_data;
>   	int err;
>   
>   	data = per_cpu(runtime_data, cpu);
> @@ -1366,8 +1595,22 @@ static void __init init_ghcb(int cpu)
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
> @@ -2006,7 +2249,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
>   
>   static bool hv_raw_handle_exception(struct pt_regs *regs)
>   {
> -	return false;
> +	/* Clear the no_further_signal bit */
> +	sev_snp_current_doorbell_page()->pending_events.events &= 0x7fff;
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

