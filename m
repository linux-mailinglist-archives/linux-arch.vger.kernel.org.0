Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF6643F97
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiLFJRn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 04:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiLFJRK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 04:17:10 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D412035F;
        Tue,  6 Dec 2022 01:16:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5eXlF9Vf+ViTHqCW5nsKeYDFrndwFjcTlRYGv/scOlkPUHTRBVCLWMnq8UCBlZmM+UCiu6jKT6hdGNla60WqIv9awTz4aHOoXjEjsp8dk/E53yrNuNWEKgr4joe7FOQ8osujvmAPlLKj92yKx1kcPIUl1pPLGwIoi6p+rT+0M6Ogzk8P0SScoUaevBL3edriXR1L9VO/zACXovO2to+xagxlpPffFzVXLUE9V8venyS9bZavzkW/wltpfwqueKk2tQG8kw5+65JUO2iqCqLVlwZXUn/8wBU1RRvsL5/cqn9HawptH6jTaDI6z4LjuTP0NqRTh5AZy6Lbha3jsownQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvpqnxZGis698AM+D88I/aNwwNXnwmYvNdPGhflLO+4=;
 b=GhYAMTZWjyNlVcwb+D/SOqWEmvM48LREa5Gob1yi/cowWM7cQItuaFnfdv6Ze1DQZ20dPenaj7n6ZN4dGZu7tyQNlj68otKtqp7oxIvotTaw/8uULM3Vu9NnrTsTp82/iNFsPX1LB6aufA7412iU1lGj0TuY9iglP/TFobvnm3NHHs3j6I3qPsL82tWBL0UeXiZNPy0xkiAd4iD5ntayar8gjX/NxYacjgl5rwBxrtqgiOEwp4n36Eorr/D0+19KtAG1zad9o7YjGKFD044BXFN3POwmEzFHSOedItNH2dDGBATobYjhUT1TPxruKC9ArtUIF2G8AvTasF+Ur+GNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvpqnxZGis698AM+D88I/aNwwNXnwmYvNdPGhflLO+4=;
 b=k29z07pTG72RKjS22ndkGHA/fVzDQp+lPyp8RvBFbvu0K5j6DP8T/KdjjEI14ixuOI2T2tBcjCIdreMQYVjE1roGW17IMJyxNZFM0UvT6DbTL3FuVzlH6HRscuKfLo1QE8ih5gY9trDAkrwj5hqbJ9WVHpmB0/+ITtSvWQb159g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.13; Tue, 6 Dec 2022 09:16:27 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 09:16:27 +0000
