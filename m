Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E006A745C
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 20:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCATec (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 14:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCATeb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 14:34:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763572A6C2;
        Wed,  1 Mar 2023 11:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI4vk7X1RxA4x1ONqgcumMjwVXXe7lMfmzrdTk7y/3l0z+TBr55eDrtJGK/m6q4Su1lN+Ft6Hp08TggO/4z8iIdAhvVtyevqR5MJHjJBArv9GHVsD9g39GIU1bTBFS0yNXg24c8hDWURRDCbYCe4J2XeAqZqsx0U/59OwHymxJ3Mvv/UOz05/aLDxU2yG1w832R1PCyq9l0HUWfAF8SfC8J5ggR2wx1tUu/GNexWyw/o13qlEpsnkAD12BEtI1R8q5pcYYUrCaydmj9Xu9fQvOGYcrDYO3XVWoVZzmleki6HDrtSdcVbg5E2unNksXK+Q8Sse9A5X5xfIp124So8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCkFwqRASQHEPA6EkmvWjvBBDBBHx3CC5b+OfP9MvSI=;
 b=cFuN7PSkt9wzCrMB/hpLOh2GsQbLqEmOkoOd5U9VAZaY3a1j6icngupZc1qw10zViz+z++ddITtQ1sgYwIuArtb9e2NVyTs5NEBzo9spo1MyQR6JuRrs/DAZuLBKY1vRq4Q6zJ/lXmG/H/31wN4lTcF+gwiqkVbyxqDjBcaWiTjIcK5dB69vRcQv0nlSS4e1Y4ijaung9mCNZDDB1Da+y+jT+cw+Y3JJMyJxijqmAMm3waJjq7717ULivrNYlf9N0+lr5+PsSBuRsgODXQIwLqC2lN+O85HVY8/FLLBLqd1tt8jnKIIdEq5HpKi3i1lFwKgvJ9qmpWPkuDh78mcTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCkFwqRASQHEPA6EkmvWjvBBDBBHx3CC5b+OfP9MvSI=;
 b=naUq0mR8u8yh4RPn9zI9d4LLT6Afyo+ZI+oIeXUDKyLMZ9EsbyrZ20AfPybaB8iX+D1ETMtGSN5IA7hs6useqmYq7Bpia0zWQSGc/HrV6gzawLwoHgiROg40Ly4AOox4+HQymhuYxacYzFYqC8uQ4mWcXlILnk6NsBRsah4qASc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Wed, 1 Mar
 2023 19:34:24 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf%3]) with mapi id 15.20.6134.025; Wed, 1 Mar 2023
 19:34:24 +0000
