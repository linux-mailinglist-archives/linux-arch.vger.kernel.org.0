Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A843507B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJTQqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 12:46:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:16711 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhJTQp7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 12:45:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="229099652"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="229099652"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:43:45 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="720485176"
Received: from yakasaka-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.9.165])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:43:43 -0700
Subject: Re: [PATCH v5 01/16] x86/mm: Move force_dma_unencrypted() to common
 code
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
 <20211009003711.1390019-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <72b8be39-b4e2-5d77-524c-a2ea0c750ab1@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f7ede3f4-7280-38da-3744-32ecd8fdfcb1@linux.intel.com>
Date:   Wed, 20 Oct 2021 09:43:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <72b8be39-b4e2-5d77-524c-a2ea0c750ab1@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/20/21 9:11 AM, Tom Lendacky wrote:
>> Intel TDX doesn't allow VMM to access guest private memory. Any memory
>> that is required for communication with VMM must be shared explicitly
>> by setting the bit in page table entry. After setting the shared bit,
>> the conversion must be completed with MapGPA hypercall. Details about
>> MapGPA hypercall can be found in [1], sec 3.2.
>>
>> The call informs VMM about the conversion between private/shared
>> mappings. The shared memory is similar to unencrypted memory in AMD
>> SME/SEV terminology but the underlying process of sharing/un-sharing
>> the memory is different for Intel TDX guest platform.
>>
>> SEV assumes that I/O devices can only do DMA to "decrypted" physical
>> addresses without the C-bit set. In order for the CPU to interact with
>> this memory, the CPU needs a decrypted mapping. To add this support,
>> AMD SME code forces force_dma_unencrypted() to return true for
>> platforms that support AMD SEV feature. It will be used for DMA memory
>> allocation API to trigger set_memory_decrypted() for platforms that
>> support AMD SEV feature.
>>
>> TDX is similar. So, to communicate with I/O devices, related pages need
>> to be marked as shared. As mentioned above, shared memory in TDX
>> architecture is similar to decrypted memory in AMD SME/SEV. So similar
>> to AMD SEV, force_dma_unencrypted() has to forced to return true. This
>> support is added in other patches in this series.
>>
>> So move force_dma_unencrypted() out of AMD specific code and call AMD
>> specific (amd_force_dma_unencrypted()) initialization function from it.
>> force_dma_unencrypted() will be modified by later patches to include
>> Intel TDX guest platform specific initialization.
>>
>> Also, introduce new config option X86_MEM_ENCRYPT_COMMON that has to be
>> selected by all x86 memory encryption features. This will be selected
>> by both AMD SEV and Intel TDX guest config options.
>>
>> This is preparation for TDX changes in DMA code and it has no
>> functional change.
> 
> Can force_dma_unencrypted() be moved to arch/x86/kernel/cc_platform.c, 
> instead of creating a new file? It might fit better with patch #6.

Please check the final version of mem_encrypt_common.c

https://github.com/intel/tdx/blob/guest/arch/x86/mm/mem_encrypt_common.c

I am not sure whether it is alright to move mem_encrypt_init() and
arch_has_restricted_virtio_memory_access() to cc_platform.c

If this is fine, I can get rid of mem_encrypt_common.c

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