Message-ID: <eee97d32-09ea-b5d0-f45a-51c0e1d18d55@amd.com>
Date:   Tue, 6 Dec 2022 10:16:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for
 decompressing kernel
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
 <20221119034633.1728632-2-ltykernel@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221119034633.1728632-2-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3573a393-0a2e-4af9-42c0-08dad76a8dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxH8onUNZ1h/mL4s3kIUIfbG/plT+BWwHQkyOlfEsGybix4KUr7wDJTDtQ2i3Qm0H+za59QMm8kA2bcSYq+WiT866PsuuM875S6i5Wq8ZNYXlnCmETRnqMDMHtUvrq9BBTsI/9HszyD/XpnqbqWLktTkwL/7VV37985ytw21dZcYeAd6Xo+jkYKqZE80NGXYFipTEuKiEKnPOvfsOLqehVdMLBdIYtESRuzfv4W13XqpUGTM+7pQzSlYqqBprFZnxYBlxFLC0qsl9cYTWY3aLjRNAgy+I7cHBXvSfC2IOVUNp2hxdSJWsFRhVTA5dV8PoSjoEz5mOPtC9HW2Va+xmWu2WQeaRmtvSvf8cWD54UzmpSvJ/TxPiMXgVMQzpqa57qpBlqW58fv5f48UK6uAc20wz9yl5+scVSwr2xhnsNMrOE3l2WSWIP5v96yde2llWvh9NHxxaLx1A3345cvQtlkR+ygC8Z7vt/yhFHc7tbzVm9FqEQ+JdH5+9Wx7HoQsZJsYfh6mCXZtFruFXjAT0p1lgsPGrcEZDAbJnq+l7dEE4v30/AXBR85HGjUITc3+/Byb2LfV/LcWB3H5hu21qXgxEpfPh81Z2kZCyFha+H+zC2kXZQLtJh0sFgCSVqPZACul7NvAMKsvTw5mgOkIFdLL51pzbJ0bfsQ87qkRxn3hzqCICcSlEjzfED33orcb833hagcYDd2+3lOayVoiAeZxF3behv6HiFUj694eV6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199015)(38100700002)(36756003)(921005)(31696002)(86362001)(6512007)(26005)(31686004)(316002)(6486002)(6666004)(478600001)(6506007)(45080400002)(7416002)(7406005)(5660300002)(66556008)(83380400001)(4326008)(8936002)(2906002)(8676002)(66476007)(66946007)(41300700001)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1F1UUgzSlNpcHVJeEhSQTVxbkZmWENTVlIyYnV1aDBmYnNqWmhqZ1B2R2kz?=
 =?utf-8?B?MzRHMkczdUt2cVJpN2xJbmJRVkNZa1NDNVJOendUT3NUQXA5UFFiZGV2aDFw?=
 =?utf-8?B?S2xKemp3V3k1dTlQbVRnWk5QaUtFQmNXd0NpV0gvN0ZsM2Y1ZVFGQ1o0SUIy?=
 =?utf-8?B?K3RhUW1wRitIcS92emh0OGZhYWMwUXA5Z1M3UGVEbFdMRGdISkdBWFV4NHFv?=
 =?utf-8?B?ZWUrSTFNQmlqYVZpWk1yWTlERTJQQW1RSnovS1Eva0xxdUVzTWdEUjU1bGpv?=
 =?utf-8?B?NGZlcERHZnZmaVJ3QWlYZjVLWEd6eEZOc3ZBUTNqNzU0UitzRldtYjNGMXVY?=
 =?utf-8?B?ZTBUV21mYTFOQ01MWmNMQ2IxTzJoRzY3YjRKUXJRL1ZjMi8zaGs2ZU9rdmJo?=
 =?utf-8?B?czNyR2ZxWDZ0eStucTg4MGRhbE5QRm8zUkhEanFHQkduNGhxMEplMlJNSjRO?=
 =?utf-8?B?bURES25pczh6enhCWURmcDV5azM1dUpsYUNuejZkYmwxaE5mQi91cURSSkMv?=
 =?utf-8?B?eUM5VUozSUEzMXU4SVN1N2pvM3ZacEJ4MlBGbGFxZHBxMEhSa1JSWmJoRkky?=
 =?utf-8?B?R0Q3T1NQSzdXWXU0NXRLekl5WVA5ajBMMlhqbjJ1d3IweHgxWk1sT2lYTXlP?=
 =?utf-8?B?NGl6Q01rMkcrRjZjZmVPcmUreTR5REZVVXJjdnJ1R1p5SUlxVmtsWVE4aDBp?=
 =?utf-8?B?a3M0RlgrSmpMWGsyQTMxNHJzdVVHSVYrelpMR1JUcld0ditzdk83eFZNVVVD?=
 =?utf-8?B?SVBNbnZ6SmZGSGdVWGcxTEUvcWtEK3p2THZ0VkdEVDdEeU5hazlWN1B4VVQz?=
 =?utf-8?B?cDB5aUhJeDRzSU9GWmpRSE9ZWXV5c0FORi9sZUJocFlwVURHTWI2aGRnZGYy?=
 =?utf-8?B?aVVuTXp3RWV4WUVWRUVRd2RQeFZuSFJlb05VcDNvbzhMelg5ODlITVhLQUFP?=
 =?utf-8?B?aWJ4b2FBT2dLVWpzanh1UmFnZ0grUlRCU0I2ZUFZaWdYYkY1bnlxS3ZHOXU3?=
 =?utf-8?B?ZDArNzRkMVhIeHA2cWdnWHQvMlhtRjdFUU4zQUV6dCtMcWxvUmRwdmlrK011?=
 =?utf-8?B?a2t2QkxTb3Zkd0E2NHRRQzJYblkwL3BPeituQ0dLZU15MldpMERiSjRwQm9w?=
 =?utf-8?B?R0lTYXpMSEhEREhDTDN6YThtM3puZml4NnZIQllCR2hZd0JOSXNmOGR4Y0hJ?=
 =?utf-8?B?cnlpQ25Xc3pYMFk1Sit5ZE02L3kyRmRnc2xveS9XTzJyeWNoOVZ1TWQyRHBR?=
 =?utf-8?B?VG9oeGZiUnJaQUozSktIbzM5amd5TVhUYVlML3FyYy9UN3ZOOTU2NmFESjY1?=
 =?utf-8?B?NVRDOHBxNmUwZHF5eFlsTzZuRzF3SEs3SWZBRnFmVlhXYzF3WEYzR2laUHlF?=
 =?utf-8?B?dnN0ckhNMlhOeG96dlhOTTlYUlZVaTBNZmVhOU4vRFhwM0VjYTdGdHJrcm92?=
 =?utf-8?B?R29EMlBINXlGcXlqTkpscDdEeWg2cDdiUzZaNU1Ycm50YXRsa00xaDlUSk5C?=
 =?utf-8?B?a0s3aU9ncmIwQkUwZFRnVWdRVmU1VWV6RXppL0RDSUZpWXAvc3V3K09MeDFv?=
 =?utf-8?B?NXBodGdCdGQ0RXVFdWVvSTBFQjhyTmFmWDd4Y0pheEIxL214L1ZoS2ZsMkpZ?=
 =?utf-8?B?M0RuWVZVZlhVTjNLeFRMbG1uZTBSWCtIdlBmVlloNUxrR0RhSUZXMjNINXB5?=
 =?utf-8?B?TTh5RE14VFBjbUFENlBpb1RwZEFaMG82VWNCL0U3OEN2cnM1YXdkY05Qait3?=
 =?utf-8?B?Y3czQWF3QVkzQUVuTlE5STRwTS9QU3FReEJoTzhWV3N2ME9sNnBuZ1JlVUcy?=
 =?utf-8?B?UW5mUjFUQW9xTkZxay9OYm12Z09MaUJZMW8wb3BOK1U1N2lvREEzS0ZZT0Zl?=
 =?utf-8?B?NGcrTkRCRXErZVZvRTdHWGxTNzR6T25IZ2x2SnVoNmxPU1d5S2hkU0ZrK0RN?=
 =?utf-8?B?OHBjTTFjRUdTTlFTOFVFOG05QUFjb3NvVjR6VXNVbXdSaVJxRlFwYzdkdzZS?=
 =?utf-8?B?cTV2TGlYcVk4YWQ0WHJRY3VBNU5YRXN6dm0xMVJxYnBVYWtGc2JLYnRhZisz?=
 =?utf-8?B?bmd1dW5VRi9QajVTaXJZQ0t3WGFxV0RUY04yeWdtVE85UVFDU2M1QmxrbWwv?=
 =?utf-8?Q?zwz4VDT2SpJAoZGpi3wEnl4Nq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3573a393-0a2e-4af9-42c0-08dad76a8dae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 09:16:27.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9Nohxrh5xXaoe6bnwZtkQurO/baqSUGdYWHJ+F4nH1cDrJnCOYZ6jvrd2rlJTIrCN17pEU5rVTaRBa+DdI1sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tianyu,

