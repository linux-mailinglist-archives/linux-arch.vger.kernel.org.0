Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEDA349A90
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCYTkp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 15:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhCYTju (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 15:39:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112E4619C9;
        Thu, 25 Mar 2021 19:39:48 +0000 (UTC)
Date:   Thu, 25 Mar 2021 15:39:47 -0400
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
Subject: Re: [PATCH 3/6] MIPS: prepare for new ftrace implementation
Message-ID: <20210325153947.692aa041@gandalf.local.home>
In-Reply-To: <20210313064149.29276-4-huangpei@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
        <20210313064149.29276-4-huangpei@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 13 Mar 2021 14:41:46 +0800
Huang Pei <huangpei@loongson.cn> wrote:

> No function change

Change logs require rationale for the change. Why is this being done? Just
saying "No function change" is not informative at all.

-- Steve


> 
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/kernel/Makefile                      | 4 ++--
>  arch/mips/kernel/{ftrace.c => ftrace-mcount.c} | 0
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/mips/kernel/{ftrace.c => ftrace-mcount.c} (100%)
> 
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 5b2b551058ac..3e7b0ee54cfb 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -17,7 +17,7 @@ obj-y		+= cpu-probe.o
>  endif
>  
>  ifdef CONFIG_FUNCTION_TRACER
> -CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_ftrace-mcount.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_perf_event_mipsxx.o = $(CC_FLAGS_FTRACE)
> @@ -39,7 +39,7 @@ obj-$(CONFIG_DEBUG_FS)		+= segment.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_MODULES)		+= module.o
>  
> -obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
> +obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace-mcount.o
>  
>  sw-y				:= r4k_switch.o
>  sw-$(CONFIG_CPU_R3000)		:= r2300_switch.o
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace-mcount.c
> similarity index 100%
> rename from arch/mips/kernel/ftrace.c
> rename to arch/mips/kernel/ftrace-mcount.c

