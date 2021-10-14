Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3942D0BF
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 05:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJNDDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 23:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhJNDDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 23:03:24 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8FFC061570;
        Wed, 13 Oct 2021 20:01:20 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id e2so8571960uax.7;
        Wed, 13 Oct 2021 20:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/CZ3h41DYsFMAqGi5C28jlvcQjjjxXwdgVx1UeMUqU=;
        b=dOC+24nlC1p6+PhEkce9QFi/JokIB7H4RtKCST+pjZJ155B3+Nbupy+nGfA4Z2Z8b+
         35NsrVFLusp8hep969Gol4XDCuRjKxiaH+//CfVeTlENH+JOFdEpBb8afIaEOScwKmo2
         yjuk3kQKmmyYJsk5dljIDsrJrUr3EHKOdHODAgGv3Qdaembzc/qqjvBsR3XjGtk26zU+
         piuPEt2Gy0A+/WBvEj2vs2142LkPPrbeSK9pcfmKxOnH0/l9A0tmmelBrGbRrjDuoSJm
         xcdFAK2vFPJjtx9fXRWTn+Liyq0mlsQEseIYMqhpMZH4/L09vGcLvyKU95j5vvSF4IyU
         4/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/CZ3h41DYsFMAqGi5C28jlvcQjjjxXwdgVx1UeMUqU=;
        b=1jvdyNLbNfacAV2I0ztmL8NeDvOtRsSqUckZbh9p/W/smeGFsHBRJj/aVrAtkglqLn
         G5MSWMomYg4ZgwDxf6A+7pSLDFgmsAH6J+tEPRby6KP0hAyK+zTCzoINdyVJ02t/RR7P
         8D10WEW+ItDB2M3Ka4rFRZroczkgHAuYVB+ps2IUKKRR6KnBwU6ZyjaN6MDoa9Nje2n8
         jmNgx6RRbH5fSwOSREb8SufN7lcsITG5jhSUTDcGez/gx2usSetbqd0eij7ApllKrP78
         tfxJ/rVBiLNPVnlwt2M+gYRYh2wWLu0mvhCR2b+V58BD7DPPptmkz/d91QMumMkiiaEt
         s8zg==
X-Gm-Message-State: AOAM531NQVfGfmVd7jTCzh8QyK9GNpf/nKxjTDsI9CEXnpAx0/Gz+jIX
        Ptt9+GkfFxa6L9/I4K0zQ6rVeagYdTX3Z1C/TWY=
X-Google-Smtp-Source: ABdhPJxYY6ovGCJYATjdLZaiIF1rw1Hx7UZB4cKPjBLokqyTS0rHd8ySPxin0PpRI3ThKuqePR3LSJeXRYzjkCYi4So=
X-Received: by 2002:a67:c19d:: with SMTP id h29mr3419511vsj.18.1634180479914;
 Wed, 13 Oct 2021 20:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211013063656.3084555-1-chenhuacai@loongson.cn>
 <20211013071117.3097969-1-chenhuacai@loongson.cn> <20211013071117.3097969-2-chenhuacai@loongson.cn>
 <YWbXdEyonDpXJFK2@bombadil.infradead.org>
In-Reply-To: <YWbXdEyonDpXJFK2@bombadil.infradead.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 14 Oct 2021 11:01:08 +0800
Message-ID: <CAAhV-H5-8yPjZhOkV2+v+XB85+2qs5342hDdTYAV1ctPAdb7+A@mail.gmail.com>
Subject: Re: [PATCH V5 15/22] LoongArch: Add elf and module support
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Luis,

On Wed, Oct 13, 2021 at 8:56 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Oct 13, 2021 at 03:11:10PM +0800, Huacai Chen wrote:
> > diff --git a/arch/loongarch/include/asm/vermagic.h b/arch/loongarch/include/asm/vermagic.h
> > new file mode 100644
> > index 000000000000..9882dfd4702a
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/vermagic.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_VERMAGIC_H
> > +#define _ASM_VERMAGIC_H
> > +
> > +#define MODULE_PROC_FAMILY "LOONGARCH "
>
> I take it this not a mips arch? There are other longarchs under
> arch/mips/include/asm/vermagic.h which is why I ask.
Yes, LoongArch is not compatible with MIPS, old Loongson is MIPS and
new Loongson isn't.

>
> > diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> > new file mode 100644
> > index 000000000000..af7c403b032b
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/module.c
> > @@ -0,0 +1,652 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +
> > +#undef DEBUG
>
> Please remove this undef DEBUG line.
OK, thanks.

>
> > +
> > +#include <linux/moduleloader.h>
> > +#include <linux/elf.h>
> > +#include <linux/mm.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/slab.h>
> > +#include <linux/fs.h>
> > +#include <linux/string.h>
> > +#include <linux/kernel.h>
> > +
> > +static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
> > +{
> > +     if (*rela_stack_top >= RELA_STACK_DEPTH)
> > +             return -ENOEXEC;
> > +
> > +     rela_stack[(*rela_stack_top)++] = stack_value;
> > +     pr_debug("%s stack_value = 0x%llx\n", __func__, stack_value);
>
> If you are going to use pr_debug() so much you may want to add
> a define for #define pr_fmt(fmt) at the very top.
OK, thanks.

>
> > +int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> > +                    unsigned int symindex, unsigned int relsec,
> > +                    struct module *me)
> > +{
>
> Nit: Please use struct module *mod, it is much more common in other places.
>
OK, thanks.

> Other than that, this looks fine to me.
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>
>   Luis
