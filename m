Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E01435086
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhJTQsJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 12:48:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:59922 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhJTQsI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 12:48:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="315032949"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="315032949"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:45:52 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="720486000"
Received: from yakasaka-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.9.165])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:45:51 -0700
Subject: Re: [PATCH v5 06/16] x86/tdx: Make DMA pages shared
To:     Tom Lendacky <thomas.lendacky@amd.com>,
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
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <66acafb6-7659-7d76-0f52-d002cfae9cc8@linux.intel.com>
Date:   Wed, 20 Oct 2021 09:45:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <654455db-a605-5069-d652-fe822ae066b0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/20/21 9:33 AM, Tom Lendacky wrote:
> On 10/8/21 7:37 PM, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> Just like MKTME, TDX reassigns bits of the physical address for
>> metadata.  MKTME used several bits for an encryption KeyID. TDX
>> uses a single bit in guests to communicate whether a physical page
>> should be protected by TDX as private memory (bit set to 0) or
>> unprotected and shared with the VMM (bit set to 1).
>>
>> __set_memory_enc_dec() is now aware about TDX and sets Shared bit
>> accordingly following with relevant TDX hypercall.
>>
>> Also, Do TDX_ACCEPT_PAGE on every 4k page after mapping the GPA range
>> when converting memory to private. Using 4k page size limit is due
>> to current TDX spec restriction. Also, If the GPA (range) was
>> already mapped as an active, private page, the host VMM may remove
>> the private page from the TD by following the “Removing TD Private
>> Pages” sequence in the Intel TDX-module specification [1] to safely
>> block the mapping(s), flush the TLB and cache, and remove the
>> mapping(s).
>>
>> BUG() if TDX_ACCEPT_PAGE fails (except "previously accepted page" case)
>> , as the guest is completely hosed if it can't access memory.
>>
>> [1] 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Ftdx-module-1eas-v0.85.039.pdf&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C0e667adf5a4042abce3908d98abd07a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637693367201703893%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=UGxQ9xBjWsmev7PetX%2BuS0RChkAXyaH7q6JHO9ZiUtY%3D&amp;reserved=0 
>>
>>
>> Tested-by: Kai Huang <kai.huang@linux.intel.com>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan 
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ...
> 
>> diff --git a/arch/x86/mm/mem_encrypt_common.c 
>> b/arch/x86/mm/mem_encrypt_common.c
>> index f063c885b0a5..119a9056efbb 100644
>> --- a/arch/x86/mm/mem_encrypt_common.c
>> +++ b/arch/x86/mm/mem_encrypt_common.c
>> @@ -9,9 +9,18 @@
>>   #include <asm/mem_encrypt_common.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/cc_platform.h>
>>   /* Override for DMA direct allocation check - 
>> ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>>   bool force_dma_unencrypted(struct device *dev)
>>   {
>> -    return amd_force_dma_unencrypted(dev);
>> +    if (cc_platform_has(CC_ATTR_GUEST_TDX) &&
>> +        cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +        return true;
>> +
>> +    if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
>> +        cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>> +        return amd_force_dma_unencrypted(dev);
>> +
>> +    return false;
> 
> Assuming the original force_dma_unencrypted() function was moved here or 
> cc_platform.c, then you shouldn't need any changes. Both SEV and TDX 
> require true be returned if CC_ATTR_GUEST_MEM_ENCRYPT returns true. And 
> then TDX should never return true for CC_ATTR_HOST_MEM_ENCRYPT.


For non TDX case, in CC_ATTR_HOST_MEM_ENCRYPT, we should still call
amd_force_dma_unencrypted() right?

> 
>>   }
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 527957586f3c..6c531d5cb5fd 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -30,6 +30,7 @@
>>   #include <asm/proto.h>
>>   #include <asm/memtype.h>
>>   #include <asm/set_memory.h>
>> +#include <asm/tdx.h>
>>   #include "../mm_internal.h"
>> @@ -1981,8 +1982,10 @@ int set_memory_global(unsigned long addr, int 
>> numpages)
>>                       __pgprot(_PAGE_GLOBAL), 0);
>>   }
>> -static int __set_memory_enc_dec(unsigned long addr, int numpages, 
>> bool enc)
>> +static int __set_memory_protect(unsigned long addr, int numpages, 
>> bool protect)
>>   {
>> +    pgprot_t mem_protected_bits, mem_plain_bits;
>> +    enum tdx_map_type map_type;
>>       struct cpa_data cpa;
>>       int ret;
>> @@ -1997,8 +2000,25 @@ static int __set_memory_enc_dec(unsigned long 
>> addr, int numpages, bool enc)
>>       memset(&cpa, 0, sizeof(cpa));
>>       cpa.vaddr = &addr;
>>       cpa.numpages = numpages;
>> -    cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
>> -    cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
>> +
>> +    if (cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT)) {
>> +        mem_protected_bits = __pgprot(0);
>> +        mem_plain_bits = pgprot_cc_shared_mask();
> 
> How about having generic versions for both shared and private that 
> return the proper value for SEV or TDX. Then this remains looking 
> similar to as it does now, just replacing the __pgprot() calls with the 
> appropriate pgprot_cc_{shared,private}_mask().

Makes sense.

> 
> Thanks,
> Tom
> 
>> +    } else {
>> +        mem_protected_bits = __pgprot(_PAGE_ENC);
>> +        mem_plain_bits = __pgprot(0);
>> +    }
>> +
>> +    if (protect) {
>> +        cpa.mask_set = mem_protected_bits;
>> +        cpa.mask_clr = mem_plain_bits;
>> +        map_type = TDX_MAP_PRIVATE;
>> +    } else {
>> +        cpa.mask_set = mem_plain_bits;
>> +        cpa.mask_clr = mem_protected_bits;
>> +        map_type = TDX_MAP_SHARED;
>> +    }
>> +
>>       cpa.pgd = init_mm.pgd;
>>       /* Must avoid aliasing mappings in the highmem code */
>> @@ -2006,9 +2026,17 @@ static int __set_memory_enc_dec(unsigned long 
>> addr, int numpages, bool enc)
>>       vm_unmap_aliases();
>>       /*
>> -     * Before changing the encryption attribute, we need to flush 
>> caches.
>> +     * Before changing the encryption attribute, flush caches.
>> +     *
>> +     * For TDX, guest is responsible for flushing caches on 
>> private->shared
>> +     * transition. VMM is responsible for flushing on shared->private.
>>        */
>> -    cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>> +    if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
>> +        if (map_type == TDX_MAP_SHARED)
>> +            cpa_flush(&cpa, 1);
>> +    } else {
>> +        cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>> +    }
>>       ret = __change_page_attr_set_clr(&cpa, 1);
>> @@ -2021,18 +2049,21 @@ static int __set_memory_enc_dec(unsigned long 
>> addr, int numpages, bool enc)
>>        */
>>       cpa_flush(&cpa, 0);
>> +    if (!ret && cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT))
>> +        ret = tdx_hcall_gpa_intent(__pa(addr), numpages, map_type);
>> +
>>       return ret;
>>   }
>>   int set_memory_encrypted(unsigned long addr, int numpages)
>>   {
>> -    return __set_memory_enc_dec(addr, numpages, true);
>> +    return __set_memory_protect(addr, numpages, true);
>>   }
>>   EXPORT_SYMBOL_GPL(set_memory_encrypted);
>>   int set_memory_decrypted(unsigned long addr, int numpages)
>>   {
>> -    return __set_memory_enc_dec(addr, numpages, false);
>> +    return __set_memory_protect(addr, numpages, false);
>>   }
>>   EXPORT_SYMBOL_GPL(set_memory_decrypted);
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
