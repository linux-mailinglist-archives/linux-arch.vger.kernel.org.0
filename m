Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECB43506A
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJTQnr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 12:43:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:40127 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJTQnr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 12:43:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="289674242"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="289674242"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:41:32 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="720484565"
Received: from yakasaka-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.9.165])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:41:30 -0700
Subject: Re: [PATCH v5 04/16] x86/tdx: Make pages shared in ioremap()
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
 <20211009003711.1390019-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <8c5074f7-5456-e628-5a09-a3a4b4f381fb@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bebdba3b-796b-d661-a3c6-7aaf7bcbe192@linux.intel.com>
Date:   Wed, 20 Oct 2021 09:41:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8c5074f7-5456-e628-5a09-a3a4b4f381fb@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/20/21 9:03 AM, Tom Lendacky wrote:
> On 10/8/21 7:36 PM, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> All ioremap()ed pages that are not backed by normal memory (NONE or
>> RESERVED) have to be mapped as shared.
>>
>> Reuse the infrastructure from AMD SEV code.
>>
>> Note that DMA code doesn't use ioremap() to convert memory to shared as
>> DMA buffers backed by normal memory. DMA code make buffer shared with
>> set_memory_decrypted().
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan 
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v4:
>>   * Renamed "protected_guest" to "cc_guest".
>>   * Replaced use of prot_guest_has() with cc_guest_has()
>>   * Modified the patch to adapt to latest version cc_guest_has()
>>     changes.
>>
>> Changes since v3:
>>   * Rebased on top of Tom Lendacky's protected guest
>>     changes (https://lore.kernel.org/patchwork/cover/1468760/)
>>
>> Changes since v1:
>>   * Fixed format issues in commit log.
>>
>>   arch/x86/include/asm/pgtable.h |  4 ++++
>>   arch/x86/mm/ioremap.c          |  8 ++++++--
>>   include/linux/cc_platform.h    | 13 +++++++++++++
>>   3 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pgtable.h 
>> b/arch/x86/include/asm/pgtable.h
>> index 448cd01eb3ec..ecefccbdf2e3 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -21,6 +21,10 @@
>>   #define pgprot_encrypted(prot)    __pgprot(__sme_set(pgprot_val(prot)))
>>   #define pgprot_decrypted(prot)    __pgprot(__sme_clr(pgprot_val(prot)))
>> +/* Make the page accesable by VMM for confidential guests */
>> +#define pgprot_cc_guest(prot) __pgprot(pgprot_val(prot) |    \
>> +                          tdx_shared_mask())
> 
> So this is only for TDX guests, so maybe a name that is less generic.
> 
> Alternatively, you could create pgprot_private()/pgprot_shared() 
> functions that check for SME/SEV or TDX and do the proper thing.
> 
> Then you can redefine pgprot_encrypted()/pgprot_decrypted() to the new 
> functions?

Make sense. It will be a better abstraction. I will make this change in
next version.

> 
>> +
>>   #ifndef __ASSEMBLY__
>>   #include <asm/x86_init.h>
>>   #include <asm/pkru.h>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 026031b3b782..83daa3f8f39c 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/cc_platform.h>
>>   #include <linux/efi.h>
>>   #include <linux/pgtable.h>
>> +#include <linux/cc_platform.h>
>>   #include <asm/set_memory.h>
>>   #include <asm/e820/api.h>
>> @@ -26,6 +27,7 @@
>>   #include <asm/pgalloc.h>
>>   #include <asm/memtype.h>
>>   #include <asm/setup.h>
>> +#include <asm/tdx.h>
>>   #include "physaddr.h"
>> @@ -87,8 +89,8 @@ static unsigned int __ioremap_check_ram(struct 
>> resource *res)
>>   }
>>   /*
>> - * In a SEV guest, NONE and RESERVED should not be mapped encrypted 
>> because
>> - * there the whole memory is already encrypted.
>> + * In a SEV or TDX guest, NONE and RESERVED should not be mapped 
>> encrypted (or
>> + * private in TDX case) because there the whole memory is already 
>> encrypted.
>>    */
>>   static unsigned int __ioremap_check_encrypted(struct resource *res)
>>   {
>> @@ -246,6 +248,8 @@ __ioremap_caller(resource_size_t phys_addr, 
>> unsigned long size,
>>       prot = PAGE_KERNEL_IO;
>>       if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
>>           prot = pgprot_encrypted(prot);
>> +    else if (cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT))
>> +        prot = pgprot_cc_guest(prot);
> 
> And if you do the new functions this could be:
> 
>      if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
>          prot = pgprot_private(prot);
>      else
>          prot = pgprot_shared(prot);

Yes. I will make this change in next version.

> 
> Thanks,
> Tom
> 
>>       switch (pcm) {
>>       case _PAGE_CACHE_MODE_UC:
>> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
>> index 7728574d7783..edb1d7a2f6af 100644
>> --- a/include/linux/cc_platform.h
>> +++ b/include/linux/cc_platform.h
>> @@ -81,6 +81,19 @@ enum cc_attr {
>>        * Examples include TDX Guest.
>>        */
>>       CC_ATTR_GUEST_UNROLL_STRING_IO,
>> +
>> +    /**
>> +     * @CC_ATTR_GUEST_SHARED_MAPPING_INIT: IO Remapped memory is marked
>> +     *                       as shared.
>> +     *
>> +     * The platform/OS is running as a guest/virtual machine and
>> +     * initializes all IO remapped memory as shared.
>> +     *
>> +     * Examples include TDX Guest (SEV marks all pages as shared by 
>> default
>> +     * so this feature cannot be enabled for it).
>> +     */
>> +    CC_ATTR_GUEST_SHARED_MAPPING_INIT,
>> +
>>   };
>>   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
