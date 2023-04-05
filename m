Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF146D73D9
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 07:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjDEFnk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 01:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbjDEFnj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 01:43:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C4719B2;
        Tue,  4 Apr 2023 22:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhmbGg6E5v8NZkr1bI7/dtlWHgVSoxLB+FpJgLq8THqkCeiN+n35D2SWtxnd/UQ1AGxDmTSqWpRwT5+E8SwOz99Yg+ttlq2bwTjaRDEv8R2oZEW4XmKq+1gUYa45TwWS1XrMmyWcLG57KowBkZh0y15NAE6j155d9GlDtOaQSFsKmWW6H/7hZS7XpOB5Y1QrsngTEQ9C0UAy9LMsEJXdVurJIAsZKOqgfCnfDuqgH8JjiKvJoAF8HQsCNGU2vARe0fu/RTk7Ysj3bmRaJM/+rLPUrp43ghrxY7VyzDrNf5/8ew+InEE1SleB6Z54+P5cOvyUoI6fJvZltiiXOU5/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t80aRn5ZS2FfM1bj7oHvMQaAE9QDBbu3cvnabukdL2A=;
 b=Bi8vMKB8yjenpwqog0FyYPKV1DpTp/CUeE39jxtDlqi7jKIXPV9oF6WEK0d4rxXjDIyPnSg8EJYZ7iHuOb8te02czXpw73apdbGp0bJ2krb0Pue5TKYdYZF88WDZjVvCvZQBIt9ep7vowrh9XfTqrDa6ouMgMNLKZ1WaXm8x4LM2RYfzpeezCkYrk6NQzX1/cmPB3mFWO9yoLkKihWx85L+sye6Q01QkHW7CGA/sUsFzq471UBb6ubUshv/qNQASxW5WDVoxozsQOaJjM+GEhoGrO8Larf0ssfePoM+zG2zzw1+ls288Jgjp4Mpihnwv3yBLgHjp/meA3VYTM6n4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t80aRn5ZS2FfM1bj7oHvMQaAE9QDBbu3cvnabukdL2A=;
 b=h9YvIRHqju5sQJrfng+doDvGAVrliROF4eLYi5gt8nctMjMOVvz5kjWrMMivFrwDXzyqxgMnmfQsWOYXYSCW5y0/p8mb9cvP8CiieXQi3w7lS7qbpF6jDpMwDaxbED8fxz4tNxhrr4NKEJjouyYEpldEJlPNfpITf6dKgaoYyig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Wed, 5 Apr 2023 05:43:31 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b6b7:4b22:74f0:dfeb]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b6b7:4b22:74f0:dfeb%2]) with mapi id 15.20.6254.034; Wed, 5 Apr 2023
 05:43:31 +0000
