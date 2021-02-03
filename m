Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556530D7BF
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhBCKlL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 05:41:11 -0500
Received: from elvis.franken.de ([193.175.24.41]:49428 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233577AbhBCKlK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 05:41:10 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1l7FaD-0005T6-00; Wed, 03 Feb 2021 11:40:25 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 56F80C0D49; Wed,  3 Feb 2021 11:36:47 +0100 (CET)
Date:   Wed, 3 Feb 2021 11:36:47 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huang Pei <huangpei@loongson.cn>
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
Subject: Re: [PATCH] MIPS: fix kernel_stack_pointer()
Message-ID: <20210203103647.GA7586@alpha.franken.de>
References: <20210129043507.30488-1-huangpei@loongson.cn>
 <20210201122352.GA8095@alpha.franken.de>
 <20210202013231.wzyb7clsu7jsze4v@ambrosehua-HP-xw6600-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202013231.wzyb7clsu7jsze4v@ambrosehua-HP-xw6600-Workstation>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 02, 2021 at 09:32:31AM +0800, Huang Pei wrote:
> On Mon, Feb 01, 2021 at 01:23:52PM +0100, Thomas Bogendoerfer wrote:
> > On Fri, Jan 29, 2021 at 12:35:07PM +0800, Huang Pei wrote:
> > > MIPS always save kernel stack pointer in regs[29]
> > > 
> > > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > > ---
> > >  arch/mips/include/asm/ptrace.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> > > index 1e76774b36dd..daf3cf244ea9 100644
> > > --- a/arch/mips/include/asm/ptrace.h
> > > +++ b/arch/mips/include/asm/ptrace.h
> > > @@ -53,7 +53,7 @@ struct pt_regs {
> > >  
> > >  static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
> > >  {
> > > -	return regs->regs[31];
> > > +	return regs->regs[29];
> > 
> > hmm, I'm still wondering where the trick is... looks like this is used
> > for uprobes, so nobody has ever used uprobes or I'm missing something.
> > 
> > How did you find that ?
> > 
> > Thomas.
> > 
> > -- 
> > Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> > good idea.                                                [ RFC1925, 2.3 ]
> 
> 
> Long story for short, 
> 
> +. I think I had fix this bug in 2018, when I backported Uprobe from my
> 4.4 branch to CentOS 7 3.10. I just knwo it is *not* following MIPS
> ABI, but I do not know how it destroy the cool function of
> Kprobe/Uprobe, since the failure in porting eBPF from upstream to 3.10
> just leave the fix in 3.10, totally forgotten.
> 
> +. In 2020, I was told to validate the effect of GNU XHash, and it came
> to me that using Uprobe to count the number of "strcmp" called in ld.so,
> so I found this fix again.
> 
> +. With more work on Kprobe/Kprobe_event/Uprobe, I found it hit only when
> accessing arguments of Kprobe/Uprobe, so simple counting numbers of probe
> fired would not trigger it

Thank you for the explanation, applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
