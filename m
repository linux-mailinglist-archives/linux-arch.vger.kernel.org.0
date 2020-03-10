Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD99D17FF66
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 14:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCJNrA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Mar 2020 09:47:00 -0400
Received: from foss.arm.com ([217.140.110.172]:37284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgCJNrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Mar 2020 09:47:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8E4A30E;
        Tue, 10 Mar 2020 06:46:58 -0700 (PDT)
Received: from [10.163.1.203] (unknown [10.163.1.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26DEA3F6CF;
        Tue, 10 Mar 2020 06:46:44 -0700 (PDT)
Subject: Re: [PATCH V2] mm/special: Create generic fallbacks for pte_special()
 and pte_mkspecial()
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1583802551-15406-1-git-send-email-anshuman.khandual@arm.com>
 <20200310132747.GA12601@alpha.franken.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a8341dde-aa59-b425-ac23-b6005e0a67ec@arm.com>
Date:   Tue, 10 Mar 2020 19:16:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200310132747.GA12601@alpha.franken.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 03/10/2020 06:57 PM, Thomas Bogendoerfer wrote:
> On Tue, Mar 10, 2020 at 06:39:11AM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
>> index aef5378f909c..8e4e4be1ca00 100644
>> --- a/arch/mips/include/asm/pgtable.h
>> +++ b/arch/mips/include/asm/pgtable.h
>> @@ -269,6 +269,36 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>>   */
>>  extern pgd_t swapper_pg_dir[];
>>  
>> +/*
>> + * Platform specific pte_special() and pte_mkspecial() definitions
>> + * are required only when ARCH_HAS_PTE_SPECIAL is enabled.
>> + */
>> +#if !defined(CONFIG_32BIT) && !defined(CONFIG_CPU_HAS_RIXI)
> 
> this looks wrong.
> 
> current Kconfig statement is
> 
> select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)
> 
> so we can't use PTE_SPECIAL on 32bit _and_ CPUs with RIXI support.

I already had asked for clarification on this.

> 
> Why can't we use
> 
> #if defined(CONFIG_ARCH_HAS_PTE_SPECIAL)
> 
> here as the comment already suggests ?

Yes, that will be easier and will automatically adjust in case
ARCH_HAS_PTE_SPECIAL scope changes later. Will respin the patch.

> 
> Thomas.
> 
