Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580DB32E2D3
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 08:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEHNz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 02:13:55 -0500
Received: from mail.loongson.cn ([114.242.206.163]:54136 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229458AbhCEHNy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 02:13:54 -0500
Received: from ambrosehua-HP-xw6600-Workstation (unknown [182.149.161.105])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCdYS2kFgsLUUAA--.7112S2;
        Fri, 05 Mar 2021 15:13:24 +0800 (CST)
Date:   Fri, 5 Mar 2021 15:13:22 +0800
From:   Huang Pei <huangpei@loongson.cn>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH] MIPS: clean up CONFIG_MIPS_PGD_C0_CONTEXT handling
Message-ID: <20210305071322.srv5gv5sro5p4dll@ambrosehua-HP-xw6600-Workstation>
References: <20210227061944.266415-1-huangpei@loongson.cn>
 <20210227061944.266415-2-huangpei@loongson.cn>
 <alpine.DEB.2.21.2102282346400.44210@angie.orcam.me.uk>
 <20210304010623.4tyzpzgllsdy3ssg@ambrosehua-HP-xw6600-Workstation>
 <alpine.DEB.2.21.2103040227500.19637@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2103040227500.19637@angie.orcam.me.uk>
User-Agent: NeoMutt/20171215
X-CM-TRANSID: AQAAf9AxCdYS2kFgsLUUAA--.7112S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw13Xr1ktr1rWFW3Wr17ZFb_yoWrGw17pa
        yDu34DtrW5KryUXryj9w1vyrs0qr4UCryaqFy7KFWkAFyxKF18Xws7Gr90vryqqFsY9a1U
        Wryag3s8GrZ7Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUBpB-UUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,
On Thu, Mar 04, 2021 at 02:40:54AM +0100, Maciej W. Rozycki wrote:
> On Thu, 4 Mar 2021, Huang Pei wrote:
> 
> > > > @@ -1164,8 +1165,8 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
> > > >  
> > > >  	if (pgd_reg == -1) {
> > > >  		vmalloc_branch_delay_filled = 1;
> > > > -		/* 1 0	1 0 1  << 6  xkphys cached */
> > > > -		uasm_i_ori(p, ptr, ptr, 0x540);
> > > > +		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
> > > > +		uasm_i_ori(p, ptr, ptr, (CAC_BASE >> 53));
> > > 
> > >  Instead I'd paper the issue over by casting the constant to `s64'.
> > > 
> > >  Or better yet fixed it properly by defining CAC_BASE, etc. as `unsigned
> > > long long' long rather than `unsigned long' to stop all this nonsense 
> > > (e.g. PHYS_TO_XKPHYS already casts the result to `s64').  Thomas, WDYT?
> > Sorry, I do not get it , on MIPS32, how can CAC_BASE be unsigned long
> > long ?
> 
>  By using the `ULL' suffix with constants.  It won't change code produced, 
> because they are unsigned anyway and the compiler will truncate them with 
> no change to the actual value to fit in narrower data types as needed, but 
> it will silence the warnings.
> 
>   Maciej


On Linux 5.11 with this patch and **ONLY** attaching ULL to CAC_BASE in 
arch/mips/include/asm/mach-generic/space.h for CONFIG_32BIT, cross gcc
7.5 in Ubuntu 18.04, loongon1c_defconfig

..........

make[1]: Entering directory '/home/hp/projects/Linux/temp/out_stable'
  GEN     Makefile
  CALL    /home/hp/projects/Linux/temp/linux-stable/scripts/atomic/check-atomics.sh
  CALL    /home/hp/projects/Linux/temp/linux-stable/scripts/checksyscalls.sh
  CC      arch/mips/mm/cache.o
  CC      arch/mips/kernel/branch.o
  CC      arch/mips/mm/context.o
  CC      arch/mips/loongson32/common/time.o
  CC      arch/mips/loongson32/ls1c/board.o
  CHK     include/generated/compile.h
  CC      arch/mips/vdso/vgettimeofday.o
  HOSTCC  arch/mips/vdso/genvdso
  CC      kernel/sched/cputime.o
In file included from /home/hp/projects/Linux/temp/linux-stable/arch/mips/include/asm/mmiowb.h:5:0,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/spinlock.h:61,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/wait.h:9,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/wait_bit.h:8,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/fs.h:6,
                 from /home/hp/projects/Linux/temp/linux-stable/arch/mips/mm/cache.c:9:
/home/hp/projects/Linux/temp/linux-stable/arch/mips/include/asm/io.h: In function ‘phys_to_virt’:
/home/hp/projects/Linux/temp/linux-stable/arch/mips/include/asm/io.h:122:9: error: cast to pointer 
from integer of different size [-Werror=int-to-pointer-cast]
  return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
         ^
In file included from /home/hp/projects/Linux/temp/linux-stable/arch/mips/include/asm/mmiowb.h:5:0,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/spinlock.h:61,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/wait.h:9,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/pid.h:6,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/sched.h:14,
                 from /home/hp/projects/Linux/temp/linux-stable/include/linux/sched/signal.h:7,
                 from /home/hp/projects/Linux/temp/linux-stable/arch/mips/kernel/branch.c:10:
/home/hp/projects/Linux/temp/linux-stable/arch/mips/include/asm/io.h: In function ‘phys_to_virt’:
/home/hp/projects/Linux/temp/linux-stable/arch/mips/include/asm/io.h:122:9: error: cast to pointer 
from integer of different size [-Werror=int-to-pointer-cast]
  return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);


.........

Only change CAC_BASE Does NOT work 


Huang Pei

