Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AB439EFE7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 09:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHHuL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 03:50:11 -0400
Received: from foss.arm.com ([217.140.110.172]:51446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhFHHuJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 03:50:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7F53ED1;
        Tue,  8 Jun 2021 00:48:16 -0700 (PDT)
Received: from [10.163.83.140] (unknown [10.163.83.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 500663F719;
        Tue,  8 Jun 2021 00:48:08 -0700 (PDT)
Subject: Re: [PATCH] mm/thp: Define default pmd_pgtable()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Hu <nickhu@andestech.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
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
        Chris Zankel <chris@zankel.net>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1623130327-13325-1-git-send-email-anshuman.khandual@arm.com>
 <CAMuHMdWVrUgfXAud_3fpjfO-1yqXzf75Jtk6SNqqcR39-ZzQJA@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8f851179-586d-4491-e650-ed3e5ea7b002@arm.com>
Date:   Tue, 8 Jun 2021 13:18:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWVrUgfXAud_3fpjfO-1yqXzf75Jtk6SNqqcR39-ZzQJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 6/8/21 12:28 PM, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> On Tue, Jun 8, 2021 at 7:31 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> Currently most platforms define pmd_pgtable() as pmd_page() duplicating the
>> same code all over. Instead just define a default value i.e pmd_page() for
>> pmd_pgtable() and let platforms override when required via <asm/pgtable.h>.
>> All the existing platform that override pmd_pgtable() have been moved into
>> their respective <asm/pgtable.h> header in order to precede before the new
>> generic definition. This makes it much cleaner with reduced code.
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Thanks for your patch!
> 
>> This patch has been built tested across multiple platforms. But the m68k
>> changes in particular might not be optimal, followed the existing switch
>> from (arch/m68k/include/asm/pgalloc.h).
> Indeed.  Why not move them to the existing
> arch/m68k/asm/{sun3,mcf,motorola}_pgtable.h>, instead of introducing
> yet another #if/#elif/#else/#endif block?
> 

Yes, that works. Will change.
