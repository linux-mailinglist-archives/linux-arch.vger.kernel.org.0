Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD969ABCA
	for <lists+linux-arch@lfdr.de>; Fri, 17 Feb 2023 13:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBQMp5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Feb 2023 07:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBQMpn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2023 07:45:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46286783D;
        Fri, 17 Feb 2023 04:45:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkkWkznrBaVNMyRkxfKGV1z090qfZOS4XWy1ZTh980n+UdT8ufOEvBCN7pWDuxQqZ1lYT0VPtdempyANla+92IWLqNdR1WOwMQH6uSLAxkEIxL3nHOzQ1Ql386r6ZQa0EpmcgFl5cg/H3WauRV6Kfl+f9ldB6gTy0Ter+eHfwCQt4mQoDqfT+YiBSdqvMkFDA/u2CLCwSSSDYomX6JC8+8h7aJLcOyhNwuYMDvpvVYF4OANWTTrt9VFdTawTDQZ+jIEpU7wkCDItO6MotOzqzQgvHucwz5MjAzf5sVNjEHomyEbxpLYhPwy1NWZzGMuR5PPAUUT6rbG1IokxhxPKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsyFilunR9wLksRdZyFqvtqSJC88BwuJiAlHZ6uDSQA=;
 b=dYLTrXuQ4dFD6EjDnsw8l4eZjZ81w07m44qQItcsLMD33RBMhNmmZkDL5/urf+Kd77qKOB41G8O18/CFNs/mXG84R9fpsBaHzAADTJ00OcoDkjAlysXxXANUs2TAFi5oq16oL05BVMSyIMqcYfBrHWNs6qaVk41HhixzG4Gj9PFvNutfguipObb5NU+UqU06IGDT57Mk8qi4t38hzWsH72zkIDgAR7x+5rujzeTNvgYQvsBq6CEgkHp26j6MzYwcQMfi3Oe749IOcSIW5uAiXAmWqrxIS/2acdFtf4IdA+MINR05ydlTnLqabf2Lo9o59lkjOLfh4ZRnmjyGZVdhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsyFilunR9wLksRdZyFqvtqSJC88BwuJiAlHZ6uDSQA=;
 b=jfMdA4oxCRip/Kvkit+CuqUwIGVzELE0SejjhTc1BlIEID0Rt/x8HKXv4n92CT3YgKYmApKNchd41zNkfhthbsJo3DUCIj5CzlS85te90vFYZUvkweYKH5ucOV8x/HuS44vwylLj4imtr+NQDOiOYcyE1IW9vzQHhcmBYSoeuHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 12:45:37 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef%6]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 12:45:36 +0000
