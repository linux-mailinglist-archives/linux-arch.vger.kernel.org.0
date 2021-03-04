Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC032C9E5
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbhCDBPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 20:15:21 -0500
Received: from mail.loongson.cn ([114.242.206.163]:35286 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1450754AbhCDBHY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 20:07:24 -0500
Received: from ambrosehua-HP-xw6600-Workstation (unknown [182.149.162.140])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax6dWPMkBg7hMUAA--.6296S2;
        Thu, 04 Mar 2021 09:06:25 +0800 (CST)
Date:   Thu, 4 Mar 2021 09:06:23 +0800
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
Message-ID: <20210304010623.4tyzpzgllsdy3ssg@ambrosehua-HP-xw6600-Workstation>
References: <20210227061944.266415-1-huangpei@loongson.cn>
 <20210227061944.266415-2-huangpei@loongson.cn>
 <alpine.DEB.2.21.2102282346400.44210@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2102282346400.44210@angie.orcam.me.uk>
User-Agent: NeoMutt/20171215
X-CM-TRANSID: AQAAf9Ax6dWPMkBg7hMUAA--.6296S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyxXrWUXFW8ZryxCr1xXwb_yoW8ur1xpa
        95t3WkGr4jvryjgrZIvFZ8Xr4Fqw4qk3s0vFnFqF9xtFWjgFyrGFs7Gr1S9rn8AFs2ya17
        WryYgFy5uF1Iyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbLiSPUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, 
On Mon, Mar 01, 2021 at 12:00:28AM +0100, Maciej W. Rozycki wrote:
> On Sat, 27 Feb 2021, Huang Pei wrote:
> 
> > index 2000bb2b0220..517509ad8596 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -2142,6 +2142,7 @@ config CPU_SUPPORTS_HUGEPAGES
> >  	depends on !(32BIT && (ARCH_PHYS_ADDR_T_64BIT || EVA))
> >  config MIPS_PGD_C0_CONTEXT
> >  	bool
> > +	depends on 64BIT
> >  	default y if 64BIT && (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP
> 
>  I guess you want:
> 
> 	default y if (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP
> 
> at the same time too.  Otherwise you have cruft left behind.
> 
Yes, it is much better
> > diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> > index a7521b8f7658..5bb9724578f7 100644
> > --- a/arch/mips/mm/tlbex.c
> > +++ b/arch/mips/mm/tlbex.c
> > @@ -1106,6 +1106,7 @@ struct mips_huge_tlb_info {
> >  	bool need_reload_pte;
> >  };
> >  
> > +#ifdef CONFIG_64BIT
> >  static struct mips_huge_tlb_info
> >  build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
> >  			       struct uasm_reloc **r, unsigned int tmp,
> 
>  Does it actually build without a warning for !CONFIG_64BIT given the 
> reference below?

No, my bad, my first reaction when seeing "IS_ENABLED(CONFIG_64BIT)" is
"#ifdef CONFIG_64BIT"
> 
> > @@ -1164,8 +1165,8 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
> >  
> >  	if (pgd_reg == -1) {
> >  		vmalloc_branch_delay_filled = 1;
> > -		/* 1 0	1 0 1  << 6  xkphys cached */
> > -		uasm_i_ori(p, ptr, ptr, 0x540);
> > +		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
> > +		uasm_i_ori(p, ptr, ptr, (CAC_BASE >> 53));
> 
>  Instead I'd paper the issue over by casting the constant to `s64'.
> 
>  Or better yet fixed it properly by defining CAC_BASE, etc. as `unsigned
> long long' long rather than `unsigned long' to stop all this nonsense 
> (e.g. PHYS_TO_XKPHYS already casts the result to `s64').  Thomas, WDYT?
Sorry, I do not get it , on MIPS32, how can CAC_BASE be unsigned long
long ?


If this did not work, how about one step back, just explicit comment
wihtout "(CAC_BASE << 53)" ?
> 
>   Maciej

