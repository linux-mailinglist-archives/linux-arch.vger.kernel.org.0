Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1B349F07
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 02:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCZBsw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 21:48:52 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57574 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230226AbhCZBsp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 21:48:45 -0400
Received: from ambrosehua-HP-xw6600-Workstation (unknown [182.149.160.162])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxQ+BTPV1gi+MAAA--.881S2;
        Fri, 26 Mar 2021 09:48:05 +0800 (CST)
Date:   Fri, 26 Mar 2021 09:48:03 +0800
From:   Huang Pei <huangpei@loongson.cn>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/6] MIPS: replace -pg with CC_FLAGS_FTRACE
Message-ID: <20210326014802.fkdiggo3tak6j5it@ambrosehua-HP-xw6600-Workstation>
References: <20210313064149.29276-1-huangpei@loongson.cn>
 <20210313064149.29276-2-huangpei@loongson.cn>
 <20210325153814.098a5d32@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325153814.098a5d32@gandalf.local.home>
User-Agent: NeoMutt/20171215
X-CM-TRANSID: AQAAf9CxQ+BTPV1gi+MAAA--.881S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW8tr1fArWkJF1UZw4Dtwb_yoW5CFy3pa
        n2kF1DJw4xXry8KryftFy5ZrsrArZYqrW0gFnFgryUtF9xZFnYgr1xtry5XF95WryxA34x
        Wa48WF17Aryava7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUWa0PUUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 25, 2021 at 03:38:14PM -0400, Steven Rostedt wrote:
> On Sat, 13 Mar 2021 14:41:44 +0800
> Huang Pei <huangpei@loongson.cn> wrote:
> 
> 
> Even simple changes require change logs. For example:
> 
> "Enabling ftrace may require more than just the -pg flags today. As ftrace
> enables more flags, use the $(CC_FLAGS_FTRACE) in the make file instead of
> hard coding "-pg"."
> 
> Other than that:
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve
> 
Got it, much better than mine, thank you
> 
> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > ---
> >  arch/mips/boot/compressed/Makefile | 2 +-
> >  arch/mips/kernel/Makefile          | 8 ++++----
> >  arch/mips/vdso/Makefile            | 4 ++--
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> > index d66511825fe1..8fc9ceeec709 100644
> > --- a/arch/mips/boot/compressed/Makefile
> > +++ b/arch/mips/boot/compressed/Makefile
> > @@ -18,7 +18,7 @@ include $(srctree)/arch/mips/Kbuild.platforms
> >  BOOT_HEAP_SIZE := 0x400000
> >  
> >  # Disable Function Tracer
> > -KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
> > +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE), $(KBUILD_CFLAGS))
> >  
> >  KBUILD_CFLAGS := $(filter-out -fstack-protector, $(KBUILD_CFLAGS))
> >  
> > diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> > index 2a05b923f579..33e31ea10234 100644
> > --- a/arch/mips/kernel/Makefile
> > +++ b/arch/mips/kernel/Makefile
> > @@ -17,10 +17,10 @@ obj-y		+= cpu-probe.o
> >  endif
> >  
> >  ifdef CONFIG_FUNCTION_TRACER
> > -CFLAGS_REMOVE_ftrace.o = -pg
> > -CFLAGS_REMOVE_early_printk.o = -pg
> > -CFLAGS_REMOVE_perf_event.o = -pg
> > -CFLAGS_REMOVE_perf_event_mipsxx.o = -pg
> > +CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_perf_event_mipsxx.o = $(CC_FLAGS_FTRACE)
> >  endif
> >  
> >  obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
> > diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> > index 5810cc12bc1d..f21cf88f7ae3 100644
> > --- a/arch/mips/vdso/Makefile
> > +++ b/arch/mips/vdso/Makefile
> > @@ -49,7 +49,7 @@ CFLAGS_vgettimeofday-o32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -in
> >  CFLAGS_vgettimeofday-n32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
> >  endif
> >  
> > -CFLAGS_REMOVE_vgettimeofday.o = -pg
> > +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
> >  
> >  ifdef CONFIG_MIPS_DISABLE_VDSO
> >    ifndef CONFIG_MIPS_LD_CAN_LINK_VDSO
> > @@ -63,7 +63,7 @@ ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> >  	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
> >  	-G 0 --eh-frame-hdr --hash-style=sysv --build-id=sha1 -T
> >  
> > -CFLAGS_REMOVE_vdso.o = -pg
> > +CFLAGS_REMOVE_vdso.o = $(CC_FLAGS_FTRACE)
> >  
> >  GCOV_PROFILE := n
> >  UBSAN_SANITIZE := n

