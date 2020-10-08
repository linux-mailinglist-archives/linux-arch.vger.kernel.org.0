Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E302E286D2B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 05:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgJHDbF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 23:31:05 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59028 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727449AbgJHDbF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Oct 2020 23:31:05 -0400
Received: from ambrosehua-HP-xw6600-Workstation (unknown [182.149.161.192])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWuTkh35f4UEbAA--.39703S2;
        Thu, 08 Oct 2020 11:30:46 +0800 (CST)
Date:   Thu, 8 Oct 2020 11:30:43 +0800
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH V3] MIPS: make userspace mapping young by default
Message-ID: <20201008033043.x2fyc354ivjqyfe3@ambrosehua-HP-xw6600-Workstation>
References: <20200919074731.22372-1-huangpei@loongson.cn>
 <20201002123502.GA11098@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002123502.GA11098@alpha.franken.de>
User-Agent: NeoMutt/20171215
X-CM-TRANSID: AQAAf9AxWuTkh35f4UEbAA--.39703S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryUJw18XF1DtrWrAryUtrb_yoW5ur48pa
        s7CF10kr4jqr13ArWfAwnFyr1rJws3KF4vgF93Zw1rZa4av3s5Jrn5KFZ3ZryDXFZ2kFW8
        urW5WF15WrsIvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JU-miiUUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 02, 2020 at 02:35:03PM +0200, Thomas Bogendoerfer wrote:
Hi, 
> On Sat, Sep 19, 2020 at 03:47:31PM +0800, Huang Pei wrote:
> > MIPS page fault path take 3 exceptions (1 TLB Miss + 2 TLB Invalid), but
> > the second TLB Invalid exception is just triggered by __update_tlb from
> > do_page_fault writing tlb without _PAGE_VALID set. With this patch, it
> > only take 1 TLB Miss + 1 TLB Invalid exceptions
> > 
> > This version removes pte_sw_mkyoung without polluting MM code and makes
> > page fault delay of MIPS on par with other architecture and covers both
> > no-RIXI and RIXI MIPS CPUS
> > 
> > [1]: https://lkml.kernel.org/lkml/1591416169-26666-1-git-send-email
> > -maobibo@loongson.cn/
> > ---
> > V3:
> > - reformat with whitespace cleaned up following Thomas's advice
> > V2:
> > - remove unused asm-generic definition of pte_sw_mkyoung following Mao's
> > advice
> > ---
> > Co-developed-by: Huang Pei <huangpei@loongson.cn>
> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > Co-developed-by: Bibo Mao <maobibo@loonson.cn>
> > ---
> >  arch/mips/include/asm/pgtable.h | 10 ++++------
> >  arch/mips/mm/cache.c            | 25 +++++++++++++------------
> >  include/linux/pgtable.h         |  8 --------
> >  mm/memory.c                     |  3 ---
> >  4 files changed, 17 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> > index dd7a0f552cac..931fb35730f0 100644
> > --- a/arch/mips/include/asm/pgtable.h
> > +++ b/arch/mips/include/asm/pgtable.h
> > @@ -27,11 +27,11 @@ struct vm_area_struct;
> >  
> >  #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
> >  				 _page_cachable_default)
> > -#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
> > -				 _page_cachable_default)
> > +#define PAGE_SHARED    __pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
> > +				 __READABLE | _page_cachable_default)
> 
> you are still doing a white space changes here. 
> 
> >  #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
> > -				 _page_cachable_default)
> > -#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
> > +				 __READABLE | _page_cachable_default)
> > +#define PAGE_READONLY	__pgprot(_PAGE_PRESENT |  __READABLE | \
> 
sorry, my bad
> I've grepped for usage of PAGE_SHARED and PAGE_READONLY and found
> arch/mips/kvm/mmu.c and arch/mips/kernel/vdso.c. I wonder
> 
for arch/mips/kvm/mmu.c, the comment says:
...
	/* Also set valid and dirty, so refill handler doesn't have to */
	*ptep = pte_mkyoung(pte_mkdirty(pfn_pte(pfn, PAGE_SHARED)));
...
the net effect is the same, dirty and valid, so I think it is ok;

for arch/mips/kernel/vdso.c, both mappings are kernel mapping, which
means the physical memory(or io memory) is already allocated and will not
be reclaimed by kernel.
       
> 1. Is this usage correct or should we use protection_map[X] ?
> 2. Are this still correct after the change in this patch ?
> 
> Right now I'm in favour to fist clean up asm/pgtable.h to get rid
> of all unneeded PAGE_XXX defines and make mm/cache.c rixi part
> more readable before applying this patch.
>
I think we can clean up rixi part of mm/cache.c after this patch, or
within V4;

> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]

