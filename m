Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357A7349AA3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 20:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhCYTpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 15:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhCYTog (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 15:44:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80C7D61A1E;
        Thu, 25 Mar 2021 19:44:34 +0000 (UTC)
Date:   Thu, 25 Mar 2021 15:44:33 -0400
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/6] kprobes/ftrace: Use ftrace_location() when
 [dis]arming probes
Message-ID: <20210325154433.7ed7e56a@gandalf.local.home>
In-Reply-To: <20210313064149.29276-5-huangpei@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
        <20210313064149.29276-5-huangpei@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 13 Mar 2021 14:41:47 +0800
Huang Pei <huangpei@loongson.cn> wrote:

> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 

Looks like this was sent before, but was missing the proper authorship
(which is not Jisheng).

   https://lore.kernel.org/linux-arm-kernel/20191225173219.4f9db436@xhacker.debian/

-- Steve


> Ftrace location could include more than a single instruction in case
> of some architectures (powerpc64, for now). In this case, kprobe is
> permitted on any of those instructions, and uses ftrace infrastructure
> for functioning.
> 
> However, [dis]arm_kprobe_ftrace() uses the kprobe address when setting
> up ftrace filter IP. This won't work if the address points to any
> instruction apart from the one that has a branch to _mcount(). To
> resolve this, have [dis]arm_kprobe_ftrace() use ftrace_function() to
> identify the filter IP.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 41fdbb7953c6..66ee28b071c2 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1045,9 +1045,10 @@ static int prepare_kprobe(struct kprobe *p)
>  static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  			       int *cnt)
>  {
> +	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
>  	int ret = 0;
>  
> -	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
> +	ret = ftrace_set_filter_ip(ops, ftrace_ip, 0, 0);
>  	if (ret) {
>  		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
>  			 p->addr, ret);
> @@ -1070,7 +1071,7 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  	 * At this point, sinec ops is not registered, we should be sefe from
>  	 * registering empty filter.
>  	 */
> -	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
> +	ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
>  	return ret;
>  }
>  
> @@ -1087,6 +1088,7 @@ static int arm_kprobe_ftrace(struct kprobe *p)
>  static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  				  int *cnt)
>  {
> +	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
>  	int ret = 0;
>  
>  	if (*cnt == 1) {
> @@ -1097,7 +1099,7 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  
>  	(*cnt)--;
>  
> -	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
> +	ret = ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
>  	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
>  		  p->addr, ret);
>  	return ret;

