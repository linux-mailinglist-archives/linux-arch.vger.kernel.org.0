Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159A73EA366
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbhHLLUu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbhHLLUt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:20:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A97C061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:20:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h1so7786547iol.9
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5mWcNxLXYHtHcB95ULLW07ZoNzd7CtV6SWiyYokLhA=;
        b=qM745eOBmfORBEOvhPainikbFx0glu4BjV/wo0f5g60o4sN8IpdftFIscUMiMmCZm9
         2W6Wb/kRmbM2/FpNzmj17OXvIv+eEtrR4uIUlCw+aHMtgF2HP4tVVsWCL/ZjE/k/B/Mv
         B3DVetQdQOvANg1a25WDDSp8yBP8xFJzfrN/aE3h7g2SSoJ3VX4lUvGRjW6HZDNKojlM
         ZcDNGYlxc2aCLKhU0Fpwk8qCFKl1pghUXzJxAqQyO69yls/L1C6RgL8uwTCW6qkisx8H
         jNC494+b501ROBMa0xAjxrXOlOb6qjkyyFrJGeYoJlf8pCZWgCxtfb8kE2kQyEN7hjXg
         nedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5mWcNxLXYHtHcB95ULLW07ZoNzd7CtV6SWiyYokLhA=;
        b=rh15/k8hZzw/nbHzjD/4LChi+ziwR8EGfr2s0JMME2vGLZ2sFWvc0y405AbySaYMjW
         286O/hWm1V3A9DqgAvyLoBIIZv4Ipmn9UDx0maocmNj+XBuF6iIC89cM7zbogVqu7Lxv
         2coc9aiggopAy3wShky6Bw+ZgCabNHW3aMfkvF7pz1C5nmonLjIvQjcMCU+TcUHwpgZ4
         EWnwdEAm4wr0HLyUpNhUpEXU1C+OWf/nXaKu+2MWf8blgAPFP76qAO6ezzWjO8BMdv8/
         YmLhU4jwn52bUyjKEKqNRxHIzLstgCkn22eY8R0iddeiJKOpE2De0ShksTEDy/unnnPD
         kGGQ==
X-Gm-Message-State: AOAM530c7To0jI7lVGY5dLXS+F8ibRF1C3gzqf5X3zzTVJHa0D468vM1
        oSU1Mw9no4H9UGwv3/DcYhICUeaJ5X9vYsfcEB0=
X-Google-Smtp-Source: ABdhPJwrycP88tOAHCiNTu3oCddPu1tyWR3vVpf/qVtbJoytUtcSHvbWHKHCd826cAQfJBuUftX/cBHEyErSfzDeRHk=
X-Received: by 2002:a6b:e010:: with SMTP id z16mr2714850iog.94.1628767223565;
 Thu, 12 Aug 2021 04:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-9-chenhuacai@loongson.cn> <CAK8P3a2Hr7TbuO6LBVC5p5AghWc3j-NCSi8rwd3aq5o8g=Jk1w@mail.gmail.com>
In-Reply-To: <CAK8P3a2Hr7TbuO6LBVC5p5AghWc3j-NCSi8rwd3aq5o8g=Jk1w@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:20:12 +0800
Message-ID: <CAAhV-H4E4Kb=7zOgXguvFNksp-x4fyGWqeKjbKAy7acV10_uug@mail.gmail.com>
Subject: Re: [PATCH 08/19] LoongArch: Add memory management
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > diff --git a/arch/loongarch/include/asm/kmalloc.h b/arch/loongarch/include/asm/kmalloc.h
> > new file mode 100644
> > index 000000000000..b318c41520d8
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/kmalloc.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __ASM_KMALLOC_H
> > +#define __ASM_KMALLOC_H
> > +
> > +#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> > +
> > +#endif /* __ASM_KMALLOC_H */
>
> You wrote elsewhere that DMA is cache-coherent, so this should not
> be needed at all.
OK, thanks.

>
> > diff --git a/arch/loongarch/include/asm/shmparam.h b/arch/loongarch/include/asm/shmparam.h
> > new file mode 100644
> > index 000000000000..f726ac537710
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/shmparam.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_SHMPARAM_H
> > +#define _ASM_SHMPARAM_H
> > +
> > +#define __ARCH_FORCE_SHMLBA    1
> > +
> > +#define        SHMLBA  (4 * PAGE_SIZE)          /* attach addr a multiple of this */
> > +
> > +#endif /* _ASM_SHMPARAM_H */
>
> I think this needs to be defined in a way that is independent of the configured
> page size to minimize the differences between kernel configuration visible to
> user space.
>
> Maybe make it always 64KB?
OK, 64KB is good.

>
> > diff --git a/arch/loongarch/include/asm/sparsemem.h b/arch/loongarch/include/asm/sparsemem.h
> > new file mode 100644
> > index 000000000000..9b57dc69f523
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/sparsemem.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LOONGARCH_SPARSEMEM_H
> > +#define _LOONGARCH_SPARSEMEM_H
> > +
> > +#ifdef CONFIG_SPARSEMEM
> > +
> > +/*
> > + * SECTION_SIZE_BITS           2^N: how big each section will be
> > + * MAX_PHYSMEM_BITS            2^N: how much memory we can have in that space
> > + */
> > +#define SECTION_SIZE_BITS      29
> > +#define MAX_PHYSMEM_BITS       48
>
> Maybe add a comment to explain how you got to '29'?
OK, 2^29 = Largest Huge Page Size.

>
> > +
> > +#ifdef CONFIG_PAGE_SIZE_4KB
> > +#define PAGE_SHIFT      12
> > +#endif
> > +#ifdef CONFIG_PAGE_SIZE_16KB
> > +#define PAGE_SHIFT      14
> > +#endif
> > +#ifdef CONFIG_PAGE_SIZE_64KB
> > +#define PAGE_SHIFT      16
> > +#endif
>
> Shouldn't these be defined in some header?
OK, they will be removed.

Huacai
>
>         Arnd
