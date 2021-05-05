Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BFA373563
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhEEHMg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 03:12:36 -0400
Received: from foss.arm.com ([217.140.110.172]:39364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhEEHMg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 May 2021 03:12:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E94FD6E;
        Wed,  5 May 2021 00:11:39 -0700 (PDT)
Received: from [10.163.78.57] (unknown [10.163.78.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EFB53F718;
        Wed,  5 May 2021 00:11:30 -0700 (PDT)
Subject: Re: [PATCH V2] mm: Define default value for FIRST_USER_ADDRESS
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1618550254-14511-1-git-send-email-anshuman.khandual@arm.com>
 <20210505062731.GS3288043@lianli.shorne-pla.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <189feda7-5d1b-d3d3-3ae9-343987a433f0@arm.com>
Date:   Wed, 5 May 2021 12:42:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210505062731.GS3288043@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/5/21 11:57 AM, Stafford Horne wrote:
> On Fri, Apr 16, 2021 at 10:47:34AM +0530, Anshuman Khandual wrote:
>> Currently most platforms define FIRST_USER_ADDRESS as 0UL duplication the
>> same code all over. Instead just define a generic default value (i.e 0UL)
>> for FIRST_USER_ADDRESS and let the platforms override when required. This
>> makes it much cleaner with reduced code.
>>
>> The default FIRST_USER_ADDRESS here would be skipped in <linux/pgtable.h>
>> when the given platform overrides its value via <asm/pgtable.h>.
>>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Guo Ren <guoren@kernel.org>
>> Cc: Brian Cain <bcain@codeaurora.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>> Cc: Stafford Horne <shorne@gmail.com>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v5.12-rc7 and has been boot tested on arm64 platform.
>> But has been cross compiled on multiple other platforms.
>>
>> Changes in V2:
>>
>> - Dropped ARCH_HAS_FIRST_USER_ADDRESS construct
>>
>> Changes in V1:
>>
>> https://patchwork.kernel.org/project/linux-mm/patch/1618368899-20311-1-git-send-email-anshuman.khandual@arm.com/
>>
>>  arch/alpha/include/asm/pgtable.h             | 1 -
>>  arch/arc/include/asm/pgtable.h               | 6 ------
>>  arch/arm64/include/asm/pgtable.h             | 2 --
>>  arch/csky/include/asm/pgtable.h              | 1 -
>>  arch/hexagon/include/asm/pgtable.h           | 3 ---
>>  arch/ia64/include/asm/pgtable.h              | 1 -
>>  arch/m68k/include/asm/pgtable_mm.h           | 1 -
>>  arch/microblaze/include/asm/pgtable.h        | 2 --
>>  arch/mips/include/asm/pgtable-32.h           | 1 -
>>  arch/mips/include/asm/pgtable-64.h           | 1 -
>>  arch/nios2/include/asm/pgtable.h             | 2 --
>>  arch/openrisc/include/asm/pgtable.h          | 1 -
> 
> Acked-by: Stafford Horne <shorne@gmail.com>
> 
>>  arch/parisc/include/asm/pgtable.h            | 2 --
>>  arch/powerpc/include/asm/book3s/pgtable.h    | 1 -
>>  arch/powerpc/include/asm/nohash/32/pgtable.h | 1 -
>>  arch/powerpc/include/asm/nohash/64/pgtable.h | 2 --
>>  arch/riscv/include/asm/pgtable.h             | 2 --
>>  arch/s390/include/asm/pgtable.h              | 2 --
>>  arch/sh/include/asm/pgtable.h                | 2 --
>>  arch/sparc/include/asm/pgtable_32.h          | 1 -
>>  arch/sparc/include/asm/pgtable_64.h          | 3 ---
>>  arch/um/include/asm/pgtable-2level.h         | 1 -
>>  arch/um/include/asm/pgtable-3level.h         | 1 -
>>  arch/x86/include/asm/pgtable_types.h         | 2 --
>>  arch/xtensa/include/asm/pgtable.h            | 1 -
>>  include/linux/pgtable.h                      | 9 +++++++++
>>  26 files changed, 9 insertions(+), 43 deletions(-)
> 
> This all looks fine to me, will this be merged via the arm tree?  I guess you
> have a means for that.

I am hoping that this should go via the MM tree instead.
