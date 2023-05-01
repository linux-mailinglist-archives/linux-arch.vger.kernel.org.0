Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFA6F3321
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjEAPrB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEAPq7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 11:46:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D611A;
        Mon,  1 May 2023 08:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIAT9hSfNe718l4NIuBVvY9Kv5DkJNl7psf43VuVhleWk1D9t/fUN+dzvZROEIvweulMWDC3DlHU8eB2djZe2vIfdEbos72xA51Nk86OIB0vC9maeCEC6mWyFWD5jzYD52P7lmgCMX9SwKzSO/9TyiVZoVeOTKyjFGbb4ya4GxYdm4iMrGtJ9zCqKx5nGdyC9ogh0IptvF+mUiJy1qijyhSHZnbL3gxDdzPf1czZmkiz3bStrVPCTiHV7Iu49pzi/toJoiWX05S8L0XGeoxRIuPnlbyXN+0r9LIWmLb8sJOKhGxiL3xg08fzBNoPO5omlSkK4+lnFZLPPhba5PdHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lnl20FglT7hdz94THSUYyaedb/0IZcF7fhiIVpSKgiE=;
 b=h1K/beM8nut+A5ySWVIGuY7382GC7g8Zs1n1wgEhh2k7pqMArWhOEMviP/2Lb9Z5CfCXhh9qS/wZxS4ggc7P2uX/lieZAiKR1czWfYEKzMgiauoyU+I1Pvupdc1uoeepYVX+p1R8kWOmXd73zkkMxQIM2gTCzGOw48XamDM9n9lMcFogoNKUQHijqba3uUAXLllUraTdL7wUXcoTNZvKoaxuFe0pYhzKj3zPqzji3hfZiSXgedxlgmP7OnJb8UoA2nh0KgESesZow+8kYpiqi8ZVooVHrpgXUanAMU9fkZSF/8EN6xgzafeQrFEFs7qNseFbUXvw1gJmNRv0ninaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lnl20FglT7hdz94THSUYyaedb/0IZcF7fhiIVpSKgiE=;
 b=gmfXZR5lV15ItVuP8EA0YiwFdoFJngUaPW/EsntUH8aNK4SLrw1WKPCg4xbCgRk4re+2V7kw4mrq4aRdnO4D6evjaiRDArYFCKzfn2sA0EmM9K2JkJdQ5heucwyBjZlEqw479V7NuIfvanGGAcdTIIrVDcB4EJCWe0psEolqA34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:46:52 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:46:51 +0000
