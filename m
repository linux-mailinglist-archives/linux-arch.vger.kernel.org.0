Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93F42C0B0
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhJMM6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhJMM6b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 08:58:31 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C81C061570;
        Wed, 13 Oct 2021 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lhMXJ6WblZHJe5mfBpeJXNE2FMlxg7WKQvEx789XACc=; b=z8dydKsbniwXTXgDkmitK6D/XA
        UuBawAGO4qpG/w28f2YxmVEvSKcSsHlORywXRdtxLhBxhYDZvj+YluC1qo5ZsWEryfrBS3LEyt94s
        zTUSAU9z1B4m+Kd220PWloGGivgPmDPOrw3X7Q2DEkREzdkgqIIujCFdnWzNK5YM3ixDqmatqP7J3
        OAw5uWxOfF8vyQJJflZgnMwYepuAX2LmRVHnywPFfsxxZdq11XY1qeWSFhtMD1PZL2vxbNEEJl0lR
        4zvoswi4rPnGI7BfiNjnSlDpMfidOAzqVPJzCbr37y2FfZDvJKnO3xb3/6cel4k5dOZCkM+hxzaAF
        gm9V7MZg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madnw-00Gi2p-G4; Wed, 13 Oct 2021 12:56:20 +0000
Date:   Wed, 13 Oct 2021 05:56:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH V5 15/22] LoongArch: Add elf and module support
Message-ID: <YWbXdEyonDpXJFK2@bombadil.infradead.org>
References: <20211013063656.3084555-1-chenhuacai@loongson.cn>
 <20211013071117.3097969-1-chenhuacai@loongson.cn>
 <20211013071117.3097969-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013071117.3097969-2-chenhuacai@loongson.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 13, 2021 at 03:11:10PM +0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/include/asm/vermagic.h b/arch/loongarch/include/asm/vermagic.h
> new file mode 100644
> index 000000000000..9882dfd4702a
> --- /dev/null
> +++ b/arch/loongarch/include/asm/vermagic.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_VERMAGIC_H
> +#define _ASM_VERMAGIC_H
> +
> +#define MODULE_PROC_FAMILY "LOONGARCH "

I take it this not a mips arch? There are other longarchs under
arch/mips/include/asm/vermagic.h which is why I ask.

> diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> new file mode 100644
> index 000000000000..af7c403b032b
> --- /dev/null
> +++ b/arch/loongarch/kernel/module.c
> @@ -0,0 +1,652 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: Hanlu Li <lihanlu@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + *
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +
> +#undef DEBUG

Please remove this undef DEBUG line.

> +
> +#include <linux/moduleloader.h>
> +#include <linux/elf.h>
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>
> +
> +static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
> +{
> +	if (*rela_stack_top >= RELA_STACK_DEPTH)
> +		return -ENOEXEC;
> +
> +	rela_stack[(*rela_stack_top)++] = stack_value;
> +	pr_debug("%s stack_value = 0x%llx\n", __func__, stack_value);

If you are going to use pr_debug() so much you may want to add
a define for #define pr_fmt(fmt) at the very top.

> +int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> +		       unsigned int symindex, unsigned int relsec,
> +		       struct module *me)
> +{

Nit: Please use struct module *mod, it is much more common in other places.

Other than that, this looks fine to me.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
