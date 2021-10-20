Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012AD43513A
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJTR2z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:28:55 -0400
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:11585
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230392AbhJTR2x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 13:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx2EcZua0ojw0BzKen6FxlF+OzRJOUkmAH83E0TC3fF6gnny4HM0fo48xKkxiF4myeBFgvLaEp8JiIfk1Zvfh8zhQwc47OE01tRPEH/1JH0wgZYyc0Y23wWMA6+aLvjCTzLFGorvwWgw8ZCknvmRX74a1EIL7zGlnBohW+xn9IunIGMVyhuazulTSy7+FwCisBo+s6Fu+Rk6imURwrKC4129r5MeS/DVQfIDzXXtChYGZYWH1q8laArkiL/doJNH73i4T254cM+mXW+Xy/ywK7oNwm0FU4BprCBSks6xvIUJ8ILgA5gnZTzOiQXcehBv0rs1vGfedhsv9Zo/HUO4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpAcJkx2zC8LdsbwxMe8SN9vYo8iAQp6cKmAWVC/V6A=;
 b=IXnGOykcpLPSx/tVJjPGIl9fORwt8z8cQDq7fahSX0AFVQVazUcLKAA9wVlK+TYNhPNo9EpJCOJDFFHGPJ9nrm1MqR80Z3tsqL2T0njYBSYuezU1FXdP8ihjkJ59Aoy0lsgM6rStbsJKJkUS+ZDfYoxn/YSa4OQqkvb+O7OzMDlZC+hqnWI4XWJmcRc+ne4WrCPThWCWoCxLr4YJOUiJ0RWGgQ25VkLrLW7AXm315EHzCFKdY8DsilbuT4hG/POXofCVlawY53u/LbfHQY1iIogGVfomnbf24T0QalEewzUDjCGMPv9CYm4aSN6xuW8phlny5v9XFtrexBC1v2LYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpAcJkx2zC8LdsbwxMe8SN9vYo8iAQp6cKmAWVC/V6A=;
 b=UKda+SsuhxDvTLK7mdrtpGFB9XPdmWqRDIHRSndnPmcm3yq4yAzuEy2NJ+WDokKOmtwu3Hcj/BbsF4pcASPc51kT6S5aQKobvR+dR0FBA/YofBivBVV8FYA6+6wZTlx/t1gIxMpAZlwqhVkM5LjwfPjwV1GwOA649aurQoN5rM8=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 17:26:35 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 17:26:35 +0000
Subject: Re: [PATCH v5 07/16] x86/kvm: Use bounce buffers for TD guest
To:     Sathyanarayanan Kuppuswamy 
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
 <42f17b60-9bd4-a8bc-5164-d960e54cd30b@amd.com>
 <0a9c6485-74d8-e0fc-d261-097380272e07@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <591e0566-59e1-71d1-684a-fd1240b2eedc@amd.com>