Message-ID: <d291b8e9-12bf-2ac3-e5cd-5a6a4eb2c7a9@amd.com>
Date:   Fri, 17 Feb 2023 13:45:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 14/16] x86/sev: Initialize #HV doorbell and handle
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
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-15-ltykernel@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230122024607.788454-15-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5834a0-baff-406d-61d5-08db10e4ddce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOJ/SJbwIo3uiCggGWhCqMHgQSn1PCRYX6m+2/C+t/HwcTkPqNkigb0nexdcuoWzJsV19nnTEYt8HN80LkvxXdWVuhBY+Kss5E4C+4/pL+yfSjSyfj79L71J97H1/9tSfApYEwMcM863sDRRdisYNkq6R9765IPKaWAGL/JAieV8qga/azMQ3BzBzLuJvfci1MjscbG8kXJEdSpF77s2fj29vF/hu5j1H+0EDUQtpy21njuq5/fZya+IwyaYKiv7zVN2anRTafIGyCES5vfakQAg0ZLu3/dVh4yM7AQvU5Z9nflkz7ZlweIbwtC+JxcOEkqSuaYLECi+8ekpZlBI/jcA/tBwtHcLk1LgdtX2cd1fRWSCVtF2OeKkiWorjlpAjVMYP6OzO4wmVD/m0kmGxcezrrHT6vdI38fhEqteLSPdtEK/OHRj9WDm8m3WB1ovdalvZUGJEZdtQKzdzeuuZp4QZFTm7IDMRaVRJUKEpRDIOFeRCYgAOk5QVYYWVdO9qvhmUgXawQKc9WqtQlWnmZfHpomAHeqIQJ2b0jhDQGUhmZ5XNguhqWQkljP5Rba+e5bvTrvm7CA0HwUJTNdn7WJjmB/wqGclEQ7nhb3U9/0gMYiA4mJd3JLSH2akhluSgxbTpgXqbPc4uC+Lje7A8eqBFcE7MsbKA+NxHm+gbs6u3TEySKkMj34f9gzY7BdA9pg2TU7GOSYkhWl1IewpSN4rDpWaBiC6bVX+BF/uUEmK8OFMClaRAoTVQbVwbBgb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(8936002)(316002)(921005)(38100700002)(7406005)(7416002)(66476007)(4326008)(8676002)(30864003)(66946007)(5660300002)(6666004)(41300700001)(2906002)(6486002)(66556008)(2616005)(478600001)(6512007)(186003)(6506007)(83380400001)(36756003)(45080400002)(86362001)(31696002)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGx1ODBrcEJiMWtpTE5YVzI5dEc5MjdITVdmZDBEZENnVmloNW96QjlJN2Rj?=
 =?utf-8?B?bGg0RzZlWHNyZmxuaGV0MlpEdEF2cnFPOUtsV0J0ZXNHSU1LN3hJK3N4bit3?=
 =?utf-8?B?cTFaMDUyODQ2ZnlIM1JIZVlpQ0daME9PcHdoUnZNYUpNM292SGx5ZHZVakt1?=
 =?utf-8?B?S2xUQUpLeDJuRCtUTFJCUjVGUFoxZFVRMmhKTmZRWnpSM2FSeGpMcXlIdDhJ?=
 =?utf-8?B?VmdrRUVJK0pXZVYxaHJicm1JeHhkNVZkT2wvTmtaak1Ud1NBQ0ZqTXdjeEFD?=
 =?utf-8?B?ZGFUVFVrV0gyeGpUVFU4U0NYSFRZTU9XQ0QxNmxzOWFTNmZOR0QzZnB2TmVk?=
 =?utf-8?B?QlFCemsxTmFTVHM2emt0cytGbm5hMk9rN0FFQkNXSmJzVElKMzl5U0VHWnpT?=
 =?utf-8?B?b0NIcnZrSG42bnRWUjhOdFRhS3pWUnl4cHJoTGhiK3l0Q3NHVnBTZFJWaHYr?=
 =?utf-8?B?Q1AyVHpNVXNSQ3JTNkZUKzJLclhTVWxrVkJvb2FneC8wcldORTJEdW4xZWZi?=
 =?utf-8?B?TlcyK1J5akVyRzE4TS83SmFNY3Vzd0ZkQTZER2lKMitsaW9BZ2tGRDI2U1Nz?=
 =?utf-8?B?dXhiVUxYLy81SFVwUXdyYnBrS0EvTzRlV1BCZEZPVFpKRkhWNlVXbnlwd0ps?=
 =?utf-8?B?aWlhRGxUbHpyTDV4UWw5UHdsL3hXSzBFUUtEdE5sRHBreGJuWWJpa0pSdFZJ?=
 =?utf-8?B?YWw2Y2R5eHZtcEdlTG1hbG9BRXh1WmFpdnNZenZ2TkdYUEJKR3I2QWJNaXhZ?=
 =?utf-8?B?d0kyREMzb0l5MVFIVTBnR2wwdk14LzFOUGtTUTB0eXRkaXZNcElTZyt2dXpS?=
 =?utf-8?B?dmxsWFl6Uk9nWi82eldPbjhHNGVHa09rV1k2STRZY0U0ZnNtaWY5YnEzS05o?=
 =?utf-8?B?VHdaRThicXpRYjB1cWs1NURGcW04eWhXbUlRZm9CZkxZeVlZcTBYcytGWDZV?=
 =?utf-8?B?bFcyRnhMd1BINUk3bGxabStiS1B4UVB2WlNjQ2J4bXJzQjBvNGVEYy9adEc1?=
 =?utf-8?B?RFZha3BXWEYxZHBGTmVxa0xDL3o4K0JvdlVSQVFoTWhodUV3UXRNWTRzSDM2?=
 =?utf-8?B?YnhLTENqWFhkcDhZVElrelV6ZG5YNVZ1RGhSRUVIVDluQjBLNGxKeDk4ekor?=
 =?utf-8?B?ODFpQkQxWUFOeUZSbGtiYXBTWXowZms5YzdMTFppY1FsRjJiQWVibmNGUDlw?=
 =?utf-8?B?NWY0dnU2ZU9CcGtOZkR2WFpvNG9iNFBtOVpGMThHR2Z2WWVqaCtiZGEyRUIv?=
 =?utf-8?B?YW9Bb29ZTHZhNUNQekt0N3hCTGcwcG9VNWttS214NjR0MEJiajNlMk5vc1lB?=
 =?utf-8?B?dDZSSDc4QWN5VEVha1dRSU1zbHljVFlJTitsc3ZRLzlNLzRnc1VPVUxGSjhC?=
 =?utf-8?B?T1ErZXYrb2NwcEY5bGpXYkk3bWNQMmZmUmFyTjR6WHNSSnh1U2xUQ1NiWWVG?=
 =?utf-8?B?a1gzZit5clZhYzluMzBkenduMUVxOXVpdjJKdnlKL2pvVHVrV2txWmNFZURh?=
 =?utf-8?B?a3ZmNmhmKy9SYS9xRkp0RHJNK2wwZjZ3cy9rV0FqOFdJOHY2YStRalJ6OUM5?=
 =?utf-8?B?Q1pIdlRNN3p5aVZUMGhwVGQrZjBGQVYvY0hCcVd2QUlxSVpmdVgwOEZiUWdY?=
 =?utf-8?B?djdNbWxjVS91eVlRNlhlaGZhdWpRbXhUUkNxZWpycFAyYTUxcmRJdXZBUnZI?=
 =?utf-8?B?NWpuS0pnaGplakd1TXRQZEJXM0srSm5GaDRKb0dxNkcvemozMjIvVVhwd2w4?=
 =?utf-8?B?Y1AvK0t1U3BUVW5TVWxXeWMvL0lNcWxiMnBacG9xVVBuSzI4Y2U3Z2tWMmpD?=
 =?utf-8?B?WlA4ZE5QWFBualV6eU05RS92TzZTd3FRMldUWkszR29JZk1KQXNpZGo2SkFO?=
 =?utf-8?B?c1EzakdDUzcrUXFiemxwYmsyZ3k5RkpyNytKN2JIQkpvK3hFQ2E4c2I3RExl?=
 =?utf-8?B?cStlMXJIdnEzVjYvcWpTS3pBY3NnWWFERklNSG85UFdWeEVMY3c3cE5XcXg5?=
 =?utf-8?B?UVFiOGNGbFQ4Q1FFSTdIdllFbm5KY2VKRi91V3BRNUhHYjlJNTIvb3A1NjVT?=
 =?utf-8?B?RXpNMFM1UVZLNldtclVBUjBCbmJLT3BkbHM0U1N3YXg5R2VHMGJzVGE3ekto?=
 =?utf-8?Q?7cAmgnveERxTGfYaBzeD7n8Au?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5834a0-baff-406d-61d5-08db10e4ddce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 12:45:36.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0itHIOfkWcnxe24/D5/4NAQrqlfl+i1lZFnROLeu5Dd6anpsiBQgJHMflX/nAVWimTydgFZIqOetgA9h/l2KMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
