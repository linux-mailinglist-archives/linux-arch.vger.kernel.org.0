Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E918339AD2
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCMBSt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 20:18:49 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52388 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232257AbhCMBSV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 20:18:21 -0500
Received: from ambrosehua-HP-xw6600-Workstation (unknown [222.209.9.50])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGdbQEkxg0agYAA--.9492S2;
        Sat, 13 Mar 2021 09:18:09 +0800 (CST)
Date:   Sat, 13 Mar 2021 09:18:08 +0800
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: Re: [PATCH 1/2] MIPS: clean up CONFIG_MIPS_PGD_C0_CONTEXT handling
Message-ID: <20210313011807.hwnwo3olqnxvgjsh@ambrosehua-HP-xw6600-Workstation>
References: <20210309080210.25561-1-huangpei@loongson.cn>
 <20210309080210.25561-2-huangpei@loongson.cn>
 <20210312102410.GA7027@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312102410.GA7027@alpha.franken.de>
User-Agent: NeoMutt/20171215
X-CM-TRANSID: AQAAf9AxGdbQEkxg0agYAA--.9492S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4DGrW3Zr13GrW3JrWDArb_yoW5Zw43p3
        4Sga1kCw4Ivr15ZryUta1DXw4rtw4qyFZ5Wr1Igr909rWqqF1v9w48GrsIyrn7CF1kWF1x
        ZF4jqFyYkr1DKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbLiSPUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, my calculate is wrong, but the result is right


Here is the new one:

CP0 Context has enough room for wraping pgd into its 41-bit PTEBase field.

+. For XPHYS, the trick is that pgd is 4kB aligned, and the PABITS <= 53,
only save 53 - 12 = 41 bit

   bit[63:59] | 0000 00 |  bit[52:12] | 0000 0000 0000

+. for CKSEG0, only save 29 - 12 = 17 bits

So, when switch pgd, only save bit[52:12] or bit[28:12] into CP0 Context's
bit[63:23], see following asm generated at runtime, ao hold pgd

	.set	push
	.set	noreorder

tlbmiss_handler_setup_pgd:

	dsra	a2, a0, 29
	move	a3, a0
	dins	a0, zero, 29, 35
	daddiu	a2, a2, 4

	movn	a0, a3, a2
	dsll	a0, a0, 11
	jr	ra
	dmtc0	a0, CP0_CONTEXT

	.set	pop

when used pgd at page walking

	dmfc0	k0, CP0_CONTEXT
	dins	k0, k0, 0, 23	         //zero badv2 
	ori	k0, k0, (CAC_BASE >> 53) //*prefix* with bit[63:59]
	drotr	k0, k0, 11		 // kick it at right position


On Fri, Mar 12, 2021 at 11:24:10AM +0100, Thomas Bogendoerfer wrote:
> On Tue, Mar 09, 2021 at 04:02:09PM +0800, Huang Pei wrote:
> > +. LOONGSON64 use 0x98xx_xxxx_xxxx_xxxx as xphys cached
> > 
> > +. let CONFIG_MIPS_PGD_C0_CONTEXT depend on 64bit
> > 
> > +. cast CAC_BASE into u64 to silence warning on MIPS32
> > 
> > CP0 Context has enough room for wraping pgd into its 41-bit PTEBase field.
> > 
> > +. For XPHYS, the trick is that pgd is 4kB aligned, and the PABITS <= 48,
> > only save 48 - 12 + 5(for bit[63:59]) = 41 bits, aka. :
> > 
> >    bit[63:59] | 0000 0000 000 |  bit[47:12] | 0000 0000 0000
> > 
> > +. for CKSEG0, only save 29 - 12 = 17 bits
> 
> you are explaining what you are doing, but not why you are doing this.
> So why are you doing this ?
> 
> >  #
> >  # Set to y for ptrace access to watch registers.
> > diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> > index a7521b8f7658..591cfa0fca02 100644
> > --- a/arch/mips/mm/tlbex.c
> > +++ b/arch/mips/mm/tlbex.c
> > @@ -848,8 +848,8 @@ void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
> >  		/* Clear lower 23 bits of context. */
> >  		uasm_i_dins(p, ptr, 0, 0, 23);
> >  
> > -		/* 1 0	1 0 1  << 6  xkphys cached */
> > -		uasm_i_ori(p, ptr, ptr, 0x540);
> > +		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
> > +		uasm_i_ori(p, ptr, ptr, ((u64)(CAC_BASE) >> 53));
> 
> you want to use bits 63..59 but picking bits 63..53 with this.  While
> bits 58..53 are probably 0, wouldn't it make also sense to mask them out ?
> 
> >  		uasm_i_drotr(p, ptr, ptr, 11);
> >  #elif defined(CONFIG_SMP)
> >  		UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
> > @@ -1164,8 +1164,9 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
> >  
> >  	if (pgd_reg == -1) {
> >  		vmalloc_branch_delay_filled = 1;
> > -		/* 1 0	1 0 1  << 6  xkphys cached */
> > -		uasm_i_ori(p, ptr, ptr, 0x540);
> > +		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
> > +		uasm_i_ori(p, ptr, ptr, ((u64)(CAC_BASE) >> 53));
> > +
> >  		uasm_i_drotr(p, ptr, ptr, 11);
> >  	}
> >  
> > @@ -1292,7 +1293,6 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
> >  
> >  	return rv;
> >  }
> > -
> >  /*
> 
> why are you removing this empty line ? I'd prefer that it stays there...
> 
> >   * For a 64-bit kernel, we are using the 64-bit XTLB refill exception
> >   * because EXL == 0.  If we wrap, we can also use the 32 instruction
> > -- 
> > 2.17.1
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]