Message-ID: <f840f7bc-887d-d69f-54fd-68acfdb9a076@amd.com>
Date:   Wed, 5 Apr 2023 07:43:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [RFC PATCH V4 14/17] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-15-ltykernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20230403174406.4180472-15-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::13) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: b11eec2f-1388-42a5-0eaa-08db3598b04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9Re6IZ4lc1nNfkGI+lDgvWE/f6VMGZHgeqMnDqUVvF98O0tHhD0g+Kh2LwJBA9XjMkFwj0N4+FDpdA8ANPLQcx+cJxu7pli1BZSDm4w/5ISlGfUwJTAH9ihTCcYmRoeCyap+eo+DCW4F9cBANZL+5UtFzJNSja1wNUoFQl9+XGRHVsM8PlAu9sOmK5iRs26OPIUCCcsG5eLVLQZSezGWnx21rNJ13k47VOZWmPQBceIN/u6JJOqr2coYu9AweRaCfL68vqFS7LztkIBcPlF/+YTdsBZdQaUabVN1MDyfUxIibBoncL5Tb+Co5F1xxIQEkPieYbcCI1nCnGG0+p1aKHHUR10ruoebEeulnZYBobXT33zfu8Age2UhIstMTWnVUGDXppngsnUeSFM9oIMaq3BkV1VchrZRsZUz3GVVDtrtIrb/WlxNQaa2SIMQhykISgWIwIaRnG0FzvlIvpgH518fLrglKc+5FxAkSXQb7A6pYmVTKzS5lips2CV2HmntF9d7F8QJ9xQiMl8Iy21jC13T1dxGHtKsGBGc/lz3YwiuND1LuYN47oSrexJU9X7fdGG23HmSUb3W//dAonA4vIVhfQ32wKY1YbTSb36M2LVoszBkD6XS+swShpvUF3birWQmbI58GY8iynwiO+1qj7dqMUcldqalazEsu5O3G0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(41300700001)(26005)(45080400002)(6486002)(2616005)(186003)(316002)(6666004)(6512007)(478600001)(6506007)(83380400001)(7406005)(5660300002)(30864003)(7416002)(2906002)(66556008)(86362001)(38100700002)(36756003)(921005)(66476007)(31696002)(4326008)(66946007)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFphSW1zS3lOWjh4UjQxTS9od3k3eUdmQXJYRENpRXk0VU1CQkZBVjVDc1R1?=
 =?utf-8?B?a24ra0hqSVFpSHg4M3FpM3BzenN6Z05EcmZnWHZYTmltcHdxaGh3c0tES2Fo?=
 =?utf-8?B?SklxUytyajg1SU90UVJ2WnZQcU42dEVsS0FHVXNoampDekw3aERic3hKOHJ4?=
 =?utf-8?B?OHl2Zlo5NEtjQWZPY1llRFdmNHEvNCsxWTV1eEh2aWJJaFFWQlZWVlpEaXla?=
 =?utf-8?B?andpV29seXFadGkzV2hBQ25ibEVpOXJUeGJIeGYwbk0wU09Nc3ZNUk5rZy9t?=
 =?utf-8?B?NHJQYy9hOHkwL2tCcUxLVFgydmR5amxuYkF3a1FzNUxvSnJLektVa2U3bm44?=
 =?utf-8?B?VkJTZlVMdGdBTUY2WkxadEU2YWNQekZHNWk4NjZpMk1iNjlicjZxbjBveFVY?=
 =?utf-8?B?WkhJZnZ3MWpJeStMOWV2ZzVDZ21ETmR4QXczOXhyY2dpZ2V0aFlVb2NaTk5v?=
 =?utf-8?B?bm9zVENqSXpWVnpWSkRtcnQ0UDdCV0FpVHJmd3FNM1FFS2tEUnRKbzZ5aVRu?=
 =?utf-8?B?Z0YvdTBpYTZLWXF1eHlMZllXR2pTd1NWd3poTnhwYzVRNWovQnVHRHJEVEE3?=
 =?utf-8?B?Y3lBRU4rb2VvUjlZa1cxbjA5ZTFCNFA1WFlKYXVNK2FtWUZFTlhTSDd0UlBN?=
 =?utf-8?B?Y1BaSXFaQjIzYndHWmdtaVo5UWliaVhqOHZBSGVJenRER25vaUxzVlJUSDM4?=
 =?utf-8?B?bTBrSHZHMzZxNU5kOVVadnoxRzFZQjZNV3pyZkZFelNlcG9LbG1Nckg3L2o2?=
 =?utf-8?B?RXZJQXJYdVNJZjhGNUFBTXp0eUFMeFE1K09EYnNIK0lKTG4yREtPUzBjVlNo?=
 =?utf-8?B?Ny8ybkplQkJIV202MGE4UzVGNGovSllETXA4MGk5UU0rNDJMV2Y2ckw1REtq?=
 =?utf-8?B?bUFWV21xZmF3dHg4a2ZJVlczYmtkTXJlcjVIbFJlekZtZzAycEVKOEd6Qi9k?=
 =?utf-8?B?Mk1IaXVyZW56aDJLNmd4b1BrVEdhNU0wS2xpNWViR3h5bWJDUW5UTzEreHJ4?=
 =?utf-8?B?VVpyNnJNV3RZNEVMSE1YOGNOQmdZSVIzZUZ0ckRsU3FBNys4MlJDQkJKMnB2?=
 =?utf-8?B?UTViZWVaNlJZdkR4ZFN4WXlHK2RyUmRadDNidHd0Rm1TRlphNEh2VldKcEpN?=
 =?utf-8?B?bVc1V0Q5Um1ITnhtMnpxZWxSSGRVdHZYcEhwYm5ZWlRNNng5Ky9icE92bnFs?=
 =?utf-8?B?M0QydTBMWFczUGh2dWJLVk9HZ2NwR2FwN09teVJnNllWVTBqaTFBYW54endT?=
 =?utf-8?B?bzhFM2JlZGlqUldpd2FNQmFFdi9oanpIOXlkK3VJZUw2Y0JRaFBqc3VkZFR5?=
 =?utf-8?B?elJNL1pJNlNqTWNUN0plNEpGSWJjRnU0MXBwSDdXczZQcTJhVWliOW1ENWJ0?=
 =?utf-8?B?QS9KSkpIdEx2OW40clpsK2V2aFB0UnFnNEZkN2tGdWhpVFNicnh2VFVJVVRR?=
 =?utf-8?B?Z1JQdWdyM0tEaXdkSzlnTHRnRmhUOStERE1BU0g5UUlIL2ZIT0JDdk5KQzRm?=
 =?utf-8?B?SUxLVENZQmEyNTZXL2FZR1FYY29pWXhyNE9iTUdxS29UMGdCQzZPNEFoaUYr?=
 =?utf-8?B?aDY0eTdjUXYrZC9pQk1wUS85WnhnK1pNUDNkN2ZHYVlVYkEzV0RRS0Z6MDNF?=
 =?utf-8?B?cnRFaWlxdExidlUwcUs0SWlMZWIvOXlxMEtaZXpZcWxxdWo1WHQ3T1ZDK1Vw?=
 =?utf-8?B?cGo2cXR2MElKTVhPRjkvV0IwSUFwUFk4SmxYUmRWRk1KTWs3WDVRbEFST0dZ?=
 =?utf-8?B?ZXV4bndybWFDY2w0aU1RS1IwdkJ5VTBCZjFrQm1vejlQc3JaL0JjUXBycit6?=
 =?utf-8?B?aWt4Zk0wc2RvTWNYdk1rVThBRkgvUVZSbXpVaFBqM09hYXhKbnNsQ3NzRnV5?=
 =?utf-8?B?UkxScHJuWlF3cUVHMDdDVG5FcUJkV0VERmZqOGZzQldSSWxOcFhCYk9EWGk4?=
 =?utf-8?B?NFdkMWpFUEx5bFZMa1pNSTg5eUlGT1B4RGdITUplWDAzc28zU1Q3eEk3RWMx?=
 =?utf-8?B?clZnYlpuNk5QN0R0aWNzYXB6V09qQmE4U1BTdDFrNGd1emlSbm1DeWR3UGRF?=
 =?utf-8?B?NnQrckRDajk2S29RSDArVHl5YWs0VldhcUZRNmt1UzRIZDFlRE5kMTAreXJ0?=
 =?utf-8?Q?CckVCa739ZSsWEB511hD1k/Iz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11eec2f-1388-42a5-0eaa-08db3598b04c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 05:43:31.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRjyZG1QXzMJOuKUlNq1iIGjH2dWaJkyorNyNdvg++cvm+hp0mHzOGsykEvQXi5X5T6+Gh65EbdN+/Sl9pS7gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Enable #HV exception to handle interrupt requests from hypervisor.
