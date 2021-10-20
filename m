Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D81435121
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJTRZF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:25:05 -0400
Received: from mail-dm3nam07on2082.outbound.protection.outlook.com ([40.107.95.82]:47873
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhJTRZE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 13:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k57gr5yaKHEefr5DMUtBF/gx64vXmKrQmp2Zv88wcPrO8H7bj7NEINdv72JL8JBR7VwOY3sX/wmHEt1UK2Et5d0BP0Dh1bS6ftIqaAzM2wRmpLRO73tsTQ/nUfi0GhOlkS6NyCI7VWSzRXOTo5d9OJf5ppweO58S7da/O81+E7AzVPzIVOcVvl0/LgKqg7XFq6PmnVcmj7GJo4Y3qVJWb170Y3Wxivi8g8vZPkQo/FXhkYtwDi3D9KPiR3Am4WWQlpfpdBXQhcGZr2fXpsA0gPMc+5tfkDLgXmGS/X4zPjs3C8V6eWyFzWbumG8TBhs+xAs16/60xl3EY3XKy/HNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1qZpG8ptqbie5y77VPiOpqV1HQb5pLUVW03iOwOHMo=;
 b=kphZO1vGmHEkdzHKflcVmE3rWsiDg9Be1G4ge3I8aop9SJ18k2pUl2xPgkQ9nGtdMECooeJvRo8euRIbrFNRADMd9a4axDOaAvopNY2NaiYxwx5/r60g98glvUxp2rdrQKkV5R+n4iG4xxVjfqbfeQ04EaDx0ESebXgQfrF2nwxHtX9LT49KoFeJ9ncmvK+8q7eMBDqSR4qg+MmZ3TgmXikaSNs5lXo0Wo/0u0y37NpTwnCm1hAwkP3TSrvJ+YNXjbuw4oxHmA6aFU8A3LRmZyLhGL3GkHnMb10zFgxh/bMsje1nKBWwnJfatP/aPlKMW+Q+M6gPC2j3MTK+8zWDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1qZpG8ptqbie5y77VPiOpqV1HQb5pLUVW03iOwOHMo=;
 b=GOb/6zhVrHzjmrBhricdL6DE8hZrQMoRxIsdnR/sW28BuI82g2CQGZJpYPKWCnOoj2KXWcR9cqjxL0AetvMGLgj9ocQnMvUFcawoXImj5sVx3P5ByyDQFNN2Nk6Fc3U2RPvBBFHtsffe1tdQkjEGjuij+fYIVU56c45/emN7iFw=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 17:22:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 17:22:46 +0000
Subject: Re: [PATCH v5 06/16] x86/tdx: Make DMA pages shared
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
 <20211009003711.1390019-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <654455db-a605-5069-d652-fe822ae066b0@amd.com>
 <66acafb6-7659-7d76-0f52-d002cfae9cc8@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0b06e686-b0d8-9485-ae00-b23f805916d9@amd.com>
Date:   Wed, 20 Oct 2021 12:22:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <66acafb6-7659-7d76-0f52-d002cfae9cc8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:208:238::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 17:22:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bab281-1fc6-4544-375e-08d993ee3b9a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5071:
X-Microsoft-Antispam-PRVS: <DM4PR12MB507129E644B2BEDA5BD672D4ECBE9@DM4PR12MB5071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKPAY8h+09cfbSK+y5V9rSy3I7c5V53XRTZUX506Ann+myx3ltgXLqm3RTxv+kzgpGklZzwjcJ3eWFNZXyGEQW6z9ySSNQ+gr4LOLxsTOTIN3eayLDN0YPpNy9XeIH0/icJE8lN+MCa6mXkFQtMn4i9itC7Scat4lKtSvjaAeuZYg9cXIdXZbX84Vs+o4EHLbYy7yVubdISJAKHazxHphPbFtq0dtSg39wpJBsac/CXEv1tmjrjnsl3DSIDNhme5I31kk9B+48IMqfT5z6lzyFnlULbF2ZsSmyQwUd6Bz1IGwPRSI3Qr5HfPyivOpbRXRILA22TMnXCw/tX3pAJWE5qkytMFPi9u13BxvgXPGlhHIMKZ4//GyyEjKOyyhK5Sd2CunQMOtdaoQpDT3jEjS3xC9qsNs18hTPQ8/CWN9+0TdkK4boizl6KHhy1Gf0YCbNqiL2+6yZ6jfGBQU3p8VrLwGzy2UawK5hjkiad7kXghs6CWdmOSuyxyuX4ZKfTGOASWNxyNebj5qDd6O1tUpKGUeHk+hKe3a4EuRrBoXQwLFnF3WeLK7b0QlKl/ZHDlXYy8nRQ7Gp3B0TpMGkmEt08FSXLoG+O2Mo07eOQ79I7diZZS/vynGhhIGM5NqnjEkd1VMyw1A85j1tYhvHXABtvU0hrGknPXlZksvA1UkbpNhfb8rtJrvR0OWNMg6BExzKVPBcVTL65JBFgxovVdepJ+9y5J0x4G4lFKsVWLBaMKgfkWaurTx76CdugqglAFOg0jhOs2Why9Uy6l6QAzng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(16576012)(7416002)(186003)(2906002)(508600001)(66946007)(86362001)(7406005)(8936002)(26005)(4326008)(5660300002)(66476007)(66556008)(36756003)(316002)(956004)(2616005)(53546011)(921005)(31696002)(110136005)(8676002)(6486002)(54906003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRNUUJDRlhmVXdDOVdSVmJvTXUyMjk2OWlucmxuN3c1b3Q3V2VTSGZWaWdE?=
 =?utf-8?B?VWhpNFlUYlg5UE14RVNheEJnSW4vVlhhRGQ1Vnkra0RKZjhtbS9LUSswMkll?=
 =?utf-8?B?VlNHall1UDR3cnJRN1RsL21ld2IyMUV1NFVtN0NJNlRjelMyZWZQUzFPTm9Q?=
 =?utf-8?B?STZiWHIxdndsTFUyaGRiaGJEMmVSM3JLQUI0QW11cVZ2RVMydzE0cjdyUU1i?=
 =?utf-8?B?NjZZNSsvM09rU3A1WGd2eE1KejYyZUM2TTlvcjVGZ24xZXRIS3BTQ0dEMFpZ?=
 =?utf-8?B?cVl6ZEJJREtTdTVtS01obWhwSTFFVEVHa1RYcEVFc3htV1VZLzVLMURoU0tV?=
 =?utf-8?B?Z0xSZVJSbzZTRmpzdUF6bklyaGRJT0l6WmxSN1IwMmV4RjREMHJNOS84dzQy?=
 =?utf-8?B?OXRLa0FoSGtmMmxwSlpmN1FTankwaER5THRHZTVPOUJLN3JCSVFUNmNxSzZa?=
 =?utf-8?B?YjRnZWhRL3RaaVUrRDNDb25TWHZZSDVqZXNtdVBoaDAxTlg3Nll3YmxmaHNv?=
 =?utf-8?B?MVkrMUlrWStKVVJaTzBOQzhMbERkMVJ2TFAydGgxeENVY29pempXdnVaWEdv?=
 =?utf-8?B?TkNjSnlFbUFNMXdtck8wNUNuR0NuOXBUOUZ4ckRUS0FWSnZLT3hqSm1OOTdF?=
 =?utf-8?B?OWxMMUhQT0VBZkp3MXBhNTNjcFNXTUR1endrZUExT25zT1BYeDAvU3puTFFt?=
 =?utf-8?B?MXM5Yy9ZTHlpbmZybzFzYXVQTjFWU0ZYcEQ4VzlobFdzZTh5N0I4cjBHdGEr?=
 =?utf-8?B?ZHdkTjBYS01LM0N2STdsQjk5TG1GSWpoUFZML0YvMDZ5WlF0UVlnYloybnpv?=
 =?utf-8?B?SHlZa2U3YTdnT05kUjZvMGZsSzFGeFdRTXAxZkprWTNUNDB2QTRZKzNjUnFm?=
 =?utf-8?B?d3dRVXlydC8wV1V1SjlENFZvTWJ6eFl2Vm5ZUHVKVWc4dVUrb3NUQnk4VEhJ?=
 =?utf-8?B?MG15Y25DL3J4YjZPY0ptRkxOc0xkYzhGdFVLWmt5djlhNVNSUFAvNmRYbzM0?=
 =?utf-8?B?ZERhMWNLRE9tL3daK0duK0tVaVhmMWFKb05aWHdwMnNSUHlEVC95Wk1rVnZM?=
 =?utf-8?B?VXJIWnFrelZLSW1LcmhqSjRUZDRIS0pwNDl3Tm5FSXRlQjlVbE5BaFZnaC93?=
 =?utf-8?B?S21zYXlldmQyT1NlRDJVMEE2d1QvZ3FVVnA1ckFhNWl3dGhURHRMdElOblMr?=
 =?utf-8?B?enV4QU9pUStzVWIxYlBCTXB4TnRtenM3b0JCMXZKaTJCb1NZTGtzaEJzQXRZ?=
 =?utf-8?B?U0I2eVdjb3VISy9kR3A5T0ZxWTdJa0FGK2IwOFBQNUJlRWxLZjF6TGFWQXJY?=
 =?utf-8?B?OCszdGE2VkxJWDF5V2JhSUZBVmJJbjRqRFhYZnRvaFd0OVNTWXhzKzZ3czZL?=
 =?utf-8?B?WVQzN3RxZWlhZDQxbTIwaERnckY4cUZKbFhQc1E5a1lKSUszc3g2dzRSaGpB?=
 =?utf-8?B?YTVPZmlqbThEeTlOZTdoOHNQSkU4VXNkcnNpaHVwTkExcXJCcGhmdFZNN2RX?=
 =?utf-8?B?VTlTYXhEejZNd29pUW1abEVqRjZubDhEa1k4Z2ZzQjVVYy9Ia3BlYkJvTkJO?=
 =?utf-8?B?b050NWhqcXdWbWQzV1oxTXNVL3hvR0N1NFA3YVl2a3JFZ1IvTEJXY2xyWllS?=
 =?utf-8?B?Q2ZJT0gyYmhzNURPZ2JRME1lRm5yMkVmOE1oUHRrM0oxRW9janMvMnJQTERY?=
 =?utf-8?B?TW5aeTQ2bC9CSTdvOFAvUVAyVGhIYmt2cnlkV1Avb3BubC82SEwxTWZLNHZH?=
 =?utf-8?Q?DxFN9NL8dtffUaqCjgCZMAcznled9AzzhOOqMGP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bab281-1fc6-4544-375e-08d993ee3b9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 17:22:46.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/20/21 11:45 AM, Sathyanarayanan Kuppuswamy wrote:
> On 10/20/21 9:33 AM, Tom Lendacky wrote:
>> On 10/8/21 7:37 PM, Kuppuswamy Sathyanarayanan wrote:

...

>>>   bool force_dma_unencrypted(struct device *dev)
>>>   {
>>> -    return amd_force_dma_unencrypted(dev);
>>> +    if (cc_platform_has(CC_ATTR_GUEST_TDX) &&
>>> +        cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>>> +        return true;
>>> +
>>> +    if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
>>> +        cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>>> +        return amd_force_dma_unencrypted(dev);
>>> +
>>> +    return false;
>>
>> Assuming the original force_dma_unencrypted() function was moved here or 
>> cc_platform.c, then you shouldn't need any changes. Both SEV and TDX 
>> require true be returned if CC_ATTR_GUEST_MEM_ENCRYPT returns true. And 
>> then TDX should never return true for CC_ATTR_HOST_MEM_ENCRYPT.
> 
> 
> For non TDX case, in CC_ATTR_HOST_MEM_ENCRYPT, we should still call
> amd_force_dma_unencrypted() right?

What I'm saying is that you wouldn't have amd_force_dma_unencrypted(). I 
think the whole force_dma_unencrypted() can exist as-is in a different 
file, whether that's cc_platform.c or mem_encrypt_common.c.

It will return true for an SEV or TDX guest, true for an SME host based on 
the DMA mask or else false. That should work just fine for TDX.

Thanks,
Tom

> 
>>
>>>   }
>>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>>> index 527957586f3c..6c531d5cb5fd 100644
>>> --- a/arch/x86/mm/pat/set_memory.c
>>> +++ b/arch/x86/mm/pat/set_memory.c
>>> @@ -30,6 +30,7 @@
>>>   #include <asm/proto.h>
>>>   #include <asm/memtype.h>
>>>   #include <asm/set_memory.h>
>>> +#include <asm/tdx.h>
>>>   #include "../mm_internal.h"
>>> @@ -1981,8 +1982,10 @@ int set_memory_global(unsigned long addr, int 
>>> numpages)
>>>                       __pgprot(_PAGE_GLOBAL), 0);
>>>   }
>>> -static int __set_memory_enc_dec(unsigned long addr, int numpages, bool 
>>> enc)
>>> +static int __set_memory_protect(unsigned long addr, int numpages, bool 
>>> protect)
>>>   {
>>> +    pgprot_t mem_protected_bits, mem_plain_bits;
>>> +    enum tdx_map_type map_type;
>>>       struct cpa_data cpa;
>>>       int ret;
>>> @@ -1997,8 +2000,25 @@ static int __set_memory_enc_dec(unsigned long 
>>> addr, int numpages, bool enc)
>>>       memset(&cpa, 0, sizeof(cpa));
>>>       cpa.vaddr = &addr;
>>>       cpa.numpages = numpages;
>>> -    cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
>>> -    cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
>>> +
>>> +    if (cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT)) {
>>> +        mem_protected_bits = __pgprot(0);
>>> +        mem_plain_bits = pgprot_cc_shared_mask();
>>
>> How about having generic versions for both shared and private that 
>> return the proper value for SEV or TDX. Then this remains looking 
>> similar to as it does now, just replacing the __pgprot() calls with the 
>> appropriate pgprot_cc_{shared,private}_mask().
> 
> Makes sense.
> 
>>
>> Thanks,
>> Tom
>>
>>> +    } else {
>>> +        mem_protected_bits = __pgprot(_PAGE_ENC);
>>> +        mem_plain_bits = __pgprot(0);
>>> +    }
>>> +
>>> +    if (protect) {
>>> +        cpa.mask_set = mem_protected_bits;
>>> +        cpa.mask_clr = mem_plain_bits;
>>> +        map_type = TDX_MAP_PRIVATE;
>>> +    } else {
>>> +        cpa.mask_set = mem_plain_bits;
>>> +        cpa.mask_clr = mem_protected_bits;
>>> +        map_type = TDX_MAP_SHARED;
>>> +    }
>>> +
>>>       cpa.pgd = init_mm.pgd;
>>>       /* Must avoid aliasing mappings in the highmem code */
>>> @@ -2006,9 +2026,17 @@ static int __set_memory_enc_dec(unsigned long 
>>> addr, int numpages, bool enc)
>>>       vm_unmap_aliases();
>>>       /*
>>> -     * Before changing the encryption attribute, we need to flush caches.
>>> +     * Before changing the encryption attribute, flush caches.
>>> +     *
>>> +     * For TDX, guest is responsible for flushing caches on 
>>> private->shared
>>> +     * transition. VMM is responsible for flushing on shared->private.
>>>        */
>>> -    cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>>> +    if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
>>> +        if (map_type == TDX_MAP_SHARED)
>>> +            cpa_flush(&cpa, 1);
>>> +    } else {
>>> +        cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>>> +    }
>>>       ret = __change_page_attr_set_clr(&cpa, 1);
>>> @@ -2021,18 +2049,21 @@ static int __set_memory_enc_dec(unsigned long 
>>> addr, int numpages, bool enc)
>>>        */
>>>       cpa_flush(&cpa, 0);
>>> +    if (!ret && cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT))
>>> +        ret = tdx_hcall_gpa_intent(__pa(addr), numpages, map_type);
>>> +
>>>       return ret;
>>>   }
>>>   int set_memory_encrypted(unsigned long addr, int numpages)
>>>   {
>>> -    return __set_memory_enc_dec(addr, numpages, true);
>>> +    return __set_memory_protect(addr, numpages, true);
>>>   }
>>>   EXPORT_SYMBOL_GPL(set_memory_encrypted);
>>>   int set_memory_decrypted(unsigned long addr, int numpages)
>>>   {
>>> -    return __set_memory_enc_dec(addr, numpages, false);
>>> +    return __set_memory_protect(addr, numpages, false);
>>>   }
>>>   EXPORT_SYMBOL_GPL(set_memory_decrypted);
>>>
> 