Content-Type: multipart/mixed; boundary="------------SdHdWL8o2hBzTnR6dSaktU2W"
Message-ID: <5038c185-b9de-bc88-9f77-75d83501eb96@amd.com>
Date:   Mon, 1 May 2023 10:46:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH V5 09/15] x86/hyperv: Add smp support for sev-snp
 guest
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
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-10-ltykernel@gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230501085726.544209-10-ltykernel@gmail.com>
X-ClientProxiedBy: SA9PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:806:28::13) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5f4d5e-68b3-45af-8e21-08db4a5b481e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JZoT9tobTuZppSzWfZMz1vnhsDsHy5q4CzUeNKp/Su515ksMiXIR3wOYxp1PDNzHXiCVgDMde9WyB2KFM3aRDQZfTp/yzn/GBy7m0XOEDo0FaSpKQLukgAmPK35XM6bhQ0FG5jMOPSkPvwma4h/IVhVHqVJGmM7W7cQkLFi1aPen/SZW0WpdwKLm+54clVflu3CgNRjUeKo3E7xMF1Au96WSk8kDfCDjgDRg5Ud1dmqdVhJKUNSSxIif0ds4mDBeln/L2YXRf2PH8raiQcd2r85af2wtamfK/vKmAnkxrDlVfl9ieyasKpPCASL9mJD5kDhEf42wxwwZE5hsW4E8XA5j8v4d57rIouGAyKKnrPsrbRTNvngkc37L0mFu7yJvYakiuLIccCwBMc/fqXofB58CjfWOF+jNBT7WUNPSNXxwV5ENMAnKchuWrmZ06l/Way2iFn0R2pU/wLl/TQaWo9XxnQwBv/bbuVHuQQdQYhbn9iq3dcvI80dWB7W5JfjOoXXzfzNLRE9xWmfMGPpHvzWt8hhcBhEJV5x+l+4x08txVa7vYShGaeNI80SFVLquu+Dt77l9waeNUGg8bhSIKi4XUETuf2Kqnj0SJIU02lEYXeYVJBX7CY411C0bB05KAfGkpm/Q8Axb7ziIACdpFJsZmm+OcmnS02wOVy21uQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(31686004)(21480400003)(316002)(53546011)(26005)(6512007)(6506007)(8936002)(7416002)(5660300002)(235185007)(8676002)(7406005)(31696002)(86362001)(478600001)(45080400002)(66946007)(66476007)(66556008)(41300700001)(2616005)(83380400001)(186003)(30864003)(38100700002)(36756003)(921005)(2906002)(6666004)(6486002)(33964004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUFwbjMwT3ZHc1Z0V2lvbUFFSEo0K20zdWt0NG9xOEtyZFpYVXRoWXJVSFhy?=
 =?utf-8?B?bS9XTzIrRllXMCs1cDY4bHUrQjBxcmFneU1aZWVPeUxLb1lMd0NPUW9iaDNi?=
 =?utf-8?B?Y3BJa2VMaHlJUG9meHVXd09YUFNGTmE2M0xjWFgzZXJGaHJlWGJMTUlPSnV4?=
 =?utf-8?B?S0VJY0RtZEhjVkpxSGJQUnBOcmhDKzdxMFJwOGRMV3Jkc3F1S0w4b2JaTEtm?=
 =?utf-8?B?cHBHb3lFdkViZmpPaEdtS3g5V1VVSllSMGxKSHRjUkhXSFYwMitGMVBYWDZH?=
 =?utf-8?B?M3dqYUlaYWJIdUdwSjhZdGM3dllqSlRQdXJMRnc1L0dZdHUvb0o4bmQ3SHNr?=
 =?utf-8?B?M1hVUjVnbFRnOGl1UldRRkRmcXVkWHBBWU1mc0M3d05tVzFSSENLOXFDRit3?=
 =?utf-8?B?YkRReGxDaG9tNGVLNjJZRG1YRE9YR2RZWVBmY2ZUZW9pbjlzVTYwSDRJUjUw?=
 =?utf-8?B?WmhMUXpRYnRQZkQ2YyszbUtVZXFMdWFmeTZBUjVKSUpYYzlKcHJwN3p1RzA5?=
 =?utf-8?B?Q2FJYkFPeXZHcVdoRTUzYktlRXptbDJFRWthZUxmdnNtMzErT3dLTlFtUTh1?=
 =?utf-8?B?MERldnZSZGo2ZCtjUFNTbGREbnlPWENMT2U2d3c4cVZwb3FJNkd1Z0kxRG9O?=
 =?utf-8?B?UnUrdWwvQmFJYzRsa2txUlVOaWttSmJFbHpHOEQwWFhuR3NGNnJJSUpYMGls?=
 =?utf-8?B?QTBORHp2MHBzUUhpMzUvdFhKMWZkRWIvMm4zYjJqRGdzRUo0M2RnZGw2SlY4?=
 =?utf-8?B?bDZUM21GRFF0aElKNlhWUzhXRDcwdmRPSHIzaXVOTzVYQkFJMHA1aGplWUlP?=
 =?utf-8?B?UWtDdWFCdDVTVnRuQ0h5MGRhdHdlVllOalRnSEFXVDdXTktXUjJrVGx0UkVl?=
 =?utf-8?B?Njh6cUdXRHZQSDVhMno1WmgzcFRwQmxaL2ZPRXVjeDZFMGFwVGptejJycFRU?=
 =?utf-8?B?M1lxRlJsNkluUmYyVEs2RE1kelpHRlhKYWNkVUJrcUtGaXBkS0tINFJ5VEdQ?=
 =?utf-8?B?azhuejRsRmRlWGJlQzZDSEY0dEVPcjYySFR5a3pnQ1UwTUhHWnhyaUlXYjQ4?=
 =?utf-8?B?ekllR3lqa3FycFl0MStDMUNSK2NTSFlTeUlQOFN6ZnhwWFdYU3NHL0NDUU5N?=
 =?utf-8?B?R3ZmUC81aFJOQlJBcVZJRWVoaDFUWFpBaW9EVWhldjdzeDNkeHVwbzVTUlhW?=
 =?utf-8?B?RWE2TGRETldEcVFKMXYvcU45TUJkSjR4Q2tJTlJESlFBelRwWFBqeDBHT2JH?=
 =?utf-8?B?bkpSUXVwbC9pVjlHMStsU0lyZzREMDlyT1N4dlRMdmQvOWhzaWtBRElwWG1S?=
 =?utf-8?B?SFZkOXdac1hZQ0tpYTIybkZjM1lqaUNKT2lXYUt5dVhHTER0TDcwL25vaTMw?=
 =?utf-8?B?bCtadXVFcWIyV1p0ZmxYbWlRNFpDTVpXaXBSV0Y1NjZFamVlM2FvUE1RZjV2?=
 =?utf-8?B?VGhWUUI1L2VxM2VPYkJNV3FSd1E3Y1dXc0VtUjZ5eERFM05uSGZHeHR0UlJJ?=
 =?utf-8?B?RnEyOURSY0E2K1lCbndMRCsrdlZBWTduNDhMd1ZDNW5HTm1abEN4L0VIUm85?=
 =?utf-8?B?R2VpcjZZd2tZemprT09jaElvUEpUSWdIaVg5Q3JzRGZ6ZXBzZXc0VEZPemlW?=
 =?utf-8?B?cE96VytieE1mV1N0L3F0aFNEc2NXYjJNWjN3eHFtSldlNndYMzdaZnVSeTUv?=
 =?utf-8?B?T2hUWlZKMm1OTWhDOTZISVZnb2p1UFdHNXpxcXkzSFBXSGJiWnlPNEE2YjBv?=
 =?utf-8?B?eG9aY2pHbFdUTWlQQXVzNzZtSEo0RlQ4MENiRk9SWWJLdVZjVkI4WjF6VG8x?=
 =?utf-8?B?WC9BVGs0NjVrZllaSm5jTG4rbFBTUFNLVU43dzNDaGUvbVgwRXRzTU9PMy9y?=
 =?utf-8?B?L0EwSjdwMWM4OTQ4cnhPTWt2ZW8yaWcwSnF0dUthSHF1UFFuNE1GZERXV0V6?=
 =?utf-8?B?dkRFQlFZWUJvSDFINUViWVB6SXlDY095R2YzNXVLMzEzM3o4Sjc4dCtnaGx4?=
 =?utf-8?B?L3YwaTVRZ1dzUWl3L1krVjJEbzJuRVJ6NGw0eEJ4Y1l5N0p1Z2hVSGdLdkUw?=
 =?utf-8?B?Wm1hU284MzBFcEE2T0kreGhsMTVPTTR0b1I5b1RSQ1NXLzNzVUJXaTJUbkk3?=
 =?utf-8?Q?X56itpZNzXhpipZvWJrpwCfNw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5f4d5e-68b3-45af-8e21-08db4a5b481e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:46:51.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXRzhcsyT8ivZilAePyNiBWcyHOqrGcDHhgnJbgSB0eOvkVzTHAxHmskvVmoJIr+pg/DSyOMoIEvSqNf3fMqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--------------SdHdWL8o2hBzTnR6dSaktU2W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/23 03:57, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> The wakeup_secondary_cpu callback was populated with wakeup_
> cpu_via_vmgexit() which doesn't work for Hyper-V and Hyper-V
> requires to call Hyper-V specific hvcall to start APs. So override
> it with Hyper-V specific hook to start AP sev_es_save_area data
> structure.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change sicne RFC v3:
>         * Replace struct sev_es_save_area with struct
>           vmcb_save_area
>         * Move code from mshyperv.c to ivm.c
> 
> Change since RFC v2:
>         * Add helper function to initialize segment
>         * Fix some coding style
> ---
>   arch/x86/hyperv/ivm.c             | 89 +++++++++++++++++++++++++++++++
>   arch/x86/include/asm/mshyperv.h   | 18 +++++++
>   arch/x86/include/asm/sev.h        | 13 +++++
>   arch/x86/include/asm/svm.h        | 15 +++++-
>   arch/x86/kernel/cpu/mshyperv.c    | 13 ++++-
>   arch/x86/kernel/sev.c             |  4 +-
>   include/asm-generic/hyperv-tlfs.h | 19 +++++++
>   7 files changed, 166 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 522eab55c0dd..0ef46f1874e6 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -22,11 +22,15 @@
>   #include <asm/sev.h>
>   #include <asm/realmode.h>
>   #include <asm/e820/api.h>
> +#include <asm/desc.h>
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   
>   #define GHCB_USAGE_HYPERV_CALL	1
>   
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
> +static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
>   union hv_ghcb {
>   	struct ghcb ghcb;
>   	struct {
> @@ -442,6 +446,91 @@ __init void hv_sev_init_mem_and_cpu(void)
>   	}
>   }
>   
> +#define hv_populate_vmcb_seg(seg, gdtr_base)			\
> +do {								\
> +	if (seg.selector) {					\
> +		seg.base = 0;					\
> +		seg.limit = HV_AP_SEGMENT_LIMIT;		\
> +		seg.attrib = *(u16 *)(gdtr_base + seg.selector + 5);	\
> +		seg.attrib = (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
> +	}							\
> +} while (0)							\
> +
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip)
> +{
> +	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
> +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	struct desc_ptr gdtr;
> +	u64 ret, retry = 5;
> +	struct hv_start_virtual_processor_input *start_vp_input;
> +	union sev_rmp_adjust rmp_adjust;
> +	unsigned long flags;
> +
> +	native_store_gdt(&gdtr);
> +
> +	vmsa->gdtr.base = gdtr.address;
> +	vmsa->gdtr.limit = gdtr.size;
> +
> +	asm volatile("movl %%es, %%eax;" : "=a" (vmsa->es.selector));
> +	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%cs, %%eax;" : "=a" (vmsa->cs.selector));
> +	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ss, %%eax;" : "=a" (vmsa->ss.selector));
> +	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ds, %%eax;" : "=a" (vmsa->ds.selector));
> +	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
> +
> +	vmsa->efer = native_read_msr(MSR_EFER);
> +
> +	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
> +	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
> +	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
> +
> +	vmsa->xcr0 = 1;
> +	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
> +	vmsa->rip = (u64)secondary_startup_64_no_verify;
> +	vmsa->rsp = (u64)&ap_start_stack[PAGE_SIZE];
> +
> +	vmsa->sev_features.snp = 1;
> +	vmsa->sev_features.restrict_injection = 1;

So this means that any other feature bits set in the BSP won't be set in 
the AP? Shouldn't you be using the BSP value and checking to be sure what 
you really want set is set?

> +
> +	rmp_adjust.as_uint64 = 0;
> +	rmp_adjust.target_vmpl = 1;
> +	rmp_adjust.vmsa = 1;
> +	ret = rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
> +			rmp_adjust.as_uint64);
> +	if (ret != 0) {
> +		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +	start_vp_input =
> +		(struct hv_start_virtual_processor_input *)ap_start_input_arg;
> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
> +	start_vp_input->partitionid = -1;
> +	start_vp_input->vpindex = cpu;
> +	start_vp_input->targetvtl = ms_hyperv.vtl;
> +	*(u64 *)&start_vp_input->context[0] = __pa(vmsa) | 1;
> +
> +	do {
> +		ret = hv_do_hypercall(HVCALL_START_VP,
> +				      start_vp_input, NULL);
> +	} while (hv_result(ret) == HV_STATUS_TIME_OUT && retry--);
> +
> +	if (!hv_result_success(ret)) {
> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
> +		goto done;
> +	}
> +
> +done:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
>   void __init hv_vtom_init(void)
>   {
>   	/*


> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 13dc2a9d23c1..0d57cb1c1bb4 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -88,6 +88,19 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>   
>   #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
>   
> +union sev_rmp_adjust {
> +	u64 as_uint64;

Why not "as_u64" or "val" like below ?

> +	struct {
> +		unsigned long target_vmpl : 8;
> +		unsigned long enable_read : 1;
> +		unsigned long enable_write : 1;
> +		unsigned long enable_user_execute : 1;
> +		unsigned long enable_kernel_execute : 1;
> +		unsigned long reserved1 : 4;
> +		unsigned long vmsa : 1;

Please do these as
		u64 target_vmpl		: 8,
		    enable_read		: 1,
		    ...
		    vmsa		: 1;

But why not continue to use the bit definition format that already exists 
in this file (just above what you added)? If you want to do these union 
type changes (here and below), it should be a separate patch that converts 
all the usage sites and then this patch can be purely functional.

> +	};
> +};
> +
>   /* SNP Guest message request */
>   struct snp_req_data {
>   	unsigned long req_gpa;
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 770dcf75eaa9..cd6bf989d918 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -425,7 +425,20 @@ struct sev_es_save_area {
>   	u64 guest_exit_info_2;
>   	u64 guest_exit_int_info;
>   	u64 guest_nrip;
> -	u64 sev_features;
> +	union {
> +		struct {
> +			u64 snp                     : 1;
> +			u64 vtom                    : 1;
> +			u64 reflectvc               : 1;
> +			u64 restrict_injection      : 1;
> +			u64 alternate_injection     : 1;
> +			u64 full_debug              : 1;
> +			u64 reserved1               : 1;
> +			u64 snpbtb_isolation        : 1;
> +			u64 resrved2                : 56;

Ditto here for the bit definitions and fix the spelling of resrved2. 
Although, as above, why aren't you expanding the use of the bit 
definitions that are in here (SVM_SEV_FEAT_SNP_ACTIVE) instead of 
modifying the structure?

> +		};
> +		u64 val;

This should be consistent with what you do above in the rmp_adjust union.

> +	} sev_features;
>   	u64 vintr_ctrl;
>   	u64 guest_exit_code;
>   	u64 virtual_tom;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index dea9b881180b..0c5f9f7bd7ba 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -295,6 +295,16 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>   
>   	native_smp_prepare_cpus(max_cpus);
>   
> +	/*
> +	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
> +	 *  enlightened guest.
> +	 */
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
> +
> +	if (!hv_root_partition)
> +		return;
> +
>   #ifdef CONFIG_X86_64
>   	for_each_present_cpu(i) {
>   		if (i == 0)
> @@ -502,8 +512,7 @@ static void __init ms_hyperv_init_platform(void)
>   
>   # ifdef CONFIG_SMP
>   	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition)
> -		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
> +	smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
>   # endif
>   
>   	/*
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index b031244d6d2d..20f3fd8ade2f 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1082,7 +1082,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
>   	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
>   	 */
>   	vmsa->vmpl		= 0;
> -	vmsa->sev_features	= sev_status >> 2;
> +	vmsa->sev_features.val = sev_status >> 2;

Looks like maybe the tab character was lost here between val and the "=" ?

Thanks,
Tom

>   
>   	/* Switch the page over to a VMSA page now that it is initialized */
>   	ret = snp_set_vmsa(vmsa, true);
> @@ -1099,7 +1099,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
>   	ghcb = __sev_get_ghcb(&state);
>   
>   	vc_ghcb_invalidate(ghcb);
> -	ghcb_set_rax(ghcb, vmsa->sev_features);
> +	ghcb_set_rax(ghcb, vmsa->sev_features.val);
>   	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
>   	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
>   	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index f4e4cc4f965f..959b075591b2 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -149,6 +149,7 @@ union hv_reference_tsc_msr {
>   #define HVCALL_ENABLE_VP_VTL			0x000f
>   #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>   #define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_ENABLE_VP_VTL			0x000f
>   #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>   #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>   #define HVCALL_SEND_IPI_EX			0x0015
> @@ -168,6 +169,7 @@ union hv_reference_tsc_msr {
>   #define HVCALL_RETARGET_INTERRUPT		0x007e
>   #define HVCALL_START_VP				0x0099
>   #define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
> +#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>   #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
> @@ -223,6 +225,7 @@ enum HV_GENERIC_SET_FORMAT {
>   #define HV_STATUS_INVALID_PORT_ID		17
>   #define HV_STATUS_INVALID_CONNECTION_ID		18
>   #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT                      120
>   #define HV_STATUS_VTL_ALREADY_ENABLED		134
>   
>   /*
> @@ -783,6 +786,22 @@ struct hv_input_unmap_device_interrupt {
>   	struct hv_interrupt_entry interrupt_entry;
>   } __packed;
>   
> +struct hv_enable_vp_vtl_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
> +struct hv_start_virtual_processor_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
>   #define HV_SOURCE_SHADOW_NONE               0x0
>   #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>   
--------------SdHdWL8o2hBzTnR6dSaktU2W
Content-Type: application/pgp-keys; name="OpenPGP_0xDEFF9AE44F304D53.asc"
Content-Disposition: attachment; filename="OpenPGP_0xDEFF9AE44F304D53.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: 7bit

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=wb2K
-----END PGP PUBLIC KEY BLOCK-----

--------------SdHdWL8o2hBzTnR6dSaktU2W--