Some minor nits below.

> Pvalidate needed pages for decompressing kernel. The E820_TYPE_RAM
> entry includes only validated memory. The kernel expects that the
> RAM entry's addr is fixed while the entry size is to be extended
> to cover addresses to the start of next entry. This patch increases
> the RAM entry size to cover all possilble memory addresses until

s/possilble/possible

> init_size.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/boot/compressed/head_64.S |  8 +++
>   arch/x86/boot/compressed/sev.c     | 84 ++++++++++++++++++++++++++++++
>   2 files changed, 92 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index d33f060900d2..818edaf5d0cf 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -348,6 +348,14 @@ SYM_CODE_START(startup_64)
>   	cld
>   	cli
>   
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/* pvalidate memory on demand if SNP is enabled. */
> +	pushq	%rsi
> +	movq    %rsi, %rdi
> +	call 	pvalidate_for_startup_64
> +	popq	%rsi
> +#endif
> +
>   	/* Setup data segments. */
>   	xorl	%eax, %eax
>   	movl	%eax, %ds
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 960968f8bf75..3a5a1ab16095 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -12,8 +12,10 @@
>    */
>   #include "misc.h"
>   
> +#include <asm/msr-index.h>
>   #include <asm/pgtable_types.h>
>   #include <asm/sev.h>
> +#include <asm/svm.h>
>   #include <asm/trapnr.h>
>   #include <asm/trap_pf.h>
>   #include <asm/msr-index.h>
> @@ -21,6 +23,7 @@
>   #include <asm/ptrace.h>
>   #include <asm/svm.h>
>   #include <asm/cpuid.h>
> +#include <asm/e820/types.h>
>   
>   #include "error.h"
>   #include "../msr.h"
> @@ -117,6 +120,22 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>   /* Include code for early handlers */
>   #include "../../kernel/sev-shared.c"
>   
> +/* Check SEV-SNP via MSR */
> +static bool sev_snp_runtime_check(void)
> +{
> +	unsigned long low, high;
> +	u64 val;
> +
> +	asm volatile("rdmsr\n" : "=a" (low), "=d" (high) :
> +			"c" (MSR_AMD64_SEV));
> +
> +	val = (high << 32) | low;
> +	if (val & MSR_AMD64_SEV_SNP_ENABLED)
> +		return true;
> +
> +	return false;
> +}
> +
>   static inline bool sev_snp_enabled(void)
>   {
>   	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> @@ -456,3 +475,68 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
>   
>   	sev_verify_cbit(top_level_pgt);
>   }
> +
> +static void extend_e820_on_demand(struct boot_e820_entry *e820_entry,
> +				  u64 needed_ram_end)
> +{
> +	u64 end, paddr;
> +	unsigned long eflags;
> +	int rc;
> +
> +	if (!e820_entry)
> +		return;
> +
> +	/* Validated memory must be aligned by PAGE_SIZE. */
> +	end = ALIGN(e820_entry->addr + e820_entry->size, PAGE_SIZE);
> +	if (needed_ram_end > end && e820_entry->type == E820_TYPE_RAM) {

maybe "if check" can be used to return from here, would read code better?

> +		for (paddr = end; paddr < needed_ram_end; paddr += PAGE_SIZE) 
Maybe we could reuse 'pvalidate_pages' here?

> +			rc = pvalidate(paddr, RMP_PG_SIZE_4K, true);
> +			if (rc) {
> +				error("Failed to validate address.n");

Would it make sense to print the cause of failure here?

> +				return;
> +			}
> +		}
> +		e820_entry->size = needed_ram_end - e820_entry->addr;
> +	}
> +}
> +
> +/*
> + * Explicitly pvalidate needed pages for decompressing the kernel.
> + * The E820_TYPE_RAM entry includes only validated memory. The kernel
> + * expects that the RAM entry's addr is fixed while the entry size is to be
> + * extended to cover addresses to the start of next entry.
> + * The function increases the RAM entry size to cover all possible memory
> + * addresses until init_size.
> + * For example,  init_end = 0x4000000,
> + * [RAM: 0x0 - 0x0],                       M[RAM: 0x0 - 0xa0000]
> + * [RSVD: 0xa0000 - 0x10000]                [RSVD: 0xa0000 - 0x10000]
> + * [ACPI: 0x10000 - 0x20000]      ==>       [ACPI: 0x10000 - 0x20000]
> + * [RSVD: 0x800000 - 0x900000]              [RSVD: 0x800000 - 0x900000]
> + * [RAM: 0x1000000 - 0x2000000]            M[RAM: 0x1000000 - 0x2001000]
> + * [RAM: 0x2001000 - 0x2007000]            M[RAM: 0x2001000 - 0x4000000]
> + * Other RAM memory after init_end is pvalidated by ms_hyperv_init_platform
> + */
> +__visible void pvalidate_for_startup_64(struct boot_params *boot_params)
> +{
> +	struct boot_e820_entry *e820_entry;
> +	u64 init_end =
> +		boot_params->hdr.pref_address + boot_params->hdr.init_size;
> +	u8 i, nr_entries = boot_params->e820_entries;
> +	u64 needed_end;

Could not very well interpret the name 'needed_end'.

> +
> +	if (!sev_snp_runtime_check())
> +		return;
> +
> +	for (i = 0; i < nr_entries; ++i) {
> +		/* Pvalidate memory holes in e820 RAM entries. */

Pvalidate and pvalidate names are used interchangeably in comments.

> +		e820_entry = &boot_params->e820_table[i];
> +		if (i < nr_entries - 1) {
> +			needed_end = boot_params->e820_table[i + 1].addr;
> +			if (needed_end < e820_entry->addr)
> +				error("e820 table is not sorted.\n");
> +		} else {
> +			needed_end = init_end;
> +		}
> +		extend_e820_on_demand(e820_entry, needed_end);
> +	}
> +}