>   arch/x86/include/asm/mem_encrypt.h |   2 +
>   arch/x86/include/asm/msr-index.h   |   6 +
>   arch/x86/include/asm/svm.h         |  12 +-
>   arch/x86/include/uapi/asm/svm.h    |   4 +
>   arch/x86/kernel/sev.c              | 307 +++++++++++++++++++++++------
>   arch/x86/kernel/traps.c            |   2 +
>   6 files changed, 272 insertions(+), 61 deletions(-)
> 
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
> index 6a6e70e792a4..70af0ce5f2c4 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -562,11 +562,17 @@
>   #define MSR_AMD64_SEV_ENABLED_BIT	0
>   #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
>   #define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
> +#define MSR_AMD64_SEV_REFLECTVC_ENABLED_BIT		4
> +#define MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED_BIT	5
> +#define MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED_BIT	6

These are already commited part of:
("8c29f0165405 x86/sev: Add SEV-SNP guest feature negotiation support")

Thanks,
Pankaj
>   #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
>   #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
>   #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
>   #define MSR_AMD64_SNP_VTOM_ENABLED	BIT_ULL(3)
>   
> +#define MSR_AMD64_SEV_REFLECTVC_ENABLED			BIT_ULL(MSR_AMD64_SEV_REFLECTVC_ENABLED_BIT)
> +#define MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED	BIT_ULL(MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED_BIT)
> +#define MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED	BIT_ULL(MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED_BIT
>   #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>   
>   /* AMD Collaborative Processor Performance Control MSRs */
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index f8b321a11ee4..911c991fec78 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -568,12 +568,12 @@ static inline void __unused_size_checks(void)
>   
>   	/* Check offsets of reserved fields */
>   
> -	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xa0);
> -	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xcc);
> -	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xd8);
> -	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x180);
> -	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x248);
> -	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x298);
> +//	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xa0);
> +//	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xcc);
> +//	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xd8);
> +//	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x180);
> +//	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x248);
> +//	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x298);
>   
>   	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xc8);
>   	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xcc);
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
> index fe5e5e41433d..03d99fad9e76 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -122,6 +122,150 @@ struct sev_config {
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
> +	}
> +}
> +
>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
>   {
>   	unsigned long sp = regs->sp;
> @@ -179,11 +323,6 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
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
> @@ -232,68 +371,38 @@ void noinstr __sev_es_ist_exit(void)
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
> +	return sev_status & MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED;
> +}
> +
> +void __init sev_snp_init_hv_handling(void)
>   {
> +	struct sev_snp_runtime_data *snp_data;
>   	struct sev_es_runtime_data *data;
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
>   	data = this_cpu_read(runtime_data);
> -	ghcb = &data->ghcb_page;
>   
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
> @@ -554,6 +663,69 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
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
> @@ -1282,6 +1454,7 @@ static void snp_register_per_cpu_ghcb(void)
>   	ghcb = &data->ghcb_page;
>   
>   	snp_register_ghcb_early(__pa(ghcb));
> +	sev_snp_setup_hv_doorbell_page(ghcb);
>   }
>   
>   void setup_ghcb(void)
> @@ -1321,6 +1494,11 @@ void setup_ghcb(void)
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
> @@ -1394,6 +1572,7 @@ static void __init alloc_runtime_data(int cpu)
>   static void __init init_ghcb(int cpu)
>   {
>   	struct sev_es_runtime_data *data;
> +	struct sev_snp_runtime_data *snp_data;
>   	int err;
>   
>   	data = per_cpu(runtime_data, cpu);
> @@ -1405,6 +1584,19 @@ static void __init init_ghcb(int cpu)
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
> @@ -2045,7 +2237,12 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
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

