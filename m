Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFC4D2E03
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 12:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiCILcP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Mar 2022 06:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiCILcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2022 06:32:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A83F14FFD4;
        Wed,  9 Mar 2022 03:31:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 233BF1655;
        Wed,  9 Mar 2022 03:31:15 -0800 (PST)
Received: from [10.163.33.203] (unknown [10.163.33.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFA443FA4D;
        Wed,  9 Mar 2022 03:31:03 -0800 (PST)
Message-ID: <f1b4dbb5-7cd4-7513-4b18-169b97745a0a@arm.com>
Date:   Wed, 9 Mar 2022 17:01:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 05/30] arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-parisc@vger.kernel.org,
        openrisc@lists.librecores.org, linux-um@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-6-git-send-email-anshuman.khandual@arm.com>
 <YiDessYDSt060Euc@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YiDessYDSt060Euc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/3/22 20:58, Catalin Marinas wrote:
> Hi Anshuman,
> 
> On Mon, Feb 28, 2022 at 04:17:28PM +0530, Anshuman Khandual wrote:
>> +static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>> +	case VM_NONE:
>> +		return PAGE_NONE;
>> +	case VM_READ:
>> +	case VM_WRITE:
>> +	case VM_WRITE | VM_READ:
>> +		return PAGE_READONLY;
>> +	case VM_EXEC:
>> +		return PAGE_EXECONLY;
>> +	case VM_EXEC | VM_READ:
>> +	case VM_EXEC | VM_WRITE:
>> +	case VM_EXEC | VM_WRITE | VM_READ:
>> +		return PAGE_READONLY_EXEC;
>> +	case VM_SHARED:
>> +		return PAGE_NONE;
>> +	case VM_SHARED | VM_READ:
>> +		return PAGE_READONLY;
>> +	case VM_SHARED | VM_WRITE:
>> +	case VM_SHARED | VM_WRITE | VM_READ:
>> +		return PAGE_SHARED;
>> +	case VM_SHARED | VM_EXEC:
>> +		return PAGE_EXECONLY;
>> +	case VM_SHARED | VM_EXEC | VM_READ:
>> +		return PAGE_READONLY_EXEC;
>> +	case VM_SHARED | VM_EXEC | VM_WRITE:
>> +	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
>> +		return PAGE_SHARED_EXEC;
>> +	default:
>> +		BUILD_BUG();
>> +	}
>> +}
> 
> I'd say ack for trying to get of the extra arch_vm_get_page_prot() and
> arch_filter_pgprot() but, TBH, I'm not so keen on the outcome. I haven't
> built the code to see what's generated but I suspect it's no significant
> improvement. As for the code readability, the arm64 parts don't look
> much better either. The only advantage with this patch is that all
> functions have been moved under arch/arm64.

Got it.

> 
> I'd keep most architectures that don't have own arch_vm_get_page_prot()
> or arch_filter_pgprot() unchanged and with a generic protection_map[]
> array. For architectures that need fancier stuff, add a
> CONFIG_ARCH_HAS_VM_GET_PAGE_PROT (as you do) and allow them to define
> vm_get_page_prot() while getting rid of arch_vm_get_page_prot() and
> arch_filter_pgprot(). I think you could also duplicate protection_map[]
> for architectures with own vm_get_page_prot() (make it static) and
> #ifdef it out in mm/mmap.c.
> 
> If later you have more complex needs or a switch statement generates
> better code, go for it, but for this series I'd keep things simple, only
> focus on getting rid of arch_vm_get_page_prot() and
> arch_filter_pgprot().

Got it.

> 
> If I grep'ed correctly, there are only 4 architectures that have own
> arch_vm_get_page_prot() (arm64, powerpc, sparc, x86) and 2 that have own
> arch_filter_pgprot() (arm64, x86). Try to only change these for the time
> being, together with the other generic mm cleanups you have in this
> series. I think there are a couple more that touch protection_map[]
> (arm, m68k). You can leave the generic protection_map[] global if the
> arch does not select ARCH_HAS_VM_GET_PAGE_PROT.

Okay, I will probably split the series into two parts.

-  Drop arch_vm_get_page_prot() and arch_filter_pgprot() on relevant
   platforms i.e arm64, powerpc, sparc and x86 via this new config
   ARCH_HAS_VM_GET_PAGE_PROT, keeping the generic protection_map[]
   since platform __SXXX/__PXX macros would be still around.

-  Drop __SXXX/__PXXX across all platforms via just initializing
   protection_map[] early during boot in the platform OR moving
   both vm_get_page_prot() via ARCH_HAS_VM_GET_PAGE_PROT and the
   generic protection_map[] inside the platform.

   There were some objections with respect to switch case code in
   comparison to the array based table look up.

> 
>> +static pgprot_t arm64_arch_filter_pgprot(pgprot_t prot)
>> +{
>> +	if (cpus_have_const_cap(ARM64_HAS_EPAN))
>> +		return prot;
>> +
>> +	if (pgprot_val(prot) != pgprot_val(PAGE_EXECONLY))
>> +		return prot;
>> +
>> +	return PAGE_READONLY_EXEC;
>> +}
>> +
>> +static pgprot_t arm64_arch_vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	pteval_t prot = 0;
>> +
>> +	if (vm_flags & VM_ARM64_BTI)
>> +		prot |= PTE_GP;
>> +
>> +	/*
>> +	 * There are two conditions required for returning a Normal Tagged
>> +	 * memory type: (1) the user requested it via PROT_MTE passed to
>> +	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
>> +	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
>> +	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
>> +	 * mmap() call since mprotect() does not accept MAP_* flags.
>> +	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
>> +	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
>> +	 */
>> +	if (vm_flags & VM_MTE)
>> +		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
>> +
>> +	return __pgprot(prot);
>> +}
>> +
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	pgprot_t ret = __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
>> +			pgprot_val(arm64_arch_vm_get_page_prot(vm_flags)));
>> +
>> +	return arm64_arch_filter_pgprot(ret);
>> +}
> 
> If we kept the array, we can have everything in a single function
> (untested and with my own comments for future changes):

Got it.

> 
> pgprot_t vm_get_page_prot(unsigned long vm_flags)
> {
> 	pgprot_t prot = __pgprot(pgprot_val(protection_map[vm_flags &
> 				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]));
> 
> 	/*
> 	 * We could get rid of this test if we updated protection_map[]
> 	 * to turn exec-only into read-exec during boot.
> 	 */
> 	if (!cpus_have_const_cap(ARM64_HAS_EPAN) &&
> 	    pgprot_val(prot) == pgprot_val(PAGE_EXECONLY))
> 		prot = PAGE_READONLY_EXEC;
> 
> 	if (vm_flags & VM_ARM64_BTI)
> 		prot != PTE_GP;
> 
> 	/*
> 	 * We can get rid of the requirement for PROT_NORMAL to be 0
> 	 * since here we can mask out PTE_ATTRINDX_MASK.
> 	 */
> 	if (vm_flags & VM_MTE) {
> 		prot &= ~PTE_ATTRINDX_MASK;
> 		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
> 	}
> 
> 	return prot;
> }
> 
