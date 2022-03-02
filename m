Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843E4C9C0D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Mar 2022 04:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiCBDXJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 22:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiCBDXJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 22:23:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2738B272A;
        Tue,  1 Mar 2022 19:22:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D55FF11FB;
        Tue,  1 Mar 2022 19:22:25 -0800 (PST)
Received: from [10.163.49.202] (unknown [10.163.49.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000B23F73D;
        Tue,  1 Mar 2022 19:22:16 -0800 (PST)
Subject: Re: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
 <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
 <542fa048-131e-240b-cc3a-fd4fff7ce4ba@arm.com>
 <Yh1pYAOiskEQes3p@shell.armlinux.org.uk>
 <dc3c95a4-de06-9889-ce1e-f660fc9fbb95@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c3b60de0-38cd-160a-aa15-831349e07e23@arm.com>
Date:   Wed, 2 Mar 2022 08:52:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dc3c95a4-de06-9889-ce1e-f660fc9fbb95@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/1/22 1:46 PM, Christophe Leroy wrote:
> 
> 
> Le 01/03/2022 à 01:31, Russell King (Oracle) a écrit :
>> On Tue, Mar 01, 2022 at 05:30:41AM +0530, Anshuman Khandual wrote:
>>> On 2/28/22 4:27 PM, Russell King (Oracle) wrote:
>>>> On Mon, Feb 28, 2022 at 04:17:32PM +0530, Anshuman Khandual wrote:
>>>>> This defines and exports a platform specific custom vm_get_page_prot() via
>>>>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>>>>> macros can be dropped which are no longer needed.
>>>>
>>>> What I would really like to know is why having to run _code_ to work out
>>>> what the page protections need to be is better than looking it up in a
>>>> table.
>>>>
>>>> Not only is this more expensive in terms of CPU cycles, it also brings
>>>> additional code size with it.
>>>>
>>>> I'm struggling to see what the benefit is.
>>>
>>> Currently vm_get_page_prot() is also being _run_ to fetch required page
>>> protection values. Although that is being run in the core MM and from a
>>> platform perspective __SXXX, __PXXX are just being exported for a table.
>>> Looking it up in a table (and applying more constructs there after) is
>>> not much different than a clean switch case statement in terms of CPU
>>> usage. So this is not more expensive in terms of CPU cycles.
>>
>> I disagree.
> 
> So do I.
> 
>>
>> However, let's base this disagreement on some evidence. Here is the
>> present 32-bit ARM implementation:
>>
>> 00000048 <vm_get_page_prot>:
>>        48:       e200000f        and     r0, r0, #15
>>        4c:       e3003000        movw    r3, #0
>>                          4c: R_ARM_MOVW_ABS_NC   .LANCHOR1
>>        50:       e3403000        movt    r3, #0
>>                          50: R_ARM_MOVT_ABS      .LANCHOR1
>>        54:       e7930100        ldr     r0, [r3, r0, lsl #2]
>>        58:       e12fff1e        bx      lr
>>
>> That is five instructions long.
> 
> On ppc32 I get:
> 
> 00000094 <vm_get_page_prot>:
>        94:	3d 20 00 00 	lis     r9,0
> 			96: R_PPC_ADDR16_HA	.data..ro_after_init
>        98:	54 84 16 ba 	rlwinm  r4,r4,2,26,29
>        9c:	39 29 00 00 	addi    r9,r9,0
> 			9e: R_PPC_ADDR16_LO	.data..ro_after_init
>        a0:	7d 29 20 2e 	lwzx    r9,r9,r4
>        a4:	91 23 00 00 	stw     r9,0(r3)
>        a8:	4e 80 00 20 	blr
> 
> 
>>
>> Please show that your new implementation is not more expensive on
>> 32-bit ARM. Please do so by building a 32-bit kernel, and providing
>> the disassembly.
> 
> With your series I get:
> 
> 00000000 <vm_get_page_prot>:
>     0:	3d 20 00 00 	lis     r9,0
> 			2: R_PPC_ADDR16_HA	.rodata
>     4:	39 29 00 00 	addi    r9,r9,0
> 			6: R_PPC_ADDR16_LO	.rodata
>     8:	54 84 16 ba 	rlwinm  r4,r4,2,26,29
>     c:	7d 49 20 2e 	lwzx    r10,r9,r4
>    10:	7d 4a 4a 14 	add     r10,r10,r9
>    14:	7d 49 03 a6 	mtctr   r10
>    18:	4e 80 04 20 	bctr
>    1c:	39 20 03 15 	li      r9,789
>    20:	91 23 00 00 	stw     r9,0(r3)
>    24:	4e 80 00 20 	blr
>    28:	39 20 01 15 	li      r9,277
>    2c:	91 23 00 00 	stw     r9,0(r3)
>    30:	4e 80 00 20 	blr
>    34:	39 20 07 15 	li      r9,1813
>    38:	91 23 00 00 	stw     r9,0(r3)
>    3c:	4e 80 00 20 	blr
>    40:	39 20 05 15 	li      r9,1301
>    44:	91 23 00 00 	stw     r9,0(r3)
>    48:	4e 80 00 20 	blr
>    4c:	39 20 01 11 	li      r9,273
>    50:	4b ff ff d0 	b       20 <vm_get_page_prot+0x20>
> 
> 
> That is definitely more expensive, it implements a table of branches.

Okay, will split out the PPC32 implementation that retains existing
table look up method. Also planning to keep that inside same file
(arch/powerpc/mm/mmap.c), unless you have a difference preference.
