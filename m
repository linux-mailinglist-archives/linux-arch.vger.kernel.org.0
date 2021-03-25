Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9CA349A61
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 20:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCYTii (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 15:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhCYTiU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED5561A32;
        Thu, 25 Mar 2021 19:38:16 +0000 (UTC)
Date:   Thu, 25 Mar 2021 15:38:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Huang Pei <huangpei@loongson.cn>
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
Message-ID: <20210325153814.098a5d32@gandalf.local.home>
In-Reply-To: <20210313064149.29276-2-huangpei@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
        <20210313064149.29276-2-huangpei@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 13 Mar 2021 14:41:44 +0800
Huang Pei <huangpei@loongson.cn> wrote:


Even simple changes require change logs. For example:

"Enabling ftrace may require more than just the -pg flags today. As ftrace
enables more flags, use the $(CC_FLAGS_FTRACE) in the make file instead of
hard coding "-pg"."

Other than that:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/boot/compressed/Makefile | 2 +-
>  arch/mips/kernel/Makefile          | 8 ++++----
>  arch/mips/vdso/Makefile            | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index d66511825fe1..8fc9ceeec709 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -18,7 +18,7 @@ include $(srctree)/arch/mips/Kbuild.platforms
>  BOOT_HEAP_SIZE := 0x400000
>  
>  # Disable Function Tracer
> -KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
> +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE), $(KBUILD_CFLAGS))
>  
>  KBUILD_CFLAGS := $(filter-out -fstack-protector, $(KBUILD_CFLAGS))
>  
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 2a05b923f579..33e31ea10234 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -17,10 +17,10 @@ obj-y		+= cpu-probe.o
>  endif
>  
>  ifdef CONFIG_FUNCTION_TRACER
> -CFLAGS_REMOVE_ftrace.o = -pg
> -CFLAGS_REMOVE_early_printk.o = -pg
> -CFLAGS_REMOVE_perf_event.o = -pg
> -CFLAGS_REMOVE_perf_event_mipsxx.o = -pg
> +CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_perf_event_mipsxx.o = $(CC_FLAGS_FTRACE)
>  endif
>  
>  obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> index 5810cc12bc1d..f21cf88f7ae3 100644
> --- a/arch/mips/vdso/Makefile
> +++ b/arch/mips/vdso/Makefile
> @@ -49,7 +49,7 @@ CFLAGS_vgettimeofday-o32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -in
>  CFLAGS_vgettimeofday-n32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
>  endif
>  
> -CFLAGS_REMOVE_vgettimeofday.o = -pg
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
>  
>  ifdef CONFIG_MIPS_DISABLE_VDSO
>    ifndef CONFIG_MIPS_LD_CAN_LINK_VDSO
> @@ -63,7 +63,7 @@ ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
>  	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
>  	-G 0 --eh-frame-hdr --hash-style=sysv --build-id=sha1 -T
>  
> -CFLAGS_REMOVE_vdso.o = -pg
> +CFLAGS_REMOVE_vdso.o = $(CC_FLAGS_FTRACE)
>  
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n