Date:   Wed, 20 Oct 2021 12:26:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <0a9c6485-74d8-e0fc-d261-097380272e07@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:610:118::22) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by CH0PR03CA0330.namprd03.prod.outlook.com (2603:10b6:610:118::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 17:26:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05d09b0a-9341-47be-9875-08d993eec43c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5214CC75060FB975567CF46DECBE9@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwUaOOrppXIz2ZZHhtClOgpkboVgeJvHAdD9pUZQA1YIsEwfiGeHF0t4o/M8GaWyVPteLFFeANGMZCq6rXR+kyICKcibYGcp17eXU36v4bSyFvZsZRApPbQ/YR87xAIhHJz5Vawp91fDH5/gey0sG01gzpod/18bFrOucuJLgBUvpuB0s2vbSclO/ZcanMdtCpyp8EaC/ru4ZiMKiC8fXWJ9m6SrkMYG1ZgYYPzCRoiryPtsYjkZphGMd2RkhzRG5eCg0fd/FulWvu1qd+/ZWLQYPfYDtg0hhC/8Tk2fvQr2REr9p59/0fC+rnLUpU8lN/rIHHUfZgltHuHwZ2aO3d/wV92vgXK7gVimqhp1VfXwBcePGU6Y+XON2ZkAruecSQLC2kc7aXwqsVPyoWn6R2NhevAxRVp+OXUnObn2e6DwdbzlfBGgzflvxSAH017BMJ07D2uVVbt2glnvlu6jBB32d12U1CZkTBnO0iIY6w7UT8TaRuu0bK7iTO0V/8GYC6eyKwKIizlXk214TrU2dFzizbcLiyMZ2Ytz2UroMu49dqeO81Y9EdFFFhprLOB+A81HQxoYT+1vl+AY+RGxBErlrkaCacs0gh+syTElmFwyRo1inUKoGgQYHdLJTV0aTorYV9FM4zvnivLeBfRk3xVmxMGtga7Ud+WK4Fd4oSM/F7Xfnx58EMiJX45o6RTrh6v9JlpA26nv7UYBeXIeFqDdoKi69/IEwzsSRIzc5GXmB9mcJHqBXNNSyoPsGBEZKmPkit68S/ohlAP06WRnMlvycf6F++v0jMla2cX9VXU8t2NQQrjbIdxlySN/tkRccW22R9HDJ3fKhK2G+lbn2aJ/ml0Wj0BoDH8emwp34jo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(66476007)(921005)(83380400001)(66556008)(508600001)(110136005)(54906003)(2616005)(66946007)(16576012)(53546011)(7406005)(86362001)(8676002)(5660300002)(7416002)(8936002)(31696002)(316002)(31686004)(36756003)(38100700002)(186003)(2906002)(26005)(4326008)(6486002)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBSQ1l4aXdNZks1a1FTckVxL3J1MVlGTGJRZUttZVBmUU9ON1NNSmc0c2k0?=
 =?utf-8?B?clFIMlVYZ0NTUm9HWUtiZEZoeHZYT21SNFh5WFNySitZdVdHNy91VXVPb3NT?=
 =?utf-8?B?SVI2b0NBalVjRDVaWEpqUEU2MjlLU3hGQjZiZ1lQWURHNmkxSGNNUmFDeDFL?=
 =?utf-8?B?TTdQTFpUa2JxNzVxS0xBZnlQTE16dFVCWUpONWI1bDRPOXdwY1BGeDJiQngv?=
 =?utf-8?B?bkExSFdOVmZRdUpIc1NaMHpyUWhwREhIMDN3WkNwTTlTdWRwNXhkUjlPellN?=
 =?utf-8?B?OFNxdEZydG1MNUZhc2swVjFHcUY5SUxiNzh1WXR3SDRMcHlyT2JhQTI4ZG1r?=
 =?utf-8?B?dVFxY3hlYldlSHRpNkhVeE5DZitSTHZ1TCtRV2xyMjlobDlqVXoycXBLSzNI?=
 =?utf-8?B?bjhxZEZGUXY2NFV5RUNpS28vYktlRHJTUGRqUUxlV2ZjV1FjN2ZaZGlRc0tC?=
 =?utf-8?B?L2UwUC91Q1NBMVpRZnVQMTI5ZUlKbXBvVHhQTkJBNzN0NVhQeFlaZGVobm1H?=
 =?utf-8?B?dDAyUHMwekp1N3QxNllhVUN5dDNIRU1Ra3FMZlZPNitDN0tmMjB1R0t5NjBk?=
 =?utf-8?B?c2Fqb0pVRDEvOG5kRDJCQ2hZU2JYdWFWeHJUekVSUGlubERFQ3lXRVl6OWVo?=
 =?utf-8?B?eU5UTFlEc2VoSHZMMXNRK1lHdWpXMkMvS1FoSUZ6NGpBSFBQcExvbTBZL2Z4?=
 =?utf-8?B?TjFHZGJCWDMwVnpKVTN0V0k3OG5aSXdHM1VmYTRzUzlhdHordU5GR2oxaGdN?=
 =?utf-8?B?VzNTSWkzdWFUNk1YSFJwMHl4U1dnVFhCUFZNTURvdlh0eFAvMHBnaTVVTktI?=
 =?utf-8?B?a0FyOTNXU1RwRTFaK3NaaG5oVG5WYjlOR3B0VGlFVVEyK2pVeU1yRnU5dzZx?=
 =?utf-8?B?NklQQlN3b2thZkRLUFh3NkpQNC9HT1lhajQ2bzhySzQwZW1Ec05uZE1JMmtS?=
 =?utf-8?B?WTNiMUxkSkJma0dXREVhK053eEhscFZnU3JGQlNhRkt0T0JYYnRlNzEvQWFs?=
 =?utf-8?B?Rmh3RWp2TUhKeXZjbTM0Tlp1SVcwQnF4bHpzZCtUd2NkU01iN2pyRkRxRnBB?=
 =?utf-8?B?MWtMOEZYclhBei96czR6MDJvTTlBNXJsV2FVcVExZVBTM3kvaFRRQmVDY3du?=
 =?utf-8?B?Vm9sSlRBTURoNFVWc2pDeFN1UmhnKzRuNFZaUHl5Ymx4ZVZmMi9jU0pyR3Jn?=
 =?utf-8?B?U1ZPSzFNUDU3NlllWWlPL0ovQUJsYWFYYmNrU29IQTNnV2NRN2RyTmh0Q3FK?=
 =?utf-8?B?cVFZVVRDakZIYnhJdEVYVTNhYllBMlZBVEw2QnFsYkZvVUZYeml4TWh2d2NS?=
 =?utf-8?B?RXMyUmVRZWxxZ2F2SjJySlRJVVZ5aDc5ejFmeFphZVlHSU9ZNFVUS2djRlMy?=
 =?utf-8?B?QVRJUUVlcDJTaUIyMHNjWEU1Kzg5VWVtTmI3Nlp2dGVZNlpCN3JLak5IcC9G?=
 =?utf-8?B?ZlNxVmNHRXMzL29XdmdxUkxXMUtOcE0wVytWWHE0eHRwN2YrY0wrUnFpV2Jy?=
 =?utf-8?B?Znd2NGhyRDJqZ1NWelBRQy84Vi83L3JRUUNJZHhsdGQ5Rng2ZjFoNDduN0Zn?=
 =?utf-8?B?WTVLaE8zVjgzWWVMNlgvd0doZ01zMUpoWkZxYkIzWE1vSkFrWWtyblZ6bStS?=
 =?utf-8?B?enlsWlpBNnF6WWhwYXhpbWVGZVpldk41UFIyOWFlVDZ4c3lIOFJVK1BRVzk1?=
 =?utf-8?B?REVBajNWVVFzUm5jZ2tsd1BLSm1QbmpsU3Y4V3EvdzBXVVZmd25INURUemxO?=
 =?utf-8?Q?Aa3RgpVcuMvfnwjmrWxZIy+QR3+mAgVLUxyGKRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d09b0a-9341-47be-9875-08d993eec43c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 17:26:35.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/20/21 11:50 AM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 10/20/21 9:39 AM, Tom Lendacky wrote:
>> On 10/8/21 7:37 PM, Kuppuswamy Sathyanarayanan wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>> Intel TDX doesn't allow VMM to directly access guest private memory.
>>> Any memory that is required for communication with VMM must be shared
>>> explicitly. The same rule applies for any DMA to and from TDX guest.
>>> All DMA pages had to marked as shared pages. A generic way to achieve
>>> this without any changes to device drivers is to use the SWIOTLB
>>> framework.
>>>
>>> This method of handling is similar to AMD SEV. So extend this support
>>> for TDX guest as well. Also since there are some common code between
>>> AMD SEV and TDX guest in mem_encrypt_init(), move it to
>>> mem_encrypt_common.c and call AMD specific init function from it
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan 
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>>
>>> Changes since v4:
>>>   * Replaced prot_guest_has() with cc_guest_has().
>>>
>>> Changes since v3:
>>>   * Rebased on top of Tom Lendacky's protected guest
>>>     changes 
>>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fpatchwork%2Fcover%2F1468760%2F&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Cad852703670a44b1e29108d993e9dcc2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637703454904800065%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lXwd5%2Fhnmd5QYaIElQ%2BtVT%2B62JHq%2Bimno5VIjTILaig%3D&amp;reserved=0) 
>>>
>>>
>>> Changes since v1:
>>>   * Removed sme_me_mask check for amd_mem_encrypt_init() in 
>>> mem_encrypt_init().
>>>
>>>   arch/x86/include/asm/mem_encrypt_common.h |  3 +++
>>>   arch/x86/kernel/tdx.c                     |  2 ++
>>>   arch/x86/mm/mem_encrypt.c                 |  5 +----
>>>   arch/x86/mm/mem_encrypt_common.c          | 14 ++++++++++++++
>>>   4 files changed, 20 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/mem_encrypt_common.h 
>>> b/arch/x86/include/asm/mem_encrypt_common.h
>>> index 697bc40a4e3d..bc90e565bce4 100644
>>> --- a/arch/x86/include/asm/mem_encrypt_common.h
>>> +++ b/arch/x86/include/asm/mem_encrypt_common.h
>>> @@ -8,11 +8,14 @@
>>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>>   bool amd_force_dma_unencrypted(struct device *dev);
>>> +void __init amd_mem_encrypt_init(void);
>>>   #else /* CONFIG_AMD_MEM_ENCRYPT */
>>>   static inline bool amd_force_dma_unencrypted(struct device *dev)
>>>   {
>>>       return false;
>>>   }
>>> +
>>> +static inline void amd_mem_encrypt_init(void) {}
>>>   #endif /* CONFIG_AMD_MEM_ENCRYPT */
>>>   #endif
>>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>>> index 433f366ca25c..ce8e3019b812 100644
>>> --- a/arch/x86/kernel/tdx.c
>>> +++ b/arch/x86/kernel/tdx.c
>>> @@ -12,6 +12,7 @@
>>>   #include <asm/insn.h>
>>>   #include <asm/insn-eval.h>
>>>   #include <linux/sched/signal.h> /* force_sig_fault() */
>>> +#include <linux/swiotlb.h>
>>>   /* TDX Module call Leaf IDs */
>>>   #define TDX_GET_INFO            1
>>> @@ -577,6 +578,7 @@ void __init tdx_early_init(void)
>>>       pv_ops.irq.halt = tdx_halt;
>>>       legacy_pic = &null_legacy_pic;
>>> +    swiotlb_force = SWIOTLB_FORCE;
>>>       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdx:cpu_hotplug",
>>>                 NULL, tdx_cpu_offline_prepare);
>>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>>> index 5d7fbed73949..8385bc4565e9 100644
>>> --- a/arch/x86/mm/mem_encrypt.c
>>> +++ b/arch/x86/mm/mem_encrypt.c
>>> @@ -438,14 +438,11 @@ static void print_mem_encrypt_feature_info(void)
>>>   }
>>>   /* Architecture __weak replacement functions */
>>> -void __init mem_encrypt_init(void)
>>> +void __init amd_mem_encrypt_init(void)
>>>   {
>>>       if (!sme_me_mask)
>>>           return;
>>> -    /* Call into SWIOTLB to update the SWIOTLB DMA buffers */
>>> -    swiotlb_update_mem_attributes();
>>> -
>>>       /*
>>>        * With SEV, we need to unroll the rep string I/O instructions,
>>>        * but SEV-ES supports them through the #VC handler.
>>> diff --git a/arch/x86/mm/mem_encrypt_common.c 
>>> b/arch/x86/mm/mem_encrypt_common.c
>>> index 119a9056efbb..6fe44c6cb753 100644
>>> --- a/arch/x86/mm/mem_encrypt_common.c
>>> +++ b/arch/x86/mm/mem_encrypt_common.c
>>> @@ -10,6 +10,7 @@
>>>   #include <asm/mem_encrypt_common.h>
>>>   #include <linux/dma-mapping.h>
>>>   #include <linux/cc_platform.h>
>>> +#include <linux/swiotlb.h>
>>>   /* Override for DMA direct allocation check - 
>>> ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>>>   bool force_dma_unencrypted(struct device *dev)
>>> @@ -24,3 +25,16 @@ bool force_dma_unencrypted(struct device *dev)
>>>       return false;
>>>   }
>>> +
>>> +/* Architecture __weak replacement functions */
>>> +void __init mem_encrypt_init(void)
>>> +{
>>> +    /*
>>> +     * For TDX guest or SEV/SME, call into SWIOTLB to update
>>> +     * the SWIOTLB DMA buffers
>>> +     */
>>> +    if (sme_me_mask || cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>>
>> Can't you just make this:
>>
>>      if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>>
>> SEV will return true if sme_me_mask is not zero and TDX should only 
>> return true if it is TDX guest, right?
> 
> Yes. It can be simplified.
> 
> But where shall we leave this function cc_platform.c or here?

Either one works...  all depends on how the maintainers feel about 
creating/using mem_encrypt_common.c or using cc_platform.c.

Thanks,
Tom

> 
>>
>> Thanks,
>> Tom
>>
>>> +        swiotlb_update_mem_attributes();
>>> +
>>> +    amd_mem_encrypt_init();
>>> +}
>>>
> 
