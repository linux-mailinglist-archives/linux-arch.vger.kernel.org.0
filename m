Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAFA43505B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhJTQlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 12:41:25 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:54657
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230049AbhJTQlY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 12:41:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY6rzaFImNEYsybf5FNu8+QSQJSu4lL4yXVvSOkY9E1oDl8Vo1yh85VsWf83U0tbJ6eKhaf1zIZ6oSE1PFzdrY2yvBjPD/8d4LA6O423cKV9SUlPqwmgpCCT+YfOJA/F7ginlKojzNdRAky0a8o1IG8orotP5olQqNugqXapnYNJtMyuE3puciiNktPZHrFjEiDU3BEEgbRGdzGkfTVfWuOPO8yt1LB0mrsQJNFx32M9dS5AMBjLxhHk9u83aA6L+58cduLxMme4rWL1T2QxplbOiVnzW2bIvV/tLX7cvXs3O7LEDQkzLsDPXcMPvJ1QjDbabGeZF2+9n1ghrl6uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r3FkA3+7/zIwxnpuEC09EorlnRS8FrHv5y1Pz5np4Q=;
 b=cbCOI7rBvWpjFVla1LQ4sc/LrL/JLGmq3srf8kv4AdUFkm2Wnq91P7G8pL+PnP1rYBcLPh4VL2sbf20tuJOPzt3lHF3jnYKv8QlHVaJFi/q9fm1c0ae+MwvKP1i1uV8C+urfXr8mAJfu2VcnMj6tyHEPQ8o9+Q8EfW6jXuUSehFT8sTxzO6R8EyRt9hbEC2XkwdVA5CkGSTj37mmGIuqGQ8B7yZnwX0h+WZ84cwrpuMe21LnK+t0Mlb9hXCR8SneuRC8qG9w3MfvUtupXKbrPoWTBEfDu++dB+LgovBjuUj8H+J54nKqe3geDt0cEy+Ue7ipimqjNDiHZJlu7LBrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r3FkA3+7/zIwxnpuEC09EorlnRS8FrHv5y1Pz5np4Q=;
 b=Lyzxh837H53C/AWKoOofcyVhJY6d2JIVssqeAOdO4lZEMRulJw1aNUJExOJ3cpSqhMi6UoazwwN6k1asctAm5oBY+ychm5WfFKjpqKmeKjLMgqSDE/vPk1tTOa+5S/Lv29IQ6G9rx7b8xKV/ZjNBidcziXcQzZdg9L6XMIz7agQ=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 16:39:05 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 16:39:05 +0000