Message-ID: <cb35f611-859e-6bea-7b94-a8f131301644@amd.com>
Date:   Wed, 1 Mar 2023 20:34:11 +0100
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
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 017dea2c-0134-4a5b-0248-08db1a8bf624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s52rYv8NsRLyEWbl9TX0dWxnvXy0zmJkv3A/W+cQ4QgrHwPUnCyq3ClE7rUbMgMOPMy7vOvUtiHJTw1gDg2rNfxk3U3etjxcVmBdewzmIbZNrdT+Rg1hWWV4uGaAZTU2781AD8y04uO6xeFR+U1idXDorAiejh5xyy7q//zMVj662WQ/wfdKUPXzdT/qHNGg9KtooGJdbxgJsaBXuaYU5GMX2zrzAW/Ve/6Qsl5zwwPgAzBLlcyhwr96OgSxIbRXbTJqQ6KaTu8qHt/GJwqnPi0tbevyEdmPfl9+Co7UjyBuK26p86PijmDg3xgQPopMHqth59ylJ7SY2medZWQo9b/K/XSMn0xlzCysgl13wC+iN2oYw6ldwYRfAiXARnrio8fSc6K8xiZm8NE9XzMsoIjFXxKy7aqk4feKV/HZ2JeL2W1OP3x3wWBvonuUcoYS5GLdau8sGoy94rBrpAkFkl3oaEEq02xvqxC906WAMP7caN5xvC3caGX7bRa2jW80nFK8qXRTmb3GvCnOqGG6KXsaba3ahGzvfP/CjUonTnRD6Pin4a1D4lfxMhrdcAC53SDSDMEFNai3QXa3fh/T8eDlT5hSfsVfmfJnqHAKq3l2XcnnFnD1SvUC+RDIE67IzJxxP4ZAv4RSagkpHp9/S2XYuX0SitgnDQdZZTLnsw4RbfGuMtxay7fUxNngHb31aJeF41wX6KjUsaWiDvQVlnCAhIRsnjOAOyXgOBqr5jP7ifHbNCqP9UpdwEwOQDMm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199018)(8676002)(6666004)(26005)(6506007)(478600001)(6512007)(186003)(2616005)(53546011)(316002)(38100700002)(66476007)(66556008)(921005)(45080400002)(6486002)(66946007)(86362001)(31696002)(4326008)(83380400001)(5660300002)(2906002)(41300700001)(8936002)(7416002)(7406005)(36756003)(30864003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk8xeDQzV3lOSTFOVGgwT3BjZWkweG1BOFRYQzBVTXZ5bFQzSXNTSzY1Qzlk?=
 =?utf-8?B?dkl5QVl0RlJpSnRKYi8xUUk4Q1Qrbm55aUFPY0R0cUltZWk3NDd5dlM4YmFN?=
 =?utf-8?B?ZDQ2d0NEcDYzRWlYVEVMWVVzWWY0S0o3b2FXSGVVRHNsWlFlWEdTMWhGbUo0?=
 =?utf-8?B?dHMxeDBEWGk1MW5FbjQ5TDNpZUtxSFNxS1ZrckE2eGp6RS9FNWxDRHZueGtj?=
 =?utf-8?B?bVZveC93amN3TTZJdDVhMjlhWXhIeGcyM1NCVWpUQ3dtSk1ZS1l2T1ZuQWV1?=
 =?utf-8?B?RllPNDVoTWdvcGpYb1FjTDJPSGl4LzQ4WmFyNXlpV1N1aGY3TVUvdjk3RUpi?=
 =?utf-8?B?d3lub0R2NnNkNXFyMjBQaTFHSm1OdzhEZ3hIQW00NjRGZysvcXNwWElEdGI0?=
 =?utf-8?B?ZEJicnZ6ekNhNm9kTmhSNStZLzk4TXFUWGE3dG1TcGd0N1ozVTBRME5jRnZp?=
 =?utf-8?B?Q1kvb1lHL1N5S3I2dytCNmZ6QTJjN2tGejlFLzJzc1FFY3prVUhWMFFDYzF5?=
 =?utf-8?B?a3pnNS9nY2gxU2NvcHNDWENEM0VWQ1JsbTRkNmU1b3FRS254OGlhZ3ZpM2tP?=
 =?utf-8?B?blZOcU1NcEY3TWJ4L2plTVpZV09JN2VmT0hBVmZ0WnZqQVhTd1dNZENFelRM?=
 =?utf-8?B?ejA1dTNLQUh3QSt2b25KVEQxcmNwT1ZOelRGMlZ5VjVZMjVlemtNZ01SbDZF?=
 =?utf-8?B?ZHdPb0taVFpNUU5LUzl0TEFQWEVlMWNEQ2orbGxJNjEyTzM5V2puVUh0Uyti?=
 =?utf-8?B?US93bFU0MUdmejM4VjFBM21LUlYwajlQeDFDd1lqQUhBOU8rYUlpdW9pSWFP?=
 =?utf-8?B?eVZXb2RwQ016V01USjJ6cllodkg2ZGttK2VQNE5Sb2FyYXNFaDlyY3QwY0VV?=
 =?utf-8?B?ZnhTWmUxUHlCeTBPMUMyMGJzWjNNVWVhQTk2SHpRMkNTdGFZTkVzaXJYVzRM?=
 =?utf-8?B?dXJybFRBZ1luR3BRSjgrYTlqaTZPdkQyZ1Fyb1JuNWlVdU5aODRCK3JYejNh?=
 =?utf-8?B?SUQxQWdSVUEzU2VVM2RWclZCZFlua3BUaFFQbUQzY3JJVkNDOWRyYURNS3Nv?=
 =?utf-8?B?czN5TzZzYUppM1c0WndsRjkrMjIzVnAzelJqbWZncHc5ekI4UFhYWnZldVdr?=
 =?utf-8?B?dDN6S0FIY0dsdmpPUkZqbWwwK3I2Mk9yVDBSbzc4Z3pPb0lKcTJjU3BCdjBK?=
 =?utf-8?B?b1UwbW1sdCtnNkdlOXVJNUZqZ241dnVpemwxNUd1R3dkL2tVN2l4UnV5b2ln?=
 =?utf-8?B?cGxpazcvYTRpYlR3anQzb0FMblBBbFU0SjR1K2VyeDJNQ1l5VTZDbkhCOUpG?=
 =?utf-8?B?dUJPT0NjTEZvSWFKM1gra1JkWVlvdnZoNTZ0Q2llNzJFMGxHK05Ib1lqcGk1?=
 =?utf-8?B?MEdFYlExTDBCWXhVa2t4eGkrV0pDc3ZNR0RPZTZMaDd2SUVHbnVSR1BSVnE5?=
 =?utf-8?B?Y2hjWGZRbGE2SnBWZkNUeHFiY3FDOVRZTUtReHFISDNCbE5TVndqWFo1eVNr?=
 =?utf-8?B?V0QrWUQ0RFpRTUZqQW0relNFRGhlNkFkYlo5N2xsNVVndEs5Kzl4TlVZUms5?=
 =?utf-8?B?NXlDREw3NkVoVEpXWE10NWtoZm1DcTNxSVl4UE1oUUhKSHd4NGdTZ1k5NWJZ?=
 =?utf-8?B?YmFEaG94TUh0T1lFcTZyOUhuNHJpaWhlVUZsVHVhalFKcC9WWkllN0Jzdm1V?=
 =?utf-8?B?YkxDWWdMUmRSTDh0ZlYyaGx6NG1FWU0ycVN1c0dMVDcrdU9MYWhyK1IzZWFz?=
 =?utf-8?B?VlRFOUhtSjVlTXMvOEthVWVNcmIrSU1vUktWS1pSZkpLSXZ0OUNTWFVVZHBi?=
 =?utf-8?B?MnM5UmE4c2hNTXQ1c3NYYmJBMG16SzNNYStwZS9GR0cySFIyK1A2UnZ0dFBI?=
 =?utf-8?B?enBXOEF5Rm9NUTJwUDJvMk9PK0hyRlJrelJzQ2Nmb0o1bThKS1JiREpUQ2xF?=
 =?utf-8?B?cW5pbjNvcnluV28rODlJb2UxTzIzNVdpOUxwRlYrQ0RxcS9COWV2OVRkZUNZ?=
 =?utf-8?B?UkhLRXRDM2FrL21nejdWUGhaS3V2eTBJNmNPTnZFVlNVVGNlN1ZWM0QvTkh1?=
 =?utf-8?B?WVFOSjB2V1ZjRWFtclpmS3VNMWcxUjZzM2RSM1lwaHcyK01UeERpZHdoa21z?=
 =?utf-8?Q?NUUWdtx8G9rYQoEpmOPxE4qbN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017dea2c-0134-4a5b-0248-08db1a8bf624
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:34:23.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGfdUL+yDW5X9ZytHjOjQ5unbqkiXm3lnMHMgH6t0tWzTTnXy5RtS80rfcJy3CjVVniRw8O4WelmutC7KuEHcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/22/2023 3:46 AM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
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
>   #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
>   #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
>   #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
>   #define MSR_AMD64_SNP_VTOM_ENABLED	BIT_ULL(3)
>   
> +#define MSR_AMD64_SEV_REFLECTVC_ENABLED			BIT_ULL(MSR_AMD64_SEV_REFLECTVC_ENABLED_BIT)
> +#define MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED	BIT_ULL(MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED_BIT)
> +#define MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED	BIT_ULL(MSR_AMD64_SEV_ALTERNATE_INJECTION_ENABLED_BIT)
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

Do we need clearing of "no_further_signal" here? as we reset it in the 
handler (do_exc_hv()) as well?

Thanks,
Pankaj

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

