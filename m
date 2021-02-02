Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7467730B4B8
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 02:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBBBdc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 20:33:32 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52066 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230106AbhBBBdc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 20:33:32 -0500
Received: from ambrosehua-HP-xw6600-Workstation (unknown [222.209.8.92])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax6dWvqxhg55gBAA--.961S2;
        Tue, 02 Feb 2021 09:32:33 +0800 (CST)
Date:   Tue, 2 Feb 2021 09:32:31 +0800
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
Subject: Re: [PATCH] MIPS: fix kernel_stack_pointer()
Message-ID: <20210202013231.wzyb7clsu7jsze4v@ambrosehua-HP-xw6600-Workstation>
References: <20210129043507.30488-1-huangpei@loongson.cn>
 <20210201122352.GA8095@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201122352.GA8095@alpha.franken.de>
User-Agent: NeoMutt/20171215
X-CM-TRANSID: AQAAf9Ax6dWvqxhg55gBAA--.961S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUGryUJrWDCr47Kw17KFg_yoW8Ar4fpF
        ZFy3Z5KFWkKryUGF9rJaySkr1ayrs8GrZ8KFW5JrW7WF9xXF1DXryxGr45Awn7Crsrta48
        XFWaq3s8CFW7ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUOMKZDUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 01, 2021 at 01:23:52PM +0100, Thomas Bogendoerfer wrote:
> On Fri, Jan 29, 2021 at 12:35:07PM +0800, Huang Pei wrote:
> > MIPS always save kernel stack pointer in regs[29]
> > 
> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > ---
> >  arch/mips/include/asm/ptrace.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> > index 1e76774b36dd..daf3cf244ea9 100644
> > --- a/arch/mips/include/asm/ptrace.h
> > +++ b/arch/mips/include/asm/ptrace.h
> > @@ -53,7 +53,7 @@ struct pt_regs {
> >  
> >  static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
> >  {
> > -	return regs->regs[31];
> > +	return regs->regs[29];
> 
> hmm, I'm still wondering where the trick is... looks like this is used
> for uprobes, so nobody has ever used uprobes or I'm missing something.
> 
> How did you find that ?
> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]


Long story for short, 

+. I think I had fix this bug in 2018, when I backported Uprobe from my
4.4 branch to CentOS 7 3.10. I just knwo it is *not* following MIPS
ABI, but I do not know how it destroy the cool function of
Kprobe/Uprobe, since the failure in porting eBPF from upstream to 3.10
just leave the fix in 3.10, totally forgotten.

+. In 2020, I was told to validate the effect of GNU XHash, and it came
to me that using Uprobe to count the number of "strcmp" called in ld.so,
so I found this fix again.

+. With more work on Kprobe/Kprobe_event/Uprobe, I found it hit only when
accessing arguments of Kprobe/Uprobe, so simple counting numbers of probe
fired would not trigger it