> 
> Co-developed-by: Lendacky Thomas <thomas.lendacky@amd.com>
> Co-developed-by: Kalra Ashish <ashish.kalra@amd.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V3:
>         * Check NMI event when irq is disabled.
>         * Remove redundant variable
> ---
>   arch/x86/include/asm/mem_encrypt.h |   2 +
>   arch/x86/include/uapi/asm/svm.h    |   4 +
>   arch/x86/kernel/sev.c              | 314 ++++++++++++++++++++++++-----
>   arch/x86/kernel/traps.c            |   2 +
>   4 files changed, 266 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index b7126701574c..9299caeca69f 100644
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
> @@ -73,6 +74,7 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
>   static inline void __init sme_enable(struct boot_params *bp) { }
>   
>   static inline void sev_es_init_vc_handling(void) { }
> +static inline void sev_snp_init_hv_handling(void) { }
>   
>   static inline int __init
>   early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 80e1df482337..828d624a38cf 100644
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
>   #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
>   #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 6445f5356c45..7fcb3b548215 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -122,6 +122,152 @@ struct sev_config {
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
> +#define sev_hv_pending_nmi	\
> +		sev_snp_current_doorbell_page()->pending_events.nmi
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
> +
> +	while (sev_hv_pending()) {
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

This prevents do_exc_hv() executing from #hv handler as 
"hv_handling_events" never resets?

Thanks,
Pankaj
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
> +	}
> +}
> +
>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
>   {
>   	unsigned long sp = regs->sp;
> @@ -179,18 +325,19 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
>   	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
>   }
>   
> -static void do_exc_hv(struct pt_regs *regs)
> -{
> -	/* Handle #HV exception. */
> -}
> -
>   void check_hv_pending(struct pt_regs *regs)
>   {
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   		return;
>   
> -	if ((regs->flags & X86_EFLAGS_IF) == 0)
> +	/* Handle NMI when irq is disabled. */
> +	if ((regs->flags & X86_EFLAGS_IF) == 0) {
> +		if (sev_hv_pending_nmi) {
> +			exc_nmi(regs);
> +			sev_hv_pending_nmi = 0;
> +		}
>   		return;
> +	}
>   
>   	do_exc_hv(regs);
>   }
> @@ -231,68 +378,35 @@ void noinstr __sev_es_ist_exit(void)
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
> +{
> +	return sev_status & MSR_AMD64_SNP_RESTRICTED_INJ;
> +}
> +
> +void __init sev_snp_init_hv_handling(void)
>   {
>   	struct sev_es_runtime_data *data;
> +	struct ghcb_state state;
>   	struct ghcb *ghcb;
> +	unsigned long flags;
>   
>   	WARN_ON(!irqs_disabled());
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) || !sev_restricted_injection_enabled())
> +		return;
>   
>   	data = this_cpu_read(runtime_data);
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
>   
> -		state->ghcb = &data->backup_ghcb;
> +	local_irq_save(flags);
>   
> -		/* Backup GHCB content */
> -		*state->ghcb = *ghcb;
> -	} else {
> -		state->ghcb = NULL;
> -		data->ghcb_active = true;
> -	}
> +	ghcb = __sev_get_ghcb(&state);
>   
> -	return ghcb;
> -}
> +	sev_snp_setup_hv_doorbell_page(ghcb);
>   
> -static inline u64 sev_es_rd_ghcb_msr(void)
> -{
> -	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
> -}
> -
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
> @@ -553,6 +667,69 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
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
> +				       SVM_VMGEXIT_SET_HV_DOORBELL_PAGE,
> +				       pa);
> +	if (ret != ES_OK)
> +		panic("SEV-SNP: failed to set up #HV doorbell page");
> +}
> +
>   static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>   {
>   	struct sev_es_runtime_data *data;
> @@ -1281,6 +1458,7 @@ static void snp_register_per_cpu_ghcb(void)
>   	ghcb = &data->ghcb_page;
>   
>   	snp_register_ghcb_early(__pa(ghcb));
> +	sev_snp_setup_hv_doorbell_page(ghcb);
>   }
>   
>   void setup_ghcb(void)
> @@ -1320,6 +1498,11 @@ void setup_ghcb(void)
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
> @@ -1393,6 +1576,7 @@ static void __init alloc_runtime_data(int cpu)
>   static void __init init_ghcb(int cpu)
>   {
>   	struct sev_es_runtime_data *data;
> +	struct sev_snp_runtime_data *snp_data;
>   	int err;
>   
>   	data = per_cpu(runtime_data, cpu);
> @@ -1404,6 +1588,19 @@ static void __init init_ghcb(int cpu)
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
>   }
> @@ -2044,7 +2241,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
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
> index d29debec8134..1aa6cab2394b 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1503,5 +1503,7 @@ void __init trap_init(void)
>   	cpu_init_exception_handling();
>   	/* Setup traps as cpu_init() might #GP */
>   	idt_setup_traps();
> +	sev_snp_init_hv_handling();
> +
>   	cpu_init();
>   }