Subject: Re: [PATCH v5 07/16] x86/kvm: Use bounce buffers for TD guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-8-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <42f17b60-9bd4-a8bc-5164-d960e54cd30b@amd.com>
Date:   Wed, 20 Oct 2021 11:39:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211009003711.1390019-8-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:208:e8::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by MN2PR20CA0010.namprd20.prod.outlook.com (2603:10b6:208:e8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 16:39:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 099ea61d-b18f-4f31-07c0-08d993e8216f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5118:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51182B348FE1553219696CF3ECBE9@DM4PR12MB5118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnMaLp0nknk0GXDUemdk5qBXyq6HF6Gx3vh9eZi6i4PRDryuIQ1FPZrANQ9K/nTHuqxd83NdZRxKg6aBmXjsmVfy0y7eO8Mw4CzFizhvryEF0C0t9Xyp3VnjGBrsCkQiPubuuT1T75nsAXVfu7o7ora0oKrcNG/58lON0xDasbDG6F6NBb0FGrDJLXhzeJzNoir99GTqHvtW62Mq3P28JyjxosiQy6mT0AlH3FUO+lzyjfcQw956WbWAG/c2XFiUEnMI0fGQkYQCNzTWIR8AZlVtKQPeZNQYmJ5mMXmHqz96qhhCQFGDZvT4AV6k7i2JsPV9VS2azQFOCoiX/ZuUrVS0PNIeb7rMoGKykOFghE5CpV+Sya4LKNI83kiraEFzSoCTRSjJM3BgGkuZtB69CvA3qFX3TZ/q8KEAslm0IOmE6ZQc2SqS1oNxI07PjpGrBgqx0kNuj5gE4szYRyXcZL+2YAiw0F5iFspedqoWEx0s2L8kKMPdQgrXedHPb8rPSIuf1e3ytjiq/FFqb9/dv4W98POEePDP/CNlt5TDqWhIdC0RBVF9YuJ4bDldyx4K0pc5zfi6y2wGhkskFieJNbAesZJaBl6rEjHjXIZgh6JMCEqfoIIp7zT4zIChB8RrJX8NNSZLdPtis6OB577F0meARnyVgExezk7C+Aj+TXv9qNZWQwrotl+xu0GLsDiIxY3NY3ybfhmSIsNLDjbBko4VRlNCOqVa72JvI66UM7lLUtz1bCC0uDJLMKP8j+Q2/aCXi3TzRw32Pxk6WZQhnzf7vB0wXk3sjUFmSfJXdsz+2znIZdq2SvJzruYWiOzz/I9ai0BrHRF6qmR1scUpLY2IZscLQPAjPBy+KzU3Lzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(31686004)(8936002)(86362001)(921005)(6486002)(26005)(38100700002)(186003)(2906002)(53546011)(4326008)(54906003)(110136005)(8676002)(508600001)(7406005)(7416002)(16576012)(316002)(2616005)(956004)(66946007)(31696002)(36756003)(83380400001)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UldBZDZQNEdKWFI2Y0k0cHZRcUNwNVoyVjdMTGticmFUMkVGV0lEczN1QUxM?=
 =?utf-8?B?bFh3dVlwdUplZVd1cUdYQTJqZ09iNmpNWUJiUVBvZFN1dmhvQVpVaXpqVUFO?=
 =?utf-8?B?VDFFZnQ5eDJMdGxiUXc0d1VDUVhGcVNCWkhqYTltaVFmM2pJL0lGVEZ6aTIw?=
 =?utf-8?B?ZVVTS2dGb3pqRllXM0RIbTVyYmt4am5Rbkl5a0hVVmVPQ0lMQ3hISmt2SkJ1?=
 =?utf-8?B?YVNVRWVqVExzcFFMOE5XbDROQzlYeG45K3k4d1lwNW12aHBGVEJPNlJFcStx?=
 =?utf-8?B?UlNCZHczeHNIRTdFVlArQS9jalpNSDFTZExvYUEzKzBaRGY0cjBOc2ZpbmFj?=
 =?utf-8?B?WVNxeTJjd0Nkc2lGeVJ5ejFGWWt1REVYUjczUFQvTXgzZVArczg5UEl1aWVm?=
 =?utf-8?B?djkxR0JxM1h2ZGtqQzllMjRQOWIxeHExa1EvUEF4T2drbWI5MkFkUUoyK3ZD?=
 =?utf-8?B?a01NenRHeHFTRnBEQTdpellLVzdqbjZkWk5PZ3VOVXJNcHdaUnJjOGE1ekVL?=
 =?utf-8?B?WXNTcW5DSCs2S2tCSGhhYmI2SjVMeUNJVjhkbm9GRThya1FRdjdmWndaUXRJ?=
 =?utf-8?B?TGtaUGVuczVVVTR4NG4rb0tOS1cybGFZSE5HWEdPQ1FoellNc3dNWWdaeEtH?=
 =?utf-8?B?ckZITFlOVW1pT3FWMFRMdlBHRUFybG1MOXVDbi9OMWlaVGZiSDMwMnVtL2o0?=
 =?utf-8?B?ZGFjN1dlYVd6a0ZuMUJCQndXK2xQZVc4RWIrbUlyclV6VFNRZWFRRWVuanov?=
 =?utf-8?B?MlJzdHFVek9KNVR1eUJKcUM3NlBEUVJ6N2l3VGRZVGdVWStVLzZ2cm04cGNF?=
 =?utf-8?B?Y2NoS2tZMWszK3VMbVEralJaTG1xSjZzL3BlYzh3dks5M05POC9wU3BSeUVC?=
 =?utf-8?B?ZlYydnIyVFRiMHFjZi9GSWpjdmJxZmZ3dGNzbWozZ2E0U1MxSHpnRHFMSTh3?=
 =?utf-8?B?SllRTVU0dmY0REtWTW1tWG4wS1lOc3l4RGlxQVk1OXpZL1dJQlhFaG5wYTlj?=
 =?utf-8?B?bU9wZE9QTlV2dFg1MTVrM0NTS25jVkFvQkxhaTU4MVZPdk80YktKZDdncmFr?=
 =?utf-8?B?TWpqKzZHQ1d5RnczeXdjMVZFMFMyS3A4MXMvU3daVmJFdldtMnMxd3FiZSti?=
 =?utf-8?B?Y3ZYWUFqZGdzMis5S25HUlpEeFM3V0RNeldCWnE4dFVydktDMXl2aCtnMVdZ?=
 =?utf-8?B?SVJFNjhHbmhqUHd2NHZnSURYcmVyRzA2YjR1dkRRb2hMOStPa1ZpNzhJNnVw?=
 =?utf-8?B?bU5sTjFWdWZKVUVOWDcrUGVjZ3h0bkJVN21ZZ3JMbG5yeXZsR1ZiK3pvTjRU?=
 =?utf-8?B?ZlpvZTdmL3VUOE9rdXVaM3J2clkveVlsaDRqVWFLVERvWjBjRDZCaDVtK3N3?=
 =?utf-8?B?VEgvLzFZVTNoMUUxMjdnYTQ4MEROelVwSngzVlRMOWFIbHlTUWZMSTdUdW0w?=
 =?utf-8?B?a0VzRmZpSEhvUUFGV01vVXRnQlFTdkxSdUJidE4rZHdEQ1d6OUJKQzFSWFBp?=
 =?utf-8?B?ZmdoWitRRGdDUTdhbFdxOUFJcFR5dCtLdVVlQTdLQ1BJNnY0d0RHZ2lOZVJl?=
 =?utf-8?B?aUhOb0daS0lxSnFuQnFtUWo3M1F1NlUrOWFNRjRHaGhZcFM0YWVROW01eDV6?=
 =?utf-8?B?RHlaMm0rZ29jalVld3hkdlQ4ZmM2MHptWFFTRW9yMitYMU5DSmhLMlo0S3py?=
 =?utf-8?B?ekU5UnBNcVZ1dEZhd1BxQTJWVTNKZmxma096d3U0N1RINDA1N3dKQnlUZUQx?=
 =?utf-8?Q?AqbbaEDkAi0YGUPIBTKLaO6OQNg6yT/lBreAHfI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099ea61d-b18f-4f31-07c0-08d993e8216f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:39:05.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/8/21 7:37 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Intel TDX doesn't allow VMM to directly access guest private memory.
> Any memory that is required for communication with VMM must be shared
> explicitly. The same rule applies for any DMA to and from TDX guest.
> All DMA pages had to marked as shared pages. A generic way to achieve
> this without any changes to device drivers is to use the SWIOTLB
> framework.
> 
> This method of handling is similar to AMD SEV. So extend this support
> for TDX guest as well. Also since there are some common code between
> AMD SEV and TDX guest in mem_encrypt_init(), move it to
> mem_encrypt_common.c and call AMD specific init function from it
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v4:
>   * Replaced prot_guest_has() with cc_guest_has().
> 
> Changes since v3:
>   * Rebased on top of Tom Lendacky's protected guest
>     changes (https://lore.kernel.org/patchwork/cover/1468760/)
> 
> Changes since v1:
>   * Removed sme_me_mask check for amd_mem_encrypt_init() in mem_encrypt_init().
> 
>   arch/x86/include/asm/mem_encrypt_common.h |  3 +++
>   arch/x86/kernel/tdx.c                     |  2 ++
>   arch/x86/mm/mem_encrypt.c                 |  5 +----
>   arch/x86/mm/mem_encrypt_common.c          | 14 ++++++++++++++
>   4 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt_common.h b/arch/x86/include/asm/mem_encrypt_common.h
> index 697bc40a4e3d..bc90e565bce4 100644
> --- a/arch/x86/include/asm/mem_encrypt_common.h
> +++ b/arch/x86/include/asm/mem_encrypt_common.h
> @@ -8,11 +8,14 @@
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   bool amd_force_dma_unencrypted(struct device *dev);
> +void __init amd_mem_encrypt_init(void);
>   #else /* CONFIG_AMD_MEM_ENCRYPT */
>   static inline bool amd_force_dma_unencrypted(struct device *dev)
>   {
>   	return false;
>   }
> +
> +static inline void amd_mem_encrypt_init(void) {}
>   #endif /* CONFIG_AMD_MEM_ENCRYPT */
>   
>   #endif
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 433f366ca25c..ce8e3019b812 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -12,6 +12,7 @@
>   #include <asm/insn.h>
>   #include <asm/insn-eval.h>
>   #include <linux/sched/signal.h> /* force_sig_fault() */
> +#include <linux/swiotlb.h>
>   
>   /* TDX Module call Leaf IDs */
>   #define TDX_GET_INFO			1
> @@ -577,6 +578,7 @@ void __init tdx_early_init(void)
>   	pv_ops.irq.halt = tdx_halt;
>   
>   	legacy_pic = &null_legacy_pic;
> +	swiotlb_force = SWIOTLB_FORCE;
>   
>   	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdx:cpu_hotplug",
>   			  NULL, tdx_cpu_offline_prepare);
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 5d7fbed73949..8385bc4565e9 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -438,14 +438,11 @@ static void print_mem_encrypt_feature_info(void)
>   }
>   
>   /* Architecture __weak replacement functions */
> -void __init mem_encrypt_init(void)
> +void __init amd_mem_encrypt_init(void)
>   {
>   	if (!sme_me_mask)
>   		return;
>   
> -	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
> -	swiotlb_update_mem_attributes();
> -
>   	/*
>   	 * With SEV, we need to unroll the rep string I/O instructions,
>   	 * but SEV-ES supports them through the #VC handler.
> diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
> index 119a9056efbb..6fe44c6cb753 100644
> --- a/arch/x86/mm/mem_encrypt_common.c
> +++ b/arch/x86/mm/mem_encrypt_common.c
> @@ -10,6 +10,7 @@
>   #include <asm/mem_encrypt_common.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/cc_platform.h>
> +#include <linux/swiotlb.h>
>   
>   /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>   bool force_dma_unencrypted(struct device *dev)
> @@ -24,3 +25,16 @@ bool force_dma_unencrypted(struct device *dev)
>   
>   	return false;
>   }
> +
> +/* Architecture __weak replacement functions */
> +void __init mem_encrypt_init(void)
> +{
> +	/*
> +	 * For TDX guest or SEV/SME, call into SWIOTLB to update
> +	 * the SWIOTLB DMA buffers
> +	 */
> +	if (sme_me_mask || cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))

Can't you just make this:

	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))

SEV will return true if sme_me_mask is not zero and TDX should only return 
true if it is TDX guest, right?

Thanks,
Tom

> +		swiotlb_update_mem_attributes();
> +
> +	amd_mem_encrypt_init();
> +}
> 
